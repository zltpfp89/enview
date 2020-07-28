$(document).ready(function(){
	
	//페이지 진입시 부서별 송치 및 지휘(건/명) 출력시 성공함수 호출
	goAjaxDefault("/sjpb/J/J0104List.face",J0104SCMap,callBackFn_selectListSuccess);

	
});
//부서별 송치 및 지휘(건/명) 검색리스트를 가져온다. (ajax)
function fn_searchList() {
	setAreaMap($("#j_searchList"), J0104SCMap);
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
	
	//부서별 송치 및 지휘(건/명) 리스트를 가지고 온다.
	goAjaxDefault("/sjpb/J/J0104List.face", J0104SCMap, callBackFn_selectListSuccess);

}

//부서별 송치 및 지휘(건/명) 리스트 성공함수. (ajax)
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
				{ width : '5%', key : 'sort', title : ['구분','구분','구분'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '5%', key : 'prsctTotalPer', title : ['입건','%','%'], sort : true, move : true, resize : true,options:{format:{type:"string",rule:"@%"}}, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '5%', key : 'prsct', title : ['입건','건','건' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '5%', key : 'prsctSp', title : ['입건','명','명'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '5%', key : 'invstTotalPer', title : ['수사중','%','%'], sort : true, move : true, resize : true,options:{format:{type:"string",rule:"@%"}}, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '5%', key : 'invst', title : ['수사중','건','건'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '5%', key : 'invstSp', title : ['수사중','명','명'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '5%', key : 'cmndPer', title : ['지휘율','지휘율','지휘율'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '5%', key : 'cmndTotalPer', title : ['지휘중','%','%'], sort : true, move : true, resize : true,options:{format:{type:"string",rule:"@%"}}, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '5%', key : 'cmnd', title : ['지휘중','건','건'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '5%', key : 'cmndSp', title : ['지휘중','명','명'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '5%', key : 'trsPer', title : ['송치율','송치율','송치율'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '5%', key : 'trsTotalPer', title : ['송치','%','%'], sort : true, move : true, resize : true,options:{format:{type:"string",rule:"@%"}}, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '5%', key : 'trs', title : ['송치','건','건'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '5%', key : 'trsSp', title : ['송치','명','명'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '5%', key : 'indict', title : ['송치','기소','건'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '5%', key : 'indictSp', title : ['송치','기소','명'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '5%', key : 'deindict', title : ['송치','불기소','건'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '5%', key : 'deindict', title : ['송치','불기소','명'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '5%', key : 'trans', title : ['송치','이송기중','건'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '5%', key : 'transSp', title : ['송치','이송기중','명'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '5%', key : 'disping', title : ['송치','처분중','건'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '5%', key : 'dispingSp', title : ['송치','처분중','명'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '5%', key : 'etc', title : ['송치','기타','건'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '5%', key : 'etcSp', title : ['송치','기타','명'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }
				
				],
			"frozencols" : 4,
		};
		QCELL.create(QCELLProp);
	
		listQcell = QCELL.getInstance("cell");


}

var J0104VOMap={
	sort : "",
	prsctTotalPer : "",
	prsct : "",
	prsctSp : "",
	invstTotalPer : "",
	invst : "",
	invstSp : "",
	cmndTotalPer : "",
	cmnd : "",
	cmndSp : "",
	trsPer : "",
	trsTotalPer : "",
	trs : "",
	trsSp : "",
	indict : "",
	indictSp : "",
	deindict : "",
	deindictSp : "",
	trans : "",
	transSp : "",
	disping : "",
	dispingSp : "",
	etc : "",
	etcSp : ""
};
//검색조건
var J0104SCMap = {
	"regStart" : ""
	,"regEnd" : ""
}