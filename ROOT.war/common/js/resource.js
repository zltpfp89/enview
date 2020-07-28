

/**
 * 자원예약팝업호출
 * opr_id : 예약ID
 * rtnfn : 리턴받을 함수명
 * strtDt : 예약 시작일자, yyyy.MM.ddHHmm 
 * endDt : 에약 종료일자, yyyy.MM.ddHHmm
 */
function fn_resourceInfo(opr_id,rtnfn,strtDt,endDt) { 
	alert("aaaaaaaa");
	var param = "";
	if(opr_id == undefined || opr_id == null) {
		return;
	}
	if(rtnfn == undefined || rtnfn == null) {
		return;
	}
	if( opr_id =='0') {
		opr_id='';
	}
	
	var opr_strt_dt = "";
	var opr_end_dt = "";
	var opr_strt_tm = "";
	var opr_end_tm = "";
	if (strtDt != null && strtDt != undefined ) {
		opr_strt_dt = strtDt.substring(0, 10);
		opr_strt_tm = strtDt.substring(10);
	}
	if (endDt != null && endDt != undefined ) {
		opr_end_dt = endDt.substring(0, 10);
		opr_end_tm = endDt.substring(10);
	}
	
	
	 
		
	param = {
		"rtnfn" : rtnfn.trim(),
		"opr_id" : opr_id,
		"opr_strt_dt" : opr_strt_dt,
		"opr_end_dt" : opr_end_dt,
		"opr_strt_tm" : opr_strt_tm,
		"opr_end_tm" : opr_end_tm
	};

	var buttons = [];
	
	
	var url = getContextPath() + "/rsrc/rsrcView.rsrc";
	fn_showDialogPopup({
		showAreaId : "resourceViewLayer",
		url : url,
		param : param,
		title : "자원예약",
		width : 700,
		height : "auto",
		modal : true,
		buttons : buttons
    });
}

