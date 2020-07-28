$(document).ready(function(){
	$("#exceldownRcdBtn").click(function(){
		if(qcellRecords.getRows("data") == "0"){
			alert("다운로드할 검색결과가 없습니다.");
			return;
		}
		
		var properties = {
			filename : "수사기록철",
			totaldata : true,
			border : true,
			headershow : true,
			colwidth : true,
			huge : false
		};
		
		qcellRecords.excelDownload(properties);
	});
});

/* 수사기록철(금감원 2020.01.29 추가) */
var qcellRecords;
var rcdRowIdx;
var isNewRcd;

//수사기록철 파라미터 맵
var b0101RCMap = {		
	rcptNum : "" //접수번호
	,orderNum : "" //수사기록철 순서
	,rcdTitle : "" //수사기록철 서류표목
	,dictator : "" //수사기록철 진술자
	,rcdDate : "" //수사기록철 작성연월일
	,rcdPage : "" //수사기록철 페이지
	,isNewRcd : null
	,rowNum : null
}

function initB0101RCMap(){
	b0101RCMap = {		
		rcptNum : "" //접수번호
		,orderNum : "" //수사기록철 순서
		,rcdTitle : "" //수사기록철 서류표목
		,dictator : "" //수사기록철 진술자
		,rcdDate : "" //수사기록철 작성연월일
		,rcdPage : "" //수사기록철 페이지
		,isNewRcd : null
		,rowNum : null
	}
} 

//수사기록철 탭 선택 
function incRecordsTab(){
	initB0101RCMap();
	b0101RCMap.rcptNum = b0101VOMap.rcptNum;
	goAjax("/sjpb/B/incRecordsList.face", b0101RCMap, callBackIncRecordsTabSuccess);
}

//수사기록철 탭 선택 성공함수 
function callBackIncRecordsTabSuccess(data){
	var QCELLProp = {
        "parentid"  : "sheetRecords",
        "id"		: "qcellRecords",
        "data"		: {"input" : data.qCellRecords},
        "selectmode": "row",
        "columns"	: [
        	{width: '5%',	key: 'checkbox',  title: ['']		, type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
        	{width: '60%',	key: 'rcdTitle',  title: ['서류표목']  , sort:true, move:true, resize: true, styleclassname: {data: 'fontsize13'}},
        	{width: '10%',	key: 'dictator',  title: ['진술자']   , sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
        	{width: '15%',	key: 'rcdDate' ,  title: ['작성연월일'] , sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
        	{width: '10%',	key: 'pageNum' ,  title: ['정수']     , sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}
    	],
    	"pagenation" : {pageunit:10, unitlist: [10, 20, 30]},
    	"emptymessage" : "조회된 기록물철 목록이 없습니다."
    };
    
	QCELL.create(QCELLProp);
    qcellRecords = QCELL.getInstance("qcellRecords");
    qcellRecords.bind("click", eventFnRec);
    
    //추가, 삭제 버튼 사람짐 현상 때문에 추가
    $("#newRcdBtn").show();
    $("#delRcdBtn").show();
    $("#saveRcdBtn").show();
    
    //총 페이지 수 표시
    $("#total").html(data.totalPage);
    
//    if (qcellRecords.getRows("data") > 0) {
//    	//최초 로딩시
//    	if(isNull(rcdRowIdx)){	//rcdRowIdx이 없으면 첫번째줄 선택
//    		rcdRowIdx = 1;
//    		selectRecord(b0101VOMap.rcptNum, qcellRecords.getRowData(rcdRowIdx).orderNum);   		
//    	//수정 후, 로딩시
//    	}else{
//    		selectRecord(b0101VOMap.rcptNum, qcellRecords.getRowData(rcdRowIdx).orderNum);	//수사기록 상세화면 호출
//    	}
//    	
//    	//셀 선택 백그라운드 지정
//		qcellRecords.setRowStyle(rcdRowIdx, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");   
//    } else {
    	rcdRowIdx = data.size;
    	insertIncRecordsView();	//수사기록 신규 등록화면 호출
//    }
}

//사건기록철 셀 클릭 이벤트
function eventFnRec(e){
	//체크박스선택은 제외 
	if(qcellRecords.getIdx("col") != 0){
		//선택한 인덱스 가져오기
		rcdRowIdx = qcellRecords.getIdx("row");
		
		//qcellRecords 커스텀 스타일이 있는경우, 제거 
		qcellRecords.clearCellStyles();
		
		//기존 체크항목 해제와 새로 선택한 행 체크박스 선택
		qcellRecords.setRowStyle(rcdRowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
		
		//사건기록 상세 호출
		if (rcdRowIdx > 0) {
			selectRecord(qcellRecords.getRowData(rcdRowIdx).rcptNum, qcellRecords.getRowData(rcdRowIdx).orderNum);
		}
	}
}

//사건기록 상세를 가져온다.
function selectRecord(rcptNum, orderNum){
	isNewRcd = false;
	
	b0101RCMap = {
		rcptNum : rcptNum,
		orderNum : orderNum
	}
	
	goAjax("/sjpb/B/selectRecord.face", b0101RCMap, callBackSelectRecordSuccess);
}

//사건기록 상세 화면 콜백함수
function callBackSelectRecordSuccess(data){
	
	b0101RCMap = data.record;
	
	if(b0101RCMap == null){
		alert("사건기록을 가져오는 중 문제가 발생했습니다. 관리자에게 문의하세요.");
		return;
	}
	 
	var rcdHtml = new StringBuffer();
	 
	rcdHtml.append('<table class="list" cellpadding="0" cellspacing="0">	 ');											
	rcdHtml.append('   <colgroup>                                         ');
	rcdHtml.append('	     <col width="15%" />                             ');
	rcdHtml.append('	     <col width="35%" />                             ');
	rcdHtml.append('	     <col width="15%" />                             ');
	rcdHtml.append('	     <col width="35%" />                             ');
	rcdHtml.append('   </colgroup>                                        ');
	rcdHtml.append('   <tbody>                                            ');
	rcdHtml.append('	     <tr>                                            ');
	rcdHtml.append('		   <th class="C">서류표목<em class="red">*</em></th>                      ');
	rcdHtml.append('		   <td class="L"><input type="text" class="w100per" id="rcdTitle" name="rcdTitle" data-rcdTitle="" value="' + b0101RCMap.rcdTitle + '" data-always="y"/></td>                      ');
	rcdHtml.append('		   <th class="C">진술자</th>   ');
	rcdHtml.append('		   <td class="L"><input type="text" class="w100per" id="dictator" name="dictator" data-dictator="" value="' + (isNull(b0101RCMap.dictator) ? "" : b0101RCMap.dictator ) + '" /></td>  ');
	rcdHtml.append('	     </tr>    ');    
	rcdHtml.append('	     <tr>                                            ');
	rcdHtml.append('		   <th class="C">작성연월일</th>                      ');
	rcdHtml.append('		   <td class="L"><label for="rcdDate"></label><input type="text" class="w100per calendar" name="rcdDate" id="rcdDate" value="'+(isNull(b0101RCMap.rcdDate) ? "" : b0101RCMap.rcdDate )+'" data-type="date" data-optional-value="true" readonly /></td>  ');
	rcdHtml.append('		   <th class="C">페이지수<em class="red">*</em></th>   ');
	rcdHtml.append('		   <td class="L"><input type="text" class="w100per" id="rcdPage" name="rcdPage" data-rcdPage="" value="' + b0101RCMap.rcdPage + '" data-always="y"/> </td>  ');
	rcdHtml.append('	     </tr>    ');                                                  
	rcdHtml.append('   </tbody>                                            ');
	rcdHtml.append('</table>                                               ');
	 
	$("#tab_mini_m7_contents_sub").html(rcdHtml.toString());
//	parent.autoresize_iframe_portlet();
	$("#rcdDate").datepicker({
		dateFormat: "yy-mm-dd",
		changeMonth: true, // 월 변경 가능
		changeYear: true, // 년 변경 가능
		showMonthAfterYear: true,
		showButtonPanel: true,
		closeText:'닫기',
		currentText:'오늘' 
	});
}

//사건기록철 등록 화면을 노출한다. 
function insertIncRecordsView(){
	isNewRcd = true;

	var rcdHtml = new StringBuffer();
	
	rcdHtml.append('<table class="list" cellpadding="0" cellspacing="0">	 ');											
	rcdHtml.append('   <colgroup>                                         ');
	rcdHtml.append('	     <col width="15%" />                             ');
	rcdHtml.append('	     <col width="35%" />                             ');
	rcdHtml.append('	     <col width="15%" />                             ');
	rcdHtml.append('	     <col width="35%" />                             ');
	rcdHtml.append('   </colgroup>                                        ');
	rcdHtml.append('   <tbody>                                            ');
	rcdHtml.append('	     <tr>                                            ');
	rcdHtml.append('		   <th class="C">서류표목<em class="red">*</em></th>                      ');
	rcdHtml.append('		   <td class="L"><input type="text" class="w100per" id="rcdTitle" name="rcdTitle" data-rcdTitle="" value="" data-always="y"/></td>                      ');
	rcdHtml.append('		   <th class="C">진술자</th>   ');
	rcdHtml.append('		   <td class="L"><input type="text" class="w100per" id="dictator" name="dictator" data-dictator="" value="" /></td>  ');
	rcdHtml.append('	     </tr>    ');    
	rcdHtml.append('	     <tr>                                            ');
	rcdHtml.append('		   <th class="C">작성연월일</th>                      ');
	rcdHtml.append('		   <td class="L"><label for="rcdDate"></label><input type="text" class="w100per calendar" name="rcdDate" id="rcdDate" value="'+(isNull(b0101RCMap.rcdDate) ? "" : b0101RCMap.rcdDate )+'" data-type="date" data-optional-value="true" readonly /></td>  ');
	rcdHtml.append('		   <th class="C">페이지수<em class="red">*</em></th>   ');
	rcdHtml.append('		   <td class="L"><input type="text" class="w100per" id="rcdPage" name="rcdPage" data-rcdPage="" value="" data-always="y"/> </td>  ');
	rcdHtml.append('	     </tr>    ');                                                  
	rcdHtml.append('   </tbody>                                            ');
	rcdHtml.append('</table>                                               ');

	$("#tab_mini_m7_contents_sub").html(rcdHtml.toString());	
	//parent.autoresize_iframe_portlet();
	$("#rcdDate").datepicker({
		dateFormat: "yy-mm-dd",
		changeMonth: true, // 월 변경 가능
		changeYear: true, // 년 변경 가능
		showMonthAfterYear: true,
		showButtonPanel: true,
		closeText:'닫기',
		currentText:'오늘'
	});
}

//새로운 기록물 등록 버튼
function addRecord(){
	isNewRcd = true;
	
	$("#rcdTitle").val("");
	$("#dictator").val("");
	$("#rcdDate").val("");
	$("#rcdPage").val("");
}

//선택된 기록물 삭제 버튼
function removeRecord(){
	var recordList="";
	
	for(var i = 1; i <= qcellRecords.getRows("data"); i++){
		if(JSON.stringify(qcellRecords.getCellLabel(i,0)) == "true"){
			recordList += qcellRecords.getRowData(i).orderNum+",";
		}	
	}
	
	if(recordList == ""){
		alert("삭제할 목록을 선택해주세요.");
		return;
	}else{
		recordList = recordList.substr(0,recordList.length-1);
		
		if(confirm("선택한 목록을 기록물철에서 삭제하시겠습니까?")){
			if(recordList.length != 0){
				var splitData = recordList.split(',');
				var spChk=[];
				for(var i=0;i<splitData.length;i++){
					spChk.push(splitData[i]);
				}
				
				if(spChk.length == 0){
					alert("선택된 목록이 없습니다.");
				}else{
					b0101RCMap = {
						rcptNum : b0101VOMap.rcptNum,
						recordList : spChk
					}
					
					//삭제 후 
					goAjax("/sjpb/B/deleteRecordList.face", b0101RCMap, incRecordsTab);	
				}
			}
		}
	}
}

//기록물 저장 버튼
function saveRecord(){
	if($("#rcdTitle").val() == null || $("#rcdTitle").val() == "") {
		alert("서류표목을 입력해주세요.");
		return;
	} else if($("#rcdPage").val() == null || $("#rcdPage").val() == "") {
		alert("저장하려는 기록물의 페이지수를 입력해주세요.");
		return;
	}
	
	b0101RCMap.rcdTitle = $("#rcdTitle").val();
	b0101RCMap.dictator = $("#dictator").val();
	b0101RCMap.rcdDate = $("#rcdDate").val();
	b0101RCMap.rcdPage = $("#rcdPage").val();
	b0101RCMap.isNewRcd = isNewRcd;
	b0101RCMap.rowNum = rcdRowIdx;
	
	goAjax("/sjpb/B/saveRecord.face", b0101RCMap, incRecordsTab);
}