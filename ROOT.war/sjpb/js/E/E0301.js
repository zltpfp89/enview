var spQcell;
$(document).ready(function(){
	fn_e_searchSpList();
});
//피의자 추가 검색 화면(리스트)을 가져온다. (ajax)		
function fn_e_searchSpList(){
	//추가 버튼영역 활성화
	$("#btnArea_pop").show();
	var queryString = $("#e_searchSpList").serialize();
	//피의자 추가 리스트 가져오기
	goAjax("/sjpb/E/spList.face", queryString, callBackFn_e_searchSpList, true);
}

//피의자 추가 리스트 성공 함수
function callBackFn_e_searchSpList(data){
	var QCELLProp = {
            "parentid" : "spList",
            "id"		: "spCell",
            "data"		: {"input" : data.qCell},
            "rowheader"	: "sequence",
            "selectmode": "row",
            "columns"	: [
            	{width: '5%',	key: 'checkbox',			title: [''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '15%',	key: 'rcptIncNum',			title: ['사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '20%',	key: 'regDate',			title: ['접수일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '15%',	key: 'nmKor',			title: ['담당수사관'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '25%',	key: 'rltActCrinmCdDesc',			title: ['관련법률 및 죄명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '20%',	key: 'spNm',			title: ['피의자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}	                	
            ],
			"frozencols" : 5,
        };
	 	QCELL.create(QCELLProp);

	 	spQcell = QCELL.getInstance("spCell");
	 	spQcell.bind("click", eventFn2);
		
}

//클릭이벤트
function eventFn2(e){
	// 선택한 인덱스 가져오기
	var spRowIdx = spQcell.getIdx("row");
	var colIdx = spQcell.getIdx("col");
	//셀 클릭 이벤트
	if(colIdx>1){
		if(JSON.stringify(spQcell.getCellLabel(spRowIdx,1)) == "true"){
			//클릭된 셀 클릭시 체크박스 체크 해제
			spQcell.setCellData(spRowIdx, 1, false);
		}else{
			//선택한 인덱스 체크박스 체크
			spQcell.setCellData(spRowIdx, 1, true);
		}
	}
}

//선택한 피의자를 수기수사자료표에 추가한다.(ajax)
function fn_e_insertHawrCriData(){
	var chkNum = [];
	var e0301VOMap = new Object();
	var e0301VOArr = new Array();
	for(var i = 1; i <= spQcell.getRows(); i++){
		if(JSON.stringify(spQcell.getCellLabel(i,1)) == "true"){
			chkNum.push(spQcell.getRowData(i));
		}
	}
	if(chkNum.length == 0){
		alert("피의자를 선택하세요.");
		return;
	}
	
	for (var i = 0; i < chkNum.length; i++) {
		var e0301VO = new Object();
		e0301VO.incSpNum = chkNum[i].incSpNum;
		e0301VO.rltActCriNmCd = chkNum[i].rltActCriNmCd;
		e0301VO.dvYn = chkNum[i].dvForm;
		e0301VOArr.push(e0301VO);
	}
	e0301VOMap.e0301VOList = e0301VOArr;
	goAjax("/sjpb/E/insertHawrCriData.face", e0301VOMap, function(data){callBackFn_e_insertHawrCriDataSuccess(data,chkNum.length)});
	
}

//선택한 피의자를 수기수사자료표에 추가 성공함수
function callBackFn_e_insertHawrCriDataSuccess(data,len){
	if(data == len){
	 	alert(" 수기수사자료표가 등록되었습니다.");
	}else {
		alert("등록에 실패하였습니다.");
	}
	//팝업창 닫기
	window.parent.commonLayerPopup.closeLayerPopup();
}

//피의자 추가팝업화면을 닫는다.
function fn_e_closeInsertHawrCriData(){
	window.parent.commonLayerPopup.closeLayerPopup();
}

//초기화 함수
function fn_e_init(form){
	$("#"+form)[0].reset();
}
