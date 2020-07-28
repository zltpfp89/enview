$(document).ready(function(){
	pageInit();
	
	$("#srchCaseNm").off("focus").on("focus", function(){
		openSearchCasePopup();
	});
	
	$("#exceldownIncPrnBtn").click(function(){
		if(qcellBankChit.getRows("data") == "0"){
			alert("다운로드할 검색결과가 없습니다.");
			return;
		}
		
		var properties={
			filename : "은행전표",
//			url : "/excelDownload.face",
			totaldata : true,
			border : true,
			headershow : true,
			colwidth : true,
			huge : false
		};
		
		qcellBankChit.excelDownload(properties);
	}); 
});

var rowIdx;
var qcellBankChit;
var bankChitVOMap = new Object();

//화면 진입시 동작함
function pageInit(){
	selectList();
	
	$(".searchArea input[type=text],.searchArea select").keypress(function(e){
		if(e.keyCode == 13){
			e.stopPropagation();
			selectList();
		}
	});
}

function search(){
	selectList();
}

//원장분석 증권계좌기본정보 리스트 조회 (ajax)
function selectList(){
	//최소화 되어 있으면 검색중단
	if(!$('#sheetBankChit:visible').length) return;
	
	bankChitVOMap.srchCaseNo = $("#srchCaseNo").val();
	bankChitVOMap.srchDocNo = $("#srchDocNo").val();
	
	goAjax("/bank/selectBankChitList.face", bankChitVOMap, callBackSelectListSuccess);
}

//사건관리 화면(리스트)조회 콜백함수
function callBackSelectListSuccess(data){
	if(data.bankChitList){
		var QCELLProp = {
	        "parentid" : "sheetBankChit",
	        "id"		: "qcellBankChit",
	        "rowheight" : {header: 35, data: 30},
	        "data"		: {"input" : data.bankChitList},
	        "selectmode": "row",
	        "columns"	: [
	        	{width: '100',	key: 'lastDealDate',			title: ['입수일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'membNm',			title: ['은행명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'branchNm',			title: ['지점명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'personDataRelaAcc',			title: ['인적사항'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'reqCntn',			title: ['요구내용'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'docNo',			title: ['요구문서번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'attachFileNm',			title: ['첨부파일'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
	//			{width: '100',	key: 'saveFileNm',			title: ['SAVE_FILE_NM'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			],
			"pagination" : {
				unitlist :[500, 1000],
				pageunit : 500,
				pagecount : 10,
				mode : 'extend',
				extendmove :true
			}
		};
		
		QCELL.create(QCELLProp);
		qcellBankChit = QCELL.getInstance("qcellBankChit");
		qcellBankChit.bind("click", eventFn);
	    
		qcellBankChit.setRowStyle(1, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");  
		
		$("#exceldownIncPrnBtn").show();
	} else {
		$("#sheetBankChit").html(data.msg);
		$("#exceldownIncPrnBtn").hide();
	}
}

//리스트 셀 클릭 이벤트
function eventFn(e){
	//선택한 인덱스 가져오기
	rowIdx = qcellBankChit.getIdx("row");
	
	//기존 체크항목 해제와 새로 선택한 행 체크박스 선택
	qcellBankChit.removeRowStyle(qcellBankChit.getIdx("row","focus","previous") == -1?1:qcellBankChit.getIdx("row","focus","previous"));
	qcellBankChit.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
}

//사건 선택 팝업
function openSearchCasePopup(){
	commonLayerPopup.openLayerPopup("/stock/searchCasePopup.face", "380px", "472px", callbackSelectCase);
}

function callbackSelectCase(incident){
	$("#srchCaseNo").val(incident.rcptNum);
	$("#srchCaseNm").val(incident.rcptIncNum);
}