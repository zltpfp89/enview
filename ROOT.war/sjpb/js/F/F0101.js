var queryString="{}";
var incSpNumList = new Array();
var mngBkSiNumMap;
var selectTab;
var listQcell;
var itemQcell;
var qCellItem;
var qCellSpItem;
var fRowIdx=1;
var addSpList="";
var deleteSp=[];
var addItemList=[];
var addItemRow;
var deleteCount=0;
$(document).ready(function(){
	//팀장,서무 역할인 경우
	if(SJPBRole.getHasAnyRole("TIMHDER_role")){
		f0101SCMap.mngBkStatCd="01";//승인요청상태
	}
	//과장 역할인 경우
	if(SJPBRole.getHasAnyRole("DRHF_role")){
		f0101SCMap.mngBkStatCd="02";//팀장승인상태
	}
	//범죄수사자료조회 역할인 경우
	if(SJPBRole.getHasAnyRole("ROLE_MNG_BK")){
		f0101SCMap.mngBkStatCd="03";//승인완료상태
	}
	
	//리스트 출력
	pageInit();
	//버튼 클릭 이벤트
	setButtonEvent();
	
	//역할에 맞는 버튼만 보이도록 처리

	//범죄수사자료대장담당역할인 경우
	if(SJPBRole.getHasAnyRole("ROLE_MNG_BK")){
		$("#deleteMngBtn").show();//범죄수사자료대장 삭제버튼
		$("#F0101prtMngBtn").show(); // 회보대장 출력버튼
		$("#F0102prtMngBtn").show(); // 의뢰대장 출력버튼
	}else{
		//범죄수사자료조회 신규등록일 경우 수사관만 가능
		if (SJPBRole.getHasAnyRole("INVIGTOR_role")){
			$("#addMngBtn").show();		
		} else {
			$("#addMngBtn").hide();
		}
		$("#deleteMngBtn").hide();
		$("#F0101prtMngBtn").hide(); // 회보대장 출력버튼
		$("#F0102prtMngBtn").hide(); // 의뢰대장 출력버튼
	}
	
});

//버튼 클릭 이벤트
function setButtonEvent(){
	//신규버튼 클릭시 팝업창 띄움
	$("#addMngBtn").off("click").on("click", function() {
		addSpList = "";
		f0101VOMap.f0101VOList="";
		addItemList=[];
		commonLayerPopup.openLayerPopup('/sjpb/F/F0301.face', "1050px", "550px", fn_f_selectAddCriDtaSpList);		
	});
		
	
	//승인 이력탭 클릭시
	$("#taskHistTab").on("click", function() {
		selectTab = "Task";
		mngBkSiNumMap = {
			rcptNum : f0101VOMap.mngBkSiNum
		}
		goAjaxDefault("/sjpb/Z/selectIncTaskHist.face", mngBkSiNumMap, callBackFn_f_selectIncTaskHistSuccess);
	});

	//승인취소 버튼 클릭시
	$(document).on("click","#concealBtn",function(){
		
		if(confirm($(this).data("trst-stat-nm")+"상태로 처리하시겠습니까?")==false){
			return;
		}else{
			tkSetting($(this));	
			fn_f_executeTask();

		}
	});
	
	//승인버튼 클릭시
	$(document).on("click","#trstBtn",function(){
		if(confirm($(this).data("trst-stat-nm")+"상태로 처리하시겠습니까?")==false){
			return;
		}else{
			tkSetting($(this));
			fn_f_executeTask();
		}
	});
	
	//반려버튼 클릭시
	$(document).on("click","#rjctBtn",function(){
		if(confirm($(this).data("trst-stat-nm")+"상태로 처리하시겠습니까?")==false){
			return;
		}else{
			tkSetting($(this));
			fn_f_executeTask();
		}
	});
	
	//처리완료 버튼 클릭시
	$(document).on("click","#inqireBtn",function(){
		
		if(confirm($(this).data("trst-stat-nm")+"상태로 처리하시겠습니까?")==false){
			return;
		}else{
			tkSetting($(this));	
			fn_f_executeTask();
//			fn_f_updateProcessCompt();

		}
	});
}

//타스크 세팅
function tkSetting(task){
	var userID = document.f_searchList.userID.value;
	f0101TKMap.rcptNum = f0101VOMap.mngBkSiNum;
	f0101TKMap.mngBkSiNum = f0101VOMap.mngBkSiNum;
	f0101TKMap.taskNum = task.data("task-num");
	f0101TKMap.trstStatNm = task.data("trst-stat-nm");
	f0101TKMap.trstStatNum = task.data("trst-stat-num");
	f0101TKMap.taskRespMb = userID;
	f0101TKMap.criStatCd = task.data("cri-stat-cd");
	f0101TKMap.regUserId = userID;
	f0101TKMap.updUserId = userID;
}

// 화면 진입시 동작함
function pageInit() {

	if ($('#startday').val() != "") {
		f0101SCMap.startday = $('#startday').val();
	}
	if ($('#endDay').val() != "") {
		f0101SCMap.endDay = $('#endDay').val();
	}

	//범죄수사자료조회대장 리스트를 가지고 온다.
	goAjaxDefault("/sjpb/F/selectList.face", f0101SCMap, callBackFn_selectListSuccess);
}

//범죄수사자료조회관리대장 검색리스트를 가져온다. (ajax)
function fn_searchList() {
	setAreaMap($("#f_searchList"), f0101SCMap);
	f0101SCMap.mngBkStatCd = $("#mngBkStatCd").val();
	f0101SCMap.criTmIdSC = $("#criTmIdSC").val();
	var d = document.f_searchList;
	f0101SCMap.spIdNum = f0101SCMap.spIdNum_1 +'-'+f0101SCMap.spIdNum_2;
	if (d.startDay.value != ' ' || d.startDay.value != null
			|| d.endDay.value != ' ' || d.endDay.value != null) {
		if (d.startDay.value != ' ' && d.startDay.value != null
				&& d.endDay.value != ' ' && d.endDay.value != null) {
			if (d.startDay.value > d.endDay.value) {
				alert("시작일이 종료일보다 큽니다. 다시 설정해주세요.");
				return ;
			}
		} else {
			alert("기간을 입력해주세요.");
			return ;
		}
	}
	
	//범죄수사자료조회대장 리스트를 가지고 온다.
	goAjaxDefault("/sjpb/F/selectList.face", f0101SCMap, callBackFn_selectListSuccess);

}
//범죄수사자료 조회회보 대장 출력
function fn_F0101_prnMngReport() {
	var mngBkSiNumList = [];
	for(var i = 1; i <= listQcell.getRows("data"); i++){
		if(JSON.stringify(listQcell.getCellLabel(i,1)) == "true"){
			mngBkSiNumList.push(listQcell.getRowData(i).mngBkSiNum);
		}	
	}
	var mngBkSiNumListMap = {
			"mngBkSiNumList":mngBkSiNumList
	}
	debugger;
	if(mngBkSiNumList.length != 0){
		//구속영장신청부 리스트 레포트 성공함수 호출
		goAjaxDefault("/sjpb/F/prnMngReport.face", mngBkSiNumListMap, callBackFn_F0101_MngReportSuccess);
	}else{
		alert("출력할 대상을 선택해주세요.");
		return;
	}
	
}

//범죄수사자료 조회회보 대장 검색 리스트 레포트 성공함수
function callBackFn_F0101_MngReportSuccess(data) {
	f0101RTMap.rexdataset = data.rexdataset;
	
	var xmlString = objectToXml(f0101RTMap);
	$("#reptNm").val("F0101.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);

	//레포트 호출
	openReportService(reportForm);  
}


//범죄수사자료 조회의뢰 대장 출력
function fn_F0102_prnMngReport() {
	var mngBkSiNumList = [];
	for(var i = 1; i <= listQcell.getRows("data"); i++){
		if(JSON.stringify(listQcell.getCellLabel(i,1)) == "true"){
			mngBkSiNumList.push(listQcell.getRowData(i).mngBkSiNum);
		}	
	}
	var mngBkSiNumListMap = {
			"mngBkSiNumList":mngBkSiNumList
	}
	
	if(mngBkSiNumList.length != 0){
		//구속영장신청부 리스트 레포트 성공함수 호출
		goAjaxDefault("/sjpb/F/prnMngReport.face", mngBkSiNumListMap, callBackFn_F0102_MngReportSuccess);
	}else{
		alert("출력할 대상을 선택해주세요.");
		return;
	}
}

//범죄수사자료 조회의뢰 대장 검색 리스트 레포트 성공함수
function callBackFn_F0102_MngReportSuccess(data) {
	f0101RTMap.rexdataset = data.rexdataset;
	
	var xmlString = objectToXml(f0101RTMap);
	$("#reptNm").val("F0102.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	
	//레포트 호출
	openReportService(reportForm);  
}

// 범죄수사자료조회관리대장 리스트 성공함수. (ajax)
function callBackFn_selectListSuccess(data){
	if(data.qCell ==""){
		$("#mngTab").hide();
		f0101VOMap.mngBkSiNum = ""; // 범죄수사자료관리대방 일련번호 초기화
	}else{
		$("#mngTab").show();
	}
	var QCELLProp = {
			"parentid" : "sheet",
			"id" : "cell",
			"data" : {
				"input" : data.qCell
			},
			"rowheader" : "sequence",
			"selectmode": "row",
			"columns" : [ 
				{ width : '5%',  key : 'checkbox', title : [ '' ], type : 'checkbox',style : { data : { "background-color" : "gray" } }, options : { wholeselect : true }, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '25%', key : 'respNm', title : [ '담당수사관' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '20%', key : 'inqNm', title : [ '조회자' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '25%', key : 'inqDt', title : [ '조회일자' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '25%', key : 'mngBkStatCdDesc', title : [ '조회상태' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }
				],
			"frozencols" : 5,
		};
		QCELL.create(QCELLProp);
	
		listQcell = QCELL.getInstance("cell");
		listQcell.bind("click", eventFn);
		if (listQcell.getRows("data") > 0) {
//			listQcell.setRowStyle(1, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");   
			if(listQcell.getIdx("col") != 0){
				listQcell.setRowStyle(1, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");   
        		//isInitStyleQcell = true;
        	}
			fRowIdx=1;
	        f0101VOMap.mngBkSiNum = listQcell.getRowData(1).mngBkSiNum;

	        if(listQcell.getRowData(1).taskNum == "5" && listQcell.getRowData(1).respIo == document.f_searchList.userID.value){
	        	//조회반려일경우 다시 재조회승인 가능하도록 한다.
	        	fn_f_selectReCridtaInqItemList(listQcell.getRowData(1).mngBkSiNum);
	        }else{
	        	//상세 호출
	        	fn_f_selectTabcontent(selectTab,f0101VOMap.mngBkSiNum);		
	        }
		}
	

}

//범죄수사자료조회대장 셀클릭 이벤트
function eventFn(e) {
	//셀클릭시 범죄경력조회피의자리스트 초기화
	incSpNumList = new Array();
		
	// 선택한 인덱스 가져오기
	var colIdx = listQcell.getIdx("col");
	fRowIdx = listQcell.getIdx("row");	

	if(colIdx >0 && fRowIdx > 0){
		if(colIdx != 1){

			listQcell.clearCellStyles();
			listQcell.setRowStyle(fRowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");


		//체크박스 모두 해제
//		for(var i = 1;i<=listQcell.getRows("data");i++){
//			if(listQcell.getCellLabel(i,1)==true){
//				//체크된 체크박스 체크 해제
//				listQcell.setCellData(i, 1, false);
//			}
//		}	
			f0101VOMap.mngBkSiNum = listQcell.getRowData(fRowIdx).mngBkSiNum;
			
			//상세 호출
			fn_f_selectTabcontent(selectTab,f0101VOMap.mngBkSiNum);
		}
	}
}

//범죄수사상세탭 클릭시
function fn_f_selectIntiIncTab(){
	selectTab = "Cridta";
	mngBkSiNumMap = {
			mngBkSiNum : f0101VOMap.mngBkSiNum
	}
	fn_f_selectTabcontent(selectTab,f0101VOMap.mngBkSiNum);
}

//범죄수사상세, 승인이력 상세호출 함수
function fn_f_selectTabcontent(selectTab,Num){
	//피의자 리스트 초기화
	f0101VOMap.f0101VOList="";
	//삭제할 피의자 초기화
	deleteSp=[];

//	//div 수령자선택 버튼 삭제
//	$("#recvSearchBtnArea").empty();
	
	listQcell = QCELL.getInstance("cell");
	
	if(listQcell.getRows("data") > 0) {
        f0101VOMap.mngBkSiNum = listQcell.getRowData(fRowIdx).mngBkSiNum;      
		if(selectTab == "Cridta" || selectTab == null || selectTab == ""){

			if(listQcell.getRowData(fRowIdx).taskNum == 5 && listQcell.getRowData(fRowIdx).respIo == document.f_searchList.userID.value){

				// 조회반려시 범죄수사자료조회관리대장 아이템 상세 호출
				fn_f_selectReCridtaInqItemList(f0101VOMap.mngBkSiNum);
			}else{
				//범죄수사자료조회관리대장 아이템 상세 호출
				fn_f_selectCridtaInqItemList(Num);
			}
		}
		if(selectTab == "Task"){
			//승인이력 상세 호출
			fn_f_selectIncTaskHist(Num);
		}
	}
}

// 범죄수사자료조회대장 아이템 리스트를 가지고 온다
function fn_f_selectCridtaInqItemList(mngBkSiNumData){
    mngBkSiNumMap = {
    		mngBkSiNum : mngBkSiNumData
    }
	goAjaxDefault("/sjpb/F/selectCridtaInqItemList.face", mngBkSiNumMap, callBackFn_f_selectCridtaInqItemListSuccess);
}
// 범죄수사자료조회대장 아이템 리스트를 성공함수
function callBackFn_f_selectCridtaInqItemListSuccess(data){
	
	
	var QCELLProp = {
			"parentid" : "sheetItem",
			"id" : "qCellItem",
			"data" : {
				"input" : data.qCell
			},
			"rowheader" : "sequence",
			"selectmode": "row",
			"columns" : [ 
				{ width : '17%', key : 'rcptIncNum', title : [ '사건번호' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '17%', key : 'spNm', title : [ '피의자명' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '17%', key : 'spIdNum', title : [ '주민번호' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '17%', key : 'inqPurp', title : [ '목적' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '16%', key : 'inqCout', title : [ '매수' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '16%', key : 'inqComn', title : [ '비고' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } } 
				
				],
			"frozencols" : 5,
		};

		QCELL.create(QCELLProp);
		itemQcell = QCELL.getInstance("qCellItem");
		$("#confmBtnArea").empty();
		//승인 취소일 경우
		if(listQcell.getRowData(fRowIdx).taskNum == 2 && listQcell.getRowData(fRowIdx).respIo == $("#userID").val()){
			var num = listQcell.getRowData(fRowIdx).mngBkSiNum;
			
			//승인자 취소 버튼 영역에 버튼 그리기
			var confmBtnArea = new StringBuffer();
			confmBtnArea.append("		<a href='javascript:void();' id='concealBtn' class='btn_blue' data-task-num='2' data-trst-stat-nm='승인취소' data-cri-stat-cd='06' data-trst-stat-num='8' ><span>승인취소</span></a>");
			$("#confmBtnArea").html(confmBtnArea.toString());
			
		}
		
		//범죄수사자료조회담당 역할일경우
		if(listQcell.getRowData(fRowIdx).taskRoleCd == "ROLE_MNG_BK" && SJPBRole.getRoleMngBkYn()){
			
			var map = {
					mngBkSiNum : itemQcell.getRowData(1).mngBkSiNum,
					orgCd : itemQcell.getRowData(1).orgCd,
					taskroleCd : itemQcell.getRowData(1).taskroleCd
			}
			//타스크 세팅		
			goAjaxDefault("/sjpb/F/selectConfmId.face", map, callBackFn_f_selectInqireIdSuccess);
		}
		
		//팀장 승인일경우
		if(listQcell.getRowData(fRowIdx).taskRoleCd == "TIMHDER_role" && (SJPBRole.getTimhderRoleYn() || SJPBRole.getRoleGnlaffYn())){
			if(itemQcell.getRowData(1).orgCd == $("#userOrgCd").val()){
				var map = {
						mngBkSiNum : itemQcell.getRowData(1).mngBkSiNum,
						orgCd : itemQcell.getRowData(1).orgCd,
						taskroleCd : itemQcell.getRowData(1).taskroleCd
				}
				//타스크 세팅	
				goAjaxDefault("/sjpb/F/selectConfmId.face", map, callBackFn_f_selectConfmIdSuccess);
			}
		}
		//과장 승인일경우
		if((listQcell.getRowData(fRowIdx).taskRoleCd == "DRHF_role:SUB_DRHF_role" && ( SJPBRole.getDrhfRoleYn() || SJPBRole.getSubDrhfYn() ) ) ){
			
				var map = {
						mngBkSiNum : itemQcell.getRowData(1).mngBkSiNum,
						orgCd : itemQcell.getRowData(1).orgCd,
						taskroleCd : itemQcell.getRowData(1).taskroleCd
				}
				//타스크 세팅	
				goAjaxDefault("/sjpb/F/selectConfmId.face", map, callBackFn_f_selectConfmIdSuccess);

		}
		//iframe 사이즈조절
		autoResize();

}
function fn_f_updateConcealConfm(){
	
	if(confirm($(this).data("trst-stat-nm")+"상태로 처리하시겠습니까?")==false){
		return;
	}else{
		
//		f0101VOMap.mngBkSiNum;
		tkSetting($(this));	
		fn_f_executeTask();
	}
	
	//iframe 사이즈조절
	autoResize();
}
//조회반려일경우 범죄수사자료조회대장 아이템 리스트를 수정 가능할수있도록한다.
function fn_f_selectReCridtaInqItemList(mngBkSiNumData){
	mngBkSiNumMap = {
			"mngBkSiNum" : mngBkSiNumData
	}

	goAjaxDefault("/sjpb/F/selectCridtaInqItemList.face", mngBkSiNumMap, callBackFn_f_selectReCridtaInqItemListSuccess);
}
//조회반려일경우 범죄수사자료조회대장 아이템 리스트를 성공함수
function callBackFn_f_selectReCridtaInqItemListSuccess(data){

	var inqCoutData = [		// 매수
		{'label':'1', 'value':'1'},
		{'label':'2', 'value':'2'},
		{'label':'3', 'value':'3'},
		{'label':'4', 'value':'4'},
		{'label':'5', 'value':'5'},
		{'label':'6', 'value':'6'},
		{'label':'7', 'value':'7'},
		{'label':'8', 'value':'8'},
		{'label':'9', 'value':'9'},
		{'label':'10', 'value':'10'}
	]; 

	var QCELLProp = {
			"parentid" : "sheetItem",
			"id" : "qCellReItem",
			"data" : {
				"input" : data.qCell
			},
			"rowheader" : "sequence",
			"selectmode": "row",
			"columns" : [ 
				{ width : '4%', key : 'checkbox', title : [ '' ], type : 'checkbox',style : { data : { "background-color" : "gray" } }, options : { wholeselect : true }, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '16%', key : 'rcptIncNum', title : [ '사건번호' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '16%', key : 'spNm', title : [ '피의자명' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '16%', key : 'spIdNum', title : [ '주민번호' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '16%', key : 'inqPurp', title : [ '목적' ],type:'input',  sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '16%', key : 'inqCout', title : [ '매수' ],type:'selectmenu',	options:{input:inqCoutData,itemcount:10}, sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '16%', key : 'inqComn', title : [ '비고' ],type:'input', sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } } 
				
				],
				"frozencols" : 5
	};
	
	QCELL.create(QCELLProp);
	qCellReItem = QCELL.getInstance("qCellReItem");
	if(selectTab == "Cridta"){
		qCellReItem.bind("click",eventFnReItem);
	}
	
	//승인자 버튼 영역에 버튼 그리기
	var confmBtnArea = new StringBuffer();
	confmBtnArea.append("		<a href='javascript:fn_f_updateReInqireConfm();' class='btn_blue'><span>재조회승인요청</span></a>");
	confmBtnArea.append("		<a href='javascript:fn_f_deleteReInqireSp();' class='btn_white'><span>삭제</span></a>");
	$("#confmBtnArea").html(confmBtnArea.toString());
	
	//iframe 사이즈조절
	autoResize();
	
}
//경력재조회시 범죄수사자료상세 셀클릭 이벤트
function eventFnReItem(e) {
	var deRowIdx = qCellReItem.getIdx("row");
	var colIdx = qCellReItem.getIdx("col");
	if(deRowIdx == null){
		deRowIdx = 1;//초기값 설정
	}
	
	qcell.setRowStyle(deRowIdx, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
	
	//셀 클릭 이벤트
//	if(JSON.stringify(qCellReItem.getCellLabel(deRowIdx,1)) == "true"){
//		//클릭된 셀 클릭시 체크박스 체크 해제
//		qCellReItem.setCellData(deRowIdx, 1, false);
//	}else{
//		//선택한 인덱스 체크박스 체크
//		qCellReItem.setCellData(deRowIdx, 1, true);
//	}
	
}

//팀장, 과장 승인일경우 성공함수. 승인자 버튼 그려줌. 
function callBackFn_f_selectConfmIdSuccess(data){
	if(data != null){
		var trst = data.trstList[0]; //승인버튼
		var rjct = data.trstList[1]; //반려버튼
		
		//승인자 버튼 영역에 버튼 그리기
		var confmBtnArea = new StringBuffer();
		confmBtnArea.append("		<a href='javascript:void(0);' class='btn_blue' id='trstBtn' data-task-num='"+trst.taskNum+"' data-trst-stat-nm='"+trst.trstStatNm+"' data-cri-stat-cd='"+trst.criStatCd+"' data-trst-stat-num='"+trst.trstStatNum+"' ><span>승인</span></a>");
		confmBtnArea.append("		<a href='javascript:void(0);' class='btn_white' id='rjctBtn' data-task-num='"+rjct.taskNum+"' data-trst-stat-nm='"+rjct.trstStatNm+"' data-cri-stat-cd='"+rjct.criStatCd+"' data-trst-stat-num='"+rjct.trstStatNum+"' ><span>반려</span></a>");
		$("#confmBtnArea").html(confmBtnArea.toString());	
	}
	//iframe 사이즈조절
	autoResize();
}

//송치관일경우 성공함수. 승인자 버튼 그려줌.
function callBackFn_f_selectInqireIdSuccess(data){
	if(data != null){
		var trst = data.trstList[0];
		var rjct = data.trstList[1];

		
		//승인자 버튼 영역에 버튼 그리기
		var confmBtnArea = new StringBuffer();
		confmBtnArea.append("		<a href='javascript:void(0);' class='btn_blue' id='trstBtn' data-task-num='"+trst.taskNum+"' data-trst-stat-nm='"+trst.trstStatNm+"' data-cri-stat-cd='"+trst.criStatCd+"' data-trst-stat-num='"+trst.trstStatNum+"' ><span>"+trst.trstStatNm+"</span></a>");
		confmBtnArea.append("		<a href='javascript:void(0);' class='btn_white' id='rjctBtn' data-task-num='"+rjct.taskNum+"' data-trst-stat-nm='"+rjct.trstStatNm+"' data-cri-stat-cd='"+rjct.criStatCd+"' data-trst-stat-num='"+rjct.trstStatNum+"' ><span>반려</span></a>");
		$("#confmBtnArea").html(confmBtnArea.toString());
		
		//iframe 사이즈조절
		autoResize();

	}
}

////수령자 팝업띄우기
//function fn_f_setRecvNm(){
//	commonLayerPopup.openLayerPopup('/sjpb/Z/layerMyPopupList.face?chkType=radio', "700px", "600px", callBackFn_f_SetRecvNmSuccess); //수령자
//}

////수령자 추가 성공함수
//function callBackFn_f_SetRecvNmSuccess(data){
//	var JsonData = JSON.parse(data);
//	
//	//ID 셋팅 
//	$("#inqireBtn").attr("data-recvio",JsonData.person[0].userId);
//	
//	//이름 셋팅 
//	$("#recvNm").val(JsonData.person[0].userName);
//
//}
//피의자 추가 팝업 확인시 범죄수사자료 아이템에 추가
function fn_f_selectAddCriDtaSpList(SpListData){
	selectTab = "Cridta";
	$("#intiIncTab").trigger('click');
	$("#mngTab").show();
	
	if(SpListData != null){
		var splitData = SpListData.incSpNumList.split(',');
		var spChk=[];
		for(var i=0;i<splitData.length;i++){
			var reptChk = 0;
			
			//전값이 존재할때
			if(typeof(f0101VOMap.f0101VOList) == "object"){
				for(var j=0;j<f0101VOMap.f0101VOList.length;j++){
					// 피의자 중복제거
					
					
					if(f0101VOMap.f0101VOList[j].incSpNum != splitData[i]){
						reptChk++;
					}
					//중복 제거된 피의자 값만 넘겨줌
					if(reptChk == f0101VOMap.f0101VOList.length){
						spChk.push(splitData[i]);
					}
				}
			}else{  //전값이 존재하지 않을때
				spChk.push(splitData[i]);
			}
		}
		if(spChk.length == 0){
			alert("중복된 피의자입니다. 다시선택해주세요.");
		}else{
			if(spChk.length != splitData.length){
				alert("중복된 피의자를 제외하고 피의자 추가되었습니다.");
			}
			var list = {
					incSpNumList : spChk
			}
			
			//피의자 추가 팝업 확인시 범죄수사자료 아이템에 추가 성공 함수 호출
			goAjaxDefault("/sjpb/F/selectAddSpList.face", list, callBackFn_f_selectAddCriDtaSpListSuccess);	
			$("#recvSearchBtnArea").empty();
		}
	}
}

//피의자 추가 팝업 확인시 범죄수사자료 아이템에 리스트 성골함수 
function callBackFn_f_selectAddCriDtaSpListSuccess(data){	
	//매수 기본설정함수
	
	for(var i=0;i<data.qCell.length;i++){	
		data.qCell[i].inqCout = "1";
		addItemList.push(data.qCell[i]);
	}
	//매수 추가함수 큐셀로 그리기
	fn_f_showList(addItemList);
	addItemRow = addItemList.length;
	//iframe 사이즈조절
	autoResize();
}
//매수 추가함수 큐셀로 그리기
function fn_f_showList(data){
	
	var inqCoutData = [
		{'label':'1', 'value':'1'},
		{'label':'2', 'value':'2'},
		{'label':'3', 'value':'3'},
		{'label':'4', 'value':'4'},
		{'label':'5', 'value':'5'},
		{'label':'6', 'value':'6'},
		{'label':'7', 'value':'7'},
		{'label':'8', 'value':'8'},
		{'label':'9', 'value':'9'},
		{'label':'10', 'value':'10'}
		]; // 매수
	$("#sheetItem").empty();
	var QCELLProp = {
			"parentid" : "sheetItem",
			"id" : "qCellSpItem",
			"data" : {
				"input" : data
			},
			"rowheader" : "sequence",
			"selectmode" : "row",
			"columns" : [ 
				{ width : '5%', key : 'checkbox', title : [ '' ], type : 'checkbox',style : { data : { "background-color" : "gray" } }, options : { wholeselect : true }, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '16%', key : 'rcptIncNum', title : [ '사건번호' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '16%', key : 'spNm', title : [ '피의자명' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '16%', key : 'spIdNum', title : [ '주민번호' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '16%', key : 'inqPurp', title : [ '조회목적' ], type:'input', sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '15%', key : 'inqCout', title : [ '매수' ], type:'selectmenu',	options:{input:inqCoutData,itemcount:10}, sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } },
				{ width : '16%', key : 'inqComn', title : [ '비고' ], type:'input', sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } } 				
				],
			"frozencols" : 5,
		};
		QCELL.create(QCELLProp);
		qCellSpItem = QCELL.getInstance("qCellSpItem");
		addSpList = f0101VOMap.f0101VOList;
		
		//기존에 있던 피의자리스트 열추가
//		if(addSpList != ""){
//			qCellSpItem.addRows(addSpList);
//		}
		//지금있는 전체 피의자 리스트 저장
		f0101VOMap.f0101VOList = qCellSpItem.getData();
		

		//승인자 버튼 영역에 버튼 그리기
		var confmBtnArea = new StringBuffer();
		confmBtnArea.append("		<a href='javascript:fn_f_AddSpBtn();' class='btn_blue'><span>피의자 추가</span></a>");
		confmBtnArea.append("		<a href='javascript:fn_f_insertInqireConfm();' class='btn_blue'><span>조회승인요청</span></a>");
		confmBtnArea.append("		<a href='javascript:fn_f_deleteInqireSp();' class='btn_white'><span>삭제</span></a>");
		$("#confmBtnArea").html(confmBtnArea.toString());
}
function fn_f_AddSpBtn(){
	commonLayerPopup.openLayerPopup('/sjpb/F/F0301.face', "1050px", "550px", fn_f_selectAddCriDtaSpList);
}
//승인이력 리스트를 가지고 온다
function fn_f_selectIncTaskHist(mngBkSiNumData){
	mngBkSiNumMap = {
	    	rcptNum : mngBkSiNumData
	}
	 goAjaxDefault("/sjpb/Z/selectIncTaskHist.face", mngBkSiNumMap, callBackFn_f_selectIncTaskHistSuccess);
}
//승인이력 리스트 성공함수
function callBackFn_f_selectIncTaskHistSuccess(data){
	var QCELLProp = {
				"parentid" : "sheetConfm",
				"id" : "qCellConfm",
				"data" : {
					"input" : data.qCell
				},
				"rowheader" : "sequence",
				"selectmode": "row",
				"columns" : [ 
	                { width : '20%', key: 'taskNm',			title: ['단계'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
					{ width : '20%', key : 'trstStatNm', title : [ '확인' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
					{ width : '20%', key : 'nmKor', title : [ '승인자' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
					{ width : '20%', key : 'regDate', title : [ '요청일시' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
					{ width : '20%', key : 'taskComn', title : [ '비고' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }
					
					],
				"frozencols" : 5,
			};
			QCELL.create(QCELLProp);
	
}

//피의자 삭제
function fn_f_deleteInqireSp(){
	var inqire=[];
	for(var i = 1; i <= qCellSpItem.getRows("data"); i++){
		if(JSON.stringify(qCellSpItem.getCellLabel(i,1)) == "true"){
			inqire.push(i);
		}
	}
	qCellSpItem.deleteRowsEx(inqire);
}

//범죄수사자료 경력조회 조회요청 함수
function fn_f_insertInqireConfm(){	
	for(var i = 1; i <= qCellSpItem.getRows("data"); i++){
		if(qCellSpItem.getRowData(i).inqPurp == null || qCellSpItem.getRowData(i).inqPurp == '' || qCellSpItem.getRowData(i).inqPurp == ' '){
			alert("조회목적을 전부 입력해주세요.\n셀 더블클릭시 입력가능합니다.");
			return;
		}
		if(qCellSpItem.getRowData(i).inqCout ==null){
			alert("매수를 입력하세요.");
			return;
		}else{
			if(isNumber(qCellSpItem.getRowData(i).inqCout) == false){
				alert("매수에 숫자만 입력하세요.");
				return;
			}
		}
	}

	f0101VOMap.f0101VOList = qCellSpItem.getData();
	//범죄수사자료 경력조회요청 추가 성공함수 호출
	goAjax("/sjpb/F/insertInqireConfm.face", f0101VOMap,callBackFn_f_insertInqireConfmSuccess);
	//리스트 재조회
	pageInit();
	//피의자 리스트 초기화
	addSpList="";
	

}
//범죄수사자료 경력조회요청 추가 성공함수 
function callBackFn_f_insertInqireConfmSuccess(data){	
 	f0101VOMap = data;
	
	f0101TKMap.rcptNum = f0101VOMap.mngBkSiNum;
	f0101TKMap.mngBkSiNum = f0101VOMap.mngBkSiNum;
	f0101TKMap.taskNum = f0101VOMap.taskTrstVOList[0].taskNum;	
	f0101TKMap.trstStatNm = f0101VOMap.taskTrstVOList[0].trstStatNm;
	f0101TKMap.trstStatNum = f0101VOMap.taskTrstVOList[0].trstStatNum;
	f0101TKMap.taskRespMb = f0101VOMap.userId;
	f0101TKMap.criStatCd = f0101VOMap.taskTrstVOList[0].criStatCd;
	f0101TKMap.regUserId = f0101VOMap.userId;
	f0101TKMap.updUserId = f0101VOMap.userId;	
	f0101TKMap.taskHistNum = f0101VOMap.incTaskHistVOList[0].taskHistNum;
	
	//타스크 수행
	fn_f_executeTask();

	alert("범죄수사자료 등록에 성공하였습니다.");
	
}
//범죄수사자료 재경력조회 조회요청 함수
function fn_f_updateReInqireConfm(){
	for(var i = 1; i <= qCellReItem.getRows("data"); i++){
		if(qCellReItem.getRowData(i).inqPurp == null || qCellReItem.getRowData(i).inqPurp == '' || qCellReItem.getRowData(i).inqPurp == ' '){
			alert("조회목적을 전부 입력해주세요.\n셀 더블클릭시 입력가능합니다.");
			return;
		}
		if(qCellReItem.getRowData(i).inqCout ==null){
			alert("매수를 입력하세요.");
			return;
		}else{
			if(isNumber(qCellReItem.getRowData(i).inqCout) == false){
				alert("매수에 숫자만 입력하세요.");
				return;
			}
		}
		
	}
	
	//재경력조회 피의자 삭제
	$.each(deleteSp, function(i, item) {
		var Sp={
			"mngBkSiNum" : item.mngBkSiNum
			,"incSpNum" : item.incSpNum
		}
		//범죄수사자료 피의자 삭제 성공함수 호출
		goAjax("/sjpb/F/deleteReInqireSp.face", Sp,function(data){callBackFn_f_deleteReInqireSpSuccess(i,data)});
	});

	if(deleteCount != deleteSp.length){
		alert("피의자 삭제에 실패하였습니다. 시스템관리자에게 문의하세요.");
	}
	deleteCount = 0;
	f0101VOMap.f0101VOList = qCellReItem.getData();
	//범죄수사자료 재경력조회요청 추가 성공함수 호출
	goAjax("/sjpb/F/updateReInqireConfm.face", f0101VOMap, function(data){callBackFn_f_updateReInqireConfmSuccess(data,incSpNumList.length)});
	
}

//범죄수사자료 재경력조회요청 추가 성공함수
function callBackFn_f_updateReInqireConfmSuccess(data,len){	
	 	
	 	f0101VOMap = data;
		
		f0101TKMap.rcptNum = f0101VOMap.mngBkSiNum;
		f0101TKMap.mngBkSiNum = f0101VOMap.mngBkSiNum;
		f0101TKMap.taskNum = f0101VOMap.taskTrstVOList[0].taskNum;	
		f0101TKMap.trstStatNm = f0101VOMap.taskTrstVOList[0].trstStatNm;
		f0101TKMap.trstStatNum = f0101VOMap.taskTrstVOList[0].trstStatNum;
		f0101TKMap.taskRespMb = f0101VOMap.userId;
		f0101TKMap.criStatCd = f0101VOMap.taskTrstVOList[0].criStatCd;
		f0101TKMap.regUserId = f0101VOMap.userId;
		f0101TKMap.updUserId = f0101VOMap.userId;	
		f0101TKMap.taskHistNum = f0101VOMap.incTaskHistVOList[0].taskHistNum;

		fn_f_executeTask();
		alert("재조회신청에 성공하였습니다.");
		
		//삭제할 피의자 초기화
		deleteSp=[];
		
		//리스트 재호출
		fn_searchList()
}

//범죄수사자료 재경력조회 삭제할 피의자 저장
function fn_f_deleteReInqireSp(){
	var inqire=[];
	for(var i = 1; i <= qCellReItem.getRows("data"); i++){;
		if(JSON.stringify(qCellReItem.getCellLabel(i,1)) == "true"){
			deleteSp.push(qCellReItem.getRowData(i));
			inqire.push(i);
		}
	}
	if(qCellReItem.getRows("data") == inqire.length){
		alert("피의자를 전부 삭제할 수 없습니다.");
		return;
	}
	qCellReItem.deleteRowsEx(inqire);
}

function callBackFn_f_deleteReInqireSpSuccess(){

	deleteCount++;
}

//타스크 수행
function fn_f_executeTask(){
	goAjax("/sjpb/F/executeTask.face", f0101TKMap, function(data){callBackFn_f_executeTaskSuccess(data)});	
}
//타스크 수행 성공함수
function callBackFn_f_executeTaskSuccess(data){
	if(data != '1'){
		alert("처리에 실패하였습니다.");
	}
	
	if(f0101TKMap.taskNum == "4"){
		fn_f_updateProcessCompt();
	}else{
		//리스트 재조회
		fn_searchList();
	}
}


//처리완료 버튼 클릭시 조회자,조회일자 update
function fn_f_updateProcessCompt(){
	goAjax("/sjpb/F/updateProcessCompt.face", f0101TKMap, callBackFn_f_updateProcessComptSuccess);
}


//처리완료 성공함수
function callBackFn_f_updateProcessComptSuccess(data){
	if(data == '1'){
		alert("처리 완료되었습니다.");
	}else{
		alert("처리에 실패하였습니다.");
	}
	//리스트 재조회
	fn_searchList();
}

//범죄수사자료대장 삭제
function fn_f_deleteHawr(){
	var mngBkSiNumArr = [];
	for(var i = 1; i <= listQcell.getRows("data"); i++){
		if(JSON.stringify(listQcell.getCellLabel(i,1)) == "true"){
			mngBkSiNumArr.push(listQcell.getRowData(i).mngBkSiNum);
		}
	}
	
	//범죄수사자료대장 삭제 성공함수 호출	
	goAjaxDefault("/sjpb/F/deleteMngBkSiNum.face",{"mngBkSiNumArr":mngBkSiNumArr},function(data){callBackFn_f_deleteMngBkSiNumSuccess(data,mngBkSiNumArr.length)});
//	listQcell.deleteRowsEx(hawr);
//	goAjax("",hawr,);
}

//범죄수사자료대장 삭제 성공함수
function callBackFn_f_deleteMngBkSiNumSuccess(data,len){
	if(data == len){
		alert("범죄수사자료대장이 삭제되었습니다.");
		//리스트 재조회
		fRowIdx=1; // 열인덱스 초기화
		fn_searchList();
	}else{
		alert("범죄수사자료대장 삭제에 실패하였습니다.");
	}
}


//초기화 함수
function fn_f_init(form){
	$("#"+form)[0].reset();
	//select 값 초기화
	$("#"+form).find("select").each(function() {
		$(this).find("option:eq(0)").prop("selected", true);
		$(this).prev('.txt').text($(this).find('option:selected').text());
	});
	
	//검색맵 초기화
	f0101SCMap = {
		inqNm : ""       //조회수사관 이름
		,spNm : ""         //피의자 이름
		,spIdNum : ""      //주민등록번호
		,startDay : ""        //조회일자 시작일
		,endDay : ""       //조회일자 종료일
	    ,respNm : ""              // 의뢰자
	    ,criTmIdSC : ""         //담당수사팀
	    ,mngBkStatCd : ""          //내사상태
		,criDeptIdFT : ""        //담당수사과(필터조건)
		,criTmIdFT : ""          //담당수사과(필터조건)	
		,userIdNm : ""
	}	
}
function containCharOnly(input, chars){
   
	for (var i=0; i < input.length; i++){
          if (chars.indexOf(input.charAt(i)) == -1){
                 return false;
          }
    }
    return true;
}
//입력값이 숫자만 있는지 체크한다.
function isNumber(input){
    var chars = "0123456789";
    return containCharOnly(input, chars);
}

//아이템 리스트
var f0101VO={
		rcptNum : ""
		,mngBkSiNum : ""
		,recvIo : ""
		,mngBkComn : ""
		,incSpNum : ""
		,inqPurp: ""
		,inqCout : ""
}

var mngMap={
	mngBkSiNum : ""	       //관리대장 일련번호	
}


//범죄수사자료 관리대장
var f0101VOMap = {
    mngBkSiNum : ""	       //관리대장 일련번호
    ,mngBkPublYr : ""     //관리대장 발행년도
	,respIo : ""       //담당수사관
	,inqIo : ""      //조회수사관
	,recpDt : ""           //접수일자
	,inqDt : ""        //조회일자
	,recvDt : ""         //수신일자
	,mngBkStatCd : ""           //관리대장상태코드
	,mngBkComn : ""           //관리대장비고
	,mngBkStatCdDesc : ""      //수사상태설명
	,taskNum : ""         //활성타스크번호
	,taskNm : ""         //활성타스크이름
	,taskRespMb : ""      //활성타스크소유코드
	,nmKor : ""           //담당수사관
	,taskTrstVOList : null //타스크이행
	,regUserId : ""      //등록자
	,regDate : ""        //등록일자
	,updUserId : ""      //수정자
	,updDate : ""        //수정일자
}

//검색조건
var f0101SCMap = {
	rcptIncNum : ""		//사건번호
	,inqNm : ""			//조회수사관 이름
	,spNm : ""			//피의자 이름
	,spIdNum : ""		//주민등록번호
	,spIdNum_1 : ""		//주민등록번호
	,spIdNum_2 : ""		//주민등록번호
	,startDay : ""		//조회일자 시작일
	,endDay : ""		//조회일자 종료일
    ,respNm : ""		// 의뢰자
    ,criTmIdSC : ""		//담당수사팀
	,mngBkStatCd : ""	//내사상태
	,criDeptIdFT : ""	//담당수사과(필터조건)
	,criTmIdFT : ""	//담당수사과(필터조건)	
	,userIdNm : ""
}

//타스크
var f0101TKMap = {		
	wfNum : "9"				//WFID
	,rcptNum : ""			//접수번호
	,taskNum : ""			//활성타스크번호
	,trstStatNm : ""		//타스크이행명
	,trstStatNum : ""		//타스크이행번호
	,taskRespMb : ""		//타스크소유자	
	,taskComn : ""			//타스크코멘트
	,edDt : ""				//내사종료일자	criStatCd = 11(입건종결), 12(내사종결)
	,criStatCd : ""			//수사상태코드
	,regUserId : ""			//등록자
	,updUserId : ""			//수정자
}
//리포트맵
var f0101RTMap = {
	rexdataset : null
}
