$(document).ready(function(){
	pageInit();
	
	$("#srchCaseNm").off("focus").on("focus", function(){
		openSearchCasePopup();
	});
	
	$("#exceldownIncPrnBtn").click(function(){
		if(qcellDerivAccDtl.getRows("data") == "0"){
			alert("다운로드할 검색결과가 없습니다.");
			return;
		}
		
		var properties={
			filename : "파생거래내역요약",
//			url : "/excelDownload.face",
			totaldata : true,
			border : true,
			headershow : true,
			colwidth : true,
			huge : false
		};
		
		qcellDerivAccDtl.excelDownload(properties);
	}); 
});

var rowIdx;
var qcellDerivAccDtl;
var derivDealSummaryVOMap = new Object();

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
	if(!$('#sheetDerivAccDtl:visible').length) return;
	
	derivDealSummaryVOMap.srchCaseNo = $("#srchCaseNo").val();
	derivDealSummaryVOMap.srchStartDate = $("#srchStartDate").val();
	derivDealSummaryVOMap.srchEndDate = $("#srchEndDate").val();
	derivDealSummaryVOMap.dateDiv = $("input[name=dateDiv]").val();
	derivDealSummaryVOMap.srchMembNo = $("#srchMembNo").val();
	derivDealSummaryVOMap.srchBranchNo = $("#srchBranchNo").val();
	derivDealSummaryVOMap.srchAccNo = $("#srchAccNo").val();
	derivDealSummaryVOMap.srchDiv = $("#srchDiv").val();
	
	goAjax("/deriv/selectDerivDealSummaryList.face", derivDealSummaryVOMap, callBackSelectListSuccess);
}

//사건관리 화면(리스트)조회 콜백함수
function callBackSelectListSuccess(data){
	if(data.derivDealSummaryList){
		var QCELLProp = {
	        "parentid" : "sheetDerivAccDtl",
	        "id"		: "qcellDerivAccDtl",
	        "rowheight" : {header: 35, data: 30},
	        "data"		: {"input" : data.derivDealSummaryList},
	        "selectmode": "row",
	        "columns"	: [
	//        	{width: '100',	key: 'caseNo',			title: ['CASE_NO'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	//        	{width: '100',	key: 'itemCd',			title: ['ITEM_CD'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	//        	{width: '100',	key: 'membNo',			title: ['MEMB_NO'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	//        	{width: '100',	key: 'branchNo',			title: ['BRANCH_NO'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'membNm',			title: ['증권사'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'branchNm',			title: ['지점'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'trusterNm',			title: ['계좌명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'accNo',			title: ['계좌번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'tradeConclDay',			title: ['체결일'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'tranDate',			title: ['결제일'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'tranHours',			title: ['거래시각'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'tranNo',			title: ['거래번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'tranDiv2',			title: ['거래구분'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	//        	{width: '100',	key: 'tranItemCd',			title: ['종목코드'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'tranItemNm',			title: ['종목'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'aut',			title: ['수량'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'uprc',			title: ['단가'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'tranAmt',			title: ['거래금액(원)'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'wertpTodayBalAut',			title: ['유가잔고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'wthldTodayBal',			title: ['에수금'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'tranDivDtlCntn',			title: ['상세적요명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
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
		qcellDerivAccDtl = QCELL.getInstance("qcellDerivAccDtl");
		qcellDerivAccDtl.bind("click", eventFn);
	    
		qcellDerivAccDtl.setRowStyle(1, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data"); 
		
		$("#exceldownIncPrnBtn").show();
	} else {
		$("#sheetDerivAccDtl").html(data.msg);
		$("#exceldownIncPrnBtn").hide();
	}
}

//리스트 셀 클릭 이벤트
function eventFn(e){
	//선택한 인덱스 가져오기
	rowIdx = qcellDerivAccDtl.getIdx("row");
	
	//기존 체크항목 해제와 새로 선택한 행 체크박스 선택
	qcellDerivAccDtl.removeRowStyle(qcellDerivAccDtl.getIdx("row","focus","previous") == -1?1:qcellDerivAccDtl.getIdx("row","focus","previous"));
	qcellDerivAccDtl.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
}

//증권사-지점 선택 팝업
function openSearchBankPopup(){
	commonLayerPopup.openLayerPopup("/stock/searchBankPopup.face", "530px", "472px", callbackSelectBank);	
}

function callbackSelectBank(bank){
	$("#srchMembNo").val(bank.membNo);
	$("#srchBranchNo").val(bank.branchNo);
	$("#srchBranchNm").val(bank.membNm + "(" + bank.branchNm + ")");
}

//사건 선택 팝업
function openSearchCasePopup(){
	commonLayerPopup.openLayerPopup("/stock/searchCasePopup.face", "380px", "472px", callbackSelectCase);
}

function callbackSelectCase(incident){
	$("#srchCaseNo").val(incident.rcptNum);
	$("#srchCaseNm").val(incident.rcptIncNum);
}