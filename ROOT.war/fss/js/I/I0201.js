$(function(){
	pageInit();
});

var qcellP;     //사건리스트

//화면 진입시 동작함
function pageInit(){
	
	//이벤트바인딩
	eventSetup();	
	
	selectIncSearchList();
	
}

//이벤트처리
function eventSetup() {
	
    $('#iframeContainer iframe').onload = function() {alert('myframe is loaded');};
	
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
		i0201SCMap = {
				criTmIdSC : ""       //담당수사팀			
				,beDtFromSC : ""      //착수일자(From)
				,beDtToSC : ""        //착수일자(To)	
				,rcptIncNumSC : ""      //사건번호
		}	
	});
	
	//조건검색호출
	$("#sechBtn").on("click", function() {
		selectIncSearchList();
	});	
	
	
	//확인버튼
	$("#cnfmBtn").on("click", function(e) {
			
		var selectedRowData = [];
		//기존 체크항목 해제와 새로 선택한 행 체크박스 선택
		for (var i=1; i<=qcellP.getRows("data"); i++) {
			if (qcellP.getCellData(i, 0)) {
				selectedRowData.push(qcellP.getRowData(i));
			}
		}		
		
		window.parent.commonLayerPopup.closeLayerPopup(selectedRowData);
		
	});	
	
	//닫기버튼
	$("#closBtn, img.btn_close").on("click", function() {
		window.parent.commonLayerPopup.closeLayerPopupOnly();
	});		
	
	
}

//리스트 셀 클릭 이벤트 
function eventFn(e){
	
	//선택한 인덱스 가져오기
	var rowIdx = qcellP.getIdx("row");
	
	if (qcellP.getIdx("col","click") > 0) {	
		qcellP.setCellData(rowIdx, 0, !qcellP.getCellData(rowIdx, 0));
	} else { //체크박스 선택시 처리
		qcellP.setCellData(rowIdx, 0, qcellP.getCellData(rowIdx, 0));
        for (var i = 0 ; i < qcellP.getCols(); i++) {
        	$("#cell_"+rowIdx+"_"+i).addClass("rt-qc-cell-select");
        }
	}

}





//사건리스트를 가져온다. 
var selectIncSearchList = function(){	
	//검색조건
	i0201SCMap.criTmIdSC = $('#criTmIdSC').val();
	if ($('#beDtFromSC').val() != "") {
		i0201SCMap.beDtFromSC = $('#beDtFromSC').val() + " 00:00:00";
	}
	if ($('#beDtToSC').val() != "") {
		i0201SCMap.beDtToSC = $('#beDtToSC').val() + " 23:59:59";
	}
	i0201SCMap.rcptIncNumSC = $('#rcptIncNumSC').val();
	
	goAjax("/sjpb/I/selectIncSearchList.face", i0201SCMap, callBackSelectIncSearchListSuccess)
	
}


//수사사건지휘부 화면(리스트) 콜백함수
function callBackSelectIncSearchListSuccess(data) {
	
	 var QCELLProp = {
     "parentid" : "sheetP",
     "id"		: "qcellP",
     "data"		: {"input" : data.qCell},
     "selectmode": "row",         
     "columns"	: [
     	{width: '5%',	key: 'checkbox',			title: [''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
     	{width: '10%',	key: 'rcptIncNum',			title: ['사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
     	{width: '10%',	key: 'beDt',			title: ['접수일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},     	
     	{width: '15%',	key: 'criTmNm',			title: ['담당수사팀'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
     	{width: '10%',	key: 'nmKor',			title: ['담당수사관'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
     	{width: '30%',	key: 'rltActCriNm',			title: ['관련법률및죄명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
     	{width: '20%',	key: 'spNm',			title: ['피의자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}, 	
     	]
 }; 

	 
 QCELL.create(QCELLProp);
 qcellP = QCELL.getInstance("qcellP");
 qcellP.bind("click", eventFn); 

}


//사건수사지휘부 데이터맵
var i0201VOMap = {		
	rcptNum : "" //접수번호
	,rcptIncNum : ""   //사건번호
	,beDt : ""   //접수일자
	,nmKor : ""  //담당수사관
	,rltActCriNm : "" //관련법률및죄명
	,spNm : ""   //피의자 이름
}

//검색조건
var i0201SCMap = {
	criTmIdSC : ""       //담당수사팀
   ,beDtFromSC : ""   //접수일자 시작일자
   ,beDtToSC : ""     //접수일자 종료일자	
   ,rcptIncNumSC : "" //사건번호		   
}
