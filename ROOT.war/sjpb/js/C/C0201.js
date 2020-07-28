$(function(){
	pageInit();
});

var qcell;     //사건송치부리스트
var qcellItem; //사건송치건아이템리스트
var qcellTrfItem; //사건송치건아이템 피의자리스트
//수현1220
var qcellSpActVioItem; //사건송치건 피의자별 (위반법률)리스트

//화면 진입시 동작함
function pageInit(){
	
	//수사사건송치부 화면(리스트)을 가져온다.	
	selectIncTrfBkList();
	
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
		c0201SCMap = {
				respDppoCdSC : ""        //담당지점코드
			   ,respTrfOffiSC : ""    //담당자
			   ,trfProDtFromSC : ""   //송치일자 시작일자
			   ,trfProDtToSC : ""     //송치일자 종료일자	
			   ,rcptIncNumSC : "" //사건번호	  
			   ,spNmSC : ""	//피의자
		}	
	});
	
	$(".searchArea input[type=text],.searchArea select").keypress(function(e){
		if(e.keyCode == 13){
			e.stopPropagation();
			
			//송치관일경우에만 검색
			if (SJPBRole.getTrnsrRoleYn()) {
				selectIncTrfBkList();
			}
		}
	});
	
	//조건검색호출
	$("#srchBtn").on("click", function() {
		selectIncTrfBkList();
	});	
		
	//신규
	$("#newBtn").off("click").on("click", function() {
		
		c0201VOMap = {
				incTrfBkNum : ""       //사건송치부번호
				,incTrfBkPublYr : ""   //발행년도    
			    ,trfProDt : $("#today").val()		  //송치건의일
			    ,respTrfOffi : $("#userId").val()    //담당사건송치 송치관
			    ,respDppoCd : ""        //담당지점코드
			    ,incTrfBkStatCd : "01" //사건송치부상태코드
				,regUserId : $("#userId").val()      //등록자
				,regDate : ""        //등록일자
				,updUserId : $("#userId").val()      //수정자
				,updDate : ""        //수정일자
				,nmKor : $("#userName").val()        //담당송치관 이름
				,respDppoDesc : ""        //관할지검명
				,incTrfBkStatDesc : "신규"        //상태코드설명
				,incTrfItemList : null  //사건송치건리스트
				,checkbox : true
			}
		
		$("#trfProDt").val(c0201VOMap.trfProDt).prev('.txt').text($("#trfProDt").find('option:selected').text());
		$("#respDppoCd").val("").prev('.txt').text($("#respDppoCd").find('option:selected').text());
		
		qcell.addRow(c0201VOMap);		
		
		if (qcellItem) {
			qcellItem.removeRows(qcellItem.getRows('data'));
		}
		
		syncIncTrfItemList(); //송치부 마스터와 사건 아이템 데이터 동기화
		insertIncTrfBk();  //신규마스터 추가
		
	});	
	
	//추가
	$("#addBtn").off("click").on("click", function() {		
		commonLayerPopup.openLayerPopup('/sjpb/C/C0302.face', "1000px", "430px", addNewIncTrfItem,true);		
	});
	
	//삭제
	$("#delBtn").off("click").on("click", function() {
		deleteIncTrfBk();
	});
	
	//저장
	$("#saveBtn").off("click").on("click", function() {
		syncIncTrfItemList(); //송치부 마스터와 사건 아이템 데이터 동기화		
		updateIncTrfBk(); //사건송치부 업데이트
	});
	
	//수현1220
	$("#saveBtn2").off("click").on("click", function() {
		syncIncTrfSpItemList(); //사건송치건 피의자별(위반법률) 아이템 데이터 동기화		
		updateIncTrfSpItem(); //사건송치건 피의자별(위반법률) 아이템 업데이트
	});
	$("#saveBtn3").off("click").on("click", function() {
		syncIncTrfSpItemList(); //사건송치건 피의자별(위반법률) 아이템 데이터 동기화		
		updateIncTrfSpItem(); //사건송치건 피의자별(위반법률) 아이템 업데이트
	});
	
	//출력
	$("#prnBtn").off("click").on("click", function() {
		selectIncTrfItemReport();
	});
	
	$("#prnBtn2").off("click").on("click", function() {
		selectIncTrfItemReport();
	});
	
	
	//송치요청완료
	$("#comfBtn").off("click").on("click", function() {
		syncIncTrfItemList(); //송치부 마스터와 사건 아이템 데이터 동기화
		
		if (c0201VOMap.respDppoCd == "") {
			alert("관할지검을 선택해 주세요.")
			return false;
		}
		
		if (!isValidDate(c0201VOMap.trfProDt)) {
			alert("유효한 송치년월일을 선택해 주세요.")
			return false;
		}

		if (c0201VOMap.incTrfItemList == undefined || c0201VOMap.incTrfItemList.length == 0) {
			alert("사건송치부에 사건을 등록해 주세요.")
			return false;
		}
		
		c0201VOMap.incTrfBkStatCd = "02"; //제출완료		
		$.each(c0201VOMap.incTrfItemList, function(i, item) {
			item.incTrfItemStatCd="03"; //송치건의
			item.updStatYN = "Y";
		});
		
		confirmIncTrfBk(); //사건송치부 업데이트
	});
	
	
	//송치문서 업로드
	$("#fileBtn").off("click").on("click", function() {	
		updateCriIncDta();
	});
	
	//수현0106
	//송치부 준비중인 문서 삭제 버튼
	$("#trfBkDelBtn").off("click").on("click", function(){
		deleteReadyTrfBk();
	});
	
}


//수사자료 업데이트
function updateCriIncDta() {
	
	if ( sjpbFile.vaultUploader) {
		sjpbFile.vaultUploader.attachEvent("onUploadComplete", function (files) {		
			
			syncSjpbFileVOList(files);			
			sjpbFile.isNewFile = false;
			sjpbFile.isCancel = false;

			goAjax("/sjpb/C/updateCriIncDta.face", incTrfItemVO, callBackUpdateCriIncDtaSuccess);
		
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
	fn_init(); //파일업로드 초기화
	
	selectIncTrfItemDetails();  //재조회
}


//첨부파일 데이터 갱신
function syncSjpbFileVOList(files) {
	
	if (incTrfItemVO.criIncDtaVOList == null || incTrfItemVO.criIncDtaVOList.length == 0) {
		var criIncDtaVOArray = new Array();
		var criIncDtaVO = {
				criDtaNum : ""
				,rcptNum : incTrfItemVO.rcptNum
				,criDtaCatgCd : CRI_DTA_CATG_CD  //송치자료
				,criReptCont : ""
				,regUserId :  incTrfItemVO.updUserId
				,updUserId :  incTrfItemVO.updUserId
				,recdType : "I"
		}
		criIncDtaVOArray.push(criIncDtaVO);
		incTrfItemVO.criIncDtaVOList = criIncDtaVOArray;
	}
	

	if ( sjpbFile.vaultUploader) {
		var sjpbFileVOArray = new Array();	
		var fileList = sjpbFile.vaultUploader.getData();
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
	
		incTrfItemVO.criIncDtaVOList[0].sjpbFileVOList = sjpbFileVOArray;	
		
	}
	
}



//사건리스트 데이터 갱신
function syncIncTrfItemList() {	
	
	c0201VOMap.respDppoCd = $("#respDppoCd").val(); //지검
	c0201VOMap.trfProDt = $("#trfProDt").val(); //송치년월일
	if (qcellItem) {
		c0201VOMap.incTrfItemList = QCELL.getInstance("qcellItem").getData();
	}
}

//수현1220
//사건송치 피의자별(위반법률) 데이터 갱신
function syncIncTrfSpItemList() {	

	if (qcellSpActVioItem) {
		incTrfSpItemVO.incTrfSpItemVOList = QCELL.getInstance("qcellSpActVioItem").getData();
		
	}
}


//수사사건송치부 화면(리스트)을 가져온다. 
function selectIncTrfBkList(){
	
	//최소화 되어 있으면 검색중단
	if(!$('#sheet:visible').length) return;
	
	c0201SCMap.respDppoCdSC = $("#respDppoCdSC").val();
	c0201SCMap.respTrfOffiSC = $("#respTrfOffiSC").val();
	c0201SCMap.trfProDtFromSC = $("#trfProDtFromSC").val();
	c0201SCMap.trfProDtToSC = $("#trfProDtToSC").val();	
	c0201SCMap.rcptIncNumSC = $("#rcptIncNumSC").val();
	c0201SCMap.spNmSC = $("#spNmSC").val();
	
	goAjax("/sjpb/C/selectIncTrfBkList.face", c0201SCMap, callBackSelectIncTrfBkListSuccess)
	
}
//수현0106
//수사사건송치부 화면(리스트) 콜백함수
function callBackSelectIncTrfBkListSuccess(data) {
	
	 var QCELLProp = {
     "parentid" : "sheet",
     "id"		: "qcell",
     "data"		: {"input" : data.qCell},
     "selectmode": "cell",         
     "columns"	: [
  	{width: '5%',	key: 'checkbox',			title: [''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:false},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
     	{width: '15%',	key: 'trfProDt',			title: ['송치일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
     	{width: '10%',	key: 'respDppoDesc',			title: ['관할지점'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},       	
     	{width: '15%',	key: 'nmKor',			title: ['담당송치관'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
     	{width: '15%',	key: 'incNum',			title: ['사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
     	{width: '20%',	key: 'spNm',			title: ['피의자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
     	{width: '10%',	key: 'trfNum',			title: ['송치번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
     	{width: '10%',	key: 'incTrfBkStatDesc',			title: ['상태'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
     	]
          
 };
 QCELL.create(QCELLProp);
 qcell = QCELL.getInstance("qcell");
 qcell.bind("click", eventFn);
 
 //최초 로딩시
 if (qcell.getRows("data") > 0) {
     //셀 선택 백그라운드 지정
	  qcell.setRowStyle(1, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
     
    c0201VOMap = qcell.getRowData(1);      
    selectIncTrfItemList();      
 
 }else{
	   //데이터가 없음, 아래 영역 숨김처리 
	   //tab_mini_m1_contents, step2Area, step3Area, 
	   $("#tab_mini_m1_contents").hide();

	   $("#step2Area").hide();
	   //$("#step3Area").hide();
	   $("#step2Btn").hide();
	   
 }
 
}

//수사사건송치부 마스터 추가 
function insertIncTrfBk(){
	goAjax("/sjpb/C/insertIncTrfBk.face", c0201VOMap, callBackInsertIncTrfBkSuccess);	
}


//수사사건송치부 마스터 추가 콜백함수
function callBackInsertIncTrfBkSuccess(data) {
	alert("정상적으로 신규 사건송치부가 생성되었습니다. \n 해당 사건들을 추가해 주세요.");
	selectIncTrfBkList(); //신규 호출
}

//수사사건송치부 업데이트 
function updateIncTrfBk(){
	goAjax("/sjpb/C/updateIncTrfBk.face", c0201VOMap, callBackUpdateIncTrfBkSuccess);	
}


//수사사건송치부 업데이트 콜백함수
function callBackUpdateIncTrfBkSuccess(data) {
	alert("정상적으로 저장되었습니다.");
	selectIncTrfBkList(); //신규 호출
}
//수현1220
//수사사건송치부 업데이트 
function updateIncTrfSpItem(){
	var spItemList= incTrfSpItemVO.incTrfSpItemVOList;
	for(var i=0; i <spItemList.length; i++){
		if(spItemList[i].incArrtClsf == null || spItemList[i].incArrtClsf == ""){
			alert("피의자 구속별을 입력해주세요");
			return;
		}
		spItemList[i].updUserId = $("#userId").val() ;
	}

	goAjax("/sjpb/C/updateIncTrfSpItem.face", incTrfSpItemVO, callBackUpdateIncTrfSpItemSuccess);	
}

//수현1220
//수사사건송치부 업데이트 콜백함수
function callBackUpdateIncTrfSpItemSuccess(data) {
	
	if(data.sucessYN == "Y"){
		alert("정상적으로 저장되었습니다.");
	}else{
		alert("시스템관리자에게 문의 하세요.");	
	}
	
	selectIncTrfItemDetails();
	
}

//수사사건결과 업데이트 
function updateIncTrfItem(){
	
	goAjax("/sjpb/C/updateIncTrfItem.face", incTrfItemVO, callBackUpdateIncTrfItemSuccess);	
}


//수사사건결과 업데이트 콜백함수
function callBackUpdateIncTrfItemSuccess(data) {
	
	alert("정상적으로 처리되었습니다.");
	selectIncTrfItemDetails();
	
}


//송치요청완료 
function confirmIncTrfBk(){	
	goAjax("/sjpb/C/confirmIncTrfBk.face", c0201VOMap, callBackConfirmIncTrfBkSuccess);	
}


//송치요청완료 콜백함수
function callBackConfirmIncTrfBkSuccess(data) {
	alert("정상적으로 송치요청완료처리되었습니다.");
	selectIncTrfBkList(); //신규 호출
}

//수사사건송치부 업데이트 
function deleteIncTrfBk(){

	var itemMap;
	var existYn = false;
	
	//기존 체크항목 해제와 새로 선택한 행 체크박스 선택
	//수현0107
	for (var i=1; i<=qcellItem.getRows("data"); i++) {
		if (JSON.stringify(qcellItem.getCellLabel(i,0)) == "true") {
			itemMap = qcellItem.getRowData(i);
			
			itemMap.incTrfBkNum = ""
			itemMap.incTrfItemStatCd = "01" //접수상태			
			itemMap.recdType = "D";
			itemMap.updStatYN = "Y";
			qcellItem.setRowData(i, itemMap);
			existYn = true;
		}
	}
	
	if (existYn) {
		syncIncTrfItemList(); //사건 아이템 데이터 동기화		
		goAjax("/sjpb/C/deleteIncTrfBk.face", c0201VOMap, callBackDeleteIncTrfBkSuccess);
	} else {
		alert("삭제할 항목을 선택해 주세요.");
		return false;
	}
	
}


//수사사건송치부 업데이트 콜백함수
function callBackDeleteIncTrfBkSuccess(data) {
	alert("정상적으로 삭제되었습니다.");
	selectIncTrfItemList(); //리스트 갱신
}

//수현0106
//리스트 셀 클릭 이벤트 
function eventFn(e){
	
	var objQCell = e.data.target;
	
	//선택한 인덱스 가져오기
	var rowIdx = qcell.getIdx("row");
	
	//기존 체크항목 해제와 새로 선택한 행 체크박스 선택
	//qcell.removeRowStyle(qcell.getIdx("row","focus","previous") == -1?1:qcell.getIdx("row","focus","previous"));
	//qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
	
	//상세 호출
	if (rowIdx > 0 && qcell.getIdx("col") != 0) {
		qcell.clearCellStyles();
		
		//기존 체크항목 해제와 새로 선택한 행 체크박스 선택
		qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
		
		c0201VOMap = qcell.getRowData(rowIdx);
		selectIncTrfItemList();
	}

}



//수사사건송치건 아이템 리스트를 가져온다. 
function selectIncTrfItemList(){
	
	//tab_mini_m1_contents 보이기;
	$("#tab_mini_m1_contents").show();
	
	$("#step2Area > div").html("");
	//$("#step3Area").hide();
	
	//수현1231
    if (c0201VOMap.incTrfBkStatCd == "02") { //사건송치 제출완료
       $("#step1Btn").hide();
       
       $("#step2Area").show();
	   $("#step2Btn").show();
	   $("#step3Area").show();
	   $("#spItemDIV").show();
	   $("#step3Btn").hide();
    } else {	   
	   $("#step1Btn").show();
	  
	   $("#step2Area").hide();
	   $("#step2Btn").hide();
	   $("#step3Area").hide();
	   $("#spItemDIV").hide();
	   //$("#step3Btn").show();
	    //화면사이즈 갱신
		autoResize();	   
    }  
	
	$("#respDppoCd").val(c0201VOMap.respDppoCd).prev("p").html($("select[name=respDppoCd] option:selected").text());
	$("#trfProDt").val(c0201VOMap.trfProDt);
	
	goAjax("/sjpb/C/selectIncTrfItemList.face", c0201VOMap, callBackSelectIncTrfItemListSuccess)
	
}



//수사사건송치부 화면(리스트) 콜백함수
function callBackSelectIncTrfItemListSuccess(data) {
	
	var evidArtcYnData = [
		{'label':'있음', 'value':'Y'},
		{'label':'없음', 'value':'N'}
		]; // 증거품 유무
	
	var incArrtClsfData = [
		{'label':'불구속기소', 'value':'04'},
		{'label':'구속기소', 'value':'18'},
		{'label':'혐의없음', 'value':'08'},
		{'label':'공소권없음', 'value':'06'},
		{'label':'범죄인정안됨', 'value':'16'},
		{'label':'각하', 'value':'15'},
		{'label':'기소중지', 'value':'11'},
		{'label':'기타', 'value':'99'}
		]; // 사건구속별
	
	 var QCELLProp = {
     "parentid" : "sheetItem",
     "id"		: "qcellItem",
     "data"		: {"input" : data.qCell},
     "selectmode": "cell",         
     "columns"	: [
     	{width: '5%',	key: 'checkbox',			title: [''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
     	{width: '10%',	key: 'trfNum',			title: ['송치번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
     	{width: '10%',	key: 'rcptIncNum',			title: ['사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
     	{width: '25%',	key: 'incCriNm',			title: ['죄명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
     	{width: '20%',	key: 'incSp',			title: ['피의자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
     	{width: '20%',	key: 'incArrtClsf',			title: ['구속별'], 	type:'selectmenu', options:{input:incArrtClsfData,itemcount:7},	sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
     	{width: '10%',	key: 'evidArtcYn',			title: ['증거품유무'],  type:'selectmenu',	options:{input:evidArtcYnData,itemcount:2},	sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
     	],
     	"rowheader"	: "sequence"
	 };
	 QCELL.create(QCELLProp);
	 qcellItem = QCELL.getInstance("qcellItem");
	 qcellItem.bind("click", eventFnItem);
	 
	 //최초 로딩시
	 if (qcellItem.getRows("data") > 0) {
		qcellItem.setRowStyle(1, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
		
		c0201VOMap.incTrfItemList = qcellItem.getData(); 
		
		incTrfItemVO = qcellItem.getRowData(1);
		selectIncTrfItemDetails();		
	 } 

}


//수사사건지휘건 아이템 리스트를 가져온다. (리포트)
function selectIncTrfItemReport(){	
	goAjax("/sjpb/C/selectIncTrfItemReport.face", c0201VOMap, callBackSelectIncTrfItemReportSuccess)	
}



//수사사건지휘부 화면(리포트) 콜백함수
function callBackSelectIncTrfItemReportSuccess(data) {
	
	c0201RTMap.rexdataset = data.rexdataset;
	
	var xmlString = objectToXml(c0201RTMap);
	
	$("#reptNm").val("C0201.crf"); //레포트 파일명
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
		incTrfItemVO = qcellItem.getRowData(rowIdx);
		selectIncTrfItemDetails();
	}

}


//검색을 통해서 신규사건을 추가한다.
function addNewIncTrfItem(data) {
	
	var itemMap = {}
	$.each(data, function(i, item) {
		
		itemMap = {
			"incTrfItemNum":item.incTrfItemNum
			,"incTrfBkNum":c0201VOMap.incTrfBkNum
			,"rcptNum":item.rcptNum
			,"incTrfItemStatCd":"02" //송치등록
			,"trfTranDt":item.trfTranDt
			,"trfReqDt":item.trfReqDt
			,"trfRcptDt":null
			,"reCmdYn":item.reCmdYn
			,"trfRst":null
			,"trfComn":null
			,"incCriNm":item.rltActCriNm
			,"incSp":item.spNm
			,"incArrtClsf":"04"
			,"evidArtcYn":"N"
			,"regUserId":$("#userId").val()
			,"regDate":null
			,"updUserId":$("#userId").val()
			,"updDate":null
			,"incTrfItemNumDesc":null
			,"rcptIncNum":item.rcptIncNum
			,"trfNum":item.trfNum
			,"recdType":"I"  //신규
			,"updStatYN":"Y"  //상태업데이트				
		}
		
		//기존리스트에 없는 경우만 추가
		if (QCELL.getInstance("qcellItem").getColData(2).indexOf(itemMap.rcptIncNum) == -1) {		
			QCELL.getInstance("qcellItem").addRow(itemMap);
		}
		
	});
	
	syncIncTrfItemList(); //사건 아이템 데이터 동기화
	
	updateIncTrfBk(); //사건송치부 업데이트
	
}
///1217 -- 수현 -------------

function eventFnSpItem(){
	//선택한 인덱스 가져오기
	var rowIdx = qcellTrfItem.getIdx("row");
	
	//기존 체크항목 해제와 새로 선택한 행 체크박스 선택
	qcellTrfItem.removeRowStyle(qcellTrfItem.getIdx("row","focus","previous") == -1?1:qcellTrfItem.getIdx("row","focus","previous"));
	qcellTrfItem.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");	
	
	//상세 호출
	if (rowIdx > 0) {
		incTrfSpItemVO = qcellTrfItem.getRowData(rowIdx);
		selectIncTrfItemSpActVioList();
	}
}
//사건송치건(아이템) 피의자 리스트 상세를 가져온다. 
function selectIncTrfItemSpActVioList(){	
	loadingFlag = false;	
	goAjax("/sjpb/C/selectIncTrfItemSpActVioList.face", incTrfSpItemVO, callBackSelectIncTrfItemSpActVioListSuccess);
}

//사건송치건(아이템) 피의자 리스트 상세 성공 콜백 함수
function callBackSelectIncTrfItemSpActVioListSuccess(data){
	
	var incArrtClsfData = [
		{'label':'불구속기소', 'value':'04'},
		{'label':'구속기소', 'value':'18'},
		{'label':'혐의없음', 'value':'08'},
		{'label':'공소권없음', 'value':'06'},
		{'label':'범죄인정안됨', 'value':'16'},
		{'label':'각하', 'value':'15'},
		{'label':'기타', 'value':'99'}
		]; // 사건구속별 
	var QCELLProp3 = {
		     "parentid" : "sheetSpActVioItem",
		     "id"		: "qcellSpActVioItem",
		     "data"		: {"input" : data.qCell},
		             
		     "columns"	: [
		     	{width: '70%',	key: 'criNm',			title: ['위반 법률'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
		     	{width: '30%',	key: 'incArrtClsf',			title: ['구속별'], 	type:'selectmenu', options:{input:incArrtClsfData,itemcount:7},	sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}
		     	],
		     	"rowheader"	: "sequence"
			 };
			 QCELL.create(QCELLProp3);
			 qcellSpActVioItem = QCELL.getInstance("qcellSpActVioItem");
			 qcellSpActVioItem.bind("click", eventFnSpActVioItem);
			 
			 //최초 로딩시
			 if (qcellSpActVioItem.getRows("data") > 0) {
				 qcellSpActVioItem.setRowStyle(1, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
				
				
			 } 
	
}
function eventFnSpActVioItem(){
	//선택한 인덱스 가져오기
	var rowIdx = qcellSpActVioItem.getIdx("row");
	
	//기존 체크항목 해제와 새로 선택한 행 체크박스 선택
	qcellSpActVioItem.removeRowStyle(qcellSpActVioItem.getIdx("row","focus","previous") == -1?1:qcellSpActVioItem.getIdx("row","focus","previous"));
	qcellSpActVioItem.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");	
	
	//상세 호출
	if (rowIdx > 0) {
		//selectIncTrfItemDetails();
	}
}

//수사사건송치건 상세를 가져온다. 
function selectIncTrfItemDetails(){
	//로딩플래그
	loadingFlag = false;	
	
	goAjax("/sjpb/C/selectIncTrfItemDetails.face", incTrfItemVO, callBackSelectIncTrfItemDetailsSuccess);
}


//수사사건송치부 화면(리스트) 콜백함수
function callBackSelectIncTrfItemDetailsSuccess(data) {
$("#spItemDIV").show();
	
	if (c0201VOMap.incTrfBkStatCd == "01") {//준비중이고 사건송치부가 있을경우 저장버튼 보이게
		$("#step3Btn").show();
	}
	
	//피의자 이름만 있는  Qcell 그리기!! -- 수현1219
	var QCELLProp2 = {
		     "parentid" : "sheetSpItem",
		     "id"		: "qcellTrfItem",
		     "data"		: {"input" : data.qCell},
		     "selectmode": "cell",         
		     "columns"	: [
		     	{width: '100%',	key: 'spNm',			title: ['피의자 이름'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}
		     	],
		     	"rowheader"	: "sequence"
			 };
			 QCELL.create(QCELLProp2);
			 qcellTrfItem = QCELL.getInstance("qcellTrfItem");
			 qcellTrfItem.bind("click" +
			 		"", eventFnSpItem);
			 
			 //최초 로딩시
			 if (qcellTrfItem.getRows("data") > 0) {
				 qcellTrfItem.setRowStyle(1, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
				 incTrfSpItemVO = qcellTrfItem.getRowData(1);
				 selectIncTrfItemSpActVioList();
				
			 }
	var incTrfItemStatCdLast = ""; //마지막 송치상태코드
	var trfRstLast = "";  //마지막 송치결과
	
    var itemHtml = new StringBuffer();  
    
    var lastElement = 0;
    if (data.incTrfItemVO.length > 0) {
    	lastElement = data.incTrfItemVO.length - 1;
    }
    
	$.each(data.incTrfItemVO, function(i, item) {
		
		
		var preTitle = "";
		if (i > 0) preTitle = "재 ";
		
		itemHtml.append('		<div class="listArea tab_mini_contents" data-inc-cri-cmd-item-num="'+item.incTrfItemNum+'" data-re-cmd-yn="'+item.reCmdYn+'" data-pre-title="'+preTitle+'">');
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
        itemHtml.append('                           <th class="C line_right" rowspan="4">'+preTitle+'송치</th>    ');
        if (i == 0) {
	        itemHtml.append('                        <th class="C">송치기관</th>                                          ');
	        itemHtml.append('                        <td class="L">'+item.respDppoDesc+'</td>                                          ');
        } else {
	        itemHtml.append('                        <th class="C">'+preTitle+'송치인계일</th>                                          ');
	        itemHtml.append('                        <td class="L">'+item.trfTranDt+'</td>                                          ');        	
        }
        
        itemHtml.append('                        <th class="C">'+preTitle+'송치접수일</th>                                         ');
        itemHtml.append('                        <td class="L">'+item.trfReqDt+'</td>                                      ');
        itemHtml.append('                    </tr>                                                                  ');
        itemHtml.append('                    <tr>                                                                   '); 
        itemHtml.append('                        <th class="C">'+preTitle+'송치일</th>                                          ');
        itemHtml.append('                        <td class="L">'+item.trfProDt+'</td>                             ');
        itemHtml.append('                        <th class="C">'+preTitle+'송치결과수령일</th>                             		         ');
        
        //마지막 엘리먼트가 아닌경우또는 송치결과 수령상태인경우
        if (i != lastElement || item.incTrfItemStatCd == "04") {        	
        	itemHtml.append('                 		 <td class="L" >'+item.trfRcptDt+'</td>                                 ');	
        } else {    
	        itemHtml.append('                 		 <td class="L" >                                             ');        
	        itemHtml.append('							<label for="trfRcptDt"></label><input type="text" class="w50per calendar datepicker" id="trfRcptDt" name="trfRcptDt" value="'+item.trfRcptDt+'" />    ');
	        itemHtml.append('                   	 </td>																	');
        
        }
        
        
        itemHtml.append('                    </tr>                                                                  ');
        itemHtml.append('                    <tr>                                                                   '); 
        itemHtml.append('                        <th class="C">'+preTitle+'송치결과</th>                                            ');
        
        //마지막 엘리먼트가 아닌경우또는 송치결과 수령상태인경우
        if (i != lastElement || item.incTrfItemStatCd == "04") {    	
        	itemHtml.append('                 		 <td class="L" colspan="3">'+(item.trfRst=="C"?"미접수":(item.trfRst=="Y"?"송치완료(가)":"부"))+'</td>                                 ');
        	
        } else {	        
	        itemHtml.append('                    <td class="L" colspan="3">                                             ');
	        itemHtml.append('                        <div class="inputbox w20per">										');
	        itemHtml.append('                    <p class="txt"></p>													');
	        itemHtml.append('                    <select name="trfRst" >																');
	        itemHtml.append('                    <option value="">선택</option>											');
	        itemHtml.append('                    <option value="Y" '+(item.trfRst=="Y"?"selected":"")+'>송치완료(가)</option>											');
	        itemHtml.append('                    <option value="N" '+(item.trfRst=="N"?"selected":"")+'>부</option>											');
	        itemHtml.append('                    <option value="C" '+(item.trfRst=="C"?"selected":"")+'>미접수</option>											');
	        itemHtml.append('                    </select>																');
	        itemHtml.append('                    </div>      															');                                             
	        itemHtml.append('                    </td>																	');
 
        }
        
        itemHtml.append('                    </tr>                                                                  ');
        itemHtml.append('                    <tr>                                                                   '); 
        itemHtml.append('                        <th class="C">기타의견</th>                                            ');
        
        //마지막 엘리먼트가 아닌경우
        if (i != lastElement) {      
        	itemHtml.append('                 		 <td class="L" colspan="3">'+item.trfComn+'</td> 			'); 
        } else {
        	itemHtml.append('  						 <td class="L" colspan="3"><label for="trfComn"></label><input type="text" class="w100per" id="trfComn" name="trfComn" value="'+item.trfComn+'"/></td> ');
        	
        	//마지막상태 저장
        	incTrfItemStatCdLast = item.incTrfItemStatCd;
        	trfRstLast = item.trfRst;
        	
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
	$("select[name=trfRst]").off("change").on("change", function() {		
		$(this).prev('.txt').text($(this).find('option:selected').text());
	});
	$("select[name=trfRst]").trigger("change");
	
	//수사결과 저장
	$("#saveItemBtn").off("click").on("click", function() {
		incTrfItemVO.incTrfItemNum = $("#step2Area div.listArea").last().data("inc-cri-cmd-item-num");
		
		//사건송치건이 수령상태가 아닐 경우에만 화면에서 값을 입력받는다. 2019.01.03 수정
		if(incTrfItemVO.incTrfItemStatCd != "04"){
			incTrfItemVO.trfRcptDt = $("#step2Area div.listArea").last().find("input[name=trfRcptDt]").val();
			incTrfItemVO.trfRst = $("#step2Area div.listArea").last().find("select[name=trfRst]").val();
		}
		
		var trfRstDesc = $("#step2Area div.listArea").last().find("select[name=trfRst] option:selected").text();
		incTrfItemVO.trfComn = $("#step2Area div.listArea").last().find("input[name=trfComn]").val();

		var preTitle = $("#step2Area div.listArea").last().data("pre-title");
		
		if(incTrfItemVO.trfRst !='C'){
			if (incTrfItemVO.trfRcptDt == "") {
				alert(preTitle+"송치결과수령일을 선택해 주세요.");
				return false;
			}
			
			if (incTrfItemVO.trfRst == "") {
				alert(preTitle+"송치결과을 선택해 주세요.");
				return false;
			}		
		}
		
		if (incTrfItemVO.incTrfItemStatCd == "03") {//송치건의 완료
			if(incTrfItemVO.trfRst =='C'){
				var r = confirm("해당 사건을 미접수처리상태로 하시겠습니까?");
				if (r == true) {
					incTrfItemVO.incTrfItemStatCd = "04"; //미접수 처리 시
					incTrfItemVO.updStatYN = "Y";
					updateIncTrfItem();
				} 	
				
			}else{
				var r = confirm("송치결과를 아래와 같이 등록하시겠습니까? \n송치결과수령일 : "+incTrfItemVO.trfRcptDt+"\n송치결과 : "+trfRstDesc);
				if (r == true) {
					incTrfItemVO.incTrfItemStatCd = "04"; //송치결과 수령
					incTrfItemVO.updStatYN = "Y";
					updateIncTrfItem();
				} 			
			}
		} else {
			incTrfItemVO.updStatYN = "N";
			updateIncTrfItem();
		}
		
	});	
		
	//유저와 타스크상태에 따른 버튼 활성화 처리
	handleBtnGroup();	
	
	//화면사이즈 갱신
	autoResize();	
	
	//수사결과가 가인 경우
	//if (incTrfItemStatCdLast == "04" && trfRstLast=="Y") {
	//수사결과가 가, 부 인경우에 모두 2018.11.20 수정
//	if (trfRstLast=="Y" || trfRstLast=="N") {
		$("#step3Area").show();
		$("#spItemDIV").show();
		initEditActionManager();
		//수사사건자료
		selectCriIncDta();
//	}else{
//		$("#step3Area").hide();
//	}
	
	//로딩플래그
	loadingFlag = true;	
	
	
}




//수사사건자료상세를 가져온다. 
function selectCriIncDta(){
	
	incTrfItemVO.criDtaCatgCd = CRI_DTA_CATG_CD; //송치자료
	goAjax("/sjpb/C/selectCriIncDta.face", incTrfItemVO, callBackSelectCriIncDtaSuccess);
}


//수사사건자료상세 콜백함수
function callBackSelectCriIncDtaSuccess(data) {
	
	//incTrfItemVO = data.incTrfItemVO;
	
	//2019.01.03 버그 수정 
	incTrfItemVO.criIncDtaVOList = data.incTrfItemVO.criIncDtaVOList;
	incTrfItemVO.criIncDtaFileVOList = data.incTrfItemVO.criIncDtaFileVOList;
	
	//수사자료 리스팅	
	renderDTTable(incTrfItemVO.criIncDtaFileVOList);
	
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
				,rcptNum : c0201VOMap.rcptNum
			}
		goAjax("/sjpb/Z/deleteFile.face", reqMap, callBackDeleteFileDataSuccess);
		
	}
	
}

//파일삭제 성공 콜백함수 
function callBackDeleteFileDataSuccess(data){
	
	//성공
	if(data.sjpbCriIncDtaFileVO.result == "01"){
		alert("파일이 삭제 되었습니다.");
		
		incTrfItemVO.criIncDtaFileVOList = data.criIncDtaFileVOList;
		incTrfItemVO.criIncDtaVOList = data.criIncDtaVOList;
		
		//작성서식 목록 새로고침
		renderDTTable(incTrfItemVO.criIncDtaFileVOList);
		
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
			if (($(this).attr("id") == "initBtn") || ($(this).attr("id") == "srchBtn") || ($(this).attr("id") == "fileBtn") ) {
				$(this).show();
			} else {
				$(this).hide();
			}
		});
	}	
}

//준비중인 송치부 삭제
function deleteReadyTrfBk(){
	var incTrfBkNumArr =[];
	
	if(confirm("선택한 송치부를 삭제하시겠습니까?") == true){
		for(var i = 1; i <= qcell.getRows("data"); i++){
			if(JSON.stringify(qcell.getCellLabel(i,0)) == "true"){
				
				if(qcell.getRowData(i).incTrfBkStatCd == "01"){
					incTrfBkNumArr.push(qcell.getRowData(i).incTrfBkNum);
				}else{
					alert("준비중인 송치부만 삭제 가능합니다.");
					return;
				}
			}
		}
		var incTrfBkNumArrMap ={
				"incTrfBkNumArr":incTrfBkNumArr
		}
		goAjaxDefault("/sjpb/C/deleteReadyTrfBk.face",incTrfBkNumArrMap,function(data){callBackFn_f_deleteReadyTrfBkSuccess(data,incTrfBkNumArr.length)});
	}else{
		return;
	}
}
//준비중인 송치부 삭제 성공 콜백함수
function callBackFn_f_deleteReadyTrfBkSuccess(data,len){
	if(data == len){
		alert("정상적으로 처리되었습니다.");	
	}else{
		alert("시스템 오류입니다. 관리자에게 문의하세요.");
	}
	pageInit();
}

//사건송치부 데이터맵
var c0201VOMap = {
	incTrfBkNum : ""        //사건송치부번호
	,incTrfBkPublYr : ""    //발행년도    
    ,trfProDt : ""		    //송치건의일
    ,respIncCmdOffi : ""    //담당사건송치 송치관
    ,respDppoCd : ""        //담당지점코드
    ,incTrfBkStatCd : ""    //사건송치부상태코드 01:준비중, 02:제출완료
	,regUserId : ""         //등록자
	,regDate : ""           //등록일자
	,updUserId : ""         //수정자
	,updDate : ""           //수정일자
	,nmKor : ""             //담당송치관 이름
	,respDppoDesc : ""      //관할지검명
	,incTrfBkStatDesc : ""  //상태코드설명
	,incTrfItemList : null  //사건송치건리스트
	,sjpbFileVOList : null  //송치자료파일
}

//검색조건
var c0201SCMap = {		
	respDppoCdSC : ""        //담당지점코드
   ,respTrfOffiSC : ""    //담당자
   ,trfProDtFromSC : ""   //송치일자 시작일자
   ,trfProDtToSC : ""     //송치일자 종료일자		
   ,rcptIncNumSC : "" //사건번호	   
   ,spNmSC : ""	//피의자
}

//리포트맵
var c0201RTMap = {		
}


//송치
var incTrfItemVO =  {		
	incTrfItemNum : ""  //사건송치건번호
	,rcptNum : ""          //접수번호
	,incTrfItemStatCd : "" //사건송치건상태코드 01:접수, 02:등록, 03:건의, 04:수령
	,incTrfBkNum : ""   //사건송치부번호	
	,trfTranDt : ""   //송치인계일
	,trfReqDt : ""    //송치접수일
	,trfRcptDt : ""   //송치수령일
	,reCmdYn : ""        //재송치여부
	,trfRst : ""      //송치결과
	,trfComn : ""     //송치의견
	,incCriNm : ""       //사건죄명
	,incSp : ""          //사건피의자
	,incArrtClsf : ""    //사건구속별
	,evidArtcYn : ""     //증거품유무
	,rcptIncNum : ""     //사건번호
	,trfProDt : ""	  //송치건의일
	,trfNum : ""      //송치번호	
	,updStatYN : ""       //상태변경유무	
	,regUserId : ""
	,regDate : ""
	,updUserId : ""
	,updDate : ""	
	,criIncDtaVOList : null  //수사사건자료	
	,sjpbFileVOList : null  //첨부파일	
}

//수현1220
//송치피의자별 아이템
var incTrfSpItemVO =  {		
		incTrfItemNum : ""  //사건송치건번호
		,rcptNum : ""          //접수번호
		,incTrfBkNum : ""   //사건송치부번호
		,criNm : ""       //사건죄명
		,incSpNum : ""          //피의자번호
		,spNm : ""          //피의자 이름
		,incArrtClsf : ""    //사건구속별
		,rcptIncNum : ""     //사건번호
		,regUserId : ""
		,updUserId : ""
		,incTrfSpItemVOList : null

}
