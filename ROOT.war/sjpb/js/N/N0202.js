$(document).ready(function(){
	pageInit();
});

var n0202VOMap = new Object();
var n0201VOMap = new Object();
var isInitStyleQcell = false;
var headerRows ; 	//헤더라인수 
var rowIdx ;	//선택한 인덱스 전역변수관리
var qcell;
var qcellItem;
var qcellDetail;
var sendNumListItem;
var recvNumListItem;
var sendBaseSttnAddrGroupItem;
var qcellAll;


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
	

	// 발신 통계 탭 클릭
	$("#selectSendRecvTab").on("click", function() {	
		selectList();
	});
	
	
	// 발신 통계 탭 클릭
	$("#selectSendTab").on("click", function() {	
		selectSendDivStatisticsList(n0202SCMap);
	});
	
	//역발신 통계
	$("#selectRecvTab").on("click", function() {
		selectRecvDivStatisticsList();
		
	});	
	
	$("#exceldown").click(function(){
	    var properties = {
	        filename: "통신해당계좌상세자료"
  	      , url: '/excelDownload.face?folderType=finc'  	
	      , border: true 
	      , headershow: true 
	      , colwidth: true
	      , label: true
	      , huge : false
	    };
	    qcell.excelDownload(properties);
	  });
	
	$("#exceldownSendRecv").click(function(){
	    var properties = {
	        filename: "발신/역발신 통계"
  	      , url: '/excelDownload.face?folderType=finc'  	
	      , border: true 
	      , headershow: true 
	      , colwidth: true
	      , label: true
	      , huge : false
	    };
	    qcellItem.excelDownload(properties);
	  });
	
	$("#exceldownSendRecvAll").click(function(){
	    var properties = {
	        filename: "발신/역발신 상세통계"
  	      , url: '/excelDownload.face?folderType=finc'  	
	      , border: true 
	      , headershow: true 
	      , colwidth: true
	      , label: true
	      , huge : false
	    };
	    qcellDetail.excelDownload(properties);
	  });
	
	
	
	$("#exceldownSend").click(function(){
	    var properties = {
	        filename: "발신 통계"
  	      , url: '/excelDownload.face?folderType=finc'  	
	      , border: true 
	      , headershow: true 
	      , colwidth: true
	      , label: true
	      , huge : false
	    };
	    sendNumListItem.excelDownload(properties);
	  });
	
	$("#exceldownRecv").click(function(){
	    var properties = {
	        filename: "역발신 통계"
	  	  , url: '/excelDownload.face?folderType=finc'  	
	      , border: true 
	      , headershow: true 
	      , colwidth: true
	      , label: true
	      , huge : false
	    };
	    recvNumListItem.excelDownload(properties);
	  });
	
	$("#exceldownSendBaseSttnAddr").click(function(){
	    var properties = {
	        filename: "발신 기지국 주소 통계"
  	      , url: '/excelDownload.face?folderType=finc'  	
	      , border: true 
	      , headershow: true 
	      , colwidth: true
	      , label: true
	      , huge : false
	    };
	    sendBaseSttnAddrGroupItem.excelDownload(properties);
	  });
	
	$("#exceldownRecvBaseSttnAddr").click(function(){
	    var properties = {
	        filename: "역발신 기지국 주소 통계"
  	      , url: '/excelDownload.face?folderType=finc'  	
	      , border: true 
	      , headershow: true 
	      , colwidth: true
	      , label: true
	      , huge : false
	    };
	    sendBaseSttnAddrGroupItem.excelDownload(properties);
	  });	
	

	$("#exceldownSendDetailAll").click(function(){
	    var properties = {
	        filename: "발신내역 상세"
  	      , url: '/excelDownload.face?folderType=finc'  	
	      , border: true 
	      , headershow: true 
	      , colwidth: true
	      , label: true
	      , huge : false
	    };
	    qcellAll.excelDownload(properties);
	 });
	$("#exceldownRecvDetailAll").click(function(){
	    var properties = {
	        filename: "역발신 내역 상세"
  	      , url: '/excelDownload.face?folderType=finc'  	
	      , border: true 
	      , headershow: true 
	      , colwidth: true
	      , label: true
	      , huge : false
	    };
	    qcellAll.excelDownload(properties);
	 });	
	
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
	initN0202SCMap();
}


//리스트 검색
function doSearch(){

	n0202SCMap.cmctCmpyNm = getFieldValue($("#cmctCmpyNmSc"));
	n0202SCMap.useTp = getFieldValue($("#useTpSc"));
	n0202SCMap.sendRecvDiv = getFieldValue($("#sendRecvDivSc"));
	n0202SCMap.cmctDtaBkNum = getFieldValue($("#cmctDtaBkNum"));
	n0202SCMap.sendNum = getFieldValue($("#sendNumSc"));	
	n0202SCMap.recvNum = getFieldValue($("#recvNumSc"));		
	n0202SCMap.sDate = getFieldValue($("#sDateSc"));
	n0202SCMap.eDate = getFieldValue($("#eDateSc"));	
	
	goAjax("/sjpb/N/selectCmctDtsList.face", n0202SCMap, function (data){callBackSelectListSuccess(data, cmctDtaDtsNum, n0202SCMap)});
}

//초기화
function initData(type){
	//0: 신규입력 
	//1: 수정 
	
	//Map 초기화
	initN0202VOMap();
	
	//입력필드 초기화 
	var _$targetObj = $("#contentsArea");
	

	_$targetObj.find("input[type=hidden]").val("");
	_$targetObj.find("input[type=text]").val("");
	_$targetObj.find("input[type=radio]:checked").prop("checked", false);
	setFieldValue($("select[name=cmctCmpyCd]"), "-1");
	
	
}  

function selectList(cmctDtaDtsNum){
	n0202SCMap.cmctDtaBkNum = getFieldValue($("#cmctDtaBkNum"));
	goAjax("/sjpb/N/selectCmctDtsList.face", n0202SCMap, function (data){callBackSelectListSuccess(data, cmctDtaDtsNum, n0202SCMap)});
}

function callBackSelectListSuccess(data, cmctDtaDtsNum, n0202SCMap){
	var QCELLProp = {
            "parentid" : "sheet",
            "id"		: "qcell",
            "merge"		: {header : "rowandcol"},
            "data"		: {"input" : data.qCell},
            "selectmode": "row",
            "columns"	: [
            	{width: '4%',	key: 'checkbox',			title: [''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '6%',	key: 'cmctCmpyNm',			title: ['통신사'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '5%',	key: 'useTpNm',			title: ['사용유형'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},  
            	{width: '5%',	key: 'sendRecvDivNm',			title: ['발착구분'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},          	
            	{width: '10%',	key: 'sendNum',			title: ['발신번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'recvNum',			title: ['착신번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'callBeTimeConv',			title: ['통화시작시간'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}, 
            	{width: '10%',	key: 'callDurtTimeConv',			title: ['통화시간'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}, 
            	{width: '40%',	key: 'sendBaseSttnAddr',			title: ['발신기지국주소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}, 
            	],
			//"rowheader"	: "sequence",
			"frozencols" : 5
        };
	
		
        QCELL.create(QCELLProp);
        qcell = QCELL.getInstance("qcell");
        headerRows = qcell.getRows("header");
        
       
        
        if (qcell.getRows("data") > 0) {
        	
        	//최초 로딩시
        	if(cmctDtaDtsNum == null){	//fincDtaBkNum이 없으면 첫번째줄 선택
        		rowIdx = headerRows;
        		selectSendRecvDivStatisticsList(n0202SCMap);
        	}else{
        		if ($("li.m1 > div.tab_mini_contents").is(":visible")) {
        			selectSendRecvDivStatisticsList(n0202SCMap);
        		}else if ($("li.m2 > div.tab_mini_contents").is(":visible")) {
        			selectSendDivStatisticsList (n0202SCMap);
	        	}else if ($("li.m3 > div.tab_mini_contents").is(":visible")) {
	        		selectRecvDivStatisticsList (n0202SCMap);
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
        
        }else if ($("li.m2 > div.tab_mini_contents").is(":visible")) {
        
        }else if ($("li.m2 > div.tab_mini_contents").is(":visible")) {
        	
        }
        
      
}


function uploadCmctExcelData(){
	ekrFile.setForm();
	
	n0201VOMap.cmctDtaBkNum = getFieldValue($("#cmctDtaBkNum"));
	n0201VOMap.cmctCmpyCd = getFieldValue($("#cmctCmpyCd"));
	n0201VOMap.fileId  = getFieldValue($("input[name=fileId]"));	
	n0201VOMap.fileNm  = getFieldValue($("input[name=fileNm]"));	
	n0201VOMap.fileSize  = getFieldValue($("input[name=fileSize]"));	
	n0201VOMap.fileType  = getFieldValue($("input[name=fileType]"));	
	n0201VOMap.filePath  = getFieldValue($("input[name=filePath]"));	
	n0201VOMap.fileCtype  = getFieldValue($("input[name=fileCtype]"));	
	n0201VOMap.fileCnt  = getFieldValue($("input[name=fileCnt]"));	
	n0201VOMap.delFileIds  = getFieldValue($("input[name=delFileIds]"));	
	
	goAjax("/sjpb/N/insertCmctDtaDtl.face", n0201VOMap, callBackUplodateCmctExcelDataSuccess);
	
}


function callBackUplodateCmctExcelDataSuccess(){
	selectList();
	ekrFile.fileUploadCallback();
	insertCmctExcelUploadViewCloseBtn();
	
	
}

function selectSendRecvDivStatisticsList(n0202SCMap){
	n0202SCMap.trntDt = "";
	goAjax("/sjpb/N/selectSendRecvDivStatisticsList.face", n0202SCMap, function (data){callbackSelectSendRecvDivStatisticsListSuccess(data, cmctDtaDtsNum, n0202SCMap)});
}


function callbackSelectSendRecvDivStatisticsListSuccess(data, cmctDtaDtsNum, n0202SCMap){
	var QCELLProp= {
            "parentid" : "sheetSendRecv",
            "id"		: "qCellItem",
            "merge"		: {header : "rowandcol"},
            "data"		: {"input" : data.qCellItem},
            "selectmode": "row",
            "columns"	: [
            	{width: '50%',	key: 'recvNum',				title: ['대상번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '25%',	key: 'sendDivCnt',				title: ['발신건수'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '25%',	key: 'recvDivCnt',			title: ['역발신건수'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            ]
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
	selectSendRecvDivStatisticsAllList(qcellItem.getRowData(rowIdx).recvNum);
	
}

function selectSendRecvDivStatisticsAllList(recvNum){
	n0202SCMap.cmctDtaBkNum = getFieldValue($("#cmctDtaBkNum"));
	n0202SCMap.recvNum = recvNum;
	goAjax("/sjpb/N/selectCmctDtsCheckList.face", n0202SCMap, function (data){selectSendRecvDivStatisticsAllListSuccess(data, n0202SCMap)});
}

function selectSendRecvDivStatisticsAllListSuccess(data, n0202SCMap){
	 $("#sheetSendRecvList").show();
	var QCELLProp = {
            "parentid" : "sheetSendRecvList",
            "id"		: "qcellDts",
            "merge"		: {header : "rowandcol"},
            "data"		: {"input" : data.qCell},
            "selectmode": "row",
            "columns"	: [
            	{width: '4%',	key: 'checkbox',			title: [''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '6%',	key: 'cmctCmpyNm',			title: ['통신사'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '5%',	key: 'useTpNm',			title: ['사용유형'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},  
            	{width: '5%',	key: 'sendRecvDivNm',			title: ['발착구분'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},          	
            	{width: '10%',	key: 'sendNum',			title: ['발신번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'recvNum',			title: ['착신번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'callBeTimeConv',			title: ['통화시작시간'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}, 
            	{width: '10%',	key: 'callDurtTimeConv',			title: ['통화시간'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}, 
            	{width: '40%',	key: 'sendBaseSttnAddr',			title: ['발신기지국주소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}, 
            	],
			//"rowheader"	: "sequence",
			"frozencols" : 5
        };
	
	
        QCELL.create(QCELLProp);
        qcellDetail = QCELL.getInstance("qcellDts");
        $("#subTitle").show();
        $("#exceldownSendRecvBtnArea").show();
        autoResize();
	
}



function selectSendDivStatisticsList(cmctDtaDtsNum){
	if ($("li.m2 > div.tab_mini_contents").is(":visible")) {
		n0202SCMap.cmctDtaBkNum = getFieldValue($("#cmctDtaBkNum"));
		goAjax("/sjpb/N/selectSendDivStatisticsList.face", n0202SCMap, function (data){callBackSelectSendDivStatisticsListSuccess(data, cmctDtaDtsNum, n0202SCMap)});
	}
}


function callBackSelectSendDivStatisticsListSuccess(data, cmctDtaDtsNum, n0202SCMap){

	
	var QCELLProp= {
            "parentid" : "sendSheet",
            "id"		: "sendNumListItem",
            "merge"		: {header : "rowandcol"},
            "data"		: {"input" : data.qCellItem},
            "selectmode": "row",
            "columns"	: [
            	{width: '50%',	key: 'sendNum',				title: ['대상번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '50%',	key: 'sendDivCnt',				title: ['발신건수'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            ]
        };
	

        QCELL.create(QCELLProp);
        sendNumListItem = QCELL.getInstance("sendNumListItem");
        sendNumListItem.bind("click", eventFn2);
        
        if (sendNumListItem.getRows("data") > 0) {
        	if(cmctDtaDtsNum == null){
        		rowIdx = headerRows;
        		sendBaseSttnAddrGroupList(n0202SCMap);
        	}else{
        		sendBaseSttnAddrGroupList(sendNumListItem.getRowData(rowIdx).sendNum,'1');
        		selectSendStatisticsAllList(sendNumListItem.getRowData(rowIdx).sendNum);
        	}
        	
        	//qcell 첫번째줄에 초기 커스텀 스타일 추가 (후에, 클릭시 스타일 제거) 
    		var colCnt = sendNumListItem.getCols();
    		for (var i = 0; i < colCnt; i++) {
    			sendNumListItem.setCellStyle(rowIdx, i, {"background-color" : "#c1c8e8 !important", "border-color" : "#a8b0d4 !important"});
				isInitStyleQcell = true;
			}
        } 


        autoResize();

	
}

function eventFn2(e){	
	//선택한 인덱스 가져오기
	rowIdx = sendNumListItem.getIdx("row");
	sendBaseSttnAddrGroupList(sendNumListItem.getRowData(rowIdx).sendNum,'1');	
	selectSendStatisticsAllList(sendNumListItem.getRowData(rowIdx).sendNum);
}


function selectSendStatisticsAllList(sendNum){
	initN0202GRPSCMap();
	n0202GRPSCMap.cmctDtaBkNum = getFieldValue($("#cmctDtaBkNum"));
	n0202GRPSCMap.sendNum = sendNum;
	n0202GRPSCMap.sendRecvDiv = "1";
	n0202GRPSCMap.allCheck = "1";
	goAjax("/sjpb/N/selectSendBaseSttnAddrStatisticsAllList.face", n0202GRPSCMap, function (data){callbackSelectSendBaseSttnAddrStatisticsAllList(data, n0202GRPSCMap)});
}







function selectRecvDivStatisticsList(cmctDtaDtsNum){
	if ($("li.m3 > div.tab_mini_contents").is(":visible")) {
		n0202SCMap.cmctDtaBkNum = getFieldValue($("#cmctDtaBkNum"));
		goAjax("/sjpb/N/selectRecvDivStatisticsList.face", n0202SCMap, function (data){callBackSelectRecvDivStatisticsListSuccess(data, cmctDtaDtsNum, n0202SCMap)});
	}
}


function callBackSelectRecvDivStatisticsListSuccess(data, cmctDtaDtsNum, n0202SCMap){

	
	var QCELLProp= {
            "parentid" : "recvSheet",
            "id"		: "recvNumListItem",
            "merge"		: {header : "rowandcol"},
            "data"		: {"input" : data.qCellItem},
            "selectmode": "row",
            "columns"	: [
            	{width: '50%',	key: 'recvNum',				title: ['대상번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '50%',	key: 'recvDivCnt',				title: ['역발신건수'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            ]
        };
	

        QCELL.create(QCELLProp);
        recvNumListItem = QCELL.getInstance("recvNumListItem");
        recvNumListItem.bind("click", eventFn3);

        if (recvNumListItem.getRows("data") > 0) {
        	if(cmctDtaDtsNum == null){
        		rowIdx = headerRows;
        		sendBaseSttnAddrGroupList(recvNumListItem.getRowData(rowIdx).recvNum,'1');
        		selectRecvStatisticsAllList(recvNumListItem.getRowData(rowIdx).recvNum);
        	}else{
        		sendBaseSttnAddrGroupList(recvNumListItem.getRowData(rowIdx).recvNum,'1');
        		selectRecvStatisticsAllList(recvNumListItem.getRowData(rowIdx).recvNum);
        	}
        	
        	//qcell 첫번째줄에 초기 커스텀 스타일 추가 (후에, 클릭시 스타일 제거) 
    		var colCnt = recvNumListItem.getCols();
    		for (var i = 0; i < colCnt; i++) {
    			recvNumListItem.setCellStyle(rowIdx, i, {"background-color" : "#c1c8e8 !important", "border-color" : "#a8b0d4 !important"});
				isInitStyleQcell = true;
			}
        }         
        autoResize();
}

function eventFn3(e){	
	//선택한 인덱스 가져오기
	rowIdx = recvNumListItem.getIdx("row");
	sendBaseSttnAddrGroupList(recvNumListItem.getRowData(rowIdx).recvNum,'2');
	selectRecvStatisticsAllList(recvNumListItem.getRowData(rowIdx).recvNum);
} 

function selectRecvStatisticsAllList(recvNum){
	initN0202GRPSCMap();
	n0202GRPSCMap.cmctDtaBkNum = getFieldValue($("#cmctDtaBkNum"));
	n0202GRPSCMap.recvNum = recvNum;
	n0202GRPSCMap.allCheck = "1";
	n0202GRPSCMap.sendRecvDiv = "2";
	goAjax("/sjpb/N/selectSendBaseSttnAddrStatisticsAllList.face", n0202GRPSCMap, function (data){callbackSelectSendBaseSttnAddrStatisticsAllList(data, n0202GRPSCMap)});
}




function sendBaseSttnAddrGroupList(moblPhonNum, sendRecvDiv){
	n0202GRPSCMap.cmctDtaBkNum = getFieldValue($("#cmctDtaBkNum"));
	n0202GRPSCMap.sendRecvDiv = sendRecvDiv;
	if(sendRecvDiv =='1'){
		n0202GRPSCMap.sendNum = moblPhonNum;
		n0202GRPSCMap.recvNum ="";
	}else if(sendRecvDiv =='2'){
		n0202GRPSCMap.recvNum = moblPhonNum;
		n0202GRPSCMap.sendNum ="";
	}
	
	goAjax("/sjpb/N/sendBaseSttnAddrGroupList.face", n0202GRPSCMap, function (data){callBackSendBaseSttnAddrGroupListSuccess(data, cmctDtaDtsNum, n0202GRPSCMap)});

}


function callBackSendBaseSttnAddrGroupListSuccess(data, cmctDtaDtsNum, n0202GRPSCMap){

	var parentId;
	if(n0202GRPSCMap.sendRecvDiv =='1'){
		parentId = "sendAddrSheet";
	}else if(n0202GRPSCMap.sendRecvDiv =='2'){
		parentId = "recvAddrSheet";
	}
	
	var QCELLProp= {
            "parentid" : parentId,
            "id"		: "sendBaseSttnAddrGroupItem",
            "merge"		: {header : "rowandcol"},
            "data"		: {"input" : data.qCellItem},
            "selectmode": "row",
            "columns"	: [
            	{width: '50%',	key: 'sendBaseSttnAddr',				title: ['기지국주소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '50%',	key: 'sendBaseSttnAddrCnt',				title: ['발생건수'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            ]
        };
	

        QCELL.create(QCELLProp);
        sendBaseSttnAddrGroupItem = QCELL.getInstance("sendBaseSttnAddrGroupItem");
        if(sendBaseSttnAddrGroupItem != null){
        	sendBaseSttnAddrGroupItem.bind("click", eventFn4);
        }
        autoResize();
}

function eventFn4(e){	
	rowIdx = sendBaseSttnAddrGroupItem.getIdx("row");
	selectSendBaseSttnAddrStatisticsAllList(sendBaseSttnAddrGroupItem.getRowData(rowIdx).sendBaseSttnAddr);
	
}







function selectSendBaseSttnAddrStatisticsAllList(sendBaseSttnAddr){
	initN0202GRPSCMap();
	n0202GRPSCMap.cmctDtaBkNum = getFieldValue($("#cmctDtaBkNum"));
	n0202GRPSCMap.sendBaseSttnAddr = sendBaseSttnAddr;
	goAjax("/sjpb/N/selectSendBaseSttnAddrStatisticsAllList.face", n0202GRPSCMap, function (data){callbackSelectSendBaseSttnAddrStatisticsAllList(data, n0202GRPSCMap)});
}


function callbackSelectSendBaseSttnAddrStatisticsAllList(data, n0202GRPSCMap){
	var parentId;
	if ($("li.m2 > div.tab_mini_contents").is(":visible")) {
		parentId = "sendAddrAllSheet";
		$("#sendAddrAllSheet").show();
		$("#recvAddrAllSheet").hide();
		 $("#subTitleSend").show();
		 $("#subTitleRecv").hide();
		 $("#exceldownSendDetailAllBtnArea").show();
		 $("#exceldownRecvDetailAllBtnArea").hide();
	}else if ($("li.m3 > div.tab_mini_contents").is(":visible")) {
		parentId = "recvAddrAllSheet";
		$("#sendAddrAllSheet").hide();
		$("#recvAddrAllSheet").show();
		$("#subTitleSend").hide();
		$("#subTitleRecv").show();
		 $("#exceldownSendDetailAllBtnArea").hide();
		 $("#exceldownRecvDetailAllBtnArea").show();		
	}
	var QCELLProp = {
           "parentid" : parentId,
           "id"		: "qcellAll",
           "data"		: {"input" : data.qCellItem},
           "selectmode": "row",
           "columns"	: [
        	{width: '4%',	key: 'checkbox',			title: [''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
           	{width: '6%',	key: 'cmctCmpyNm',			title: ['통신사'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
           	{width: '5%',	key: 'useTpNm',			title: ['사용유형'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},  
           	{width: '5%',	key: 'sendRecvDivNm',			title: ['발착구분'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},          	
           	{width: '10%',	key: 'sendNum',			title: ['발신번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
           	{width: '10%',	key: 'recvNum',			title: ['착신번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
           	{width: '10%',	key: 'callBeTimeConv',			title: ['통화시작시간'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}, 
           	{width: '10%',	key: 'callDurtTimeConv',			title: ['통화시간'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}, 
           	{width: '40%',	key: 'sendBaseSttnAddr',			title: ['발신기지국주소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}, 
           	],
			//"rowheader"	: "sequence",
			"frozencols" : 5
       };
	
	
       QCELL.create(QCELLProp);
       qcellAll = QCELL.getInstance("qcellAll");
      
       autoResize();
       handleUI();
}



function insertCmctExcelUploadViewBtn(){
	$("#insertDiv").show();
	$("#insertCmctExcelUploadViewBtn").hide();
	$("#insertCmctExcelUploadViewCloseBtn").show();
}

function insertCmctExcelUploadViewCloseBtn(){
	$("#insertDiv").hide();
	$("#insertCmctExcelUploadViewBtn").show();
	$("#insertCmctExcelUploadViewCloseBtn").hide();
}



//삭제 
function deleteCmctDtaDts(){
	
	
	//선택된 ROW가져오기 
	var n0202VOArray = new Array();
	
	for(var i = 0; i < qcell.getColData(0).length; i++){
		if(qcell.getColData(0)[i] == true){
			
			var n0202VOTmp = new Object();
			n0202VOTmp = qcell.getRowData(i+headerRows);
			
			n0202VOArray.push(n0102VOTmp);
		}
	}
	
	//체크여부확인 
	if(n0202VOArray.length == 0){
		alert("하나이상 체크해주세요.");
		return;
	}
	
	//병합한다.
	if(confirm("삭제하시겠습니까?") == true){
		var reqMap = {
				n0202VOList : n0202VOArray
		}
		goAjax("/sjpb/N/deleteCmctDtaDts.face", reqMap, callBackDeleteCmctDtaDtsSuccess);
	}else{
		return;
	}
}

//삭제 성공 콜백 함수 
function callBackDeleteCmctDtaDtsSuccess(data){
	//성공
	if(data.n0202VO.result == "01"){
		alert("삭제되었습니다.");
		selectList();
		
		  
        if ($("li.m1 > div.tab_mini_contents").is(":visible")) {
        	selectSendDivStatisticsList(n0102SCMap);
        }else if ($("li.m2 > div.tab_mini_contents").is(":visible")) {
        	selectDayStatisticsList();
        }else if ($("li.m3 > div.tab_mini_contents").is(":visible")) {
        	selectDayStatisticsList();
        }
	}else{
		var errMsg = "";
		if(data.n0202VO.errMsg != null){
			errMsg = data.n0202VO.errMsg;
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

function handleUI(){
	autoResize();
}
//신규 저장
function insertCmctDtaDts(){
	//Map 데이터 갱신
	ekrFile.setForm();
	if(syncN0201VOMap(true)){
		goAjax("/sjpb/N/insertCmctDta.face", n0201VOMap, callBackInsertCmctDtaDtsSuccess);
	}
}

//신규저장 성공 콜백함수
function callBackInsertCmctDtaDtsSuccess(data){
	alert("신규로 등록되었습니다.");
	
	selectList(data.n0202VO.cmctDtaDtsNum);
	
}

//Map 데이터 갱신
function syncN0202VOMap(isValid) {
	
	//유효성체크 여부에 따라 체크함 
	if(isValid){
		//유효성 체크
		var chkObjs = $("#contentsArea");
		if(!chkValidate.check(chkObjs, true)) return;
	}	
	return true;
	
}


function syncN0201VOMap(isValid) {
	
	//유효성체크 여부에 따라 체크함 
	if(isValid){
		//유효성 체크
		var chkObjs = $("#contentsArea");
		if(!chkValidate.check(chkObjs, true)) return;
	}	
	return true;
	
}


//초기화
function initN0202VOMap(){
	n0202VOMap = {
			cmctDtaBkNum : ""		
			,cmctDtaSbjt : ""	
			,moblPhonNum : ""			
			,cmctCmpyNm : ""			
		}                           
}


//포렌식
var n0202VOMap = {
		cmctDtaSbjt : ""	
		,moblPhonNum : ""	
		,cmctDtaBkNum : ""	
		,cmctCmpyNm :  ""
		,useTp :  ""
		,sendRecvDiv :  ""
		,sendNum :  ""
		,recvNum :  ""
		,sDate :  ""
		,eDate :  ""
		,callBeTime :  ""
		,callDurtTime :  ""
		,sendBaseSttnAddr :  ""
}


var n0201VOMap = {
		cmctDtaSbjt : ""	
		,moblPhonNum : ""	
		,cmctDtaBkNum : ""	
		,cmctCmpyNm :  ""
		,useTp :  ""
		,sendRecvDiv :  ""
		,sendNum :  ""
		,recvNum :  ""
		,sDate :  ""
		,eDate :  ""
		,callBeTime :  ""
		,callDurtTime :  ""
		,sendBaseSttnAddr :  ""
}

//초기화
function initN0202SCMap(){
	n0202SCMap = {
		cmctDtaSbjt : ""	
		,moblPhonNum : ""	
		,cmctDtaBkNum : ""	
		,cmctCmpyNm :  ""
		,useTp :  ""
		,sendRecvDiv :  ""
		,sendNum :  ""
		,recvNum :  ""
		,sDate :  ""
		,eDate :  ""
		,callBeTime :  ""
		,callDurtTime :  ""
		,sendBaseSttnAddr :  ""
	}
}

//검색조건




var n0202SCMap = {
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

function initN0202GRPSCMap(){
	n0202GRPSCMap = {
		cmctDtaSbjt : ""	
		,moblPhonNum : ""	
		,cmctDtaBkNum : ""	
		,cmctCmpyNm :  ""
		,useTp :  ""
		,sendRecvDiv :  ""
		,sendNum :  ""
		,recvNum :  ""
		,sDate :  ""
		,eDate :  ""
		,callBeTime :  ""
		,callDurtTime :  ""
		,sendBaseSttnAddr :  ""
		,allCheck : ""
	}
}


var n0202GRPSCMap = {
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
		,allCheck : ""
	}



//리포트맵
var n0202RTMap = {
	rexdataset : null
}
