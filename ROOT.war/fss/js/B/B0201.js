$(function(){
	pageInit();
});

//화면 진입시 동작함
function pageInit(){
	
	//이벤트바인딩
	eventSetup();	
	
}

//이벤트처리
function eventSetup() {
	
    $('#iframeContainer iframe').onload = function() {alert('myframe is loaded');};
	
	//닫기버튼
	$("#closBtn, img.btn_close").on("click", function() {
		window.parent.commonLayerPopup.closeLayerPopupOnly();
	});		
	
	//확인버튼
	$("#cnfmBtn").on("click", function(e) {
		
		//Map 데이터 갱신
		if(syncB0201VOMap(true)){	
			var mfCdArr = [];
			$("input[name=mfCd]:checked").each(function(){
				mfCdArr.push($(this).val());
			});
			
			var b0201VOMap = {
					mfCd : mfCdArr.join(":")
					,mfCont : getFieldValue($("#mfCont"))
			}
			
			window.parent.commonLayerPopup.closeLayerPopup(b0201VOMap);
			
		}
		
		
			
//		var selectedRowData = [];
//		//기존 체크항목 해제와 새로 선택한 행 체크박스 선택
//		for (var i=1; i<=qcellP.getRows("data"); i++) {
//			if (qcellP.getCellData(i, 0)) {
//				selectedRowData.push(qcellP.getRowData(i));
//			}
//		}		
//		
//		
		
	});	
	
}

//Map 데이터 갱신
function syncB0201VOMap(isValid) {
	
	//유효성체크 여부에 따라 체크함 
	if(isValid){
		//유효성 체크
		var chkObjs = $("#b0201ContentsArea");
		if(!chkValidate.check(chkObjs, true)) return;
	}
	
	//데이터셋팅
	setAreaMap($("#b0201ContentsArea"), b0201VOMap);
	
	return true;
	
}

//사건변경이력 데이터맵
var b0201VOMap = {		
	mfCd: ""		//변경코드
	,mfCont : ""	//상세내용
}
