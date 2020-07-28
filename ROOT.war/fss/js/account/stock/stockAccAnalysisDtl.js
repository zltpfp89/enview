$(document).ready(function(){
	pageInit();
	
	$("#srchCaseNm").off("focus").on("focus", function(){
		openSearchCasePopup();
	});
	
	$("#exceldownIncPrnBtn").click(function(){
		if(qcellStockDealSummary.getRows("data") == "0"){
			alert("다운로드할 검색결과가 없습니다.");
			return;
		}
		
		var properties={
			filename : "증권주식거래내역요약",
//			url : "/excelDownload.face",
			totaldata : true,
			border : true,
			headershow : true,
			colwidth : true,
			huge : false
		};
		
		qcellStockDealSummary.excelDownload(properties);
	});
});

function search(){
	selectList();
}

var rowIdx;
var qcellStockDealSummary;
var stockDealSummaryVOMap = new Object();

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

//원장분석 증권계좌상세정보 리스트 조회 (ajax)
function selectList(){
	//최소화 되어 있으면 검색중단
	if(!$('#sheetStockDealSummary:visible').length) return;
	
	stockDealSummaryVOMap.srchCaseNo = $("#srchCaseNo").val();       
	stockDealSummaryVOMap.srchStartDate = $("#srchStartDate").val(); 
	stockDealSummaryVOMap.srchEndDate = $("#srchEndDate").val();     
	stockDealSummaryVOMap.dateDiv = $("input[name=dateDiv]").val();  
	stockDealSummaryVOMap.srchDiv = $("#srchDiv").val();  
	stockDealSummaryVOMap.srchMembNo = $("#srchMembNo").val();  
	stockDealSummaryVOMap.srchBranchNo = $("#srchBranchNo").val();  
	stockDealSummaryVOMap.srchAccNo = $("#srchAccNo").val();  
	
	goAjax("/stock/selectStockAccDtlList.face", stockDealSummaryVOMap, callBackSelectListSuccess);
}

//사건관리 화면(리스트)조회 콜백함수
function callBackSelectListSuccess(data){
	if(data.stockDealSummaryList){
		var QCELLProp = {
	        "parentid" : "sheetStockDealSummary",
	        "id"		: "qcellStockDealSummary",
	        "rowheight" : {header: 35, data: 30},
	        "data"		: {"input" : data.stockDealSummaryList},
	        "selectmode": "row",
	        "columns"	: [
	        	{width: '100',	key: 'tranBaseDate',	title: ['기준일'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'membNm',			title: ['증권사'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'brNm',			title: ['지점'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'accNo',			title: ['계좌번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'trusterNm',		title: ['위탁자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'rgno',			title: ['주민등록번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'postNo',			title: ['우편번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'homeAddr',			title: ['주소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'homeTelNo',			title: ['전화번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'accOpnDate',			title: ['계좌개설일'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'accMngrNm',			title: ['계좌관리자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	        	{width: '100',	key: 'tradeItemNm',			title: ['매매종목명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
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
		qcellStockDealSummary = QCELL.getInstance("qcellStockDealSummary");
		qcellStockDealSummary.bind("click", eventFn);
	    
		qcellStockDealSummary.setRowStyle(1, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");  
		
		$("#exceldownIncPrnBtn").show();
	} else {
		$("#sheetStockDealSummary").html(data.msg);
		$("#exceldownIncPrnBtn").hide();
	}
}

//리스트 셀 클릭 이벤트
function eventFn(e){
	//선택한 인덱스 가져오기
	rowIdx = qcellStockDealSummary.getIdx("row");
	
	//기존 체크항목 해제와 새로 선택한 행 체크박스 선택
	qcellStockDealSummary.removeRowStyle(qcellStockDealSummary.getIdx("row","focus","previous") == -1?1:qcellStockDealSummary.getIdx("row","focus","previous"));
	qcellStockDealSummary.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
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