var qcell;
var queryString;
var qCellList=[];
var listRow;
$(document).ready(function(){
	fn_M0102_pageInit();     
});
//화면 진입시 동작함
function fn_M0102_pageInit(){
	qCellList=[];
	queryString = $("#m0102_searchList").serialize();
	goAjax("/sjpb/M/M0102selectList.face",queryString,callBackFn_M0102_selectListSuccess);
}
//압수부 리스트를 qCellList에 담는다.
function callBackFn_M0102_selectListSuccess(data){	
	for(var i=0;i<data.qCell.length;i++){
		qCellList.push(data.qCell[i]);
	}
	fn_M0102_showList(qCellList);
	listRow = qCellList.length;
}
//큐셀그리기
function fn_M0102_showList(data){
	var QCELLProp = {
            "parentid" : "listSheet",
            "id"		: "cell",
            "rowheader" : "sequence",
            "selectmode": "row",
            "columns"	: [
            	{width: '5%',	key: 'checkbox',			title: ['',''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '7%',	key: 'seizBkNum',			title: ['번호','압수부'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}, type: "html", options: {html: {data: fnData}}},
            	{width: '7%',	key: 'seizProdNum',			title: ['번호','압수물'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '7%',	key: 'rcptIncNum',			title: ['범죄사건부번호','범죄사건부번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '7%',	key: 'seizDt',	type:"input",			title: ['압수연월일','압수연월일'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'},options : {format: {type: "date", origin:"YYYYMMDD", rule: "YYYY-MM-DD"}}},
            	{width: '7%',	key: 'seizProdKind',	type:"input",			title: ['압수물건','품종'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '7%',	key: 'seizProdQnty',	type:"input",			title: ['압수물건','수량'], options:{limit:'number'},		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '8%',	key: 'ownrNm',	type:"input",			title: ['소유자의 주거성명','소유자의 성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},	                	
            	{width: '8%',	key: 'ownrAddr',	type:"input",			title: ['소유자의 주거성명','소유자의 주거'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},	                	
            	{width: '8%',	key: 'revIpdrNm',	type:"input",			title: ['피압수자의 주거성명','피압수자의 성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},	                	
            	{width: '8%',	key: 'revIpdrAddr',	type:"input",			title: ['피압수자의 주거성명','피압수자의 주거'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},	                	
            	{width: '8%',	key: 'csdnNm',	type:"input",			title: ['보관자 확인','보관자 확인'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},               	
            	{width: '8%',	key: 'trsrNm',		type:"input",		title: ['취급자확인','취급자확인'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},             	
            	{width: '7%',	key: 'dipDt',	type:"input",			title: ['처분','연월일'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'},options : {format: {type: "date", origin:"YYYYMMDD", rule: "YYYY-MM-DD"}} },            	
            	{width: '7%',	key: 'dipGist',	type:"input",			title: ['처분','요지'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}} ,          	
            	{width: '7%',	key: 'seizBkComn',	type:"input",			title: ['비고','비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}
            ],
            "merge": {"header": "rowandcol"},
       		"rowheader"	: "sequence",
       		"data" : {"input":data}
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("cell");
}
//새로운 row를 추가한다.
function fn_M0102_newSeiz(){
	//맵 초기화
	M0102VOMap = {
			"seizBkNum":""
			,"seizProdNum":""
			,"rcptIncNum":""
			,"seizDt":""
			,"seizProdKind":""
			,"seizProdQnty":""
			,"ownrNm":""
			,"ownrAddr":""
			,"revIpdrNm":""
			,"revIpdrAddr":""
			,"csdnNm":""
			,"trsrNm":""
			,"dipDt":""
			,"dipGist":""
			,"seizBkComn":""			
	}
	qCellList.push(M0102VOMap);
	fn_M0102_showList(qCellList);
	$("#btnDeleteSeiz").show(); // 열삭제버튼 보이기
	$("#btnNewSeiz").hide(); // 신규버튼 숨기기
}
function fn_M0102_newProd(){
	for(var i=2;i<qcell.getRows("data")+2;i++){
		if(JSON.stringify(qcell.getCellLabel(i,1)) == "true"){
			M0102VOMap = {
					"seizBkNum":""
					,"rcptIncNum":qcell.getRowData(i).rcptIncNum
					,"rcptNum":qcell.getRowData(i).rcptNum
					,"seizDt":""
					,"seizProdKind":""
					,"seizProdQnty":""
					,"ownrNm":qcell.getRowData(i).ownrNm
					,"ownrAddr":qcell.getRowData(i).ownrAddr
					,"revIpdrNm":qcell.getRowData(i).revIpdrNm
					,"revIpdrAddr":qcell.getRowData(i).revIpdrAddr
					,"csdnNm":""
					,"trsrNm":""
					,"dipDt":""
					,"dipGist":""
					,"seizBkComn":""			
			}
			qCellList.push(M0102VOMap);
			fn_M0102_showList(qCellList);
			//버튼보이기
			$("#btnDeleteSeiz").show(); // 열삭제버튼 보이기
			$("#btnInsertSeiz").show(); // 저장버튼 보이기
			$("#btnNewSeiz").hide(); // 신규버튼 숨기기
			$("#btnPrtSeiz").hide(); // 출력버튼 숨기기
			$("#btnNewProd").hide(); // 압수물추가버튼 숨기기
		}
	}
}
function fn_M0102_insertSeiz(){
	for(var i=listRow+2;i<qcell.getRows("data")+2;i++){
		goAjax("/sjpb/M/M0102selectList.face",qcell.getRowData(i),callBackFn_M0102_insertSeiz);
	}	
}
function fn_M0102_deleteSeiz(){
	qcell.deleteRow(listRow+2);
	$("#btnDeleteSeiz").hide(); // 열삭제버튼 숨기기
	$("#btnInsertSeiz").hide(); // 저장버튼 숨기기
	$("#btnNewSeiz").show(); // 신규버튼 보이기
	$("#btnPrtSeiz").show(); // 출력버튼 보이기
	$("#btnNewProd").show(); // 압수물추가버튼 보이기
}

function callBackFn_M0102_insertSeiz(data){
	alert("압수부가 등록되었습니다.");
	$("#btnDeleteSeiz").hide(); // 열삭제버튼 숨기기
	$("#btnInsertSeiz").hide(); // 저장버튼 숨기기
	$("#btnNewSeiz").show(); // 신규버튼 보이기
	$("#btnPrtSeiz").show(); // 출력버튼 보이기
	$("#btnNewProd").show(); // 압수물추가버튼 보이기
	fn_e_pageInit(); 
}
function fnData(id, row, col, val, obj){
	var html = '';
	if(val === '' || val == undefined){
		html = "<input type=\"button\" onclick='openDialog(\""+row+"\", \""+val+"\")' value=\"사건검색\"/>";
	}else {
		html = "<a href='javascript:openDialog(\""+row+"\", \""+val+"\", \""+obj+"\")'>"+val+"<a>";
	}
	return html;
}


function openDialog(row, val, obj){
	commonLayerPopup.openLayerPopup('/sjpb/M/AddIncMast.face', "1000px", "430px", function(data){ fn_M0102_addNewItem(data, row, obj) });
}

//검색을 통해서 신규사건을 추가한다.
function fn_M0102_addNewItem(data, row, obj) {

//	qcell.setCellData(parseInt(row),4,data[0].rcptIncNum);
	$("#btnDeleteSeiz").show(); // 열삭제버튼 보이기
	$("#btnInsertSeiz").show(); // 저장버튼 보이기
//	qcell.refresh();
	qcell.setRowData(parseInt(row),{"rcptIncNum":data[0].rcptIncNum,"rcptNum":data[0].rcptNum});

}

//압수부 출력
function fn_M0102_prtSeizReport() {
	//압수부 리스트 레포트 성공함수 호출
	goAjaxDefault("/sjpb/M/M0102selectList.face", queryString, callBackFn_M0102_prtSeizReportSuccess);
}

//압수부 리스트 레포트 성공함수
function callBackFn_M0102_prtSeizReportSuccess(data) {
	M0102RTMap.rexdataset = data.qCell;
	
	var xmlString = objectToXml(M0102RTMap);
	$("#reptNm").val("M0102.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	console.log(xmlString);
	//레포트 호출
	openReportService(reportForm);  
}


//초기화 함수
function fn_M0102_init(form){
	$("#"+form)[0].reset();	
}

var M0102VOMap = {
		"seizBkNum":""
		,"seizProdNum":""
		,"rcptIncNum":""
		,"seizDt":""
		,"seizProdKind":""
		,"seizProdQnty":""
		,"ownrNm":""
		,"ownrAddr":""
		,"revIpdrNm":""
		,"revIpdrAddr":""
		,"csdnNm":""
		,"trsrNm":""
		,"dipDt":""
		,"dipGist":""
		,"seizBkComn":""
		,"rcptNum":""
		,"rcptIncNum":""
}
//리포트맵
var M0102RTMap = {
	rexdataset : null
}