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
$(document).ready(function(){
	//팀장 역할인 경우
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
	//범죄수사자료조회 신규등록일 경우 
	if (SJPBRole.getHasAnyRole($("#taskRoleCd").val())){
		$("#addMngBtn").show();		
	} else {
		$("#addMngBtn").hide();
	}
	//범죄수사자료대장담당역할인 경우
	if(SJPBRole.getHasAnyRole("ROLE_MNG_BK")){
		$("#deleteMngBtn").show();//범죄수사자료대장 삭제버튼
		$("#prtMngBtn").show(); // 대장출력버튼
		$("#prtMngItemBtn").show(); // 아이템출력버튼
	}else{
		$("#deleteMngBtn").hide();
		$("#prtMngBtn").hide(); // 대장출력버튼
		$("#prtMngItemBtn").hide(); // 아이템출력버튼
	}
	
});

//버튼 클릭 이벤트
function setButtonEvent(){
	//신규버튼 클릭시 팝업창 띄움
	$("#addMngBtn").off("click").on("click", function() {
		f0101VOMap.f0101VOList = "";
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
		
		if($(this).data("trst-stat-nm") == "처리완료"){
			if($(this).data("recvio") == null){
				alert("수령자를 입력해주세요.");
				return;
			}
		}
		
		if(confirm($(this).data("trst-stat-nm")+"상태로 처리하시겠습니까?")==false){
			return;
		}else{
			tkSetting($(this));	
			fn_f_executeTask();[]
			fn_f_updateProcessCompt();

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
	f0101TKMap.recvIo = task.data("recvio");
}

// 화면 진입시 동작함
function pageInit() {

	if ($('#startday').val() != "") {
		f0101SCMap.startday = $('#startday').val();
	}
	if ($('#endDay').val() != "") {
		f0101SCMap.endDay = $('#endDay').val();
	}
	debugger;
	//범죄수사자료조회대장 리스트를 가지고 온다.
	goAjaxDefault("/sjpb/F/selectList.face", f0101SCMap, callBackFn_selectListSuccess);
}

//범죄수사자료조회관리대장 검색리스트를 가져온다. (ajax)
function fn_searchList() {
	queryString = $("#f_searchList").serialize();
	var d = document.f_searchList;
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
	goAjaxDefault("/sjpb/F/selectList.face", queryString, callBackFn_selectListSuccess);

}
//범죄수사자료조회대장 출력
function fn_f_prnMngReport() {
	queryString = $("#f_searchList").serialize();
	//수기수사자료표 검색 리스트 레포트 성공함수 호출
	goAjaxDefault("/sjpb/F/selectList.face", queryString, callBackFn_f_selectMngReportSuccess);
}
//범죄수사자료조회대장 아이템 출력
function fn_f_prnMngItemReport(){
	
	var mngMap = {
			mngBkSiNum : f0101VOMap.mngBkSiNum
			,userIdNm : $("#userIdNm").val()
	}
	debugger;
	goAjaxDefault("/sjpb/F/prnMngItemReport.face", mngMap, callBackFn_f_selectMngReportSuccess);
}
//범죄수사자료조회대장 검색 리스트 레포트 성공함수
function callBackFn_f_selectMngReportSuccess(data) {
	f0101RTMap.rexdataset = data.rexdataset;
	
	var xmlString = objectToXml(f0101RTMap);
	$("#reptNm").val("F0101.crf"); //레포트 파일명
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
				{ width : '15%', key : 'rcptIncNum', title : [ '사건번호' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '15%', key : 'inqDt', title : [ '조회일자' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '15%', key : 'inqNm', title : [ '조회자' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '15%', key : 'respNm', title : [ '담당수사관' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '15%', key : 'mngBkStatCdDesc', title : [ '조회상태' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '15%', key : 'recvNm', title : [ '수령자' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } } 
				],
			"frozencols" : 5,
		};
		QCELL.create(QCELLProp);
	
		listQcell = QCELL.getInstance("cell");
		listQcell.bind("click", eventFn);
		if (listQcell.getRows("data") > 0) {
			listQcell.setRowStyle(1, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
	        f0101VOMap.mngBkSiNum = listQcell.getRowData(1).mngBkSiNum;
	        if(listQcell.getRowData(1).mngBkStatCdDesc == "조회반려" && listQcell.getRowData(1).respIo == document.f_searchList.userID.value){
	        	//조회반려일경우 다시 재조회승인 가능하도록 한다.
	        	fn_f_selectReCridtaInqItemList(f0101VOMap.mngBkSiNum);
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
	fRowIdx = listQcell.getIdx("row");	
	
	var colIdx = listQcell.getIdx("col");
	//기존 체크박스 열번호
	var pastchk = listQcell.getIdx("row","focus","previous") == -1?1:listQcell.getIdx("row","focus","previous");

		//체크박스 모두 해제
//		for(var i = 1;i<=listQcell.getRows("data");i++){
//			if(listQcell.getCellLabel(i,1)==true){
//				//체크된 체크박스 체크 해제
//				listQcell.setCellData(i, 1, false);
//			}
//		}
	//기존 체크항목 해제
	listQcell.removeRowStyle(pastchk);

	//새로 선택한 행 스타일적용
	listQcell.setRowStyle(fRowIdx, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");

	f0101VOMap.mngBkSiNum = listQcell.getRowData(fRowIdx).mngBkSiNum;
	
	//상세 호출
	fn_f_selectTabcontent(selectTab,f0101VOMap.mngBkSiNum);
	
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
	
	//div 수령자선택 버튼 삭제
	$("#recvSearchBtnArea").empty();
	
	listQcell = QCELL.getInstance("cell");
	
	if(listQcell.getRows("data") > 0) {
        f0101VOMap.mngBkSiNum = listQcell.getRowData(fRowIdx).mngBkSiNum;      
		if(selectTab == "Cridta" || selectTab == null || selectTab == ""){
			if(listQcell.getRowData(fRowIdx).mngBkStatCdDesc == "조회반려" && listQcell.getRowData(fRowIdx).respIo == document.f_searchList.userID.value){
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
				{ width : '20%', key : 'spNm', title : [ '피의자명' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '20%', key : 'spIdNum', title : [ '주민번호' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '25%', key : 'inqPurp', title : [ '목적' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '10%', key : 'inqCout', title : [ '매수' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '25%', key : 'inqComn', title : [ '비고' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } } 
				
				],
			"frozencols" : 5,
		};

		QCELL.create(QCELLProp);
		itemQcell = QCELL.getInstance("qCellItem");
		$("#confmBtnArea").empty();
		//범죄수사자료조회담당 역할일경우
		if(listQcell.getRowData(fRowIdx).taskRoleCd == "ROLE_MNG_BK" && SJPBRole.getRoleMngBkYn()){
			var map = {
					mngBkSiNum : itemQcell.getRowData(1).mngBkSiNum,
					orgCd : itemQcell.getRowData(1).orgCd,
					taskroleCd : itemQcell.getRowData(1).taskroleCd
			}
			//승인자 리스트 찾기			
			goAjaxDefault("/sjpb/F/selectConfmId.face", map, callBackFn_f_selectInqireIdSuccess);
		}
		
		//팀장, 과장 승인일경우
		if((listQcell.getRowData(fRowIdx).taskRoleCd == "TIMHDER_role" && SJPBRole.getTimhderRoleYn()) || (listQcell.getRowData(fRowIdx).taskRoleCd == "DRHF_role" && SJPBRole.getDrhfRoleYn()) ){
			var map = {
					mngBkSiNum : itemQcell.getRowData(1).mngBkSiNum,
					orgCd : itemQcell.getRowData(1).orgCd,
					taskroleCd : itemQcell.getRowData(1).taskroleCd
			}
			//승인자 리스트 찾기		
			goAjaxDefault("/sjpb/F/selectConfmId.face", map, callBackFn_f_selectConfmIdSuccess);
		}

}
//조회반려일경우 범죄수사자료조회대장 아이템 리스트를 수정 가능할수있도록한다.
function fn_f_selectReCridtaInqItemList(mngBkSiNumData){
	mngBkSiNumMap = {
			mngBkSiNum : mngBkSiNumData
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
				{ width : '5%', key : 'checkbox', title : [ '' ], type : 'checkbox',style : { data : { "background-color" : "gray" } }, options : { wholeselect : true }, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '20%', key : 'spNm', title : [ '피의자명' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '20%', key : 'spIdNum', title : [ '주민번호' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '25%', key : 'inqPurp', title : [ '목적' ],type:'input', sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '10%', key : 'inqCout', title : [ '매수' ],type:'selectmenu',	options:{input:inqCoutData,itemcount:10}, sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '20%', key : 'inqComn', title : [ '비고' ],type:'input', sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } } 
				
				],
				"frozencols" : 5,
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

//팀장, 과장 승인일경우 성공함수. 승인자 리스트조회하여 버튼 그려줌. 
function callBackFn_f_selectConfmIdSuccess(data){
	
	for(var i=0;i<data.confmIdList.length;i++){
		if(data.confmIdList[i].userId == data.userId){
			var trst = data.trstList[0]; //승인버튼
			var rjct = data.trstList[1]; //반려버튼
			
			//승인자 버튼 영역에 버튼 그리기
			var confmBtnArea = new StringBuffer();
			confmBtnArea.append("		<a href='javascript:void(0);' class='btn_blue' id='trstBtn' data-task-num='"+trst.taskNum+"' data-trst-stat-nm='"+trst.trstStatNm+"' data-cri-stat-cd='"+trst.criStatCd+"' data-trst-stat-num='"+trst.trstStatNum+"' ><span>승인</span></a>");
			confmBtnArea.append("		<a href='javascript:void(0);' class='btn_white' id='rjctBtn' data-task-num='"+rjct.taskNum+"' data-trst-stat-nm='"+rjct.trstStatNm+"' data-cri-stat-cd='"+rjct.criStatCd+"' data-trst-stat-num='"+rjct.trstStatNum+"' ><span>반려</span></a>");
			$("#confmBtnArea").html(confmBtnArea.toString());	
		}
	}
}

//송치관일경우 성공함수. 승인자 리스트조회하여 버튼 그려줌.
function callBackFn_f_selectInqireIdSuccess(data){
//	for(var i=0;i<data.confmIdList.length;i++){
//		if(data.confmIdList[i].userId == data.userId){
			var inqire = data.trstList[0];
			if(inqire != null){	
				if(inqire.criStatCd == 05){
					$("#recvSearchBtnArea").append("<span class='title'>수령자&nbsp; : &nbsp; </span><label for='recvNm'></label><input type='text' name='recvNm' id='recvNm' class='w35per' readonly/>");
					$("#recvSearchBtnArea").append("<a href='javascript:fn_f_setRecvNm();' class='btn_blue'><span>검색</span></a>");
					$("#recvSearchBtnArea").append("<input type='hidden' name='recvIo' id='recvIo'/>");
				}
				
				//승인자 버튼 영역에 버튼 그리기
				var confmBtnArea = new StringBuffer();
				confmBtnArea.append("		<a href='javascript:void(0);' class='btn_blue' id='inqireBtn' data-task-num='"+inqire.taskNum+"' data-trst-stat-nm='"+inqire.trstStatNm+"' data-cri-stat-cd='"+inqire.criStatCd+"' data-trst-stat-num='"+inqire.trstStatNum+"' ><span>"+inqire.trstStatNm+"</span></a>");
				$("#confmBtnArea").html(confmBtnArea.toString());
				
				//iframe 사이즈조절
				autoResize();
//			}
//		}
	}
}

//수령자 팝업띄우기
function fn_f_setRecvNm(){
	commonLayerPopup.openLayerPopup('/sjpb/Z/layerMyPopupList.face?chkType=radio', "700px", "600px", callBackFn_f_SetRecvNmSuccess); //수령자
}

//수령자 추가 성공함수
function callBackFn_f_SetRecvNmSuccess(data){
	var JsonData = JSON.parse(data);
	
	//ID 셋팅 
	$("#inqireBtn").attr("data-recvio",JsonData.person[0].userId);
	
	//이름 셋팅 
	$("#recvNm").val(JsonData.person[0].userName);

}
//피의자 추가 팝업 확인시 범죄수사자료 아이템에 추가
function fn_f_selectAddCriDtaSpList(SpListData){
	selectTab = "Cridta";
	$("#intiIncTab").trigger('click');
	$("#mngTab").show();
	debugger;
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
		if(spChk == ""){
			alert("중복된 피의자이거나 법인입니다. 다시선택해주세요.");
		}else{
			if(spChk.length != splitData.length){
				alert("법인과 중복된 피의자를 제외하고 피의자 추가되었습니다.");
			}
			var list = {
					incSpNumList : spChk
			}
			//피의자 추가 팝업 확인시 범죄수사자료 아이템에 추가 성공 함수 호출
			goAjaxDefault("/sjpb/F/selectAddSpList.face", list, callBackFn_f_selectAddCriDtaSpListSuccess);	
		}
	}
}

//피의자 추가 팝업 확인시 범죄수사자료 아이템에 추가 성공
function callBackFn_f_selectAddCriDtaSpListSuccess(data){	
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
				"input" : data.qCell
			},
			"rowheader" : "sequence",
			"selectmode" : "row",
			"columns" : [ 
				{ width : '20%', key : 'spNm', title : [ '피의자명' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '20%', key : 'spIdNum', title : [ '주민번호' ], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '20%', key : 'inqPurp', title : [ '조회목적' ], type:'input', sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '20%', key : 'inqCout', title : [ '매수' ], type:'selectmenu',	options:{input:inqCoutData,itemcount:10}, sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } },
				{ width : '20%', key : 'inqComn', title : [ '비고' ], type:'input', sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } } 
				
				],
			"frozencols" : 5,
		};
		QCELL.create(QCELLProp);
		qCellSpItem = QCELL.getInstance("qCellSpItem");

		addSpList = f0101VOMap.f0101VOList
		//기존에 있던 피의자리스트 열추가
		if(addSpList != ""){
			qCellSpItem.addRows(addSpList);
		}
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
		alert("등록에 성공하였습니다.");
		
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
	qCellReItem.deleteRowsEx(inqire);
}

function callBackFn_f_deleteReInqireSpSuccess(i,data){
	if(i!=data){
		alert("피의자 삭제에 실패하였습니다.");
	}
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
	//리스트 재조회
	fn_searchList()
}
//경력조회중 버튼 클릭시 조회일자, 조회자 update
function fn_f_updateMngBkInqire(){
	goAjax("/sjpb/F/updateMngBkInqire.face", f0101TKMap, function(data){callBackFn_f_updateMngBkInqireSuccess(data)});
}
//경력조회중 버튼 클릭시 조회일자, 조회자 update 성공함수
function callBackFn_f_updateMngBkInqireSuccess(data){
	if(data == '1'){
		alert("경력조회 처리되었습니다.");
	}else{
		alert("처리에 실패하였습니다.");
	}
}

//처리완료 버튼 클릭시 매수, 수신수사관, 수신일자 update
function fn_f_updateProcessCompt(){
	goAjax("/sjpb/F/updateProcessCompt.face", f0101TKMap, callBackFn_f_updateProcessComptSuccess);
}


//버튼 클릭시 매수, 수신수사관, 수신일자 update 성공함수
function callBackFn_f_updateProcessComptSuccess(data){
	if(data == '1'){
		alert("처리 완료되었습니다.");
	}else{
		alert("처리에 실패하였습니다.");
	}
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
	,recvIo: ""		 //수신수사관
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
	,recvIo : ""
}
//리포트맵
var f0101RTMap = {
	rexdataset : null
}
