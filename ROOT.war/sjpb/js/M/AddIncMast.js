var queryString;
var listQcell;
function fn_m_selectIncMastList(){
	IncMastMap={	//검색조건 세팅
			incNum :  $("#m_searchIncMastList [name=incNum]").val(),			//사건구분
			nmKor : $("#m_searchIncMastList [name=nmKor]").val()					//피의자명
		}
	goAjax("/sjpb/M/selectIncMast.face",IncMastMap,callBackFn_m_selectIncMastSuccess);
}

function callBackFn_m_selectIncMastSuccess(data){
	var QCELLProp = {
			"parentid" : "sheetIncMastList",
			"id" : "cell",
			"data" : {
				"input" : data.qCell
			},
			"rowheader" : "sequence",
			"selectmode": "row",
			"columns" : [ 
				{width: '10%', key : 'checkbox', title : [ '' ], type : 'checkbox',style : { data : { "background-color" : "gray" } }, options : { wholeselect : true }, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
			    {width: '30%',  key: 'rcptIncNum',         title: ['사건번호'],       sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			    {width: '30%',  key: 'dvFormDesc',           title: ['발각형태'],     sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
			    {width: '30%',  key: 'nmKor',           title: ['수사담당자'],     sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}    
				],
			"frozencols" : 5,
		};
		QCELL.create(QCELLProp);
		listQcell = QCELL.getInstance("cell");
		$("#btnArea_pop").show();
}

//사건 추가 성공함수
function fn_m_selectSendItemList(){
	var list=[];
	for(var i = 1; i <= listQcell.getRows("data"); i++){
		if(JSON.stringify(listQcell.getCellLabel(i,1)) == "true"){
			list.push(listQcell.getRowData(i));
		}	
	}
	window.parent.commonLayerPopup.closeLayerPopup(list);
}

//사건 추가 팝업창 닫기 이벤트
function fn_m_closeIncMastList(){
	window.parent.commonLayerPopup.closeLayerPopup();
}

var IncMastMap={
		rcptIncNum : "",		//사건번호
		nmKor : ""				//수사담당자

	};