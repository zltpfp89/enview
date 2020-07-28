$(function(){
	pageInitA0302();
});

var a0302VOMap = new Object();
var countSp = 0;	//라디오박스 아이디 구분을 위해 커스텀

//화면 진입시 동작함
function pageInitA0302(){
	selectIncHist();
	eventSetupA0302();
}

//이벤트처리
function eventSetupA0302() {
	//닫기버튼
	$("#closBtn, img.btn_close").on("click", function() {
		window.close();
	});
}

//초기화
function initDataA0302(){
	$("#a0302ContentsAreaA").html("");
	$("#a0302ContentsAreaB").html("");
	$("#apprArea_EditButtons").html("");
	
	$("#apprArea02").hide();
}

//피의자 이력 정보 조회
function selectIncHist(){
	
	var incMfNum = $("#incMfNum").val();
	
	var reqMap = {
		incMfNum : incMfNum
	}

	goAjaxDefault("/sjpb/A/selctIncidentHist.face", reqMap, callBackSelectIncHistSuccess);
	
}

//피의자 이력 정보 조회 성공 콜백함수
function callBackSelectIncHistSuccess(data){
	
	//화면 초기화 
	
	initDataA0302();
	var spPrevHtml = new StringBuffer();	//수정전 데이터 담을 버퍼
	var spReqHtml = new StringBuffer();		//수정요청 데이터 담을 버퍼 
	
	var taskTrstVOSB = new StringBuffer();		//승인버튼 데이터 담을 버퍼 
	
	a0302VOMap = data.a0101VO;
	
	countSp = 0;	//라디오박스 아이디 구분을 위해 커스텀
	
	spPrevHtml = renderSpHtml(data, a0302VOMap.a0101VOList[0].incSpVOList, "이전<br/>");	//수정전 데이터
	spReqHtml = renderSpHtml(data, a0302VOMap.a0101VOList[1].incSpVOList, "수정<br/>");	//수정요청 데이터 
	
	$("#a0302ContentsAreaA").html(spPrevHtml.toString());	//수정전 Html
	$("#a0302ContentsAreaB").html(spReqHtml.toString());	//수정요청 Html
	
	areaSetReadOnly($("#a0302ContentsArea"));
	
	//피의자 이벤트 바인딩
	eventSpSetup();
	
	//현재 수정요청된 데이터에만 승인 버튼 노출함 
	if(a0302VOMap.incMfNum == $("#incMfNum").val()){
		
		//팀장, 서무의 경우 현재 로그인한 계정의 팀 사건만 승인버튼 노출함 2019.01.02
		
		//승인 버튼 노출여부 
		var isTrstBtnView = false;
		
		if(SJPBRole.getTimhderRoleYn() || SJPBRole.getRoleGnlaffYn()){
			if($("#orgCd").val() == a0302VOMap.criTmId){
				isTrstBtnView = true;
			}
			
		}else{
			isTrstBtnView = true;
		}
		
		if(SJPBRole.getSubDrhfYn() ){
			isTrstBtnView = true;
			
		}
		
		if(isTrstBtnView){
			//승인 버튼 노출
			$.each(a0302VOMap.taskTrstVOList, function(index, taskTrstVO) {
				if (SJPBRole.getHasAnyRole(taskTrstVO.taskRoleCd)) {	//역할에 맞는 버튼만 보이도록 처리
					taskTrstVOSB.append(" <a href=\"javascript:void(0);\" id=\"btn_"+taskTrstVO.trstStatNum+"\" class=\"btn_white\" name=\"trstBtn\" value=\""+taskTrstVO.trstStatNm+"\" data-trst-stat-nm=\""+taskTrstVO.trstStatNm+"\" data-trst-stat-num=\""+taskTrstVO.trstStatNum+"\" data-cri-stat-cd=\""+taskTrstVO.criStatCd+"\" data-wf-num=\""+taskTrstVO.wfNum+"\" data-always=\"y\"><span>"+taskTrstVO.trstStatNm+"</span></a> ");			
				}
			});
			
			//버튼 노출
			var trstBtnGroupHtml = taskTrstVOSB.toString();
			
			//승인인경우 
			// 1) 팀장이며(팀장 과장은 본인 수사팀 사건만 볼수 있음), 수사상태가 피의자수정팀장승인요청[16] 번일 경우
			// 2) 과장이며(팀장 과장은 본인 수사팀 사건만 볼수 있음), 수사상태가 피의자수정과장승인요청[17] 번일 경우
			//서무 추가 2019.01.02
			
			if (((SJPBRole.getTimhderRoleYn() || SJPBRole.getRoleGnlaffYn()) && a0302VOMap.criStatCd == "16") 
					|| ((SJPBRole.getDrhfRoleYn() || SJPBRole.getSubDrhfYn() )&& a0302VOMap.criStatCd == "17")) {
				$("#apprArea_EditButtons").html(trstBtnGroupHtml);
				$("#apprArea_EditButtons a:first").attr("class", "btn_blue");
				$("#taskNmTD").html(getTaskNm(a0302VOMap.taskNm));
				//$("#criArea02").hide();
				if (trstBtnGroupHtml != "") {
					$("#apprArea02").show();
				} else {
					$("#apprArea02").hide();
				}
				

				
				//결재의견만 활성화
				$("#taskComn").val("").attr("disabled",false);
			}
			
			if (SJPBRole.getInvigtorRoleYn() && a0302VOMap.criStatCd == "16") {
				$("#apprArea_EditButtons").html(trstBtnGroupHtml);
				$("#apprArea_EditButtons a:first").attr("class", "btn_blue");
				$("#taskNmTD").html(getTaskNm(a0302VOMap.taskNm));
				//$("#criArea02").hide();
				if (trstBtnGroupHtml != "") {
					$("#apprArea02").show();
					if(SJPBRole.getInvigtorRoleYn() ==true && SJPBRole.getRoleGnlaffYn()== false){
						$("#btn_11").hide();
					}
				} else {
					$("#apprArea02").hide();
				}
				$("#taskComn").val("").attr("disabled",false);
				
			}
			
			
			
			//타스크이행
			eventTaskBtnA0302();
			
		}
	}
}

//타스크 버튼 이벤트 
function eventTaskBtnA0302(){
	//타스크이행
	$("a[name=trstBtn]").off("click").on("click", function() {
		a0302TKMap.wfNum = $(this).data("wf-num");
		a0302TKMap.rcptNum = a0302VOMap.rcptNum;
		a0302TKMap.taskNum = a0302VOMap.taskNum;	
		a0302TKMap.trstStatNm = $(this).data("trst-stat-nm");
		a0302TKMap.trstStatNum = $(this).data("trst-stat-num");
		a0302TKMap.taskRespMb = $("#userId").val();
		a0302TKMap.taskComn = $("#taskComn").val();
		a0302TKMap.criStatCd = $(this).data("cri-stat-cd");
		a0302TKMap.regUserId = $("#userId").val(); 
		a0302TKMap.updUserId = $("#userId").val();

		if ($(this).parent('div.r_btn').attr("id") == "apprArea_EditButtons") { //승인자
			executeTaskA0302();
		}
	});	
}

//워크플로우 상태이행처리
function executeTaskA0302(callbackFunction){
	goAjax("/sjpb/A/executeTask.face", a0302TKMap, function(data){ callBackexecuteTaskA0302Success(data, callbackFunction)});
}

//워크플로우 상태이행처리 콜백처리
function callBackexecuteTaskA0302Success(data, callbackFunction) {
	//console.log(JSON.stringify(data));
	alert("정상적으로 처리되었습니다.");
	
	//변경된 상태 저장 
	a0302VOMap.criStatCd = data.criStatCd;
	
	//재조회 
	if (typeof callbackFunction == "function") {
		callbackFunction(data);
	}else{
		//재조회
		//selectIncHist();
		
		//승인창 닫기 
		window.close();
	}
}



function inita0302TKMap(){
	a0302TKMap = {		
			//wfNum : SJPBRole.getTrnsrRoleYn() ? "3" : "2"	//WFID [송치관 : 3, 수사관,과장,팀장 : 2]
			wfNum : ""	//WFID
			,rcptNum : ""	      //접수번호
			,taskNum : ""         //활성타스크번호
			,trstStatNm : ""      //타스크이행명
			,trstStatNum : ""      //타스크이행번호
			,taskRespMb : ""      //타스크소유자	
			,taskComn : ""        //타스크코멘트
			,edDt : ""            //종결일자
			,criStatCd : ""       //수사상태코드
			,regUserId : ""      //등록자
			,updUserId : ""       //수정자		
		}
}

//타스크
var a0302TKMap = {		
	wfNum : ""				//WFID 
	,rcptNum : ""	      //접수번호
	,taskNum : ""         //활성타스크번호
	,trstStatNm : ""      //타스크이행명
	,trstStatNum : ""      //타스크이행번호
	,taskRespMb : ""      //타스크소유자	
	,taskComn : ""        //타스크코멘트
	,edDt : ""            //종결일자
	,criStatCd : ""       //수사상태코드
	,regUserId : ""      //등록자
	,updUserId : ""       //수정자		
}



