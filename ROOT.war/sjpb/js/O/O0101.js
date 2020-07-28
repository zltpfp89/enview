var listQcell;
var rowIdx=1;
$(document).ready(function(){

	//엑셀 다운로드
	$("#exceldown").click(function(){
		
		var properties = {
				filename: "사건조회이력현황",
				url: '/excelDownload.face',
				border: true, // border 처리
				headershow: true, // header 출력
				colwidth: true, // col의 width 'px' 적용
				huge: false //대용량 여부

			};
		listQcell.excelDownload(properties);
		
		
	  });
	
	//페이지 진입시 사건조회이력 출력시 성공함수 호출
	goAjaxDefault("/sjpb/O/selectList.face",O0101SCMap,callBackFn_o_selectListSuccess);
	
});

//사건조회이력 검색 리스트 화면 출력
function fn_o_selectList(){
	
	O0101SCMap={	//검색조건 세팅
			nmKorSc :  $("#o_searchList [name=nmKorSc]").val(),			//조회자 이름
			inqDtSc :  $("#o_searchList [name=inqDtSc]").val()			//조회일자
		}
	//사건조회이력 검색리스트 화면 성공함수 호출
	goAjaxDefault("/sjpb/O/selectList.face", O0101SCMap, callBackFn_o_selectListSuccess);
}

//사건조회이력 검색리스트 화면 성공함수
function callBackFn_o_selectListSuccess(data){	

	var QCELLProp = {
			"parentid" : "inqHist",
			"id" : "cell",
			"data" : {
				"input" : data.qCell
			},
			"rowheader" : "sequence",
			"selectmode": "row",
			"columns" : [ 
				{width: '20%',	key: 'histDivDesc',			title: ['이력구분'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize17'}},
				{width: '20%',	key: 'rcptIncNum',			title: ['사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize17'}},
				{width: '20%',	key: 'spNm',			title: ['피의자이름'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize17'}},
				{width: '20%',	key: 'nmKor',			title: ['조회자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize17'}},
				{width: '20%',	key: 'inqDt',			title: ['조회일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize17'}}
				],
		};
		QCELL.create(QCELLProp);
	
		listQcell = QCELL.getInstance("cell");
//		listQcell.bind("click", eventFn);

	
}

////통합피의자조회 셀클릭 이벤트
//function eventFn(e){
//	
//	// 선택한 인덱스 가져오기
//	if(rowIdx == null){
//		rowIdx = 1;//초기값 설정
//	}else{
//		rowIdx = listQcell.getIdx("row");	
//	}
//	//기존 체크박스 열번호
//	var pastchk = listQcell.getIdx("row","focus","previous") == -1?1:listQcell.getIdx("row","focus","previous");
//	
//	//기존 체크항목 해제
//	listQcell.removeRowStyle(pastchk);
//
//	//새로 선택한 행 스타일적용
//	listQcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
//	
//}



//초기화 함수
function fn_o_init(form){
	$("#"+form)[0].reset();
	//select 값 초기화
	$("#"+form).find("select").each(function() {
		$(this).find("option:eq(0)").prop("selected", true);
		$(this).prev('.txt').text($(this).find('option:selected').text());
	});	
	
	//검색맵 초기화
	O0101SCMap={
		nmKorSc : "",		//조회자이름
		inqDtSc : ""		//조회일자
	}	
}

var O0101SCMap={
	nmKorSc : "",		//조회자이름
	inqDtSc : ""		//조회일자
};

var O0101VOMap = {
		"inqHistSiNum" : "",
	    "histDiv" : "",
	    "histDivDesc" : "",
	    "rcptNum" : "",
	    "rcptIncNum" : "",
	    "incSpNum" : "",
	    "spNm" : "",
	    "inqUserId" : "",
	    "inqDt" : ""
};