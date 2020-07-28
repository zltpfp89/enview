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
	
	setAreaMap($("#j_searchList"), J0106SCMap);
	J0106SCMap.fdCdArray = fdCdArray.toString();
	J0106SCMap.year = new Date().getFullYear();
	//페이지 진입시 분야별 송치 및 지휘(건/명) 출력시 성공함수 호출
	goAjaxDefault("/sjpb/J/J0106List.face",J0106SCMap,callBackFn_selectListSuccess);
	day = J0106SCMap.year.toString();
	//excel다운로드
	$("#exceldown").click(function(){
		
		var properties = {
				filename: "분야별_송치_및_지휘수사현황_"+day,
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
//분야별 송치 및 지휘(건/명) 검색리스트를 가져온다. (ajax)
function fn_searchList() {
	setAreaMap($("#j_searchList"), J0106SCMap);
	
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
	J0106SCMap.fdCdArray = fdCdArray.toString();
	
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
	
	J0106SCMap.year = d.year.value;
	if(J0106SCMap.regStart != '' && J0106SCMap.regStart != ' ' && J0106SCMap.regStart != null){
		day = J0106SCMap.regStart.toString()+"~"+J0106SCMap.regEnd.toString()
	}else if(J0106SCMap.year != '' && J0106SCMap.year != ' ' && J0106SCMap.year != null){
		day = J0106SCMap.year.toString();
	}
	//분야별 송치 및 지휘(건/명) 리스트를 가지고 온다.
	goAjaxDefault("/sjpb/J/J0106List.face", J0106SCMap, callBackFn_selectListSuccess);

}

//분야별 송치 및 지휘(건/명) 리스트 성공함수. (ajax)
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
				{ width : '10%', key : 'sort', title : ['구분\n'+day,'구분\n'+day,'구분\n'+day,'구분\n'+day], sort : true, move : false, resize : false, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'prsctTotalPer', title : ['입건','%','%','%'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'prsct', title : ['입건','건','건','건' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'prsctSp', title : ['입건','명','명','명'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'invstTotalPer', title : ['수사중','%','%','%'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'invst', title : ['수사중','건','건','건'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'invstSp', title : ['수사중','명','명','명'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'cmndPer', title : ['지휘율(%)','지휘율(%)','지휘율(%)','지휘율(%)'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'cmndTotalPer', title : ['지휘중','%','%','%'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'cmnd', title : ['지휘중','건','건','건'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'cmndSp', title : ['지휘중','명','명','명'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'trsPer', title : ['송치율(%)','송치율(%)','송치율(%)','송치율(%)'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'trsTotalPer', title : ['송치','%','%','%'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'trs', title : ['송치','건','건','건'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'trsSp', title : ['송치','명','명','명'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'indictOld', title : ['송치','기소','구약식','건'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'indictOldSp', title : ['송치','기소','구약식','명'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'indictTri', title : ['송치','기소','구공판','건'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'indictTriSp', title : ['송치','기소','구공판','명'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'deindictSus', title : ['송치','불기소','기소유예','건'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'deindictSusSp', title : ['송치','불기소','기소유예','명'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'deindictRgt', title : ['송치','불기소','공소권없음','건'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'deindictRgtSp', title : ['송치','불기소','공소권없음','명'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'deindictDesus', title : ['송치','불기소','혐의없음','건'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'deindictDesusSp', title : ['송치','불기소','혐의없음','명'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'trans', title : ['송치','타관이송\n기소중지','건','건'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'transSp', title : ['송치','타관이송\n기소중지','명','명'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'disping', title : ['송치','처분중','건','건'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'dispingSp', title : ['송치','처분중','명','명'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'etc', title : ['기타\n(고소취하,\n수사중지)','기타\n(고소취하,\n수사중지)','건','건'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'etcSp', title : ['기타\n(고소취하,\n수사중지)','기타\n(고소취하,\n수사중지)','명','명'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }
				
				],
			"frozencols" : 7,
		};
		QCELL.create(QCELLProp);
	
		listQcell = QCELL.getInstance("cell");


}

var J0106VOMap={
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
	indictOld : "",
	indictOldSp : "",
	indictTri : "",
	indictTriSp : "",
	deindictSus : "",
	deindictSusSp : "",
	deindictRgt : "",
	deindictRgtSp : "",
	deindictDesus : "",
	deindictDesusSp : "",
	trans : "",
	transSp : "",
	disping : "",
	dispingSp : "",
	etc : "",
	etcSp : ""
};
//검색조건
var J0106SCMap = {
	"regStart" : ""
	,"regEnd" : ""
	,"fdCdArray" : ""
	,"year" : ""
}