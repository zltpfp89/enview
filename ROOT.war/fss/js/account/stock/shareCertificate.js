$(document).ready(function(){
	pageInit();
	
	$("#srchBranchNm").off("focus").on("focus", function() {	
		openSearchBankPopup();
	});
	
	$("#srchCaseNm").off("focus").on("focus", function(){
		openSearchCasePopup();
	});
	
	$("#exceldownIncPrnBtn").click(function(){
		if(qcellStockShareCert.getRows("data") == "0"){
			alert("다운로드할 검색결과가 없습니다.");
			return;
		}
		
		var properties={
			filename : "증권주권입출고",
//			url : "/excelDownload.face",
			totaldata : true,
			border : true,
			headershow : true,
			colwidth : true,
			huge : false
		};
		
		qcellStockShareCert.excelDownload(properties);
	}); 
});

var rowIdx;
var qcellStockShareCert;
var stockShareCertVOMap = new Object();

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
	if(!$('#sheetStockShareCert:visible').length) return;
	
	stockShareCertVOMap.srchcaseNo = $("#srchCaseNo").val();
	stockShareCertVOMap.srchStartDate = $("#srchStartDate").val();
	stockShareCertVOMap.srchEndDate = $("#srchEndDate").val();
	stockShareCertVOMap.srchDiv = $("#srchDiv").val();
	stockShareCertVOMap.srchMembNo = $("#srchMembNo").val();
	stockShareCertVOMap.srchBranchNo = $("#srchBranchNo").val();
	stockShareCertVOMap.srchAccNo = $("#srchAccNo").val();
	
	goAjax("/stock/selectStockShareCertList.face", stockShareCertVOMap, callBackSelectListSuccess);
}

//사건관리 화면(리스트)조회 콜백함수
function callBackSelectListSuccess(data){
	if(data.stockShareCertList){
		var QCELLProp = {
	        "parentid" : "sheetStockShareCert",
	        "id"		: "qcellStockShareCert",
	        "rowheight" : {header: 35, data: 30},
	        "data"		: {"input" : data.stockShareCertList},
	        "selectmode": "row",
	        "columns"	: [
				{width: '100',	key: 'membNm',			title: ['증권사'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'branchNm',			title: ['지점'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'accNo',			title: ['계좌번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'trusterNm',			title: ['위탁자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'tranDate',			title: ['일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'tranNo',			title: ['거래번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'itemNm',			title: ['종목'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'inAut',			title: ['입고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'outAut',			title: ['출고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'relativeSeqCoNm',			title: ['증권사'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'relativeBranchNm',			title: ['지점'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'relativeAccNo',			title: ['계좌번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'relativeAccNm',			title: ['위탁자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'issueNum',			title: ['회차'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'stockT',			title: ['권종'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'stkCertNo',			title: ['주권번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'remk',			title: ['비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
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
		qcellStockShareCert = QCELL.getInstance("qcellStockShareCert");
		qcellStockShareCert.bind("click", eventFn);
	    
		qcellStockShareCert.setRowStyle(1, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data"); 
		
		$("#exceldownIncPrnBtn").show();
	} else {
		$("#sheetStockShareCert").html(data.msg);
		$("#exceldownIncPrnBtn").hide();
	}
}

//리스트 셀 클릭 이벤트
function eventFn(e){
	//선택한 인덱스 가져오기
	rowIdx = qcellStockShareCert.getIdx("row");
	
	//기존 체크항목 해제와 새로 선택한 행 체크박스 선택
	qcellStockShareCert.removeRowStyle(qcellStockShareCert.getIdx("row","focus","previous") == -1?1:qcellStockShareCert.getIdx("row","focus","previous"));
	qcellStockShareCert.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
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