$(document).ready(function(){
	pageInit();
	
	$("#srchBranchNm").off("focus").on("focus", function() {	
		openSearchBankPopup();
	});
	
	$("#srchCaseNm").off("focus").on("focus", function(){
		openSearchCasePopup();
	});
	
	$("#exceldownIncPrnBtn").click(function(){
		if(qcellBankAccTrsfHist.getRows("data") == "0"){
			alert("다운로드할 검색결과가 없습니다.");
			return;
		}
		
		var properties={
			filename : "은행계좌거래내역",
//			url : "/excelDownload.face",
			totaldata : true,
			border : true,
			headershow : true,
			colwidth : true,
			huge : false
		};
		
		qcellBankAccTrsfHist.excelDownload(properties);
	}); 
});

var rowIdx;
var qcellBankAccTrsfHist;
var bankAccTrsfHistVOMap = new Object();

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
	if(!$('#sheetBankAccTrsfHist:visible').length) return;
	
	bankAccTrsfHistVOMap.srchCaseNo = $("#srchCaseNo").val();
	bankAccTrsfHistVOMap.srchStartDate = $("#srchStartDate").val();
	bankAccTrsfHistVOMap.srchEndDate = $("#srchEndDate").val();
	bankAccTrsfHistVOMap.srchMembNo = $("#srchMembNo").val();
	bankAccTrsfHistVOMap.srchBranchNo = $("#srchBranchNo").val();
	bankAccTrsfHistVOMap.srchAccNo = $("#srchAccNo").val();
	bankAccTrsfHistVOMap.srchDiv = $("#srchDiv").val();
	
	goAjax("/bank/selectBankAccTrsfHistList.face", bankAccTrsfHistVOMap, callBackSelectListSuccess);
}

//사건관리 화면(리스트)조회 콜백함수
function callBackSelectListSuccess(data){
	if(data.bankAccTrsfHistList){
		var QCELLProp = {
	        "parentid" : "sheetBankAccTrsfHist",
	        "id"		: "qcellBankAccTrsfHist",
	        "rowheight" : {header: 35, data: 30},
	        "data"		: {"input" : data.bankAccTrsfHistList},
	        "selectmode": "row",
	        "columns"	: [
				{width: '100',	key: 'membNm',			title: ['은행명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'membBrNm',			title: ['지점명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'trusterNm',			title: ['계좌주'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'accNo',			title: ['계좌번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'tranDate',			title: ['거래일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'tranHours',			title: ['거래시각'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'tranNo',			title: ['거래번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'acntCode',			title: ['계정과목'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'tranDivNm',			title: ['거래구분'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'tranCntnNm',			title: ['거래내용'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'remark',			title: ['적요'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'currDivNm',			title: ['통화종류'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'inAmt',			title: ['입금금액'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'outAmt',			title: ['출금금액'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'bllncAmt',			title: ['거래후 잔액'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'ordMdDivNm',			title: ['거래매체'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'dealMebNm',			title: ['취급은행명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'dealBrNm',			title: ['취급지점명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'tranDiv',			title: ['(본인)계좌 기록내용'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'relativeMembNm',			title: ['상대금융회사'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'relativeBrNm',			title: ['상대지점'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'relativeAccNo',			title: ['상대계좌'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'relativeAccNm',			title: ['상대계좌주'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
				{width: '100',	key: 'docNo',			title: ['요구문서번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
	//			{width: '100',	key: 'membNo',			title: ['MEMB_NO'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
	//			{width: '100',	key: 'branchNo',			title: ['BRANCH_NO'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
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
		qcellBankAccTrsfHist = QCELL.getInstance("qcellBankAccTrsfHist");
		qcellBankAccTrsfHist.bind("click", eventFn);
	    
		qcellBankAccTrsfHist.setRowStyle(1, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
		
		$("#exceldownIncPrnBtn").show();
	} else {
		$("#sheetBankAccTrsfHist").html(data.msg);
		$("#exceldownIncPrnBtn").hide();
	}
}

//리스트 셀 클릭 이벤트
function eventFn(e){
	//선택한 인덱스 가져오기
	rowIdx = qcellBankAccTrsfHist.getIdx("row");
	
	//기존 체크항목 해제와 새로 선택한 행 체크박스 선택
	qcellBankAccTrsfHist.removeRowStyle(qcellBankAccTrsfHist.getIdx("row","focus","previous") == -1?1:qcellBankAccTrsfHist.getIdx("row","focus","previous"));
	qcellBankAccTrsfHist.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
}

//은행-지점 선택 팝업
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