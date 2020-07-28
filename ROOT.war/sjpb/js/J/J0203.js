var listQcell;
var day ="";
$(document).ready(function(){
	
	setAreaMap($("#j_searchList"), J0203SCMap);
	day = J0203SCMap.regStart.toString()+"~"+J0203SCMap.regEnd.toString();
	//페이지 진입시 디지털포렌식 수사현황 출력시 성공함수 호출
	goAjaxDefault("/sjpb/J/J0203List.face",J0203SCMap,callBackFn_selectListSuccess);

	$("#exceldown").click(function(){
		
		var properties = {
				filename: "디지털포렌식_수사현황_"+day,
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
//디지털포렌식 수사현황 검색리스트를 가져온다. (ajax)
function fn_searchList() {
	setAreaMap($("#j_searchList"), J0203SCMap);
	
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
	day = J0203SCMap.regStart.toString()+"~"+J0203SCMap.regEnd.toString();
	//디지털포렌식 수사현황 리스트를 가지고 온다.
	goAjaxDefault("/sjpb/J/J0203List.face", J0203SCMap, callBackFn_selectListSuccess);

}

//디지털포렌식 수사현황 리스트 성공함수. (ajax)
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
				{ width : '16%', key : 'sort', title : ['구분\n'+day,'구분\n'+day], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '12%', key : 'totalPer', title : ['지원현황','%',], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } },
				{ width : '12%', key : 'gen', title : ['지원현황','건'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } },
				{ width : '12%', key : 'total', title : ['지원현황','매체수'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } },
				{ width : '12%', key : 'disk', title : ['매체별 현황','디스크 건수'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } },
				{ width : '12%', key : 'diskPer', title : ['매체별 현황','%'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } },
				{ width : '12%', key : 'mob', title : ['매체별 현황','모바일 건수'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } },
				{ width : '12%', key : 'mobPer', title : ['매체별 현황','%'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }
				
				]
		};
		QCELL.create(QCELLProp);
	
		listQcell = QCELL.getInstance("cell");


}

var J0203VOMap={
	sort : "",
	total : "",
	gen : "",
	totalPer : "",
	disk : "",
	diskPer : "",
	mob : "",
	mobPer : ""
};
//검색조건
var J0203SCMap = {
	"regStart" : ""
	,"regEnd" : ""
}