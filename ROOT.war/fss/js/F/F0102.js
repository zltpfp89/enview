//var queryString="{}";
//var qcell;
//var str=1;
//var insert=0;
//
//$(document).ready(function() {
//	pageInit();
//});
//
//// 화면 진입시 동작함
//function pageInit() {
//	goAjax("/sjpb/F/selectList.face", queryString, function(data){callBackFn_selectListSuccess(data)});
//}
//
//// //범죄수사자료조회관리대장 검색리스트를 가져온다. (ajax)
//function fn_searchList() {
//	queryString = $("#f_searchList").serialize();
//	var d = document.f_searchList;
//	if (d.startDay.value != ' ' || d.startDay.value != null
//			|| d.endDay.value != ' ' || d.endDay.value != null) {
//		if (d.startDay.value != ' ' && d.startDay.value != null
//				&& d.endDay.value != ' ' && d.endDay.value != null) {
//			if (d.startDay.value > d.endDay.value) {
//				alert("시작일이 종료일보다 큽니다. 다시 설정해주세요.");
//				return ;
//			}
//		} else {
//			alert("기간을 입력해주세요.");
//			return ;
//		}
//	}
//	goAjaxDefault("/sjpb/F/selectList.face", queryString, callBackFn_selectListSuccess);
//
//}
//
//// 범죄수사자료조회관리대장 화면(리스트)을 가져온다. (ajax)
//function callBackFn_selectListSuccess(data){
//	var QCELLProp = {
//			"parentid" : "sheet",
//			"id" : "cell",
//			"data" : {
//				"input" : data.qCell
//			},
//			"rowheader" : "sequence",
//			"selectmode": "row",
//			"columns" : [ 
//				{ width : '50', key : 'checkbox', title : [ '' ], type : 'checkbox',style : { data : { "background-color" : "gray" } }, options : { wholeselect : true }, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
//				{ width : '100', key : 'regDate', title : [ '작성일자' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize18' } }, 
//				{ width : '100', key : 'criTmNm', title : [ '수사팀' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize18' } }, 
//				{ width : '100', key : 'nmKor', title : [ '담당수사관' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize18' } }, 
//				{ width : '100', key : 'sp', title : [ '피의자' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize18' } }, 
//				{ width : '100', key : 'mngBkComn', title : [ '비고' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize18' } } 
//				],
//			"frozencols" : 5,
//		};
//		QCELL.create(QCELLProp);
//		fn_btnInsert(str);
//		
//		qcell = QCELL.getInstance("cell");
//		qcell.bind("click", eventFn);
//		if (qcell.getRows("data") > 0) {
//	        qcell.setCellData(1, 1, true);
//	        var reqMap = {
//        		mngBkSiNum : qcell.getRowData(1).mngBkSiNum
//	        }
//	      //범죄수사자료조회관리대장 상세 호출
//	        goAjaxDefault("/sjpb/F/selectCriData.face", reqMap, callBackFn_f_selectCriDataSuccess);
//		}
//}
//
////범죄수사자료조회관리대장 신규 등록한다.
//function fn_insertcriData() {// getRowData
//	var insert = $("#f_insertdata").serialize();
//	var d = document.f_insertdata;
//	if (d.nmKor.value == '' || d.nmKor.value == null) {
//		alert("담당수사관을 입력하세요.");
//		d.nmKor.focus();
//		return false;
//	}
//	if (d.sp.value == '' || d.sp.value == null) {
//		alert("피의자을 입력하세요.");
//		d.sp.focus();
//		return false;
//	}
//	
//	goAjax("/sjpb/F/insertCriData.face", insert, callBackFn_insertcriDataSuccess);
//	
//}
//
////범죄수사자료조회관리대장 신규 등록 성공함수
//function callBackFn_insertcriDataSuccess(data){
//	if (data == 1) {
//		alert("등록되었습니다.");
//		goAjaxDefault("/sjpb/F/selectList.face", "{}", callBackFn_selectListSuccess);
//		fn_btnInsert(str);
//	} else {
//		alert("등록에 실패하였습니다.");
//	}
//}
//
////셀클릭 이벤트
//function eventFn(e) {
//	//등록버튼이 있을시 삭제
//	fn_btnInsert(str);
//	// 선택한 인덱스 가져오기
//	var rowIdx = qcell.getIdx("row");
//	var colIdx = qcell.getIdx("col");
//	//셀 클릭 이벤트
//	if(colIdx>1){
//		if(JSON.stringify(qcell.getCellLabel(rowIdx,1)) == "true"){
//			//클릭된 셀 클릭시 체크박스 체크 해제
//		 	qcell.setCellData(rowIdx, 1, false);
//		}else{
//			//선택한 인덱스 체크박스 체크
//			qcell.setCellData(rowIdx, 1, true);
//		}
//	}
//	var reqMap = {
//    		mngBkSiNum : qcell.getRowData(rowIdx).mngBkSiNum
//        }
//	//범죄수사자료조회관리대장 상세 호출
//	goAjaxDefault("/sjpb/F/selectCriData.face", reqMap , callBackFn_f_selectCriDataSuccess);
//
//}
//
////범죄수사자료조회관리대장 상세 성공 함수
//function callBackFn_f_selectCriDataSuccess(data){
//	// 범죄수사자료조회관리대장 정보 셋팅
//	$("#nmKor").val(data.nmKor); // 담당수사관
//	$("#sp").val(data.sp); // 피의자
//	$("#mngBkComn").val(data.mngBkComn); // 관리대장비고
//}
//
////등록버튼 유무
//function fn_btnInsert(type) {	
//	//0: 신규입력
//	//1: 상세보기 
//	if (type == 1) {
//		$("#btn_insertcriData").hide();
//	} else {
//		$("#f_insertdata")[0].reset();
//		$("#btn_insertcriData").show();
//	}
//}
//
////범죄수사자료조회관리대장 열 삭제한다.
//function fn_deleteCriData() {
//	// 선택된 ROW의 chkNum가져오기
//	var chkNum = [];
//	for (var i = 1; i <= qcell.getRows(); i++) {
//		if (JSON.stringify(qcell.getCellLabel(i, 1)) == "true") {
//			chkNum.push(i);
//		}
//	}
//	qcell.deleteRowsEx(chkNum);
//	alert("삭제되었습니다.");
//}
//
////초기화 함수
//function fn_f_init(form){
//	$("#"+form)[0].reset(); //form 데이터 지우기
//	goAjaxDefault("/sjpb/F/selectList.face", "{}", allBackFn_selectListSuccess); //리스트 초기화
//}
