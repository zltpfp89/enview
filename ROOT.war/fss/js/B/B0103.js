/* 송치정보 스크립트 */
$(document).ready(function(){
	//이벤트 세팅
	eventSetupTrf();
});

const CRI_DTA_CATG_CD = "8916" //송치자료

//이벤트 세팅
function eventSetupTrf() {
	
}

//TODO 삭제필요 사용안함
//STEP1,2,3,4 이벤트 바인딩 (전체)
function ocrtSubTabEventFullBind(){
	$(".ocrt_sub_tab").off("click").on("click",function(){
		var f = $(this).siblings();
		var num = $(this).attr("id");
		
		$(f).each(function( index ) {
			var n = $(this).attr("id");
			$(this).removeClass("sub_tab_on");
			$("." + n ).hide();
		});
		
		$(this).addClass("sub_tab_on");
		$("." + num ).show();
	});
}

//STEP1,2,3,4 이벤트 바인딩 (지정)
function ocrtSubTabEventBind(index){
	//STEP1 : index 1
	//STEP2 : index 2
	//STEP3 : index 3
	//STEP4 : index 4
	//STEP6 : index 5 -> 완료 
	
	//높은 STEP에서는 이전 STEP 바인딩까지 함 
	$(".ocrt_sub_tab").each(function(i){
		
		//진행하지 않은 STEP
		if(i > index-1){
			return false;
			
		//현재 진행중인 STEP
		}else if(i == index-1){
			$(this).addClass("sub_tab_on");
			$("." + $(this).attr("id") ).show();
			$("#"+$(this).attr("id")+"_em").html("진행중");	//상단 STEP 진행중으로 변경 
			
		//완료된 STEP
		}else{
			$("#"+$(this).attr("id")+"_em").html("완료");	//상단 STEP 완료로 변경 
			
		}
		
		$(this).off("click").on("click", function(){
			var f = $(this).siblings();
			var num = $(this).attr("id");
			
			$(f).each(function( index ) {
				var n = $(this).attr("id");
				$(this).removeClass("sub_tab_on");
				$("." + n ).hide();
			});
			
			$(this).addClass("sub_tab_on");
			$("." + num ).show();
			
			eval($(this).data("href"));
		});
	});
	
	//판결완료된 사건인 경우, 마지막(판결진행) 화면 노출함
	if(index == 5){
		$(".ocrt_sub_tab:last").addClass("sub_tab_on");
		$("." + $(".ocrt_sub_tab:last").attr("id") ).show();
	}
}

//STEP1,2,3,4 이벤트 바인딩 해제 
function ocrtSubTabEventUnbind(){
	$(".ocrt_sub_tab").off("click");
	$(".ocrt_sub_tab").each(function(i){
		var n = $(this).attr("id");
		$(this).removeClass("sub_tab_on");
		$("." + n ).hide();
		
		//상단 STEP, 진행중, 완료 문구 제거
		$("#"+n+"_em").html("");
	});
}


//송치정보 탭 눌렀을경우, 
function selectTrfInfo(){
	//b0101VOMap.criStatCd
	var scriStatCd = isNull(b0101VOMap.criStatCd) ? 30 : Number(b0101VOMap.criStatCd) ;
	
	//수사지휘건의 	50 ~ 59 
	//송치 			70 ~ 79
	//처분진행		90 ~ 91	
	//판결진행 		92
	
	//이벤트 해제 
	ocrtSubTabEventUnbind();
	
	//수사지휘건의
	if(50 <= scriStatCd && scriStatCd <= 59){
		selectIncCriCmdItemDetails();

		//STEP1, 이벤트바인딩
		ocrtSubTabEventBind(1);
		
	//송치
	}else if(70 <= scriStatCd && scriStatCd <= 79){
		
		//송치가결, 재송치가결의 경우에는 처분진행탭 활성화 
		if(scriStatCd == 73 || scriStatCd == 78){
			selectIncDipRstDetails();
			
			//STEP3, 이벤트바인딩
			ocrtSubTabEventBind(3);
		
		}else{
			selectIncTrfItemDetails();
			
			//그외, STEP2, 이벤트바인딩
			ocrtSubTabEventBind(2);
		}
		
	//판결진행
	}else if(90 == scriStatCd){
		selectIncJdtRstDetails();
		
		//STEP4, 이벤트바인딩
		ocrtSubTabEventBind(4);
	
	//판결완료
	}else if(91 <= scriStatCd){
		selectIncJdtRstDetails();
		
		//STEP4, 이벤트바인딩
		ocrtSubTabEventBind(5);
	}
}

//송치정보 > 송치진행 (사건송치건 상세를 가져온다.)
function selectIncTrfItemDetails(){
	incTrfItemVO.rcptNum = b0101VOMap.rcptNum;
	goAjax("/sjpb/B/selectIncTrfItemDetails.face", incTrfItemVO, callBackSelectIncTrfItemDetailsSuccess);
}

//수사사건송치건 상세 성공 콜백함수
function callBackSelectIncTrfItemDetailsSuccess(data){
	
	//송치서류목록 숨김
	$("#ocrt_list_tab1_div_step2").hide();
	
	var incTrfItemStatCdLast = ""; //마지막 송치상태코드
	var trfRstLast = "";  //마지막 송치결과
	
	var itemHtml = new StringBuffer();  
    
    var lastElement = 0;
    
    if (data.incTrfItemVO.length > 0) {
    	lastElement = data.incTrfItemVO.length - 1;
    }
    
    var incTrfItemLength = data.incTrfItemVO.length;
  
	$.each(data.incTrfItemVO, function(i, item) {
		
		var preTitle = "";
		if (i > 0) preTitle = "재 ";
		
		itemHtml.append('<div class="listArea">																	');
		itemHtml.append('	<table class="list" cellpadding="0" cellspacing="0">                                ');
		itemHtml.append('		<colgroup>                                                                      ');
		itemHtml.append('			<col width="10%" />                                                         ');
		itemHtml.append('			<col width="23%" />                                                         ');
		itemHtml.append('			<col width="10%" />                                                         ');
		itemHtml.append('			<col width="23%" />                                                         ');
		itemHtml.append('			<col width="10%" />                                                         ');
		itemHtml.append('			<col width="*%" />                                                          ');
		itemHtml.append('		</colgroup>                                                                     ');
		itemHtml.append('		<tbody>                                                                         ');
		itemHtml.append('			<tr>                                                                        ');
		itemHtml.append('				<th class="C">'+preTitle+'송치결과</th>                                                 ');
		
		//마지막 엘리먼트가 아닌경우또는 송치결과 수령상태인경우
        if (i != lastElement || item.incTrfItemStatCd == "04") {
        	itemHtml.append('				<td class="L" colspan="5">'+(item.trfRst=="Y"?"송치가결":"송치부결")+'</td>                                     ');
        }else{
        	itemHtml.append('				<td class="L" colspan="5">송치건의중</td>                                     ');
        }
		
		itemHtml.append('			</tr>                                                                       ');
		itemHtml.append('			<tr>                                                                        ');
		itemHtml.append('				<th class="C">'+preTitle+'송치일시</th>                                                 ');
		itemHtml.append('				<td class="L">'+item.trfProDt+'</td>                                           ');
		itemHtml.append('				<th class="C">'+preTitle+'송치기관</th>                                                 ');
		itemHtml.append('				<td class="L">'+item.respDppoDesc+'</td>                                                 ');
		itemHtml.append('				<th class="C">'+preTitle+'송치결과</th>                                                 ');
		
		//마지막 엘리먼트가 아닌경우또는 송치결과 수령상태인경우
        if (i != lastElement || item.incTrfItemStatCd == "04") {
        	itemHtml.append('				<td class="L">'+(item.trfRst=="Y"?"가":"부")+'</td>                                                    ');
        
        }else{
        	itemHtml.append('				<td class="L"></td>                                                    ');
        
        }
		
		itemHtml.append('			</tr>                                                                       ');
		itemHtml.append('			<tr>                                                                        ');
		itemHtml.append('				<th class="C" rowspan="1">'+preTitle+'송치의견</th>                                     ');
		itemHtml.append('				<td class="L" colspan="5">'+item.trfComn+'</td>                   ');
		itemHtml.append('			</tr>                                                                       ');
		itemHtml.append('		</tbody>                                                                        ');
		itemHtml.append('	</table>                                                                            ');
		itemHtml.append('</div>                                                                                  ');
		
		//마지막일경우,
		if(i == incTrfItemLength - 1){
			
			//마지막상태 저장
        	incTrfItemStatCdLast = item.incTrfItemStatCd;
        	trfRstLast = item.trfRst;
			
			//로그인한 계정이 해당사건의 참조, 권한이없을경우 : 조회만가능
			//단, 송치관은 '재송치요청'버튼노출되어야 함 .
			if(accessMap.criLvCd == "03" || accessMap.criLvCd == ""){
				
				if(SJPBRole.getTrnsrRoleYn()){
					//수사상태가 [ 송치부결(74), 재송치부결(79) ] 일 경우에만
					if(b0101VOMap.criStatCd == "74" || b0101VOMap.criStatCd == "79"){
						//송치결과가 '부' 일때, 재송치요청 버튼 노출
						if(item.trfRst == "N"){
							itemHtml.append('<div class="btnArea">																					');
							
							//수사지휘탭에 송치요청 버튼 노출
							$.each(b0101VOMap.taskTrstVOList, function(index, taskTrstVO) {
								console.log(taskTrstVO.trstStatNm);
								console.log(taskTrstVO.trstStatNum);
								console.log(taskTrstVO.taskRespMb);
								console.log(taskTrstVO.criStatCd);
								if (SJPBRole.getHasAnyRole(taskTrstVO.taskRoleCd)) {	//역할에 맞는 버튼만 보이도록 처리
									itemHtml.append(" <div class=\"r_btn\"><a href=\"javascript:void(0);\" class=\"btn_blue\" name=\"trstBtn\" value=\""+taskTrstVO.trstStatNm+"\" data-update-type=\"4\" data-trst-stat-nm=\""+taskTrstVO.trstStatNm+"\" data-trst-stat-num=\""+taskTrstVO.trstStatNum+"\" data-cri-stat-cd=\""+taskTrstVO.criStatCd+"\" data-wf-num=\""+taskTrstVO.wfNum+"\" data-always=\"y\"><span>"+taskTrstVO.trstStatNm+"</span></a></div> ");			
								}
							});
							itemHtml.append('</div>                                                                                                 ');
						}
					}
				}
				
			//권한이 있을경우, 수정가능 
			}else{
				
				//사건수사권한이 있고, 수사상태가 [ 송치부결(74), 재송치부결(79) ] 일 경우에만
				if(b0101VOMap.criStatCd == "74" || b0101VOMap.criStatCd == "79"){
					//송치결과가 '부' 일때, 재송치요청 버튼 노출
					if(item.trfRst == "N"){
						
						itemHtml.append('<div class="btnArea">																					');
						
						//수사지휘탭에 송치요청 버튼 노출
						$.each(b0101VOMap.taskTrstVOList, function(index, taskTrstVO) {
							console.log(taskTrstVO.trstStatNm);
							console.log(taskTrstVO.trstStatNum);
							console.log(taskTrstVO.taskRespMb);
							console.log(taskTrstVO.criStatCd);
							if (SJPBRole.getHasAnyRole(taskTrstVO.taskRoleCd)) {	//역할에 맞는 버튼만 보이도록 처리
								itemHtml.append(" <div class=\"r_btn\"><a href=\"javascript:void(0);\" class=\"btn_blue\" name=\"trstBtn\" value=\""+taskTrstVO.trstStatNm+"\" data-update-type=\"4\" data-trst-stat-nm=\""+taskTrstVO.trstStatNm+"\" data-trst-stat-num=\""+taskTrstVO.trstStatNum+"\" data-cri-stat-cd=\""+taskTrstVO.criStatCd+"\" data-wf-num=\""+taskTrstVO.wfNum+"\" data-always=\"y\"><span>"+taskTrstVO.trstStatNm+"</span></a></div> ");			
							}
						});
					
						itemHtml.append('</div>                                                                                                 ');
						
					}
				}
			}
		}
	});
	
	var preTitle2 = "";
	if(incTrfItemLength > 0) preTitle2 = "재 ";
	
	//송치요청중, 재송치요청중일 경우
	if(b0101VOMap.criStatCd == "70" || b0101VOMap.criStatCd == "75"){
		itemHtml.append('<div class="listArea">																	');
		itemHtml.append('	<table class="list" cellpadding="0" cellspacing="0">                                ');
		itemHtml.append('		<colgroup>                                                                      ');
		itemHtml.append('			<col width="10%" />                                                         ');
		itemHtml.append('			<col width="23%" />                                                         ');
		itemHtml.append('			<col width="10%" />                                                         ');
		itemHtml.append('			<col width="23%" />                                                         ');
		itemHtml.append('			<col width="10%" />                                                         ');
		itemHtml.append('			<col width="*%" />                                                          ');
		itemHtml.append('		</colgroup>                                                                     ');
		itemHtml.append('		<tbody>                                                                         ');
		itemHtml.append('			<tr>                                                                        ');
		itemHtml.append('				<th class="C">'+preTitle2+'송치결과</th>                                                 ');
		itemHtml.append('				<td class="L" colspan="5">'+preTitle2+'송치요청중</td>                                     ');
		itemHtml.append('			</tr>                                                                       ');
		itemHtml.append('		</tbody>                                                                        ');
		itemHtml.append('	</table>                                                                            ');
		itemHtml.append('</div>                                                                                  ');
	}
	
	$("#ocrt_list_tab1_div_step1").html(itemHtml.toString());
	
	//수사결과가 가인 경우
	if (incTrfItemStatCdLast == "04" && trfRstLast=="Y") {
		
		//송치서류목록 보임
		$("#ocrt_list_tab1_div_step2").show();
		
		//송치사건자료
		selectCriIncDta();
	}
	
	//타스크이행
	eventTaskBtn();
	
	//화면사이즈 갱신
	autoResize();
	
}

//송치사건자료를 가져온다. 
function selectCriIncDta(){
	incTrfItemVO.criDtaCatgCd = CRI_DTA_CATG_CD; //송치자료
	goAjax("/sjpb/B/selectCriIncDta.face", incTrfItemVO, callBackSelectCriIncDtaSuccess);
}

//수사사건자료상세 콜백함수
function callBackSelectCriIncDtaSuccess(data) {
	
	console.log(JSON.stringify(data));
	
	incTrfItemVO = data.incTrfItemVO;
	
	//수사자료 리스팅	
	renderDTTable(incTrfItemVO.criIncDtaFileVOList, "2");
	
	//화면사이즈 갱신
	autoResize();	
}

//송치정보 > 수사지휘진행 (수사사건지휘건 상세를 가져온다.) 
function selectIncCriCmdItemDetails(){
	incCriCmdItemVO.rcptNum = b0101VOMap.rcptNum;
	goAjax("/sjpb/B/selectIncCriCmdItemDetails.face", incCriCmdItemVO, callBackSelectIncCriCmdItemDetailsSuccess);
}


//수사사건지휘건 상세 성공 콜백함수
function callBackSelectIncCriCmdItemDetailsSuccess(data){
	var itemHtml = new StringBuffer();  
	
	var lastElement = 0;
    if (data.incCriCmdItemVO.length > 0) {
    	lastElement = data.incCriCmdItemVO.length - 1;
    }
    
    var incCriCmdItemLength = data.incCriCmdItemVO.length;
    
    $.each(data.incCriCmdItemVO, function(i, item) {
    	
    	var preTitle = "";
		if (i > 0) preTitle = "재 ";
		
		itemHtml.append('<div class="listArea" data-inc-cri-cmd-item-num="'+item.incCriCmdItemNum+'" data-re-cmd-yn="'+item.reCmdYn+'" data-pre-title="'+preTitle+'">														');
		itemHtml.append('	<table class="list" cellpadding="0" cellspacing="0">                        ');
		itemHtml.append('		<colgroup>                                                              ');
		itemHtml.append('			<col width="15%" />                                                 ');
		itemHtml.append('			<col width="35%" />                                                 ');
		itemHtml.append('			<col width="15%" />                                                 ');
		itemHtml.append('			<col width="35%" />                                                 ');
		itemHtml.append('		</colgroup>                                                             ');
		itemHtml.append('		<tbody>                                                                 ');
		itemHtml.append('			<tr>                                                                ');    
		
		if (i == 0) {
			itemHtml.append('				<th class="C">지휘기관</th>                                         ');
			itemHtml.append('				<td class="L">'+item.respDppoDesc+'</td>                                         ');
		}else{
			itemHtml.append('				<th class="C">'+preTitle+'지휘인계일</th>                                         ');
			itemHtml.append('				<td class="L">'+item.respDppoDesc+'</td>                                         ');
		}
		
		
		itemHtml.append('				<th class="C">'+preTitle+'지휘접수일</th>                                        ');
		itemHtml.append('				<td class="L">'+item.criCmdReqDt+'</td>                                   ');
		itemHtml.append('			</tr>                                                               ');
		itemHtml.append('			<tr>                                                                ');    
		itemHtml.append('				<th class="C">'+preTitle+'지휘건의일</th>                                        ');
		itemHtml.append('				<td class="L">'+item.criCmdProDt+'</td>                                   ');
		itemHtml.append('				<th class="C">'+preTitle+'지휘수령일</th>                                   ');
		
		//마지막 엘리먼트가 아닌경우또는 수사지휘결과 수령상태인경우
        if (i != lastElement || item.incCriCmdItemStatCd == "04") {       
        	itemHtml.append('				<td class="L">'+item.criCmdRcptDt+'</td>                                        ');
        }else{
        	itemHtml.append('				<td class="L"></td>                                        ');
        }
		
		itemHtml.append('			</tr>                                                               ');
		itemHtml.append('			<tr>                                                                ');    
		itemHtml.append('				<th class="C">'+preTitle+'지휘결과</th>                                         ');
		
		//마지막 엘리먼트가 아닌경우또는 수사지휘결과 수령상태인경우
        if (i != lastElement || item.incCriCmdItemStatCd == "04") {  
        	itemHtml.append('				<td class="L" colspan="3">'+(item.criCmdRst=="Y"?"가":"부")+'</td>                                ');
        }else{
        	itemHtml.append('				<td class="L" colspan="3"></td>                                ');
        }
		
		itemHtml.append('			</tr>                                                               ');
		itemHtml.append('			<tr>                                                                ');    
		itemHtml.append('				<th class="C">기타의견</th>                                         ');
		itemHtml.append('				<td class="L" colspan="3">'+item.criCmdComn+'</td>                  ');
		itemHtml.append('			</tr>                                                               ');
		itemHtml.append('		</tbody>                                                                ');
		itemHtml.append('	</table>                                                                    ');
		itemHtml.append('</div>                                                                       ');
		
		//마지막일경우,
		if(i == incCriCmdItemLength - 1){
			//로그인한 계정이 해당사건의 참조, 권한이없을경우 : 조회만가능
			//단, 송치관은 '송치요청'버튼노출되어야 함 .
			if(accessMap.criLvCd == "03" || accessMap.criLvCd == ""){
				
				if(SJPBRole.getTrnsrRoleYn()){
					//수사상태가 [ 지휘가결(53), 재지휘가결(58) ] 일 경우에만
					if(b0101VOMap.criStatCd == "53" || b0101VOMap.criStatCd == "58"){
						//수사지휘결과가 '가' 일때, 송치요청 버튼 노출
						if(item.criCmdRst == "Y"){
							itemHtml.append('<div class="btnArea">																					');
							
							//수사지휘탭에 송치요청 버튼 노출
							$.each(b0101VOMap.taskTrstVOList, function(index, taskTrstVO) {
								console.log(taskTrstVO.trstStatNm);
								console.log(taskTrstVO.trstStatNum);
								console.log(taskTrstVO.taskRespMb);
								console.log(taskTrstVO.criStatCd);
								if (SJPBRole.getHasAnyRole(taskTrstVO.taskRoleCd)) {	//역할에 맞는 버튼만 보이도록 처리
									itemHtml.append(" <div class=\"r_btn\"><a href=\"javascript:void(0);\" class=\"btn_blue\" name=\"trstBtn\" value=\""+taskTrstVO.trstStatNm+"\" data-update-type=\"4\" data-trst-stat-nm=\""+taskTrstVO.trstStatNm+"\" data-trst-stat-num=\""+taskTrstVO.trstStatNum+"\" data-cri-stat-cd=\""+taskTrstVO.criStatCd+"\" data-wf-num=\""+taskTrstVO.wfNum+"\" data-always=\"y\"><span>"+taskTrstVO.trstStatNm+"</span></a></div> ");			
								}
							});
							itemHtml.append('</div>                                                                                                 ');
						}
					}
				}
				
			//수사관은 권한이 있을경우에만, 수정가능 
			}else{
				//사건수사권한이 있고, 수사상태가 [ 지휘부결(54), 재지휘부결(59) ] 일 경우에만
				if(b0101VOMap.criStatCd == "54" || b0101VOMap.criStatCd == "59"){
					//수사지휘결과가 '부' 이고, 병합된사건일 경우에는 분리송치 버튼 노출
					if(item.criCmdRst == "N" && b0101VOMap.combIncYn == "Y"){
						itemHtml.append('<div class="btnArea">																					');
						itemHtml.append('	<div class="r_btn"><a href="javascript:unCombIncMast();" class="btn_blue"><span>분리송치</span></a></div>       ');
						itemHtml.append('</div>                                                                                                 ');
					}
				
				//사건수사권한이 있고, 수사상태가 [ 지휘가결(53), 재지휘가결(58) ] 일 경우에만
				}else if(b0101VOMap.criStatCd == "53" || b0101VOMap.criStatCd == "58"){
					//수사지휘결과가 '가' 일때, 송치요청 버튼 노출
					if(item.criCmdRst == "Y"){
						
						itemHtml.append('<div class="btnArea">																					');
						
						//수사지휘탭에 송치요청 버튼 노출
						$.each(b0101VOMap.taskTrstVOList, function(index, taskTrstVO) {
							console.log(taskTrstVO.trstStatNm);
							console.log(taskTrstVO.trstStatNum);
							console.log(taskTrstVO.taskRespMb);
							console.log(taskTrstVO.criStatCd);
							if (SJPBRole.getHasAnyRole(taskTrstVO.taskRoleCd)) {	//역할에 맞는 버튼만 보이도록 처리
								itemHtml.append(" <div class=\"r_btn\"><a href=\"javascript:void(0);\" class=\"btn_blue\" name=\"trstBtn\" value=\""+taskTrstVO.trstStatNm+"\" data-update-type=\"4\" data-trst-stat-nm=\""+taskTrstVO.trstStatNm+"\" data-trst-stat-num=\""+taskTrstVO.trstStatNum+"\" data-cri-stat-cd=\""+taskTrstVO.criStatCd+"\" data-wf-num=\""+taskTrstVO.wfNum+"\" data-always=\"y\"><span>"+taskTrstVO.trstStatNm+"</span></a></div> ");			
							}
						});
					
						itemHtml.append('</div>                                                                                                 ');
						
					}
				}
			}
		}
    });
    
    var preTitle2 = "";
	if(incCriCmdItemLength > 0) preTitle2 = "재 ";
	
	//수사지휘요청중, 수사재지휘요청중일 경우
	if(b0101VOMap.criStatCd == "50" || b0101VOMap.criStatCd == "55"){
		itemHtml.append('<div class="listArea">																	');
		itemHtml.append('	<table class="list" cellpadding="0" cellspacing="0">                                ');
		itemHtml.append('		<colgroup>                                                                      ');
		itemHtml.append('			<col width="15%" />                                                 ');
		itemHtml.append('			<col width="35%" />                                                 ');
		itemHtml.append('			<col width="15%" />                                                 ');
		itemHtml.append('			<col width="35%" />                                                 ');
		itemHtml.append('		</colgroup>                                                                     ');
		itemHtml.append('		<tbody>                                                                         ');
		itemHtml.append('			<tr>                                                                        ');
		itemHtml.append('				<th class="C">'+preTitle2+'지휘결과</th>                                                 ');
		itemHtml.append('				<td class="L" colspan="3">'+preTitle2+'지휘요청중</td>                                     ');
		itemHtml.append('			</tr>                                                                       ');
		itemHtml.append('		</tbody>                                                                        ');
		itemHtml.append('	</table>                                                                            ');
		itemHtml.append('</div>                                                                                  ');
	}
    
    $("#ocrt_list_tab0_div").html(itemHtml.toString());
    
    //타스크이행
	eventTaskBtn();
	
	//화면사이즈 갱신
	autoResize();
}

//사건을 분리한다. (ajax)
function unCombIncMast(){
	//분리한다.
	if(confirm("분리송치 하시겠습니까?") == true){
		
		goAjax("/sjpb/B/unCombIncMast.face", b0101VOMap, callBackUnCombIncMastSuccess);
	}else{
		return;
	}
}

//사건을 분리한다. 성공 콜백함수
function callBackUnCombIncMastSuccess(data){
	alert("분리성공!!");
	selectList(data.b0101VO.rcptNum);
}

//처분진행 수정 화면 노출(그리기)
function updateIncDipRstView(data){
	var rstHtml = new StringBuffer();  
	
	rstHtml.append('<div class="listArea">																								');
	rstHtml.append('	<table class="list" cellpadding="0" cellspacing="0">                                                            ');
	rstHtml.append('		<colgroup>                                                                                                  ');
	rstHtml.append('			<col width="15%" />                                                                                     ');
	rstHtml.append('			<col width="*%" />                                                                                      ');
	rstHtml.append('		</colgroup>                                                                                                 ');
	rstHtml.append('		<tbody>                                                                                                     ');
	rstHtml.append('                                                                                                                    ');
	rstHtml.append('			<tr>                                                                                                    ');
	rstHtml.append('				<th class="C">형제번호</th>                                                                             ');
	rstHtml.append('				<td class="L">                                                                                      ');
	rstHtml.append('					<label for="txt_92"></label><input type="text" class="w100per" id="txt_92" name="crlwNum" value="'+getParamValue(b0101VOMap.crlwNum)+'" />           ');
	rstHtml.append('				</td>                                                                                               ');
	rstHtml.append('			</tr>                                                                                                   ');
	rstHtml.append('			<tr>                                                                                                    ');
	rstHtml.append('				<th class="C">검찰처분일시</th>                                                                           ');
	rstHtml.append('				<td class="L">                                                                                      ');
	rstHtml.append('					<label for="txt_93"></label><input type="text" class="w20per calendar datepicker" data-type="date" title="검찰처분일시" id="txt_93" name="poDipDt" value="'+getParamValue(b0101VOMap.poDipDt)+'" />   ');
	rstHtml.append('				</td>                                                                                               ');
	rstHtml.append('			</tr>                                                                                                   ');
	rstHtml.append('		</tbody>                                                                                                    ');
	rstHtml.append('	</table>                                                                                                        ');
	rstHtml.append('</div>                                                                                                              ');
	
	//피의자
	var spNum = 0;
	$.each(b0101VOMap.incSpVOList, function(i, incSpVO) {
		
		var spIdNumDec =  Base64.decode(incSpVO.spIdNum);
		var spNmDec = Base64.decode(incSpVO.spNm);
		
		spNum++;
		
		rstHtml.append('<div class="personinfo" data-name="rstpersoninfo">                                                                                                                                                                                                                                ');
		
		rstHtml.append('<table name="grid-table-sp" class="list" cellpadding="0" cellspacing="0">                                                                                                                                                                                                 ');
		
		rstHtml.append('	<input type="hidden" name="rst_spIdNum" value="'+spIdNumDec+'" />  ');
		rstHtml.append('	<input type="hidden" name="rst_spNm" value="'+spNmDec+'" />  ');
		rstHtml.append('	<input type="hidden" name="rst_rcptNum" value="'+incSpVO.rcptNum+'" />  ');
		rstHtml.append('	<input type="hidden" name="rst_incSpNum" value="'+incSpVO.incSpNum+'" />   ');
		
		rstHtml.append('   <colgroup>                                                                                                                                                                                                                                        ');
		rstHtml.append('   <col width="10%" />                                                                                                                                                                                                                               ');
		rstHtml.append('   <col width="15%" />                                                                                                                                                                                                                               ');
		rstHtml.append('   <col width="30%" />                                                                                                                                                                                                                               ');
		rstHtml.append('   <col width="15%" />                                                                                                                                                                                                                               ');
		rstHtml.append('   <col width="30%" />                                                                                                                                                                                                                               ');
		rstHtml.append('   </colgroup>                                                                                                                                                                                                                                       ');
		rstHtml.append('   <tbody>                                                                                                                                                                                                                                           ');
		rstHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		rstHtml.append('		   <th class="C line_right" rowspan="9">피의자 정보</th>                                                                                                                                                                                             ');
		
		if(incSpVO.indvCorpDiv == "1" ){	//개인
			rstHtml.append('		   <th class="C">성명</th>                                                                                                                                                                                                                        ');
		}else{	//법인
			rstHtml.append('		   <th class="C">법인명</th>                                                                                                                                                                                                                        ');
		}
		
		rstHtml.append('		   <td class="L" colspan="3">'+spNmDec+'</td>                                                                                                                                                                                                                              ');
		rstHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
		rstHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		rstHtml.append('	   <td colspan="4" class="L">																			');
		
		$.each(incSpVO.actVioVOList, function(j, ActVioVO) {
		
			rstHtml.append('	   	<div class="law">                                                                                   ');
			rstHtml.append('			<input type="hidden" name="rst_actVio_incSpNum" value="'+ActVioVO.incSpNum+'" />  ');
			rstHtml.append('			<input type="hidden" name="rst_actVio_actVioNum" value="'+ActVioVO.actVioNum+'" />  ');
			rstHtml.append('	   		<ul>                                                                                            ');
			rstHtml.append('	   			<li><span class="title">관련법률 및 죄명</span>                                                    ');
			rstHtml.append('	   				<label for="rst_rltActCriNmCdDesc_'+i+'_'+j+'"></label><input type="text" class="w80per" id="rst_rltActCriNmCdDesc_'+i+'_'+j+'" name="rst_rltActCriNmCdDesc" value="'+ActVioVO.rltActCriNmCdDesc+'" disabled="true" data-readonly="y"/>    ');
			rstHtml.append('	   			</li>                                                                                       ');
			
			rstHtml.append('	   			<li><span class="title">검찰내용</span>                                                         ');
			rstHtml.append('	   				<div class="inputbox w80per">                                                           ');
			
			var poContCodeName="";
			var poContCodeHtml = new StringBuffer();
			poContCodeHtml.append('						<option value="" selected="selected">없음</option>                                                                                                          ');
			poContCodeName = "없음";
			$.each(data.poContList, function(k, poCont) {
				if(ActVioVO.incDipRstVO.poContCd == poCont.code){
					poContCodeName = poCont.codeName;
				}
				poContCodeHtml.append('						<option value="'+poCont.code+'" '+(ActVioVO.incDipRstVO.poContCd == poCont.code ? "selected=\"selected\"":"")+'>'+poCont.codeName+'</option>                                                                                                          ');
			});
			
			rstHtml.append('	   					<p class="txt">'+poContCodeName+'</p>                                                                 ');
			rstHtml.append('	   					<select name="rst_poContCd">                                                                            ');
			rstHtml.append(poContCodeHtml);
			rstHtml.append('	   					</select>                                                                           ');
			rstHtml.append('	   				</div>                                                                                  ');
			rstHtml.append('	   			</li>                                                                                       ');
			rstHtml.append('	   			<li><span class="title">처분내용</span>                                                         ');
			rstHtml.append('	   				<label for="rst_dipCont_'+i+'_'+j+'"></label><input type="text" class="w80per" id="rst_dipCont_'+i+'_'+j+'" name="rst_dipCont" value="'+getParamValue(ActVioVO.incDipRstVO.dipCont)+'" />    ');
			rstHtml.append('	   			</li>                                                                                       ');
			rstHtml.append('	   			<li><span class="title">벌금액</span>                                                         ');
			rstHtml.append('	   				<label for="rst_fnAmt_'+i+'_'+j+'"></label><input type="text" class="w10per" id="rst_fnAmt_'+i+'_'+j+'" name="rst_fnAmt" value="'+getParamValue(ActVioVO.incDipRstVO.fnAmt)+'" /><span class="sub_title">만원</span>    ');
			rstHtml.append('	   			</li>                                                                                       ');
			rstHtml.append('	   		</ul>                                                                                           ');
			rstHtml.append('	   	</div>                                                                                              ');
		
		});
		
		rstHtml.append('	   	</td>                                                                                                ');
		rstHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
		rstHtml.append('   </tbody>                                                                                                                                                                                                                                          ');
		rstHtml.append('</table>                                                                                                                                                                                                                                             ');
		rstHtml.append('</div>                                                                                                                                                                                                                                             ');
	});
	
	//수사상태가 [사건처분완료(90)] 일 경우에만
	if(b0101VOMap.criStatCd == "90"){
		rstHtml.append('<div class="btnArea">																					');
		rstHtml.append(" <div class=\"r_btn\"><a href=\"javascript:updateIncident(6);\" class=\"btn_blue\" name=\"updateIncDipRstBtn\"><span>수정</span></a></div> ");
		//수정버튼만 
		
		//처분진행탭에 처분등록 버튼 노출
//		$.each(b0101VOMap.taskTrstVOList, function(index, taskTrstVO) {
//			console.log(taskTrstVO.trstStatNm);
//			console.log(taskTrstVO.trstStatNum);
//			console.log(taskTrstVO.taskRespMb);
//			console.log(taskTrstVO.criStatCd);
//			if (taskTrstVO.taskRoleCd.indexOf($("#kindCd").val()) != -1) {	//역할에 맞는 버튼만 보이도록 처리		
//				rstHtml.append(" <div class=\"r_btn\"><a href=\"javascript:void(0);\" class=\"btn_blue\" name=\"trstBtn\" value=\""+taskTrstVO.trstStatNm+"\" data-update-type=\"5\" data-trst-stat-nm=\""+taskTrstVO.trstStatNm+"\" data-trst-stat-num=\""+taskTrstVO.trstStatNum+"\" data-cri-stat-cd=\""+taskTrstVO.criStatCd+"\" data-wf-num=\""+taskTrstVO.wfNum+"\" data-always=\"y\"><span>"+taskTrstVO.trstStatNm+"</span></a></div> ");			
//			}
//		});
	
		rstHtml.append('</div>                                                                                                 ');
			
	}
	
	$("#ocrt_list_tab2_div").html(rstHtml.toString());
	
	//TODO 송치관이 아닐경우에는, 입력화면이 보일필요가 없는거 아닐까?
	//송치관이 아닐경우에는 읽기만 가능 (송치관만 수정가능)
	if(SJPBRole.getTrnsrRoleYn() && b0101VOMap.criStatCd == "90"){
		//수정가능 
		
		//이벤트바인딩 (selectbox)
		setTargetDefaultEvent( $("#ocrt_list_tab2_div") );
		
		//달력이벤트
		$(".datepicker").datepicker({
			  dateFormat: "yy-mm-dd"  
		});
		
	}else{
		//수정 불가능
		areaSetReadOnly($("#ocrt_list_tab2_div"));
	}
	
	//화면사이즈 갱신
	autoResize();
}

//처분수정 성공 콜백함수 
function callBackUpdateIncDipRstSuccess(data){
	alert("처분결과 수정완료");
	selectIncDipRstDetails();
}

//판결수정 성공 콜백함수 
function callBackUpdateIncJdtRstSuccess(data){
	alert("판결결과 수정완료");
	selectIncJdtRstDetails();
}

//처분진행 입력 화면 노출(그리기)
function insertIncDipRstView(data){
	
	var rstHtml = new StringBuffer();  
	
	rstHtml.append('<div class="listArea">																								');
	rstHtml.append('	<table class="list" cellpadding="0" cellspacing="0">                                                            ');
	rstHtml.append('		<colgroup>                                                                                                  ');
	rstHtml.append('			<col width="15%" />                                                                                     ');
	rstHtml.append('			<col width="*%" />                                                                                      ');
	rstHtml.append('		</colgroup>                                                                                                 ');
	rstHtml.append('		<tbody>                                                                                                     ');
	rstHtml.append('                                                                                                                    ');
	rstHtml.append('			<tr>                                                                                                    ');
	rstHtml.append('				<th class="C">형제번호</th>                                                                             ');
	rstHtml.append('				<td class="L">                                                                                      ');
	rstHtml.append('					<label for="txt_92"></label><input type="text" class="w100per" id="txt_92" name="crlwNum" />           ');
	rstHtml.append('				</td>                                                                                               ');
	rstHtml.append('			</tr>                                                                                                   ');
	rstHtml.append('			<tr>                                                                                                    ');
	rstHtml.append('				<th class="C">검찰처분일시</th>                                                                           ');
	rstHtml.append('				<td class="L">                                                                                      ');
	rstHtml.append('					<label for="txt_93"></label><input type="text" class="w20per calendar datepicker" data-type="date" title="검찰처분일시" id="txt_93" name="poDipDt" />   ');
	rstHtml.append('				</td>                                                                                               ');
	rstHtml.append('			</tr>                                                                                                   ');
	rstHtml.append('		</tbody>                                                                                                    ');
	rstHtml.append('	</table>                                                                                                        ');
	rstHtml.append('</div>                                                                                                              ');
	
	//피의자
	var spNum = 0;
	$.each(b0101VOMap.incSpVOList, function(i, incSpVO) {
		
		var spIdNumDec =  Base64.decode(incSpVO.spIdNum);
		var spNmDec = Base64.decode(incSpVO.spNm);
		
		spNum++;
		
		rstHtml.append('<div class="personinfo" data-name="rstpersoninfo">                                                                                                                                                                                                                                ');
		
		rstHtml.append('<table name="grid-table-sp" class="list" cellpadding="0" cellspacing="0">                                                                                                                                                                                                 ');
		
		rstHtml.append('	<input type="hidden" name="rst_spIdNum" value="'+spIdNumDec+'" />  ');
		rstHtml.append('	<input type="hidden" name="rst_spNm" value="'+spNmDec+'" />  ');
		rstHtml.append('	<input type="hidden" name="rst_rcptNum" value="'+incSpVO.rcptNum+'" />  ');
		rstHtml.append('	<input type="hidden" name="rst_incSpNum" value="'+incSpVO.incSpNum+'" />   ');
		
		rstHtml.append('   <colgroup>                                                                                                                                                                                                                                        ');
		rstHtml.append('   <col width="10%" />                                                                                                                                                                                                                               ');
		rstHtml.append('   <col width="15%" />                                                                                                                                                                                                                               ');
		rstHtml.append('   <col width="30%" />                                                                                                                                                                                                                               ');
		rstHtml.append('   <col width="15%" />                                                                                                                                                                                                                               ');
		rstHtml.append('   <col width="30%" />                                                                                                                                                                                                                               ');
		rstHtml.append('   </colgroup>                                                                                                                                                                                                                                       ');
		rstHtml.append('   <tbody>                                                                                                                                                                                                                                           ');
		rstHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		rstHtml.append('		   <th class="C line_right" rowspan="9">피의자 정보</th>                                                                                                                                                                                             ');
		
		if(incSpVO.indvCorpDiv == "1" ){	//개인
			rstHtml.append('		   <th class="C">성명</th>                                                                                                                                                                                                                        ');
		}else{	//법인
			rstHtml.append('		   <th class="C">법인명</th>                                                                                                                                                                                                                        ');
		}
		
		rstHtml.append('		   <td class="L" colspan="3">'+spNmDec+'</td>                                                                                                                                                                                                                              ');
		rstHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
		rstHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		rstHtml.append('	   <td colspan="4" class="L">																			');
		
		$.each(incSpVO.actVioVOList, function(j, ActVioVO) {
		
			rstHtml.append('	   	<div class="law">                                                                                   ');
			rstHtml.append('			<input type="hidden" name="rst_actVio_incSpNum" value="'+ActVioVO.incSpNum+'" />  ');
			rstHtml.append('			<input type="hidden" name="rst_actVio_actVioNum" value="'+ActVioVO.actVioNum+'" />  ');
			rstHtml.append('	   		<ul>                                                                                            ');
			rstHtml.append('	   			<li><span class="title">관련법률 및 죄명</span>                                                    ');
			rstHtml.append('	   				<label for="rst_rltActCriNmCdDesc_'+i+'_'+j+'"></label><input type="text" class="w80per" id="rst_rltActCriNmCdDesc_'+i+'_'+j+'" name="rst_rltActCriNmCdDesc" value="'+ActVioVO.rltActCriNmCdDesc+'" disabled="true" data-readonly="y"/>    ');
			rstHtml.append('	   			</li>                                                                                       ');
			
			rstHtml.append('	   			<li><span class="title">검찰내용</span>                                                         ');
			rstHtml.append('	   				<div class="inputbox w80per">                                                           ');
			
			var poContCodeHtml = new StringBuffer();
			poContCodeHtml.append('						<option value="" selected="selected">없음</option>                                                                                                          ');
			$.each(data.poContList, function(k, poCont) {
				poContCodeHtml.append('						<option value="'+poCont.code+'">'+poCont.codeName+'</option>                                                                                                          ');
			});
			
			rstHtml.append('	   					<p class="txt">없음</p>                                                                 ');
			rstHtml.append('	   					<select name="rst_poContCd">                                                                            ');
			rstHtml.append(poContCodeHtml);
			rstHtml.append('	   					</select>                                                                           ');
			rstHtml.append('	   				</div>                                                                                  ');
			rstHtml.append('	   			</li>                                                                                       ');
			rstHtml.append('	   			<li><span class="title">처분내용</span>                                                         ');
			rstHtml.append('	   				<label for="rst_dipCont_'+i+'_'+j+'"></label><input type="text" class="w80per" id="rst_dipCont_'+i+'_'+j+'" name="rst_dipCont" value="" />    ');
			rstHtml.append('	   			</li>                                                                                       ');
			rstHtml.append('	   			<li><span class="title">벌금액</span>                                                         ');
			rstHtml.append('	   				<label for="rst_fnAmt_'+i+'_'+j+'"></label><input type="text" class="w10per" id="rst_fnAmt_'+i+'_'+j+'" name="rst_fnAmt" value="" /><span class="sub_title">만원</span>    ');
			rstHtml.append('	   			</li>                                                                                       ');
			rstHtml.append('	   		</ul>                                                                                           ');
			rstHtml.append('	   	</div>                                                                                              ');
		
		});
		
		rstHtml.append('	   	</td>                                                                                                ');
		rstHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
		rstHtml.append('   </tbody>                                                                                                                                                                                                                                          ');
		rstHtml.append('</table>                                                                                                                                                                                                                                             ');
		rstHtml.append('</div>                                                                                                                                                                                                                                             ');
	});
	
	//수사상태가 [ 송치가결(73), 재송치가결(78) ] 일 경우에만
	if(b0101VOMap.criStatCd == "73" || b0101VOMap.criStatCd == "78"){
		rstHtml.append('<div class="btnArea">																					');
		
		//처분진행탭에 처분등록 버튼 노출
		$.each(b0101VOMap.taskTrstVOList, function(index, taskTrstVO) {
			console.log(taskTrstVO.trstStatNm);
			console.log(taskTrstVO.trstStatNum);
			console.log(taskTrstVO.taskRespMb);
			console.log(taskTrstVO.criStatCd);
			if (SJPBRole.getHasAnyRole(taskTrstVO.taskRoleCd)) {	//역할에 맞는 버튼만 보이도록 처리
				rstHtml.append(" <div class=\"r_btn\"><a href=\"javascript:void(0);\" class=\"btn_blue\" name=\"trstBtn\" value=\""+taskTrstVO.trstStatNm+"\" data-update-type=\"5\" data-trst-stat-nm=\""+taskTrstVO.trstStatNm+"\" data-trst-stat-num=\""+taskTrstVO.trstStatNum+"\" data-cri-stat-cd=\""+taskTrstVO.criStatCd+"\" data-wf-num=\""+taskTrstVO.wfNum+"\" data-always=\"y\"><span>"+taskTrstVO.trstStatNm+"</span></a></div> ");			
			}
		});
	
		rstHtml.append('</div>                                                                                                 ');
			
	}
	
	$("#ocrt_list_tab2_div").html(rstHtml.toString());
	
	//TODO 송치관이 아닐경우에는, 입력화면이 보일필요가 없는거 아닐까?
	//송치관이 아닐경우에는 읽기만 가능 (송치관만 수정가능)
	if(SJPBRole.getTrnsrRoleYn() && (b0101VOMap.criStatCd == "73" || b0101VOMap.criStatCd == "78")){
		//수정가능 
		
		//이벤트바인딩 (selectbox)
		setTargetDefaultEvent( $("#ocrt_list_tab2_div") );
		
		//달력이벤트
		$(".datepicker").datepicker({
			  dateFormat: "yy-mm-dd"  
		});
		
	}else{
		//수정 불가능
		areaSetReadOnly($("#ocrt_list_tab2_div"));
	}
	
	//타스크이행
	eventTaskBtn();
	
	//화면사이즈 갱신
	autoResize();
	
}


//판결진행 입력 화면 노출(그리기)
function insertIncJdtRstView(data){
	
	var rstHtml = new StringBuffer();  
	
	rstHtml.append('<div class="listArea">																								');
	rstHtml.append('	<table class="list" cellpadding="0" cellspacing="0">                                                            ');
	rstHtml.append('		<colgroup>                                                                                                  ');
	rstHtml.append('			<col width="15%" />                                                                                     ');
	rstHtml.append('			<col width="*%" />                                                                                      ');
	rstHtml.append('		</colgroup>                                                                                                 ');
	rstHtml.append('		<tbody>                                                                                                     ');
	rstHtml.append('                                                                                                                    ');
	rstHtml.append('			<tr>                                                                                                    ');
	rstHtml.append('				<th class="C">판결확정</th>                                                                             ');
	rstHtml.append('				<td class="L">                                                                                      ');
	rstHtml.append('					<label for="txt_98"></label><input type="text" class="w20per calendar datepicker" data-type="date" title="판결확정일" id="txt_98" name="jdtFiDt" />           ');
	rstHtml.append('				</td>                                                                                               ');
	rstHtml.append('			</tr>                                                                                                   ');
	rstHtml.append('		</tbody>                                                                                                    ');
	rstHtml.append('	</table>                                                                                                        ');
	rstHtml.append('</div>                                                                                                              ');
	
	//피의자
	var spNum = 0;
	$.each(b0101VOMap.incSpVOList, function(i, incSpVO) {
		
		var spIdNumDec =  Base64.decode(incSpVO.spIdNum);
		var spNmDec = Base64.decode(incSpVO.spNm);
		
		spNum++;
		
		rstHtml.append('<div class="personinfo" data-name="jdtpersoninfo">                                                                                                                                                                                                                                ');
		
		rstHtml.append('<table name="grid-table-sp" class="list" cellpadding="0" cellspacing="0">                                                                                                                                                                                                 ');
		
		rstHtml.append('	<input type="hidden" name="jdt_spIdNum" value="'+spIdNumDec+'" />  ');
		rstHtml.append('	<input type="hidden" name="jdt_spNm" value="'+spNmDec+'" />  ');
		rstHtml.append('	<input type="hidden" name="jdt_rcptNum" value="'+incSpVO.rcptNum+'" />  ');
		rstHtml.append('	<input type="hidden" name="jdt_incSpNum" value="'+incSpVO.incSpNum+'" />   ');
		
		rstHtml.append('   <colgroup>                                                                                                                                                                                                                                        ');
		rstHtml.append('   <col width="10%" />                                                                                                                                                                                                                               ');
		rstHtml.append('   <col width="15%" />                                                                                                                                                                                                                               ');
		rstHtml.append('   <col width="30%" />                                                                                                                                                                                                                               ');
		rstHtml.append('   <col width="15%" />                                                                                                                                                                                                                               ');
		rstHtml.append('   <col width="30%" />                                                                                                                                                                                                                               ');
		rstHtml.append('   </colgroup>                                                                                                                                                                                                                                       ');
		rstHtml.append('   <tbody>                                                                                                                                                                                                                                           ');
		rstHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		rstHtml.append('		   <th class="C line_right" rowspan="9">피의자 정보</th>                                                                                                                                                                                             ');
		
		if(incSpVO.indvCorpDiv == "1" ){	//개인
			rstHtml.append('		   <th class="C">성명</th>                                                                                                                                                                                                                        ');
		}else{	//법인
			rstHtml.append('		   <th class="C">법인명</th>                                                                                                                                                                                                                        ');
		}
		
		rstHtml.append('		   <td class="L" colspan="3">'+spNmDec+'</td>                                                                                                                                                                                                                              ');
		rstHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
		rstHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		rstHtml.append('	   <td colspan="4" class="L">																			');
		
		$.each(incSpVO.actVioVOList, function(j, ActVioVO) {
		
			rstHtml.append('	   	<div class="law">                                                                                   ');
			rstHtml.append('			<input type="hidden" name="jdt_actVio_incSpNum" value="'+ActVioVO.incSpNum+'" />  ');
			rstHtml.append('			<input type="hidden" name="jdt_actVio_actVioNum" value="'+ActVioVO.actVioNum+'" />  ');
			rstHtml.append('	   		<ul>                                                                                            ');
			rstHtml.append('	   			<li><span class="title">관련법률 및 죄명</span>                                                    ');
			rstHtml.append('	   				<label for="jdt_rltActCriNmCdDesc_'+i+'_'+j+'"></label><input type="text" class="w80per" id="jdt_rltActCriNmCdDesc_'+i+'_'+j+'" name="jdt_rltActCriNmCdDesc" value="'+ActVioVO.rltActCriNmCdDesc+'" disabled="true" data-readonly="y"/>    ');
			rstHtml.append('	   			</li>                                                                                       ');
			rstHtml.append('	   			<li><span class="title">판결내용</span>                                                         ');
			rstHtml.append('	   				<label for="jdt_jdtCont_'+i+'_'+j+'"></label><input type="text" class="w80per" id="jdt_jdtCont_'+i+'_'+j+'" name="jdt_jdtCont" value="" />    ');
			rstHtml.append('	   			</li>                                                                                       ');
			rstHtml.append('	   			<li><span class="title">기타</span>                                                         ');
			rstHtml.append('	   				<label for="jdt_jdtOp_'+i+'_'+j+'"></label><input type="text" class="w80per" id="jdt_jdtOp_'+i+'_'+j+'" name="jdt_jdtOp" value="" />    ');
			rstHtml.append('	   			</li>                                                                                       ');
			rstHtml.append('	   		</ul>                                                                                           ');
			rstHtml.append('	   	</div>                                                                                              ');
		
		});
		
		rstHtml.append('	   	</td>                                                                                                ');
		rstHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
		rstHtml.append('   </tbody>                                                                                                                                                                                                                                          ');
		rstHtml.append('</table>                                                                                                                                                                                                                                             ');
		rstHtml.append('</div>                                                                                                                                                                                                                                             ');
	});
	
	//수사상태가 [ 사건처분완료(90) ] 일 경우에만
	if(b0101VOMap.criStatCd == "90"){
		rstHtml.append('<div class="btnArea">																					');
		
		//처분진행탭에 처분등록 버튼 노출
		$.each(b0101VOMap.taskTrstVOList, function(index, taskTrstVO) {
			console.log(taskTrstVO.trstStatNm);
			console.log(taskTrstVO.trstStatNum);
			console.log(taskTrstVO.taskRespMb);
			console.log(taskTrstVO.criStatCd);
			if (SJPBRole.getHasAnyRole(taskTrstVO.taskRoleCd)) {	//역할에 맞는 버튼만 보이도록 처리
				rstHtml.append(" <div class=\"r_btn\"><a href=\"javascript:void(0);\" class=\"btn_blue\" name=\"trstBtn\" value=\""+taskTrstVO.trstStatNm+"\" data-update-type=\"7\" data-trst-stat-nm=\""+taskTrstVO.trstStatNm+"\" data-trst-stat-num=\""+taskTrstVO.trstStatNum+"\" data-cri-stat-cd=\""+taskTrstVO.criStatCd+"\" data-wf-num=\""+taskTrstVO.wfNum+"\" data-always=\"y\"><span>"+taskTrstVO.trstStatNm+"</span></a></div> ");			
			}
		});
	
		rstHtml.append('</div>                                                                                                 ');
			
	}
	
	$("#ocrt_list_tab3_div").html(rstHtml.toString());
	
	//TODO 송치관이 아닐경우에는, 입력화면이 보일필요가 없는거 아닐까?
	//송치관이 아닐경우에는 읽기만 가능 (송치관만 수정가능)
	if(SJPBRole.getTrnsrRoleYn() && b0101VOMap.criStatCd == "90"){
		//수정가능 
		
		//이벤트바인딩 (selectbox)
		setTargetDefaultEvent( $("#ocrt_list_tab3_div") );
		
		//달력이벤트
		$(".datepicker").datepicker({
			  dateFormat: "yy-mm-dd"  
		});
		
	}else{
		//수정 불가능
		areaSetReadOnly($("#ocrt_list_tab3_div"));
	}
	
	//타스크이행
	eventTaskBtn();
	
	//화면사이즈 갱신
	autoResize();
}

//판결진행 수정/조회 화면 노출(그리기)
function updateIncJdtRstView(data){
	
	var rstHtml = new StringBuffer();  
	
	rstHtml.append('<div class="listArea">																								');
	rstHtml.append('	<table class="list" cellpadding="0" cellspacing="0">                                                            ');
	rstHtml.append('		<colgroup>                                                                                                  ');
	rstHtml.append('			<col width="15%" />                                                                                     ');
	rstHtml.append('			<col width="*%" />                                                                                      ');
	rstHtml.append('		</colgroup>                                                                                                 ');
	rstHtml.append('		<tbody>                                                                                                     ');
	rstHtml.append('                                                                                                                    ');
	rstHtml.append('			<tr>                                                                                                    ');
	rstHtml.append('				<th class="C">판결확정</th>                                                                             ');
	rstHtml.append('				<td class="L">                                                                                      ');
	rstHtml.append('					<label for="txt_98"></label><input type="text" class="w20per calendar datepicker" data-type="date" title="판결확정일" id="txt_98" name="jdtFiDt" value="'+getParamValue(b0101VOMap.jdtFiDt)+'" />           ');
	rstHtml.append('				</td>                                                                                               ');
	rstHtml.append('			</tr>                                                                                                   ');
	rstHtml.append('		</tbody>                                                                                                    ');
	rstHtml.append('	</table>                                                                                                        ');
	rstHtml.append('</div>                                                                                                              ');
	
	//피의자
	var spNum = 0;
	$.each(b0101VOMap.incSpVOList, function(i, incSpVO) {
		
		var spIdNumDec =  Base64.decode(incSpVO.spIdNum);
		var spNmDec = Base64.decode(incSpVO.spNm);
		
		spNum++;
		
		rstHtml.append('<div class="personinfo" data-name="jdtpersoninfo">                                                                                                                                                                                                                                ');
		
		rstHtml.append('<table name="grid-table-sp" class="list" cellpadding="0" cellspacing="0">                                                                                                                                                                                                 ');
		
		rstHtml.append('	<input type="hidden" name="jdt_spIdNum" value="'+spIdNumDec+'" />  ');
		rstHtml.append('	<input type="hidden" name="jdt_spNm" value="'+spNmDec+'" />  ');
		rstHtml.append('	<input type="hidden" name="jdt_rcptNum" value="'+incSpVO.rcptNum+'" />  ');
		rstHtml.append('	<input type="hidden" name="jdt_incSpNum" value="'+incSpVO.incSpNum+'" />   ');
		
		rstHtml.append('   <colgroup>                                                                                                                                                                                                                                        ');
		rstHtml.append('   <col width="10%" />                                                                                                                                                                                                                               ');
		rstHtml.append('   <col width="15%" />                                                                                                                                                                                                                               ');
		rstHtml.append('   <col width="30%" />                                                                                                                                                                                                                               ');
		rstHtml.append('   <col width="15%" />                                                                                                                                                                                                                               ');
		rstHtml.append('   <col width="30%" />                                                                                                                                                                                                                               ');
		rstHtml.append('   </colgroup>                                                                                                                                                                                                                                       ');
		rstHtml.append('   <tbody>                                                                                                                                                                                                                                           ');
		rstHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		rstHtml.append('		   <th class="C line_right" rowspan="9">피의자 정보</th>                                                                                                                                                                                             ');
		
		if(incSpVO.indvCorpDiv == "1" ){	//개인
			rstHtml.append('		   <th class="C">성명</th>                                                                                                                                                                                                                        ');
		}else{	//법인
			rstHtml.append('		   <th class="C">법인명</th>                                                                                                                                                                                                                        ');
		}
		
		rstHtml.append('		   <td class="L" colspan="3">'+spNmDec+'</td>                                                                                                                                                                                                                              ');
		rstHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
		rstHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		rstHtml.append('	   <td colspan="4" class="L">																			');
		
		$.each(incSpVO.actVioVOList, function(j, ActVioVO) {
		
			rstHtml.append('	   	<div class="law">                                                                                   ');
			rstHtml.append('			<input type="hidden" name="jdt_actVio_incSpNum" value="'+ActVioVO.incSpNum+'" />  ');
			rstHtml.append('			<input type="hidden" name="jdt_actVio_actVioNum" value="'+ActVioVO.actVioNum+'" />  ');
			rstHtml.append('	   		<ul>                                                                                            ');
			rstHtml.append('	   			<li><span class="title">관련법률 및 죄명</span>                                                    ');
			rstHtml.append('	   				<label for="jdt_rltActCriNmCdDesc_'+i+'_'+j+'"></label><input type="text" class="w80per" id="jdt_rltActCriNmCdDesc_'+i+'_'+j+'" name="jdt_rltActCriNmCdDesc" value="'+ActVioVO.rltActCriNmCdDesc+'" disabled="true" data-readonly="y"/>    ');
			rstHtml.append('	   			</li>                                                                                       ');
			rstHtml.append('	   			<li><span class="title">판결내용</span>                                                         ');
			rstHtml.append('	   				<label for="jdt_jdtCont_'+i+'_'+j+'"></label><input type="text" class="w80per" id="jdt_jdtCont_'+i+'_'+j+'" name="jdt_jdtCont" value="'+getParamValue(ActVioVO.incJdtRstVO.jdtCont)+'" />    ');
			rstHtml.append('	   			</li>                                                                                       ');
			rstHtml.append('	   			<li><span class="title">기타</span>                                                         ');
			rstHtml.append('	   				<label for="jdt_jdtOp_'+i+'_'+j+'"></label><input type="text" class="w80per" id="jdt_jdtOp_'+i+'_'+j+'" name="jdt_jdtOp" value="'+getParamValue(ActVioVO.incJdtRstVO.jdtOp)+'" />    ');
			rstHtml.append('	   			</li>                                                                                       ');
			rstHtml.append('	   		</ul>                                                                                           ');
			rstHtml.append('	   	</div>                                                                                              ');
		
		});
		
		rstHtml.append('	   	</td>                                                                                                ');
		rstHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
		rstHtml.append('   </tbody>                                                                                                                                                                                                                                          ');
		rstHtml.append('</table>                                                                                                                                                                                                                                             ');
		rstHtml.append('</div>                                                                                                                                                                                                                                             ');
	});
	
	//수사상태가 [ 사건판결완료(91) ] 일 경우에만
	if(b0101VOMap.criStatCd == "91"){
		rstHtml.append('<div class="btnArea">																					');
		rstHtml.append(" <div class=\"r_btn\"><a href=\"javascript:updateIncident(8);\" class=\"btn_blue\" name=\"updateIncJdtRstBtn\"><span>수정</span></a></div> ");
		rstHtml.append('</div>                                                                                                 ');
	}
	
	$("#ocrt_list_tab3_div").html(rstHtml.toString());
	
	//TODO 송치관이 아닐경우에는, 입력화면이 보일필요가 없는거 아닐까?
	//송치관이 아닐경우에는 읽기만 가능 (송치관만 수정가능)
	if(SJPBRole.getTrnsrRoleYn() && b0101VOMap.criStatCd == "91"){
		//수정가능 
		
		//이벤트바인딩 (selectbox)
		setTargetDefaultEvent( $("#ocrt_list_tab3_div") );
		
		//달력이벤트
		$(".datepicker").datepicker({
			  dateFormat: "yy-mm-dd"  
		});
		
	}else{
		//수정 불가능
		areaSetReadOnly($("#ocrt_list_tab3_div"));
	}
	
	//타스크이행
	eventTaskBtn();
	
	//화면사이즈 갱신
	autoResize();
	
}

//검찰처분결과 데이터 갱신
function syncIncDipRstVOList(paramMap){
	
	//var incDipRstVO = new Object();
	
	paramMap.rcptNum = b0101VOMap.rcptNum;
	
	paramMap.crlwNum = $("input[name=crlwNum]").val();
	paramMap.poDipDt = $("input[name=poDipDt]").val();
	
	
	//피의자정보 셋팅 n명
	//radio 는 data-name 으로 찾는다. 
	var incSpVOArray = new Array();
	$("div[data-name=rstpersoninfo]").each(function(i) {
		
		var incSpVO = {
			incSpNum : $(this).find("input[name=rst_incSpNum]").val()
			,rcptNum : $(this).find("input[name=rst_rcptNum]").val()
			,spNm : Base64.encode($(this).find("input[name=rst_spNm]").val())
		}
		
		//법률정보
		var actVioVOArray = new Array();
		
		$($(this).find(".law")).each(function(j) {
			var ActVioVO = {
					incSpNum : $(this).find("input[name=rst_actVio_incSpNum]").val()		//사용안함
					,actVioNum : $(this).find("input[name=rst_actVio_actVioNum]").val()		//사용안함
			}
			
			var IncDipRstVO = {
					incSpNum : $(this).find("input[name=rst_actVio_incSpNum]").val()		
					,actVioNum : $(this).find("input[name=rst_actVio_actVioNum]").val()		
					,poContCd : $(this).find("select[name=rst_poContCd]").val()
					,dipCont : $(this).find("input[name=rst_dipCont]").val()
					,fnAmt : $(this).find("input[name=rst_fnAmt]").val()
			}
			
			ActVioVO.incDipRstVO = IncDipRstVO;
		
			//법률위반 셋팅
			actVioVOArray.push(ActVioVO);
		});
		
		incSpVO.actVioVOList = actVioVOArray;
		incSpVOArray.push(incSpVO);
	});
	paramMap.incSpVOList = incSpVOArray;
}

//검찰판결결과 데이터 갱신
function syncIncJdtRstVOList(paramMap){
	
	paramMap.rcptNum = b0101VOMap.rcptNum;
	
	paramMap.jdtFiDt = $("input[name=jdtFiDt]").val();
	
	//피의자정보 셋팅 n명
	//radio 는 data-name 으로 찾는다. 
	var incSpVOArray = new Array();
	$("div[data-name=jdtpersoninfo]").each(function(i) {
		
		var incSpVO = {
			incSpNum : $(this).find("input[name=jdt_incSpNum]").val()
			,rcptNum : $(this).find("input[name=jdt_rcptNum]").val()
			,spNm : Base64.encode($(this).find("input[name=jdt_spNm]").val())
		}
		
		//법률정보
		var actVioVOArray = new Array();
		
		$($(this).find(".law")).each(function(j) {
			var ActVioVO = {
					incSpNum : $(this).find("input[name=jdt_actVio_incSpNum]").val()		//사용안함
					,actVioNum : $(this).find("input[name=jdt_actVio_actVioNum]").val()		//사용안함
			}

			//판결진행VO
			var incJdtRstVO = {
				actVioNum : $(this).find("input[name=jdt_actVio_actVioNum]").val()		
				,incSpNum : $(this).find("input[name=jdt_actVio_incSpNum]").val()	
				,jdtCont : $(this).find("input[name=jdt_jdtCont]").val()	
				,jdtOp : $(this).find("input[name=jdt_jdtOp]").val()	
			}
			
			ActVioVO.incJdtRstVO = incJdtRstVO;
		
			//법률위반 셋팅
			actVioVOArray.push(ActVioVO);
		});
		
		incSpVO.actVioVOList = actVioVOArray;
		incSpVOArray.push(incSpVO);
	});
	paramMap.incSpVOList = incSpVOArray;
}

//처분결과 등록 
function insertIncDipRst(){
	
}

//송치정보 > 처분진행 (사건처분결과 상세를 가져온다.) 
function selectIncDipRstDetails(){
	goAjax("/sjpb/B/selectIncDipRstDetails.face", b0101VOMap, callBackSelectIncDipRstDetailsSuccess);
}

//송치정보 > 처분진행 성공 콜백함수
function callBackSelectIncDipRstDetailsSuccess(data){
	b0101VOMap = data.b0101VO;
	
	//1. 송치가결, 재송치가결 상태인경우에는 신규입력.
	if(b0101VOMap.criStatCd == "73" || b0101VOMap.criStatCd == "78"){
		insertIncDipRstView(data);
		
	//2. 그 외, 90번 이상인 상태에는 데이터 불러와서 보여주기.
	}else{
		updateIncDipRstView(data);
	}
	
}

//송치정보 > 판결진행 (사건판결결과 상세를 가져온다.) 
function selectIncJdtRstDetails(){
	goAjax("/sjpb/B/selectIncJdtRstDetails.face", b0101VOMap, callBackSelectIncJdtRstDetailsSuccess);
}

//송치정보 > 판결진행 성공 콜백함수
function callBackSelectIncJdtRstDetailsSuccess(data){
	b0101VOMap = data.b0101VO;
	
	//1. 사건처분완료인 경우에는 신규입력.
	if(b0101VOMap.criStatCd == "90"){
		insertIncJdtRstView(data);
		
		
	//2. 그 외, 91번 이상인 상태에는 데이터 불러와서 보여주기.
	}else{
		updateIncJdtRstView(data);
	}
	
}

//Map 데이터 초기화
function initIncCriCmdItemVOMap() {	
	incCriCmdItemVO =  {		
			incCriCmdItemNum : ""  //사건수사지휘건번호
			,rcptNum : ""          //접수번호
			,incCriCmdItemStatCd : "" //사건수사지휘건상태코드 01:접수, 02:등록, 03:건의, 04:수령
			,incCriCmdBkNum : ""   //사건수사지휘부번호	
			,criCmdTranDt : ""   //수사지휘인계일
			,criCmdReqDt : ""    //수사지휘접수일
			,criCmdRcptDt : ""   //수사지휘수령일
			,reCmdYn : ""        //재지휘여부
			,criCmdRst : ""      //수사지휘결과
			,criCmdComn : ""     //수사지휘의견
			,incCriNm : ""       //사건죄명
			,incSp : ""          //사건피의자
			,incArrtClsf : ""    //사건구속별
			,evidArtcYn : ""     //증거품유무
			,rcptIncNum : ""     //사건번호
			,criCmdProDt : ""	  //수사지휘건의일
			,updStatYN : ""       //상태변경유무	
			,regUserId : ""
			,regDate : ""
			,updUserId : ""
			,updDate : ""		
		}
}

//Map 데이터 초기화
function initIncTrfItemVOMap() {	
	incTrfItemVO =  {		
			incTrfItemNum : ""  //사건송치건번호
			,rcptNum : ""          //접수번호
			,incTrfItemStatCd : "" //사건송치건상태코드 01:접수, 02:등록, 03:건의, 04:수령
			,incTrfBkNum : ""   //사건송치부번호	
			,trfTranDt : ""   //송치인계일
			,trfReqDt : ""    //송치접수일
			,trfRcptDt : ""   //송치수령일
			,reCmdYn : ""        //재송치여부
			,trfRst : ""      //송치결과
			,trfComn : ""     //송치의견
			,incCriNm : ""       //사건죄명
			,incSp : ""          //사건피의자
			,incArrtClsf : ""    //사건구속별
			,evidArtcYn : ""     //증거품유무
			,rcptIncNum : ""     //사건번호
			,trfProDt : ""	  //송치건의일
			,trfNum : ""      //송치번호	
			,updStatYN : ""       //상태변경유무	
			,regUserId : ""
			,regDate : ""
			,updUserId : ""
			,updDate : ""		
		}
}

//수사지휘
var incCriCmdItemVO =  {		
	incCriCmdItemNum : ""  //사건수사지휘건번호
	,rcptNum : ""          //접수번호
	,incCriCmdItemStatCd : "" //사건수사지휘건상태코드 01:접수, 02:등록, 03:건의, 04:수령
	,incCriCmdBkNum : ""   //사건수사지휘부번호	
	,criCmdTranDt : ""   //수사지휘인계일
	,criCmdReqDt : ""    //수사지휘접수일
	,criCmdRcptDt : ""   //수사지휘수령일
	,reCmdYn : ""        //재지휘여부
	,criCmdRst : ""      //수사지휘결과
	,criCmdComn : ""     //수사지휘의견
	,incCriNm : ""       //사건죄명
	,incSp : ""          //사건피의자
	,incArrtClsf : ""    //사건구속별
	,evidArtcYn : ""     //증거품유무
	,rcptIncNum : ""     //사건번호
	,criCmdProDt : ""	  //수사지휘건의일
	,updStatYN : ""       //상태변경유무	
	,regUserId : ""
	,regDate : ""
	,updUserId : ""
	,updDate : ""		
}

//송치
var incTrfItemVO =  {		
	incTrfItemNum : ""  //사건송치건번호
	,rcptNum : ""          //접수번호
	,incTrfItemStatCd : "" //사건송치건상태코드 01:접수, 02:등록, 03:건의, 04:수령
	,incTrfBkNum : ""   //사건송치부번호	
	,trfTranDt : ""   //송치인계일
	,trfReqDt : ""    //송치접수일
	,trfRcptDt : ""   //송치수령일
	,reCmdYn : ""        //재송치여부
	,trfRst : ""      //송치결과
	,trfComn : ""     //송치의견
	,incCriNm : ""       //사건죄명
	,incSp : ""          //사건피의자
	,incArrtClsf : ""    //사건구속별
	,evidArtcYn : ""     //증거품유무
	,rcptIncNum : ""     //사건번호
	,trfProDt : ""	  //송치건의일
	,trfNum : ""      //송치번호	
	,updStatYN : ""       //상태변경유무	
	,regUserId : ""
	,regDate : ""
	,updUserId : ""
	,updDate : ""		
	,criIncDtaVOList : null  //수사사건자료	
	,sjpbFileVOList : null  //첨부파일	
}

//처분진행 
var incDipRstVO = {
	actVioNum : ""		//법률위반번호
	,incSpNum : ""		//사건피의자번호
	,poContCd : ""		//검찰내용
	,dipCont : ""		//처분내용
	,fnAmt : ""			//벌금액
	,regUserId : ""		//등록자
	,regDate : ""		//등록일자
	,updUserId : ""		//수정자
	,updDate : ""		//수정일자

}

//판결진행 
var incJdtRstVO = {
	actVioNum : ""		//법률위반번호
	,incSpNum : ""		//사건피의자번호
	,jdtCont : ""		//판결내용
	,jdtOp : ""			//판결의견
	,regUserId : ""		//등록자
	,regDate : ""		//등록일자
	,updUserId : ""		//수정자
	,updDate : ""		//수정일자
}

