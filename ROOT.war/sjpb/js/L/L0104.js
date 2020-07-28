$(function(){
	pageInit();
});

var qcell;     //조직관리리스트
var searchFlag = true; //조회여부

//화면 진입시 동작함
function pageInit(){
	
	//조직관리 화면(리스트)을 가져온다.	
	selectCriTmMngList();
	
	//이벤트바인딩
	eventSetup();
	
}

//이벤트처리
function eventSetup() {
	
	//검색조건 초기화
	$("#initBtn").on("click", function() {
		
		var searchArea = $("div.searchArea");		
		//input 값 초기화
		searchArea.find("input[type=text]").val("");
		
		//select 값 초기화
		searchArea.find("select").each(function() {
			$(this).find("option:eq(0)").prop("selected", true);
			$(this).prev('.txt').text($(this).find('option:selected').text());
		});
		
		//검색맵 초기화
		l0104SCMap = {
			pareTmIdSC : "1" //상위조직번호
		   ,criTmIdSC : "" //팀코드
		   ,criTmNmSC : "" //팀명
		   ,fdCdSC : "" //사건분야	 				
		}
		
	});
	
	//조건검색호출
	$("#srchBtn").on("click", function() {		
		selectCriTmMngList();
	});
	
	
	$(".searchArea input[type=text],.searchArea select").keypress(function(e){
		if(e.keyCode == 13){
			e.stopPropagation();
			selectCriTmMngList();
		}
	});
	
	
	//상세정보저장
	$("#saveDtsBtn, #saveFdCdBtn").on("click", function() {
		
		if (l0104VOMap.recdType == "U") {
			updateCriTmMngDts();
		} else {		
			insertCriTmMngDts();
		}
	});	
		
	//신규추가
	$("#addBtn").on("click", function() {		
		l0104VOMap = {		
				 criTmId : "0"
				,criTmNm : ""
				,pareTmId : ""
				,criTmDiv : l0104VOMap.criTmDiv
				,sortOrd : ""
				,criTmStat : "1"
				,regUserId : $("#userId").val() 
				,regDate : ""
				,updUserId : $("#userId").val()
				,updDate : ""	
				,pareCriTmDiv : ""
				,recdType : "I"	
				,beDt :""
				,edDt :""
				,InvstgStat : "1"
				,fdCdList : null	
			};
		
		var fdCdVOArray = new Array();
		$("input[name=fdCd]").each(function(index) {				
			var fdCdVO = {
				code : $(this).val()
				,codeTag1 : $(this).data('code-tag1').toString()
			}
			fdCdVOArray.push(fdCdVO);
		});	
		l0104VOMap.fdCdList = fdCdVOArray;		
		
		syncL0104VOPage();
		
		//상세정보 탭 선택
		$("#criTmDtsTab").trigger('click');
		
	});
	
}


//조직관리 화면(리스트)을 가져온다. 
function selectCriTmMngList(){
	
	//최소화 되어 있으면 검색중단
	if(!$('#sheet:visible').length) return;
	
	l0104SCMap.criTmNmSC = getFieldValue($("#criTmNmSC")); //팀명
	l0104SCMap.fdCdSC = getFieldValue($("#fdCdSC")); //사건분야
		
	goAjax("/sjpb/L/selectCriTmMngList.face", l0104SCMap, callBackSelectCriTmMngListSuccess)
	
}

//조직관리 화면(리스트) 콜백함수
function callBackSelectCriTmMngListSuccess(data) {
 
	  var QCELLProp = {
	     "parentid" : "sheet",
		 "id"		: "qcell",
		 "data"		: {"input" : data.qCell},
		 "selectmode": "cell",         
		 "columns"	: [	     	
	     	{width: '15%',	key: 'sortOrd',			title: ['정렬순서'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
		 	{width: '15%',	key: 'criTmId',			title: ['부서코드'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
		 	{width: '20%',	key: 'criTmNm',			title: ['이름'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},       	
		 	{width: '20%',	key: 'fdCdDesc',		title: ['분야'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
		 	{width: '15%',	key: 'criTmStatDesc',		title: ['활성화여부'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
		 	{width: '15%',	key: 'updDate',			title: ['수정일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
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
	 qcell = QCELL.getInstance("qcell");
	 qcell.bind("click", eventClickFn);
	 
	 //최초 로딩시
	 if (qcell.getRows("data") > 0) {
	   qcell.setRowStyle(1, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");		   
	   l0104VOMap = qcell.getRowData(1);
	   selectCriTmMngDts();		   
	 } 
 
}

//리스트 셀 클릭 이벤트 
function eventClickFn(e){
	
	var objQCell = e.data.target;
	
	//선택한 인덱스 가져오기
	var rowIdx = qcell.getIdx("row");
	var colIdx = qcell.getSelectedCol();

	qcell.removeRowStyle(qcell.getIdx("row","focus","previous") == -1?1:qcell.getIdx("row","focus","previous"));
	qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
		
	l0104VOMap = qcell.getRowData(rowIdx);
	
	searchFlag = false; //트리선택 비활성화
	$('#deptTree').jstree("deselect_all");
	$('#deptTree').jstree(true).select_node(l0104VOMap.criTmId);
	
	selectCriTmMngDts();

}

//조직관리 상세를 가져온다. 
function selectCriTmMngDts(){	
	goAjax("/sjpb/L/selectCriTmMngDts.face", l0104VOMap, callBackSelectCriTmMngDtsSuccess);	
}


//조직관리 화면(리스트) 콜백함수
function callBackSelectCriTmMngDtsSuccess(data) {
	$('#pareTmId').html("<option value=\"\">선택</option>");
	$.each(data.criTmPareList, function(index, criTmPare) {
		$('#pareTmId').append(new Option(criTmPare.criTmNm,criTmPare.criTmId));
	});	
	
	l0104VOMap.fdCdList = data.fdCdList;
	
	syncL0104VOPage();
	searchFlag = true;  //트리선택 활성화
}

//수사분야 선택가능 여부 확인
function chkFdCdSelection() {
	
	var retVal = true;
	
	$("input[name=fdCd]").each(function(index) {
		if ($(this).prop('checked')) {
			var fdTmId = $(this).data('code-tag1').toString();		
			if ((fdTmId != "") && (fdTmId != l0104VOMap.criTmId)) {
				alert("[" + $(this).data('code-name') + "] 분야은 이미 [" + tmMap.get(fdTmId) + "]에 지정된 수사분야입니다.");
				$(this).prop('checked', false);
				retVal = false;				
			}
		}
	});	
	return retVal;
	
}

//조직상세갱신 
function updateCriTmMngDts(){
	
	//비활성화인경우 모든 수사분야 해지
	if (getFieldValue($("#criTmStat")) == "0") {
		$("input[name=fdCd]").prop('checked', false);
	}
	
	//유효성 체크
	var chkObjs = $("#contents");
	if(!chkValidate.check(chkObjs, true)) return;	
	
	if(chkFdCdSelection()) {	
		
		syncL0104VOMap();	
		goAjax("/sjpb/L/updateCriTmMngDts.face", l0104VOMap, callBackUpdateCriTmMngDtsSuccess);
	}
	
}

//조직상세갱신 콜백함수
function callBackUpdateCriTmMngDtsSuccess(data) {
	alert("성공적으로 상세정보가 수정되었습니다.")
	selectCriTmMngList();
}

//조직추가 
function insertCriTmMngDts(){
	
	//유효성 체크
	var chkObjs = $("#contentsArea");
	if(!chkValidate.check(chkObjs, true)) return;
	if(!chkFdCdSelection()) return;
	
	syncL0104VOMap();
	goAjax("/sjpb/L/insertCriTmMngDts.face", l0104VOMap, callBackInsertCriTmMngDtsSuccess);
	
}

//조직추가 콜백함수
function callBackInsertCriTmMngDtsSuccess(data) {
	alert("성공적으로 조직정보가 추가되었습니다.")
	selectCriTmMngList();
}


//Map 데이터 갱신
function syncL0104VOMap() {
	
	
	l0104VOMap.criTmId = getFieldValue($("#criTmId"));
	l0104VOMap.criTmNm = getFieldValue($("#criTmNm"));
	l0104VOMap.pareTmId = getFieldValue($("#pareTmId"));
	l0104VOMap.criTmStat = getFieldValue($("#criTmStat"));
	l0104VOMap.sortOrd = getFieldValue($("#sortOrd"));
	l0104VOMap.pareTmId = getFieldValue($("#pareTmId"));
	l0104VOMap.updUserId = $("#userId").val();
	l0104VOMap.beDt = getFieldValue($("#beDt"));
	l0104VOMap.edDt = getFieldValue($("#edDt"));
	l0104VOMap.criTmDiv = getFieldValue($("#criTmDiv"));
	l0104VOMap.criYn = getFieldValue($("#criYn"));
	
	var fdCdVOArray = new Array();
	$("input[name=fdCd]").each(function(index) {	
		
		var fdCdVO = {
			code : $(this).val()
			,codeTag1 : setCodeTag($(this).prop('checked'), $(this).data('code-tag1').toString(), l0104VOMap.criTmId)
		}
		fdCdVOArray.push(fdCdVO);
	});	
	l0104VOMap.fdCdList = fdCdVOArray;
	
}

//코드값 결정
function setCodeTag(bCk,oldVal,newVal) {
	
	var retVal = "";
	if (bCk) { //체크 
		retVal = l0104VOMap.criTmId;
	} else { //체크해제
		if (oldVal == newVal) { //기존값과 동일한 경우는 사건분야해지
			retVal = "";
		} else {   //기존값과 다른 경우는 기존값 유지
			retVal = oldVal; 
		}
	}
	return retVal;
	
}


//화면갱신
function syncL0104VOPage() {
	
	setFieldValue($("#criTmId"), l0104VOMap.criTmId);//부서코드
	setFieldValue($("#criTmNm"), l0104VOMap.criTmNm);//이름
	setFieldValue($("#pareTmId"), l0104VOMap.pareTmId);//상위부서
	setFieldValue($("#criTmStat"), l0104VOMap.criTmStat);//사용여부
	setFieldValue($("#sortOrd"), l0104VOMap.sortOrd);//정렬순서
	setFieldValue($('#pareTmId'), l0104VOMap.pareTmId);//부모조직
	
	setFieldValue($('#beDt'), l0104VOMap.beDt);
	setFieldValue($('#edDt'), l0104VOMap.edDt);
	setFieldValue($('#criTmDiv'), l0104VOMap.criTmDiv);
	setFieldValue($('#criYn'), l0104VOMap.criYn);
	

	
	
	
	$.each(l0104VOMap.fdCdList, function(index, fdCd) {		
		
		if (fdCd.codeTag1 == l0104VOMap.criTmId) {
			$('#fdCd_'+fdCd.code).prop('checked', true);
		} else {
			$('#fdCd_'+fdCd.code).prop('checked', false);
		}
		$('#fdCd_'+fdCd.code).data("code-tag1", fdCd.codeTag1);
	});	
	
	//팀부터 추가
	if (l0104VOMap.recdType == "U") {
		$("#saveFdCdBtn").show();
	} else {	
		$("#saveFdCdBtn").hide();
	}
	
	//트리업데이트
	fn_drawTree();
	
}


//조직관리 데이터맵
var l0104VOMap = {		
	 criTmId : ""
	,criTmNm : ""
	,pareTmId : ""
	,criTmDiv : ""
	,sortOrd : ""
	,criTmStat : ""
	,regUserId : ""
	,regDate : ""
	,updUserId : ""
	,updDate : ""	
	,pareCriTmDiv : ""
	,recdType : ""	
	,beDt : ""
	,edDt : ""	
	,criYn : ""	
	,fdCdList : null	
}

//검색조건
var l0104SCMap = {
    pareTmIdSC : "1" //상위조직번호
   ,criTmIdSC :  "" //조직번호	
   ,criTmNmSC : "" //팀명
   ,fdCdSC : "" //사건분야	   
}
