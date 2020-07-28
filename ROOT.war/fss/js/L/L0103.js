var qcellPO;     //전문관관리리스트

//이벤트처리
function eventSetupPO() {
	
	//전문관관리 탭 클릭
	$("#profOffiTab").on("click", function() {		
				
		selectProfOffiMngList();
	});	
	
	//추가
	$("#newPOBtn").off("click").on("click", function() {	
		
		addNewProfOffiMngItem(); //신규유저추가	
	});
	
	//저장
	$("#saveBtnPO").off("click").on("click", function() {
		
		//유효성 체크
		var chkObjs = $("#contentsAreaM3");
		if(!chkValidate.check(chkObjs, true)) return;		
		
		syncL0103VOMap();
		
		if (l0103VOMap.recdType == "I") {
			insertProfOffiMngItem(); //신규항목추가	
		} else {
			updateProfOffiMngItem(); //신규항목추가
		}
	});
	
	//삭제
	$("#delBtnPO").off("click").on("click", function() {
		deleteProfOffiMngItem(); //삭제
	});

	
}



//인사관리 화면(리스트)을 가져온다. 
function selectProfOffiMngList(){	
			
	//최소화 되어 있으면 검색중단
	if(!$('#sheetPO:visible').length) return;
		
	goAjax("/sjpb/L/selectProfOffiMngList.face", l0103VOMap, callBackSelectProfOffiMngListSuccess)
	
}


//인사관리 화면(리스트) 콜백함수
function callBackSelectProfOffiMngListSuccess(data) {
	
     var QCELLProp = {
		 "parentid" : "sheetPO",
		 "id"		: "qcellPO",
		 "data"		: {"input" : data.qCell},
		 "selectmode": "cell",         
		 "columns"	: [
	    		    	   
     	{width: '25%',	key: 'criTmNm',			title: ['수사팀'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},     	       	
     	{width: '15%',	key: 'criMbClasDesc',			title: ['직급'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
     	{width: '15%',	key: 'criMbPosiDesc',			title: ['직위'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
     	{width: '15%',	key: 'criMbSrocDesc',			title: ['직렬'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},      	
     	{width: '15%',	key: 'carrBeDt',			title: ['시작일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
     	{width: '15%',	key: 'carrEdDt',			title: ['종료일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},     	
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
	 qcellPO = QCELL.getInstance("qcellPO");
	 qcellPO.bind("click", eventClickPOFn);
	 
	 //최초 로딩시
	 if (qcellPO.getRows("data") > 0) {
		   qcellPO.setRowStyle(1, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");	  
		   l0103VOMap = qcellPO.getRowData(1);
		 
	 } else {
		 
			l0103VOMap = {
					carrMngSiNum : ""
					,criMbId : l0101VOMap.criMbId
					,criTmId : ""
					,carrMngDiv : "2"  //1:경력, 2:전문관
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
	 
	 syncL0103VOPage();
 
}

//리스트 셀 클릭 이벤트 
function eventClickPOFn(e){
	
	var objQCell = e.data.target;
	
	//선택한 인덱스 가져오기
	var rowIdx = qcellPO.getIdx("row");
	var colIdx = qcellPO.getSelectedCol();

	qcellPO.removeRowStyle(qcellPO.getIdx("row","focus","previous") == -1?1:qcellPO.getIdx("row","focus","previous"));
	qcellPO.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
		
	l0103VOMap = qcellPO.getRowData(rowIdx);
	syncL0103VOPage();

}


//경력관리 신규 추가
function insertProfOffiMngItem() {
	
	goAjax("/sjpb/L/insertProfOffiMngItem.face", l0103VOMap, callBackInsertProfOffiMngItemSuccess);
}


//경력관리 신규 추가 콜백함수
function callBackInsertProfOffiMngItemSuccess(data) {		
		
	console.log(JSON.stringify(data));	
	alert("정상적으로 신규 전문관 경력이 추가되었습니다.");
	selectProfOffiMngList();
}

//경력관리 갱신
function updateProfOffiMngItem() {
	
	goAjax("/sjpb/L/updateProfOffiMngItem.face", l0103VOMap, callBackUpdateProfOffiMngItemSuccess);
}

//경력관리 갱신 콜백함수
function callBackUpdateProfOffiMngItemSuccess(data) {		
		
	console.log(JSON.stringify(data));
	alert("정상적으로 전문관 경력이 수정되었습니다.");
	selectProfOffiMngList();
}


//경력관리 갱신
function deleteProfOffiMngItem() {
	
	goAjax("/sjpb/L/deleteProfOffiMngItem.face", l0103VOMap, callBackDeleteProfOffiMngItemSuccess);
}

//경력관리 갱신 콜백함수
function callBackDeleteProfOffiMngItemSuccess(data) {		
		
	console.log(JSON.stringify(data));
	alert("정상적으로 전문관 경력이 삭제되었습니다.");
	selectProfOffiMngList();
}


//화면 갱신
function syncL0103VOPage() {
	
	//맵존재확인
	checkl0103VOMap();	
	
	var diffInDays = 0;
	for (var i=1; i<=qcellPO.getRows("data"); i++) {
		diffInDays += parseInt(qcellPO.getRowData(i).diffInDays);
	}
	
	$("#totlPOSpan").html(humanise(diffInDays));
	

	setFieldValue($("select[name=criTmIdPO]"), l0103VOMap.criTmId);
	setFieldValue($("select[name=criMbSrocPO]"), l0103VOMap.criMbSroc);
	setFieldValue($("select[name=criMbClasPO]"), l0103VOMap.criMbClas);
	setFieldValue($("select[name=criMbPosiPO]"), l0103VOMap.criMbPosi);		
	setFieldValue($("input[name=carrPOBeDt]"), l0103VOMap.carrBeDt);
	setFieldValue($("input[name=carrPOEdDt]"), l0103VOMap.carrEdDt);

	
}


//맵 갱신
function syncL0103VOMap() {
	
	//맵존재확인
	checkl0103VOMap();

	l0103VOMap.criTmId = getFieldValue($("select[name=criTmIdPO]"));
	l0103VOMap.criMbSroc = getFieldValue($("select[name=criMbSrocPO]"));
	l0103VOMap.criMbClas = getFieldValue($("select[name=criMbClasPO]"));
	l0103VOMap.criMbPosi = getFieldValue($("select[name=criMbPosiPO]"));		
	l0103VOMap.carrBeDt = getFieldValue($("input[name=carrPOBeDt]"));
	l0103VOMap.carrEdDt = getFieldValue($("input[name=carrPOEdDt]"));
	
}


//신규아이템 추가
function addNewProfOffiMngItem() {
	
	l0103VOMap = {
			carrMngSiNum : ""
			,criMbId : l0101VOMap.criMbId
			,criTmId : ""
			,carrMngDiv : "2" //1:경력, 2:전문관
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
	
	qcellPO.addRow(l0103VOMap);
	syncL0103VOPage();
	
}

//맵초기화
function checkl0103VOMap() {
	if (l0103VOMap == undefined) {
		l0103VOMap = {
			carrMngSiNum : ""
			,criMbId : l0101VOMap.criMbId
			,criTmId : ""
			,carrMngDiv : "2"  //1:경력, 2:전문관
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
var l0103VOMap = {
		carrMngSiNum : ""
		,criMbId : l0101VOMap.criMbId
		,criTmId : ""
		,carrMngDiv : "2"  //1:경력, 2:전문관
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


