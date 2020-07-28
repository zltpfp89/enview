var listQcell;
var day = "";
$(document).ready(function(){
	var fdCdArray = [];
	var values = document.getElementsByName("fdCd");
	for(var i=0;i<values.length;i++){
		if(values[i].checked){
			fdCdArray.push(values[i].value);
		}
	}
	
	setAreaMap($("#j_searchList"), J0201SCMap);
	J0201SCMap.fdCdArray = fdCdArray.toString();
	J0201SCMap.year = new Date().getFullYear();
	//페이지 진입시 사건유입통계 출력시 성공함수 호출
	goAjaxDefault("/sjpb/J/J0201List.face",J0201SCMap,callBackFn_selectListSuccess);
	day = J0201SCMap.year.toString();
	
	$("#exceldown").click(function(){
		
		var properties = {
				filename: "사건_유입_통계_"+day,
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
//사건유입통계 검색리스트를 가져온다. (ajax)
function fn_searchList() {
	setAreaMap($("#j_searchList"), J0201SCMap);
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
	J0201SCMap.fdCdArray = fdCdArray.toString();
	
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
	if( d.year.value != '' && d.year.value != null && d.regStart.value != '' && d.regStart.value != null ){
		alert("기간과 년도중 하나만 선택해주세요.");
		return;
	}
	
	J0201SCMap.year = d.year.value;
	if(J0201SCMap.regStart != '' && J0201SCMap.regStart != ' ' && J0201SCMap.regStart != null){
		day = J0201SCMap.regStart.toString()+"~"+J0201SCMap.regEnd.toString()
	}else if(J0201SCMap.year != '' && J0201SCMap.year != ' ' && J0201SCMap.year != null){
		day = J0201SCMap.year.toString();
	}
	//사건유입통계 리스트를 가지고 온다.
	goAjaxDefault("/sjpb/J/J0201List.face", J0201SCMap, callBackFn_selectListSuccess);

}

//사건유입통계 리스트 성공함수. (ajax)
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
				{ width : '10%', key : 'sort', title : ['구분\n'+day,'구분\n'+day], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '9%', key : 'total', title : ['계','계',], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '9%', key : 'totalPer', title : ['계','%',], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '9%', key : 'gen', title : ['일반','계'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '9%', key : 'genPer', title : ['일반','%'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '9%', key : 'ie', title : ['범죄신고센터','계'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '9%', key : 'iePer', title : ['범죄신고센터','%'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '9%', key : 'mob', title : ['불편신고앱','계' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '9%', key : 'mobPer', title : ['불편신고앱','%' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '9%', key : 'inc', title : ['진정사건부','계'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } },
				{ width : '9%', key : 'incPer', title : ['진정사건부','%'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }
				],
			"frozencols" : 5,
		};
		QCELL.create(QCELLProp);
	
		listQcell = QCELL.getInstance("cell");


}

var J0201VOMap={
	sort : "",
	sortPer : "",
	total : "",
	totalPer : "",
	gen : "",
	genPer : "",
	ie : "",
	iePer : "",
	inc : "",
	incPer : "",
	mob : "",
	mobPer : ""
};
//검색조건
var J0201SCMap = {
	"regStart" : ""
	,"regEnd" : ""
	,"fdCdArray" : ""
	,"year" : ""
}