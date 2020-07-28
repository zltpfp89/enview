var listQcell;
$(document).ready(function(){
	var fdCdArray = [];
	var values = document.getElementsByName("fdCd");
	for(var i=0;i<values.length;i++){
		if(values[i].checked){
			fdCdArray.push(values[i].value);
		}
	}

	setAreaMap($("#j_searchList"), J0301SCMap);
	J0301SCMap.fdCdArray = fdCdArray.toString();
	
	//페이지 진입시 년도별 수사현황(인지/고발) 출력시 성공함수 호출
	goAjaxDefault("/sjpb/J/J0301List.face",J0301SCMap,callBackFn_selectListSuccess);
	
	//엑셀다운로드
	$("#exceldown").click(function(){
		
		var properties = {
				filename: "년도별_수사현황(인지/고발)",
				url: '/excelDownload.face',
				border: true, // border 처리
				headershow: true, // header 출력
				colwidth: true, // col의 width 'px' 적용
				huge: false //대용량 여부

			};
		listQcell.excelDownload(properties);
		
		
	  });

	//사건분야
	$("#total").click(function(){
		if($("#total").prop("checked")){
			$("input[name=fdCd").prop("checked",true);
		}else{
			$("input[name=fdCd").prop("checked",false);
		}
	});
	
});
//년도별 수사현황(인지/고발) 검색리스트를 가져온다. (ajax)
function fn_searchList() {
	setAreaMap($("#j_searchList"), J0301SCMap);
	
	var fdCdArray = [];
	var values = document.getElementsByName("fdCd");
	for(var i=0;i<values.length;i++){
		if(values[i].checked){
			fdCdArray.push(values[i].value);
		}
	}
	if(fdCdArray.length ==0){
		alert("분야를 선택해주세요.");
		return;
	}
	J0301SCMap.fdCdArray = fdCdArray.toString();
	
	//년도별 수사현황(인지/고발) 리스트를 가지고 온다.
	goAjaxDefault("/sjpb/J/J0301List.face", J0301SCMap, callBackFn_selectListSuccess);

}

//년도별 수사현황(인지/고발) 리스트 성공함수. (ajax)
function callBackFn_selectListSuccess(data){
//	var fdCd = data.sc.selectFdCdCodeList.toString();
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
				{ width : '10%', key : 'sort', title : ['구분','구분','구분'], sort : true, move : false, resize : false, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '6%', key : 'prsct', title : ['입건','계','건'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '6%', key : 'prsctTotalPer', title : ['입건','계','%'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '6%', key : 'prsAccus', title : ['입건','고발','고발' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '6%', key : 'prsPapst', title : ['입건','인지','인지'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '6%', key : 'invst', title : ['수사중','계','계'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '6%', key : 'invstAccus', title : ['수사중','고발','고발'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '6%', key : 'invstPapst', title : ['수사중','인지','인지'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '6%', key : 'cmnd', title : ['지휘중','계','계'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '6%', key : 'cmndAccus', title : ['지휘중','고발','고발'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '6%', key : 'cmndPapst', title : ['지휘중','인지','인지'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '6%', key : 'trsPer', title : ['송치율\n(%)','송치율\n(%)','송치율\n(%)'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '6%', key : 'trs', title : ['송치','계','건'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'trsTotalPer', title : ['송치','계','%'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '6%', key : 'trsAccus', title : ['송치','고발','고발'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '6%', key : 'trsPapst', title : ['송치','인지','인지'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '8%', key : 'preTrsPer', title : ['예상송치율\n(지휘중포함)\n(%)','예상송치율\n(지휘중포함)\n(%)','예상송치율\n(지휘중포함)\n(%)'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }
				],
			"frozencols" : 8,
		};
		QCELL.create(QCELLProp);
	
		listQcell = QCELL.getInstance("cell");


}

var J0301VOMap={
	sort : "",
	prsct : "",
	prsctTotalPer : "",
	prsAccus : "",
	prsPapst : "",
	invst : "",
	invstAccus : "",
	invstPapst : "",
	cmnd : "",
	cmndAccus : "",
	cmndPapst : "",
	trsPer : "",
	trsTotalPer : "",
	trs : "",
	trsAccus : "",
	trsPapst : "",
	preTrsPer : "",
	criTmDiv : "",
	dept : ""
};
//검색조건
var J0301SCMap = {
	"fdCdArray" : ""
}