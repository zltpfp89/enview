
/* 송치정보 스크립트 */
$(document).ready(function(){
	//이벤트 세팅
	eventSetupTrf();
});


//이벤트 세팅
function eventSetupTrf() {
	
}

//STEP1,2,3,4 이벤트 바인딩 (지정)
function ocrtSubTabEventBind(index,rest){
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
			if(rest == "R"){
				$("#"+$(this).attr("id")+"_em").html("부결");	//상단 STEP 완료로 변경 
			}else{
				$(this).addClass("sub_tab_on");
				$("." + $(this).attr("id") ).show();
				$("#"+$(this).attr("id")+"_em").html("진행중");	//상단 STEP 진행중으로 변경 
				eval($(this).data("href"));
			}
			
		//완료된 STEP
		}else{
			if(rest == "R"){
				$(this).addClass("sub_tab_on");
				$("." + $(this).attr("id") ).show();
				$("#"+$(this).attr("id")+"_em").html("재진행중");	//상단 STEP 완료로 변경 
				eval($(this).data("href"));
			}else{
				$("#"+$(this).attr("id")+"_em").html("완료");	//상단 STEP 완료로 변경 
			}
			
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
	//initEditActionManager();
	//수현1230
	//b0101VOMap.taskNum
	var staskNum = isNull(b0101VOMap.taskNum) ? 1 : Number(b0101VOMap.taskNum) ;
	
	var fileListHtml = "";
	//수사지휘건의 	50 ~ 59 
	//송치 			70 ~ 79
	//처분진행		90 ~ 91	
	//판결진행 		92
	//이벤트 해제 
	ocrtSubTabEventUnbind();
	if(scriStatCd == 22 || scriStatCd == 24 || scriStatCd == 40){
		
		selectIncCriCmdItemDetails();
		
		//STEP1, 이벤트바인딩
		ocrtSubTabEventBind(1,"");
		
	//수사지휘건의
	//지휘접수완료[52],지휘결과"부"[54],재지휘접수완료[57],재지휘결과"부"[59]
	}else if("52,54,57,59".indexOf(scriStatCd) != -1){
		//수현1230
		if( (staskNum >=16 && staskNum <= 19) || (staskNum >= 60 && staskNum <=63) ){
			selectIncTrfItemDetails();
			
			//그외, STEP2, 이벤트바인딩
			ocrtSubTabEventBind(2,"R");
		}else{
			selectIncCriCmdItemDetails();

			//STEP1, 이벤트바인딩
			ocrtSubTabEventBind(1,"");
		}	
		
	//송치
	//지휘결과"부"[53],재지휘결과"부"[58],송치완료[72],재송치완료[77]
	}else if("53,58,72,77".indexOf(scriStatCd) != -1){
	
		selectIncTrfItemDetails();
		
		//그외, STEP2, 이벤트바인딩
		ocrtSubTabEventBind(2,"");
		
	//송치가결, 재송치가결의 경우에는 처분진행탭 활성화 
	}else if("73,78".indexOf(scriStatCd) != -1){
		selectIncDipRstDetails();			
		//STEP3, 이벤트바인딩
		ocrtSubTabEventBind(3,"");
	//송치 부결, 재송치 부결의 경우에는 송치 단계는 부결
	}else if("74,79".indexOf(scriStatCd) != -1){
		selectIncTrfItemDetails();
		
		//그외, STEP3, 이벤트바인딩
		ocrtSubTabEventBind(2,"R");
	//판결진행
	}else if(90 == scriStatCd){
		selectIncJdtRstDetails();
		
		//STEP4, 이벤트바인딩
		ocrtSubTabEventBind(4,"");
	
		//판결문 업로드를 위해 추가(20-04-21)
		sjpbFile.init();
	//판결완료
	}else if(91 <= scriStatCd){
		selectIncJdtRstDetails();
		
		//STEP4, 이벤트바인딩
		ocrtSubTabEventBind(5,"");
		
		//판결문 업로드를 위해 추가(20-04-21)
		sjpbFile.init();
	}
	
	autoResize();
}

//송치정보 > 송치진행 (사건송치건 상세를 가져온다.)
function selectIncTrfItemDetails(){
	incTrfItemVO.rcptNum = b0101VOMap.rcptNum;
	//incTrfItemVO.pareRcptNum = b0101VOMap.pareRcptNum;
	goAjax("/sjpb/B/selectIncTrfItemDetails.face", incTrfItemVO, callBackSelectIncTrfItemDetailsSuccess);
}

//수사사건송치건 상세 성공 콜백함수
function callBackSelectIncTrfItemDetailsSuccess(data){
	
	//송치서류목록 숨김
//	$("#ocrt_list_tab1_div_step2").hide();
	
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
		
		itemHtml.append('<div class="listArea" data-inc-trf-item-num="'+item.incTrfItemNum+'" data-re-trf-yn="'+item.reTrfYn+'" data-pre-title="'+preTitle+'">																	');
		itemHtml.append('	<table class="list" cellpadding="0" cellspacing="0">                                ');
		itemHtml.append('		<colgroup>                                                                      ');
		itemHtml.append('			<col width="15%" />                                                 ');
		itemHtml.append('			<col width="35%" />                                                 ');
		itemHtml.append('			<col width="15%" />                                                 ');
		itemHtml.append('			<col width="35%" />                                                 ');
		itemHtml.append('		</colgroup>                                                                     ');
		itemHtml.append('		<tbody>                                                                         ');
		if(preTitle ==""){
			itemHtml.append('			<tr>                                                                        ');
			
			itemHtml.append('				<th class="C">'+preTitle+'송치기관</th>                                                 ');
			itemHtml.append('				<td class="L" colspan="3">'+item.respDppoDesc+'</td>                                                 ');
		
			itemHtml.append('			</tr>                                                                        ');
		}
		itemHtml.append('			<tr>                                                                        ');
		itemHtml.append('				<th class="C">송치번호</th>                                                 ');
		itemHtml.append('				<td class="L"><span name="trfNum" id="trfNum_'+i+'" >'+item.trfNum+'</span></td>                                                 ');
		itemHtml.append('				<th class="C">'+preTitle+'송치접수일</th>                                                 ');
		itemHtml.append('				<td class="L"><input type="text" name="trfReqDt" id="trfReqDt_'+i+'" data-type="date" data-optional-value="false" date-error-message="유효한 날짜를 입력해주세요." class="80per calendar datepicker" data-always="y" title="송치접수일" value="'+item.trfReqDt+'" ></td>                                                 ');
		itemHtml.append('			</tr>                                                                        ');
		
		itemHtml.append('			<tr>                                                                        ');
		itemHtml.append('				<th class="C">'+preTitle+'송치건의일</th>                                                 ');
		itemHtml.append('				<td class="L"><input type="text" name="trfProDt" id="trfProDt_'+i+'" data-type="date" data-optional-value="false" date-error-message="유효한 날짜를 입력해주세요." class="80per calendar datepicker" data-always="y" title="송치일시" value="'+item.trfProDt+'" ></td>                                           ');
		itemHtml.append('				<th class="C">'+preTitle+'송치결과</th>                                     ');
		itemHtml.append('				<td class="L">                                     ');
		itemHtml.append('	   				<div class="inputbox w80per">                                                       ');	
		itemHtml.append('	   					<p class="txt"></p>                                                   ');	
		itemHtml.append('				   		<select name="trfRst" id="trfRst_'+i+'" title="송치결과" '+(item.trfRst != "" ? "disabled" : "" )+' data-type="select"  data-optional-value="false">                                                                                                                                                                                                                             ');
		itemHtml.append('							<option value="">선택</option>');
		itemHtml.append('							<option value="Y" '+(item.trfRst == 'Y' ? "selected=\"selected\"" : "")+'>가</option>');
		//itemHtml.append('							<option value="N" '+(item.trfRst == 'N' ? "selected=\"selected\"" : "")+'>부</option>');
		itemHtml.append('	   					</select>                                                                       ');	
		itemHtml.append('	   				</div>                                                                              ');	
		itemHtml.append('				</td>                                     ');
		itemHtml.append('			</tr>                                                                        ');
		/*
		itemHtml.append('			<tr>                                                                        ');
		itemHtml.append('				<th class="C">'+preTitle+'송치결과수령일</th>                                                 ');
		itemHtml.append('				<td class="L"><input type="text" name="trfRcptDt" id="trfRcptDt_'+i+'" data-type="date" data-optional-value="false" date-error-message="유효한 날짜를 입력해주세요." class="80per calendar datepicker" title="송치결과수령일" value="'+item.trfRcptDt+'" ></td>                                           ');
		
		itemHtml.append('				<th class="C" rowspan="1">'+preTitle+'송치의견</th>                                     ');
		itemHtml.append('				<td class="L"><label for="trfComn"></label><input type="text" class="w100per" name="trfComn" id="trfComn" value="'+item.trfComn+'"/> </td>                   ');
		itemHtml.append('			</tr>                                                                       ');
		*/
		itemHtml.append('		</tbody>                                                                        ');
		itemHtml.append('	</table>                                                                            ');
		itemHtml.append('	<div class="btnArea">                                                                                                                                                                                                                                ');
		itemHtml.append('   	<div class="r_btn">                                                                                                                    ');
		itemHtml.append('   		<a href="javascript:void(0);" onclick="javascript:'+(item.trfRst == ""? "updateTrfTask(this);" : "updateTrfItem(this);")+'" class="btn_light_blue save" id="trfUpdateBtn"><span>저장</span></a>                                                                                                                     ');
		itemHtml.append('		</div>  ');
		itemHtml.append('	</div>  ');
		itemHtml.append('</div>                                                                                  ');
		
		//마지막일경우,
		if(i == incTrfItemLength - 1){
			
			//마지막상태 저장
        	incTrfItemStatCdLast = item.incTrfItemStatCd;
        	trfRstLast = item.trfRst;
		
			
		}
	});
	
	var preTitle2 = "";
	if(incTrfItemLength > 0) preTitle2 = "재 ";
	
	//지휘결과"가"[53], 재지휘결과"가"[58]
	if(b0101VOMap.criStatCd == "53" || b0101VOMap.criStatCd == "58"){
		itemHtml.append('<div class="listArea" id="newTrf">																	');
		itemHtml.append('	<table class="list" cellpadding="0" cellspacing="0" data-re-trf-yn="'+(preTitle2 != "" ? "Y" : "" )+'">                                ');
		itemHtml.append('		<colgroup>                                                                      ');
		itemHtml.append('			<col width="15%" />                                                 ');
		itemHtml.append('			<col width="35%" />                                                 ');
		itemHtml.append('			<col width="15%" />                                                 ');
		itemHtml.append('			<col width="35%" />                                                 ');
		itemHtml.append('		</colgroup>                                                                     ');
		itemHtml.append('		<tbody>                                                                         ');
		itemHtml.append('			<tr>                                                                        ');
		itemHtml.append('				<th class="C">'+preTitle2+'송치기관</th>                                                 ');
		itemHtml.append('				<td class="L" colspan="3">서울남부지방검찰청</td>                                                 ');
		
//		itemHtml.append('				<th class="C">송치번호</th>                                                 ');
//		itemHtml.append('				<td class="L"><input type="text" name="trfNum" id="trfNum" class="80per" title="송치번호"></td>                                                 ');
		
		itemHtml.append('			</tr>                                                                        ');
		itemHtml.append('			<tr>                                                                        ');
		itemHtml.append('				<th class="C">'+preTitle2+'송치접수일</th>                                                 ');
		itemHtml.append('				<td class="L"><input type="text" name="trfReqDt" id="trfReqDt" data-type="date" data-optional-value="false" date-error-message="유효한 날짜를 입력해주세요." class="80per calendar datepicker" data-always="y" title="송치접수일"></td>                                           ');
		itemHtml.append('				<th class="C">'+preTitle2+'송치건의일</th>                                                 ');
		itemHtml.append('				<td class="L"><input type="text" name="trfProDt" id="trfProDt" data-type="date" data-optional-value="false" date-error-message="유효한 날짜를 입력해주세요." class="80per calendar datepicker" data-always="y" title="송치건의일"></td>                                           ');
		itemHtml.append('			</tr>                                                                       ');
		itemHtml.append('		</tbody>                                                                        ');
		itemHtml.append('	</table>                                                                            ');
		itemHtml.append('	<div class="btnArea">                                                                                                                                                                                                                                ');
		itemHtml.append('   	<div class="r_btn">                                                                                                                    ');
		itemHtml.append('   		<a href="javascript:void(0);" onclick="javascript:saveTrf(this);" class="btn_light_blue save" id="trfSaveBtn"><span>저장</span></a>                                                                                                                     ');
		itemHtml.append('		</div>  ');
		itemHtml.append('	</div>  ');
		itemHtml.append('</div>  ');
	}
	
	
	$("#ocrt_list_tab1_div").html(itemHtml.toString());
	

	
	//송치서류목록 보임	
	//$("#ocrt_list_tab1_div_step2").show();
	//initEditActionManager();	
	incTrfItemVO.criDtaCatgCd = CRI_TRF_DTA_CATG_CD; //송치자료
	
	
	//송치사건자료
	selectCriIncDta(incTrfItemVO, "2");
		
	//송치문서 업로드
	$("#fileBtn").off("click").on("click", function() {	
		updateCriIncDta();
	});

	//달력이벤트
	$(".datepicker").datepicker({
		  dateFormat: "yy-mm-dd" ,
		  changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
		  changeYear: true,
		  showButtonPanel: true,
		  currentText: '오늘 날짜'
	});
	
	//select 박스 공통스크립트!	
	setDefaultEvent();
	
	//타스크이행
	eventTaskBtn();
	
	//화면사이즈 갱신
	autoResize();
	
}
//송치 저장 
function saveTrf(obj){
	//맵초기화
	initIncTrfItemVOMap();
	
	var targetObj = $(obj).closest(".btnArea").parent("div");
	var testobj = $("#newTrf");

	if(isAllCheckGrap()){
		if(!chkValidate.check(testobj, true)) return;
		
		if(!confirm("송치 요청하시겠습니까?")){
			return;
		}
		
		incTrfItemVO.respDppoCd = "01";//남부지검
		incTrfItemVO.rcptNum = b0101VOMap.rcptNum;		//접수번호
		incTrfItemVO.trfReqDt= targetObj.find("input[name=trfReqDt]").val(); 			//송치접수일
		incTrfItemVO.trfProDt= targetObj.find("input[name=trfProDt]").val(); 			//송치건의일
		incTrfItemVO.reTrfYn = targetObj.data("re-trf-yn");								//재송치여부
//		incTrfItemVO.trfNum= targetObj.find("input[name=trfNum]").val(); 			//송치번호
		
		//타스크 세팅
		var task = new Object();
		task.wfNum = b0101VOMap.wfNum;
		task.rcptNum = b0101VOMap.rcptNum;
		task.taskNum = b0101VOMap.taskNum;	
		task.trstStatNm = b0101VOMap.taskTrstVOList[0].trstStatNm;//송치건의!
		task.trstStatNum = b0101VOMap.taskTrstVOList[0].trstStatNum;
		task.taskRespMb = $("#userId").val();
		task.criStatCd = b0101VOMap.taskTrstVOList[0].criStatCd;
		task.regUserId = $("#userId").val(); 
		task.updUserId = $("#userId").val();
		incTrfItemVO.b0101TK = task;
			
		goAjax("/sjpb/B/saveTrfItem.face",incTrfItemVO,function(data){callBackFn_saveTrfItemSuccess(data)});
	}else{
		alert("통계원표를 전부 입력해야 송치요청이 가능합니다.");
		return;
	}
}

//송치 저장 콜백 함수
function callBackFn_saveTrfItemSuccess(data){
	
	if(data == 1){
		alert("송치요청이 완료되었습니다.");
		
	}else{
		alert("시스템 에러입니다. 시스템 문의자에게 문의하세요.");
	}
	
	pageInit();	
}
//송치 업데이트(task)
function updateTrfTask(obj){
	//맵초기화
	initIncTrfItemVOMap();
	
	var targetObj = $(obj).closest(".listArea");
	
	if(!chkValidate.check(targetObj, true)) return;
	
	
	var aaaa= targetObj.find("select[name=trfRst]").val();
	
	if(aaaa == "" || aaaa == null){
		alert("[송치결과]를 입력하세요.");
		return;
	}
	
	var trfRstText = (aaaa == "Y"?"가":"부");
	
	if(!confirm("송치 결과 "+trfRstText+"로 입력하시겠습니까?")){
		return;
	}
	
	incTrfItemVO.rcptNum = b0101VOMap.rcptNum;		//접수번호
	incTrfItemVO.incTrfItemNum = targetObj.data("inc-trf-item-num");				//송치아이템
	incTrfItemVO.trfReqDt= targetObj.find("input[name=trfReqDt]").val(); 			//송치접수일
	incTrfItemVO.trfProDt= targetObj.find("input[name=trfProDt]").val(); 			//송치건의일
	incTrfItemVO.trfRcptDt= targetObj.find("input[name=trfRcptDt]").val(); 			//송치결과수령일
	incTrfItemVO.trfRst= targetObj.find("select[name=trfRst]").val(); 			//송치결과
	incTrfItemVO.trfComn= targetObj.find("input[name=trfComn]").val(); 			//송치의견
//	incTrfItemVO.trfNum= targetObj.find("input[name=trfNum]").val(); 			//송치번호
	
	var task = new Object();
	task.wfNum = b0101VOMap.wfNum;
	task.rcptNum = b0101VOMap.rcptNum;
	task.taskNum = b0101VOMap.taskNum;	
	task.trstStatCd = targetObj.find("select[name=trfRst]").val();
	task.taskRespMb = $("#userId").val();
	task.regUserId = $("#userId").val(); 
	task.updUserId = $("#userId").val();
	incTrfItemVO.b0101TK = task;
	
	goAjax("/sjpb/B/updateTrfItemTask.face",incTrfItemVO,function(data){callBackFn_updateTrfItemSuccess(data)});
	
}
//송치 업데이트(정보성 업데이트!!)
function updateTrfItem(obj){
	//맵초기화
	initIncTrfItemVOMap();
	
	var targetObj = $(obj).closest(".listArea");
	
	if(!chkValidate.check(targetObj, true)) return;
	
	incTrfItemVO.rcptNum = b0101VOMap.rcptNum;		//접수번호
	incTrfItemVO.incTrfItemNum = targetObj.data("inc-trf-item-num");				//송치아이템
	incTrfItemVO.trfReqDt= targetObj.find("input[name=trfReqDt]").val(); 			//송치접수일
	incTrfItemVO.trfProDt= targetObj.find("input[name=trfProDt]").val(); 			//송치건의일
	incTrfItemVO.trfRcptDt= targetObj.find("input[name=trfRcptDt]").val(); 			//송치결과수령일
	incTrfItemVO.trfComn= targetObj.find("input[name=trfComn]").val(); 			//송치의견
//	incTrfItemVO.trfNum= targetObj.find("input[name=trfNum]").val(); 			//송치번호
	
	goAjax("/sjpb/B/updateTrfItem.face",incTrfItemVO,function(data){callBackFn_updateTrfItemSuccess2(data)});
	
}

//송치 업데이트 콜백 함수
function callBackFn_updateTrfItemSuccess(data){
	
	if(data == 1){
		alert("정상적으로 처리되였습니다.");
		
	}else{
		alert("시스템 에러입니다. 시스템 문의자에게 문의하세요.");
	}
	
	pageInit();

}
//송치 업데이트 콜백 함수
function callBackFn_updateTrfItemSuccess2(data){
	
	if(data == 1){
		alert("수정되였습니다.");
		
	}else{
		alert("시스템 에러입니다. 시스템 문의자에게 문의하세요.");
	}
	
	pageInit();

}

//송치사건자료를 가져온다. 
function selectCriIncDta(itemVO, type){
	//itemVO.criDtaCatgCd = CRI_DTA_CATG_CD; //송치자료
	goAjax("/sjpb/B/selectCriIncDta.face", itemVO, function(data){ callBackSelectCriIncDtaSuccess(data,type); });
}

//수사사건자료상세 콜백함수
function callBackSelectCriIncDtaSuccess(data, type) {
	
	//console.log(JSON.stringify(data));
	
	//incTrfItemVO = data.incCriItemVO;
	
	//수사자료 리스팅	
	renderDTTable(data.incCriItemVO.criIncDtaFileVOList, type);
	
	//화면사이즈 갱신
	autoResize();	
}

//송치정보 > 수사지휘진행 (수사사건지휘건 상세를 가져온다.) 
function selectIncCriCmdItemDetails(){
	incCriCmdItemVO.rcptNum = b0101VOMap.rcptNum;
	//incCriCmdItemVO.pareRcptNum = b0101VOMap.pareRcptNum;
	goAjax("/sjpb/B/selectIncCriCmdItemDetails.face", incCriCmdItemVO, callBackSelectIncCriCmdItemDetailsSuccess);
}


//수사사건지휘건 상세 성공 콜백함수
function callBackSelectIncCriCmdItemDetailsSuccess(data){
	
	//수사지휘서류목록 숨김
	//$("#ocrtc_list_tab0_div_step2").hide();
	
	var itemHtml = new StringBuffer();  
	
	var criCmdRstLast = "";  //마지막 지휘결과
	
	var lastElement = 0;
    if (data.incCriCmdItemVO.length > 0) {
    	lastElement = data.incCriCmdItemVO.length - 1;
    }
    
    var incCriCmdItemLength = data.incCriCmdItemVO.length;
    
    $.each(data.incCriCmdItemVO, function(i, item) {
    	
    	
    	
    	var preTitle = "";
		if (item.reCmdYn == "Y") preTitle = "재 ";
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
		itemHtml.append('				<th class="C">지휘구분</th>                                         ');
		itemHtml.append('				<td class="L">                                     ');
		
		
		itemHtml.append('	   				<span name="criCmdNm" id="criCmdNm" data-code="'+item.incCriCmdItemStatCd+'">'+item.incCriCmdItemDesc+'</span>                                                       ');	
		/*
		itemHtml.append('	   				<div class="inputbox w40per">                                                       ');	
		
		
		itemHtml.append('	   					<p class="txt"></p>                                                   ');	
		itemHtml.append('				   		<select name="criCmdNm" id="criCmdNm" disabled data-type="select" data-optional-value="false" title="구분">                                                                                                                                                                                                                             ');
		itemHtml.append('							<option value="'+item.incCriCmdItemStatCd+'" selected=\"selected\">'+item.incCriCmdItemDesc+'</option>');
		itemHtml.append('	   					</select>                                                                       ');	
		itemHtml.append('	   				</div>                                                                              ');	
		*/
		itemHtml.append('				</td>                                                               ');
		if(preTitle ==""){
			itemHtml.append('				<th class="C">'+preTitle+'지휘기관</th>                                                 ');
			itemHtml.append('				<td class="L">'+item.respDppoDesc+'</td>                                                 ');
		}else{
			itemHtml.append('				<th class="C">'+preTitle+'지휘인계일</th>                                                 ');
			itemHtml.append('				<td class="L">'+item.criCmdTranDt+'</td>                                                 ');
		}
		itemHtml.append('			</tr>                                                               ');
		itemHtml.append('			<tr>                                                               ');
		itemHtml.append('				<th class="C">'+preTitle+'지휘접수일</th>                                        ');
		itemHtml.append('				<td class="L"><input type="text" class="w80per calendar datepicker" name="criCmdReqDt" id="criCmdReqDt_'+i+'" value="'+item.criCmdReqDt+'" title="지휘접수일" readonly /></td>                                   ');
		itemHtml.append('				<th class="C">'+preTitle+'지휘건의일</th>                                        ');
		itemHtml.append('				<td class="L"><input type="text" class="w80per calendar datepicker" name="criCmdProDt" id="criCmdProDt_'+i+'" value="'+item.criCmdProDt+'" title="지휘건의일" readonly /></td>                                   ');
		itemHtml.append('			</tr>                                                               ');
		itemHtml.append('			<tr>                                                                ');    
		itemHtml.append('				<th class="C">'+preTitle+'지휘의견</th>                                                 ');
		itemHtml.append('				<td class="L" colspan="3"><input type="text" name="criCmdReqComn" id="criCmdReqComn_'+i+'" class="w100per" value="'+(isNull(item.criCmdReqComn)? "" :item.criCmdReqComn)+'" data-always="y" title="지휘의견" maxlength="300"></td>                                     ');
		itemHtml.append('			</tr>                                                                ');    
		itemHtml.append('			<tr>                                                                ');    
		itemHtml.append('				<th class="C">'+preTitle+'지휘수령일</th>                                   ');
		itemHtml.append('				<td class="L"><input type="text" class="w80per calendar datepicker" name="criCmdRcptDt" id="criCmdRcptDt_'+i+'" value="'+item.criCmdRcptDt+'" title="지휘수령일" readonly /></td>                                        ');
		itemHtml.append('				<th class="C">지휘결과</th>                                      ');
		itemHtml.append('				<td class="L">                                         ');
		itemHtml.append('	   				<div class="inputbox w80per">                                                       ');	
		itemHtml.append('	   					<p class="txt"></p>                                                   ');	
		itemHtml.append('				   		<select name="criCmdRst" id="criCmdRst_'+i+'" data-type="select"  data-always="y" title="지휘결과" '+(item.criCmdRst != "" ? "disabled" : "" )+'>                                                                                                                                                                                                                             ');
		itemHtml.append('							<option value="">선택</option>');
		itemHtml.append('							<option value="Y" '+(item.criCmdRst == 'Y' ? "selected=\"selected\"" : "")+'>가</option>');
		if(item.incCriCmdItemStatCd == "04"){
			itemHtml.append('									<option value="N" '+(item.criCmdRst == 'N' ? "selected=\"selected\"" : "")+'>부</option>');
		}
		itemHtml.append('	   					</select>                                                                       ');	
		itemHtml.append('	   				</div>                                                                              ');	
		itemHtml.append('				</td>                                        ');
		itemHtml.append('			</tr>                                                               ');

		itemHtml.append('			<tr>                                        ');
		itemHtml.append('				<th class="C">검사 지휘의견</th>                                      ');
		itemHtml.append('				<td class="L" colspan="3">                                          ');
		itemHtml.append('					<label for="criCmdComn"></label><input type="text" class="w100per" name="criCmdComn" id="criCmdComn_'+i+'" value="'+item.criCmdComn+'"  maxlength="300"/>                                                                    ');
		itemHtml.append('				</td>                                       ');
		itemHtml.append('			</tr>                                       ');
		
		if( lastElement == i){	
			//입건건의 경우, 마지막상태 저장
        	criCmdRstLast = item.criCmdRst;   	
		}
			
		
		
		
		itemHtml.append('		</tbody>                                                                ');
		itemHtml.append('	</table>                                                                    ');
		
		
		
		var str ="";
		if(item.criCmdRst == ""){
			str = "updateCriCmdTask(this);";
		}else{
			str = "updateCriCmd(this);";
		}
		
		
		
		
		/*
		if( (item.incCriCmdItemStatCd == "01" && criCmdRstLast == "") || (item.incCriCmdItemStatCd == "04" && "52,57".indexOf(b0101VOMap.criStatCd) != -1 && criCmdRstLast == "") ){//
			c
		
		}else{
			str = "updateCriCmd(this);";
		}
		*/
		
		itemHtml.append('	<div class="btnArea">                                                                                                                                                                                                                                ');
		itemHtml.append('   	<div class="r_btn"><a href="javascript:void(0);" onclick="javascript:'+str+'" class="btn_light_blue save"><span>저장</span></a></div>                                                                                                                     ');
		itemHtml.append('	</div>                                                                                                                                                                                                                                               ');
		itemHtml.append('</div>                                                                       ');
		
		
    });
    /*
    //수사사건부등록[22]
    if("22".indexOf(b0101VOMap.criStatCd) != -1 && ( incCriCmdItemLength == 0 || criCmdRstLast == "N" )){
    	
    	itemHtml.append('<div class="listArea" id="newCmd" data-name="newCmd" data-re-cmd-yn="">																	');
    	itemHtml.append('	<table class="list" cellpadding="0" cellspacing="0">                                ');
    	itemHtml.append('		<colgroup>                                                                      ');
    	itemHtml.append('			<col width="15%" />                                                 ');
    	itemHtml.append('			<col width="35%" />                                                 ');
    	itemHtml.append('			<col width="15%" />                                                 ');
    	itemHtml.append('			<col width="35%" />                                                 ');
    	itemHtml.append('		</colgroup>                                                                     ');
    	itemHtml.append('		<tbody>                                                                         ');
    	itemHtml.append('			<tr>                                                                        ');
    	itemHtml.append('				<th class="C">구분</th>                                                 ');
    	itemHtml.append('					<td class="L">                                     ');
    	itemHtml.append('						<span name="criCmdNm" id="criCmdNm" value="01">입건건의</span>                                     ');
    	
    	
    	
    	itemHtml.append('	   					<div class="inputbox w80per">                                                       ');	
    	itemHtml.append('	   					<p class="txt"></p>                                                   ');	
    	itemHtml.append('				   		<select name="criCmdNm" id="criCmdNm" disabled data-type="select" data-optional-value="false" title="구분" onchange="changeCriCmdNm(this.value);">                                                                                                                                                                                                                             ');
    	itemHtml.append('							<option value="">선택</option>');
    	$.each(data.criCmdList, function(k, criCmd) {
    		if(criCmd.code == "01"){
    			itemHtml.append('					<option value="'+criCmd.code+'" selected="selected">'+criCmd.codeName+'</option>');	
    		}	
    	});
    	itemHtml.append('	   					</select>                                                                       ');	
    	itemHtml.append('	   				</div>                                                                              ');	
    	
    	
    	
    	itemHtml.append('				</td>                                     ');
    	
    	
    	itemHtml.append('				<th class="C">지휘기관</th>                                                 ');
    	itemHtml.append('				<td class="L">남부지검</td>                                     ');
    	itemHtml.append('			</tr>                                                                       ');
    	itemHtml.append('			<tr>                                                                        ');
    	itemHtml.append('				<th class="C">지휘접수일</th>                                                 ');
    	itemHtml.append('				<td class="L"><input type="text" name="criCmdReqDt" id="criCmdReqDt" data-type="date" data-optional-value="false" date-error-message="유효한 날짜를 입력해주세요." class="80per calendar datepicker" data-always="y" title="지휘접수일"></td>                                     ');
    	itemHtml.append('				<th class="C">지휘건의일</th>                                                 ');
    	itemHtml.append('				<td class="L"><input type="text" name="criCmdProDt" id="criCmdProDt" data-type="date" data-optional-value="false" date-error-message="유효한 날짜를 입력해주세요." class="80per calendar datepicker" data-always="y" title="지휘건의일"></td>                                     ');
    	itemHtml.append('			</tr>                                                                       ');
    	
    	
    	itemHtml.append('			<tr id="spCmdTR" style="display:none;">                                                                       ');
    	itemHtml.append('				<th class="C">피의자</th>										');                                                                                                                                                                                                                       
    	itemHtml.append('				<td class="L" colspan="3">                                                                       ');
    	itemHtml.append('					<div class="list_box"> 													');
    	itemHtml.append('						<ul id="spCmdArea"> 													');
    	itemHtml.append('						</ul> 													');
    	itemHtml.append('						<a name="spBtn" id="spBtn" href="javascript:searchSpCmdBtn();" class="btn_gray"><span>검색</span></a>	');
    	itemHtml.append('					</div>																	');
    	itemHtml.append('				</td>                                                                       ');
    	itemHtml.append('			</tr>                                                                       ');
    	
    	itemHtml.append('		</tbody>                                                                        ');
    	itemHtml.append('	</table>                                                                            ');
    	itemHtml.append('	<div class="btnArea">                                                                                                                                                                                                                                ');
    	itemHtml.append('   	<div class="r_btn">                                                                                                                    ');
    	itemHtml.append('   		<a href="javascript:void(0);" onclick="javascript:saveCriCmdTask(this);" class="btn_white" id="cmdSaveBtn"><span>저장</span></a>                                                                                                                     ');
    	itemHtml.append('   	</div>                                                                                                                     ');
    	itemHtml.append('	</div>                                                                                                                                                                                                                                               ');
    	
    	itemHtml.append('</div>                                                                                  ');
    	
    }
    */
    
    //수사줄[40], 지휘결과 '부'[54], 재지휘결과 '부'[59], 송치결과'부'[74], 재송치결과'부'[79]
    if("22,40,54,59,74,79".indexOf(b0101VOMap.criStatCd) != -1){
    	
    	var preTitle3 = "";
    	
    	if(b0101VOMap.taskNum == "8" || b0101VOMap.taskNum == "60"){
    		preTitle3 = "재 ";
    	}
    	
	    itemHtml.append('<div class="listArea" id="newCmd" data-name="newCmd" data-re-cmd-yn="'+(preTitle3=="" ? "":"Y" )+'">																	');
		itemHtml.append('	<table class="list" cellpadding="0" cellspacing="0">                                ');
		itemHtml.append('		<colgroup>                                                                      ');
		itemHtml.append('			<col width="15%" />                                                 ');
		itemHtml.append('			<col width="35%" />                                                 ');
		itemHtml.append('			<col width="15%" />                                                 ');
		itemHtml.append('			<col width="35%" />                                                 ');
		itemHtml.append('		</colgroup>                                                                     ');
		itemHtml.append('		<tbody>                                                                         ');
		itemHtml.append('			<tr>                                                                        ');
		itemHtml.append('				<th class="C">구분</th>                                                 ');
		itemHtml.append('					<td class="L">                                     ');
		if(b0101VOMap.criStatCd == "22"){
			itemHtml.append('				   		<span name="criCmdNm" id="criCmdNm" data-code="01">수사지휘(최초)</span>                                                                                                                                                                                                                             ');
		}else{
			itemHtml.append('				   		<span name="criCmdNm" id="criCmdNm" data-code="04">수사지휘</span>                                                                                                                                                                                                                             ');
		}
		itemHtml.append('					</td>                                     ');
			
		
		itemHtml.append('				<th class="C">지휘기관</th>                                                 ');
		itemHtml.append('				<td class="L">서울남부지방검찰청</td>                                     ');
		itemHtml.append('			</tr>                                                                       ');
		itemHtml.append('			<tr>                                                                        ');
		itemHtml.append('				<th class="C">'+preTitle3+'지휘접수일</th>                                                 ');
		itemHtml.append('				<td class="L"><input type="text" name="criCmdReqDt" id="criCmdReqDt" data-type="date" data-optional-value="false" date-error-message="유효한 날짜를 입력해주세요." class="w80per calendar datepicker" data-always="y" title="지휘접수일"></td>                                     ');
		itemHtml.append('				<th class="C">'+preTitle3+'지휘건의일</th>                                                 ');
		itemHtml.append('				<td class="L"><input type="text" name="criCmdProDt" id="criCmdProDt" data-type="date" data-optional-value="false" date-error-message="유효한 날짜를 입력해주세요." class="w80per calendar datepicker" data-always="y" title="지휘건의일"></td>                                     ');
		itemHtml.append('			</tr>                                                                       ');
		itemHtml.append('			<tr>                                                                       ');
		itemHtml.append('				<th class="C">지휘의견</th>                                                 ');
		itemHtml.append('				<td class="L" colspan="3"><input type="text" name="criCmdReqComn" id="criCmdReqComn" data-optional-value="false" class="w100per" data-always="y" title="지휘의견"   maxlength="300"></td>                                     ');
		itemHtml.append('			</tr>                                                                       ');
		
		itemHtml.append('		</tbody>                                                                        ');
		itemHtml.append('	</table>                                                                            ');
		itemHtml.append('	<div class="btnArea">                                                                                                                                                                                                                                ');
		itemHtml.append('   	<div class="r_btn">                                                                                                                    ');
		itemHtml.append('   		<a href="javascript:void(0);" onclick="javascript:saveCriCmd(this);" class="btn_light_blue save" id="cmdSaveBtn"><span>저장</span></a>                                                                                                                     ');
		itemHtml.append('   	</div>                                                                                                                     ');
		itemHtml.append('	</div>                                                                                                                                                                                                                                               ');
		
		itemHtml.append('</div>                                                                                  ');
    
    }
    
    
	itemHtml.append('</div>                                                                                  ');
    
    
    
	
    
	$("#spCmdBtn").off("click").on("click", function() {	
		commonLayerPopup.openLayerPopup('/sjpb/Z/spListLayerPopupList.face?rcptNum='+b0101VOMap.rcptNum, "1050px", "435px", callBackFn_searchSpCmdBtnSuccess);
	});
	
    $("#ocrt_list_tab0_div").html(itemHtml.toString());
    
  //이벤트바인딩 (selectbox)
	setTargetDefaultEvent( $("#ocrt_list_tab0_div") );
    
	
	//selct 퍼블 이벤트 바인딩
	setDefaultEvent();
	
    //파일첨부 S 2018.11.20 추가
    //데이터가 있을경우에만, 가 혹은, 부 에서 노출 
//	if(criCmdRstLast == "Y" || criCmdRstLast == "N"){
		
		//수사지휘서류목록 보임
		//$("#ocrt_list_tab0_div_step2").show();
		
		//initEditActionManager();
		
		incCriCmdItemVO.criDtaCatgCd = CRI_CMD_DTA_CATG_CD; //수사지휘자료
		//수사지휘사건자료
		selectCriIncDta(incCriCmdItemVO, "3");
		
//	}
	//파일첨부 E 2018.11.20 추가
		$("#criCmdNm").attr("onchange","changeCriCmdNm()");
	//달력이벤트
	$(".datepicker").datepicker({
		  dateFormat: "yy-mm-dd" ,
		  changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
		  changeYear: true,
		  showButtonPanel: true,
		  currentText: '오늘 날짜'
	});
	
	//지휘문서 업로드
	$("#fileBtn").off("click").on("click", function() {	
		updateCriIncDta();
	});
	
    //타스크이행
	eventTaskBtn();
	
	//화면사이즈 갱신
	autoResize();
	
	
	
	
	
	
	
}

//수사 지휘 업데이트(정보성)
function updateCriCmd(obj){
	//수사지휘 구분에 따라 유효성 검사
	//01 : 수사지휘건의 처음꺼(모든 피의자)
	//02 : 출국금지 (피의자 선택)
	//03 : 그냥 수사지뤼 건의 (피의자 선택)
	//04 : 마지막 수사지휘건의(모든 피의자)
	//var targetObj = $(obj).closest(".btnArea").parent("div");
	//var cloneObjName = targetObj.data("re-cmd-yn");
	//var cloneObjName = targetObj.data("name");
	
	//맵초기화
	initIncCriCmdItemVOMap();
	
	var testobj = $(obj).closest(".listArea");
	
	if(!chkValidate.check(testobj, true)) return;
	incCriCmdItemVO.rcptNum = b0101VOMap.rcptNum;		//접수번호
	incCriCmdItemVO.incCriCmdItemNum = testobj.data("inc-cri-cmd-item-num");				//수사지휘아이템
	incCriCmdItemVO.criCmdReqDt= testobj.find("input[name=criCmdReqDt]").val(); 			//수사지휘 접수일
	incCriCmdItemVO.criCmdProDt= testobj.find("input[name=criCmdProDt]").val(); 			//수사지휘 건의일
	incCriCmdItemVO.criCmdTranDt= testobj.find("input[name=criCmdTranDt]").val(); 			//수사지휘 인계일
	incCriCmdItemVO.criCmdRcptDt= testobj.find("input[name=criCmdRcptDt]").val(); 			//수사지휘 수령일
	incCriCmdItemVO.criCmdComn= testobj.find("input[name=criCmdComn]").val(); 			//지휘의견
	incCriCmdItemVO.criCmdReqComn= testobj.find("input[name=criCmdReqComn]").val(); 			//수사관 지휘의견
		
	
	goAjax("/sjpb/B/updateCriCmd.face",incCriCmdItemVO,function(data){callBackFn_updateCriCmdSuccess(data)});

}
//수사 지휘  타스크 업데이트
function updateCriCmdTask(obj){
	//수사지휘 구분에 따라 유효성 검사
	//01 : 수사지휘건의 처음꺼(모든 피의자)
	//02 : 출국금지 (피의자 선택)
	//03 : 그냥 수사지뤼 건의 (피의자 선택)
	//04 : 마지막 수사지휘건의(모든 피의자)
	//var targetObj = $(obj).closest(".btnArea").parent("div");
	//var cloneObjName = targetObj.data("re-cmd-yn");
	//var cloneObjName = targetObj.data("name");

	//맵초기화
	initIncCriCmdItemVOMap();
	
	var testobj = $(obj).closest(".listArea");
	
	
	
	if(!chkValidate.check(testobj, true)) return;
	if(testobj.find("select[name=criCmdRst]").val() =="" || testobj.find("select[name=criCmdRst]").val() == null){
		alert("[지휘결과]를 입력하세요.");
		return;
	}
	
	var criCmdRstText = (testobj.find("select[name=criCmdRst]").val() == "Y"?"가":"부");
	if(!confirm("수사지휘 결과 "+criCmdRstText+"로 입력하시겠습니까?")){
		return;
	}
	
	incCriCmdItemVO.rcptNum = b0101VOMap.rcptNum;		//접수번호
	incCriCmdItemVO.incCriCmdItemStatCd = testobj.find("select[name=criCmdNm]").val();		//수사지휘 구분
	incCriCmdItemVO.incCriCmdItemNum = testobj.data("inc-cri-cmd-item-num");				//수사지휘아이템
	incCriCmdItemVO.criCmdReqDt= testobj.find("input[name=criCmdReqDt]").val(); 			//수사지휘 접수일
	incCriCmdItemVO.criCmdProDt= testobj.find("input[name=criCmdProDt]").val(); 			//수사지휘 건의일
	incCriCmdItemVO.criCmdTranDt= testobj.find("input[name=criCmdTranDt]").val(); 			//수사지휘 인계일
	incCriCmdItemVO.criCmdRcptDt= testobj.find("input[name=criCmdRcptDt]").val(); 			//수사지휘 수령일
	incCriCmdItemVO.criCmdReqComn= testobj.find("input[name=criCmdReqComn]").val(); 			//수사관 수사지휘의견
	incCriCmdItemVO.reCmdYn= testobj.data("re-cmd-yn"); 			//재지휘여부
	incCriCmdItemVO.criCmdRst= testobj.find("select[name=criCmdRst]").val(); 			//지휘결과
	incCriCmdItemVO.criCmdComn= testobj.find("input[name=criCmdComn]").val(); 			//지휘의견
	
	
	var task = new Object();
	task.wfNum = b0101VOMap.wfNum;
	task.rcptNum = b0101VOMap.rcptNum;
	task.taskNum = b0101VOMap.taskNum;
	task.trstStatCd = testobj.find("select[name=criCmdRst]").val();
	task.regUserId = $("#userId").val(); 
	task.updUserId = $("#userId").val();
	incCriCmdItemVO.b0101TK = task;

	 
	goAjax("/sjpb/B/updateCriCmdTask.face",incCriCmdItemVO,function(data){callBackFn_updateCriCmdSuccess2(data)});

}
//수사 지휘 업데이트 성공 콜백함수
function callBackFn_updateCriCmdSuccess(data){
	if(data == 1){
		alert("수사지휘가 수정되었습니다.");
	}else{
		alert("시스템 에러입니다. 시스템 문의자에게 문의하세요.");
	}
	
	selectIncCriCmdItemDetails();	//수사지휘 detail설명
}
//수사 지휘 업데이트 성공 콜백함수
function callBackFn_updateCriCmdSuccess2(data){
	if(data == 1){
		
		alert("수사지휘가 완료되었습니다.");
	}else{
		alert("시스템 에러입니다. 시스템 문의자에게 문의하세요.");
	}
	
	pageInit();	
}
//수사 지휘 저장 
function saveCriCmd(obj){
	//수사지휘 구분에 따라 유효성 검사
	//01 : 수사지휘건의 처음꺼(모든 피의자)
	//02 : 출국금지 (피의자 선택)
	//03 : 그냥 수사지뤼 건의 (피의자 선택)
	//04 : 마지막 수사지휘건의(모든 피의자)

	//맵초기화
	initIncCriCmdItemVOMap();
	
	var targetObj = $(obj).closest(".btnArea").parent("div");
	//var cloneObjName = targetObj.data("re-cmd-yn");
	var cloneObjName = targetObj.data("name");
	var testobj = $("#newCmd");

	
	if(!chkValidate.check(testobj, true)) return;
	
	if(!confirm("수사지휘 요청하시겠습니까?")){
		return;
	}
	
	incCriCmdItemVO.respDppoCd = "01";//서울남부지방검찰청
	incCriCmdItemVO.rcptNum = b0101VOMap.rcptNum;		//접수번호
	incCriCmdItemVO.criCmdReqDt= targetObj.find("input[name=criCmdReqDt]").val(); 			//수사지휘접수일
	incCriCmdItemVO.criCmdProDt= targetObj.find("input[name=criCmdProDt]").val(); 			//수사지휘건의일
	incCriCmdItemVO.criCmdReqComn= targetObj.find("input[name=criCmdReqComn]").val(); 			//수사관 지휘의견
	
	incCriCmdItemVO.incCriCmdItemStatCd = targetObj.find("span[name=criCmdNm]").data("code");		//수사지휘 구분
	incCriCmdItemVO.reCmdYn = targetObj.data("re-cmd-yn");		//재수사지휘 여부
	
	var task = new Object();
	task.wfNum = b0101VOMap.wfNum;
	task.rcptNum = b0101VOMap.rcptNum;
	task.taskNum = b0101VOMap.taskNum;	
	task.trstStatNm = b0101VOMap.taskTrstVOList[0].trstStatNm;
	task.trstStatNum = b0101VOMap.taskTrstVOList[0].trstStatNum;
	task.taskRespMb = $("#userId").val();
	task.taskComn = $("#taskComn").val();
	task.criStatCd = b0101VOMap.taskTrstVOList[0].criStatCd;
	task.regUserId = $("#userId").val(); 
	task.updUserId = $("#userId").val();
	incCriCmdItemVO.b0101TK = task;
		
	
	goAjax("/sjpb/B/saveCriCmd.face",incCriCmdItemVO,function(data){callBackFn_saveCriCmdSuccess2(data)});
	
}

//수사 지휘 저장 콜백 함수
function callBackFn_saveCriCmdSuccess(data){
	
	if(data == 1){
		alert("정상적으로 처리되었습니다.");
	}else{
		alert("시스템 에러입니다. 시스템 문의자에게 문의하세요.");
	}
	
	selectIncCriCmdItemDetails();	//수사지휘 detail설명
}
//수사 지휘 저장 콜백 함수
function callBackFn_saveCriCmdSuccess2(data){
	
	if(data == 1){
		alert("정상적으로 처리되었습니다.");
		
	}else{
		alert("시스템 에러입니다. 시스템 문의자에게 문의하세요.");
	}
	
	pageInit();	//수사지휘 detail설명
}
//수사지휘 구분 변경시 피의자 표출 변경 함수!
function changeCriCmdNm(criCmdNm){
	
	if(criCmdNm == "02" || criCmdNm == "03"){
		//피의자 표출
		$("#spCmdTR").show();
	
	}else{
		$("#spCmdTR").hide();
	}
	
}

//피의자 검색 버튼 클릭시 팝업창 표출
function searchSpCmdBtn(){
	commonLayerPopup.openLayerPopup('/sjpb/Z/spListLayerPopupList.face?rcptNum='+b0101VOMap.rcptNum, "1050px", "435px", callBackFn_searchSpCmdBtnSuccess);
}

//피의자 추가 콜백함수
function callBackFn_searchSpCmdBtnSuccess(data){
	
	var spCmdHtml = new StringBuffer();  
	var isDuplication = false;
	var spCmdData = [];
	
	//1. 중복체크를 위해 기존 수사관들을 배열에 넣음 (담당, 수사관, 참조수사관 모두) _ 테이블상, 중복으로 들어가면 안됨
	$("li[data-name=spCmd]").each(function(i){
		spCmdData.push($(this).attr("data-incSpNum"));
	});
	
	$.each(data, function(i, spCmd) {	
		//2. 중복체크
		if($.inArray(spCmd.incSpNum, spCmdData) == -1){
			//중복체크 완료
			spCmdHtml.append('					   <li data-name="spCmd" data-incSpNum="'+spCmd.incSpNum+'"><span>'+spCmd.spNm+'</span><a href="javascript:void(0);" onclick="removeSpCmdli(this);" class="list_box_close" data-name="removeSpCmdBtn" data-always="y"><img src="/sjpb/images/btn_box_close.png" alt="닫기 버튼" /></a></li>                                                                       ');
		}else{
			isDuplication = true;
		}
	});
	
	if(isDuplication){
		alert("중복으로 지정하려는 피의자가 있습니다.");
	}
	
	$("#spCmdArea").append(spCmdHtml.toString());
	
}
//피의자 삭제
function removeSpCmdli(obj){
	$(obj).closest("li").remove();
}

//사건을 분리한다. (checkBox)
function unCombIncMastChkBox(){
	
	var qcell = QCELL.getInstance("qcell");
	
	//선택된 ROW의 rcptNum가져오기 
	var b0101VOArray = new Array();
	
	for(var i = 0; i < qcell.getColData(0).length; i++){
		if(qcell.getColData(0)[i] == true){
			
			//본인 사건만 분리가능 
			if($("#userId").val() != qcell.getRowData(i+1).criMbMainUserId){
				alert("사건분리는 담당수사관만 요청 가능합니다.");
				return;
			}
			
			//병합된 마스터 사건만 분리 가능
			if( !(qcell.getRowData(i+1).combIncYn == 'Y' && qcell.getRowData(i+1).pareIncNum == qcell.getRowData(i+1).incNum) ){
				alert("병합된 마스터 사건만 1건 선택 후 분리 가능합니다.");
				return;
			}
			
			//수사 단계에서만 분리 가능, [수사착수(40), 지휘부결(54), 재지휘부결(59)]
			if( !(qcell.getRowData(i+1).criStatCd == "40"|| qcell.getRowData(i+1).criStatCd == "53"|| qcell.getRowData(i+1).criStatCd == "58" || qcell.getRowData(i+1).criStatCd == "54" || qcell.getRowData(i+1).criStatCd == "59") ){
				alert("사건분리는 수사중, 지휘결과 '부', 재지휘결과 '부' 대상으로만 가능합니다.");
				return;
			}
			
			var b0101VO = new Object();
			b0101VO = qcell.getRowData(i+1);
			
			b0101VOArray.push(b0101VO);
		}
	}
	
	
	//하나의사건만 분리가능
	if(b0101VOArray.length != 1){
		alert("사건을 1개만 선택해주세요.");
		return;
	}
	
	//사건분리
	unCombIncMast(b0101VOArray[0]);
	
}

//사건을 분리한다. (ajax)
function unCombIncMast(b0101VOTmp){
	//분리한다.
	if(confirm("사건을 분리 하시겠습니까?") == true){
		goAjax("/sjpb/B/unCombIncMast.face", b0101VOTmp, callBackUnCombIncMastSuccess);
	}else{
		return;
	}
}


//사건을 분리한다. 성공 콜백함수
function callBackUnCombIncMastSuccess(data){
	alert("사건을 분리 했습니다.");
	selectList(data.b0101VO.rcptNum);
}

//처분진행 수정 화면 노출(그리기)
function updateIncDipRstView(data){
	var rstHtml = new StringBuffer();  
	
	//피의자
	var spNum = 0;
	$.each(b0101VOMap.incSpVOList, function(i, incSpVO) {
		
		var spIdNumDec =  incSpVO.spIdNum;
		var spNmDec = incSpVO.spNm;
		
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
		
		rstHtml.append('			<tr>                                                                                                    ');
		rstHtml.append('				<th class="C">형제번호</th>                                                                             ');
		rstHtml.append('				<td class="L" colspan="3">                                                                                      ');
		rstHtml.append('					<label for="rst_crlwNum_'+i+'"></label><input type="text" class="w100per" id="rst_crlwNum_'+i+'" name="rst_crlwNum" value="'+getParamValue(incSpVO.crlwNum)+'" maxlength="30"/>           ');
		rstHtml.append('				</td>                                                                                               ');
		rstHtml.append('			</tr>                                                                                                   ');

		rstHtml.append('			<tr>                                                                                                    ');
		rstHtml.append('				<th class="C">검찰처분일시</th>                                                                           ');
		rstHtml.append('				<td class="L" colspan="3">                                                                                      ');
		rstHtml.append('					<label for="rst_poDipDt_'+i+'"></label><input type="text" class="w20per calendar datepicker" title="검찰처분일시" id="rst_poDipDt_'+i+'" name="rst_poDipDt" value="'+getParamValue(incSpVO.poDipDt)+'" />   ');
		rstHtml.append('				</td>                                                                                               ');
		rstHtml.append('			</tr>                                                                                                   ');
		
		
		rstHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		rstHtml.append('	   <td colspan="4" class="L">																			');
		
		$.each(incSpVO.actVioVOList, function(j, ActVioVO) {
			
			var poContCd = "";
			var dipCont = "";
			var fnAmt = "";
			
			//처분내용이 있으면 
			if(ActVioVO.incDipRstVO != null){
				poContCd = ActVioVO.incDipRstVO.poContCd;
				dipCont = getParamValue(ActVioVO.incDipRstVO.dipCont);
				fnAmt = getParamValue(ActVioVO.incDipRstVO.fnAmt)
			}
		
			rstHtml.append('	   	<div class="law">                                                                                   ');
			rstHtml.append('			<input type="hidden" name="rst_actVio_incSpNum" value="'+ActVioVO.incSpNum+'" />  ');
			rstHtml.append('			<input type="hidden" name="rst_actVio_actVioNum" value="'+ActVioVO.actVioNum+'" />  ');
			rstHtml.append('	   		<ul>                                                                                            ');
			rstHtml.append('	   			<li><span class="title">위반법률 및 죄명</span>                                                    ');
			rstHtml.append('	   				<label for="rst_rltActCriNmCdDesc_'+i+'_'+j+'"></label><input type="text" class="w80per" id="rst_rltActCriNmCdDesc_'+i+'_'+j+'" name="rst_rltActCriNmCdDesc" value="'+ActVioVO.rltActCriNmCdDesc+'" disabled="true" data-readonly="y"/>    ');
			rstHtml.append('	   			</li>                                                                                       ');
			
			rstHtml.append('	   			<li><span class="title">검찰내용</span>                                                         ');
			rstHtml.append('	   				<div class="inputbox w80per">                                                           ');
			
			var poContCodeName="";
			var poContCodeHtml = new StringBuffer();
			poContCodeHtml.append('						<option value="" selected="selected">없음</option>                                                                                                          ');
			poContCodeName = "없음";
			$.each(data.poContList, function(k, poCont) {
				if(poContCd == poCont.code){
					poContCodeName = poCont.codeName;
				}
				poContCodeHtml.append('						<option value="'+poCont.code+'" '+(poContCd == poCont.code ? "selected=\"selected\"":"")+'>'+poCont.codeName+'</option>                                                                                                          ');
			});
			
			rstHtml.append('	   					<p class="txt">'+poContCodeName+'</p>                                                                 ');
			rstHtml.append('	   					<select name="rst_poContCd">                                                                            ');
			rstHtml.append(poContCodeHtml);
			rstHtml.append('	   					</select>                                                                           ');
			rstHtml.append('	   				</div>                                                                                  ');
			rstHtml.append('	   			</li>                                                                                       ');
			rstHtml.append('	   			<li><span class="title">처분내용</span>                                                         ');
			rstHtml.append('	   				<label for="rst_dipCont_'+i+'_'+j+'"></label><input type="text" class="w80per" id="rst_dipCont_'+i+'_'+j+'" name="rst_dipCont" value="'+dipCont+'" maxlength="300" />    ');
			rstHtml.append('	   			</li>                                                                                       ');
			rstHtml.append('	   			<li><span class="title">벌금액</span>                                                         ');
			rstHtml.append('	   				<label for="rst_fnAmt_'+i+'_'+j+'"></label><input type="text" class="w10per" id="rst_fnAmt_'+i+'_'+j+'" name="rst_fnAmt" value="'+fnAmt+'" maxlength="30" /><span class="sub_title">만원</span>    ');
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
	
	//수사상태가 [(사건처분완료(90) || 사건판결완료(91)) && 사건마스터] 일 경우에만
	if((b0101VOMap.criStatCd == "90" || b0101VOMap.criStatCd == "91") && isRootInc){
		rstHtml.append('<div class="btnArea">																					');
		rstHtml.append(" <div class=\"r_btn\"><a href=\"javascript:updateIncident(6);\" class=\"btn_light_blue save\" name=\"updateIncDipRstBtn\"><span>수정</span></a></div> ");
		//수정버튼만 
		
		//처분진행탭에 처분등록 버튼 노출
//		$.each(b0101VOMap.taskTrstVOList, function(index, taskTrstVO) {
//			console.log(taskTrstVO.trstStatNm);
//			console.log(taskTrstVO.trstStatNum);
//			console.log(taskTrstVO.taskRespMb);
//			console.log(taskTrstVO.criStatCd);
//			if (taskTrstVO.taskRoleCd.indexOf($("#kindCd").val()) != -1) {	//역할에 맞는 버튼만 보이도록 처리		
//				rstHtml.append(" <div class=\"r_btn\"><a href=\"javascript:void(0);\" class=\"btn_light_blue\" name=\"trstBtn\" value=\""+taskTrstVO.trstStatNm+"\" data-update-type=\"5\" data-trst-stat-nm=\""+taskTrstVO.trstStatNm+"\" data-trst-stat-num=\""+taskTrstVO.trstStatNum+"\" data-cri-stat-cd=\""+taskTrstVO.criStatCd+"\" data-wf-num=\""+taskTrstVO.wfNum+"\" data-always=\"y\"><span>"+taskTrstVO.trstStatNm+"</span></a></div> ");			
//			}
//		});
	
		rstHtml.append('</div>                                                                                                 ');
			
	}
	
	$("#ocrt_list_tab2_div").html(rstHtml.toString());
	
	//TODO 송치관이 아닐경우에는, 입력화면이 보일필요가 없는거 아닐까?
	//송치관이 아닐경우에는 읽기만 가능 (송치관만 수정가능)
	if(SJPBRole.getTrnsrRoleYn() && (b0101VOMap.criStatCd == "90" || b0101VOMap.criStatCd == "91")){
		//수정가능 
		
		//이벤트바인딩 (selectbox)
		setTargetDefaultEvent( $("#ocrt_list_tab2_div") );
		
		//달력이벤트
		$(".datepicker").datepicker({
			  dateFormat: "yy-mm-dd" ,
			  changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
			  changeYear: true,
			  showButtonPanel: true,
			  currentText: '오늘 날짜'
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
	alert("처분결과가 수정 되었습니다.");
	selectIncDipRstDetails();
}

//판결수정 성공 콜백함수 
function callBackUpdateIncJdtRstSuccess(data){
	alert("판결결과가 수정 되었습니다.");
	selectIncJdtRstDetails();
	sjpbFile.init();
}

//첨부파일 데이터 갱신
function syncSjpbFileVOList(files) {
	if ( sjpbFile.vaultUploader) {
		var sjpbFileVOArray = new Array();	
		var fileList = sjpbFile.vaultUploader.getData();
		
		if (files.length > 0) {  
			for (var i = 0 ; i < fileList.length ; i++) {					
				var sjpbFileVO = {
					fileNm : fileList[i].name
				   ,fileMask : fileList[i].serverName
				   ,fileSize : fileList[i].size
				   ,regUserId : $("#userId").val()
				   ,updUserId : $("#userId").val()
				}
				sjpbFileVOArray.push(sjpbFileVO);
			}
		}
		
		return sjpbFileVOArray;
	}
}

//처분진행 입력 화면 노출(그리기)
function insertIncDipRstView(data){
	
	var rstHtml = new StringBuffer();  
	
	//피의자
	var spNum = 0;
	$.each(b0101VOMap.incSpVOList, function(i, incSpVO) {
		
		var spIdNumDec =  incSpVO.spIdNum;
		var spNmDec = incSpVO.spNm;
		
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
		
		rstHtml.append('			<tr>                                                                                                    ');
		rstHtml.append('				<th class="C">형제번호</th>                                                                             ');
		rstHtml.append('				<td class="L" colspan="3">                                                                                      ');
		rstHtml.append('					<label for="rst_crlwNum_'+i+'"></label><input type="text" class="w100per" id="rst_crlwNum_'+i+'" name="rst_crlwNum"   maxlength="30"/>           ');
		rstHtml.append('				</td>                                                                                               ');
		rstHtml.append('			</tr>                                                                                                   ');
		rstHtml.append('			<tr>                                                                                                    ');
		rstHtml.append('				<th class="C">검찰처분일시</th>                                                                           ');
		rstHtml.append('				<td class="L" colspan="3">                                                                                      ');
		rstHtml.append('					<label for="rst_poDipDt_'+i+'"></label><input type="text" class="w20per calendar datepicker" title="검찰처분일시" id="rst_poDipDt_'+i+'" name="rst_poDipDt" />   ');
		rstHtml.append('				</td>                                                                                               ');
		rstHtml.append('			</tr>                                                                                                   ');
		
		rstHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		rstHtml.append('	   <td colspan="4" class="L">																			');
		
		$.each(incSpVO.actVioVOList, function(j, ActVioVO) {
		
			rstHtml.append('	   	<div class="law">                                                                                   ');
			rstHtml.append('			<input type="hidden" name="rst_actVio_incSpNum" value="'+ActVioVO.incSpNum+'" />  ');
			rstHtml.append('			<input type="hidden" name="rst_actVio_actVioNum" value="'+ActVioVO.actVioNum+'" />  ');
			rstHtml.append('	   		<ul>                                                                                            ');
			rstHtml.append('	   			<li><span class="title">위반법률 및 죄명</span>                                                    ');
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
			rstHtml.append('	   				<label for="rst_dipCont_'+i+'_'+j+'"></label><input type="text" class="w80per" id="rst_dipCont_'+i+'_'+j+'" name="rst_dipCont" value=""   maxlength="300"/>    ');
			rstHtml.append('	   			</li>                                                                                       ');
			rstHtml.append('	   			<li><span class="title">벌금액</span>                                                         ');
			rstHtml.append('	   				<label for="rst_fnAmt_'+i+'_'+j+'"></label><input type="text" class="w10per" id="rst_fnAmt_'+i+'_'+j+'" name="rst_fnAmt" value="" maxlength="30"/><span class="sub_title">만원</span>    ');
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
		
		if(isRootInc){
			//처분진행탭에 처분등록 버튼 노출
			$.each(b0101VOMap.taskTrstVOList, function(index, taskTrstVO) {
				//console.log(taskTrstVO.trstStatNm);
				//console.log(taskTrstVO.trstStatNum);
				//console.log(taskTrstVO.taskRespMb);
				//console.log(taskTrstVO.criStatCd);
				if (SJPBRole.getHasAnyRole(taskTrstVO.taskRoleCd)) {	//역할에 맞는 버튼만 보이도록 처리
					rstHtml.append(" <div class=\"r_btn\"><a href=\"javascript:void(0);\" class=\"btn_light_blue save\" name=\"trstBtn\" value=\""+taskTrstVO.trstStatNm+"\" data-update-type=\"5\" data-trst-stat-nm=\""+taskTrstVO.trstStatNm+"\" data-trst-stat-num=\""+taskTrstVO.trstStatNum+"\" data-cri-stat-cd=\""+taskTrstVO.criStatCd+"\" data-wf-num=\""+taskTrstVO.wfNum+"\" data-always=\"y\"><span>"+taskTrstVO.trstStatNm+"</span></a></div> ");			
				}
			});
		}
	
		rstHtml.append('</div>                                                                                                 ');
			
	}
	
	$("#ocrt_list_tab2_div").html(rstHtml.toString());
	
	//TODO 송치관이 아닐경우에는, 입력화면이 보일필요가 없는거 아닐까?
	//송치관이 아닐경우에는 읽기만 가능 (송치관만 수정가능)
	if( b0101VOMap.criStatCd == "73" || b0101VOMap.criStatCd == "78" ){
		//수정가능 
		
		//이벤트바인딩 (selectbox)
		setTargetDefaultEvent( $("#ocrt_list_tab2_div") );
		
		//달력이벤트
		$(".datepicker").datepicker({
			  dateFormat: "yy-mm-dd" ,
			  changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
			  changeYear: true,
			  showButtonPanel: true,
			  currentText: '오늘 날짜'
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

	//피의자
	var spNum = 0;
	$.each(b0101VOMap.incSpVOList, function(i, incSpVO) {
		
		var spIdNumDec =  incSpVO.spIdNum;
		var spNmDec = incSpVO.spNm;
		
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
		
		rstHtml.append('			<tr>                                                                                                    ');
		rstHtml.append('				<th class="C">판결확정</th>                                                                             ');
		rstHtml.append('				<td class="L" colspan="3">                                                                                      ');
		rstHtml.append('					<label for="jdt_jdtFiDt_'+i+'"></label><input type="text" class="w20per calendar datepicker" title="판결확정일" id="jdt_jdtFiDt_'+i+'" name="jdt_jdtFiDt" />           ');
		rstHtml.append('				</td>                                                                                               ');
		rstHtml.append('			</tr>                                                                                                   ');
		
		rstHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		rstHtml.append('	   <td colspan="4" class="L">																			');
		
		$.each(incSpVO.actVioVOList, function(j, ActVioVO) {
		
			rstHtml.append('	   	<div class="law">                                                                                   ');
			rstHtml.append('			<input type="hidden" name="jdt_actVio_incSpNum" value="'+ActVioVO.incSpNum+'" />  ');
			rstHtml.append('			<input type="hidden" name="jdt_actVio_actVioNum" value="'+ActVioVO.actVioNum+'" />  ');
			rstHtml.append('	   		<ul>                                                                                            ');
			rstHtml.append('	   			<li><span class="title">위반법률 및 죄명</span>                                                    ');
			rstHtml.append('	   				<label for="jdt_rltActCriNmCdDesc_'+i+'_'+j+'"></label><input type="text" class="w80per" id="jdt_rltActCriNmCdDesc_'+i+'_'+j+'" name="jdt_rltActCriNmCdDesc" value="'+ActVioVO.rltActCriNmCdDesc+'" disabled="true" data-readonly="y"/>    ');
			rstHtml.append('	   			</li>                                                                                       ');
			rstHtml.append('	   			<li><span class="title">판결내용</span>                                                         ');
			rstHtml.append('	   				<label for="jdt_jdtCont_'+i+'_'+j+'"></label><input type="text" class="w80per" id="jdt_jdtCont_'+i+'_'+j+'" name="jdt_jdtCont" value=""  maxlength="300" />    ');
			rstHtml.append('	   			</li>                                                                                       ');
			rstHtml.append('	   			<li><span class="title">기타</span>                                                         ');
			rstHtml.append('	   				<label for="jdt_jdtOp_'+i+'_'+j+'"></label><input type="text" class="w80per" id="jdt_jdtOp_'+i+'_'+j+'" name="jdt_jdtOp" value=""  maxlength="300" />    ');
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
		
		if(isRootInc){
			//처분진행탭에 처분등록 버튼 노출
			$.each(b0101VOMap.taskTrstVOList, function(index, taskTrstVO) {
				if (SJPBRole.getHasAnyRole(taskTrstVO.taskRoleCd)) {	//역할에 맞는 버튼만 보이도록 처리
					rstHtml.append(" <div class=\"r_btn\"><a href=\"javascript:void(0);\" class=\"btn_light_blue save\" name=\"trstBtn\" value=\""+taskTrstVO.trstStatNm+"\" data-update-type=\"7\" data-trst-stat-nm=\""+taskTrstVO.trstStatNm+"\" data-trst-stat-num=\""+taskTrstVO.trstStatNum+"\" data-cri-stat-cd=\""+taskTrstVO.criStatCd+"\" data-wf-num=\""+taskTrstVO.wfNum+"\" data-always=\"y\"><span>"+taskTrstVO.trstStatNm+"</span></a></div> ");			
				}
			});
		}
	
		rstHtml.append('</div>                                                                                                 ');
			
	}
	
	$("#ocrt_list_tab3_div").html(rstHtml.toString());
	
	//TODO 송치관이 아닐경우에는, 입력화면이 보일필요가 없는거 아닐까?
	//송치관이 아닐경우에는 읽기만 가능 (송치관만 수정가능)
	if(b0101VOMap.criStatCd == "90"){
		//수정가능 
		
		//이벤트바인딩 (selectbox)
		setTargetDefaultEvent( $("#ocrt_list_tab3_div") );
		
		//달력이벤트
		$(".datepicker").datepicker({
			  dateFormat: "yy-mm-dd" ,
			  changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
			  changeYear: true,
			  showButtonPanel: true,
			  currentText: '오늘 날짜'
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
	
	//피의자
	var spNum = 0;
	$.each(b0101VOMap.incSpVOList, function(i, incSpVO) {
		
		var spIdNumDec =  incSpVO.spIdNum;
		var spNmDec = incSpVO.spNm;
		
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
		
		rstHtml.append('			<tr>                                                                                                    ');
		rstHtml.append('				<th class="C">판결확정</th>                                                                             ');
		rstHtml.append('				<td class="L" colspan="3">                                                                                      ');
		rstHtml.append('					<label for="jdt_jdtFiDt_'+i+'"></label><input type="text" class="w20per calendar datepicker" title="판결확정일" id="jdt_jdtFiDt_'+i+'" name="jdt_jdtFiDt" value="'+getParamValue(incSpVO.jdtFiDt)+'" />           ');
		rstHtml.append('				</td>                                                                                               ');
		rstHtml.append('			</tr>                                                                                                   ');
		
		rstHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		rstHtml.append('	   <td colspan="4" class="L">																			');
		
		$.each(incSpVO.actVioVOList, function(j, ActVioVO) {
			
			var jdtCont = "";
			var jdtOp = "";
			
			//판결데이터가 있을경우
			if(ActVioVO.incJdtRstVO != null){
				jdtCont = getParamValue(ActVioVO.incJdtRstVO.jdtCont);
				jdtOp = getParamValue(ActVioVO.incJdtRstVO.jdtOp);
			}
		
			rstHtml.append('	   	<div class="law">                                                                                   ');
			rstHtml.append('			<input type="hidden" name="jdt_actVio_incSpNum" value="'+ActVioVO.incSpNum+'" />  ');
			rstHtml.append('			<input type="hidden" name="jdt_actVio_actVioNum" value="'+ActVioVO.actVioNum+'" />  ');
			rstHtml.append('	   		<ul>                                                                                            ');
			rstHtml.append('	   			<li><span class="title">위반법률 및 죄명</span>                                                    ');
			rstHtml.append('	   				<label for="jdt_rltActCriNmCdDesc_'+i+'_'+j+'"></label><input type="text" class="w80per" id="jdt_rltActCriNmCdDesc_'+i+'_'+j+'" name="jdt_rltActCriNmCdDesc" value="'+ActVioVO.rltActCriNmCdDesc+'" disabled="true" data-readonly="y"/>    ');
			rstHtml.append('	   			</li>                                                                                       ');
			rstHtml.append('	   			<li><span class="title">판결내용</span>                                                         ');
			rstHtml.append('	   				<label for="jdt_jdtCont_'+i+'_'+j+'"></label><input type="text" class="w80per" id="jdt_jdtCont_'+i+'_'+j+'" name="jdt_jdtCont" value="'+jdtCont+'" maxlength="300"/>    ');
			rstHtml.append('	   			</li>                                                                                       ');
			rstHtml.append('	   			<li><span class="title">기타</span>                                                         ');
			rstHtml.append('	   				<label for="jdt_jdtOp_'+i+'_'+j+'"></label><input type="text" class="w80per" id="jdt_jdtOp_'+i+'_'+j+'" name="jdt_jdtOp" value="'+jdtOp+'" maxlength="300" />    ');
			rstHtml.append('	   			</li>                                                                                       ');
			rstHtml.append('	   		</ul>                                                                                           ');
			rstHtml.append('	   	</div>                                                                                              ');
		
		});
		
		rstHtml.append('	   	</td>                                                                                                ');
		rstHtml.append('	   <tr>                                                                                                                                                                                                                                            ');
		rstHtml.append('	   		<th class="C">파일업로드 </td>                                                                                                                                                                                                                                            ');
		rstHtml.append('			<td class="L td_line" colspan="3">');
		rstHtml.append('				<div id="vault_upload" style="height: 200px; width: 100%" ></div>');
		rstHtml.append('<ul id="vault_fileList" style="display: none;">');
		rstHtml.append('</ul>');
		rstHtml.append('<form name="setFileList" method="post" target="invisible" action="${cPath }/sjpb/fileMngr?cmd=delete">');
		rstHtml.append('<input type=hidden name=semaphore  value="">');
		rstHtml.append('<input type=hidden name=vaccum> ');
		rstHtml.append('<input type=hidden name=delBoardId value="">');
		rstHtml.append('<input type=hidden name=unDelList> ');
		rstHtml.append('<input type=hidden name=delList> ');
		rstHtml.append('<input type=hidden name=subId value=sub01>');
		rstHtml.append('</form>');
		rstHtml.append('	   		</td>                                                                                                                                                                                                                                            ');
		rstHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
		rstHtml.append('   </tbody>                                                                                                                                                                                                                                          ');
		rstHtml.append('</table>                                                                                                                                                                                                                                             ');
		rstHtml.append('</div>                                                                                                                                                                                                                                             ');
	});
	
	//수사상태가 [ 사건판결완료(91) && 사건마스터 ] 일 경우에만
	if(b0101VOMap.criStatCd == "91" && isRootInc){
		rstHtml.append('<div class="btnArea">																					');
		rstHtml.append(" <div class=\"r_btn\"><a href=\"javascript:updateIncident(8);\" class=\"btn_light_blue save\" name=\"updateIncJdtRstBtn\"><span>수정</span></a></div> ");
		rstHtml.append('</div>                                                                                                 ');
	}
	
	$("#ocrt_list_tab3_div").html(rstHtml.toString());
	
	//업로드된 판결문 리스트 보여주기
	var fileListHtml="";
	$.each(b0101VOMap.sjpbFileVOList, function(index, item) {
		fileListHtml += '<li data-id="'+item.fileId+'" data-name="'+item.fileNm+'" data-size="'+item.fileSize+'" data-mask="'+item.fileMask +'" data-type="'+item.fileType+'" data-path="'+item.filePath+'" data-cType="'+item.fileCtype+'">';
		fileListHtml += '<a href="#">'+item.fileNm+'('+item.fileSize+')</a>';
		fileListHtml += '</li>';
	});
	$("#vault_fileList").html(fileListHtml);
	
	//TODO 송치관이 아닐경우에는, 입력화면이 보일필요가 없는거 아닐까?
	//송치관이 아닐경우에는 읽기만 가능 (송치관만 수정가능)
	if(b0101VOMap.criStatCd == "91"){
		//수정가능 
		
		//이벤트바인딩 (selectbox)
		setTargetDefaultEvent( $("#ocrt_list_tab3_div") );
		
		//달력이벤트
		$(".datepicker").datepicker({
			  dateFormat: "yy-mm-dd" ,
			  changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
			  changeYear: true,
			  showButtonPanel: true,
			  currentText: '오늘 날짜'  
		});
		
	}else{
		//수정 불가능
		areaSetReadOnly($("#ocrt_list_tab3_div"));
	}
	
	//타스크이행
	eventTaskBtn();
}

//수사자료 업데이트
function updateDipRstDta() {
	
	if ( sjpbFile.vaultUploader) {
		sjpbFile.vaultUploader.attachEvent("onUploadComplete", function (files) {		
			
			syncSjpbFileVOList(files);			
			sjpbFile.isNewFile = false;
			sjpbFile.isCancel = false;

			goAjax("/sjpb/B/updateDipRstDta.face", incCriCmdItemVO, callBackUpdateCriIncDtaSuccess);
		
		});		
		
		if (sjpbFile.isNewFile) { //업로드 대상이 있는 경우			
			sjpbFile.vaultUploader.upload();
		} else {  //업로드 대상이 없는 경우			
			incTrfItemVO.criIncDtaVOList = null;
			sjpbFile.isCancel = false;
		} 
		
	}
	
}


//검찰처분결과 데이터 갱신
function syncIncDipRstVOList(paramMap){
	
	//var incDipRstVO = new Object();
	
	paramMap.rcptNum = b0101VOMap.rcptNum;
	
	//피의자정보 셋팅 n명
	//radio 는 data-name 으로 찾는다. 
	var incSpVOArray = new Array();
	$("div[data-name=rstpersoninfo]").each(function(i) {
		
		var incSpVO = {
			incSpNum : $(this).find("input[name=rst_incSpNum]").val()
			,rcptNum : $(this).find("input[name=rst_rcptNum]").val()
			,spNm : $(this).find("input[name=rst_spNm]").val()
			,crlwNum : $(this).find("input[name=rst_crlwNum]").val()
			,poDipDt : $(this).find("input[name=rst_poDipDt]").val()
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
	
	//피의자정보 셋팅 n명
	//radio 는 data-name 으로 찾는다. 
	var incSpVOArray = new Array();
	$("div[data-name=jdtpersoninfo]").each(function(i) {
		
		var incSpVO = {
			incSpNum : $(this).find("input[name=jdt_incSpNum]").val()
			,rcptNum : $(this).find("input[name=jdt_rcptNum]").val()
			,spNm : $(this).find("input[name=jdt_spNm]").val()
			,jdtFiDt : $(this).find("input[name=jdt_jdtFiDt]").val()
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
//수사자료 업데이트
function updateCriIncDta() {
	
	if ( sjpbFile.vaultUploader) {
		sjpbFile.vaultUploader.attachEvent("onUploadComplete", function (files) {		
			
			syncSjpbFileVOList(files);			
			sjpbFile.isNewFile = false;
			sjpbFile.isCancel = false;

			goAjax("/sjpb/C/updateCriIncDta.face", incCriCmdItemVO, callBackUpdateCriIncDtaSuccess);
		
		});		
		
		if (sjpbFile.isNewFile) { //업로드 대상이 있는 경우			
			sjpbFile.vaultUploader.upload();
		} else {  //업로드 대상이 없는 경우			
			incTrfItemVO.criIncDtaVOList = null;
			sjpbFile.isCancel = false;
		} 
		
	}
	
}

//공통스크립트 가져옴
function setDefaultEvent(){
	$('.inputbox').find('select').each(function() {
		var self = $(this),
			parentBox = self.parents('.inputbox'),
			change = function() {
				$(this).prev('.txt').text($(this).find('option:selected').text());
			},
			focusin = function() {
				$(this).parents('.inputbox').addClass('selected');
			},
			focusout = function() {
				$(this).parents('.inputbox').removeClass('selected');
			};

		self.css({

			'height' : parentBox.height() + 'px'
		}).on({
			'change' : change,
			'focusin' : focusin,
			'focusout' : focusout
		});
	}).end().find('.txt').each(function(){
		var self = $(this);
		self.text(self.next('select').find('option:selected').text());
	});
	
}
//Map 데이터 초기화
function initIncCriCmdBkVOMap() {	
	incCriCmdBkVO =  {		
			incCriCmdItemNum : ""                  	
			,incCriCmdBkNum : "" 	//사건수사지휘부번호    	
			,rcptNum : ""		 //접수번호            	
			,rcptIncNum : ""		//부모접수번호           	
			,incCriCmdItemStatCd : ""               	
			,incCriCmdBkStatCd  : ""                	
			,incCriCmdItemDesc  : ""                	
			,criCmdTranDt : ""       //수사지휘인계일      	
			,criCmdReqDt : ""        //수사지휘접수일      	
			,criCmdRcptDt : ""       //수사지휘수령일      	
			,reCmdYn : ""            //재지휘여부        	
			,criCmdRst : ""                         	
			,criCmdComn : ""                        	
			,incSpNum : ""            //사건피의자       	
			,spNm : ""               //피의자이름        	
			,incCriNm : ""                          	
			,regUserId : ""                         	
			,regDate : ""                          
			,updUserId : ""                         
			,updDate : ""
			
		}
}



//Map 데이터 초기화
function initIncCriCmdItemVOMap() {	
	incCriCmdItemVO =  {		
			incCriCmdItemNum : ""  //사건수사지휘건번호
			,rcptIncNum : ""     //사건번호
			,rcptNum : ""          //접수번호
			,pareRcptNum : ""		//부모접수번호
			,respDppoCd : ""	//담당지검코드
			,respDppoDesc : ""	//담당지검코드설명
			,criCmdRst : ""      //수사지휘결과
			,criCmdComn : ""     //수사지휘의견
			,criCmdTranDt : ""   //수사지휘인계일
			,criCmdReqDt : ""    //수사지휘접수일
			,criCmdRcptDt : ""   //수사지휘수령일
			,incCriCmdItemStatCd : ""	//지휘건 구분코드
			,incCriCmdItemDesc : ""		//지휘건 구분설명
			,reCmdYn : ""		//재지휘여부
			,updStatYN : ""       //상태변경유무	
			,regUserId : ""
			,regDate : ""
			,updUserId : ""
			,updDate : ""	
			,spCmdVOList : null	//수사 지휘 피의자 리스트
			,incCriCmdBkList : null
			,b0101TK : null
			,criCmdReqComn : ""
		}
}

//Map 데이터 초기화
function initIncTrfItemVOMap() {	
	incTrfItemVO =  {		
			incTrfItemNum : ""  //사건송치건번호
			,rcptNum : ""          //접수번호
			,pareRcptNum : ""	//부모접수번호
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
			,b0101TK : null
			
		}
}


//수사지휘부
var incCriCmdBkVO =  {		
	incCriCmdItemNum : ""                  	
	,incCriCmdBkNum : "" 	//사건수사지휘부번호    	
	,rcptNum : ""		 //접수번호            	
	,rcptIncNum : ""		//부모접수번호           	
	,incCriCmdItemStatCd : ""               	
	,incCriCmdBkStatCd  : ""                	
	,incCriCmdItemDesc  : ""                	
	,criCmdTranDt : ""       //수사지휘인계일      	
	,criCmdReqDt : ""        //수사지휘접수일      	
	,criCmdRcptDt : ""       //수사지휘수령일      	
	,reCmdYn : ""            //재지휘여부        	
	,criCmdRst : ""                         	
	,criCmdComn : ""                        	
	,incSpNum : ""            //사건피의자       	
	,spNm : ""               //피의자이름        	
	,incCriNm : ""                          	
	,regUserId : ""                         	
	,regDate : ""                          
	,updUserId : ""                         
	,updDate : ""   
	
}

//수사지휘겅(피의자별)
var incCriCmdItemVO =  {		
	incCriCmdItemNum : ""  //사건수사지휘건번호
	,rcptIncNum : ""     //사건번호
	,rcptNum : ""          //접수번호
	,pareRcptNum : ""		//부모접수번호
	,respDppoCd : ""	//담당지검코드
	,respDppoDesc : ""	//담당지검코드설명
	,criCmdRst : ""      //수사지휘결과
	,criCmdComn : ""     //수사지휘의견
	,criCmdTranDt : ""   //수사지휘인계일
	,criCmdReqDt : ""    //수사지휘접수일
	,criCmdRcptDt : ""   //수사지휘수령일
	,incCriCmdItemStatCd : ""	//지휘건 구분코드
	,incCriCmdItemDesc : ""		//지휘건 구분설명
	,reCmdYn : ""		//재지휘여부
	,updStatYN : ""       //상태변경유무	
	,regUserId : ""
	,regDate : ""
	,updUserId : ""
	,updDate : ""	
	,spCmdVOList : null	//수사 지휘 피의자 리스트
	,incCriCmdBkList : null
	,b0101TK : null
	,criCmdReqComn : ""
}
/*
//수사지휘
var incCriCmdItemVO =  {		
	incCriCmdItemNum : ""  //사건수사지휘건번호
	,rcptNum : ""          //접수번호
	,pareRcptNum : ""		//부모접수번호
	,incCriCmdItemStatCd : "" //사건수사지휘건상태코드 01:접수, 02:등록, 03:건의, 04:수령
	,incCriCmdBkStatCd : ""	//사건지휘부구분코드
	,incCriCmdItemDesc : ""	//사건지휘건구분 설명
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
	,spCmdVOList : null	//수사 지휘 피의자 리스트
	,incCriCmdBkList : null
}
*/
//송치
var incTrfItemVO =  {		
	incTrfItemNum : ""  //사건송치건번호
	,rcptNum : ""          //접수번호
	,pareRcptNum : ""	//부모접수번호
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
	,sjpbFileVOList : null  //첨부파일
}

