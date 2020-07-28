var queryString;
var spQcell;
var qcell;
var insert;
var rowIdx=1;
//리포트맵
var e0101RTMap = {
	rexdataset : null
}

$(document).ready(function(){
	fn_e_pageInit();
	
	//신규버튼 클릭시 팝업창 호출
	$("#addBtn").off("click").on("click", function() {	
		commonLayerPopup.openLayerPopup('/sjpb/E/E0301.face', "1050px", "550px", fn_e_pageInit);		
	});
        
});
			
//화면 진입시 동작함
function fn_e_pageInit(){
	queryString ="{}";
	//수기수사자료표 성공함수 호출
	goAjaxDefault("/sjpb/E/selectList.face", queryString, callBackFn_e_selectListSuccess);
}
//수기수사자료표 화면(리스트) 성공함수 (ajax)
function callBackFn_e_selectListSuccess(data){
	var QCELLProp = {
            "parentid" : "sheet",
            "id"		: "cell",
            "data"		: {"input" : data.qCell},
            "rowheader" : "sequence",
            "selectmode": "row",
            "columns"	: [
            	{width: '5%',	key: 'checkbox',			title: [''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '10%',	key: 'spNm',			title: ['성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '15%',	key: 'spIdNum',			title: ['주민등록번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '15%',	key: 'regDate',			title: ['작성일자(피신일자)'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '15%',	key: 'rltActCrinmCdDesc',			title: ['죄명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '10%',	key: 'dvformDesc',			title: ['발견여부'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '15%',	key: 'nmKor',			title: ['담당수사관'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '15%',	key: 'dtaTabComn',			title: ['비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}	                	
            ],
			"frozencols" : 5,
        };
	 	QCELL.create(QCELLProp);
	 	qcell = QCELL.getInstance("cell");	
	 	
	 	//비고칸 클릭시 이벤트 바인딩
	 	qcell.bind("click",eventFn);
	 	qcell.setRowStyle(1, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
		if(qcell.getRowData(1) != null){
		 	if(qcell.getRowData(1).respCriOffi == document.e_searchList.userId.value){
				$("#deleteBtn").show();
			}
		}
}
//수기수사자료표 출력
function fn_e_prnHawrReport() {
	//수기수사자료표 검색 리스트 레포트 성공함수 호출
	goAjaxDefault("/sjpb/E/selectList.face", queryString, callBackFn_e_selectHawrReportSuccess);	
}

//수기수사자료표 검색 리스트 레포트 성공함수
function callBackFn_e_selectHawrReportSuccess(data) {
	
	e0101RTMap.rexdataset = data.qCell;
	
	var xmlString = objectToXml(e0101RTMap);
	
	$("#reptNm").val("E0101.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	//레포트 호출
	openReportService(reportForm);  
	
}

//리스트 셀 클릭 이벤트
function eventFn(e){
	//선택한 행,열 인덱스 가져오기
	if(rowIdx == null){
		rowIdx = 1;//초기값 설정
	}else{
		rowIdx = qcell.getIdx("row");	
	}
	var colIdx = qcell.getIdx("col");
	//기존 체크박스 열번호
	var pastchk = qcell.getIdx("row","focus","previous") == -1?1:qcell.getIdx("row","focus","previous");
	
	//기존 체크항목 스타일 제거
	qcell.removeRowStyle(pastchk);
		
	//새로 선택한 행 스타일 적용
	qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
	
	//담당수사관과 내계정이 같을때 삭제버튼 활성화
	if(document.e_searchList.userId.value == qcell.getRowData(rowIdx).respCriOffi){
		$("#deleteBtn").show();
	}else{
		$("#deleteBtn").hide();
	}
	
 	//비고 셀 클릭 이벤트
	if(colIdx == 8){
		var dtaTabComn = qcell.getRowData(rowIdx).dtaTabComn;
		var userId = document.e_searchList.userId.value;
		//담당수사관과 로그인한 아이디가 같으면 비고창을 수정할수있다.
		if(qcell.getRowData(rowIdx).respCriOffi == userId){
			//비고 팝업화면을 가지고 온다.
			if(dtaTabComn == null){
				commonLayerPopup.openLayerPopup('/sjpb/E/E0302.face', "1000px", "262px", fn_e_pageInit);
			}else{
				commonLayerPopup.openLayerPopup('/sjpb/E/E0302.face?dtaTabComn='+encodeURI(dtaTabComn), "1000px", "262px", fn_e_pageInit);
			}
		}
	}
	
}

//수기수사자료표 검색 화면(리스트)을 가져온다. (ajax)
function fn_e_searchList(){
	queryString = $("#e_searchList").serialize();
	var d = document.e_searchList;
	if(d.startDay.value !=' ' || d.startDay.value!= null ||d.endDay.value !=' ' || d.endDay.value!=null){
		if(d.startDay.value!=' ' && d.startDay.value!=null && d.endDay.value!=' ' && d.endDay.value!=null){
			if(d.startDay.value > d.endDay.value){
				alert("시작일이 종료일보다 큽니다. 다시 설정해주세요.");
				return ;
			}
		}else{
			alert("기간을 입력해주세요.");
			return ;
		}
	}
	//수기수사자료표 검색 리스트 성공함수 호출
	goAjaxDefault("/sjpb/E/selectList.face", queryString, callBackFn_e_selectListSuccess);
	
}
	
//수기수사자료표 삭제한다.
function fn_e_deleteHawr(){ 
	var e0101VOMap = new Object();
	var e0101VOArr = new Array();
	var userId = document.e_searchList.userId.value;
	
	for(var i = 1;i <= qcell.getRows("data");i++){
		if(JSON.stringify(qcell.getCellLabel(i,1)) == "true"){
			if(qcell.getRowData(i).respCriOffi == userId){
				e0101VOArr.push(qcell.getRowData(i));
			}
		}
	}
	e0101VOMap.e0101VOList = e0101VOArr;
	
	if(e0101VOArr.length !=0){
		if(confirm("수기수사자료표를 삭제하시겠습니까?")==false){
			return;
		}
	}else{
		alert("삭제할 수기수사자료표를 선택해주세요.");
		return;
	}
	
	//수기수사자료표 삭제 성공함수 호출
	goAjax("/sjpb/E/deleteHawr.face", e0101VOMap, function(data){callBackFn_e_deleteHawrSuccess(data,e0101VOArr.length)});
}
//수기수사자료표 삭제 성공함수
function callBackFn_e_deleteHawrSuccess(data,len){
	if(data == len){
		alert("수기수사자료표가 삭제되었습니다.");
		fn_e_pageInit();
	}else{
		alert("수기수사자료표 삭제 실패하였습니다.");
	}
}

//초기화 함수
function fn_e_init(form){
	$("#"+form)[0].reset();
	//select 값 초기화
	$("#"+form).find("select").each(function() {
		$(this).find("option:eq(0)").prop("selected", true);
		$(this).prev('.txt').text($(this).find('option:selected').text());
	});
	
}

//수기수사자료표 열 삭제.
//var chkNum = [];
//for(var i = 1; i <= qcell.getRows(); i++){
//	if(JSON.stringify(qcell.getCellLabel(i,0)) == "true"){
//		chkNum.push(i);
//	}
//}
//if(chkNum.length != 0){
//	if(confirm("삭제하시겠습니까?")==true){
//		qcell.deleteRowsEx(chkNum);
//	}
//}else{
//	alert("삭제할 열을 선택해주세요.");
//}