var qcellCR;     //경력관리리스트

//이벤트처리
function eventSetupCR() {
	
	//경력관리 탭 클릭
	$("#criMbCarrTab").on("click", function() {		
		selectCarrMngList();
	});	
	
	//추가
	$("#newCRBtn").off("click").on("click", function() {		
		addNewCarrMngItem(); //신규유저추가	
	});
	
	//저장
	$("#saveBtnCR").off("click").on("click", function() {
		
		//유효성 체크
		var chkObjs = $("#contentsAreaM2");
		if(!chkValidate.check(chkObjs, true)) return;		
		
		syncL0102VOMap();
		
		if (l0102VOMap.recdType == "I") {
			insertCarrMngItem(); //신규항목추가	
		} else {
			updateCarrMngItem(); //신규항목추가
		}
	});
	
	//삭제
	$("#delBtnCR").off("click").on("click", function() {
		deleteCarrMngItem(); //삭제		
	});
	
}


//인사관리 화면(리스트)을 가져온다. 
function selectCarrMngList(){
		
	//최소화 되어 있으면 검색중단
	if(!$('#sheetCR:visible').length) return;
		
	goAjax("/sjpb/L/selectCarrMngList.face", l0102VOMap, callBackSelectCarrMngListSuccess)
	
}


//인사관리 화면(리스트) 콜백함수
function callBackSelectCarrMngListSuccess(data) {
	
     var QCELLProp = {
		 "parentid" : "sheetCR",
		 "id"		: "qcellCR",
		 "data"		: {"input" : data.qCell},
		 "selectmode": "cell",         
		 "columns"	: [	    		    	   
     	{width: '25%',	key: 'criTmNm',			title: ['수사팀'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},     	       	
     	{width: '15%',	key: 'criMbClasDesc',			title: ['직급'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
     	{width: '15%',	key: 'criMbPosiDesc',			title: ['직위'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
     	{width: '15%',	key: 'criMbSrocDesc',			title: ['직렬'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},      	
     	{width: '15%',	key: 'carrBeDt',			title: ['전입일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
     	{width: '15%',	key: 'carrEdDt',			title: ['전출일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},     	
     	]
         , "rowheaders": ["sequence"]
		 /*
   		 , "pagination":
         {
             "unitlist": [5, 10, 20, 30, 40, 50, 100, 150]
           , "pageunit": 5
           , "pagecount": 10
           , "mode": 'extend'
           , "extendmove": true
         } 
         */  	
  	 };
	
	 QCELL.create(QCELLProp);
	 qcellCR = QCELL.getInstance("qcellCR");
	 qcellCR.bind("click", eventClickCRFn);
	 
	 //최초 로딩시
	 if (qcellCR.getRows("data") > 0) {
		   qcellCR.setRowStyle(1, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");	  
		   l0102VOMap = qcellCR.getRowData(1);
		 
	 } else {
		 
			l0102VOMap = {
					carrMngSiNum : ""
					,criMbId : l0101VOMap.criMbId
					,criTmId : ""
					,carrMngDiv : "1" //1:경력, 2:전문관
					,criMbPosi : ""
					,criMbClas : ""
					,criMbSroc : ""
					,carrBeDt : ""
					,carrEdDt : ""
					,regUserId : $("#userId").val()
					,regDate : ""
					,updUserId : $("#userId").val()
					,updDate : ""
					,criTmNm : ""
					,criMbClasDesc : ""		
					,criMbPosiDesc : ""
					,criMbSrocDesc : ""
					,recdType : "I"						
				}
			
	 } 
	 
	 syncL0102VOPage();
 
}

//리스트 셀 클릭 이벤트 
function eventClickCRFn(e){
	
	var objQCell = e.data.target;
	
	//선택한 인덱스 가져오기
	var rowIdx = qcellCR.getIdx("row");
	var colIdx = qcellCR.getSelectedCol();

	qcellCR.removeRowStyle(qcellCR.getIdx("row","focus","previous") == -1?1:qcellCR.getIdx("row","focus","previous"));
	qcellCR.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
		
	l0102VOMap = qcellCR.getRowData(rowIdx);
	syncL0102VOPage();

}


//경력관리 신규 추가
function insertCarrMngItem() {
	
	goAjax("/sjpb/L/insertCarrMngItem.face", l0102VOMap, callBackInsertCarrMngItemSuccess);
}


//경력관리 신규 추가 콜백함수
function callBackInsertCarrMngItemSuccess(data) {		
	alert("정상적으로 신규 경력이 추가되었습니다.");
	selectCarrMngList();
}

//경력관리 갱신
function updateCarrMngItem() {
	
	goAjax("/sjpb/L/updateCarrMngItem.face", l0102VOMap, callBackUpdateCarrMngItemSuccess);
}

//경력관리 갱신 콜백함수
function callBackUpdateCarrMngItemSuccess(data) {		
	alert("정상적으로 경력이 수정되었습니다.");
	selectCarrMngList();
}


//경력관리 삭제
function deleteCarrMngItem() {
	
	goAjax("/sjpb/L/deleteCarrMngItem.face", l0102VOMap, callBackDeleteCarrMngItemSuccess);
}

//경력관리 삭제 콜백함수
function callBackDeleteCarrMngItemSuccess(data) {		
	alert("정상적으로 경력이 삭제되었습니다.");
	selectCarrMngList();
}


//화면 갱신
function syncL0102VOPage() {
	
	//맵존재확인
	checkl0102VOMap();
	
	var diffInDays = 0;
	for (var i=1; i<=qcellCR.getRows("data"); i++) {
		diffInDays += parseInt(qcellCR.getRowData(i).diffInDays);
	}
	
	$("#totlCarrSpan").html(humanise(diffInDays));
	

	setFieldValue($("select[name=criTmIdCR]"), l0102VOMap.criTmId);
	setFieldValue($("select[name=criMbSrocCR]"), l0102VOMap.criMbSroc);
	setFieldValue($("select[name=criMbClasCR]"), l0102VOMap.criMbClas);
	setFieldValue($("select[name=criMbPosiCR]"), l0102VOMap.criMbPosi);		
	setFieldValue($("input[name=carrBeDt]"), l0102VOMap.carrBeDt);
	setFieldValue($("input[name=carrEdDt]"), l0102VOMap.carrEdDt);

	
}


//맵 갱신
function syncL0102VOMap() {
	
	//맵존재확인
	checkl0102VOMap();	

	l0102VOMap.criTmId = getFieldValue($("select[name=criTmIdCR]"));
	l0102VOMap.criMbSroc = getFieldValue($("select[name=criMbSrocCR]"));
	l0102VOMap.criMbClas = getFieldValue($("select[name=criMbClasCR]"));
	l0102VOMap.criMbPosi = getFieldValue($("select[name=criMbPosiCR]"));		
	l0102VOMap.carrBeDt = getFieldValue($("input[name=carrBeDt]"));
	l0102VOMap.carrEdDt = getFieldValue($("input[name=carrEdDt]"));
	
}


//신규아이템 추가
function addNewCarrMngItem() {
	
	l0102VOMap = {
			carrMngSiNum : ""
			,criMbId : l0101VOMap.criMbId
			,criTmId : ""
			,carrMngDiv : "1" //1:경력, 2:전문관
			,criMbPosi : ""
			,criMbClas : ""
			,criMbSroc : ""
			,carrBeDt : ""
			,carrEdDt : ""
			,regUserId : $("#userId").val()
			,regDate : ""
			,updUserId : $("#userId").val()
			,updDate : ""
			,criTmNm : "신규작성"
			,criMbClasDesc : ""		
			,criMbPosiDesc : ""
			,criMbSrocDesc : ""
			,recdType : "I"						
		}
	
	qcellCR.addRow(l0102VOMap);
	syncL0102VOPage();
	
}

//맵초기화
function checkl0102VOMap() {
	if (l0102VOMap == undefined) {
		l0102VOMap = {
			carrMngSiNum : ""
			,criMbId : l0101VOMap.criMbId
			,criTmId : ""
			,carrMngDiv : "1"  //1:경력, 2:전문관
			,criMbPosi : ""
			,criMbClas : ""
			,criMbSroc : ""
			,carrBeDt : ""
			,carrEdDt : ""
			,regUserId : $("#userId").val()
			,regDate : ""
			,updUserId : $("#userId").val()
			,updDate : ""
			,recdType : "I"	
		}
	}	
}

//경력관리
var l0102VOMap = {
	carrMngSiNum : ""
	,criMbId : l0101VOMap.criMbId
	,criTmId : ""
	,carrMngDiv : "1"  //1:경력, 2:전문관
	,criMbPosi : ""
	,criMbClas : ""
	,criMbSroc : ""
	,carrBeDt : ""
	,carrEdDt : ""
	,regUserId : $("#userId").val()
	,regDate : ""
	,updUserId : $("#userId").val()
	,updDate : ""
	,recdType : "I"	
}


