$(document).ready(function(){
	pageInit();
	
	$("#srchBranchNm").off("focus").on("focus", function() {	
		openSearchBankPopup();
	});
	
	$("#srchCaseNm").off("focus").on("focus", function(){
		openSearchCasePopup();
	});
	
	$("#exceldownIncPrnBtn").click(function(){
		if(qcellDerivDepWtdw.getRows("data") == "0"){
			alert("다운로드할 검색결과가 없습니다.");
			return;
		}
		
		var properties={
			filename : "파생입출금내역",
//			url : "/excelDownload.face",
			totaldata : true,
			border : true,
			headershow : true,
			colwidth : true,
			huge : false
		};
		
		qcellDerivDepWtdw.excelDownload(properties);
	});
});

var rowIdx;
var qcellDerivDepWtdw;
var derivDepWtdwVOMap = new Object();

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
	if(!$('#sheetDerivDepositWithdraw:visible').length) return;
	
	derivDepWtdwVOMap.srchCaseNo = $("#srchCaseNo").val();
	derivDepWtdwVOMap.srchStartDate = $("#srchStartDate").val();
	derivDepWtdwVOMap.srchEndDate = $("#srchEndDate").val();
	derivDepWtdwVOMap.srchMembNo = $("#srchMembNo").val();
	derivDepWtdwVOMap.srchBranchNo = $("#srchBranchNo").val();
	derivDepWtdwVOMap.srchAccNo = $("#srchAccNo").val();
	derivDepWtdwVOMap.srchDiv = $("#srchDiv").val();
	
	goAjax("/deriv/selectDerivDepWtdwList.face", derivDepWtdwVOMap, callBackSelectListSuccess);
}

//사건관리 화면(리스트)조회 콜백함수
function callBackSelectListSuccess(data){
	if(data.derivDepWtdwList){
		var QCELLProp = {
	        "parentid" : "sheetDerivDepositWithdraw",
	        "id"		: "qcellDerivDepWtdw",
	        "rowheight" : {header: 35, data: 30},
	        "data"		: {"input" : data.derivDepWtdwList},
	        "selectmode": "row",
	        "columns"	: [
				{width: '100',	key: 'membNm',			title: ['증권사'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'branchNm',			title: ['지점'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'accNo',			title: ['계좌번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'accNm',			title: ['위탁자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'tranDate',			title: ['일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'tranNo',			title: ['거래번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'receipt',			title: ['입금'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'disburse',			title: ['출금'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'tranDiv',			title: ['구분'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'publishBankNm',			title: ['발행은행'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'publishBranchNm',			title: ['발행지점'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'publishDate',			title: ['발행일'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'faceBillAmt',			title: ['권면금액'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'pubShtNum',			title: ['매수'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'chckNo',			title: ['수표번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'relativeMembNm',			title: ['금융회사'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'relativeBranchNm',			title: ['지점'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'relativeAccNo',			title: ['계좌번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'relativeAccNm',			title: ['계좌주'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'remk',			title: ['비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
	//			{width: '100',	key: 'caseNo',			title: ['CASE_NO'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	//			{width: '100',	key: 'itemCd',			title: ['ITEM_CD'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	//			{width: '100',	key: 'membNo',			title: ['MEMB_NO'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	//			{width: '100',	key: 'branchNo',			title: ['BRANCH_NO'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	//			{width: '100',	key: 'tranSeqNo',			title: ['TRAN_SEQ_NO'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	//			{width: '100',	key: 'relativeMembNo',			title: ['RELATIVE_MEMB_NO'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	//			{width: '100',	key: 'relativeBranchNo',			title: ['RELATIVE_BRANCH_NO'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
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
		qcellDerivDepWtdw = QCELL.getInstance("qcellDerivDepWtdw");
		qcellDerivDepWtdw.bind("click", eventFn);
	    
		qcellDerivDepWtdw.setRowStyle(1, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data"); 
		
		$("#exceldownIncPrnBtn").show();
	} else {
		$("#sheetDerivDepositWithdraw").html(data.msg);
		$("#exceldownIncPrnBtn").hide();
	}
}

//리스트 셀 클릭 이벤트
function eventFn(e){
	//선택한 인덱스 가져오기
	rowIdx = qcellDerivDepWtdw.getIdx("row");
	
	//기존 체크항목 해제와 새로 선택한 행 체크박스 선택
	qcellDerivDepWtdw.removeRowStyle(qcellDerivDepWtdw.getIdx("row","focus","previous") == -1?1:qcellDerivDepWtdw.getIdx("row","focus","previous"));
	qcellDerivDepWtdw.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
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