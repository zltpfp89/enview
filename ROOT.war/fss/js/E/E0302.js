//비고를 등록한다.(ajax)
function fn_e_updateComn(){
	var map = window.parent.qcell.getRowData(window.parent.qcell.getSelectedRow());	
	var updateComnMap = {
			bkPublYr : map.bkPublYr, 
			bkSiNum : map.bkSiNum, 
			dtaTabComn : document.e_updateComn.dtaTabComn.value
	};
	//비고 등록 성공함수 호출
	goAjaxDefault("/sjpb/E/updateComn.face", updateComnMap, callBackFn_e_updateComnSuccess);
	  
}

//비고 등록 성공함수
function callBackFn_e_updateComnSuccess(data){
	if(data == 1){
		alert("비고가 등록되었습니다.");
	 }else {
		 alert("비고등록에 실패하였습니다.");
	}
	//비고창닫기
	fn_e_closeUpdateComn(); 
}

//비고입력 팝업창을 닫는다.
function fn_e_closeUpdateComn(){
	window.parent.commonLayerPopup.closeLayerPopup();
}

