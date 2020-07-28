$(document).ready(function(){
	pageInit();
	
	$("#srchBranchNm").off("focus").on("focus", function() {	
		openSearchBankPopup();
	});
	
	$("#srchCaseNm").off("focus").on("focus", function(){
		openSearchCasePopup();
	});
	
	$("#exceldownIncPrnBtn").click(function(){
		if(qcellStockOrdMdiInfo.getRows("data") == "0"){
			alert("다운로드할 검색결과가 없습니다.");
			return;
		}
		
		var properties={
			filename : "증권주문매체정보",
//			url : "/excelDownload.face",
			totaldata : true,
			border : true,
			headershow : true,
			colwidth : true,
			huge : false
		};
		
		qcellStockOrdMdiInfo.excelDownload(properties);
	});
});

var rowIdx;
var qcellStockOrdMdiInfo;
var stockOrdMdiInfoVOMap = new Object();

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
	if(!$('#sheetStockOrdMdiInfo:visible').length) return;
	
	stockOrdMdiInfoVOMap.srchCaseNo = $("#srchCaseNo").val();      
	stockOrdMdiInfoVOMap.srchStartDate = $("#srchStartDate").val();
	stockOrdMdiInfoVOMap.srchEndDate = $("#srchEndDate").val();    
	stockOrdMdiInfoVOMap.srchMembNo = $("#srchMembNo").val();      
	stockOrdMdiInfoVOMap.srchBranchNo = $("#srchBranchNo").val();  
	stockOrdMdiInfoVOMap.srchAccNo = $("#srchAccNo").val();        
	
	goAjax("/stock/selectStockOrdMdiInfoList.face", stockOrdMdiInfoVOMap, callBackSelectListSuccess);
}

//사건관리 화면(리스트)조회 콜백함수
function callBackSelectListSuccess(data){
	if(data.stockOrdMdiList){
		var QCELLProp = {
	        "parentid" : "sheetStockOrdMdiInfo",
	        "id"		: "qcellStockOrdMdiInfo",
	        "rowheight" : {header: 35, data: 30},
	        "data"		: {"input" : data.stockOrdMdiList},
	        "selectmode": "row",
	        "columns"	: [
	//			{width: '100',	key: 'membNo',			title: ['MEMB_NO'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'membNm',			title: ['증권사'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	//			{width: '100',	key: 'branchNo',			title: ['BRANCH_NO'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'branchNm',			title: ['지점'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'accNo',			title: ['계좌번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'trusterNm',			title: ['위탁자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'ordDate',			title: ['주문일'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'ordNo',			title: ['주문번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	//			{width: '100',	key: 'ordItemCd',			title: ['종목'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'ordItemNm',			title: ['종목'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'buySellDiv',			title: ['구분'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'crrctCnclDiv',			title: ['호가구분'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'origOrdNo',			title: ['원주문번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'aut',			title: ['수량'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'prc',			title: ['가격'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'ordHours',			title: ['주문시각'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'ordMd',			title: ['주문매체'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'ipNo',			title: ['IP번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'mac',			title: ['MAC'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'reservOrdDate',			title: ['예약주문접수일'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
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
		qcellStockOrdMdiInfo = QCELL.getInstance("qcellStockOrdMdiInfo");
		qcellStockOrdMdiInfo.bind("click", eventFn);
	    
		qcellStockOrdMdiInfo.setRowStyle(1, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data"); 
		
		$("#exceldownIncPrnBtn").show();
	} else {
		$("#sheetStockOrdMdiInfo").html(data.msg);
		$("#exceldownIncPrnBtn").hide();
	}
}

//리스트 셀 클릭 이벤트
function eventFn(e){
	//선택한 인덱스 가져오기
	rowIdx = qcellStockOrdMdiInfo.getIdx("row");
	
	//기존 체크항목 해제와 새로 선택한 행 체크박스 선택
	qcellStockOrdMdiInfo.removeRowStyle(qcellStockOrdMdiInfo.getIdx("row","focus","previous") == -1?1:qcellStockOrdMdiInfo.getIdx("row","focus","previous"));
	qcellStockOrdMdiInfo.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
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