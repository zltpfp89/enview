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
	
	setAreaMap($("#j_searchList"), J0202SCMap);
	J0202SCMap.fdCdArray = fdCdArray.toString();
	day = J0202SCMap.regStart.toString()+"~"+J0202SCMap.regEnd.toString();
	//페이지 진입시 범죄수사경력조회현황 출력시 성공함수 호출
	goAjaxDefault("/sjpb/J/J0202List.face",J0202SCMap,callBackFn_selectListSuccess);

	$("#exceldown").click(function(){
		
		var properties = {
				filename: "범죄수사경력조회현황_"+day,
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
//범죄수사경력조회현황 검색리스트를 가져온다. (ajax)
function fn_searchList() {
	setAreaMap($("#j_searchList"), J0202SCMap);
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
	J0202SCMap.fdCdArray = fdCdArray.toString();
	
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
	day = J0202SCMap.regStart.toString()+"~"+J0202SCMap.regEnd.toString();
	//범죄수사경력조회현황 리스트를 가지고 온다.
	goAjaxDefault("/sjpb/J/J0202List.face", J0202SCMap, callBackFn_selectListSuccess);

}

//범죄수사경력조회현황 리스트 성공함수. (ajax)
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
				{ width : '50%', key : 'sort', title : ['구분\n'+day,'구분\n'+day], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '25%', key : 'total', title : ['명','명',], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '25%', key : 'totalPer', title : ['계','%',], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }
				]
		};
		QCELL.create(QCELLProp);
	
		listQcell = QCELL.getInstance("cell");


}

var J0202VOMap={
	sort : "",
	total : "",
	totalPer : ""
};
//검색조건
var J0202SCMap = {
	"regStart" : ""
	,"regEnd" : ""
	,"fdCdArray" : ""
}