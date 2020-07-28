$(function(){
	pageInit();
});

var qcell;     //통계원표리스트

//화면 진입시 동작함
function pageInit(){
	
	//통계원표 화면(리스트)을 가져온다.	
	selectStsGrapBkList();
	
	//이벤트바인딩
	eventSetup();
	
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
		i0101SCMap = {
		   rcptIncNumSC : "" //사건번호
		   ,spNmSC : "" //피의자	   
		   ,incCriNmSC : "" //위법조항	  
		   ,stsGrapFillDtFromSC : ""   //작성일자 시작일자
		   ,stsGrapFillDtToSC : ""     //작성일자 종료일자			   
		}	
	});
	
	//조건검색호출
	$("#srchBtn").off("click").on("click", function() {
		selectStsGrapBkList();
	});	
	
	//추가
	$("#addBtn").off("click").on("click", function() {		
		commonLayerPopup.openLayerPopup('/sjpb/I/I0201.face', "1000px", "475px", addNewStsGrapBkItem);		
	});
	
	//저장
	$("#saveBtn").off("click").on("click", function() {		
		syncStsGrapBkList();
		updateStsGrapBkList(); //통계원표 업데이트
	});
	
	//출력
	$("#prnBtn").off("click").on("click", function() {
		selectStsGrapBkReport();
	});
	
	//삭제
	$("#delBtn").off("click").on("click", function() {
		selectStsGrapBkLast();
	});	
	
	
	$(".searchArea input[type=text],.searchArea select").keypress(function(e){
		if(e.keyCode == 13){
			e.stopPropagation();
			selectStsGrapBkList();
		}
	});
	
}


//데이터 갱신
function syncStsGrapBkList() {
	if (qcell) {
		i0101VOMap.stsGrapBkVOList = qcell.getData();
	}
}


//통계원표 화면(리스트)을 가져온다. 
function selectStsGrapBkList(){
	
	//최소화 되어 있으면 검색중단
	if(!$('#sheet:visible').length) return;
	
	i0101SCMap.rcptIncNumSC = $("#rcptIncNumSC").val(); //사건번호
	i0101SCMap.spNmSC = $("#spNmSC").val();   //피의자
	i0101SCMap.incCriNmSC = $("#incCriNmSC").val();   //위법조항
	
	if ($('#stsGrapFillDtFromSC').val() != "") {
		i0101SCMap.stsGrapFillDtFromSC = $('#stsGrapFillDtFromSC').val() + " 00:00:00"; //작성일자 시작일자
	}
	if ($('#stsGrapFillDtToSC').val() != "") {
		i0101SCMap.stsGrapFillDtToSC = $('#stsGrapFillDtToSC').val() + " 23:59:59"; //작성일자 종료일자
	}
		
	goAjax("/sjpb/I/selectStsGrapBkList.face", i0101SCMap, callBackSelectStsGrapBkListSuccess)
	
}


//통계원표 화면(리스트) 콜백함수
function callBackSelectStsGrapBkListSuccess(data) {

	 var QCELLProp = {
       "parentid" : "sheet",
       "id"		: "qcell",
       "data"		: {"input" : data.qCell},
       "selectmode": "cell",         
       "columns"	: [
       	{width: '10%',	key: 'stsGrapFillDt',			title: ['작성일자','작성일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
       	{width: '10%',	key: 'rcptIncNum',			title: ['사건번호','사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},       	
       	{width: '10%',	key: 'spNm',			title: ['피의자','피의자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
       	{width: '20%',	key: 'incCriNm',			title: ['위법조항','위법조항'],		sort:true, move:true, resize: true, styleclassname: {data: 'align fontsize13'}},
       	{width: '10%',	key: 'occrStsGrapNum',			title: ['통계원표번호','발생'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},       	
       	{width: '10%',	key: 'arstStsGrapNum',			title: ['통계원표번호','검거'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},       	
       	{width: '10%',	key: 'spStsGrapNum',			title: ['통계원표번호','피의'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},       	
       	{width: '20%',	key: 'stsGrapComn',			title: ['비고','비고'], type:'input', options:{maxlength:50}, sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
       	]
       	, "merge": {"header": "rowandcol"}
   		, "rowheader"	: "sequence"
   }; 
	
   QCELL.create(QCELLProp);
   qcell = QCELL.getInstance("qcell");
   qcell.bind("click", eventClickFn);
   qcell.bind("dblclick", eventDblClickFn);
   
}

//통계원표 마스터 추가 
function insertStsGrapBkList(){	
	goAjax("/sjpb/I/insertStsGrapBkList.face", i0101VOMap, callBackInsertStsGrapBkSuccess);	
}


//통계원표 마스터 추가 콜백함수
function callBackInsertStsGrapBkSuccess(data) {
	
	alert("정상적으로 통계원표가 추가되었습니다.");
	selectStsGrapBkList(); //신규 호출
}

//통계원표 업데이트 
function updateStsGrapBkList(){
	goAjax("/sjpb/I/updateStsGrapBkList.face", i0101VOMap, callBackUpdateStsGrapBkListSuccess);	
}


//통계원표 업데이트 콜백함수
function callBackUpdateStsGrapBkListSuccess(data) {
	
	alert("정상적으로 저장되었습니다.");
	selectStsGrapBkList(); //신규 호출
}


//마지막 통계원표 가져오기
function selectStsGrapBkLast(){
	goAjax("/sjpb/I/selectStsGrapBkLast.face", i0101VOMap, callBackSelectStsGrapBkLastSuccess);	
}


//마지막 통계원표 가져오기함수 콜백
function callBackSelectStsGrapBkLastSuccess(data) {
	
	
	if (data.incNum != "") {	
		var r = confirm("등록된 마지막 사건번호["+data.incNum+"] 를 삭제하시겠습니까?");
		if (r == true) {
			deleteStsGrapBkLast();
		}	
	} else {
		alert("더 이상 삭제할 사건번호가 없습니다.");
	}
}

//마지막 통계원표 삭제 
function deleteStsGrapBkLast(){
	goAjax("/sjpb/I/deleteStsGrapBkLast.face", i0101VOMap, callBackDeleteStsGrapBkLastSuccess);	
}


//마지막 통계원표 콜백함수
function callBackDeleteStsGrapBkLastSuccess(data) {
	
	alert("사건번호 ["+data.incNum+"] 항목이 정상적으로 삭제되었습니다.");	
	selectStsGrapBkList(); //신규 호출
}


//리스트 셀 클릭 이벤트 
function eventClickFn(e){
	
	var objQCell = e.data.target;
	
	//선택한 인덱스 가져오기
	var rowIdx = qcell.getIdx("row");
	var colIdx = qcell.getSelectedCol();

	qcell.removeRowStyle(qcell.getIdx("row","focus","previous") == -1?1:qcell.getIdx("row","focus","previous"));
	qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");

}


//리스트 셀 클릭 이벤트 
function eventDblClickFn(e){
	
	var objQCell = e.data.target;
	
	//선택한 인덱스 가져오기
	var rowIdx = qcell.getIdx("row");
	var colIdx = qcell.getSelectedCol(); 
	var prevIdx = qcell.getIdx("row","focus","previous");


	if (colIdx == 8) {
		var rowData = qcell.getRowData(rowIdx);
		rowData.updStatYN = "Y";
		qcell.setRowData(rowIdx, rowData);
	}

}


//통계원표 (리포트)
function selectStsGrapBkReport(){

	//최소화 되어 있으면 검색중단
	if(!$('#sheet:visible').length) return;
	
	i0101SCMap.rcptIncNumSC = $("#rcptIncNumSC").val(); //사건번호
	i0101SCMap.spNmSC = $("#spNmSC").val();   //피의자
	i0101SCMap.incCriNmSC = $("#incCriNmSC").val();   //위법조항
	
	if ($('#stsGrapFillDtFromSC').val() != "") {
		i0101SCMap.stsGrapFillDtFromSC = $('#stsGrapFillDtFromSC').val() + " 00:00:00"; //작성일자 시작일자
	}
	if ($('#stsGrapFillDtToSC').val() != "") {
		i0101SCMap.stsGrapFillDtToSC = $('#stsGrapFillDtToSC').val() + " 23:59:59"; //작성일자 종료일자
	}	
	
	goAjax("/sjpb/I/selectStsGrapBkReport.face", i0101SCMap, callBackSelectStsGrapBkReportSuccess)	
}



//통계원표 화면(리포트) 콜백함수
function callBackSelectStsGrapBkReportSuccess(data) {
	i0101RTMap.rexdataset = data.rexdataset;
	
	var xmlString = objectToXml(i0101RTMap);
	
	$("#reptNm").val("I0101.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	
	//레포트 호출
	openReportService(reportForm);  

}


//검색을 통해서 신규사건을 추가한다.
function addNewStsGrapBkItem(data) {

	var itemList = [];
	var itemMap = {};
	$.each(data, function(i, item) {		
		itemList.push(item.rcptNum);		
	});
	
	i0101VOMap.rcptNumList = itemList;
	i0101VOMap.spTpCd = "2"; //피의자
	i0101VOMap.regUserId = $("#userId").val()
	i0101VOMap.updUserId = $("#userId").val()
	
	insertStsGrapBkList(); //신규항목 추가
	
}


//통계원표 데이터맵
var i0101VOMap = {	
	rcptNumList : null //접수번호리스트	
	,stsGrapBkVOList : null //통계원표리스트	
}


//통계원표 아이템 데이터맵
var stsGrapBkVOMap = {
	arstStsGrapNum: ""
	,incCriNm: ""
	,incSpNum: ""
	,occrStsGrapNum: ""
	,rcptIncNum: ""
	,rcptNum: ""
	,regDate: ""
	,regUserId: ""
	,spNm: ""
	,spStsGrapNum: ""
	,stsGrapComn: ""
	,stsGrapFillDt: ""
	,stsGrapSiNum: ""
	,stsGrapStatCd : "1"	
	,updDate: ""
	,updUserId: ""
}


//검색조건
var i0101SCMap = {
   rcptIncNumSC : "" //사건번호
  ,spNmSC : "" //피의자	   
  ,incCriNmSC : "" //위법조항	  
  ,stsGrapFillDtFromSC : ""   //작성일자 시작일자
  ,stsGrapFillDtToSC : ""     //작성일자 종료일자			   
}


//리포트맵
var i0101RTMap = {		
}
