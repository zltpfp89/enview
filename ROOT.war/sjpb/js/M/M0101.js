var qcell;

$(document).ready(function(){
	fn_e_pageInit();
        
});
//화면 진입시 동작함
function fn_e_pageInit(){
	var queryString ="{}";
	//수기수사자료표 성공함수 호출
	goAjaxDefault("/sjpb/M/selectList.face", queryString, callBackFn_e_selectListSuccess);
}
function callBackFn_e_selectListSuccess(data){
	var QCELLProp = {
            "parentid" : "listSheet",
            "id"		: "cell",
            "data"		: {"input" : data.qCell},
            "rowheader" : "sequence",
            "selectmode": "row",
            "columns"	: [
            	{width: '5%',	key: 'checkbox',			title: [''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '10%',	key: 'spNm',			title: ['번호','압수부'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '15%',	key: 'spIdNum',			title: ['번호','압수물'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '15%',	key: 'regDate',			title: ['범죄사건부번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '15%',	key: 'rltActCrinmCdDesc',			title: ['압수연월일'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '10%',	key: 'dvformDesc',			title: ['압수물건','품종'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '15%',	key: 'nmKor',			title: ['압수물건','수량'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '15%',	key: 'dtaTabComn',			title: ['소유자의 주거성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},	                	
            	{width: '15%',	key: 'dtaTabComn',			title: ['피압수자의 주거성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},	                	
            	{width: '15%',	key: 'dtaTabComn',			title: ['보관자 확인'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}	  ,              	
            	{width: '15%',	key: 'dtaTabComn',			title: ['취급자확인'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}	   ,             	
            	{width: '15%',	key: 'dtaTabComn',			title: ['처분','연월일'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}	    ,            	
            	{width: '15%',	key: 'dtaTabComn',			title: ['처분','요지'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}	     ,           	
            	{width: '15%',	key: 'Comn',			title: ['비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}	                	
            ]
            , "merge": {"header": "rowandcol"}
       		, "rowheader"	: "sequence"
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("qcell");
}