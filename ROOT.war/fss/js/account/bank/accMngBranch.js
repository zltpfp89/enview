$(document).ready(function(){
	pageInit();
	
	$("#srchCaseNm").off("focus").on("focus", function(){
		openSearchCasePopup();
	});
	
	$("#exceldownIncPrnBtn").click(function(){
		if(qcellBankAccMngBranch.getRows("data") == "0"){
			alert("다운로드할 검색결과가 없습니다.");
			return;
		}
		
		var properties={
			filename : "은행계좌관리점",
//			url : "/excelDownload.face",
			totaldata : true,
			border : true,
			headershow : true,
			colwidth : true,
			huge : false
		};
		
		qcellBankAccMngBranch.excelDownload(properties);
	}); 
});

var rowIdx;
var qcellBankAccMngBranch;
var bankAccMngBranchVOMap = new Object();

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
	if(!$('#sheetBankAccMngBranch:visible').length) return;
	
	bankAccMngBranchVOMap.srchCaseNo = $("#srchCaseNo").val();
	
	goAjax("/bank/selectBankAccMngBranchList.face", bankAccMngBranchVOMap, callBackSelectListSuccess);
}

//사건관리 화면(리스트)조회 콜백함수
function callBackSelectListSuccess(data){
	if(data.bankAccMngBranchList){
		var QCELLProp = {
	        "parentid" : "sheetBankAccMngBranch",
	        "id"		: "qcellBankAccMngBranch",
	        "rowheight" : {header: 35, data: 30},
	        "data"		: {"input" : data.bankAccMngBranchList},
	        "selectmode": "row",
	        "columns"	: [
	        	{width: '100',	key: 'lastDealDate',		title: ['입수일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'baseDate',			title: ['기준일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'membNm',			title: ['은행명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'brNm',			title: ['지점명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'accNo',			title: ['계좌번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'docNo',			title: ['요구문서번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
	//			{width: '100',	key: 'branchNo',			title: ['BRANCH_NO'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
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
		qcellBankAccMngBranch = QCELL.getInstance("qcellBankAccMngBranch");
		qcellBankAccMngBranch.bind("click", eventFn);
	    
		qcellBankAccMngBranch.setRowStyle(1, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
		
		$("#exceldownIncPrnBtn").show();
	} else {
		$("#sheetBankAccMngBranch").html(data.msg);
		$("#exceldownIncPrnBtn").hide();
	}
}

//리스트 셀 클릭 이벤트
function eventFn(e){
	//선택한 인덱스 가져오기
	rowIdx = qcellBankAccMngBranch.getIdx("row");
	
	//기존 체크항목 해제와 새로 선택한 행 체크박스 선택
	qcellBankAccMngBranch.removeRowStyle(qcellBankAccMngBranch.getIdx("row","focus","previous") == -1?1:qcellBankAccMngBranch.getIdx("row","focus","previous"));
	qcellBankAccMngBranch.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
}

//사건 선택 팝업
function openSearchCasePopup(){
	commonLayerPopup.openLayerPopup("/stock/searchCasePopup.face", "380px", "472px", callbackSelectCase);
}

function callbackSelectCase(incident){
	$("#srchCaseNo").val(incident.rcptNum);
	$("#srchCaseNm").val(incident.rcptIncNum);
}