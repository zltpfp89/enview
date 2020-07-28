$(function(){
	pageInit();
});

var qcell; //내사리스트


//화면 진입시 동작함
function pageInit(){
	
	//이벤트셋업
	eventSetup();
	
	//사건리스트가져오기
	selectMigCriIncBkDtaList();
	
	//화면사이즈 갱신
	autoResize();
}

//이벤트처리
function eventSetup() {
		
	//검색 버튼 클릭
	$("#srchBtn").off("click").on("click", function() {		
		selectMigCriIncBkDtaList();
	});	
	
	
	//initBtn
	//초기화버튼
	$("#initBtn").off("click").on("click", function() {	
		var searchArea = $(".searchArea");		
		//input 값 초기화
		searchArea.find("input[type=text]").val("");
		
		//select 값 초기화
		searchArea.find("select").each(function() {
			$(this).find("option:eq(0)").prop("selected", true);
			$(this).prev('.txt').text($(this).find('option:selected').text());
		});
		
		x0101VOMap = {
				baseYear : ""        //기준년도
			   ,prgsStep : "0"    //단계
			   ,trgtDta : "I"      //검증대상	   
		}
	});	
	
	
	//신규 버튼 클릭
	$("#addBtn").off("click").on("click", function() {		
		insertMigCriIncBkDtaList();
	});
	
	//갱신 버튼 클릭
	$("#updBtn").off("click").on("click", function() {		
		updateMigCriIncBkDtaList();
	});			
	
	//임시 버튼 클릭
	$("#tmpBtn").off("click").on("click", function() {		
		processMigCriIncBkDtaList();
	});		
	
}


//이관갱신 
function processMigCriIncBkDtaList(){
	
	//최소화 되어 있으면 검색중단
	if(!$('#sheet:visible').length) return;
	
	x0101VOMap.baseYear = $("#baseYearSC").val();
	x0101VOMap.prgsStep = $("#prgsStepSC").val();
	x0101VOMap.trgtDta = $("#trgtDtaSC").val();
	
	goAjax("/sjpb/X/processMigCriIncBkDtaList.face", x0101VOMap, callBackUpdateMigCriIncBkDtaListSuccess);
	
}

//이관갱신 콜백함수
function callBackProcessMigCriIncBkDtaListSuccess(data) {
	alert("사건 갱신 완료했습니다.");
}



//신규이관 
function insertMigCriIncBkDtaList(){
	
	//최소화 되어 있으면 검색중단
	if(!$('#sheet:visible').length) return;
	
	x0101VOMap.baseYear = $("#baseYearSC").val();
	x0101VOMap.prgsStep = $("#prgsStepSC").val();
	x0101VOMap.trgtDta = $("#trgtDtaSC").val();
	
	goAjax("/sjpb/X/insertMigCriIncBkDtaList.face", x0101VOMap, callBackInsertMigCriIncBkDtaListSuccess);
	
}

//신규이관 콜백함수
function callBackInsertMigCriIncBkDtaListSuccess(data) {
	alert("신규사건 추가 완료했습니다.");
}



//이관갱신 
function updateMigCriIncBkDtaList(){
	
	//최소화 되어 있으면 검색중단
	if(!$('#sheet:visible').length) return;
	
	x0101VOMap.baseYear = $("#baseYearSC").val();
	x0101VOMap.prgsStep = $("#prgsStepSC").val();
	x0101VOMap.trgtDta = $("#trgtDtaSC").val();
	
	goAjax("/sjpb/X/updateMigCriIncBkDtaList.face", x0101VOMap, callBackUpdateMigCriIncBkDtaListSuccess);
	
}

//이관갱신 콜백함수
function callBackUpdateMigCriIncBkDtaListSuccess(data) {
	alert("사건 갱신 완료했습니다.");
}



//이관리스트 
function selectMigCriIncBkDtaList(){
	
	//최소화 되어 있으면 검색중단
	if(!$('#sheet:visible').length) return;
	
	x0101VOMap.baseYear = $("#baseYearSC").val();
	x0101VOMap.prgsStep = $("#prgsStepSC").val();
	x0101VOMap.trgtDta = $("#trgtDtaSC").val();
	
	
	
	goAjax("/sjpb/X/selectMigCriIncBkDtaList.face", x0101VOMap, callBackSelectMigCriIncBkDtaListSuccess)
	
}

//이관리스트 콜백함수
function callBackSelectMigCriIncBkDtaListSuccess(data) {
	
	var QCELLProp = {};
	
	//사건
	if (x0101VOMap.trgtDta == "I") {
	
	 QCELLProp = {
     "parentid" : "sheet",
     "id"		: "qcell",
     "data"		: {"input" : data.qCell},
     "selectmode": "cell",         
     "columns"	: [
    	{width: '100',	key: 'rcptNum',			title: ['접수번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
		{width: '100',	key: 'rcptIncNum',			title: ['사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
		{width: '100',	key: 'rcptTpCd',			title: ['접수유형코드'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
		{width: '100',	key: 'criStatCd',			title: ['수사상태코드'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
		{width: '100',	key: 'fdCd',			title: ['사건분야코드'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
		{width: '100',	key: 'criTmId',			title: ['수사팀'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
		{width: '100',	key: 'dvForm',			title: ['발각형태'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
		{width: '100',	key: 'beDt',			title: ['착수일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
		{width: '100',	key: 'edDt',			title: ['종결일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
		{width: '100',	key: 'pareRcptNum',			title: ['부모접수번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
		{width: '100',	key: 'combIncYn',			title: ['병합사건여부'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
		{width: '100',	key: 'infwDiv',			title: ['유입구분'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
		{width: '100',	key: 'chaDt',			title: ['입건일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
		{width: '100',	key: 'chaItt',			title: ['고발기간'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
		{width: '100',	key: 'incOccrAreaAddr',			title: ['사건발생지'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
		{width: '100',	key: 'crlwNum',			title: ['형제번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
		{width: '100',	key: 'poDipDt',			title: ['검찰처분일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
		{width: '100',	key: 'jdtFiDt',			title: ['판결확정일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
		
     	]
     , "rowheaders": ["sequence"]
	 };
	 
	} else if (x0101VOMap.trgtDta == "P") {  //피의자
		
		
		QCELLProp = {
			     "parentid" : "sheet",
			     "id"		: "qcell",
			     "data"		: {"input" : data.qCell},
			     "selectmode": "cell",         
			     "columns"	: [		
			    	 {width: '100',	key: 'incSpNum',			title: ['피의자번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			    	 {width: '100',	key: 'spTpCd',			title: ['피의자유형'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},			    	 
			    	 {width: '300',	key: 'spIdNum',			title: ['피의자식별코드'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			    	 {width: '100',	key: 'indvCorpDiv',			title: ['개인법인구분'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			    	 {width: '100',	key: 'homcForcPernDiv',			title: ['내외국인구분'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			    	 {width: '100',	key: 'gendDiv',			title: ['성별'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			    	 {width: '300',	key: 'spNm',			title: ['피의자명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			    	 {width: '300',	key: 'spAddr',			title: ['주소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},			    	 
			    	 {width: '200',	key: 'spBsnsNm',			title: ['업소명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			    	 {width: '100',	key: 'spStatCd',			title: ['상태코드'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},			    	 
			     	]
			     , "rowheaders": ["sequence"]
				 };
		
	} else if (x0101VOMap.trgtDta == "V") {  //법률위반
		
		
		QCELLProp = {
			     "parentid" : "sheet",
			     "id"		: "qcell",
			     "data"		: {"input" : data.qCell},
			     "selectmode": "cell",         
			     "columns"	: [
			    	 {width: '10%',	key: 'rltActCriNmCd',			title: ['관련법률코드'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			    	 {width: '60%',	key: 'rltActCriNmCdDesc',			title: ['관련법률코드설명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},			    	 
			    	 {width: '30%',	key: 'vioCont',			title: ['위반내용'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},			    	 			    	 
			     	]
			     , "rowheaders": ["sequence"]
				 };
		
	} else if (x0101VOMap.trgtDta == "D") {  //사건처분결과
	
		QCELLProp = {
			     "parentid" : "sheet",
			     "id"		: "qcell",
			     "data"		: {"input" : data.qCell},
			     "selectmode": "cell",         
			     "columns"	: [
			    	 {width: '10%',	key: 'poContCd',			title: ['검찰내용'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			    	 {width: '60%',	key: 'dipCont',			title: ['처분내용'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},			    	 
			    	 {width: '30%',	key: 'fnAmt',			title: ['벌금액'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},			    	 			    	 
			     	]
			     , "rowheaders": ["sequence"]
				 };
		
	} else if (x0101VOMap.trgtDta == "J") {  //사건판결결과
		

		QCELLProp = {
			     "parentid" : "sheet",
			     "id"		: "qcell",
			     "data"		: {"input" : data.qCell},
			     "selectmode": "cell",         
			     "columns"	: [
			    	 {width: '50%',	key: 'jdtCont',			title: ['판결내용'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			    	 {width: '50%',	key: 'jdtOp',			title: ['판결의견'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},		    	 
			    	 			    	 			    	 
			     	]
			     , "rowheaders": ["sequence"]
				 };
		
	} else if (x0101VOMap.trgtDta == "M") {  //수사관
		

		QCELLProp = {
			     "parentid" : "sheet",
			     "id"		: "qcell",
			     "data"		: {"input" : data.qCell},
			     "selectmode": "cell",         
			     "columns"	: [
			    	 {width: '25%',	key: 'criTmNm',			title: ['수사팀명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			    	 {width: '25%',	key: 'criTmId',			title: ['수사팀계정'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			    	 {width: '25%',	key: 'nmKor',			title: ['수사담당자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			    	 {width: '25%',	key: 'criMbId',			title: ['계정'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			     	]
			     , "rowheaders": ["sequence"]
				 };
		
	} 
	 
	 
 QCELL.create(QCELLProp);
 qcell = QCELL.getInstance("qcell");
 
}



//데이터맵
var x0101VOMap = {
	baseYear : ""        //기준년도
   ,prgsStep : ""    //단계
   ,trgtDta : ""      //검증대상	   
}
