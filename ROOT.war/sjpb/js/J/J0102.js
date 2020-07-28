var listQcell;
var day="";
$(document).ready(function(){
	var fdCdArray = [];
	var values = document.getElementsByName("fdCd");
	for(var i=0;i<values.length;i++){
		if(values[i].checked){
			fdCdArray.push(values[i].value);
		}
	}

	setAreaMap($("#j_searchList"), J0102SCMap);
	J0102SCMap.fdCdArray = fdCdArray.toString();
	J0102SCMap.year = new Date().getFullYear();
	day = J0102SCMap.year.toString();
	//페이지 진입시 수사관 수사현황출력시 성공함수 호출
	goAjaxDefault("/sjpb/J/J0102List.face",J0102SCMap,callBackFn_selectListSuccess);
	
	

	
	//엑셀다운로드
	$("#exceldown").click(function(){
		
		var properties = {
				filename: "수사관별_수사현황_"+day,
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
//부서 수사현황 검색리스트를 가져온다. (ajax)
function fn_searchList() {
	setAreaMap($("#j_searchList"), J0102SCMap);
	
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
	J0102SCMap.fdCdArray = fdCdArray.toString();
	
	var d = document.j_searchList;
	if (d.regStart.value != ' ' || d.regStart.value != null
			|| d.regEnd.value != ' ' || d.regEnd.value != null) {
		if (d.regStart.value != ' ' && d.regStart.value != null
				&& d.regEnd.value != ' ' && d.regEnd.value != null) {
			if (d.regStart.value > d.regEnd.value) {
				alert("시작일이 종료일보다 큽니다. 다시 설정해주세요.");
				return ;
			}
		} else {
			alert("기간을 입력해주세요.");
			return ;
		}
	}
	J0102SCMap.year = d.year.value;
	if(J0102SCMap.regStart != '' && J0102SCMap.regStart != ' ' && J0102SCMap.regStart != null){
		day = J0102SCMap.regStart.toString()+"~"+J0102SCMap.regEnd.toString()
	}else if(J0102SCMap.year != '' && J0102SCMap.year != ' ' && J0102SCMap.year != null){
		day = J0102SCMap.year.toString();
	}
	//수사관 수사현황 리스트를 가지고 온다.
	goAjaxDefault("/sjpb/J/J0102List.face", J0102SCMap, callBackFn_selectListSuccess);

}

//범죄수사자료조회관리대장 리스트 성공함수. (ajax)
function callBackFn_selectListSuccess(data){
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
				{ width : '10%', key : 'sort', title : ['구분\n'+day,'구분\n'+day,'구분\n'+day], sort : true, move : false, resize : false, styleclassname : { data : 'aligncenter fontsize17' } }, 
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
				{ width : '6%', key : 'etc', title : ['기타','기타','기타'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '8%', key : 'preTrsPer', title : ['예상송치율\n(지휘중포함)\n(%)','예상송치율\n(지휘중포함)\n(%)','예상송치율\n(지휘중포함)\n(%)'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }
				],
			"frozencols" : 8,
		};
		QCELL.create(QCELLProp);
	
		listQcell = QCELL.getInstance("cell");


}

var J0102VOMap={
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
var J0102SCMap = {
	"regStart" : ""
	,"regEnd" : ""
	,"fdCdArray" : ""
	,"year" : ""
}