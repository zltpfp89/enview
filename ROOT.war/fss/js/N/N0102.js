$(document).ready(function(){
	pageInit();
});

var n0102VOMap = new Object();
var n0101VOMap = new Object();
var isInitStyleQcell = false;
var headerRows ; 	//헤더라인수 
var rowIdx ;	//선택한 인덱스 전역변수관리
var qcell;
var qcellItem;
var qcellDetail;
var qcellDay;
var qcellDayAll;

//화면 진입시 동작함
function pageInit(){
	selectList();
	
	//이벤트바인딩
	eventSetup();
	autoResize();
}

//이벤트 세팅
function eventSetup() {
	
	$(".searchArea input[type=text]").keypress(function(e){
		if(e.keyCode == 13){
			e.stopPropagation();
			doSearch();
		}
	});
	
	//출력 버튼 클릭
	$("#prnBtn").off("click").on("click", function() {		
		prnIntiInc();
	});
	
	
	// 계좌별 통계 탭 클릭
	$("#wrntTrgtAcctNumTab").on("click", function() {	
		selectWrntTrgtAcctNumStatisticsList(n0102SCMap);
	});
	
	//일자별 통계 탭 클릭
	$("#trntDtTab").on("click", function() {
		selectDayStatisticsList();
		
	});	
	
	$("#exceldown").click(function(){
	    var properties = {
	        filename: "금융해당계좌상세자료"
	      , border: true 
	      , headershow: true 
	      , colwidth: true
	      , label: true
	    };
	    qcell.excelDownload(properties);
	  });
	
	$("#exceldownWrntTrgtAcctNum").click(function(){
	    var properties = {
	        filename: "계좌별 통계"
	      , border: true 
	      , headershow: true 
	      , colwidth: true
	      , label: true
	    };
	    qcellItem.excelDownload(properties);
	  });
	
	$("#exceldownWrntTrgtAcctNumAll").click(function(){
	    var properties = {
	        filename: "해당 계좌별 상세통계"
	      , border: true 
	      , headershow: true 
	      , colwidth: true
	      , label: true
	    };
	    qcellDetail.excelDownload(properties);
	  });
	
	
	$("#exceldownTrantDt").click(function(){
	    var properties = {
	        filename: "일자별 통계"
	      , border: true 
	      , headershow: true 
	      , colwidth: true
	      , label: true
	    };
	    qcellDay.excelDownload(properties);
	  });
	
	$("#exceldownTrantDtAll").click(function(){
	    var properties = {
	        filename: "일자별 상세 통계"
	      , border: true 
	      , headershow: true 
	      , colwidth: true
	      , label: true
	    };
	    qcellDayAll.excelDownload(properties);
	  });
	
}

//출력 
function prnIntiInc(){
	selectListReport();
}

//리포트 리스트를 가져온다. 
function selectListReport(){
	goAjax("/sjpb/N/selectDtsList.face", n0102SCMap, callBackSelectListReportSuccess);
}

//리포트 리스트 콜백 성공함수
function callBackSelectListReportSuccess(data){
	

	h0101RTMap.rexdataset = data.qCell;
	
	var xmlString = objectToXml(h0101RTMap);
	
	$("#reptNm").val("H0101.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	
	//레포트 호출
	openReportService(reportForm);  
	
}

//검색조건 초기화
function initSearchData(){
	var searchArea = $("div[class=searchArea]");
	
	//input 값 초기화
	searchArea.find("input[type=text]").val("");
	
	//select 값 초기화
	searchArea.find("select").each(function() {
		$(this).find("option:eq(0)").prop("selected", true);
		$(this).prev('.txt').text($(this).find('option:selected').text());
	});
	
	//검색맵 초기화
	initN0102SCMap();
}


//리스트 검색
function doSearch(){

	n0102SCMap.wrntTrgtAcctNum = getFieldValue($("#wrntTrgtAcctNumSc"));
	n0102SCMap.inptOuptDiv = getFieldValue($("#inptOuptDivSc"));
	n0102SCMap.fincDtaBkNum = getFieldValue($("#fincDtaBkNum"));
	n0102SCMap.opntFincCd = getFieldValue($("#opntFincCdSc"));	
	n0102SCMap.inptOuptNm = getFieldValue($("#inptOuptNmSc"));	
	n0102SCMap.opntAcctNum = getFieldValue($("#opntAcctNumSc"));	
	n0102SCMap.sDate = getFieldValue($("#sDateSc"));
	n0102SCMap.eDate = getFieldValue($("#eDateSc"));	
	n0102SCMap.sTrntAmt = getFieldValue($("#sTrntAmtSc"));
	n0102SCMap.eTrntAmt = getFieldValue($("#eTrntAmtSc"));	
	n0102SCMap.acctAbst = getFieldValue($("#acctAbstSc"));
	n0102SCMap.trntDt = "";
	
	goAjax("/sjpb/N/selectDtsList.face", n0102SCMap, function (data){callBackSelectListSuccess(data, fincDtaDtsNum, n0102SCMap)});
}

//초기화
function initData(type){
	//0: 신규입력 
	//1: 수정 
	
	//Map 초기화
	initN0102VOMap();
	
	//입력필드 초기화 
	var _$targetObj = $("#contentsArea");
	
	//input 값 초기화
	_$targetObj.find("input[type=hidden]").val("");
	_$targetObj.find("input[type=text]").val("");
	_$targetObj.find("input[type=radio]:checked").prop("checked", false);
	setFieldValue($("select[name=fincCd]"), "-1");
	
	//신규입력 or 수정 화면 컨트롤
	if (type == 0){
		$("#viewDiv").hide();
		$("#insertDiv").show();
	}else{
		$("#viewDiv").show();
		$("#insertDiv").hide();		
	}
	
}  //

//디지털포렌식지원업무현황 화면(리스트)조회 (ajax)
function selectList(fincDtaDtsNum){
	n0102SCMap.fincDtaBkNum = getFieldValue($("#fincDtaBkNum"));
	goAjax("/sjpb/N/selectDtsList.face", n0102SCMap, function (data){callBackSelectListSuccess(data, fincDtaDtsNum, n0102SCMap)});
}

function callBackSelectListSuccess(data, fincDtaDtsNum, n0102SCMap){
	var QCELLProp = {
            "parentid" : "sheet",
            "id"		: "qcell",
            "merge"		: {header : "rowandcol"},
            "data"		: {"input" : data.qCell},
            "selectmode": "row",
            "columns"	: [
            	{width: '4%',	key: 'checkbox',			title: [''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '10%',	key: 'wrntTrgtAcctNum',			title: ['영장대상계좌번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '5%',	key: 'inptOuptDivNm',			title: ['구분'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},  
            	{width: '10%',	key: 'trntDt',			title: ['거래일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'},options: {format: {type: "date", origin:"YYYY/MM/DD", rule: "YYYY-MM-DD"}, locale: 'ko', dateformat: 'YY/MM/DD'}},          	
            	{width: '15%',	key: 'trntAmt',			title: ['거래금액'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'},options : {format: {type: "number", rule:"￦ #,###원"}}},
            	{width: '15%',	key: 'opntAcctNum',			title: ['상대 계좌번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '11%',	key: 'opntFincNm',			title: ['상대은행'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}, 
            	{width: '10%',	key: 'inptOuptNm',			title: ['입출금명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}, 
            	{width: '10%',	key: 'acctAbst',			title: ['적요'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}, 
            	{width: '10%',	key: 'fincDtaComn',			title: ['기타'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}, 
            	],
			//"rowheader"	: "sequence",
			"frozencols" : 5
        };
	
		
        QCELL.create(QCELLProp);
        qcell = QCELL.getInstance("qcell");
        headerRows = qcell.getRows("header");
        
       
        
        if (qcell.getRows("data") > 0) {
        	
        	//최초 로딩시
        	if(fincDtaDtsNum == null){	//fincDtaBkNum이 없으면 첫번째줄 선택
        		rowIdx = headerRows;
        		selectWrntTrgtAcctNumStatisticsList(n0102SCMap);
        	}else{
        		if ($("li.m1 > div.tab_mini_contents").is(":visible")) {
        			selectWrntTrgtAcctNumStatisticsList(n0102SCMap);
        		}else if ($("li.m2 > div.tab_mini_contents").is(":visible")) {
        			selectDayStatisticsList (n0102SCMap);
        		}
        	}
        	
        	//qcell 첫번째줄에 초기 커스텀 스타일 추가 (후에, 클릭시 스타일 제거) 
    		var colCnt = qcell.getCols();
    		for (var i = 0; i < colCnt; i++) {
				qcell.setCellStyle(rowIdx, i, {"background-color" : "#c1c8e8 !important", "border-color" : "#a8b0d4 !important"});
				isInitStyleQcell = true;
			}
        	
        //데이터가 없을경우
        } 
        
        if ($("li.m1 > div.tab_mini_contents").is(":visible")) {
        	$("#sheetwrntTrgtAcctNumList").hide();
        	$("#subTitle").hide();
        	$("#exceldownWrntTrgtAcctNumAllBtnArea").hide();
        }else if ($("li.m1 > div.tab_mini_contents").is(":visible")) {
        	$("#dayAllSheet").hide();
        	$("#subTitleDay").hide();
        	$("#exceldownTrantDtAllBtnArea").hide();
        }
        
      
}


function uplodateFincExcelData(){
	ekrFile.setForm();
	
	n0101VOMap.fincDtaBkNum = getFieldValue($("#fincDtaBkNum"));
	n0101VOMap.fileId  = getFieldValue($("input[name=fileId]"));	
	n0101VOMap.fileNm  = getFieldValue($("input[name=fileNm]"));	
	n0101VOMap.fileSize  = getFieldValue($("input[name=fileSize]"));	
	n0101VOMap.fileType  = getFieldValue($("input[name=fileType]"));	
	n0101VOMap.filePath  = getFieldValue($("input[name=filePath]"));	
	n0101VOMap.fileCtype  = getFieldValue($("input[name=fileCtype]"));	
	n0101VOMap.fileCnt  = getFieldValue($("input[name=fileCnt]"));	
	n0101VOMap.delFileIds  = getFieldValue($("input[name=delFileIds]"));	

	goAjax("/sjpb/N/insertFincDtaDtl.face", n0101VOMap, callBackUplodateFincExcelDataSuccess);
	
}


function callBackUplodateFincExcelDataSuccess(){
	selectList();
	ekrFile.fileUploadCallback();
	insertFincExcelUploadViewCloseBtn();
	
	
}

function selectWrntTrgtAcctNumStatisticsList(n0102SCMap){
	n0102SCMap.trntDt = "";
	goAjax("/sjpb/N/selectWrntTrgtAcctNumStatisticsList.face", n0102SCMap, function (data){callbackSelectWrntTrgtAcctNumStatisticsListSuccess(data, fincDtaDtsNum, n0102SCMap)});
}


function callbackSelectWrntTrgtAcctNumStatisticsListSuccess(data, fincDtaDtsNum, n0102SCMap){
	var QCELLProp= {
            "parentid" : "sheetwrntTrgtAcctNum",
            "id"		: "qCellItem",
            "merge"		: {header : "rowandcol"},
            "data"		: {"input" : data.qCellItem},
            "selectmode": "row",
            "columns"	: [
            	{width: '23%',	key: 'opntAcctNum',				title: ['상대 계좌번호','상대 계좌번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '9%',	key: 'opntFincNm',				title: ['상대 거래은행','상대 거래은행'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '9%',	key: 'inptDivCnt',			title: ['입금정보','입금건수'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '25%',	key: 'inptTrntAmtSum',	title: ['입금정보','입금총액'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'},options : {format: {type: "number", rule:"￦ #,###원"}}},
            	{width: '9%',	key: 'ouptDivCnt',			title: ['출금정보','출금건수'], options:{limit:'number'},		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '25%',	key: 'ouptTrntAmtSum',			title: ['출금정보','출금총액'], options:{limit:'number'},		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'},options : {format: {type: "number", rule:"￦ #,###원"}}},
            ],
			"frozencols" : 5
        };
	
		
        QCELL.create(QCELLProp);
        qcellItem = QCELL.getInstance("qCellItem");
        qcellItem.bind("click", eventFn);
        autoResize();
       
	
}
//상황에 맞는 화면노출
function handleUI(){
	
}

//리스트 셀 클릭 이벤트
function eventFn(e){	
	//선택한 인덱스 가져오기
	rowIdx = qcellItem.getIdx("row");
	selectWrntTrgtAcctNumAllList(qcellItem.getRowData(rowIdx).opntAcctNum);
	
}

function selectWrntTrgtAcctNumAllList(opntAcctNum){
	n0102SCMap.fincDtaBkNum = getFieldValue($("#fincDtaBkNum"));
	n0102SCMap.opntAcctNum = opntAcctNum;
	goAjax("/sjpb/N/selectDtsCheckList.face", n0102SCMap, function (data){selectWrntTrgtAcctNumAllListSuccess(data, n0102SCMap)});
}

function selectWrntTrgtAcctNumAllListSuccess(data, n0102SCMap){
	 $("#sheetwrntTrgtAcctNumList").show();
	var QCELLProp = {
            "parentid" : "sheetwrntTrgtAcctNumList",
            "id"		: "qcellDts",
            "merge"		: {header : "rowandcol"},
            "data"		: {"input" : data.qCell},
            "selectmode": "row",
            "columns"	: [
            	{width: '4%',	key: 'checkbox',			title: [''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '10%',	key: 'wrntTrgtAcctNum',			title: ['영장대상계좌번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '5%',	key: 'inptOuptDivNm',			title: ['구분'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},  
            	{width: '10%',	key: 'trntDt',			title: ['거래일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'},options: {format: {type: "date", origin:"YYYY/MM/DD", rule: "YYYY-MM-DD"}, locale: 'ko', dateformat: 'YY/MM/DD'}},          	
            	{width: '15%',	key: 'trntAmt',			title: ['거래금액'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'},options : {format: {type: "number", rule:"￦ #,###원"}}},
            	{width: '15%',	key: 'opntAcctNum',			title: ['상대 계좌번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '11%',	key: 'opntFincNm',			title: ['상대은행'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}, 
            	{width: '10%',	key: 'inptOuptNm',			title: ['입출금명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}, 
            	{width: '10%',	key: 'acctAbst',			title: ['적요'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}, 
            	{width: '10%',	key: 'fincDtaComn',			title: ['기타'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}, 
            	],
			//"rowheader"	: "sequence",
			"frozencols" : 5
        };
	
	
        QCELL.create(QCELLProp);
        qcellDetail = QCELL.getInstance("qcellDts");
        $("#subTitle").show();
        $("#exceldownWrntTrgtAcctNumAllBtnArea").show();
        autoResize();
	
}


function selectDayStatisticsList(fincDtaDtsNum){
	if ($("li.m2 > div.tab_mini_contents").is(":visible")) {
		n0102SCMap.fincDtaBkNum = getFieldValue($("#fincDtaBkNum"));
		n0102SCMap.opntAcctNum = "";
		goAjax("/sjpb/N/selectDayStatisticsList.face", n0102SCMap, function (data){callBackSelectDayStatisticsListSuccess(data, fincDtaDtsNum, n0102SCMap)});
	}
}


function callBackSelectDayStatisticsListSuccess(data, fincDtaDtsNum, n0102SCMap){

	
	var QCELLProp= {
            "parentid" : "trantDtSheet",
            "id"		: "qCellDay",
            "merge"		: {header : "rowandcol"},
            "data"		: {"input" : data.qCellItem},
            "selectmode": "row",
            "columns"	: [
            	{width: '25%',	key: 'trntDt',				title: ['거래일자','거래일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'},options: {format: {type: "date", origin:"YYYY/MM/DD", rule: "YYYY-MM-DD"}, locale: 'ko', dateformat: 'YY/MM/DD'}},
            	{width: '13%',	key: 'inptDivCnt',			title: ['입금정보','입금건수'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '25%',	key: 'inptTrntAmtSum',	title: ['입금정보','입금총액'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'},options : {format: {type: "number", rule:"￦ #,###원"}}},
            	{width: '12%',	key: 'ouptDivCnt',			title: ['출금정보','출금건수'], options:{limit:'number'},		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '25%',	key: 'ouptTrntAmtSum',			title: ['출금정보','출금총액'], options:{limit:'number'},		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'},options : {format: {type: "number", rule:"￦ #,###원"}}},
            ],
			"frozencols" : 4
        };
	

        QCELL.create(QCELLProp);
        qcellDay = QCELL.getInstance("qCellDay");
        qcellDay.bind("click", eventFn2);
        autoResize();

	
}

function eventFn2(e){	
	//선택한 인덱스 가져오기
	rowIdx = qcellDay.getIdx("row");
	selectDayStatisticsAllList(qcellDay.getRowData(rowIdx).trntDt);
	
}


function selectDayStatisticsAllList(trntDt){
	n0102SCMap.fincDtaBkNum = getFieldValue($("#fincDtaBkNum"));
	n0102SCMap.trntDt = trntDt;
	goAjax("/sjpb/N/selectDtsList.face", n0102SCMap, function (data){selectDayStatisticsAllListSuccess(data, n0102SCMap)});
}


function selectDayStatisticsAllListSuccess(data, n0102SCMap){
	 $("#dayAllSheet").show();
	var QCELLProp = {
           "parentid" : "dayAllSheet",
           "id"		: "qcelldayAll",
           "merge"		: {header : "rowandcol"},
           "data"		: {"input" : data.qCell},
           "selectmode": "row",
           "columns"	: [
           	{width: '15%',	key: 'wrntTrgtAcctNum',			title: ['영장대상계좌번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
           	{width: '7%',	key: 'inptOuptDivNm',			title: ['구분'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},  
           	{width: '13%',	key: 'trntDt',			title: ['거래일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'},options: {format: {type: "date", origin:"YYYY/MM/DD", rule: "YYYY-MM-DD"}, locale: 'ko', dateformat: 'YY/MM/DD'}},          	
           	{width: '15%',	key: 'trntAmt',			title: ['거래금액'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'},options : {format: {type: "number", rule:"￦ #,###원"}}},
           	{width: '15%',	key: 'opntAcctNum',			title: ['상대 계좌번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
           	{width: '11%',	key: 'opntFincNm',			title: ['상대은행'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}, 
           	{width: '12%',	key: 'inptOuptNm',			title: ['입출금명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}, 
           	{width: '12%',	key: 'acctAbst',			title: ['적요'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}, 
           	],
			//"rowheader"	: "sequence",
			"frozencols" : 5
       };
	
	
       QCELL.create(QCELLProp);
       qcellDayAll = QCELL.getInstance("qcelldayAll");
       $("#subTitleDay").show();
       $("#exceldownTrantDtAllBtnArea").show();
       autoResize();
}



function insertFincExcelUploadViewBtn(){
	$("#insertDiv").show();
	$("#insertFincExcelUploadViewBtn").hide();
	$("#insertFincExcelUploadViewCloseBtn").show();
}

function insertFincExcelUploadViewCloseBtn(){
	$("#insertDiv").hide();
	$("#insertFincExcelUploadViewBtn").show();
	$("#insertFincExcelUploadViewCloseBtn").hide();
}



//삭제 
function deleteFincDtaDts(){
	
	
	//선택된 ROW가져오기 
	var n0102VOArray = new Array();
	
	for(var i = 0; i < qcell.getColData(0).length; i++){
		if(qcell.getColData(0)[i] == true){
			
			var n0102VOTmp = new Object();
			n0102VOTmp = qcell.getRowData(i+headerRows);
			
			n0102VOArray.push(n0102VOTmp);
		}
	}
	
	//체크여부확인 
	if(n0102VOArray.length == 0){
		alert("하나이상 체크해주세요.");
		return;
	}
	
	//병합한다.
	if(confirm("삭제하시겠습니까?") == true){
		var reqMap = {
				n0102VOList : n0102VOArray
		}
		goAjax("/sjpb/N/deleteFincDtaDts.face", reqMap, callBackDeleteFincDtaDtsSuccess);
	}else{
		return;
	}
}

//삭제 성공 콜백 함수 
function callBackDeleteFincDtaDtsSuccess(data){
	//성공
	if(data.n0102VO.result == "01"){
		alert("삭제되었습니다.");
		selectList();
		
		  
        if ($("li.m1 > div.tab_mini_contents").is(":visible")) {
        	selectWrntTrgtAcctNumStatisticsList(n0102SCMap);
        }else if ($("li.m2 > div.tab_mini_contents").is(":visible")) {
        	selectDayStatisticsList();
        }
	}else{
		var errMsg = "";
		if(data.n0102VO.errMsg != null){
			errMsg = data.n0102VO.errMsg;
		}else{
			errMsg = "삭제 실패 관리자에 문의해주세요.";
		}
		alert(errMsg);
	}
}

//신규 입력 화면 노출 
function insertFincDtaDtsViewBtn(){
	
	//초기화 
	initData("0");
	
	handleUI();
}

//신규 저장
function insertFincDtaDts(){
	//Map 데이터 갱신
	ekrFile.setForm();
	if(syncN0101VOMap(true)){
		goAjax("/sjpb/N/insertFincDta.face", n0101VOMap, callBackInsertFincDtaDtsSuccess);
	}
}

//신규저장 성공 콜백함수
function callBackInsertFincDtaDtsSuccess(data){
	alert("신규로 등록되었습니다.");
	
	selectList(data.n0102VO.fincDtaDtsNum);
	
}

//Map 데이터 갱신
function syncN0102VOMap(isValid) {
	
	//유효성체크 여부에 따라 체크함 
	if(isValid){
		//유효성 체크
		var chkObjs = $("#contentsArea");
		if(!chkValidate.check(chkObjs, true)) return;
	}	
	return true;
	
}


function syncN0101VOMap(isValid) {
	
	//유효성체크 여부에 따라 체크함 
	if(isValid){
		//유효성 체크
		var chkObjs = $("#contentsArea");
		if(!chkValidate.check(chkObjs, true)) return;
	}	
	return true;
	
}


//초기화
function initN0102VOMap(){
	n0102VOMap = {
			fincDtaBkNum : ""		//포렌식지원일련번호
			,fincDtaSbjt : ""	//포렌식지원발행년도
			,wrntTrgtAcctNum : ""			//연번
			,fincCd : ""			//매체연번
			,trntDt :  ""
		}                           
}


//포렌식
var n0102VOMap = {
		fincDtaSbjt : ""	//금융코드
		,wrntTrgtAcctNum : ""	//제목
		,fincDtaBkNum : ""	// 영장대상 계좌번호
		,opntFincCd :  ""
		,fincDtaBkNum :  ""
		,opntAcctNum :  ""
		,sDate :  ""
		,eDate :  ""
		,sTrntAmt :  ""
		,eTrntAmt :  ""
		,acctAbst :  ""
		,trntDt :  ""
}


var n0101VOMap = {
		fincDtaSbjt : ""	//금융코드
		,wrntTrgtAcctNum : ""	//제목
		,fincDtaBkNum : ""	// 영장대상 계좌번호
		,opntFincCd :  ""
		,fincDtaBkNum :  ""
		,opntAcctNum :  ""
		,sDate :  ""
		,eDate :  ""
		,sTrntAmt :  ""
		,eTrntAmt :  ""
		,acctAbst :  ""
		,trntDt :  ""
}

//초기화
function initN0102SCMap(){
	n0102SCMap = {
		fincDtaSbjt : ""	//금융코드
		,wrntTrgtAcctNum : ""	//제목
		,opntFincCd :  ""
		,fincDtaBkNum :  ""
		,opntAcctNum :  ""
		,sDate :  ""
		,eDate :  ""
		,sTrntAmt :  ""
		,eTrntAmt :  ""
		,acctAbst :  ""	
		,trntDt :  ""
	}
}

//검색조건




var n0102SCMap = {
	fincDtaSbjt : ""	//금융코드
	,wrntTrgtAcctNum : ""	//제목
	,fincDtaBkNum : ""	// 영장대상 계좌번호
	,opntFincCd :  ""
	,fincDtaBkNum :  ""
	,opntAcctNum :  ""
	,sDate :  ""
	,eDate :  ""
	,sTrntAmt :  ""
	,eTrntAmt :  ""
	,acctAbst :  ""
	,trntDt :  ""
}

//리포트맵
var n0102RTMap = {
	rexdataset : null
}
