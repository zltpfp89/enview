var queryString="{}";
var qcell;
var sheet;
var list="";
var incSpNumList="";
$(document).ready(function(){
	goAjaxDefault("/sjpb/F/selectCridtaSpList.face", queryString, callBackFn_f_selectCridtaSpListSuccess,true);
});
//범죄수사자료조회대장 신규팝업이 뜬다.
function fn_f_selectCridtaSpList(){
	 var incNum = document.f_cridtaSpList.incNum.value;
	 var spNm = document.f_cridtaSpList.spNm.value;
	 var spIdNum_1= document.f_cridtaSpList.spIdNum_1.value;
	 var spIdNum_2 = document.f_cridtaSpList.spIdNum_2.value;
	 var spIdNum = '';
	 if((spIdNum_1 !='' && spIdNum_1 != null) || (spIdNum_2 !='' && spIdNum_2 != null)){
		 spIdNum = spIdNum_1+'-' + spIdNum_2;
	 }
	 
	 if((incNum=='' || incNum==null)&& (spNm=='' || spNm==null)&& (spIdNum==''||spIdNum==null)){
		 alert("검색조건을 입력하세요.");
		 return;
	 }else{
		
		 var searchSp = {
				 "incNum":incNum,
				 "spNm":spNm,
				 "spIdNum":spIdNum				 
		 };
		 goAjaxDefault("/sjpb/F/selectCridtaSpList.face", searchSp, callBackFn_f_selectCridtaSpListSuccess);
	 }
}

//범죄수사자료조회대장 신규팝업 리스트 화면 성공 함수
function callBackFn_f_selectCridtaSpListSuccess(data){
	if(data.qCell == ""|| data.qCell == null){
		
	}else{
		 $("#btnArea_pop").show();
	}
	
	//Base64 디코드
	$.each(data.qCell, function(i, dataTmp) {
		dataTmp.spIdNum = Base64.decode(dataTmp.spIdNum);
		dataTmp.spNm = Base64.decode(dataTmp.spNm);
	});
	
		var QCELLProp = {
				"parentid" : "sheetCridtaSpList",
				"id" : "qCellSpList",
				"data" : {
					"input" : data.qCell
				},
				"rowheader" : "sequence",
				"selectmode": "row",
				"columns" : [ 
					{ width : '5%', key : 'checkbox', title : [ '' ], type : 'checkbox',style : { data : { "background-color" : "gray" } }, options : { wholeselect : true }, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
	                { width : '15%', key: 'incNum',			title: ['사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
	                { width : '15%', key: 'indvCorpDivDesc',			title: ['구분'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
					{ width : '30%', key : 'spNm', title : [ '피의자명' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize18' } }, 
					{ width : '35%', key : 'spIdNum', title : [ '주민등록번호' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize18' } }	
					],
				"frozencols" : 5
			};
			QCELL.create(QCELLProp);
			sheet = QCELL.getInstance("qCellSpList");
			sheet.bind("click",eventPopUpFn);
	
}

//범죄수사경력조회 팝업창 클릭이벤트
function eventPopUpFn(e) {
	// 선택한 인덱스 가져오기
	var rowIdx = sheet.getIdx("row");
	var colIdx = sheet.getIdx("col");
	//셀 클릭 이벤트
	if(colIdx>1){
		if(JSON.stringify(sheet.getCellLabel(rowIdx,1)) == "true"){
			//클릭된 셀 클릭시 체크박스 체크 해제
			sheet.setCellData(rowIdx, 1, false);
		}else{
			//선택한 인덱스 체크박스 체크
			sheet.setCellData(rowIdx, 1, true);
		}
	}
	
}

//피의자 추가 팝업 확인시 범죄수사자료상세 아이템에 리스트값 보내줌
function fn_f_selectSendItemList(){
	var div=1;
	for(var i = 1; i <= sheet.getRows("data"); i++){
		if(JSON.stringify(sheet.getCellLabel(i,1)) == "true"){
			if(sheet.getRowData(i).indvCorpDiv != "2"){	//법인이 아닐경우
				incSpNumList += sheet.getRowData(i).incSpNum+",";
			}else if(sheet.getRowData(i).indvCorpDiv == "2"){ // 법인일경우
				div++;
			}
		}	
	}
	if(incSpNumList == "" && div != 1){
		alert("법인은 경력조회요청을 할 수 없습니다.");
	}else if(incSpNumList == "" && div == 1){
		alert("피의자를 선택해주세요.");
		return;
	}else{
		
		incSpNumList = incSpNumList.substr(0,incSpNumList.length-1);
		list = {
				incSpNumList : incSpNumList
		}
		if(div != 1){
			alert("법인은 뺴고 추가되었습니다.")
		}
				
		//팝업창을 닫고 피의자번호 보냄.
		window.parent.commonLayerPopup.closeLayerPopup(list);
	}
}

//피의자 추가 팝업창 닫기 이벤트
function fn_f_closeCridtaSpList(){
	window.parent.commonLayerPopup.closeLayerPopup();
}

//초기화 함수
function fn_f_init(form){
	$("#"+form)[0].reset();
}