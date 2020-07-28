$(function(){
	pageInit();
});

var qcell;     //사건수사지휘부리스트
var qcellItem; //사건수사지휘건아이템리스트

//화면 진입시 동작함
function pageInit(){
	
	//수사사건지휘부 화면(리스트)을 가져온다.	
	selectIncCriCmdBkList();
	
	//이벤트바인딩
	eventSetup();
	
	//유저와 타스크상태에 따른 버튼 활성화 처리
	handleBtnGroup();
	
}

//이벤트처리
function eventSetup() {
	
	//검색조건 초기화
	$("#initBtn").on("click", function() {
		var searchArea = $("div[class=searchArea]");		
		//input 값 초기화
		searchArea.find("input[type=text]").val("");
		
		//select 값 초기화
		searchArea.find("select").each(function() {
			$(this).find("option:eq(0)").prop("selected", true);
			$(this).prev('.txt').text($(this).find('option:selected').text());
		});
		
		//검색맵 초기화
		c0101SCMap = {
				respDppoCdSC : ""        //담당지점코드
			   ,respTrfOffiSC : ""    //담당자
			   ,criCmdProDtFromSC : ""   //지휘일자 시작일자
			   ,criCmdProDtToSC : ""     //지휘일자 종료일자	
			   ,rcptIncNumSC : "" //사건번호	   
			   ,spNmSC : ""	//피의자
		}	
	});
	
	$(".searchArea input[type=text],.searchArea select").keypress(function(e){
		if(e.keyCode == 13){
			e.stopPropagation();
			
			//송치관일경우에만 검색
			if (SJPBRole.getTrnsrRoleYn()) {
				selectIncCriCmdBkList();
			}
		}
	});
	
	//조건검색호출
	$("#srchBtn").on("click", function() {
		selectIncCriCmdBkList();
	});	
		
	//신규
	$("#newBtn").off("click").on("click", function() {
		
		c0101VOMap = {
				incCriCmdBkNum : ""       //사건수사지휘부번호
				,incCriCmdBkPublYr : ""   //발행년도    
			    ,criCmdProDt : $("#today").val()		  //수사지휘건의일
			    ,respTrfOffi : $("#userId").val()    //담당사건지휘 송치관
			    ,respDppoCd : ""        //담당지점코드
			    ,incCriCmdBkStatCd : "01" //사건수사지휘부상태코드
				,regUserId : $("#userId").val()      //등록자
				,regDate : ""        //등록일자
				,updUserId : $("#userId").val()      //수정자
				,updDate : ""        //수정일자
				,nmKor : $("#userName").val()        //담당송치관 이름
				,respDppoDesc : ""        //관할지검명
				,incCriCmdBkStatDesc : "신규"        //상태코드설명
				,incCriCmdItemList : null  //사건수사지휘건리스트
				,checkbox : true
			}
		
		$("#criCmdProDt").val(c0101VOMap.criCmdProDt).prev('.txt').text($("#criCmdProDt").find('option:selected').text());
		$("#respDppoCd").val("").prev('.txt').text($("#respDppoCd").find('option:selected').text());
		
		qcell.addRow(c0101VOMap);		
		
		if (qcellItem) {
			qcellItem.removeRows(qcellItem.getRows('data'));
		}
		
		syncIncCriCmdItemList(); //지휘부 마스터와 사건 아이템 데이터 동기화
		insertIncCriCmdBk();  //신규마스터 추가
		
	});	
	
	//수현0106
	//수사지휘부 준비중인 문서 삭제 버튼
	$("#cmdBkDelBtn").off("click").on("click", function(){
		deleteReadyCmdBk();
	});
	
	//추가
	$("#addBtn").off("click").on("click", function() {		
		commonLayerPopup.openLayerPopup('/sjpb/C/C0301.face', "1000px", "430px", addNewIncCriCmdItem);		
	});
	
	//삭제
	$("#delBtn").off("click").on("click", function() {
		deleteIncCriCmdBk();
	});
	
	//저장
	$("#saveBtn").off("click").on("click", function() {
		syncIncCriCmdItemList(); //지휘부 마스터와 사건 아이템 데이터 동기화
		updateIncCriCmdBk(); //사건수사지휘부 업데이트
	});
	
	//출력
	$("#prnBtn").off("click").on("click", function() {
		selectIncCriCmdItemReport();
	});
	
	//출력
	$("#prnBtn2").off("click").on("click", function() {
		selectIncCriCmdItemReport();
	});
	
	//지휘요청완료
	$("#comfBtn").off("click").on("click", function() {
		syncIncCriCmdItemList(); //지휘부 마스터와 사건 아이템 데이터 동기화
		
		if (c0101VOMap.respDppoCd == "") {
			alert("관할지검을 선택해 주세요.")
			return false;
		}
		
		if (!isValidDate(c0101VOMap.criCmdProDt)) {
			alert("유효한 지휘년월일을 선택해 주세요.")
			return false;
		}

		if (c0101VOMap.incCriCmdItemList == undefined || c0101VOMap.incCriCmdItemList.length == 0) {
			alert("사건수사지휘부에 사건을 등록해 주세요.")
			return false;
		}
		
		c0101VOMap.incCriCmdBkStatCd = "02"; //제출완료		
		$.each(c0101VOMap.incCriCmdItemList, function(i, item) {
			item.incCriCmdItemStatCd="03"; //수사지휘건의
			item.updStatYN = "Y";
		});
		
		confirmIncCriCmdBk(); //사건수사지휘부 업데이트
	});
	
	//송치문서 업로드
	$("#fileBtn").off("click").on("click", function() {	
		updateCriIncDta();
	});
	
}

//수사자료 업데이트
function updateCriIncDta() {
	
	if ( sjpbFile.vaultUploader) {
		sjpbFile.vaultUploader.attachEvent("onUploadComplete", function (files) {		
			
			syncSjpbFileVOList(files);			
			sjpbFile.isNewFile = false;
			sjpbFile.isCancel = false;

			goAjax("/sjpb/C/updateCriIncDta.face", incCriCmdItemVO, callBackUpdateCriIncDtaSuccess);
		
		});		
		
		if (sjpbFile.isNewFile) { //업로드 대상이 있는 경우			
			sjpbFile.vaultUploader.upload();
		} else {  //업로드 대상이 없는 경우			
			incTrfItemVO.criIncDtaVOList = null;
			sjpbFile.isCancel = false;
		} 
		
	}
	
}

//송치부파일 업로드 콜백
function callBackUpdateCriIncDtaSuccess(data) {
	alert("정상적으로 저장되었습니다.");
	//console.log(JSON.stringify(data));
	
	fn_init(); //파일업로드 초기화
	
	selectIncCriCmdItemDetails();  //재조회
}

//첨부파일 데이터 갱신
function syncSjpbFileVOList(files) {
	
	if (incCriCmdItemVO.criIncDtaVOList == null || incCriCmdItemVO.criIncDtaVOList.length == 0) {
		var criIncDtaVOArray = new Array();
		var criIncDtaVO = {
				criDtaNum : ""
				,rcptNum : incCriCmdItemVO.rcptNum
				,criDtaCatgCd : CRI_DTA_CATG_CD  //송치자료
				,criReptCont : ""
				,regUserId :  incCriCmdItemVO.updUserId
				,updUserId :  incCriCmdItemVO.updUserId
				,recdType : "I"
		}
		criIncDtaVOArray.push(criIncDtaVO);
		incCriCmdItemVO.criIncDtaVOList = criIncDtaVOArray;
	}
	

	if ( sjpbFile.vaultUploader) {
		var sjpbFileVOArray = new Array();	
		var fileList = sjpbFile.vaultUploader.getData();
		//console.log(fileList);
		
		if (files.length > 0) {  
			for (var i = 0 ; i < fileList.length ; i++) {					
				var sjpbFileVO = {
					fileNm : fileList[i].name
				   ,fileMask : fileList[i].serverName
				   ,fileSize : fileList[i].size
				   ,regUserId : $("#userId").val()
				   ,updUserId : $("#userId").val()
				}
				sjpbFileVOArray.push(sjpbFileVO);
			}
		}
	
		incCriCmdItemVO.criIncDtaVOList[0].sjpbFileVOList = sjpbFileVOArray;	
		
	}
	
}


//사건리스트 데이터 갱신
function syncIncCriCmdItemList() {	
	
	c0101VOMap.respDppoCd = $("#respDppoCd").val(); //지검
	c0101VOMap.criCmdProDt = $("#criCmdProDt").val(); //지휘년월일
	if (qcellItem) {
		c0101VOMap.incCriCmdItemList = QCELL.getInstance("qcellItem").getData();
	}
}


//수사사건지휘부 화면(리스트)을 가져온다. 
function selectIncCriCmdBkList(){
	
	//최소화 되어 있으면 검색중단
	if(!$('#sheet:visible').length) return;
	
	c0101SCMap.respDppoCdSC = $("#respDppoCdSC").val();
	c0101SCMap.respTrfOffiSC = $("#respTrfOffiSC").val();
	c0101SCMap.criCmdProDtFromSC = $("#criCmdProDtFromSC").val();
	c0101SCMap.criCmdProDtToSC = $("#criCmdProDtToSC").val();	
	c0101SCMap.rcptIncNumSC = $("#rcptIncNumSC").val();
	c0101SCMap.spNmSC = $("#spNmSC").val();
	
	goAjax("/sjpb/C/selectIncCriCmdBkList.face", c0101SCMap, callBackSelectIncCriCmdBkListSuccess)
	
}


//수사사건지휘부 화면(리스트) 콜백함수
function callBackSelectIncCriCmdBkListSuccess(data) {
	
	var QCELLProp = {
		       "parentid" : "sheet",
		       "id"		: "qcell",
		       "data"		: {"input" : data.qCell},
		       "selectmode": "cell",         
		       "columns"	: [
		       	{width: '5%',	key: 'checkbox',			title: [''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:false},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
		       	{width: '15%',	key: 'criCmdProDt',			title: ['지휘일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
		       	{width: '15%',	key: 'respDppoDesc',			title: ['관할지점'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},       	
		       	{width: '15%',	key: 'nmKor',			title: ['담당송치관'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
		       	{width: '20%',	key: 'incNum',			title: ['사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
		       	{width: '20%',	key: 'spNm',			title: ['피의자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
		       	{width: '10%',	key: 'incCriCmdBkStatDesc',			title: ['상태'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
		       	]
		       
		   };
   QCELL.create(QCELLProp);
   qcell = QCELL.getInstance("qcell");
   qcell.bind("click", eventFn);
   
   //최초 로딩시
   if (qcell.getRows("data") > 0) {   
       //셀 선택 백그라운드 지정
	  qcell.setRowStyle(1, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data"); 
       
      c0101VOMap = qcell.getRowData(1);      
      selectIncCriCmdItemList();
      
   }else{
	   //데이터가 없음, 아래 영역 숨김처리 
	   //contentsArea, step2Area, step3Area
	   $("#contentsArea").hide();
	   $("#step2Area").hide();
	   $("#step3Area").hide();
	   $("#step2Btn").hide();
	   
   }
   
}

//수사사건지휘부 마스터 추가 
function insertIncCriCmdBk(){
	goAjax("/sjpb/C/insertIncCriCmdBk.face", c0101VOMap, callBackInsertIncCriCmdBkSuccess);	
}


//수사사건지휘부 마스터 추가 콜백함수
function callBackInsertIncCriCmdBkSuccess(data) {
	alert("정상적으로 신규 사건수사지휘부가 생성되었습니다. \n 해당 사건들을 추가해 주세요.");
	//console.log(JSON.stringify(data));
	selectIncCriCmdBkList(); //신규 호출
}

//수사사건지휘부 업데이트 
function updateIncCriCmdBk(){
	goAjax("/sjpb/C/updateIncCriCmdBk.face", c0101VOMap, callBackUpdateIncCriCmdBkSuccess);	
}


//수사사건지휘부 업데이트 콜백함수
function callBackUpdateIncCriCmdBkSuccess(data) {
	alert("정상적으로 저장되었습니다.");
	//console.log(JSON.stringify(data));
	selectIncCriCmdBkList(); //신규 호출
}

//수사사건결과 업데이트 
function updateIncCriCmdItem(){
	
	goAjax("/sjpb/C/updateIncCriCmdItem.face", incCriCmdItemVO, callBackUpdateIncCriCmdItemSuccess);	
}


//수사사건결과 업데이트 콜백함수
function callBackUpdateIncCriCmdItemSuccess(data) {
	
	alert("정상적으로 처리되었습니다.");
	//console.log(JSON.stringify(data));	
	
	selectIncCriCmdItemDetails();
}


//지휘요청완료 
function confirmIncCriCmdBk(){	
	goAjax("/sjpb/C/confirmIncCriCmdBk.face", c0101VOMap, callBackConfirmIncCriCmdBkSuccess);	
}


//지휘요청완료 콜백함수
function callBackConfirmIncCriCmdBkSuccess(data) {
	alert("정상적으로 지휘요청완료처리되었습니다.");
	//console.log(JSON.stringify(data));
	selectIncCriCmdBkList(); //신규 호출
}

//수사사건지휘부 업데이트 
function deleteIncCriCmdBk(){

	var itemMap;
	var existYn = false;
	//기존 체크항목 해제와 새로 선택한 행 체크박스 선택
	for (var i=1; i<=qcellItem.getRows("data"); i++) {
		if (qcellItem.getCellData(i, 1)) {
			itemMap = qcellItem.getRowData(i);
			
			itemMap.incCriCmdBkNum = ""
			itemMap.incCriCmdItemStatCd = "01" //접수상태			
			itemMap.recdType = "D";
			itemMap.updStatYN = "Y";
			qcellItem.setRowData(i, itemMap);
			existYn = true;
		}
	}
	
	if (existYn) {
		syncIncCriCmdItemList(); //사건 아이템 데이터 동기화		
		goAjax("/sjpb/C/deleteIncCriCmdBk.face", c0101VOMap, callBackDeleteIncCriCmdBkSuccess);
	} else {
		alert("삭제할 항목을 선택해 주세요.");
		return false;
	}
	
}


//수사사건지휘부 업데이트 콜백함수
function callBackDeleteIncCriCmdBkSuccess(data) {
	alert("정상적으로 삭제되었습니다.");
	//console.log(JSON.stringify(data));
	selectIncCriCmdItemList(); //리스트 갱신
}

//리스트 셀 클릭 이벤트 
function eventFn(e){
	
	var objQCell = e.data.target;
	
	//선택한 인덱스 가져오기
	var rowIdx = qcell.getIdx("row");
	
	
	//상세 호출
	if (rowIdx > 0) {
		qcell.clearCellStyles();
		
		//기존 체크항목 해제와 새로 선택한 행 체크박스 선택
		qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");	
		
		c0101VOMap = qcell.getRowData(rowIdx);
		selectIncCriCmdItemList();
	}

}



//수사사건지휘건 아이템 리스트를 가져온다. 
function selectIncCriCmdItemList(){
	
	//contentsArea보이기
	$("#contentsArea").show();
	
	$("#step2Area > div").html("");
	$("#step3Area").hide();
	
    if (c0101VOMap.incCriCmdBkStatCd == "02") { //사건수사지휘 제출완료
       $("#step1Btn").hide();
	   $("#step2Area").show();
	   $("#step2Btn").show();
	   
	   
    } else {	   
	   $("#step1Btn").show();
	   $("#step2Area").hide();
	   $("#step2Btn").hide();
    }  
	
	$("#respDppoCd").val(c0101VOMap.respDppoCd).prev("p").html($("select[name=respDppoCd] option:selected").text());
	$("#criCmdProDt").val(c0101VOMap.criCmdProDt);
	
	goAjax("/sjpb/C/selectIncCriCmdItemList.face", c0101VOMap, callBackSelectIncCriCmdItemListSuccess)
	
}



//수현0106
//수사사건지휘부 화면(리스트) 콜백함수
function callBackSelectIncCriCmdItemListSuccess(data) {
	
	var evidArtcYnData = [
		{'label':'있음', 'value':'Y'},
		{'label':'없음', 'value':'N'},
		]; // 증거품 유무

	
	var incArrtClsfData = [
		{'label':'불구속기소', 'value':'04'},
		{'label':'구속기소', 'value':'18'},
		{'label':'혐의없음', 'value':'08'},
		{'label':'공소권없음', 'value':'06'},
		{'label':'범죄인정안됨', 'value':'16'},
		{'label':'각하', 'value':'15'},
		{'label':'기타', 'value':'99'},
		]; // 사건구속별
	
	 var QCELLProp = {
   "parentid" : "sheetItem",
   "id"		: "qcellItem",
   "data"		: {"input" : data.qCell},
   "selectmode": "cell",         
   "columns"	: [
   	{width: '5%',	key: 'checkbox',			title: [''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
   	{width: '15%',	key: 'rcptIncNum',			title: ['사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
   	{width: '30%',	key: 'incCriNm',			title: ['죄명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
   	{width: '20%',	key: 'incSp',			title: ['피의자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
   	{width: '20%',	key: 'incArrtClsf',			title: ['구속별'], 	type:'selectmenu', options:{input:incArrtClsfData,itemcount:7},	sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
   	{width: '10%',	key: 'evidArtcYn',			title: ['증거품유무'],  type:'selectmenu', options:{input:evidArtcYnData,itemcount:2},	sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
   	],
   	"rowheader"	: "sequence"
	 };
	 QCELL.create(QCELLProp);
	 qcellItem = QCELL.getInstance("qcellItem");
	 qcellItem.bind("click", eventFnItem);
	 
	 //최초 로딩시
	 if (qcellItem.getRows("data") > 0) {
		qcellItem.setRowStyle(1, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
		 
		c0101VOMap.incCriCmdItemList = qcellItem.getData(); 
		incCriCmdItemVO = qcellItem.getRowData(1);
		selectIncCriCmdItemDetails();		
	 } 

}


//수사사건지휘건 아이템 리스트를 가져온다. (리포트)
function selectIncCriCmdItemReport(){	
	goAjax("/sjpb/C/selectIncCriCmdItemReport.face", c0101VOMap, callBackSelectIncCriCmdItemReportSuccess)	
}



//수사사건지휘부 화면(리포트) 콜백함수
function callBackSelectIncCriCmdItemReportSuccess(data) {
	
	//console.log(JSON.stringify(data));
	c0101RTMap.rexdataset = data.rexdataset;
	
	var xmlString = objectToXml(c0101RTMap);
	
	$("#reptNm").val("C0101.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	
	//레포트 호출
	openReportService(reportForm);  

}

//리스트 셀 클릭 이벤트 
function eventFnItem(e){
	//선택한 인덱스 가져오기
	var rowIdx = qcellItem.getIdx("row");	
	
	//기존 체크항목 해제와 새로 선택한 행 체크박스 선택
	qcellItem.removeRowStyle(qcellItem.getIdx("row","focus","previous") == -1?1:qcellItem.getIdx("row","focus","previous"));
	qcellItem.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
	
	//상세 호출
	if (rowIdx > 0) {
		incCriCmdItemVO = qcellItem.getRowData(rowIdx);
		selectIncCriCmdItemDetails();
	}

}


//검색을 통해서 신규사건을 추가한다.
function addNewIncCriCmdItem(data) {
	
	var itemMap = {}
	$.each(data, function(i, item) {
		
		itemMap = {
			"incCriCmdItemNum":item.incCriCmdItemNum
			,"incCriCmdBkNum":c0101VOMap.incCriCmdBkNum
			,"rcptNum":item.rcptNum
			,"incCriCmdItemStatCd":"02" //수사지휘등록
			,"criCmdTranDt":item.criCmdTranDt
			,"criCmdReqDt":item.criCmdReqDt
			,"criCmdRcptDt":null
			,"reCmdYn":item.reCmdYn
			,"criCmdRst":null
			,"criCmdComn":null
			,"incCriNm":item.rltActCriNm
			,"incSp":item.spNm
			,"incArrtClsf":"04"
			,"evidArtcYn":"N"
			,"regUserId":$("#userId").val()
			,"regDate":null
			,"updUserId":$("#userId").val()
			,"updDate":null
			,"incCriCmdItemNumDesc":null
			,"rcptIncNum":item.rcptIncNum	
			,"recdType":"I"  //신규
			,"updStatYN":"Y"  //상태업데이트				
		}
		
		//기존리스트에 없는 경우만 추가
		if (QCELL.getInstance("qcellItem").getColData(2).indexOf(itemMap.rcptIncNum) == -1) {		
			QCELL.getInstance("qcellItem").addRow(itemMap);
		}
		
	});
	
	syncIncCriCmdItemList(); //사건 아이템 데이터 동기화
	updateIncCriCmdBk(); //사건수사지휘부 업데이트
	
}

//수사사건지휘건 상세를 가져온다. 
function selectIncCriCmdItemDetails(){
	//로딩플래그
	loadingFlag = false;
	
	goAjax("/sjpb/C/selectIncCriCmdItemDetails.face", incCriCmdItemVO, callBackSelectIncCriCmdItemDetailsSuccess);
}





//수사사건지휘부 화면(리스트) 콜백함수
function callBackSelectIncCriCmdItemDetailsSuccess(data) {
	
    var itemHtml = new StringBuffer();  
    
    var criCmdRstLast = "";  //마지막 지휘결과
    
    var lastElement = 0;
    if (data.incCriCmdItemVO.length > 0) {
    	lastElement = data.incCriCmdItemVO.length - 1;
    }
    
	$.each(data.incCriCmdItemVO, function(i, item) {
		
		var preTitle = "";
		if (i > 0) preTitle = "재 ";
		
		itemHtml.append('		<div class="listArea tab_mini_contents" data-inc-cri-cmd-item-num="'+item.incCriCmdItemNum+'" data-re-cmd-yn="'+item.reCmdYn+'" data-pre-title="'+preTitle+'">');
        itemHtml.append('            <table class="list" cellpadding="0" cellspacing="0">                           ');
        itemHtml.append('                <colgroup>                                                                 ');
        itemHtml.append('                    <col width="10%" />                                                    ');        
        itemHtml.append('                    <col width="15%" />                                                    ');
        itemHtml.append('                    <col width="30%" />                                                    ');
        itemHtml.append('                    <col width="15%" />                                                    ');
        itemHtml.append('                    <col width="30%" />                                                    ');
        itemHtml.append('                </colgroup>                                                                ');
        itemHtml.append('                <tbody>                                                                    ');
        itemHtml.append('                    <tr>                                                                   ');
        itemHtml.append('                           <th class="C line_right" rowspan="4">'+preTitle+'수사지휘</th>    ');
        if (i == 0) {
	        itemHtml.append('                        <th class="C">지휘기관</th>                                          ');
	        itemHtml.append('                        <td class="L">'+item.respDppoDesc+'</td>                                          ');
        } else {
	        itemHtml.append('                        <th class="C">'+preTitle+'지휘인계일</th>                                          ');
	        itemHtml.append('                        <td class="L">'+item.criCmdTranDt+'</td>                                          ');        	
        }
        
        itemHtml.append('                        <th class="C">'+preTitle+'지휘접수일</th>                                         ');
        itemHtml.append('                        <td class="L">'+item.criCmdReqDt+'</td>                                      ');
        itemHtml.append('                    </tr>                                                                  ');
        itemHtml.append('                    <tr>                                                                   '); 
        itemHtml.append('                        <th class="C">'+preTitle+'지휘건의일</th>                                          ');
        itemHtml.append('                        <td class="L">'+item.criCmdProDt+'</td>                             ');
        itemHtml.append('                        <th class="C">'+preTitle+'지휘수령일</th>                             		         ');
        
        //마지막 엘리먼트가 아닌경우또는 수사지휘결과 수령상태인경우
        if (i != lastElement || item.incCriCmdItemStatCd == "04") {        	
        	itemHtml.append('                 		 <td class="L" >'+item.criCmdRcptDt+'</td>                                 ');	
        } else {        	
	        itemHtml.append('                 		 <td class="L" >                                             ');        
	        itemHtml.append('							<label for="criCmdRcptDt"></label><input type="text" class="w50per calendar datepicker" id="criCmdRcptDt" name="criCmdRcptDt" value="'+item.criCmdRcptDt+'" />    ');
	        itemHtml.append('                   	 </td>																	');
        	 
        }
        
        
        itemHtml.append('                    </tr>                                                                  ');
        itemHtml.append('                    <tr>                                                                   '); 
        itemHtml.append('                        <th class="C">'+preTitle+'지휘결과</th>                                            ');
        
        //마지막 엘리먼트가 아닌경우또는 수사지휘결과 수령상태인경우
        if (i != lastElement || item.incCriCmdItemStatCd == "04") {    	
        	itemHtml.append('                 		 <td class="L" colspan="3">'+(item.criCmdRst=="C"?"미접수":(item.criCmdRst=="Y"?"가":"부"))+'</td>                                 ');
        } else {
		        itemHtml.append('                    <td class="L" colspan="3">                                             ');
		        itemHtml.append('                        <div class="inputbox w20per">										');
		        itemHtml.append('                    <p class="txt"></p>													');
		        itemHtml.append('                    <select name="criCmdRst" >																');
		        itemHtml.append('                    <option value="">선택</option>											');
		        itemHtml.append('                    <option value="Y" '+(item.criCmdRst=="Y"?"selected":"")+'>가</option>											');
		        itemHtml.append('                    <option value="N" '+(item.criCmdRst=="N"?"selected":"")+'>부</option>											');
		        itemHtml.append('                    <option value="C" '+(item.criCmdRst=="C"?"selected":"")+'>미접수</option>											');
		        itemHtml.append('                    </select>																');
		        itemHtml.append('                    </div>      															');                                             
		        itemHtml.append('                    </td>																	');
        	
        }
        
        itemHtml.append('                    </tr>                                                                  ');
        itemHtml.append('                    <tr>                                                                   '); 
        itemHtml.append('                        <th class="C">기타의견</th>                                            ');
        
        //마지막 엘리먼트가 아닌경우
        if (i != lastElement) {      
        	itemHtml.append('                 		 <td class="L" colspan="3">'+item.criCmdComn+'</td> 			'); 
        } else {
        	itemHtml.append('  						 <td class="L" colspan="3"><label for="criCmdComn"></label><input type="text" class="w100per" id="criCmdComn" name="criCmdComn" value="'+item.criCmdComn+'"/></td> ');
        
        	//마지막상태 저장
        	criCmdRstLast = item.criCmdRst;
        }
        
        itemHtml.append('                    </tr>                                                                  ');
        itemHtml.append('                </tbody>                                                                   ');
        itemHtml.append('            </table>                                                                       ');
        itemHtml.append('        </div>                                                                             ');		
        itemHtml.append('        <p>&nbsp;</p>                                                                             ');
	});
	 

	itemHtml.append('<div class="btnArea">                                                                         ');	
	itemHtml.append('<div class="r_btn"><a href="#" class="btn_white" id="saveItemBtn"><span>저장</span></a></div>   ');
	itemHtml.append('</div>                                                                                        ');

	
	$("#step2Area > div").html(itemHtml.toString());
	
	//달력이벤트
	$(".datepicker").datepicker({
		  dateFormat: "yy-mm-dd" ,
		  changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
		  changeYear: true,
		  showButtonPanel: true,
		  currentText: '오늘 날짜'
	});	
	
	//가부결정
	$("select[name=criCmdRst]").off("change").on("change", function() {		
		$(this).prev('.txt').text($(this).find('option:selected').text());
	});
	$("select[name=criCmdRst]").trigger("change");
	
	//수사결과 저장
	$("#saveItemBtn").off("click").on("click", function() {
		
		incCriCmdItemVO.incCriCmdItemNum = $("#step2Area div.listArea").last().data("inc-cri-cmd-item-num");
		
		//사건수사지휘건이 수령상태가 아닐 경우에만 화면에서 값을 입력받는다. 2019.01.03 수정
		if(incCriCmdItemVO.incCriCmdItemStatCd != "04"){
			incCriCmdItemVO.criCmdRcptDt = $("#step2Area div.listArea").last().find("input[name=criCmdRcptDt]").val();
			incCriCmdItemVO.criCmdRst = $("#step2Area div.listArea").last().find("select[name=criCmdRst]").val();
		}
		
		var criCmdRstDesc = $("#step2Area div.listArea").last().find("select[name=criCmdRst] option:selected").text();
		incCriCmdItemVO.criCmdComn = $("#step2Area div.listArea").last().find("input[name=criCmdComn]").val();
		
		var preTitle = $("#step2Area div.listArea").last().data("pre-title");
		if(incCriCmdItemVO.criCmdRst !='C'){
			if (incCriCmdItemVO.criCmdRcptDt == "") {
				alert(preTitle+"지휘수령일을 선택해 주세요.");
				return false;
			}
			
			if (incCriCmdItemVO.criCmdRst == "") {
				alert(preTitle+"지휘결과을 선택해 주세요.");
				return false;
			}		
		}
		
		if (incCriCmdItemVO.incCriCmdItemStatCd == "03") {//수사지휘건의 완료
			if(incCriCmdItemVO.criCmdRst =='C'){
				var r = confirm("해당 사건을 미접수처리상태로 하시겠습니까?");
				if (r == true) {
					incCriCmdItemVO.incCriCmdItemStatCd = "04"; 
					incCriCmdItemVO.updStatYN = "Y";
					updateIncCriCmdItem();
				} 					
			}else{
				var r = confirm("수사지휘결과를 아래와 같이 등록하시겠습니까? \n지휘수령일 : "+incCriCmdItemVO.criCmdRcptDt+"\n지휘결과 : "+criCmdRstDesc);
				if (r == true) {
					incCriCmdItemVO.incCriCmdItemStatCd = "04"; //수사지휘결과 수령
					incCriCmdItemVO.updStatYN = "Y";
					updateIncCriCmdItem();
				} 					
			}
			/*
			var r = confirm("수사지휘결과를 아래와 같이 등록하시겠습니까? \n지휘수령일 : "+incCriCmdItemVO.criCmdRcptDt+"\n지휘결과 : "+criCmdRstDesc);
			if (r == true) {
				incCriCmdItemVO.incCriCmdItemStatCd = "04"; //수사지휘결과 수령
				incCriCmdItemVO.updStatYN = "Y";
				updateIncCriCmdItem();
			} 		
			*/	
		} else {
			
			incCriCmdItemVO.updStatYN = "N";
			updateIncCriCmdItem();
			
		}
		
	});	
	
	//유저와 타스크상태에 따른 버튼 활성화 처리
	handleBtnGroup();
	
	//화면사이즈 갱신
	autoResize();
	
	//파일첨부 S 2018.11.20 추가
	//데이터가 있을경우에만, 가 혹은, 부 에서 노출 
	if(criCmdRstLast == "Y" || criCmdRstLast == "N"){
		$("#step3Area").show();
		
		initEditActionManager();
		//수사사건자료
		selectCriIncDta();
	}
	//파일첨부 E 2018.11.20 추가
	
	//로딩플래그
	loadingFlag = true;
}

//수사사건자료상세를 가져온다. 
function selectCriIncDta(){
	
	incCriCmdItemVO.criDtaCatgCd = CRI_DTA_CATG_CD; //수사지휘
	goAjax("/sjpb/C/selectCriIncDta.face", incCriCmdItemVO, callBackSelectCriIncDtaSuccess);
}

//수사사건자료상세 콜백함수
function callBackSelectCriIncDtaSuccess(data) {
	//console.log(JSON.stringify(data));
	//incCriCmdItemVO = data.incTrfItemVO;
	
	//2019.01.03 버그 수정 
	incCriCmdItemVO.criIncDtaVOList = data.incTrfItemVO.criIncDtaVOList;
	incCriCmdItemVO.criIncDtaFileVOList = data.incTrfItemVO.criIncDtaFileVOList;
	
	//수사자료 리스팅	
	renderDTTable(incCriCmdItemVO.criIncDtaFileVOList);
	
	//화면사이즈 갱신
	autoResize();	
}

//수사자료 데이터 표시
function renderDTTable(qcellData) {	
	
	if (qcellData == null) qcellData = [];
	
	 var QCELLProp = {
	         "parentid" : "sheetDT",
	         "id"		: "qcellDT",
	         "data"		: {"input" : qcellData},
	         "selectmode": "cell",         
	         "columns"	: [
	         	{width: '25%',	key: 'criDtaCatgDesc',			title: ['서식명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
	         	{width: '25%',	key: 'atchFileNm',				title: ['관련서식 파일명'],	type: "html", options: {html: {data: fnData}},	sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
	         	{width: '20%',	key: 'updUserNm',			title: ['작성자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
	         	{width: '20%',	key: 'updDate',				title: ['작성일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
	         	{width: '10%',	key: '',				title: [''], type: "html", options: {html: {data: fnDeleteData}},		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}
	         	]         
	         , "rowheaders": ["sequence"]	         
	     };
	     QCELL.create(QCELLProp);
	     qcellDT = QCELL.getInstance("qcellDT");
}

//qcell 삭제버튼 그리기 
function fnDeleteData(id, row, col, val, obj){
	
	var html = "";
	
	//본인이 등록한 파일만 삭제 가능 
	if($("#userId").val() == obj.regUserId){
		html = "<a href=\"javascript:deleteFileData('"+obj.atchFileId+"')\" >삭제<a>";
	}
	
	return html;
}

//파일삭제 
function deleteFileData(atchFileId){
	
	//삭제한다.
	if(confirm("삭제하시겠습니까?") == true){
		var reqMap = {
				atchFileId : atchFileId
				,rcptNum : c0101VOMap.rcptNum
			}
		goAjax("/sjpb/Z/deleteFile.face", reqMap, callBackDeleteFileDataSuccess);
		
	}
	
}

//파일삭제 성공 콜백함수 
function callBackDeleteFileDataSuccess(data){
	
	//성공
	if(data.sjpbCriIncDtaFileVO.result == "01"){
		alert("파일이 삭제 되었습니다.");
		
		incCriCmdItemVO.criIncDtaFileVOList = data.criIncDtaFileVOList;
		incCriCmdItemVO.criIncDtaVOList = data.criIncDtaVOList;
		
		//작성서식 목록 새로고침
		renderDTTable(incCriCmdItemVO.criIncDtaFileVOList);
		
		//화면사이즈 갱신
		autoResize();
		
	}else{
		alert(data.sjpbCriIncDtaFileVO.errMsg);
		
	}
	
}

//첨부파일 다운 셀표현
function fnData(id, row, col, val, obj){
	var html = '';  
	if(val == ''){
	  html = val;
	} else {
	  html = '<a href="/sjpb/Z/download.face?fileId='+obj.atchFileId+'" download >'+val+'<a>';
	}
	
	return html;
}



//유저와 타스크상태에 따른 버튼 활성화 처리
function handleBtnGroup() {
	
	//송치관이 아니면 읽기 전용 처리
	if (!SJPBRole.getTrnsrRoleYn()) {
		$("a.btn_white, a.btn_blue").each(function(index) {
			if (($(this).attr("id") == "initBtn") || ($(this).attr("id") == "srchBtn") ) {
				$(this).show();
			} else {
				$(this).hide();
			}
		});
	}
	
}

//수현0106
//수사지휘부 
function deleteReadyCmdBk(){
	var incCriCmdBkNumArr =[];
	
	if(confirm("선택한 수사지휘부를 삭제하시겠습니까?") == true){
		for(var i = 1; i <= qcell.getRows("data"); i++){
			if(JSON.stringify(qcell.getCellLabel(i,0)) == "true"){
				if(qcell.getRowData(i).incCriCmdBkStatCd == "01"){
					incCriCmdBkNumArr.push(qcell.getRowData(i).incCriCmdBkNum);
				}else{
					alert("준비중인 지휘부만 삭제 가능합니다.");
					return;
				}
			}
		}
		var incCriCmdBkNumArrMap ={
				"incCriCmdBkNumArr":incCriCmdBkNumArr
		}
		goAjaxDefault("/sjpb/C/deleteReadyCmdBk.face",incCriCmdBkNumArrMap,function(data){callBackFn_f_deleteReadyCmdBkSuccess(data,incCriCmdBkNumArr.length)});
	}else{
		return;
	}
}
function callBackFn_f_deleteReadyCmdBkSuccess(data,len){
	if(data == len){
		alert("정상적으로 처리되었습니다.");	
	}else{
		alert("시스템 오류입니다. 관리자에게 문의하세요.");
	}
	pageInit();
}

//사건수사지휘부 데이터맵
var c0101VOMap = {
	incCriCmdBkNum : ""       //사건수사지휘부번호
	,incCriCmdBkPublYr : ""   //발행년도    
    ,criCmdProDt : ""		  //수사지휘건의일
    ,respIncCmdOffi : ""    //담당사건지휘 송치관
    ,respDppoCd : ""        //담당지점코드
    ,incCriCmdBkStatCd : "" //사건수사지휘부상태코드 01:준비중, 02:제출완료
	,regUserId : ""      //등록자
	,regDate : ""        //등록일자
	,updUserId : ""      //수정자
	,updDate : ""        //수정일자
	,nmKor : ""        //담당송치관 이름
	,respDppoDesc : ""        //관할지검명
	,incCriCmdBkStatDesc : ""        //상태코드설명
	,incCriCmdItemList : null  //사건수사지휘건리스트
}

//검색조건
var c0101SCMap = {		
	respDppoCdSC : ""        //담당지점코드
   ,respTrfOffiSC : ""    //담당자
   ,criCmdProDtFromSC : ""   //지휘일자 시작일자
   ,criCmdProDtToSC : ""     //지휘일자 종료일자		
   ,rcptIncNumSC : "" //사건번호	   
   ,spNmSC : ""	//피의자
}


//리포트맵
var c0101RTMap = {		
}


//수사지휘
var incCriCmdItemVO =  {		
	incCriCmdItemNum : ""  //사건수사지휘건번호
	,rcptNum : ""          //접수번호
	,incCriCmdItemStatCd : "" //사건수사지휘건상태코드 01:접수, 02:등록, 03:건의, 04:수령
	,incCriCmdBkNum : ""   //사건수사지휘부번호	
	,criCmdTranDt : ""   //수사지휘인계일
	,criCmdReqDt : ""    //수사지휘접수일
	,criCmdRcptDt : ""   //수사지휘수령일
	,reCmdYn : ""        //재지휘여부
	,criCmdRst : ""      //수사지휘결과
	,criCmdComn : ""     //수사지휘의견
	,incCriNm : ""       //사건죄명
	,incSp : ""          //사건피의자
	,incArrtClsf : ""    //사건구속별
	,evidArtcYn : ""     //증거품유무
	,rcptIncNum : ""     //사건번호
	,criCmdProDt : ""	  //수사지휘건의일
	,updStatYN : ""       //상태변경유무	
	,regUserId : ""
	,regDate : ""
	,updUserId : ""
	,updDate : ""		
}


