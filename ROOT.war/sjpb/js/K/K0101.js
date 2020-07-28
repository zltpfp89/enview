$(document).ready(function(){
	
	//페이지 진입시 수사차량관리 성공함수 호출
	goAjaxDefault("/sjpb/K/selectList.face",K0101SCMap,callBackFn_selectListSuccess);

	
});
//수사차량관리 검색리스트를 가져온다. (ajax)
function fn_searchList() {
	K0101SCMap.itdcYearSC = $("#itdcYearSC").val();

	//수사차량관리 리스트를 가지고 온다.
	goAjaxDefault("/sjpb/K/selectList.face", K0101SCMap, callBackFn_selectListSuccess);

}

//수사차량관리 리스트 성공함수. (ajax)
function callBackFn_selectListSuccess(data){
	if(data.qCell == null ||data.qCell == ''){
		fn_K_new()
	}
	
	var QCELLProp = {
			"parentid" : "sheet",
			"id" : "cell",
			"data" : {
				"input" : data.qCell
			},
			"rowheader" : "sequence",
			"merge": {"header": "rowandcol"},
			"selectmode": "row",
			"columns" : [ 
				{ width : '10%', key : 'itdcYear', title : ['년도'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '10%', key : 'vhcDiv', title : ['구분'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '10%', key : 'vhcKind', title : ['차종'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '10%', key : 'vhcSz', title : ['차형'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '10%', key : 'mnftNm', title : ['제조사'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '10%', key : 'mdlNm', title : ['모델명'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '10%', key : 'vhcCarNo', title : ['차량번호'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '10%', key : 'mngTmNm', title : ['관리수사팀'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '10%', key : 'pblcYn', title : ['공용여부'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '10%', key : 'comnCont', title : ['비고'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				
				],
			"frozencols" : 5,
		};
		QCELL.create(QCELLProp);
	
		listQcell = QCELL.getInstance("cell");
		listQcell.bind("click", eventFn);
	    if (listQcell.getRows("data") > 0) {
	    	listQcell.setRowStyle(1, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
    		//첫번째 정보 세팅
	    	K0101VOMap = listQcell.getRowData(1);
	    	fn_K_selectSetting();
	    	//수정세팅
	    	updateYN();
		}

}
// 셀클릭 이벤트
function eventFn(e){

	// 선택한 인덱스 가져오기
	var colIdx = listQcell.getIdx("col");
	rowIdx = listQcell.getIdx("row");	

	if(colIdx >0 && rowIdx > 0){
		if(colIdx != 1){
			//기존 체크박스 열번호
			var pastchk = listQcell.getIdx("row","focus","previous") == -1?1:listQcell.getIdx("row","focus","previous");
			
			//기존 체크항목 해제
			listQcell.removeRowStyle(pastchk);
		
			//새로 선택한 행 스타일적용
			listQcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
			
			freezeInput(true); // 입력 비활성화
			fn_K_initK0101VOMap(); // 맵초기화
			K0101VOMap = listQcell.getRowData(rowIdx);
		
			//출석요구통지부 데이터 세팅
			fn_K_selectSetting();
			//수정세팅
			updateYN();
		}
	}
}
//수사차량관리 데이터 세팅
function fn_K_selectSetting(){	

	getAreaMap($("#K0101"), K0101VOMap);
	$("#vhcMngNum").val(K0101VOMap.vhcMngNum);
	setFieldValue($("#itdcYear"), K0101VOMap.itdcYear);
	setFieldValue($("#vhcDiv"), K0101VOMap.vhcDivCd);
	setFieldValue($("#vhcKind"), K0101VOMap.vhcKindCd);
	setFieldValue($("#vhcSz"), K0101VOMap.vhcSzCd);
	setFieldValue($("#mngTmId"), K0101VOMap.mngTmId);
	if(K0101VOMap.pblcYn == 'O'){
		$("#pblcYn_N").prop("checked",false);
		$("#pblcYn_Y").prop("checked",true);
	}
	if(K0101VOMap.pblcYn == 'X'){	
		$("#pblcYn_Y").prop("checked",false);
		$("#pblcYn_N").prop("checked",true);
	}
	
}

//수정 가능 버튼 보이기 여부
function updateYN(){
	if(K0101VOMap.regUserId == $("#regUserId").val() ){
		freezeInput(false); // 입력 활성화
		$("#btnUpdate").show();  //수정버튼 보이기
		$("#btnDelete").show();  //삭제버튼 보이기
		//화면사이즈 갱신
		autoResize();
	}else{
		freezeInput(true); // 입력 비활성화
		$("#btnUpdate").hide();  //수정버튼 숨기기
		$("#btnDelete").hide();  //삭제버튼 숨기기
		//화면사이즈 갱신
		autoResize();
	}
	$("#btnInsert").hide();  //저장버튼 숨기기

}

//맵초기화
function fn_K_initK0101VOMap() {
	K0101VOMap={
			itdcYear : "",
			vhcDivCd : "",
			vhcDiv : "",
			vhcKindCd : "",
			vhcKind : "",
			vhcSzCd : "",
			vhcSz : "",
			mnftNm : "",
			mdlNm : "",
			vhcCarNo : "",
			mngTmId : "",
			mngTmNm : "",
			pblcYn : "",
			comnCont : ""
	}
}

//신규등록
function fn_K_new(){
	
	$("#pblcYn_Y").prop("checked",false);
	$("#pblcYn_N").prop("checked",false);
	fn_K_initK0101VOMap(); //맵초기화
	fn_K_selectSetting(); // 데이터 세팅	
	
	freezeInput(false); // 입력 활성화
	
	$("#btnInsert").show(); // 저장버튼 보이기	
	$("#btnUpdate").hide(); // 수정버튼 숨기기	
	$("#btnDelete").hide(); // 삭제버튼 숨기기	
	//화면사이즈 갱신
	autoResize();
}
//등록하기
function fn_K_insert(){

	setAreaMap($("#K0101"), K0101VOMap);
	K0101VOMap.itdcYear = $("#itdcYear").val();
	K0101VOMap.vhcDiv = $("#vhcDiv").val();
	K0101VOMap.vhcKindCd = $("#vhcKind").val();
	K0101VOMap.vhcSzCd = $("#vhcSz").val();
	K0101VOMap.mngTmId = $("#mngTmId").val();
	K0101VOMap.regUserId = $("#regUserId").val();
	K0101VOMap.pblcYn = $("input:radio[name=pblcYn]:checked").val();
	
	//유효성 체크
	var chkObjs = $("#contentsArea");
	if(!chkValidate.check(chkObjs, true)) return;
	
	goAjaxDefault("/sjpb/K/insertMng.face",K0101VOMap,callBackFn_K_insertSuccess);
	
	$("#btnInsert").hide(); //저장버튼 숨기기

}

//등록성공함수 호출
function callBackFn_K_insertSuccess(data){
	
	if(data == 1){
		alert("수사차량이 등록되었습니다.");
	}else{
		alert("수사차량 등록실패하였습니다.");
	}
	//페이지 리셋
	fn_searchList();
	freezeInput(true); // 입력 비활성화
}
//수정
function fn_K_update(){
	setAreaMap($("#K0101"), K0101VOMap);
	K0101VOMap.vhcMngNum = $("#vhcMngNum").val();
	K0101VOMap.itdcYear = $("#itdcYear").val();
	K0101VOMap.vhcDiv = $("#vhcDiv").val();
	K0101VOMap.vhcKindCd = $("#vhcKind").val();
	K0101VOMap.vhcSzCd = $("#vhcSz").val();
	K0101VOMap.mngTmId = $("#mngTmId").val();
	K0101VOMap.regUserId = $("#regUserId").val();
	goAjaxDefault("/sjpb/K/updateMng.face",K0101VOMap,callBackFn_K_updateSuccess);
}
//수정성공함수 호출
function callBackFn_K_updateSuccess(data){
	if(data == 1){
		alert("수정되었습니다.");
	}else{
		alert("수정에 실패하였습니다.");
	}
	//페이지 리셋
	fn_searchList();
	freezeInput(true); // 입력 비활성화
}
//삭제
function fn_K_delete(){
	var map = {
			vhcMngNum : $("#vhcMngNum").val()
	}
	
	goAjaxDefault("/sjpb/K/deleteMng.face",map,callBackFn_K_deleteSuccess);
}
//수정성공함수 호출
function callBackFn_K_deleteSuccess(data){
	if(data == 1){
		alert("삭제되었습니다.");
	}else{
		alert("삭제에 실패하였습니다.");
	}
	//페이지 리셋
	fn_searchList();
	freezeInput(true); // 입력 비활성화
}
//입력화면 비/활성화
function freezeInput(tf) {
	$("#contentsArea input").attr("disabled",tf);
	$("#contentsArea select").attr("disabled",tf);
	$("#contentsArea a").attr("disabled",tf);
	$("#contentsArea textarea").attr("disabled",tf);
}
var K0101VOMap={
	vhcMngNum : "",
	itdcYear : "",
	vhcDivCd : "",
	vhcDiv : "",
	vhcKindCd : "",
	vhcKind : "",
	vhcSzCd : "",
	vhcSz : "",
	mnftNm : "",
	mdlNm : "",
	vhcCarNo : "",
	mngTmId : "",
	mngTmNm : "",
	pblcYn : "",
	comnCont : ""
};
//검색조건
var K0101SCMap = {
	"itdcYearSC" : ""

}