$(document).ready(function(){
	pageInit();
	
	$("#srchCaseNm").off("focus").on("focus", function(){
		openSearchCasePopup();
	});
	
	$("#exceldownIncPrnBtn").click(function(){
		if(qcellBankAccDtl.getRows("data") == "0"){
			alert("다운로드할 검색결과가 없습니다.");
			return;
		}
		
		var properties={
			filename : "은행계좌거래내역요약",
//			url : "/excelDownload.face",
			totaldata : true,
			border : true,
			headershow : true,
			colwidth : true,
			huge : false
		};
		
		qcellBankAccDtl.excelDownload(properties);
	}); 
});

var rowIdx;
var qcellBankAccDtl;
var bankAccDtlVOMap = new Object();

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
	if(!$('#sheetBankAccDtl:visible').length) return;
	
	bankAccDtlVOMap.srchCaseNo = $("#srchCaseNo").val();
	bankAccDtlVOMap.srchStartDate = $("#srchStartDate").val();
	bankAccDtlVOMap.srchEndDate = $("#srchEndDate").val();
	bankAccDtlVOMap.srchAccNo = $("#srchAccNo").val();
	
	goAjax("/bank/selectBankDealSummaryList.face", bankAccDtlVOMap, callBackSelectListSuccess);
}

//사건관리 화면(리스트)조회 콜백함수
function callBackSelectListSuccess(data){
	if(data.bankDealSummaryList){
		var QCELLProp = {
	        "parentid" : "sheetBankAccDtl",
	        "id"		: "qcellStockAccDtl",
	        "rowheight" : {header: 35, data: 30},
	        "data"		: {"input" : data.bankDealSummaryList},
	        "selectmode": "row",
	        "columns"	: [
				{width: '100',	key: 'tranDivNm',			title: ['거래구분'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'tranCntnNm',			title: ['거래내용'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'membNm',			title: ['은행명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'membBrNm',			title: ['현관리지점'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'trusterNm',			title: ['게좌주'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'rgno',			title: ['주민번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'tranDate',			title: ['거래일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'tranHours',			title: ['거래시각'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'acntCode',			title: ['계정과목'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'amt',			title: ['금액'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'ordMdDivNm',			title: ['거래매체'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'relativeMembNm',			title: ['상대은행'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'relativeBrNm',			title: ['상대지점'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'relativeAccNo',			title: ['상대계좌'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'relativeAccNm',			title: ['상대계좌주'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
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
		qcellBankAccDtl = QCELL.getInstance("qcellBankAccDtl");
		qcellBankAccDtl.bind("click", eventFn);
	    
		qcellBankAccDtl.setRowStyle(1, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");   
		
		$("#exceldownIncPrnBtn").show();
	} else {
		$("#sheetBankAccDtl").html(data.msg);
		$("#exceldownIncPrnBtn").hide();
	}
}

//리스트 셀 클릭 이벤트
function eventFn(e){
	//선택한 인덱스 가져오기
	rowIdx = qcellBankAccDtl.getIdx("row");
	
	//기존 체크항목 해제와 새로 선택한 행 체크박스 선택
	qcellBankAccDtl.removeRowStyle(qcellBankAccDtl.getIdx("row","focus","previous") == -1?1:qcellBankAccDtl.getIdx("row","focus","previous"));
	qcellBankAccDtl.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
}

//사건 선택 팝업
function openSearchCasePopup(){
	commonLayerPopup.openLayerPopup("/stock/searchCasePopup.face", "380px", "472px", callbackSelectCase);
}

function callbackSelectCase(incident){
	$("#srchCaseNo").val(incident.rcptNum);
	$("#srchCaseNm").val(incident.rcptIncNum);
}