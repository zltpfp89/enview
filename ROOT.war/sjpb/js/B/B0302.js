$(function(){
	pageInitB0302();
});

var b0302VOMap = new Object();
var countSp = 0;	//라디오박스 아이디 구분을 위해 커스텀

//화면 진입시 동작함
function pageInitB0302(){
	selectIncHist();
	eventSetupB0302();
}

//이벤트처리
function eventSetupB0302() {
	//닫기버튼
	$("#closBtn, img.btn_close").on("click", function() {
		window.close();
	});
}

//초기화
function initDataB0302(){
	$("#b0302ContentsAreaA").html("");
	$("#b0302ContentsAreaB").html("");
	$("#apprArea_EditButtons").html("");
	
	$("#apprArea02").hide();
}

//피의자 이력 정보 조회
function selectIncHist(){
	
	var incMfNum = $("#incMfNum").val();
	
	var reqMap = {
		incMfNum : incMfNum
	}

	goAjaxDefault("/sjpb/B/selctIncidentHist.face", reqMap, callBackSelectIncHistSuccess);
	
}

//피의자 이력 정보 조회 성공 콜백함수
function callBackSelectIncHistSuccess(data){
	
	//화면 초기화 
	initDataB0302();
	
	var spPrevHtml = new StringBuffer();	//수정전 데이터 담을 버퍼
	var spReqHtml = new StringBuffer();		//수정요청 데이터 담을 버퍼 
	
	var taskTrstVOSB = new StringBuffer();		//승인버튼 데이터 담을 버퍼 
	
	b0302VOMap = data.b0101VO;
	
	countSp = 0;	//라디오박스 아이디 구분을 위해 커스텀
	
	spPrevHtml = renderSpHtml0302(data, b0302VOMap.b0101VOList[0].incSpVOList, "이전");	//수정전 데이터
	spReqHtml = renderSpHtml0302(data, b0302VOMap.b0101VOList[1].incSpVOList, "수정");	//수정요청 데이터 
	
	
	$("#b0302ContentsAreaA").html(spPrevHtml.toString());	//수정전 Html
	$("#b0302ContentsAreaB").html(spReqHtml.toString());	//수정요청 Html
	
	areaSetReadOnly($("#b0302ContentsArea"));
	
	//피의자 이벤트 바인딩
	eventSpSetup();
	
	//현재 수정요청된 데이터에만 승인 버튼 노출함 
	if(b0302VOMap.incMfNum == $("#incMfNum").val()){
		
		//팀장, 서무의 경우 현재 로그인한 계정의 팀 사건만 승인버튼 노출함 2019.01.02
		
		//승인 버튼 노출여부 
		var isTrstBtnView = false;
		
		if(SJPBRole.getTimhderRoleYn() || SJPBRole.getRoleGnlaffYn()){
			if($("#orgCd").val() == b0302VOMap.criTmId){
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
			$.each(b0302VOMap.taskTrstVOList, function(index, taskTrstVO) {
				if (SJPBRole.getHasAnyRole(taskTrstVO.taskRoleCd)) {	//역할에 맞는 버튼만 보이도록 처리
					taskTrstVOSB.append(" <a href=\"javascript:void(0);\" class=\"btn_white\" id=\"btn_"+taskTrstVO.trstStatNum+"\" name=\"trstBtn\" value=\""+taskTrstVO.trstStatNm+"\" data-trst-stat-nm=\""+taskTrstVO.trstStatNm+"\" data-trst-stat-num=\""+taskTrstVO.trstStatNum+"\" data-cri-stat-cd=\""+taskTrstVO.criStatCd+"\" data-wf-num=\""+taskTrstVO.wfNum+"\" data-always=\"y\"><span>"+taskTrstVO.trstStatNm+"</span></a> ");			
				}
			});
			
			//버튼 노출
			var trstBtnGroupHtml = taskTrstVOSB.toString();
			
			//수사중 승인인경우 
			// 1) 팀장이며(팀장 과장은 본인 수사팀 사건만 볼수 있음), 수사상태가 피의자수정팀장승인요청[42] 번일 경우
			// 2) 과장이며(팀장 과장은 본인 수사팀 사건만 볼수 있음), 수사상태가 피의자수정과장승인요청[43] 번일 경우
			//
			//수사지휘건의 승인인경우
			// 3) 팀장이며(팀장 과장은 본인 수사팀 사건만 볼수 있음), 수사상태가 피의자수정팀장승인요청[60] 번일 경우
			// 4) 과장이며(팀장 과장은 본인 수사팀 사건만 볼수 있음), 수사상태가 피의자수정과장승인요청[61] 번일 경우
			//서무 추가 2019.01.02
		
			
			if (((SJPBRole.getTimhderRoleYn() || SJPBRole.getRoleGnlaffYn()) && b0302VOMap.criStatCd == "42") 
					|| ((SJPBRole.getDrhfRoleYn()|| SJPBRole.getSubDrhfYn()) && b0302VOMap.criStatCd == "43")
					|| ((SJPBRole.getTimhderRoleYn() || SJPBRole.getRoleGnlaffYn()) && b0302VOMap.criStatCd == "60")
					|| ((SJPBRole.getDrhfRoleYn()|| SJPBRole.getSubDrhfYn()) && b0302VOMap.criStatCd == "61")) {
				$("#apprArea_EditButtons").html(trstBtnGroupHtml);
				$("#apprArea_EditButtons a:first").attr("class", "btn_blue");
				$("#taskNmTD").html(getTaskNm(b0302VOMap.taskNm));
				//$("#criArea02").hide();
				if (trstBtnGroupHtml != "") {
					$("#apprArea02").show();
				} else {
					$("#apprArea02").hide();
				}
				
				//결재의견만 활성화
				$("#taskComn").val("").attr("disabled",false);
			}

			if (SJPBRole.getInvigtorRoleYn() && b0302VOMap.criStatCd == "42" || SJPBRole.getInvigtorRoleYn() && b0302VOMap.criStatCd == "60") {
				$("#apprArea_EditButtons").html(trstBtnGroupHtml);
				$("#apprArea_EditButtons a:first").attr("class", "btn_blue");
				$("#taskNmTD").html(getTaskNm(b0302VOMap.taskNm));
				//$("#criArea02").hide();
				if (trstBtnGroupHtml != "") {
					$("#apprArea02").show();
					if(SJPBRole.getInvigtorRoleYn() ==true && SJPBRole.getRoleGnlaffYn()== false){
						$("#btn_41").hide();
						$("#btn_51").hide();
					}
				} else {
					$("#apprArea02").hide();
				}
				$("#taskComn").val("").attr("disabled",false);
				
			}
			
			
			
			//타스크이행
			eventTaskBtnB0302();
		}
		
		
	}
}

//타스크 버튼 이벤트 
function eventTaskBtnB0302(){
	//타스크이행
	$("a[name=trstBtn]").off("click").on("click", function() {

		b0302TKMap.wfNum = $(this).data("wf-num");
		b0302TKMap.rcptNum = b0302VOMap.rcptNum;
		b0302TKMap.taskNum = b0302VOMap.taskNum;	
		b0302TKMap.trstStatNm = $(this).data("trst-stat-nm");
		b0302TKMap.trstStatNum = $(this).data("trst-stat-num");
		b0302TKMap.taskRespMb = $("#userId").val();
		b0302TKMap.taskComn = $("#taskComn").val();
		b0302TKMap.criStatCd = $(this).data("cri-stat-cd");
		b0302TKMap.regUserId = $("#userId").val(); 
		b0302TKMap.updUserId = $("#userId").val();
				
		if ($(this).parent('div.r_btn').attr("id") == "apprArea_EditButtons") { //승인자
			executeTaskB0302();
		}
	});	
}

//워크플로우 상태이행처리
function executeTaskB0302(callbackFunction){
	goAjax("/sjpb/B/executeTask.face", b0302TKMap, function(data){ callBackexecuteTaskB0302Success(data, callbackFunction)});
}

//워크플로우 상태이행처리 콜백처리
function callBackexecuteTaskB0302Success(data, callbackFunction) {
	//console.log(JSON.stringify(data));
	alert("정상적으로 처리되었습니다.");
	
	//변경된 상태 저장 
	b0302VOMap.criStatCd = data.criStatCd;
	
	if (typeof callbackFunction == "function") {
		callbackFunction(data);
	}else{
		//재조회
		//selectIncHist();
		
		//승인창 닫기 
		window.close();
	}
}

//피의자 그리기 
function renderSpHtml0302(data, incSpVOList, subSpTitle){
	
	var spHtml = new StringBuffer();
	
	var b0101VOMapTmp = data.b0101VO;
	
	//피의자
	var spNum = 0;
	$.each(incSpVOList, function(i, incSpVO) {
		
		var spIdNumDec =  Base64.decode(incSpVO.spIdNum);
		var spNmDec = Base64.decode(incSpVO.spNm);
		var spAddrDec = Base64.decode(incSpVO.spAddr);
		var spCnttNumDec = Base64.decode(incSpVO.spCnttNum);
		var spJobDec = Base64.decode(incSpVO.spJob);
		var spBsnsNmDec = Base64.decode(incSpVO.spBsnsNm);
		
		spNum++;
		
		spHtml.append('<div class="personinfo" data-name="personinfo">                                                                                                                                                                                                                                ');
		
		spHtml.append('<div class="btnArea">                                                                                                                                                                                                                                ');
		spHtml.append('	<div class="r_btn" name="spBtnArea">                                                                                                                                                                                                                                  ');
		
		//사건번호가 생성되면, 피의자 추가 삭제는 안됨 
		var scriStatCd = isNull(b0101VOMapTmp.criStatCd) ? 0 : Number(b0101VOMapTmp.criStatCd) ;
		
		//수사중 상태 이후에는 피의자 추가 삭제 노출 안함 
		if(scriStatCd < 40){
			spHtml.append('	   <a name="sp_add_btn" onclick="javascript:spAdd(this);" href="javascript:void(0);"><img src="/sjpb/images/plus_icon.png" alt="더하기버튼" /></a>                                                                                                                                           ');
			spHtml.append('	   <a name="sp_sub_btn" onclick="javascript:spSub(this);" href="javascript:void(0);"><img src="/sjpb/images/minus_icon.png" alt="빼기버튼" /></a>                                                                                                                                           ');
		}
		
		spHtml.append('	   <a name="sp_up_btn" onclick="javascript:spUp(this);" href="javascript:void(0);"><img src="/sjpb/images/Add_icon.png" alt="올리기버튼" /></a>                                                                                                                                            ');
		spHtml.append('	   <a name="sp_down_btn" onclick="javascript:spDown(this);" href="javascript:void(0);"><img src="/sjpb/images/delete_icon.png" alt="내리기버튼" /></a>                                                                                                                                         ');
		spHtml.append('   </div>                                                                                                                                                                                                                                            ');
		spHtml.append('</div>																																																				');
		
		spHtml.append('<table name="grid-table-sp" class="list" cellpadding="0" cellspacing="0">                                                                                                                                                                                                 ');
		
		spHtml.append('	<input type="hidden" name="spIdNum" value="'+spIdNumDec+'" />  ');
		spHtml.append('	<input type="hidden" name="gendDiv" value="'+incSpVO.gendDiv+'" />  ');
		spHtml.append('	<input type="hidden" name="spNm" value="'+spNmDec+'" />  ');
		spHtml.append('	<input type="hidden" name="rcptNum" value="'+incSpVO.rcptNum+'" />  ');
		spHtml.append('	<input type="hidden" name="updateCd" value="M" />   ');
		spHtml.append('	<input type="hidden" name="h_incSpNum" value="'+incSpVO.incSpNum+'" />   ');
		
		spHtml.append('   <colgroup>                                                                                                                                                                                                                                        ');
		spHtml.append('   <col width="15%" />                                                                                                                                                                                                                               ');
		spHtml.append('   <col width="15%" />                                                                                                                                                                                                                               ');
		spHtml.append('   <col width="40%" />                                                                                                                                                                                                                               ');
		spHtml.append('   </colgroup>                                                                                                                                                                                                                                       ');
		spHtml.append('   <tbody>                                                                                                                                                                                                                                           ');
		spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		
		var subSpTitleTmp = "";
		if(!isNull(subSpTitle)){
			subSpTitleTmp = subSpTitle + "<br/>";
		}
		
		spHtml.append('		   <th class="C line_right" rowspan="3"> '+subSpTitleTmp+' 피의자<br/>정보                                                                                                                                                                                             ');

		if(incSpVO.indvCorpDiv == "1"){
			spHtml.append('		   <th class="C">성명</th>                                                                                                                                                                                                                       ');
			spHtml.append('		   <td class="L">                                                                                                                                                                                                                   ');
			spHtml.append('			   <label for="spIndvNm_'+countSp+'_'+i+'"></label><input type="text" class="w100per" id="spIndvNm_'+countSp+'_'+i+'" name="spIndvNm" value="'+ spNmDec+'" data-type="name" data-optional-value=false maxlength="20" title="성명"/>                                                                                                                                                    ');
			spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
			spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
			spHtml.append('	   <tr name="indvTR2">                                                                                                                                                                                                                                             ');
			spHtml.append('		   <th class="C"><span name="spIdNumTitle">주민등록번호</span></th>                                                                                                                                                                                                                    ');
			spHtml.append('		   <td class="L">                                                                                                                                                                                                                   ');
			spHtml.append('			   <label for="spIdNumA_'+countSp+'_'+i+'"></label><input type="text" class="w40per" id="spIdNumA_'+countSp+'_'+i+'" name="spIdNumA" value="'+getIdNumA(spIdNumDec)+'" data-type="rnnFront" data-optional-value=true maxlength="6" size="6" title="주민등록번호"/>                                                            ');
			spHtml.append('		   	   ~ <label for="spIdNumB_'+countSp+'_'+i+'"></label><input type="text" class="w47per" id="spIdNumB_'+countSp+'_'+i+'" id="spIdNumB_'+i+'" name="spIdNumB" value="'+getIdNumB(spIdNumDec)+'" data-type="rnnBack" data-optional-value=true maxlength="7" size="7" title="주민등록번호"/>                                                                                                                                                                                                                                        ');
			spHtml.append('		   		&nbsp;<span name=\"gendDivSpan\"></span>                ');
			spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		}else{
			spHtml.append('	   <tr name="corpTR1">                                                                                                                                                                                                                                             ');
			spHtml.append('		   <th class="C">법인명 </th>                                                                                                                                                                                                                       ');
			spHtml.append('		   <td class="L">                                                                                                                                                                                                                   ');
			spHtml.append('			   <label for="spCorpNm_'+countSp+'_'+i+'"></label><input type="text" class="w100per" id="spCorpNm_'+countSp+'_'+i+'" name="spCorpNm" value="'+ spNmDec+'" data-type="name" data-optional-value=true maxlength="20" title="법인명" />                                                                                                                                                    ');
			spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
			spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
			spHtml.append('	   <tr name="corpTR2">                                                                                                                                                                                                                                             ');
			spHtml.append('		   <th class="C">법인등록번호</th>                                                                                                                                                                                                                    ');
			spHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                   ');
			spHtml.append('			   <label for="spCorpIdNumA_'+countSp+'_'+i+'"></label><input type="text" class="w40per" id="spCorpIdNumA_'+countSp+'_'+i+'" name="spCorpIdNumA" value="'+getCorpIdNumA(spIdNumDec)+'" data-type="bizIdFront" title="법인등록번호" maxlength="6" data-optional-value=true  size="6"/>                                                                  ');
			spHtml.append('		       ~ <label for="spCorpIdNumB_'+countSp+'_'+i+'"></label><input type="text" class="w40per" id="spCorpIdNumB_'+countSp+'_'+i+'" name="spCorpIdNumB" value="'+getCorpIdNumB(spIdNumDec)+'" data-type="bizIdBack" title="법인등록번호" maxlength="7" data-optional-value=true  size="7"/>                                                                                    ');
			spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
			spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
		}
		spHtml.append('   </tbody>                                                                                                                                                                                                                                          ');
		spHtml.append('</table>                                                                                                                                                                                                                                             ');
		spHtml.append('</div>                                                                                                                                                                                                                                             ');
	
		countSp++;
	});
	
	
	return spHtml;
}


function initb0302TKMap(){
	b0302TKMap = {		
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
var b0302TKMap = {		
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



