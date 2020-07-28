$(function(){
	pageInit();
});

var qcell; //내사리스트


//화면 진입시 동작함
function pageInit(){
	
	//이벤트셋업
	eventSetup();
	
	//화면사이즈 갱신
	autoResize();
}

//이벤트처리
function eventSetup() {
		
	//검색 버튼 클릭
	$("#srchBtn").off("click").on("click", function() {		
		selectMigCriIncBkRawList();
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
			   ,prgsStep : ""    //단계
			   ,trgtDta : ""      //검증대상
			   ,incNum : "" //사건번호
			   ,incSiNum : "" //사건일련번호
		}
	});	
	
	
	
}




//이관리스트 
function selectMigCriIncBkRawList(){
	
	//최소화 되어 있으면 검색중단
	if(!$('#sheet:visible').length) return;
	
	x0101VOMap.baseYear = $("#baseYearSC").val();
	x0101VOMap.incNum = $("#incNumSC").val();
	x0101VOMap.incSiNum = $("#incSiNumSC").val();
	x0101VOMap.prgsStep = "";
	x0101VOMap.trgtDta = "";
	
	goAjax("/sjpb/X/selectMigCriIncBkRawList.face", x0101VOMap, callBackSelectMigCriIncBkRawListSuccess)
	
}

//이관리스트 콜백함수
function callBackSelectMigCriIncBkRawListSuccess(data) {
	
	 var QCELLProp = {
     "parentid" : "sheet",
     "id"		: "qcell",
     "data"		: {"input" : data.qCell},
     "selectmode": "cell",         
     "columns"	: [
    	
    	 {width: '100',	key: 'incSiNum',			title: ['사건일련번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'baseYear',			title: ['기준년도'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'rcptNum',			title: ['접수번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'incSpNum',			title: ['사건피의자번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'prgsStep',			title: ['진행단계'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'incFd',			title: ['사건분야'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'incNum',			title: ['사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'beDt',			title: ['수리일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'criTm',			title: ['수사팀'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'criRespMb',			title: ['수사담당자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'spNm',			title: ['피의자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'spCnt',			title: ['피의자수'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'spSsn',			title: ['주민번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'spAddr',			title: ['주소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'spBsnsNm',			title: ['업소명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'rltActCriNm',			title: ['관련법률및죄명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'vioCont',			title: ['위반내용'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'vioCla',			title: ['위반조항'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'criDt',			title: ['범죄일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'chaDoc',			title: ['고발서류'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'criPla',			title: ['범죄장소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'dvCau',			title: ['발각원인'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'chaItt',			title: ['고발기관'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'criCmdProDt',			title: ['수사지휘일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'cmdItt',			title: ['지휘기관'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'trfOp',			title: ['송치의견'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'trfDt',			title: ['송치일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'trfItt',			title: ['송치기관'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'trfRst',			title: ['송치결과'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'nsPi',			title: ['소요기간'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'poDipDt',			title: ['검찰처분일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'poDipRst',			title: ['검찰처분결과'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'dipCont',			title: ['처분내용'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'fnAmt',			title: ['벌금액'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'crlwNum',			title: ['형제번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'cortNum',			title: ['법원번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'fiDt',			title: ['확정일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'jdtCont',			title: ['판결내용'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'trilDt',			title: ['구공판일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
    	 {width: '100',	key: 'flyrDistSpCnt',			title: ['전단지배포피의자수'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}

    	 
    	 
     	]
     , "rowheaders": ["sequence"]
	 };
	 

	 
	 
 QCELL.create(QCELLProp);
 qcell = QCELL.getInstance("qcell");
 
 qcell.bind("click", eventFn);
 
 //최초 로딩시
 if (qcell.getRows("data") > 0) {
    //셀 선택 백그라운드 지정
	qcell.setRowStyle(1, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");   	 
    x0101VOMap = qcell.getRowData(1);	
    syncX0101VOPage();
 } 
 
 
}


//리스트 셀 클릭 이벤트 
function eventFn(e){
	
	//선택한 인덱스 가져오기
	var rowIdx = qcell.getIdx("row");
	
	//기존 체크항목 해제와 새로 선택한 행 체크박스 선택
	qcell.removeRowStyle(qcell.getIdx("row","focus","previous") == -1?1:qcell.getIdx("row","focus","previous"));
	qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
	
	//내사상세 호출
	if (rowIdx > 0) {		
		x0101VOMap = qcell.getRowData(rowIdx);
		syncX0101VOPage();
	}

}



//화면 갱신
function syncX0101VOPage() {

    $('#incSiNum').html(x0101VOMap.incSiNum);		
  	 $('#baseYear').html(x0101VOMap.baseYear);		
  	 $('#rcptNum').html(x0101VOMap.rcptNum);		
  	 $('#incSpNum').html(x0101VOMap.incSpNum);		
  	 $('#prgsStep').html(x0101VOMap.prgsStep);		
  	 $('#incFd').html(x0101VOMap.incFd);		
  	 $('#incNum').html(x0101VOMap.incNum);		
  	 $('#beDt').html(x0101VOMap.beDt);		
  	 $('#criTm').html(x0101VOMap.criTm);		
  	 $('#criRespMb').html(x0101VOMap.criRespMb);		
  	 $('#spNm').html(x0101VOMap.spNm);		
  	 $('#spCnt').html(x0101VOMap.spCnt);		
  	 $('#spSsn').html(x0101VOMap.spSsn);		
  	 $('#spAddr').html(x0101VOMap.spAddr);		
  	 $('#spBsnsNm').html(x0101VOMap.spBsnsNm);		
  	 $('#rltActCriNm').html(x0101VOMap.rltActCriNm);		
  	 $('#vioCont').html(x0101VOMap.vioCont);		
  	 $('#vioCla').html(x0101VOMap.vioCla);		
  	 $('#criDt').html(x0101VOMap.criDt);		
  	 $('#chaDoc').html(x0101VOMap.chaDoc);		
  	 $('#criPla').html(x0101VOMap.criPla);		
  	 $('#dvCau').html(x0101VOMap.dvCau);		
  	 $('#chaItt').html(x0101VOMap.chaItt);		
  	 $('#criCmdProDt').html(x0101VOMap.criCmdProDt);		
  	 $('#cmdItt').html(x0101VOMap.cmdItt);		
  	 $('#trfOp').html(x0101VOMap.trfOp);		
  	 $('#trfDt').html(x0101VOMap.trfDt);		
  	 $('#trfItt').html(x0101VOMap.trfItt);		
  	 $('#trfRst').html(x0101VOMap.trfRst);		
  	 $('#nsPi').html(x0101VOMap.nsPi);		
  	 $('#poDipDt').html(x0101VOMap.poDipDt);		
  	 $('#poDipRst').html(x0101VOMap.poDipRst);		
  	 $('#dipCont').html(x0101VOMap.dipCont);		
  	 $('#fnAmt').html(x0101VOMap.fnAmt);		
  	 $('#crlwNum').html(x0101VOMap.crlwNum);		
  	 $('#cortNum').html(x0101VOMap.cortNum);		
  	 $('#fiDt').html(x0101VOMap.fiDt);		
  	 $('#jdtCont').html(x0101VOMap.jdtCont);		
  	 $('#trilDt').html(x0101VOMap.trilDt);		
  	 $('#flyrDistSpCnt').html(x0101VOMap.flyrDistSpCnt);		
	
	
}

//데이터맵
var x0101VOMap = {
	baseYear : ""        //기준년도
   ,prgsStep : ""    //단계
   ,trgtDta : ""      //검증대상	
   ,incNum : ""  //사건번호
   ,incSiNum : "" //사건일련번호
}
