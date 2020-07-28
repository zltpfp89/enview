/* 통계원표 스크립트 */
$(document).ready(function(){
	//이벤트 세팅
	eventSetupSts();
});

//이벤트 세팅
function eventSetupSts() {
	
	// 발생 통계원표 S 
	$("select[name=occr_occrYrmhDt_year], select[name=occr_occrYrmhDt_month], select[name=occr_occrYrmhDt_day], select[name=occr_occrYrmhDt_time]").off("click").on("click",function(){
		if($("input[name=occr_occrYrmhDtDivCd]:checked").val() != 1){
			$("input[name=occr_occrYrmhDtDivCd]:radio[value='1']").prop("checked", true);
		}
	});
		
	//발생통계원표 - 발생년월일시 선택 
//	$("input[name=occr_occrYrmhDtDivCd]").on("click", function(){
//		if( getFieldValue($(this)) == "1"){	//발생년월일시 선택
//			$("select[data-name=occr_occrYrmhDt]").each(function(){
//				$(this).removeAttr("data-optional-value");
//			});
//			
//		}else{	//미상선택 : 필수옵션 제거 
//			$("select[data-name=occr_occrYrmhDt]").each(function(){
//				$(this).attr("data-optional-value","true");
//			});
//			
//		}
//	});
	
	$("input[name=occr_age]").off("click").on("click", function(){
		if($("input[name=occr_ageDivCd]:checked").val() != 1){
			$("input[name=occr_ageDivCd]:radio[value='1']").prop("checked", true);
			//$(this).removeAttr("data-optional-value");
		}
	});
	
//	$("input[name=occr_ageDivCd]").on("click", function(){
//		if( getFieldValue($(this)) == "1"){	//연령선택
//			$("input[name=occr_age]").removeAttr("data-optional-value");
//			
//		}else{	//미상선택 : 연령 필수옵션 제거 
//			$("input[name=occr_age]").attr("data-optional-value","true");
//		}
//	});
	
	
	
	$("select[name=occr_occrAreaDiv]").off("change").on("change", function(){
		
		var jsonArray = eval('jsonOccrAreaArray["'+$(this).val()+'"]');
		
		var html = new StringBuffer();
		html.append('<option value="" selected="selected">선택</option>')
		
		if(jsonArray != null ){
			for (var i = 0; i < jsonArray.length; i++) {
				var data = "";
				html.append('<option value="'+jsonArray[i].value+'">'+jsonArray[i].label+'</option>');
			}
		}
		
		$("select[name=occr_occrArea]").html(html.toString());
		
		//이벤트바인딩 (selectbox)
		setTargetDefaultEvent( $("div[data-name=occr_occrAreaDiv]") );
	});
	
	$("select[name=occr_occrYrmhDt_year], select[name=occr_occrYrmhDt_month], select[name=occr_occrYrmhDt_day], select[name=occr_recgYrmhDt_year], select[name=occr_recgYrmhDt_month], select[name=occr_recgYrmhDt_day]").off("change").on("change", function(e){
		e.stopPropagation();
		
		var isEventExcute = true;
		var dataName = $(this).data("name");
		
		//년 월 일 3개 전부 선택했을 경우 , 
		if( $("select[data-name="+dataName+"] option:selected").length > 2 ){
			$("select[data-name="+dataName+"] option:selected").each(function(){
				if(isNull( $(this).val() )){
					isEventExcute = false;
					return false;
				}
			});
		}else{
			isEventExcute = false;
		}
		
		var messageType = $("#"+dataName+"_sub").attr("data-messageType");
		var messageHtml = "";
		if("1" == messageType){	//시경
			messageHtml = "시경";
		}else{	//시
			messageHtml = "시";
		}
		
		if(isEventExcute){
			var dayToStr = combineDayToString(dataName);
			var yyyy_mm_dd = fncStrToDate(dayToStr);
			var dayOfWeek = getDayOfWeek(yyyy_mm_dd);
			
			$("#"+dataName+"_sub").html(messageHtml+" ("+dayOfWeek+"요일)");
			$("input[name="+dataName+"Dotw]").val(dayOfWeek);
		}else{
			$("#"+dataName+"_sub").html(messageHtml);
			$("input[name="+dataName+"Dotw]").val("");
		}
	});
	
	$("input[data-name=occr_damgAmt]").off("change").on("change", function(e){
		e.stopPropagation();
		
		var damgAmtTot = 0;
		$("input[data-name=occr_damgAmt]").each(function(){
			damgAmtTot += isNull($(this).val()) ? 0 : parseInt($(this).val());
		});
		setFieldValue($("#occr_damgAmtTot"), damgAmtTot);
	});
	
	$("input[data-name=occr_bodyDamgInjy], input[data-name=occr_bodyDamgDeth]").off("change").on("change", function(e){
		e.stopPropagation();
		var dataName = $(this).data("name");
		var isEmpty = true;
		$("input[data-name="+dataName+"]").each(function(){
			if(!isNull($(this).val())){
				setFieldValue($("input[name="+dataName+"]"), "Y");
				isEmpty = false;
				return false;
			}
		});
		if(isEmpty){
			setFieldValue($("input[name="+dataName+"]"), null);
		}
	});
	// 발생 통계원표 E
	
	// 검거통계원표 S
	$("input[data-name=arst_collAmt]").off("change").on("change", function(e){
		e.stopPropagation();
		
		var collAmtTot = 0;
		$("input[data-name=arst_collAmt]").each(function(){
			collAmtTot += isNull($(this).val()) ? 0 : parseInt($(this).val());
		});
		setFieldValue($("#arst_collAmtTot"), collAmtTot);
	});
	// 검거통계원표 E
	
	//피의자통계원표 S
	$("select[name=sp_jobCd]").off("change").on("change", function(e){
		if($(this).val() == "00"){	//공무원 추가 입력 필드 노출 
			$("#sp_jobCd_subDiv").show();
		}else{
			$("#sp_jobCd_subDiv").hide();
		}
	});
	
	$("select[name=sp_rltActCriNmCdDesc]").off("change").on("change", function(e){
		//죄명선택에 따라 죄명코드, 죄명, 죄명sub, 법률위반번호는 바귀어야함 S
		setFieldValue($("#sp_rltActCriNmCd"), $(this).find('option:selected').data("rltactcrinmcd"));			//죄명코드
		setFieldValue($("#sp_actVioClaNm"), $(this).find('option:selected').data("actvioclanm"));				//죄명 sub
		setFieldValue($("input[name=sp_actVioNum]"), getFieldValue($(this)));	//법률위반번호
		//죄명선택에 따라 죄명코드, 죄명, 죄명sub, 법률위반번호는 바귀어야함 E
	});
	//피의자통계원표 E
	
	//발생통계원표 출력 버튼 클릭
	$("#occrPrnBtn").off("click").on("click", function() {	
		stsPrnt("1");
	});
	
	//검거통계원표 출력 버튼 클릭
	$("#arstPrnBtn").off("click").on("click", function() {		
		stsPrnt("2");
	});
	
	//피의자통계원표 출력 버튼 클릭
	$("#spPrnBtn").off("click").on("click", function() {		
		stsPrnt("3");
	});
	
}

//발생,검거,피의자 통계원표 출력
function stsPrnt(type){
	//type 1 : 발생 
	//type 2 : 검거
	//type 3 : 피의자
	
	var reportName = "";
	
	var b0102RTVO = new Object();
	
	//발생통계원표
	if(type == "1"){
		reportName = "B0201.crf";
		syncOccrStsGrapVOMap();
		b0102RTVO[0] = occrStsGrapVOMap;
		
	//검거통계원표
	}else if(type == "2"){
		reportName = "B0202.crf";
		syncArstStsGrapVOMap();
		b0102RTVO[0] = arstStsGrapVOMap;
		
	//피의자통계원표	
	}else if(type == "3"){
		reportName = "B0203.crf";
		syncSpStsGrapVOMap();
		b0102RTVO[0] = spStsGrapVOMap;
		
		//피의자 주민번호, 성명 셋팅 S
		b0102RTVO[0].spNm = getFieldValue($("#sp_spNm"));			//성명
		b0102RTVO[0].spIdNum = getFieldValue($("#sp_spIdNum"));		//주민(여권)번호
		//피의자 주민번호, 성명 셋팅 E
		
	//아무것도아님.	
	}else{
		return;
	}
	
	//리포트에 필요한 데이터 셋팅 S
	b0102RTVO[0].userId = getFieldValue($("#userId"));					//사용자 ID
	b0102RTVO[0].userName = getFieldValue($("#userName"));				//사용자 이름
	b0102RTVO[0].todayDateYmd = getFieldValue($("#todayDateYmd"));		//작성날짜 yyyymmdd
	b0102RTVO[0].clas = "특별사법경찰관";				//계급 (고정)
	b0102RTVO[0].code = "2150101";						//코드 (고정)
	//리포트에 필요한 데이터 셋팅 E
	
	//리포트 여분 데이터 S
	b0102RTVO[0].tmp1 = b0102VOMap.incNum;		//사건번호
	b0102RTVO[0].tmp2 = "";						//tmp2
	b0102RTVO[0].tmp3 = "";						//tmp3
	b0102RTVO[0].tmp4 = "";						//tmp4
	b0102RTVO[0].tmp5 = "";						//tmp5
	b0102RTVO[0].tmp6 = "";						//tmp6
	b0102RTVO[0].tmp7 = "";						//tmp7
	b0102RTVO[0].tmp8 = "";						//tmp8
	b0102RTVO[0].tmp9 = "";						//tmp9
	b0102RTVO[0].tmp10 = "";					//tmp10
	//리포트 여분 데이터 E
	
	//console.log(JSON.stringify(b0102RTVO));
	b0102RTMap.rexdataset = b0102RTVO;
	
	var xmlString = objectToXml(b0102RTMap);
	
	
	$("#reptNm").val(reportName); //레포트 파일명
	$("#xmlData").val(xmlString);
	
	//레포트 호출
	openReportService(reportForm);  
}
//통계원표 탭 클릭시 실행
function abc(){
//	if(b0101VOMap.pareRcptNum != null && b0101VOMap.pareRcptNum != "" && b0101VOMap.pareRcptNum != " "){
//		alert("병합된 사건입니다. "+b0101VOMap.pareIncNum+"사건에서 진행가능합니다.");
//		return false;
//	}

	if(b0101VOMap.criStatCd == "57" || b0101VOMap.criStatCd == "67"){
		//수현 - 피의자 정보입력시에만 통계원표 작성 가능 
		var rstYN = "Y";
		$.each(b0101VOMap.incSpVOList, function(i, incSpVO) {
			var idNumlen = (incSpVO.spIdNum).length;
			var spNm = incSpVO.spNm;
			var spAddr = incSpVO.spAddr;
			var incCont = b0101VOMap.incCont;
			
			$.each(incSpVO.actVioVOList,function(i,actVioVO){
				if(!actVioVO.actVioClaVOList || actVioVO.actVioClaVOList.length == 0){
					rstYN = "N";
				}else{
					if(!actVioVO.actVioClaVOList || actVioVO.actVioClaVOList.length == 0){
						rstYN = "N";
					}else{
						var rltActCriNmCdYN = actVioVO.rltActCriNmCd;
						var actVioClaNmYN = actVioVO.actVioClaVOList[0].actVioClaNm;
						var vioContYN = actVioVO.vioCont;
						if( actVioClaNmYN == null || actVioClaNmYN == "" || vioContYN == null || vioContYN ==  "" || rltActCriNmCdYN == null || rltActCriNmCdYN == "" ){
							rstYN = "N";
						}
					}
				}
			});

		});

	}
	//통계원표 상세를 가져온다.	
	var reqMap3 = {
			rcptNum : b0101VOMap.rcptNum 
	}
	
	goAjaxDefault("/sjpb/B/selectIncidentStat.face", reqMap3, selectStsGrapList);

}

//통계원표 리스트 
function selectStsGrapList(data){
	
	b0101VOMap = data.b0101VO;
	
	//피의자 사건번호로 정렬 (병합사건일경우 보기 편의성을 위해)
//	if(b0101VOMap.incSpVOList != null){
//		b0101VOMap.incSpVOList.sort(function(a,b){
//			return a.rcptNum < b.rcptNum ? -1 : a.rcptNum > b.rcptNum ? 1 : 0;
//		});
//	}

	var stsHtml = new StringBuffer();		//통계원표 리스트 
	
	stsHtml.append('<div class="listArea">																		');
	stsHtml.append('	<table class="list" cellpadding="0" cellspacing="0">                                    ');
	stsHtml.append('		<colgroup>                                                                          ');
	stsHtml.append('			<col width="8%" />                                                              ');
	stsHtml.append('			<col width="20%" />                                                             ');
	stsHtml.append('			<col width="16%" />                                                             ');
	stsHtml.append('			<col width="*%" />                                                              ');
	stsHtml.append('			<col width="12%" />                                                             ');
	stsHtml.append('			<col width="12%" />                                                             ');
	stsHtml.append('			<col width="12%" />                                                             ');
	stsHtml.append('		</colgroup>                                                                         ');
	stsHtml.append('		<thead>                                                                             ');
	stsHtml.append('			<tr>                                                                            ');
	stsHtml.append('				<th class="C" rowspan="2"></th>                                            ');
	stsHtml.append('				<th class="C" rowspan="2">사건번호</th>                                         ');
	stsHtml.append('				<th class="C" rowspan="2">피의자</th>                                          ');
	stsHtml.append('				<th class="C r_line" rowspan="2">위법조항</th>                                  ');
	stsHtml.append('				<th class="C" colspan="3">통계원표번호</th>                                       ');
	stsHtml.append('			</tr>                                                                           ');
	stsHtml.append('			<tr>                                                                            ');
	stsHtml.append('				<th class="C">발생</th>                                                       ');
	stsHtml.append('				<th class="C">검거</th>                                                       ');
	stsHtml.append('				<th class="C">피의</th>                                                       ');
	stsHtml.append('			</tr>                                                                           ');
	stsHtml.append('		</thead>                                                                            ');
	stsHtml.append('		<tbody>                                                                             ');
	var rctCd="";
	var rcptNum="";
	var incSpNum="";
	var spYN = true;
	var occArstYN = true;
	$.each(b0101VOMap.incSpVOList, function(i, incSpVO) {
		
		var incSpNmDec = incSpVO.spNm;
		
//		//법률 위법조항으로 정렬 (보기 편의성을 위해)
//		if(incSpVO.actVioVOList != null){
//			incSpVO.actVioVOList.sort(function(a,b){
//				return a.rltActCriNmCdDesc < b.rltActCriNmCdDesc ? -1 : a.rltActCriNmCdDesc > b.rltActCriNmCdDesc ? 1 : 0;
//			});
//		}

		if(i == 0){
			
			rctCd = incSpVO.rltActCriNmCd;
			rcptNum = incSpVO.incNum;
			incSpNum = incSpVO.incSpNum;
			spYN = true;
			occArstYN = true;
			
		}else if(rcptNum != incSpVO.incNum){
			
			rctCd = incSpVO.rltActCriNmCd;
			rcptNum = incSpVO.incNum;
			incSpNum = incSpVO.incSpNum;
			spYN = true;
			occArstYN = true;
			
		}else if(rcptNum == incSpVO.incNum){	
			
			if(rctCd != incSpVO.rltActCriNmCd){
				
				rctCd = incSpVO.rltActCriNmCd;
				spYN = true;
				occArstYN = true;
				if(incSpNum != incSpVO.incSpNum){
					incSpNum = incSpVO.incSpNum;
					spYN = true;
				}else if(incSpNum == incSpVO.incSpNum){
					spYN = false;
				}
				
				
			}else if(rctCd == incSpVO.rltActCriNmCd){
				
				spYN = true;
				occArstYN = false;
				
			}
		}
		
		stsHtml.append('			<tr>                                                                            ');
		stsHtml.append('				<td class="C">'+(i+1)+'</td>                                                        ');
		stsHtml.append('				<td class="C">'+incSpVO.incNum+'</td>                                                 ');
		stsHtml.append('				<td class="C">'+incSpNmDec+'</td>                                                      ');
			
		var spStsGrapVOTmp = null;		//피의자 통계원표 데이터
		var actVioCnt = 0;
		
		$.each(incSpVO.actVioVOList, function(j, ActVioVO) {
			
			var btnHtml_1 = new StringBuffer();		//'발생' 작성버튼
			var btnHtml_2 = new StringBuffer();		//'검거' 작성버튼
			var btnHtml_3 = new StringBuffer();		//'피의' 작성버튼
			
			if(actVioCnt != 0){
				stsHtml.append('				<tr>                                                      ');
			}
			
			stsHtml.append('				<td class="C">'+getParamValue(ActVioVO.rltActCriNmCdDesc)+'</td>                                                      ');
			
			var rltActHtml = new StringBuffer();
			$.each(ActVioVO.actVioClaVOList, function(k, ActVioClaVO) {
				if(k != 0){
					rltActHtml.append(" 및 ");
				}
				
				rltActHtml.append(ActVioClaVO.actVioClaNm);
			});
			
			//이름 디코딩한걸넣고 , .... 비교하자+ rltActCriNmCd 널값 
			
			//피의자 통계원표탭 노출여부
			//var isSpStsGrapView = rctYN;
			
			//개인일경우에만, 피의자통계원표 작성/수정 노출
//			if(incSpVO.indvCorpDiv == "1"){
				//마지막일때만, 피의자통계원표
			var isSpStsGrapView = true;
//				if(ActVioVO.spStsGrapVO != null){
					spStsGrapVOTmp = ActVioVO.spStsGrapVO;
//					isSpStsGrapView = true;
//					btnHtml_3.append("<a href=\"javascript:updateSpStsGrapView('"+spStsGrapVOTmp.incSpNum+"','"+spStsGrapVOTmp.actVioNum+"','"+spStsGrapVOTmp.rcptNum+"','"+spStsGrapVOTmp.rltActCriNmCd+"','"+spStsGrapVOTmp.rltActCriNmCdDesc+"','"+spStsGrapVOTmp.actVioClaNm+"','"+incSpNmDec+"',"+isSpStsGrapView+")\" class=\"btn_light_blue\" data-name=\"spStsGrapBtn\" data-rltactcrinmcd=\""+spStsGrapVOTmp.rltActCriNmCd+"\" data-spstsgrapnum=\""+spStsGrapVOTmp.spStsGrapNum+"\" data-incspnum=\""+spStsGrapVOTmp.incSpNum+"\" data-rcptnum=\""+spStsGrapVOTmp.rcptNum+"\" data-actvionum=\""+spStsGrapVOTmp.actVioNum+"\" data-always=\"y\"><span>수정</span></a>");
//				}
				
				//가장마지막의 법률 정보를 기본으로함 
//				if(incSpVO.actVioVOList.length == j+1){
					//피의자통계원표는 피의자별로 하나만,
					//작성한 피의자통계원표 데이터가 있으면, 
//			if(ActVioVO.spStsGrapVO != null){		//수정 
//				btnHtml_3.append("<a href=\"javascript:updateSpStsGrapView('"+spStsGrapVOTmp.incSpNum+"','"+spStsGrapVOTmp.actVioNum+"','"+spStsGrapVOTmp.rcptNum+"','"+spStsGrapVOTmp.rltActCriNmCd+"','"+spStsGrapVOTmp.rltActCriNmCdDesc+"','"+spStsGrapVOTmp.actVioClaNm+"','"+incSpNmDec+"',"+isSpStsGrapView+")\" class=\"btn_light_blue\" data-name=\"spStsGrapBtn\" data-rltactcrinmcd=\""+spStsGrapVOTmp.rltActCriNmCd+"\" data-spstsgrapnum=\""+spStsGrapVOTmp.spStsGrapNum+"\" data-incspnum=\""+spStsGrapVOTmp.incSpNum+"\" data-rcptnum=\""+spStsGrapVOTmp.rcptNum+"\" data-actvionum=\""+spStsGrapVOTmp.actVioNum+"\" data-always=\"y\"><span>수정</span></a>");
			//신규작성
//			}else{
//						isSpStsGrapView = true;
//				btnHtml_3.append("<a href=\"javascript:updateSpStsGrapView('"+ActVioVO.incSpNum+"','"+ActVioVO.actVioNum+"','"+ActVioVO.rcptNum+"','"+ActVioVO.rltActCriNmCd+"','"+ActVioVO.rltActCriNmCdDesc+"','"+rltActHtml+"','"+incSpNmDec+"',"+isSpStsGrapView+")\" class=\"btn_white\" data-name=\"spStsGrapBtn\" data-rltactcrinmcd=\""+ActVioVO.rltActCriNmCd+"\" data-spstsgrapnum=\"\" data-incspnum=\""+ActVioVO.incSpNum+"\" data-rcptnum=\""+incSpVO.rcptNum+"\" data-actvionum=\""+ActVioVO.actVioNum+"\"><span>작성</span></a>");
//			}
//				}
//			}
			if(spYN == true){
				//피의
				if(ActVioVO.spStsGrapVO != null){		//수정 
					btnHtml_3.append("<a href=\"javascript:updateSpStsGrapView('"+spStsGrapVOTmp.incSpNum+"','"+spStsGrapVOTmp.actVioNum+"','"+spStsGrapVOTmp.rcptNum+"','"+spStsGrapVOTmp.rltActCriNmCd+"','"+spStsGrapVOTmp.rltActCriNmCdDesc+"','"+spStsGrapVOTmp.actVioClaNm+"','"+incSpNmDec+"','"+spYN+"','"+occArstYN+"')\" class=\"btn_light_blue_line appointed\" data-name=\"spStsGrapBtn\" data-rltactcrinmcd=\""+spStsGrapVOTmp.rltActCriNmCd+"\" data-spstsgrapnum=\""+spStsGrapVOTmp.spStsGrapNum+"\" data-incspnum=\""+spStsGrapVOTmp.incSpNum+"\" data-rcptnum=\""+spStsGrapVOTmp.rcptNum+"\" data-actvionum=\""+spStsGrapVOTmp.actVioNum+"\" data-always=\"y\"><span>수정</span></a>");			
				}else{//신규작성
					btnHtml_3.append("<a href=\"javascript:updateSpStsGrapView('"+ActVioVO.incSpNum+"','"+ActVioVO.actVioNum+"','"+ActVioVO.rcptNum+"','"+ActVioVO.rltActCriNmCd+"','"+ActVioVO.rltActCriNmCdDesc+"','"+rltActHtml+"','"+incSpNmDec+"','"+spYN+"','"+occArstYN+"')\" class=\"btn_light_blue new2\" data-name=\"spStsGrapBtn\" data-rltactcrinmcd=\""+ActVioVO.rltActCriNmCd+"\" data-spstsgrapnum=\"\" data-incspnum=\""+ActVioVO.incSpNum+"\" data-rcptnum=\""+incSpVO.rcptNum+"\" data-actvionum=\""+ActVioVO.actVioNum+"\"><span>작성</span></a>");
				}
			}
			if(occArstYN == true){
				
				//작성한 발생통계원표 데이터가 있으면, 
				if(ActVioVO.occrStsGrapVO != null){		//수정 
					btnHtml_1.append("<a href=\"javascript:updateOccrStsGrapView('"+ActVioVO.incSpNum+"','"+ActVioVO.actVioNum+"','"+ActVioVO.rcptNum+"','"+ActVioVO.rltActCriNmCd+"','"+ActVioVO.rltActCriNmCdDesc+"','"+rltActHtml+"','"+incSpNmDec+"','"+spYN+"','"+occArstYN+"')\" class=\"btn_light_blue_line appointed\" data-name=\"occrStsGrapBtn\" data-rltactcrinmcd=\""+ActVioVO.rltActCriNmCd+"\" data-occrstsgrapnum=\""+ActVioVO.occrStsGrapVO.occrStsGrapNum+"\" data-incspnum=\""+ActVioVO.incSpNum+"\" data-rcptnum=\""+incSpVO.rcptNum+"\" data-actvionum=\""+ActVioVO.actVioNum+"\" data-always=\"y\"><span>수정</span></a>");
				}else{	//신규작성
					btnHtml_1.append("<a href=\"javascript:updateOccrStsGrapView('"+ActVioVO.incSpNum+"','"+ActVioVO.actVioNum+"','"+ActVioVO.rcptNum+"','"+ActVioVO.rltActCriNmCd+"','"+ActVioVO.rltActCriNmCdDesc+"','"+rltActHtml+"','"+incSpNmDec+"','"+spYN+"','"+occArstYN+"')\" class=\"btn_light_blue new2\" data-name=\"occrStsGrapBtn\" data-rltactcrinmcd=\""+ActVioVO.rltActCriNmCd+"\" data-occrstsgrapnum=\"\" data-incspnum=\""+ActVioVO.incSpNum+"\" data-rcptnum=\""+incSpVO.rcptNum+"\" data-actvionum=\""+ActVioVO.actVioNum+"\"><span>작성</span></a>");
				}
				
				
				//작성한 검거통계원표 데이터가 있으면, 
				if(ActVioVO.arstStsGrapVO != null){		//수정 
					btnHtml_2.append("<a href=\"javascript:updateArstStsGrapView('"+ActVioVO.incSpNum+"','"+ActVioVO.actVioNum+"','"+ActVioVO.rcptNum+"','"+ActVioVO.rltActCriNmCd+"','"+ActVioVO.rltActCriNmCdDesc+"','"+rltActHtml+"','"+incSpNmDec+"','"+spYN+"','"+occArstYN+"')\" class=\"btn_light_blue_line appointed\" data-name=\"arstStsGrapBtn\" data-rltactcrinmcd=\""+ActVioVO.rltActCriNmCd+"\" data-arststsgrapnum=\""+ActVioVO.arstStsGrapVO.arstStsGrapNum+"\" data-incspnum=\""+ActVioVO.incSpNum+"\" data-rcptnum=\""+incSpVO.rcptNum+"\" data-actvionum=\""+ActVioVO.actVioNum+"\" data-always=\"y\"><span>수정</span></a>");
				}else{
					btnHtml_2.append("<a href=\"javascript:updateArstStsGrapView('"+ActVioVO.incSpNum+"','"+ActVioVO.actVioNum+"','"+ActVioVO.rcptNum+"','"+ActVioVO.rltActCriNmCd+"','"+ActVioVO.rltActCriNmCdDesc+"','"+rltActHtml+"','"+incSpNmDec+"','"+spYN+"','"+occArstYN+"')\" class=\"btn_light_blue new2\" data-name=\"arstStsGrapBtn\" data-rltactcrinmcd=\""+ActVioVO.rltActCriNmCd+"\" data-arststsgrapnum=\"\" data-incspnum=\""+ActVioVO.incSpNum+"\" data-rcptnum=\""+incSpVO.rcptNum+"\" data-actvionum=\""+ActVioVO.actVioNum+"\"><span>작성</span></a>");
				}
			}
			
			stsHtml.append('				<td class="C">'+btnHtml_1+'</a></td>        ');
			stsHtml.append('				<td class="C">'+btnHtml_2+'</td>        ');
			stsHtml.append('				<td class="C">'+btnHtml_3+'</td>        ');
			stsHtml.append('				</tr>                                                      ');
			
			actVioCnt++;
			
		});
	});
	
	$("#tab_mini_m5_contents_listArea").html(stsHtml.toString());
	
	//유저와 상태에 따른 UI 처리 
	//handleUi();
	
	//화면사이즈 갱신
	autoResize();
}
//통계원표 리스트 
function selectStsGrapList2(){
	
	
	
	//피의자 사건번호로 정렬 (병합사건일경우 보기 편의성을 위해)
	if(b0101VOMap.incSpVOList != null){
		b0101VOMap.incSpVOList.sort(function(a,b){
			return a.rcptNum < b.rcptNum ? -1 : a.rcptNum > b.rcptNum ? 1 : 0;
		});
	}
	
	var stsHtml = new StringBuffer();		//통계원표 리스트 
	
	stsHtml.append('<div class="listArea">																		');
	stsHtml.append('	<table class="list" cellpadding="0" cellspacing="0">                                    ');
	stsHtml.append('		<colgroup>                                                                          ');
	stsHtml.append('			<col width="8%" />                                                              ');
	stsHtml.append('			<col width="20%" />                                                             ');
	stsHtml.append('			<col width="16%" />                                                             ');
	stsHtml.append('			<col width="*%" />                                                              ');
	stsHtml.append('			<col width="12%" />                                                             ');
	stsHtml.append('			<col width="12%" />                                                             ');
	stsHtml.append('			<col width="12%" />                                                             ');
	stsHtml.append('		</colgroup>                                                                         ');
	stsHtml.append('		<thead>                                                                             ');
	stsHtml.append('			<tr>                                                                            ');
	stsHtml.append('				<th class="C" rowspan="2"></th>                                            ');
	stsHtml.append('				<th class="C" rowspan="2">사건번호</th>                                         ');
	stsHtml.append('				<th class="C" rowspan="2">피의자</th>                                          ');
	stsHtml.append('				<th class="C r_line" rowspan="2">위법조항</th>                                  ');
	stsHtml.append('				<th class="C" colspan="3">통계원표번호</th>                                       ');
	stsHtml.append('			</tr>                                                                           ');
	stsHtml.append('			<tr>                                                                            ');
	stsHtml.append('				<th class="C">발생</th>                                                       ');
	stsHtml.append('				<th class="C">검거</th>                                                       ');
	stsHtml.append('				<th class="C">피의</th>                                                       ');
	stsHtml.append('			</tr>                                                                           ');
	stsHtml.append('		</thead>                                                                            ');
	stsHtml.append('		<tbody>                                                                             ');
	var rctCd="";
	var rctYN = true;
	$.each(b0101VOMap.incSpVOList, function(i, incSpVO) {
		
		var incSpNmDec = incSpVO.spNm;
		
//		//법률 위법조항으로 정렬 (보기 편의성을 위해)
//		if(incSpVO.actVioVOList != null){
//			incSpVO.actVioVOList.sort(function(a,b){
//				return a.rltActCriNmCdDesc < b.rltActCriNmCdDesc ? -1 : a.rltActCriNmCdDesc > b.rltActCriNmCdDesc ? 1 : 0;
//			});
//		}
		
		if(i == 0){
			
			rctCd = incSpVO.rltActCriNmCd;
			rcptNum = incSpVO.incNum;
			incSpNum = incSpVO.incSpNum;
			spYN = true;
			occArstYN = true;
			
		}else if(rcptNum != incSpVO.incNum){
			
			rctCd = incSpVO.rltActCriNmCd;
			rcptNum = incSpVO.incNum;
			incSpNum = incSpVO.incSpNum;
			spYN = true;
			occArstYN = true;
			
		}else if(rcptNum == incSpVO.incNum){	
			
			if(rctCd != incSpVO.rltActCriNmCd){
				
				rctCd = incSpVO.rltActCriNmCd;
				spYN = true;
				occArstYN = true;
				if(incSpNum != incSpVO.incSpNum){
					incSpNum = incSpVO.incSpNum;
					spYN = true;
				}else if(incSpNum == incSpVO.incSpNum){
					spYN = false;
				}
				
				
			}else if(rctCd == incSpVO.rltActCriNmCd){
				
				spYN = true;
				occArstYN = false;
				
			}
		}
		
		stsHtml.append('			<tr>                                                                            ');
		stsHtml.append('				<td class="C" rowspan="'+incSpVO.actVioVOList.length+'">'+(i+1)+'</td>                                                        ');
		stsHtml.append('				<td class="C" rowspan="'+incSpVO.actVioVOList.length+'">'+incSpVO.incNum+'</td>                                                 ');
		stsHtml.append('				<td class="C" rowspan="'+incSpVO.actVioVOList.length+'">'+incSpNmDec+'</td>                                                      ');
		
		var spStsGrapVOTmp = null;		//피의자 통계원표 데이터
		var actVioCnt = 0;
		
		$.each(incSpVO.actVioVOList, function(j, ActVioVO) {
			
			var btnHtml_1 = new StringBuffer();		//'발생' 작성버튼
			var btnHtml_2 = new StringBuffer();		//'검거' 작성버튼
			var btnHtml_3 = new StringBuffer();		//'피의' 작성버튼
			
			if(actVioCnt != 0){
				stsHtml.append('				<tr>                                                      ');
			}
			
			stsHtml.append('				<td class="C">'+getParamValue(ActVioVO.rltActCriNmCdDesc)+'</td>                                                      ');
			
			var rltActHtml = new StringBuffer();
			$.each(ActVioVO.actVioClaVOList, function(k, ActVioClaVO) {
				if(k != 0){
					rltActHtml.append(" 및 ");
				}
				
				rltActHtml.append(ActVioClaVO.actVioClaNm);
			});
			
			//이름 디코딩한걸넣고 , .... 비교하자+ rltActCriNmCd 널값 
			
			//피의자 통계원표탭 노출여부
			var isSpStsGrapView = rctYN;
			
			//개인일경우에만, 피의자통계원표 작성/수정 노출
//			if(incSpVO.indvCorpDiv == "1"){
			//마지막일때만, 피의자통계원표
			
//			if(ActVioVO.spStsGrapVO != null){
				spStsGrapVOTmp = ActVioVO.spStsGrapVO;
//					isSpStsGrapView = true;
//				btnHtml_3.append("<a href=\"javascript:updateSpStsGrapView('"+spStsGrapVOTmp.incSpNum+"','"+spStsGrapVOTmp.actVioNum+"','"+spStsGrapVOTmp.rcptNum+"','"+spStsGrapVOTmp.rltActCriNmCd+"','"+spStsGrapVOTmp.rltActCriNmCdDesc+"','"+spStsGrapVOTmp.actVioClaNm+"','"+incSpNmDec+"',"+isSpStsGrapView+")\" class=\"btn_light_blue\" data-name=\"spStsGrapBtn\" data-rltactcrinmcd=\""+spStsGrapVOTmp.rltActCriNmCd+"\" data-spstsgrapnum=\""+spStsGrapVOTmp.spStsGrapNum+"\" data-incspnum=\""+spStsGrapVOTmp.incSpNum+"\" data-rcptnum=\""+spStsGrapVOTmp.rcptNum+"\" data-actvionum=\""+spStsGrapVOTmp.actVioNum+"\" data-always=\"y\"><span>수정</span></a>");
//			}
			
			//가장마지막의 법률 정보를 기본으로함 
//				if(incSpVO.actVioVOList.length == j+1){
			//피의자통계원표는 피의자별로 하나만,
			//작성한 피의자통계원표 데이터가 있으면, 
//			if(spStsGrapVOTmp != null){		//수정 
			if(spYN == true){
				//피의
				if(ActVioVO.spStsGrapVO != null){		//수정 
					btnHtml_3.append("<a href=\"javascript:updateSpStsGrapView('"+spStsGrapVOTmp.incSpNum+"','"+spStsGrapVOTmp.actVioNum+"','"+spStsGrapVOTmp.rcptNum+"','"+spStsGrapVOTmp.rltActCriNmCd+"','"+spStsGrapVOTmp.rltActCriNmCdDesc+"','"+spStsGrapVOTmp.actVioClaNm+"','"+incSpNmDec+"','"+spYN+"','"+occArstYN+"')\" class=\"btn_light_blue_line appointed\" data-name=\"spStsGrapBtn\" data-rltactcrinmcd=\""+spStsGrapVOTmp.rltActCriNmCd+"\" data-spstsgrapnum=\""+spStsGrapVOTmp.spStsGrapNum+"\" data-incspnum=\""+spStsGrapVOTmp.incSpNum+"\" data-rcptnum=\""+spStsGrapVOTmp.rcptNum+"\" data-actvionum=\""+spStsGrapVOTmp.actVioNum+"\" data-always=\"y\"><span>수정</span></a>");			
				}else{//신규작성
					btnHtml_3.append("<a href=\"javascript:updateSpStsGrapView('"+ActVioVO.incSpNum+"','"+ActVioVO.actVioNum+"','"+ActVioVO.rcptNum+"','"+ActVioVO.rltActCriNmCd+"','"+ActVioVO.rltActCriNmCdDesc+"','"+rltActHtml+"','"+incSpNmDec+"','"+spYN+"','"+occArstYN+"')\" class=\"btn_light_blue new2\" data-name=\"spStsGrapBtn\" data-rltactcrinmcd=\""+ActVioVO.rltActCriNmCd+"\" data-spstsgrapnum=\"\" data-incspnum=\""+ActVioVO.incSpNum+"\" data-rcptnum=\""+incSpVO.rcptNum+"\" data-actvionum=\""+ActVioVO.actVioNum+"\"><span>작성</span></a>");
				}
			}
			if(occArstYN == true){
				
				//작성한 발생통계원표 데이터가 있으면, 
				if(ActVioVO.occrStsGrapVO != null){		//수정 
					btnHtml_1.append("<a href=\"javascript:updateOccrStsGrapView('"+ActVioVO.incSpNum+"','"+ActVioVO.actVioNum+"','"+ActVioVO.rcptNum+"','"+ActVioVO.rltActCriNmCd+"','"+ActVioVO.rltActCriNmCdDesc+"','"+rltActHtml+"','"+incSpNmDec+"','"+spYN+"','"+occArstYN+"')\" class=\"btn_light_blue_line appointed\" data-name=\"occrStsGrapBtn\" data-rltactcrinmcd=\""+ActVioVO.rltActCriNmCd+"\" data-occrstsgrapnum=\""+ActVioVO.occrStsGrapVO.occrStsGrapNum+"\" data-incspnum=\""+ActVioVO.incSpNum+"\" data-rcptnum=\""+incSpVO.rcptNum+"\" data-actvionum=\""+ActVioVO.actVioNum+"\" data-always=\"y\"><span>수정</span></a>");
				}else{	//신규작성
					btnHtml_1.append("<a href=\"javascript:updateOccrStsGrapView('"+ActVioVO.incSpNum+"','"+ActVioVO.actVioNum+"','"+ActVioVO.rcptNum+"','"+ActVioVO.rltActCriNmCd+"','"+ActVioVO.rltActCriNmCdDesc+"','"+rltActHtml+"','"+incSpNmDec+"','"+spYN+"','"+occArstYN+"')\" class=\"btn_light_blue new2\" data-name=\"occrStsGrapBtn\" data-rltactcrinmcd=\""+ActVioVO.rltActCriNmCd+"\" data-occrstsgrapnum=\"\" data-incspnum=\""+ActVioVO.incSpNum+"\" data-rcptnum=\""+incSpVO.rcptNum+"\" data-actvionum=\""+ActVioVO.actVioNum+"\"><span>작성</span></a>");
				}
				
				
				//작성한 검거통계원표 데이터가 있으면, 
				if(ActVioVO.arstStsGrapVO != null){		//수정 
					btnHtml_2.append("<a href=\"javascript:updateArstStsGrapView('"+ActVioVO.incSpNum+"','"+ActVioVO.actVioNum+"','"+ActVioVO.rcptNum+"','"+ActVioVO.rltActCriNmCd+"','"+ActVioVO.rltActCriNmCdDesc+"','"+rltActHtml+"','"+incSpNmDec+"','"+spYN+"','"+occArstYN+"')\" class=\"btn_light_blue_line appointed\" data-name=\"arstStsGrapBtn\" data-rltactcrinmcd=\""+ActVioVO.rltActCriNmCd+"\" data-arststsgrapnum=\""+ActVioVO.arstStsGrapVO.arstStsGrapNum+"\" data-incspnum=\""+ActVioVO.incSpNum+"\" data-rcptnum=\""+incSpVO.rcptNum+"\" data-actvionum=\""+ActVioVO.actVioNum+"\" data-always=\"y\"><span>수정</span></a>");
				}else{
					btnHtml_2.append("<a href=\"javascript:updateArstStsGrapView('"+ActVioVO.incSpNum+"','"+ActVioVO.actVioNum+"','"+ActVioVO.rcptNum+"','"+ActVioVO.rltActCriNmCd+"','"+ActVioVO.rltActCriNmCdDesc+"','"+rltActHtml+"','"+incSpNmDec+"','"+spYN+"','"+occArstYN+"')\" class=\"btn_light_blue new2\" data-name=\"arstStsGrapBtn\" data-rltactcrinmcd=\""+ActVioVO.rltActCriNmCd+"\" data-arststsgrapnum=\"\" data-incspnum=\""+ActVioVO.incSpNum+"\" data-rcptnum=\""+incSpVO.rcptNum+"\" data-actvionum=\""+ActVioVO.actVioNum+"\"><span>작성</span></a>");
				}
			}
			
			stsHtml.append('				<td class="C">'+btnHtml_1+'</a></td>        ');
			stsHtml.append('				<td class="C">'+btnHtml_2+'</td>        ');
			stsHtml.append('				<td class="C">'+btnHtml_3+'</td>        ');
			stsHtml.append('				</tr>                                                      ');
			
			actVioCnt++;
			
		});
	});
	
	$("#tab_mini_m5_contents_listArea").html(stsHtml.toString());
	
	//유저와 상태에 따른 UI 처리 
	handleUi();
	
	//화면사이즈 갱신
	autoResize();
}

//'발생' 통계원표 등록, 수정 화면 노출
function updateOccrStsGrapView(incSpNum, actVioNum, rcptNum, rltActCriNmCd, rltActCriNmCdDesc, actVioClaNm, incSpNmDec, spYN, occArstYN){
//function updateOccrStsGrapView(incSpNum, actVioNum){
	//수현 - 피의자 필수정보 입력시에만 통계원표 작성 가능 
	var spChk = "Y";
	if(b0101VOMap.criStatCd == "57" || b0101VOMap.criStatCd == "67"){
		$.each(b0101VOMap.incSpVOList, function(i, incSpVO) {
			var idNumlen = (incSpVO.spIdNum).length;
			var spNm = incSpVO.spNm;
			var spAddr = incSpVO.spAddr;
			var incCont = b0101VOMap.incCont;
			if(spNm.indexOf("성명불상") != -1 || spNm.indexOf("성명 불상") != -1){
				
			}else{
				if( idNumlen != 14 ||spNm == ""|| spNm == " " || spNm == null ||spAddr == "" ||spAddr == " " ||spAddr == null||incCont == " " ||incCont == null){
					spChk = "N";
				}
			}
			$.each(incSpVO.actVioVOList,function(i,actVioVO){
				if(!actVioVO.actVioClaVOList || actVioVO.actVioClaVOList.length == 0){
					spChk = "N";
				}else{
					if(!actVioVO.actVioClaVOList|| actVioVO.actVioClaVOList.length == 0){
						spChk = "N";
					}else{
						var rltActCriNmCdYN = actVioVO.rltActCriNmCd;
						var actVioClaNmYN = actVioVO.actVioClaVOList[0].actVioClaNm;
						var vioContYN = actVioVO.vioCont;
						if( actVioClaNmYN == null || actVioClaNmYN == ""||vioContYN == null||vioContYN ==  ""||rltActCriNmCdYN == null||rltActCriNmCdYN ==  "" ){
							spChk = "N";
						}
					}
				}
			});
	
		});
	}
	if(spChk == "N"){
		alert("피의자의 성명, 주민등록번호, 주소, 위반법률, 위반조항, 위반내용을 입력하셔야 통계원표 입력이 가능합니다.");
		return;
	}
	if(spChk == "Y"){
		if(!checkStsRequired(incSpNmDec, rltActCriNmCd)){
			return;
		}
		
		var reqMap = {
				incSpNum : incSpNum
				,actVioNum : actVioNum
			}
		
		goAjaxDefault("/sjpb/B/selectOccrStsGrap.face", reqMap,  function(data){callBackUpdateOccrStsGrapViewSuccess(data, incSpNum, actVioNum, rcptNum, rltActCriNmCd, rltActCriNmCdDesc, actVioClaNm, incSpNmDec, spYN, occArstYN)});
	}
}

//'발생' 통계원표 등록, 수정 화면 노출 성공함수
function callBackUpdateOccrStsGrapViewSuccess(data, incSpNum, actVioNum, rcptNum, rltActCriNmCd, rltActCriNmCdDesc, actVioClaNm, incSpNmDec, spYN, occArstYN){
	
	//통계원표 공통맵 초기화(사건번호)
	initB0102VOMap();
	
	//'발생' 통계원표 가져오기 
	occrStsGrapVOMap = data.occrStsGrapVO;
	
	//'피의자' 통계원표 탭 노출 여부 
	setSpStsGrapTabView(spYN, occArstYN);
	
	//사건번호셋팅
	b0102VOMap.incNum = data.incNum;
	
	if(occrStsGrapVOMap == null){	//신규 
		
		//신규등록화면 노출
		insertOccrStsGrapView(incSpNum, rcptNum, actVioNum, rltActCriNmCd, rltActCriNmCdDesc, actVioClaNm, incSpNmDec, spYN, occArstYN);
		
	}else{	//수정
		
		//통계원표 영역 초기화 
		initStsGrap("2");
		
		//sub 탭 링크 셋팅 
		setStsGrapSubTabLink(incSpNum, rcptNum, actVioNum, rltActCriNmCd, rltActCriNmCdDesc, actVioClaNm, incSpNmDec, spYN, occArstYN);
		
		//발생통계원표 데이터셋팅(Map -> 화면)
		setOccrStsGrapArea(occrStsGrapVOMap);
		
		//이벤트바인딩 (selectbox)
		setTargetDefaultEvent( $("#tab_small_m1_contents .m1") );
		
		//탭선택
		stsContentsView("m1");	//발생통계원표 선택
		
		//화면사이즈 갱신
		autoResize();
	}
}


//발생통계원표 데이터셋팅(Map -> 화면)
function setOccrStsGrapArea(occrStsGrapVO){
	
	//필드 셋팅
	setFieldValue($("#occr_rltActCriNmCd"), occrStsGrapVO.rltActCriNmCd);			//죄명코드
	setFieldValue($("#occr_rltActCriNmCdDesc"), occrStsGrapVO.rltActCriNmCdDesc);	//죄명
	setFieldValue($("#occr_actVioClaNm"), occrStsGrapVO.actVioClaNm);				//죄명 sub
	
	setFieldValue($("input[name=occr_occrStsGrapNum]"), occrStsGrapVO.occrStsGrapNum);	//발생통계원표번호
	setFieldValue($("input[name=occr_stsGrapPublYrmh]"), occrStsGrapVO.stsGrapPublYrmh);	//통계원표발행년월
	setFieldValue($("input[name=occr_famyVioYnCd]"), occrStsGrapVO.famyVioYnCd);	//가정폭력유무
	setFieldValue($("input[name=occr_schlVioYnCd]"), occrStsGrapVO.schlVioYnCd);	//학교폭력유무
	setFieldValue($("input[name=occr_forgSpYnCd]"), occrStsGrapVO.forgSpYnCd);	//외국인피의자유무
	setFieldValue($("input[name=occr_occrYrmhDtDivCd]"), occrStsGrapVO.occrYrmhDtDivCd);	//발생년월일시구분코드
	
	
	var occrYrmhDtYear = isNull(occrStsGrapVO.occrYrmhDt) ? "" : occrStsGrapVO.occrYrmhDt.substring(0,4);
	var occrYrmhDtMonth = isNull(occrStsGrapVO.occrYrmhDt) ? "" : occrStsGrapVO.occrYrmhDt.substring(4,6);
	var occrYrmhDtDay = isNull(occrStsGrapVO.occrYrmhDt) ? "" : occrStsGrapVO.occrYrmhDt.substring(6,8);
	var occrYrmhDtTime = isNull(occrStsGrapVO.occrYrmhDt) ? "" : occrStsGrapVO.occrYrmhDt.substring(8,10);
	
	//발생 년, 월, 일, 시간 셋팅
	appendYear( $("select[name=occr_occrYrmhDt_year]"), occrYrmhDtYear );
	appendMonth( $("select[name=occr_occrYrmhDt_month]"), occrYrmhDtMonth );
	appendDay( $("select[name=occr_occrYrmhDt_day]"), occrYrmhDtDay );
	appendTime( $("select[name=occr_occrYrmhDt_time]"), occrYrmhDtTime );
	
	
	var recgYrmhDtYear = isNull(occrStsGrapVO.recgYrmhDt) ? "" : occrStsGrapVO.recgYrmhDt.substring(0,4);
	var recgYrmhDtMonth = isNull(occrStsGrapVO.recgYrmhDt) ? "" : occrStsGrapVO.recgYrmhDt.substring(4,6);
	var recgYrmhDtDay = isNull(occrStsGrapVO.recgYrmhDt) ? "" : occrStsGrapVO.recgYrmhDt.substring(6,8);
	var recgYrmhDtTime = isNull(occrStsGrapVO.recgYrmhDt) ? "" : occrStsGrapVO.recgYrmhDt.substring(8,10);
	
	//인지 년, 월, 일, 시간 셋팅
	appendYear( $("select[name=occr_recgYrmhDt_year]"), recgYrmhDtYear );
	appendMonth( $("select[name=occr_recgYrmhDt_month]"), recgYrmhDtMonth );
	appendDay( $("select[name=occr_recgYrmhDt_day]"), recgYrmhDtDay );
	appendTime( $("select[name=occr_recgYrmhDt_time]"), recgYrmhDtTime );
	
	setFieldValue($("#occr_occrYrmhDt_sub"), isNull(occrStsGrapVO.occrDotw) ? "시경" : "시경 ("+occrStsGrapVO.occrDotw+"요일)");
	setFieldValue($("input[name=occr_occrYrmhDtDotw]"), occrStsGrapVO.occrDotw);					//발생요일
	setFieldValue($("#occr_recgYrmhDt_sub"), isNull(occrStsGrapVO.recgDotw) ? "시" : "시 ("+occrStsGrapVO.recgDotw+"요일)");	
	setFieldValue($("input[name=occr_recgYrmhDtDotw]"), occrStsGrapVO.recgDotw);					//인지요일
	setFieldValue($("select[name=occr_occrToRecgPi]"), occrStsGrapVO.occrToRecgPi);		//발생부터인지까지기간
	setFieldValue($("select[name=occr_criMeth]"), occrStsGrapVO.criMeth);					//범죄수법
	setFieldValue($("select[name=occr_occrDtSpelSitu]"), occrStsGrapVO.occrDtSpelSitu);	//발생일특수사정
	setFieldValue($("select[name=occr_criTimeWeth]"), occrStsGrapVO.criTimeWeth);			//범행시일기
	setFieldValue($("select[name=occr_criClue]"), occrStsGrapVO.criClue);					//수사단서
	setFieldValue($("select[name=occr_undcRsn]"), occrStsGrapVO.undcRsn);					//미신고이유
	setFieldValue($("input[name=occr_vicm]"), occrStsGrapVO.vicm);								//피해자
	setFieldValue($("input[name=occr_ageDivCd]"), occrStsGrapVO.ageDivCd);						//연령구분코드
	setFieldValue($("input[name=occr_age]"), occrStsGrapVO.age);									//연령
	setFieldValue($("input[name=occr_forgCdNaty]"), occrStsGrapVO.forgCdNaty);					//외국인코드국적
	setFieldValue($("input[name=occr_forgCdPosi]"), occrStsGrapVO.forgCdPosi);					//외국인코드신분
	setFieldValue($("select[name=occr_vicmDamgTimeSitu]"), occrStsGrapVO.vicmDamgTimeSitu);//피해자피해시상황
	setFieldValue($("select[name=occr_occrAreaDiv]"), occrStsGrapVO.occrAreaDiv);			//발생지구분
	
	$("select[name=occr_occrAreaDiv]").trigger("change");	//발생지 select 구성 
	setFieldValue($("select[name=occr_occrArea]"), occrStsGrapVO.occrArea);				//발생지
	setFieldValue($("select[name=occr_occrPla]"), occrStsGrapVO.occrPla);					//발생장소
	setFieldValue($("select[name=occr_propDamgDegr]"), occrStsGrapVO.propDamgDegr);		//재산피해정도
	
	setFieldValue($("input[name=occr_damgAmtMony]"), occrStsGrapVO.damgAmtMony);						//피해액화폐
	setFieldValue($("input[name=occr_damgAmtCar]"), occrStsGrapVO.damgAmtCar);						//피해액자동차
	setFieldValue($("input[name=occr_damgAmtMarkSecu]"), occrStsGrapVO.damgAmtMarkSecu);				//피해액유가증권
	setFieldValue($("input[name=occr_damgAmtJewy]"), occrStsGrapVO.damgAmtJewy);						//피해액귀금속
	setFieldValue($("input[name=occr_damgAmtElecElenProd]"), occrStsGrapVO.damgAmtElecElenProd);		//피해액전기전자제품
	setFieldValue($("input[name=occr_damgAmtMocyBike]"), occrStsGrapVO.damgAmtMocyBike);				//피해액오토바이자전거
	setFieldValue($("input[name=occr_damgAmtFurnArtc]"), occrStsGrapVO.damgAmtFurnArtc);				//피해액가구류
	setFieldValue($("input[name=occr_damgAmtClot]"), occrStsGrapVO.damgAmtClot);						//피해액의류
	setFieldValue($("input[name=occr_damgAmtMach]"), occrStsGrapVO.damgAmtMach);						//피해액기계류
	setFieldValue($("input[name=occr_damgAmtFarmFortProd]"), occrStsGrapVO.damgAmtFarmFortProd);		//피해액농임산물
	setFieldValue($("input[name=occr_damgAmtAmhbProd]"), occrStsGrapVO.damgAmtAmhbProd);				//피해액축산물
	setFieldValue($("input[name=occr_damgAmtMarnProd]"), occrStsGrapVO.damgAmtMarnProd);				//피해액수산물
	setFieldValue($("input[name=occr_damgAmtMcgd]"), occrStsGrapVO.damgAmtMcgd);						//피해액잡화
	setFieldValue($("input[name=occr_damgAmtEtc]"), occrStsGrapVO.damgAmtEtc);						//피해액기타
	setFieldValue($("#occr_damgAmtTot"), occrStsGrapVO.damgAmtTot);									//피해액합계
	
	setFieldValue($("input[name=occr_bodyDamgZero]"), occrStsGrapVO.bodyDamgZero);			//신체피해무
	setFieldValue($("input[name=occr_bodyDamgInjy]"), occrStsGrapVO.bodyDamgInjy);			//신체피해상해
	setFieldValue($("input[name=occr_bodyDamgDeth]"), occrStsGrapVO.bodyDamgDeth);			//신체피해사망
	setFieldValue($("input[name=occr_bodyDamgInjyMan]"), occrStsGrapVO.bodyDamgInjyMan);		//신체피해상해남자
	setFieldValue($("input[name=occr_bodyDamgInjyWomn]"), occrStsGrapVO.bodyDamgInjyWomn);	//신체피해상해여자
	setFieldValue($("input[name=occr_bodyDamgDethMan]"), occrStsGrapVO.bodyDamgDethMan);		//신체피해사망남자
	setFieldValue($("input[name=occr_bodyDamgDethWomn]"), occrStsGrapVO.bodyDamgDethWomn);	//신체피해사망여자
	setFieldValue($("select[name=occr_bodyDamgInjyDegr]"), occrStsGrapVO.bodyDamgInjyDegr);	//신체피해상해정도
	
	setFieldValue($("input[name=occr_incSpNum]"), occrStsGrapVO.incSpNum);			//사건피의자번호
	setFieldValue($("input[name=occr_rcptNum]"), occrStsGrapVO.rcptNum);				//사건접수번호
	setFieldValue($("input[name=occr_actVioNum]"), occrStsGrapVO.actVioNum);			//법률위반번호
	
	
	$("#StsIncrcptNum1").html(b0102VOMap.incNum);
}

//검거통계원표 데이터셋팅(Map -> 화면)
function setArstStsGrapArea(arstStsGrapVO){
	
	//필드 셋팅
	setFieldValue($("input[name=arst_rcptNum]"), arstStsGrapVO.rcptNum);				//사건접수번호
	setFieldValue($("#arst_rltActCriNmCd"), arstStsGrapVO.rltActCriNmCd);			//죄명코드
	setFieldValue($("#arst_rltActCriNmCdDesc"), arstStsGrapVO.rltActCriNmCdDesc);	//죄명
	setFieldValue($("#arst_actVioClaNm"), arstStsGrapVO.actVioClaNm);				//죄명 sub
	
	setFieldValue($("input[name=arst_arstStsGrapNum]"), arstStsGrapVO.arstStsGrapNum);	//검거통계원표번호
	setFieldValue($("input[name=arst_stsGrapPublYrmh]"), arstStsGrapVO.stsGrapPublYrmh);	//통계원표발행년월
	
	setFieldValue($("input[name=arst_incSpNum]"), arstStsGrapVO.incSpNum);	//사건피의자번호
	setFieldValue($("input[name=arst_actVioNum]"), arstStsGrapVO.actVioNum);	//법률위반번호
	setFieldValue($("input[name=arst_famyVioYn]"), arstStsGrapVO.famyVioYn);	//가정폭력유무
	setFieldValue($("input[name=arst_schlVioYn]"), arstStsGrapVO.schlVioYn);	//학교폭력유무
	
	var arstYearMontDtYear = isNull(arstStsGrapVO.arstYearMontDt) ? "" : arstStsGrapVO.arstYearMontDt.substring(0,4);
	var arstYearMontDtMonth = isNull(arstStsGrapVO.arstYearMontDt) ? "" : arstStsGrapVO.arstYearMontDt.substring(4,6);
	var arstYearMontDtDay = isNull(arstStsGrapVO.arstYearMontDt) ? "" : arstStsGrapVO.arstYearMontDt.substring(6,8);
	
	//검거 년, 월, 일 셋팅
	appendYear( $("select[name=arst_arstYearMontDt_year]"), arstYearMontDtYear );
	appendMonth( $("select[name=arst_arstYearMontDt_month]"), arstYearMontDtMonth );
	appendDay( $("select[name=arst_arstYearMontDt_day]"), arstYearMontDtDay );
	
	var occrYearMontDtYear = isNull(arstStsGrapVO.occrYearMontDt) ? "" : arstStsGrapVO.occrYearMontDt.substring(0,4);
	var occrYearMontDtMonth = isNull(arstStsGrapVO.occrYearMontDt) ? "" : arstStsGrapVO.occrYearMontDt.substring(4,6);
	var occrYearMontDtDay = isNull(arstStsGrapVO.occrYearMontDt) ? "" : arstStsGrapVO.occrYearMontDt.substring(6,8);
	
	//발생 년, 월, 일 셋팅
	appendYear( $("select[name=arst_occrYearMontDt_year]"), occrYearMontDtYear );
	appendMonth( $("select[name=arst_occrYearMontDt_month]"), occrYearMontDtMonth );
	appendDay( $("select[name=arst_occrYearMontDt_day]"), occrYearMontDtDay );
	
	setFieldValue($("select[name=arst_occrToArstPi]"), arstStsGrapVO.occrToArstPi);		//발생부터 검거까지 기간
	setFieldValue($("select[name=arst_criMeth]"), arstStsGrapVO.criMeth);				//범죄수법
	setFieldValue($("select[name=arst_trpsEnty]"), arstStsGrapVO.trpsEnty);				//침입구
	setFieldValue($("select[name=arst_trpsWay]"), arstStsGrapVO.trpsWay);				//침입방법
	setFieldValue($("input[name=arst_arstKornMan]"), arstStsGrapVO.arstKornMan);			//검거한국인남자
	setFieldValue($("input[name=arst_arstKornWomn]"), arstStsGrapVO.arstKornWomn);		//검거한국인여자
	setFieldValue($("input[name=arst_arstKornCorp]"), arstStsGrapVO.arstKornCorp);		//검거한국인법인
	setFieldValue($("input[name=arst_arstForgMan]"), arstStsGrapVO.arstForgMan);			//검거외국인남자
	setFieldValue($("input[name=arst_arstForgWomn]"), arstStsGrapVO.arstForgWomn);		//검거외국인여자
	setFieldValue($("input[name=arst_arstForgCorp]"), arstStsGrapVO.arstForgCorp);		//검거외국인법인
	setFieldValue($("select[name=arst_cmtdUnctClsf]"), arstStsGrapVO.cmtdUnctClsf);		//기수,미수별
	setFieldValue($("select[name=arst_acmpNum]"), arstStsGrapVO.acmpNum);				//공범수
	
	setFieldValue($("select[name=arst_criToolType]"), arstStsGrapVO.criToolType);				//범행도구 종류
	setFieldValue($("select[name=arst_criToolActn]"), arstStsGrapVO.criToolActn);				//범행도구조치
	setFieldValue($("select[name=arst_criToolAcqrWay]"), arstStsGrapVO.criToolAcqrWay);			//범행도구 입수방법
	setFieldValue($("select[name=arst_arstClue]"), arstStsGrapVO.arstClue);						//검거단서
	setFieldValue($("select[name=arst_stgdDipWay]"), arstStsGrapVO.stgdDipWay);					//장물 처분방법
	setFieldValue($("select[name=arst_stgdMonyCospUse]"), arstStsGrapVO.stgdMonyCospUse);		//금전소비 용도
	setFieldValue($("input[name=arst_collAmtMony]"), arstStsGrapVO.collAmtMony);					//회수액화폐
	setFieldValue($("input[name=arst_collAmtCar]"), arstStsGrapVO.collAmtCar);					//회수액자동차
	setFieldValue($("input[name=arst_collAmtMarkSecu]"), arstStsGrapVO.collAmtMarkSecu);			//회수액유가증권
	setFieldValue($("input[name=arst_collAmtJewy]"), arstStsGrapVO.collAmtJewy);					//회수액귀금속
	setFieldValue($("input[name=arst_collAmtElecElenProd]"), arstStsGrapVO.collAmtElecElenProd);	//회수액전기전자제품
	setFieldValue($("input[name=arst_collAmtMocyBike]"), arstStsGrapVO.collAmtMocyBike);			//회수액오토바이자전거
	setFieldValue($("input[name=arst_collAmtFurnArtc]"), arstStsGrapVO.collAmtFurnArtc);			//회수액가구류
	setFieldValue($("input[name=arst_collAmtClot]"), arstStsGrapVO.collAmtClot);					//회수액의류
	setFieldValue($("input[name=arst_collAmtMach]"), arstStsGrapVO.collAmtMach);					//회수액기계류
	setFieldValue($("input[name=arst_collAmtFarmFortProd]"), arstStsGrapVO.collAmtFarmFortProd);	//회수액농임산물
	setFieldValue($("input[name=arst_collAmtAmhbProd]"), arstStsGrapVO.collAmtAmhbProd);			//회수액축산물
	setFieldValue($("input[name=arst_collAmtMarnProd]"), arstStsGrapVO.collAmtMarnProd);			//회수액수산물
	setFieldValue($("input[name=arst_collAmtMcgd]"), arstStsGrapVO.collAmtMcgd);					//회수액잡화
	setFieldValue($("input[name=arst_collAmtEtc]"), arstStsGrapVO.collAmtEtc);					//회수액기타
	setFieldValue($("#arst_collAmtTot"), arstStsGrapVO.collAmtTot);					//회수액합계
	setFieldValue($("select[name=arst_collDegrCd]"), arstStsGrapVO.collDegrCd);					//회수정도
	$("#StsIncrcptNum2").html(b0102VOMap.incNum);
}

//피의자통계원표 데이터셋팅(Map -> 화면)
function setSpStsGrapArea(spStsGrapVO){
	
	//필드 셋팅
	setFieldValue($("input[name=sp_rcptNum]"), spStsGrapVO.rcptNum);		//사건접수번호
	setFieldValue($("input[name=sp_incSpNum]"), spStsGrapVO.incSpNum);	//사건피의자번호
	
	//죄명 SELECT BOX 셋팅 S
	var actVioHtml = new StringBuffer();
	$.each(incSpVOGrapMap.actVioVOList, function(i, actVioVO) {
		if(actVioVO.actVioNum == spStsGrapVO.actVioNum){
			actVioHtml.append('<option value="'+actVioVO.actVioNum+'" data-rltactcrinmcd="'+actVioVO.rltActCriNmCd+'" data-actvioclanm="'+actVioVO.actVioClaNm+'" selected="selected">'+actVioVO.rltActCriNmCdDesc+'</option>');
		}else{
			actVioHtml.append('<option value="'+actVioVO.actVioNum+'" data-rltactcrinmcd="'+actVioVO.rltActCriNmCd+'" data-actvioclanm="'+actVioVO.actVioClaNm+'">'+actVioVO.rltActCriNmCdDesc+'</option>');
		}
	});
	$("select[name=sp_rltActCriNmCdDesc]").html(actVioHtml.toString());
	setTargetDefaultEvent($("select[name=sp_rltActCriNmCdDesc]"));
	$("select[name=sp_rltActCriNmCdDesc]").trigger("change");
	//죄명 SELECT BOX 셋팅 E
	
	//죄명선택에 따라 죄명코드, 죄명, 죄명sub, 법률위반번호는 바귀어야함 S
	//setFieldValue($("#sp_rltActCriNmCd"), spStsGrapVO.rltActCriNmCd);			//죄명코드
	//setFieldValue($("#sp_rltActCriNmCdDesc"), spStsGrapVO.rltActCriNmCdDesc);	//죄명
	//setFieldValue($("#sp_actVioClaNm"), spStsGrapVO.actVioClaNm);				//죄명 sub
	//setFieldValue($("input[name=sp_actVioNum]"), spStsGrapVO.actVioNum);	//법률위반번호
	//죄명선택에 따라 죄명코드, 죄명, 죄명sub, 법률위반번호는 바귀어야함 E
	
	setFieldValue($("input[name=sp_spStsGrapNum]"), spStsGrapVO.spStsGrapNum);	//피의자통계원표번호
	setFieldValue($("input[name=sp_stsGrapPublYrmh]"), spStsGrapVO.stsGrapPublYrmh);	//통계원표발행년월
	
	//피의자정보
	setFieldValue($("#sp_spNm"), incSpVOGrapMap.spNm);				//피의자이름
	setFieldValue($("#sp_spIdNum"), incSpVOGrapMap.spIdNum);		//피의자식별번호
	setFieldValue($("input[name=sp_gendDiv]"), incSpVOGrapMap.gendDiv);		//피의자성별
	
	setFieldValue($("input[name=sp_famyVioYn]"), spStsGrapVO.famyVioYn);		//가정폭력유무
	setFieldValue($("input[name=sp_schlVioYn]"), spStsGrapVO.schlVioYn);		//학교폭력유무
	setFieldValue($("input[name=sp_forgCdNaty]"), spStsGrapVO.forgCdNaty);	//외국인코드국적
	setFieldValue($("input[name=sp_forgCdPosi]"), spStsGrapVO.forgCdPosi);	//외국인코드신분
	setFieldValue($("input[name=sp_criTimeAge]"), spStsGrapVO.criTimeAge);	//범행시연령
	
	setFieldValue($("select[name=sp_jobCd]"), spStsGrapVO.jobCd);			//직업코드
	setFieldValue($("input[name=sp_puofBelgCd]"), spStsGrapVO.puofBelgCd);	//공무원소속코드
	setFieldValue($("input[name=sp_puofClasCd]"), spStsGrapVO.puofClasCd);						//공무원계급코드
	setFieldValue($("input[name=sp_puofDutyRelv]"), spStsGrapVO.puofDutyRelv);					//공무원직무관련성
	setFieldValue($("select[name=sp_crrdCd]"), spStsGrapVO.crrdCd);								//전과코드
	setFieldValue($("select[name=sp_secvSituLastDipCont]"), spStsGrapVO.secvSituLastDipCont);	//재범상황전회처분내용
	setFieldValue($("select[name=sp_secvSituProtDip]"), spStsGrapVO.secvSituProtDip);			//재범상황보호처분
	setFieldValue($("select[name=sp_secvSituSecvPi]"), spStsGrapVO.secvSituSecvPi);				//재범상황재범기간
	setFieldValue($("select[name=sp_secvSituSecvType]"), spStsGrapVO.secvSituSecvType);			//재범상황재범종류
	setFieldValue($("select[name=sp_acmpRelt]"), spStsGrapVO.acmpRelt);						//공범관계
	setFieldValue($("select[name=sp_vicmRelt]"), spStsGrapVO.vicmRelt);						//피해자와의관계
	setFieldValue($("select[name=sp_criAftrHdot]"), spStsGrapVO.criAftrHdot);				//범행후은신처
	setFieldValue($("select[name=sp_drugCmusYn]"), spStsGrapVO.drugCmusYn);					//마약류등상용여부
	setFieldValue($("select[name=sp_criTimeMindStat]"), spStsGrapVO.criTimeMindStat);		//범행시정신상태
	setFieldValue($("select[name=sp_criMotv]"), spStsGrapVO.criMotv);			//범행동기
	setFieldValue($("select[name=sp_acab]"), spStsGrapVO.acab);					//학력
	setFieldValue($("select[name=sp_livgDegr]"), spStsGrapVO.livgDegr);			//생활정도
	setFieldValue($("select[name=sp_relg]"), spStsGrapVO.relg);					//종교
	setFieldValue($("select[name=sp_margRelt]"), spStsGrapVO.margRelt);			//혼인관계
	setFieldValue($("select[name=sp_pareRelt]"), spStsGrapVO.pareRelt);			//부모관계
	setFieldValue($("select[name=sp_arstPolf]"), spStsGrapVO.arstPolf);			//검거자(경찰)
	setFieldValue($("select[name=sp_actn]"), spStsGrapVO.actn);					//조치
	setFieldValue($("select[name=sp_confYn]"), spStsGrapVO.confYn);				//자백여부
	setFieldValue($("select[name=sp_arrtClsf]"), spStsGrapVO.arrtClsf);			//구속별
	setFieldValue($("select[name=sp_nonArrtClsf]"), spStsGrapVO.nonArrtClsf);	//불구속별
	setFieldValue($("select[name=sp_trfOp]"), spStsGrapVO.trfOp);				//송치의견
	setFieldValue($("select[name=sp_incHandPi]"), spStsGrapVO.incHandPi);		//사건처리기간
	
	$("#StsIncrcptNum3").html(b0102VOMap.incNum);
	
}


//통계원표 탭 선택 화면 노출
function stsContentsView(type){
	//type : m1(발생), m2(검거), m3(피의자)
	$("#tab_small_m1_contents").attr("class","tab_small "+type); //통계원표 선택
	$("#tab_small_m1_contents").show();
	
	//화면사이즈 갱신
	autoResize();
}

//'발생' 통계원표 작성 화면노출
function insertOccrStsGrapView(incSpNum, rcptNum, actVioNum, rltActCriNmCd, rltActCriNmCdDesc, actVioClaNm, incSpNmDec, spYn, occArstYn){
	//incSpNum	: 사건피의자번호
	//rcptNum 	: 접수번호
	//actVioNum	: 법률위반번호
	//rltActCriNmCdDesc	: 죄명
	//actVioClaNm	: 죄명 sub
	
	//통계원표 영역 초기화 
	initStsGrap("1");
	
	//sub 탭 링크 셋팅 
	setStsGrapSubTabLink(incSpNum, rcptNum, actVioNum, rltActCriNmCd, rltActCriNmCdDesc, actVioClaNm, incSpNmDec, spYn, occArstYn);
	
	//'피의자' 통계원표 탭 노출 여부 
	setSpStsGrapTabView(spYn, occArstYn);
	
	//데이터 셋팅 
	setFieldValue($("#occr_rltActCriNmCd"), rltActCriNmCd);			//죄명코드
	setFieldValue($("#occr_rltActCriNmCdDesc"), rltActCriNmCdDesc);	//죄명
	setFieldValue($("#occr_actVioClaNm"), actVioClaNm);				//죄명 sub
	
	setFieldValue($("input[name=occr_incSpNum]"), incSpNum);	//사건피의자번호
	setFieldValue($("input[name=occr_rcptNum]"), rcptNum);		//접수번호
	setFieldValue($("input[name=occr_actVioNum]"), actVioNum);	//법률위반번호
	
	//발생 년, 월, 일, 시간 셋팅
	appendYear( $("select[name=occr_occrYrmhDt_year]") );
	appendMonth( $("select[name=occr_occrYrmhDt_month]") );
	appendDay( $("select[name=occr_occrYrmhDt_day]") );
	appendTime( $("select[name=occr_occrYrmhDt_time]") );
	
	//인지 년, 월, 일, 시간 셋팅
	appendYear( $("select[name=occr_recgYrmhDt_year]") );
	appendMonth( $("select[name=occr_recgYrmhDt_month]") );
	appendDay( $("select[name=occr_recgYrmhDt_day]") );
	appendTime( $("select[name=occr_recgYrmhDt_time]") );
	
	//데이터셋팅, 첫번째 데이터를 불러오시겠습니까? 2018.11.13 추가 
	//b0101VOMap.incSpVOList[0].actVioVOList[0].occrStsGrapVO
	//첫번째 피의자의 데이터가 있을 경우에만, 데이터 불러오기 confirm 노출
	if(b0101VOMap.incSpVOList[0].actVioVOList[0].occrStsGrapVO != null && !isNull(b0101VOMap.incSpVOList[0].actVioVOList[0].occrStsGrapVO.occrStsGrapNum)){
		
		//삭제한다.
		if(confirm("첫번째 피의자의 발생통계원표 데이터를 \n불러오시겠습니까?") == true){
			
			//피의자번호, 접수번호, 법률위반번호는 다시셋팅함
			var occrStsGrapVOClone = cloneObj(b0101VOMap.incSpVOList[0].actVioVOList[0].occrStsGrapVO);
			
			//발생통계원표일련번호 신규로 설정 (초기화)
			//생성일자, 생성자, 수정일자, 수정자는 소스부분에서 새로 셋팅함 
			//아래 7개의 데이터는 신규입력할 데이터로 다시 셋팅해주어야함
			occrStsGrapVOClone.occrStsGrapNum = "";						//발생통계원표일련번호
			occrStsGrapVOClone.incSpNum = incSpNum;						//피의자번호
			occrStsGrapVOClone.rcptNum = rcptNum;						//사건번호
			occrStsGrapVOClone.actVioNum = actVioNum;					//법률위반번호
			occrStsGrapVOClone.rltActCriNmCd = rltActCriNmCd;			//죄명코드
			occrStsGrapVOClone.rltActCriNmCdDesc = rltActCriNmCdDesc;	//죄명
			occrStsGrapVOClone.actVioClaNm = actVioClaNm;				//죄명 sub
			
			setOccrStsGrapArea(occrStsGrapVOClone);
			
		}
	}
	
	//이벤트바인딩 (selectbox)
	setTargetDefaultEvent( $("#tab_small_m1_contents .m1") );
	
	//탭선택
	stsContentsView("m1");	//발생통계원표 선택
	
	//화면사이즈 갱신
	autoResize();
}

//sub 탭 링크 셋팅 
function setStsGrapSubTabLink(incSpNum, rcptNum, actVioNum, rltActCriNmCd, rltActCriNmCdDesc, actVioClaNm, incSpNmDec, spYn, occArstYn){
	$("#occrStsGrapLink").attr("href", "javascript:updateOccrStsGrapView('"+incSpNum+"','"+actVioNum+"','"+rcptNum+"','"+rltActCriNmCd+"','"+rltActCriNmCdDesc+"','"+actVioClaNm+"','"+incSpNmDec+"','"+spYn+"','"+occArstYn+"')");
	$("#arstStsGrapLink").attr("href", "javascript:updateArstStsGrapView('"+incSpNum+"','"+actVioNum+"','"+rcptNum+"','"+rltActCriNmCd+"','"+rltActCriNmCdDesc+"','"+actVioClaNm+"','"+incSpNmDec+"','"+spYn+"','"+occArstYn+"')");
	$("#spStsGrapLink").attr("href", "javascript:updateSpStsGrapView('"+incSpNum+"','"+actVioNum+"','"+rcptNum+"','"+rltActCriNmCd+"','"+rltActCriNmCdDesc+"','"+actVioClaNm+"','"+incSpNmDec+"','"+spYn+"','"+occArstYn+"')");
}

//통계원표 작성 초기화 
function initStsGrap(type){
	//type : 1 [신규입력]
	//type : 2 [수정]
	
	var _$targetObj = $("#tab_small_m1_contents");
	
	//input 값 초기화
	_$targetObj.find("input[type=hidden]").val("");
	_$targetObj.find("input[type=text]").val("");
	_$targetObj.find("input[type=radio]:checked").prop("checked", false);
	_$targetObj.find("input[type=checkbox]:checked").prop("checked", false);
	
	$("#occr_occrYrmhDt_sub").html("시경");
	$("#occr_recgYrmhDt_sub").html("시");
	
	$("#occr_damgAmtTot").html("");
	$("#arst_collAmtTot").html("");
	
	//select값 초기화
	_$targetObj.find("select").each(function(){
		var self = $(this);
		//첫번째 option 선택
		self.find("option:eq(0)").prop("selected", true);
		self.prev(".txt").text(self.find('option:selected').text());
	});
	
	//버튼 컨트롤
	if(type == "1"){	//신규입력
		$("div[data-name=occrArea01]").show();
		$("div[data-name=occrArea02]").hide();
		
	}else if(type == "2"){	//수정
		$("div[data-name=occrArea01]").hide();
		$("div[data-name=occrArea02]").show();
	}else{	//수정
		$("div[data-name=occrArea01]").hide();
		$("div[data-name=occrArea02]").show();
	}
}

//통계원표 입력 화면 노출 전, 피의자 이름, 관련법률 및 죄명 여부 확인 
function checkStsRequired(incSpNm, rltActCriNmCd){
	if(isNull(incSpNm)){
		alert("피의자명을 먼저 입력하세요.");
		return false;
	}
	
	if(isNull(rltActCriNmCd)){
		alert("위반법률 및 죄명을 먼저 선택하세요.");
		return false;
	}
	return true;
}

//'검거' 통계원표 등록, 수정 화면 노출
function updateArstStsGrapView(incSpNum, actVioNum, rcptNum, rltActCriNmCd, rltActCriNmCdDesc, actVioClaNm, incSpNmDec, spYn, occArstYn){
//function updateArstStsGrapView(incSpNum, actVioNum){
	// 수현 - 피의자 필수정보 입력시에만 통계원표 작성 가능
	var spChk = "Y";
	if(b0101VOMap.criStatCd == "57" || b0101VOMap.criStatCd == "67"){
		$.each(b0101VOMap.incSpVOList, function(i, incSpVO) {
			var idNumlen = (incSpVO.spIdNum).length;
			var spNm = incSpVO.spNm;
			var spAddr = incSpVO.spAddr;
			var incCont = b0101VOMap.incCont;
			if(spNm.indexOf("성명불상") != -1 || spNm.indexOf("성명 불상") != -1){
				
			}else{
				if( idNumlen != 14 ||spNm == ""|| spNm == " " || spNm == null ||spAddr == "" ||spAddr == " " ||spAddr == null||incCont == " " ||incCont == null){
					spChk = "N";
				}
			}
			$.each(incSpVO.actVioVOList,function(i,actVioVO){
				if(!actVioVO.actVioClaVOList || actVioVO.actVioClaVOList.length == 0){
					spChk = "N";
				}else{
					if(!actVioVO.actVioClaVOList || actVioVO.actVioClaVOList.length == 0){
						spChk = "N";
					}else{
						var rltActCriNmCdYN = actVioVO.rltActCriNmCd;
						var actVioClaNmYN = actVioVO.actVioClaVOList[0].actVioClaNm;
						var vioContYN = actVioVO.vioCont;
						if( actVioClaNmYN == null || actVioClaNmYN == ""||vioContYN == null||vioContYN ==  ""||rltActCriNmCdYN == null||rltActCriNmCdYN ==  "" ){
							spChk = "N";
						}
					}
				}
			});
	
		});
	}
	if(spChk == "N"){
		alert("피의자의 성명, 주민등록번호, 주소, 위반법률, 위반조항, 위반내용을 입력하셔야 통계원표 입력이 가능합니다.");
		return;
	}
	if(spChk == "Y"){
		if(!checkStsRequired(incSpNmDec, rltActCriNmCd)){
			return;
		}
		
		var reqMap = {
				incSpNum : incSpNum
				,actVioNum : actVioNum
			}
		
		goAjaxDefault("/sjpb/B/selectArstStsGrap.face", reqMap, function(data){ callBackUpdateArstStsGrapViewSuccess(data, incSpNum, actVioNum, rcptNum, rltActCriNmCd, rltActCriNmCdDesc, actVioClaNm, incSpNmDec, spYn, occArstYn)});
	}
}

//'검거' 통계원표 등록, 수정 화면 노출 성공 콜백함수
function callBackUpdateArstStsGrapViewSuccess(data, incSpNum, actVioNum, rcptNum, rltActCriNmCd, rltActCriNmCdDesc, actVioClaNm, incSpNmDec, spYn, occArstYn){
	
	//통계원표 공통맵 초기화(사건번호)
	initB0102VOMap();
	
	//'검거' 통계원표 가져오기 
	arstStsGrapVOMap = data.arstStsGrapVO;
	
	//'피의자' 통계원표 탭 노출 여부 
	setSpStsGrapTabView(spYn, occArstYn);
	
	//사건번호셋팅
	b0102VOMap.incNum = data.incNum;
	
	if(arstStsGrapVOMap == null){	//신규
		insertArstStsGrapView(incSpNum, rcptNum, actVioNum, rltActCriNmCd, rltActCriNmCdDesc, actVioClaNm, incSpNmDec, spYn, occArstYn);
		
	}else{	//수정
		//통계원표 영역 초기화 
		initStsGrap("2");
		
		//sub 탭 링크 셋팅 
		setStsGrapSubTabLink(incSpNum, rcptNum, actVioNum, rltActCriNmCd, rltActCriNmCdDesc, actVioClaNm, incSpNmDec, spYn, occArstYn);
		
		//데이터셋팅
		setArstStsGrapArea(arstStsGrapVOMap);
		
		//이벤트바인딩 (selectbox)
		setTargetDefaultEvent( $("#tab_small_m1_contents .m2") );
		
		//탭선택
		stsContentsView("m2");	//검거통계원표 선택
		
		//화면사이즈 갱신
		autoResize();
	}
	
	
}

//'검거' 통계원표 작성 화면노출
function insertArstStsGrapView(incSpNum, rcptNum, actVioNum, rltActCriNmCd, rltActCriNmCdDesc, actVioClaNm, incSpNmDec, spYn, occArstYn){
	//incSpNum	: 사건피의자번호
	//rcptNum 	: 접수번호
	//actVioNum	: 법률위반번호
	//rltActCriNmCdDesc	: 죄명
	//actVioClaNm	: 죄명 sub
	
	//통계원표 영역 초기화 
	initStsGrap("1");
	
	//sub 탭 링크 셋팅 
	setStsGrapSubTabLink(incSpNum, rcptNum, actVioNum, rltActCriNmCd, rltActCriNmCdDesc, actVioClaNm, incSpNmDec, spYn, occArstYn);
	
	//'피의자' 통계원표 탭 노출 여부 
	setSpStsGrapTabView(spYn, occArstYn);
	
	//데이터 셋팅 
	setFieldValue($("input[name=arst_rcptNum]"), rcptNum);		//접수번호
	setFieldValue($("#arst_rltActCriNmCd"), rltActCriNmCd);			//죄명코드
	setFieldValue($("#arst_rltActCriNmCdDesc"), rltActCriNmCdDesc);	//죄명
	setFieldValue($("#arst_actVioClaNm"), actVioClaNm);				//죄명 sub
	
	setFieldValue($("input[name=arst_incSpNum]"), incSpNum);	//사건피의자번호
	setFieldValue($("input[name=arst_actVioNum]"), actVioNum);	//법률위반번호
	
	//검거 년, 월, 일간 셋팅
	appendYear( $("select[name=arst_arstYearMontDt_year]") );
	appendMonth( $("select[name=arst_arstYearMontDt_month]") );
	appendDay( $("select[name=arst_arstYearMontDt_day]") );
	
	//발생 년, 월, 일 셋팅
	appendYear( $("select[name=arst_occrYearMontDt_year]") );
	appendMonth( $("select[name=arst_occrYearMontDt_month]") );
	appendDay( $("select[name=arst_occrYearMontDt_day]") );
	
	//데이터셋팅, 첫번째 데이터를 불러오시겠습니까? 2018.11.13 추가 
	//b0101VOMap.incSpVOList[0].actVioVOList[0].arstStsGrapVO
	//첫번째 피의자의 데이터가 있을 경우에만, 데이터 불러오기 confirm 노출
	if(b0101VOMap.incSpVOList[0].actVioVOList[0].arstStsGrapVO != null && !isNull(b0101VOMap.incSpVOList[0].actVioVOList[0].arstStsGrapVO.arstStsGrapNum)){
		
		//삭제한다.
		if(confirm("첫번째 피의자의 검거통계원표 데이터를 \n불러오시겠습니까?") == true){
			
			//피의자번호, 접수번호, 법률위반번호는 다시셋팅함
			var arstStsGrapVOClone = cloneObj(b0101VOMap.incSpVOList[0].actVioVOList[0].arstStsGrapVO);
			
			//검거통계원표일련번호 신규로 설정 (초기화)
			//생성일자, 생성자, 수정일자, 수정자는 소스부분에서 새로 셋팅함 
			//아래 7개의 데이터는 신규입력할 데이터로 다시 셋팅해주어야함
			arstStsGrapVOClone.arstStsGrapNum = "";						//검거통계원표일련번호
			arstStsGrapVOClone.incSpNum = incSpNum;						//피의자번호
			arstStsGrapVOClone.rcptNum = rcptNum;						//사건번호
			arstStsGrapVOClone.actVioNum = actVioNum;					//법률위반번호
			arstStsGrapVOClone.rltActCriNmCd = rltActCriNmCd;			//죄명코드
			arstStsGrapVOClone.rltActCriNmCdDesc = rltActCriNmCdDesc;	//죄명
			arstStsGrapVOClone.actVioClaNm = actVioClaNm;				//죄명 sub
			
			setArstStsGrapArea(arstStsGrapVOClone);
			
		}
	}
	
	//이벤트바인딩 (selectbox)
	setTargetDefaultEvent( $("#tab_small_m1_contents .m2") );
	
	//탭선택
	stsContentsView("m2");	//검거통계원표 선택
	
	//화면사이즈 갱신
	autoResize();
	
}

//'발생','검거' 통계원표 노출
function setSpStsGrapTabView(spYn, occArstYn){
	
	//'발생','검거' 탭 노출
	if(occArstYn == "true"){
		$("#tab_small_m1_contents .m1").show();
		$("#tab_small_m1_contents .m2").show();
		
	//미노출
	}else{
		$("#tab_small_m1_contents .m1").hide();
		$("#tab_small_m1_contents .m2").hide();
		
	}
	//피의자 통계원표 탭 노출
	if(spYn == "true"){
		$("#tab_small_m1_contents .m3").show();
		
		//미노출
	}else{
		$("#tab_small_m1_contents .m3").hide();
		
	}
	//화면사이즈 갱신
	autoResize();
}

//'피의자' 통계원표 등록, 수정 화면 노출
function updateSpStsGrapView(incSpNum, actVioNum, rcptNum, rltActCriNmCd, rltActCriNmCdDesc, actVioClaNm, incSpNmDec, spYn, occArstYn){
	//수현 - 성명,주민등록번호,주소 입력시에만 통계원표 입력가능 
	var spChk = "Y"; //피의자 정보 체크
	if(b0101VOMap.criStatCd == "57" || b0101VOMap.criStatCd == "67"){
		$.each(b0101VOMap.incSpVOList, function(i, incSpVO) {
			var idNumlen = (incSpVO.spIdNum).length;
			var spNm = incSpVO.spNm;
			var spAddr = incSpVO.spAddr;
			var incCont = b0101VOMap.incCont;
			
			if(spNm.indexOf("성명불상") != -1 || spNm.indexOf("성명 불상") != -1){
				
			}else{
				if( idNumlen != 14 ||spNm == ""|| spNm == " " || spNm == null ||spAddr == "" ||spAddr == " " ||spAddr == null||incCont == " " ||incCont == null){
					spChk = "N";
				}
			}
			$.each(incSpVO.actVioVOList,function(i,actVioVO){
				if(!actVioVO.actVioClaVOList || actVioVO.actVioClaVOList.length == 0){
					spChk = "N";
					
				}else{
					if(!actVioVO.actVioClaVOList|| actVioVO.actVioClaVOList.length == 0){
						spChk = "N";
					}else{
						var actVioClaNmYN = actVioVO.actVioClaVOList[0].actVioClaNm;
						var vioContYN = actVioVO.vioCont;
						var rltActCriNmCdYN = actVioVO.rltActCriNmCd;
						if( actVioClaNmYN == null || actVioClaNmYN ==  "" || vioContYN == null || vioContYN ==  "" || rltActCriNmCdYN == null || rltActCriNmCdYN == ""){
							spChk = "N";
						}
					}
				}
			});
	
		});
	}
	if(spChk == "N"){
		alert("피의자의 성명, 주민등록번호, 주소, 위반법률, 위반조항, 위반내용을 입력하셔야 통계원표 입력이 가능합니다.");
		return;
	}
	if(spChk == "Y"){
		if(!checkStsRequired(incSpNmDec, rltActCriNmCd)){
			return;
		}
		
		var reqMap = {
				incSpNum : incSpNum
				,actVioNum : actVioNum
			}
		goAjaxDefault("/sjpb/B/selectSpStsGrap.face", reqMap, function(data){callBackUpdateSpStsGrapViewSuccess(data, incSpNum, actVioNum, rcptNum, rltActCriNmCd, rltActCriNmCdDesc, actVioClaNm, incSpNmDec, spYn, occArstYn)});
	}
}

//'피의자' 통계원표 등록, 수정 화면 노출 성공 콜백함수
function callBackUpdateSpStsGrapViewSuccess(data, incSpNum, actVioNum, rcptNum, rltActCriNmCd, rltActCriNmCdDesc, actVioClaNm, incSpNmDec, spYn, occArstYn){
	
	//피의자 정보 초기화 
	initIncSpVOGrapMap();
	
	//통계원표 공통맵 초기화(사건번호)
	initB0102VOMap();
	
	//'피의자' 통계원표 가져오기 
	spStsGrapVOMap = data.spStsGrapVO;
	
	//피의자정보 셋팅
	incSpVOGrapMap = data.incSpVO;
	
	//'피의자' 통계원표 탭 노출 여부 
	setSpStsGrapTabView(spYn, occArstYn);
	
	//사건번호셋팅
	b0102VOMap.incNum = data.incNum;
	
	if(spStsGrapVOMap == null){	//신규
		insertSpStsGrapView(incSpNum, actVioNum, rcptNum, rltActCriNmCd, rltActCriNmCdDesc, actVioClaNm, incSpNmDec, spYn, occArstYn);
	}else{	//수정
		//통계원표 영역 초기화 
		initStsGrap("2");
		
		//sub 탭 링크 셋팅 
		setStsGrapSubTabLink(incSpNum, rcptNum, actVioNum, rltActCriNmCd, rltActCriNmCdDesc, actVioClaNm, incSpNmDec, spYn, occArstYn);
		
		//데이터셋팅
		setSpStsGrapArea(spStsGrapVOMap);
		
		//이벤트바인딩 (selectbox)
		setTargetDefaultEvent( $("#tab_small_m1_contents .m3") );
		
		$("select[name=sp_jobCd]").trigger("change");	//공무원일경우 입력영역활성화
		
		//탭선택
		stsContentsView("m3");	//피의자통계원표 선택
		
		//화면사이즈 갱신
		autoResize();
	}
	
}

//'피의자' 통계원표 작성 화면노출
function insertSpStsGrapView(incSpNum, actVioNum, rcptNum, rltActCriNmCd, rltActCriNmCdDesc, actVioClaNm, incSpNmDec, spYn, occArstYn){
	//incSpNum	: 사건피의자번호
	//rcptNum 	: 접수번호
	//actVioNum	: 법률위반번호
	//rltActCriNmCdDesc	: 죄명
	//actVioClaNm	: 죄명 sub
	
	//통계원표 영역 초기화 
	initStsGrap("1");
	
	//sub 탭 링크 셋팅 
	setStsGrapSubTabLink(incSpNum, rcptNum, actVioNum, rltActCriNmCd, rltActCriNmCdDesc, actVioClaNm, incSpNmDec, spYn, occArstYn);
	
	//죄명 SELECT BOX 셋팅 S
	var actVioHtml = new StringBuffer();
	$.each(incSpVOGrapMap.actVioVOList, function(i, actVioVO) {
		
		if(actVioVO.actVioNum == actVioNum){
			actVioHtml.append('<option value="'+actVioVO.actVioNum+'" data-rltactcrinmcd="'+actVioVO.rltActCriNmCd+'" data-actvioclanm="'+actVioVO.actVioClaNm+'" selected="selected">'+actVioVO.rltActCriNmCdDesc+'</option>');
		}else{
			actVioHtml.append('<option value="'+actVioVO.actVioNum+'" data-rltactcrinmcd="'+actVioVO.rltActCriNmCd+'" data-actvioclanm="'+actVioVO.actVioClaNm+'">'+actVioVO.rltActCriNmCdDesc+'</option>');
		}
	});
	$("select[name=sp_rltActCriNmCdDesc]").html(actVioHtml.toString());
	setTargetDefaultEvent($("select[name=sp_rltActCriNmCdDesc]"));
	$("select[name=sp_rltActCriNmCdDesc]").trigger("change");
	//죄명 SELECT BOX 셋팅 E
	
	//죄명선택에 따라 죄명코드, 죄명, 죄명sub, 법률위반번호는 바귀어야함 S
//	setFieldValue($("#sp_rltActCriNmCd"), rltActCriNmCd);			//죄명코드
//	setFieldValue($("#sp_rltActCriNmCdDesc"), rltActCriNmCdDesc);	//죄명
//	setFieldValue($("#sp_actVioClaNm"), actVioClaNm);				//죄명 sub
//	setFieldValue($("input[name=sp_actVioNum]"), actVioNum);	//법률위반번호
	//죄명선택에 따라 죄명코드, 죄명, 죄명sub, 법률위반번호는 바귀어야함 E
	
	setFieldValue($("input[name=sp_rcptNum]"), rcptNum);		//접수번호
	setFieldValue($("input[name=sp_incSpNum]"), incSpNum);		//사건피의자번호
	
	//피의자정보
	setFieldValue($("#sp_spNm"), incSpVOGrapMap.spNm);				//피의자이름
	setFieldValue($("#sp_spIdNum"), incSpVOGrapMap.spIdNum);		//피의자식별번호
	setFieldValue($("input[name=sp_gendDiv]"), incSpVOGrapMap.gendDiv);		//피의자성별
	
	
	
	//데이터셋팅, 첫번째 데이터를 불러오시겠습니까? 2018.11.13 추가 
	//b0101VOMap.incSpVOList[0].actVioVOList[0].spStsGrapVO
	//첫번째 피의자의 데이터가 있을 경우에만, 데이터 불러오기 confirm 노출
	
	var spStsGrapVOTmp = new Object();
	$.each(b0101VOMap.incSpVOList[0].actVioVOList, function(i, actVioVO) {
		if(actVioVO.spStsGrapVO != null && !isNull(actVioVO.spStsGrapVO.spStsGrapNum)){
			spStsGrapVOTmp = actVioVO.spStsGrapVO;
		}
	});
	
	if(spStsGrapVOTmp != null && !isNull(spStsGrapVOTmp.spStsGrapNum)){
		
		//삭제한다.
		if(confirm("첫번째 피의자의 피의자통계원표 데이터를 \n불러오시겠습니까?") == true){
			
			//피의자번호, 접수번호, 법률위반번호는 다시셋팅함
			var spStsGrapVOClone = cloneObj(spStsGrapVOTmp);
			
			//피의자통계원표일련번호 신규로 설정 (초기화)
			//생성일자, 생성자, 수정일자, 수정자는 소스부분에서 새로 셋팅함 
			//아래 7개의 데이터는 신규입력할 데이터로 다시 셋팅해주어야함
			spStsGrapVOClone.spStsGrapNum = "";						//피의자통계원표일련번호
			spStsGrapVOClone.incSpNum = incSpNum;					//피의자번호
			spStsGrapVOClone.rcptNum = rcptNum;						//사건번호
			spStsGrapVOClone.actVioNum = actVioNum;					//법률위반번호
			spStsGrapVOClone.rltActCriNmCd = rltActCriNmCd;			//죄명코드
			spStsGrapVOClone.rltActCriNmCdDesc = rltActCriNmCdDesc;	//죄명
			spStsGrapVOClone.actVioClaNm = actVioClaNm;				//죄명 sub
			
			setSpStsGrapArea(spStsGrapVOClone);
			
		}
	}
	
	
	
	//이벤트바인딩 (selectbox)
	setTargetDefaultEvent( $("#tab_small_m1_contents .m3") );
	
	//탭선택
	stsContentsView("m3");	//피의자통계원표 선택
	
	//화면사이즈 갱신
	autoResize();
}

//년도 option 셋팅 
function appendYear(_$div, value){
	var date = new Date();
	var year = date.getFullYear();
	
	var occrYearOption = new StringBuffer();
	
	if(isNull(value) || value == "0000"){
		occrYearOption.append('<option value="" selected="selected">선택</option>');
		_$div.prev('.txt').text("선택");
	}else{
		occrYearOption.append('<option value="">선택</option>');
	}
	
	for(var i = year; i >= year - 60; i--){
		if(i == value){
			occrYearOption.append('<option value="'+i+'" selected="selected">'+i+'</option>');
			_$div.prev('.txt').text(i);
		}else{
			occrYearOption.append('<option value="'+i+'">'+i+'</option>');
		}
	}
	
	_$div.html(occrYearOption.toString());
}

//월 option 셋팅 
function appendMonth(_$div, value){
	
	var occrMonthOption = new StringBuffer();
	
	if(isNull(value) || value == "00"){
		occrMonthOption.append('<option value="" selected="selected">선택</option>');
		_$div.prev('.txt').text("선택");
	}else{
		occrMonthOption.append('<option value="">선택</option>');
	}
	
	for(var i = 1; i <= 12; i++){
		if(i == value){
			occrMonthOption.append('<option value="'+pad(i,"2")+'" selected="selected">'+pad(i,"2")+'</option>');
			_$div.prev('.txt').text(pad(i,"2"));
		}else{
			occrMonthOption.append('<option value="'+pad(i,"2")+'">'+pad(i,"2")+'</option>');
		}
		
	}
	
	_$div.html(occrMonthOption.toString());
	
}

//일 option 셋팅 
function appendDay(_$div, value){
	
	var occrDayOption = new StringBuffer();
	
	if(isNull(value) || value == "00"){
		occrDayOption.append('<option value="" selected="selected">선택</option>');
		_$div.prev('.txt').text("선택");
	}else{
		occrDayOption.append('<option value="">선택</option>');
	}
	
	for(var i = 1; i <= 31; i++){
		if(i == value){
			occrDayOption.append('<option value="'+pad(i,"2")+'" selected="selected">'+pad(i,"2")+'</option>');
			_$div.prev('.txt').text(pad(i,"2"));
		}else{
			occrDayOption.append('<option value="'+pad(i,"2")+'">'+pad(i,"2")+'</option>');
		}
	}
	
	_$div.html(occrDayOption.toString());
	
}

//시간 option 셋팅 
function appendTime(_$div, value){
	
	var occrTimeOption = new StringBuffer();
	
	if(isNull(value) || value == "00"){
		occrTimeOption.append('<option value="" selected="selected">선택</option>');
		_$div.prev('.txt').text("선택");
	}else{
		occrTimeOption.append('<option value="">선택</option>');
	}
	
	for(var i = 1; i <= 24; i++){
		if(!isNull(value) && i == value){
			occrTimeOption.append('<option value="'+pad(i,"2")+'" selected="selected">'+pad(i,"2")+'</option>');
			_$div.prev('.txt').text(pad(i,"2"));
		}else{
			occrTimeOption.append('<option value="'+pad(i,"2")+'">'+pad(i,"2")+'</option>');
		}
		
	}
	
	_$div.html(occrTimeOption.toString());
	
}

//custom select 이벤트 바인딩
function setTargetDefaultEvent(_$obj){
	_$obj.find('select').each(function() {
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
	});
}

//검거통계원표 등록하기 
function insertArstStsGrap(){
	
	//검거통계원표 맵 초기화 
	initArstStsGrapVOMap();
	
	//데이터갱신
	syncArstStsGrapVOMap();
	
	goAjax("/sjpb/B/insertUpdateArstStsGrap.face", arstStsGrapVOMap,  callBackInsertArstStsGrapSuccess);
}

//검거통계원표 저장 성공 콜백함수
function callBackInsertArstStsGrapSuccess(data){
	b0101VOMap = data.b0101VO;
	arstStsGrapVOMap = data.arstStsGrapVO;
	
	//수정 화면으로 변경,
	$("div[data-name=occrArea01]").hide();
	$("div[data-name=occrArea02]").show();
	
	//수정시 필요한 데이터 셋팅
	setFieldValue($("input[name=arst_arstStsGrapNum]"), arstStsGrapVOMap.arstStsGrapNum);		//검거통계원표번호
	setFieldValue($("input[name=arst_stsGrapPublYrmh]"), arstStsGrapVOMap.stsGrapPublYrmh);	//통계원표발행년월
	
	//모든 통계원표 등록시 바로, 송치요청 보내기 S 2018.11.29 
	//통계원표를 모두 입력했는지 확인한다. && 마스터 사건일경우
	//금감원
//	if(isAllCheckGrap() && (b0101VOMap.criStatCd == "57" || b0101VOMap.criStatCd == "67" ) && isRootInc){
//		//사건이 '수사중' 상태일 경우, 수사지원요청 보내기
//		var taskTrstVOListTmp = new Array();
//		for (var i = 0; i < b0101VOMap.taskTrstVOList.length; i++) {
//			//상태가 75번이 송치요청.
//			if(b0101VOMap.taskTrstVOList[i].criStatCd == "75"){
//				taskTrstVOListTmp.push(b0101VOMap.taskTrstVOList[i]);
//			}
//		}
//		
//		var reqMap = new Object();
//		reqMap.b0101VO = b0101VOMap;
//		reqMap.b0101VO.taskTrstVOList = taskTrstVOListTmp;
//		alert("송치요청 되었습니다.");
//		callBackInsertIncMastSuccess(reqMap);	//수사지원요청 	
//	}else{
		alert("검거통계원표가 등록 되었습니다.");
		selectStsGrapList2();
//	}
	//모든 통계원표 등록시 바로, 수사지원요청 보내기 E 2018.11.29
}

//검거통계원표 수정하기 
function updateArstStsGrap(){
	
	//검거통계원표 맵 초기화 
	initArstStsGrapVOMap();
	
	//데이터갱신
	syncArstStsGrapVOMap();
	
	goAjax("/sjpb/B/insertUpdateArstStsGrap.face", arstStsGrapVOMap,  callBackUpdateArstStsGrapSuccess);
}

//검거통계원표 수정 성공 콜백함수
function callBackUpdateArstStsGrapSuccess(data){
	b0101VOMap = data.b0101VO;
	arstStsGrapVOMap = data.arstStsGrapVO;
	
	selectStsGrapList2();
	alert("검거통계원표가 수정 되었습니다.");
}

//피의자통계원표 등록하기 
function insertSpStsGrap(){
	
	//피의자통계원표 맵 초기화 
	initSpStsGrapVOMap();
	
	//데이터갱신
	syncSpStsGrapVOMap();
	
	goAjax("/sjpb/B/insertUpdateSpStsGrap.face", spStsGrapVOMap,  callBackInsertSpStsGrapSuccess);
}

//피의자통계원표 저장 성공 콜백함수
function callBackInsertSpStsGrapSuccess(data){
	b0101VOMap = data.b0101VO;
	spStsGrapVOMap = data.spStsGrapVO;
	
	//수정 화면으로 변경,
	$("div[data-name=occrArea01]").hide();
	$("div[data-name=occrArea02]").show();
	
	//수정시 필요한 데이터 셋팅
	setFieldValue($("input[name=sp_spStsGrapNum]"), spStsGrapVOMap.spStsGrapNum);		//피의자통계원표번호
	setFieldValue($("input[name=sp_stsGrapPublYrmh]"), spStsGrapVOMap.stsGrapPublYrmh);	//통계원표발행년월
	
	//모든 통계원표 등록시 바로, 송치요청 보내기 S 2018.11.29 
	//통계원표를 모두 입력했는지 확인한다. && 마스터 사건일경우
	//금감원
	if(isAllCheckGrap() && ( b0101VOMap.criStatCd == "57" || b0101VOMap.criStatCd == "67" ) && isRootInc){
		//사건이 '수사중' 상태일 경우, 수사지원요청 보내기
		var taskTrstVOListTmp = new Array();
		for (var i = 0; i < b0101VOMap.taskTrstVOList.length; i++) {
			//상태가 75번이 수사지휘요청.
			if(b0101VOMap.taskTrstVOList[i].criStatCd == "75"){
				taskTrstVOListTmp.push(b0101VOMap.taskTrstVOList[i]);
			}
		}
		
		var reqMap = new Object();
		reqMap.b0101VO = b0101VOMap;
		reqMap.b0101VO.taskTrstVOList = taskTrstVOListTmp;
		alert("송치요청 되었습니다.");
		callBackInsertIncMastSuccess(reqMap);	//수사지원요청
	}else{
		alert("피의자통계원표가 등록 되었습니다. ");
		selectStsGrapList2();
	}
	//모든 통계원표 등록시 바로, 수사지원요청 보내기 E 2018.11.29
	
}

//모든 통계원표를 입력했는지 확인함
function isAllCheckGrap(){
	
	var result = false;
	
	var isStsResult = true;		//'발생', '검거' 통계원표 등록 여부 (false : 등록안함, true: 등록함)
	var isSpStsResult = true;	//'피의자' 통계원표 등록 여부 (false : 등록안함, true: 등록함)
	var rctCd = "";
	var rctYN = true;
	$.each(b0101VOMap.incSpVOList, function(i, incSpVO) {

		
		if(i == 0){
			
			rctCd = incSpVO.rltActCriNmCd;
			rcptNum = incSpVO.incNum;
			incSpNum = incSpVO.incSpNum;
			spYN = true;
			occArstYN = true;
			
			
		}else if(rcptNum != incSpVO.incNum){
			
			rctCd = incSpVO.rltActCriNmCd;
			rcptNum = incSpVO.incNum;
			incSpNum = incSpVO.incSpNum;
			spYN = true;
			occArstYN = true;
			
		}else if(rcptNum == incSpVO.incNum){	
			
			if(rctCd != incSpVO.rltActCriNmCd){
				
				rctCd = incSpVO.rltActCriNmCd;
				spYN = true;
				occArstYN = true;
				if(incSpNum != incSpVO.incSpNum){
					incSpNum = incSpVO.incSpNum;
					spYN = true;
				}else if(incSpNum == incSpVO.incSpNum){
					spYN = false;
				}
				
				
			}else if(rctCd == incSpVO.rltActCriNmCd){
				
				spYN = true;
				occArstYN = false;
				
			}
		}
		
		
		if(occArstYN == true){
			//작성한 발생통계원표 데이터가 없으면, 
			if(incSpVO.actVioVOList[0].occrStsGrapVO == null){		
				isStsResult = false;
				return false;
			}
			
			
			//작성한 검거통계원표 데이터가 없으면, 
			if(incSpVO.actVioVOList[0].arstStsGrapVO == null){		
				isStsResult = false;
				return false;
			}
		}
		if(spYN == true){
			//작성한 피의자통계원표 데이터가 있으면, 
			if(incSpVO.actVioVOList[0].spStsGrapVO == null){
				isSpStsResult =  false;
				return false;
			}
		}
		
		
		
//		var isSpStsGrapVO = false;	//'피의자' 통계원표 등록 여부 반복문안에서 
//		
//		if(i == 0 || rctCd != incSpVO.rltActCriNmCd){
//			rctCd = incSpVO.rltActCriNmCd;
//			rctYN = true;
//			$.each(incSpVO.actVioVOList, function(j, ActVioVO) {
//				
//				//작성한 발생통계원표 데이터가 없으면, 
//				if(ActVioVO.occrStsGrapVO == null){		
//					isStsResult = false;
//					return false;
//				}
//				
//				
//				//작성한 검거통계원표 데이터가 없으면, 
//				if(ActVioVO.arstStsGrapVO == null){		
//					isStsResult = false;
//					return false;
//				}
//				
//				
//				//작성한 피의자통계원표 데이터가 있으면, 
//				if(ActVioVO.spStsGrapVO == null){
//					isSpStsResult =  false;
//					return false;
//				}
//			});
//		}else if(rctCd == incSpVO.rltActCriNmCd){		
//			rctYN = false;
//			$.each(incSpVO.actVioVOList, function(j, ActVioVO) {
//								
//				//작성한 피의자통계원표 데이터가 있으면, 
//				if(ActVioVO.spStsGrapVO == null){
//					isSpStsResult =  false;
//					return false;
//				}
//			});
//		}
//		$.each(incSpVO.actVioVOList, function(j, ActVioVO) {
//			
//			//작성한 발생통계원표 데이터가 없으면, 
//			if(ActVioVO.occrStsGrapVO == null){		
//				isStsResult = false;
//				return false;
//			}
//			
//			
//			//작성한 검거통계원표 데이터가 없으면, 
//			if(ActVioVO.arstStsGrapVO == null){		
//				isStsResult = false;
//				return false;
//			}
//			
//			//개인일경우에만
//			if(incSpVO.indvCorpDiv == "1"){
//				//작성한 피의자통계원표 데이터가 있으면, 
//				if(ActVioVO.spStsGrapVO != null){
//					isSpStsGrapVO =  true;
//				}
//				
//			//법인일경우에는
//			}else{
//				//피의통계원표를 작성하지 않으므로 패스 
//				isSpStsGrapVO =  true;
//			}
//		});
		
		//피의자 통계원표를 작성하지 않음 
		if(!isSpStsResult){
//			isSpStsResult = false;
			return false;
		}
		
		//발생, 검거 통계원표를 작성하지 않음 
		if(!isStsResult){
			return false;
		}
	});
	
	//통계원표를 모두 입력한 상태 (정상)
	if(isStsResult && isSpStsResult){
		result = true;
	//통계원표를 모두 입력이 안된 상태(진행안됨)
	}else{	
		result = false;
	}
	
	return result;
}

//피의자통계원표 수정하기 
function updateSpStsGrap(){
	
	//피의자통계원표 맵 초기화 
	initSpStsGrapVOMap();
	
	//데이터갱신
	syncSpStsGrapVOMap();
	
	goAjax("/sjpb/B/insertUpdateSpStsGrap.face", spStsGrapVOMap,  callBackUpdateSpStsGrapSuccess);
}

//피의자통계원표 수정 성공 콜백함수
function callBackUpdateSpStsGrapSuccess(data){
	b0101VOMap = data.b0101VO;
	spStsGrapVOMap = data.spStsGrapVO;
	selectStsGrapList2();
	alert("피의자통계원표가 수정 되었습니다.");
}

//발생통계원표 등록하기 
function insertOccrStsGrap(){
	
	//발생통계원표 맵 초기화 
	initOccrStsGrapVOMap();
	
	//유효성 체크
	//var chkObjs = $("#tab_small_m1_contents_li");
	//if(!chkValidate.check(chkObjs, true)) return;
	
	//데이터갱신
	syncOccrStsGrapVOMap();
	
	goAjax("/sjpb/B/insertUpdateOccrStsGrap.face", occrStsGrapVOMap,  callBackInsertOccrStsGrapSuccess);
}

//발생통계원표 저장 성공 콜백함수
function callBackInsertOccrStsGrapSuccess(data){
	b0101VOMap = data.b0101VO;
	occrStsGrapVOMap = data.occrStsGrapVO;
	
	//수정 화면으로 변경,
	$("div[data-name=occrArea01]").hide();
	$("div[data-name=occrArea02]").show();
	
	//수정시 필요한 데이터 셋팅
	setFieldValue($("input[name=occr_occrStsGrapNum]"), occrStsGrapVOMap.occrStsGrapNum);		//발생통계원표번호
	setFieldValue($("input[name=occr_stsGrapPublYrmh]"), occrStsGrapVOMap.stsGrapPublYrmh);	//통계원표발행년월
	
	//모든 통계원표 등록시 바로, 수사지원요청 보내기 S 2018.11.29 
	//통계원표를 모두 입력했는지 확인한다. && 마스터 사건일경우
	//금감원
//	if(isAllCheckGrap() && ( b0101VOMap.criStatCd == "57" || b0101VOMap.criStatCd == "67" ) && isRootInc){
//		//사건이 '수사중' 상태일 경우, 수사지원요청 보내기
//		var taskTrstVOListTmp = new Array();
//		for (var i = 0; i < b0101VOMap.taskTrstVOList.length; i++) {
//			//상태가 75번이 송치요청.
//			if(b0101VOMap.taskTrstVOList[i].criStatCd == "75"){
//				taskTrstVOListTmp.push(b0101VOMap.taskTrstVOList[i]);
//			}
//		}
//		
//		var reqMap = new Object();
//		reqMap.b0101VO = b0101VOMap;
//		reqMap.b0101VO.taskTrstVOList = taskTrstVOListTmp;
//		alert("송치요청 되었습니다.");
//		callBackInsertIncMastSuccess(reqMap);	//수사지원요청 	
//	}else{
		alert("발생통계원표가 등록 되었습니다.");
		selectStsGrapList2();
//	}
	//모든 통계원표 등록시 바로, 수사지원요청 보내기 E 2018.11.29
}

//발생통계원표 수정하기 
function updateOccrStsGrap(){
	
	//발생통계원표 맵 초기화 
	initOccrStsGrapVOMap();
	
	//유효성 체크
	var chkObjs = $("#tab_small_m1_contents_li");
	if(!chkValidate.check(chkObjs, true)) return;
	
	//데이터갱신
	syncOccrStsGrapVOMap();
	
	goAjax("/sjpb/B/insertUpdateOccrStsGrap.face", occrStsGrapVOMap,  callBackUpdateOccrStsGrapSuccess);
}

//발생통계원표 수정 성공 콜백함수
function callBackUpdateOccrStsGrapSuccess(data){
	
	b0101VOMap = data.b0101VO;
	occrStsGrapVOMap = data.occrStsGrapVO;
	selectStsGrapList2();
	alert("발생통계원표가 수정 되었습니다.");
}

//발생통계원표 데이터갱신
function syncOccrStsGrapVOMap(){
	
	occrStsGrapVOMap.incSpNum = getFieldValue($("input[name=occr_incSpNum]"));		//사건피의자번호
	occrStsGrapVOMap.rcptNum = b0101VOMap.rcptNum;			//통합사건접수번호(사건 재조회를 위한 사건번호이므로 부모사건번호 셋팅)
	occrStsGrapVOMap.actVioNum = getFieldValue($("input[name=occr_actVioNum]"));		//법률위반번호

	occrStsGrapVOMap.occrStsGrapNum = getFieldValue($("input[name=occr_occrStsGrapNum]"));		//발생통계원표번호
	occrStsGrapVOMap.stsGrapPublYrmh = getFieldValue($("input[name=occr_stsGrapPublYrmh]"));		//통계원표발행년월

	occrStsGrapVOMap.famyVioYnCd = getFieldValue($("input[name=occr_famyVioYnCd]"));				//가정폭력유무
	occrStsGrapVOMap.schlVioYnCd = getFieldValue($("input[name=occr_schlVioYnCd]"));				//학교폭력유무
	occrStsGrapVOMap.forgSpYnCd = getFieldValue($("input[name=occr_forgSpYnCd]"));				//외국인피의자유무

	occrStsGrapVOMap.occrYrmhDtDivCd = getFieldValue($("input[name=occr_occrYrmhDtDivCd]"));		//발생년월일시구분코드
	
	//발생년월일시 선택일 경우에만 날짜값 셋팅
	if(occrStsGrapVOMap.occrYrmhDtDivCd == "1"){
		occrStsGrapVOMap.occrYrmhDt = combineDateToString("occr_occrYrmhDt", true);			//발생년월일시
	}
	
	occrStsGrapVOMap.occrDotw = getFieldValue($("input[name=occr_occrYrmhDtDotw]"));				//발생요일
	occrStsGrapVOMap.recgYrmhDt = combineDateToString("occr_recgYrmhDt", true);			//인지년월일시
	occrStsGrapVOMap.recgDotw = getFieldValue($("input[name=occr_recgYrmhDtDotw]"));				//인지요일

	occrStsGrapVOMap.occrToRecgPi = getFieldValue($("select[name=occr_occrToRecgPi]"));			//발생부터인지까지기간
	occrStsGrapVOMap.criMeth = getFieldValue($("select[name=occr_criMeth]"));					//범죄수법
	occrStsGrapVOMap.occrDtSpelSitu = getFieldValue($("select[name=occr_occrDtSpelSitu]"));		//발생일특수사정
	occrStsGrapVOMap.criTimeWeth = getFieldValue($("select[name=occr_criTimeWeth]"));			//범행시일기
	occrStsGrapVOMap.criClue = getFieldValue($("select[name=occr_criClue]"));					//수사단서
	occrStsGrapVOMap.undcRsn = getFieldValue($("select[name=occr_undcRsn]"));					//미신고이유
	occrStsGrapVOMap.vicm = getFieldValue($("input[name=occr_vicm]"));											//피해자
	occrStsGrapVOMap.ageDivCd = getFieldValue($("input[name=occr_ageDivCd]"));									//연령구분코드

	//연령선택일 경우에만 연령값 셋팅
	if(occrStsGrapVOMap.ageDivCd == "1"){
		occrStsGrapVOMap.age = getFieldValue($("input[name=occr_age]"));												//연령
	}
	
	occrStsGrapVOMap.forgCdNaty = getFieldValue($("input[name=occr_forgCdNaty]"));								//외국인코드국적
	occrStsGrapVOMap.forgCdPosi = getFieldValue($("input[name=occr_forgCdPosi]"));								//외국인코드신분
	occrStsGrapVOMap.vicmDamgTimeSitu = getFieldValue($("select[name=occr_vicmDamgTimeSitu]"));	//피해자피해시상황
	occrStsGrapVOMap.occrAreaDiv = getFieldValue($("select[name=occr_occrAreaDiv]"));			//발생지구분
	occrStsGrapVOMap.occrArea = getFieldValue($("select[name=occr_occrArea]"));					//발생지
	occrStsGrapVOMap.occrPla = getFieldValue($("select[name=occr_occrPla]"));					//발생장소
	occrStsGrapVOMap.propDamgDegr = getFieldValue($("select[name=occr_propDamgDegr]"));			//재산피해정도


	occrStsGrapVOMap.damgAmtMony = getFieldValue($("input[name=occr_damgAmtMony]"));						//피해액화폐
	occrStsGrapVOMap.damgAmtCar = getFieldValue($("input[name=occr_damgAmtCar]"));						//피해액자동차
	occrStsGrapVOMap.damgAmtMarkSecu = getFieldValue($("input[name=occr_damgAmtMarkSecu]"));				//피해액유가증권
	occrStsGrapVOMap.damgAmtJewy = getFieldValue($("input[name=occr_damgAmtJewy]"));						//피해액귀금속
	occrStsGrapVOMap.damgAmtElecElenProd = getFieldValue($("input[name=occr_damgAmtElecElenProd]"));		//피해액전기전자제품
	occrStsGrapVOMap.damgAmtMocyBike = getFieldValue($("input[name=occr_damgAmtMocyBike]"));				//피해액오토바이자전거
	occrStsGrapVOMap.damgAmtFurnArtc = getFieldValue($("input[name=occr_damgAmtFurnArtc]"));				//피해액가구류
	occrStsGrapVOMap.damgAmtClot = getFieldValue($("input[name=occr_damgAmtClot]"));						//피해액의류
	occrStsGrapVOMap.damgAmtMach = getFieldValue($("input[name=occr_damgAmtMach]"));						//피해액기계류
	occrStsGrapVOMap.damgAmtFarmFortProd = getFieldValue($("input[name=occr_damgAmtFarmFortProd]"));		//피해액농임산물
	occrStsGrapVOMap.damgAmtAmhbProd = getFieldValue($("input[name=occr_damgAmtAmhbProd]"));				//피해액축산물
	occrStsGrapVOMap.damgAmtMarnProd = getFieldValue($("input[name=occr_damgAmtMarnProd]"));				//피해액수산물
	occrStsGrapVOMap.damgAmtMcgd = getFieldValue($("input[name=occr_damgAmtMcgd]"));						//피해액잡화
	occrStsGrapVOMap.damgAmtEtc = getFieldValue($("input[name=occr_damgAmtEtc]"));						//피해액기타
	occrStsGrapVOMap.damgAmtTot = getFieldValue($("#occr_damgAmtTot"));									//피해액합계

	occrStsGrapVOMap.bodyDamgZero = isNull(getFieldValue($("input[name=occr_bodyDamgZero]"))) ? "" : getFieldValue($("input[name=occr_bodyDamgZero]"));		//신체피해무
	occrStsGrapVOMap.bodyDamgInjy = isNull(getFieldValue($("input[name=occr_bodyDamgInjy]"))) ? "" : getFieldValue($("input[name=occr_bodyDamgInjy]"));		//신체피해상해
	occrStsGrapVOMap.bodyDamgDeth = isNull(getFieldValue($("input[name=occr_bodyDamgDeth]"))) ? "" : getFieldValue($("input[name=occr_bodyDamgDeth]"));		//신체피해사망
	occrStsGrapVOMap.bodyDamgInjyMan = getFieldValue($("input[name=occr_bodyDamgInjyMan]"));			//신체피해상해남자
	occrStsGrapVOMap.bodyDamgInjyWomn = getFieldValue($("input[name=occr_bodyDamgInjyWomn]"));		//신체피해상해여자
	occrStsGrapVOMap.bodyDamgDethMan = getFieldValue($("input[name=occr_bodyDamgDethMan]"));			//신체피해사망남자
	occrStsGrapVOMap.bodyDamgDethWomn = getFieldValue($("input[name=occr_bodyDamgDethWomn]"));		//신체피해사망여자
	occrStsGrapVOMap.bodyDamgInjyDegr = getFieldValue($("select[name=occr_bodyDamgInjyDegr]"));	//신체피해상해정도
	
	//occrStsGrapVOMap.regUserId = $("#userId").val();	//사용자계정
	
	//같은위법조항에 대해서도 같이 업데이트 해준다. 
	var occr_rltActCriNmCd = $("#occr_rltActCriNmCd").val();
	var occrStsGrapNum = $("#occr_occrStsGrapNum").val();
	var occrRcptNum = $("#occr_rcptNum").val();
	var occrStsGrapVOSubArray = new Array();
	
	$("a[data-name=occrStsGrapBtn]").each(function(){
//		if(!isNull($(this).data("occrstsgrapnum"))){	//신규등록이 아닌
//			if(occrStsGrapNum == $(this).data("occrstsgrapnum")){	//현재수정하고있는 통계원표는 제외
//				return true;	//continue
//			}
//		}
		
		if(occr_rltActCriNmCd == $(this).data("rltactcrinmcd") && occrRcptNum == $(this).data("rcptnum")){
			var occrStsGrapVOSub = {
					occrStsGrapNum : $(this).data("occrstsgrapnum")	//발생통계원표번호
					,stsGrapPublYrmh : occrStsGrapVOMap.stsGrapPublYrmh	//통계원표발행년월
					,famyVioYnCd : occrStsGrapVOMap.famyVioYnCd		//가정폭력유무
					,schlVioYnCd : occrStsGrapVOMap.schlVioYnCd		//학교폭력유무
					,forgSpYnCd : occrStsGrapVOMap.forgSpYnCd		//외국인피의자유무
					,occrYrmhDtDivCd : occrStsGrapVOMap.occrYrmhDtDivCd	//발생년월일시구분코드
					,occrYrmhDt : occrStsGrapVOMap.occrYrmhDt		//발생년월일시
					,occrDotw : occrStsGrapVOMap.occrDotw			//발생요일
					,recgYrmhDt : occrStsGrapVOMap.recgYrmhDt		//인지년월일시
					,recgDotw : occrStsGrapVOMap.recgDotw			//인지요일
					,occrToRecgPi : occrStsGrapVOMap.occrToRecgPi		//발생부터인지까지기간
					,criMeth : occrStsGrapVOMap.criMeth			//범죄수법
					,occrDtSpelSitu : occrStsGrapVOMap.occrDtSpelSitu	//발생일특수사정
					,criTimeWeth : occrStsGrapVOMap.criTimeWeth		//범행시일기
					,criClue : occrStsGrapVOMap.criClue			//수사단서
					,undcRsn : occrStsGrapVOMap.undcRsn			//미신고이유
					,vicm : occrStsGrapVOMap.vicm				//피해자
					,ageDivCd : occrStsGrapVOMap.ageDivCd			//연령구분코드
					,age : occrStsGrapVOMap.age					//연령
					,forgCdNaty : occrStsGrapVOMap.forgCdNaty		//외국인코드국적
					,forgCdPosi : occrStsGrapVOMap.forgCdPosi		//외국인코드신분
					,vicmDamgTimeSitu : occrStsGrapVOMap.vicmDamgTimeSitu	//피해자피해시상황
					,occrAreaDiv : occrStsGrapVOMap.occrAreaDiv		//발생지구분
					,occrArea : occrStsGrapVOMap.occrArea			//발생지
					,occrPla : occrStsGrapVOMap.occrPla			//발생장소
					,propDamgDegr : occrStsGrapVOMap.propDamgDegr		//재산피해정도
					,damgAmtMony : occrStsGrapVOMap.damgAmtMony		//피해액화폐
					,damgAmtCar : occrStsGrapVOMap.damgAmtCar		//피해액자동차
					,damgAmtMarkSecu : occrStsGrapVOMap.damgAmtMarkSecu	//피해액유가증권
					,damgAmtJewy : occrStsGrapVOMap.damgAmtJewy			//피해액귀금속
					,damgAmtElecElenProd : occrStsGrapVOMap.damgAmtElecElenProd	//피해액전기전자제품
					,damgAmtMocyBike : occrStsGrapVOMap.damgAmtMocyBike		//피해액오토바이자전거
					,damgAmtFurnArtc : occrStsGrapVOMap.damgAmtFurnArtc		//피해액가구류
					,damgAmtClot : occrStsGrapVOMap.damgAmtClot			//피해액의류
					,damgAmtMach : occrStsGrapVOMap.damgAmtMach			//피해액기계류
					,damgAmtFarmFortProd : occrStsGrapVOMap.damgAmtFarmFortProd	//피해액농임산물
					,damgAmtAmhbProd : occrStsGrapVOMap.damgAmtAmhbProd		//피해액축산물
					,damgAmtMarnProd : occrStsGrapVOMap.damgAmtMarnProd		//피해액수산물
					,damgAmtMcgd : occrStsGrapVOMap.damgAmtMcgd			//피해액잡화
					,damgAmtEtc : occrStsGrapVOMap.damgAmtEtc			//피해액기타
					,damgAmtTot : occrStsGrapVOMap.damgAmtTot			//피해액합계
					,bodyDamgZero : occrStsGrapVOMap.bodyDamgZero			//신체피해무
					,bodyDamgInjy : occrStsGrapVOMap.bodyDamgInjy			//신체피해상해
					,bodyDamgDeth : occrStsGrapVOMap.bodyDamgDeth			//신체피해사망
					,bodyDamgInjyMan : occrStsGrapVOMap.bodyDamgInjyMan		//신체피해상해남자
					,bodyDamgInjyWomn : occrStsGrapVOMap.bodyDamgInjyWomn		//신체피해상해여자
					,bodyDamgDethMan : occrStsGrapVOMap.bodyDamgDethMan			//신체피해사망남자
					,bodyDamgDethWomn : occrStsGrapVOMap.bodyDamgDethWomn		//신체피해사망여자
					,bodyDamgInjyDegr : occrStsGrapVOMap.bodyDamgInjyDegr		//신체피해상해정도
					,incSpNum : $(this).data("incspnum")				//사건피의자번호
					//,rcptNum : $(this).data("rcptnum")					//접수번호
					,actVioNum : $(this).data("actvionum")				//법률위반번호
			}
			
			occrStsGrapVOSubArray.push(occrStsGrapVOSub);
		}
	});
	occrStsGrapVOMap.occrStsGrapVOList = occrStsGrapVOSubArray;
}

//검거통계원표 데이터갱신
function syncArstStsGrapVOMap(){
	
	arstStsGrapVOMap.arstStsGrapNum = getFieldValue($("input[name=arst_arstStsGrapNum]"));		//검거통계원표번호
	arstStsGrapVOMap.stsGrapPublYrmh = getFieldValue($("input[name=arst_stsGrapPublYrmh]"));		//통계원표발행년월
	
	arstStsGrapVOMap.incSpNum = getFieldValue($("input[name=arst_incSpNum]"));		//사건피의자번호
	arstStsGrapVOMap.rcptNum = b0101VOMap.rcptNum;			//통합사건접수번호(사건 재조회를 위한 사건번호이므로 부모사건번호 셋팅)
	arstStsGrapVOMap.actVioNum = getFieldValue($("input[name=arst_actVioNum]"));		//법률위반번호
	
	arstStsGrapVOMap.famyVioYn = getFieldValue($("input[name=arst_famyVioYn]"));				//가정폭력유무
	arstStsGrapVOMap.schlVioYn = getFieldValue($("input[name=arst_schlVioYn]"));				//학교폭력유무
	arstStsGrapVOMap.arstYearMontDt = combineDateToString("arst_arstYearMontDt", false);	//검거년월일
	arstStsGrapVOMap.occrYearMontDt = combineDateToString("arst_occrYearMontDt", false);	//발생년월일
	arstStsGrapVOMap.occrToArstPi = getFieldValue($("select[name=arst_occrToArstPi]"));			//발생부터 검거까지 기간
	arstStsGrapVOMap.criMeth = getFieldValue($("select[name=arst_criMeth]"));					//범죄수법
	arstStsGrapVOMap.trpsEnty = getFieldValue($("select[name=arst_trpsEnty]"));					//침입구
	arstStsGrapVOMap.trpsWay = getFieldValue($("select[name=arst_trpsWay]"));					//침입방법
	arstStsGrapVOMap.arstKornMan = getFieldValue($("input[name=arst_arstKornMan]"));				//검거한국인남자
	arstStsGrapVOMap.arstKornWomn = getFieldValue($("input[name=arst_arstKornWomn]"));			//검거한국인여자
	arstStsGrapVOMap.arstKornCorp = getFieldValue($("input[name=arst_arstKornCorp]"));			//검거한국인법인
	arstStsGrapVOMap.arstForgMan = getFieldValue($("input[name=arst_arstForgMan]"));				//검거외국인남자
	arstStsGrapVOMap.arstForgWomn = getFieldValue($("input[name=arst_arstForgWomn]"));			//검거외국인여자
	arstStsGrapVOMap.arstForgCorp = getFieldValue($("input[name=arst_arstForgCorp]"));			//검거외국인법인
	arstStsGrapVOMap.cmtdUnctClsf = getFieldValue($("select[name=arst_cmtdUnctClsf]"));			//기수,미수별
	arstStsGrapVOMap.acmpNum = getFieldValue($("select[name=arst_acmpNum]"));					//공범수
	arstStsGrapVOMap.criToolType = getFieldValue($("select[name=arst_criToolType]"));			//범행도구 종류
	arstStsGrapVOMap.criToolActn = getFieldValue($("select[name=arst_criToolActn]"));			//범행도구조치
	arstStsGrapVOMap.criToolAcqrWay = getFieldValue($("select[name=arst_criToolAcqrWay]"));		//범행도구 입수방법
	arstStsGrapVOMap.arstClue = getFieldValue($("select[name=arst_arstClue]"));					//검거단서
	arstStsGrapVOMap.stgdDipWay = getFieldValue($("select[name=arst_stgdDipWay]"));				//장물 처분방법
	arstStsGrapVOMap.stgdMonyCospUse = getFieldValue($("select[name=arst_stgdMonyCospUse]"));	//금전소비 용도
	
	arstStsGrapVOMap.collAmtMony = getFieldValue($("input[name=arst_collAmtMony]"));						//회수액화폐
	arstStsGrapVOMap.collAmtCar = getFieldValue($("input[name=arst_collAmtCar]"));						//회수액자동차
	arstStsGrapVOMap.collAmtMarkSecu = getFieldValue($("input[name=arst_collAmtMarkSecu]"));				//회수액유가증권
	arstStsGrapVOMap.collAmtJewy = getFieldValue($("input[name=arst_collAmtJewy]"));						//회수액귀금속
	arstStsGrapVOMap.collAmtElecElenProd = getFieldValue($("input[name=arst_collAmtElecElenProd]"));		//회수액전기전자제품
	arstStsGrapVOMap.collAmtMocyBike = getFieldValue($("input[name=arst_collAmtMocyBike]"));				//회수액오토바이자전거
	arstStsGrapVOMap.collAmtFurnArtc = getFieldValue($("input[name=arst_collAmtFurnArtc]"));				//회수액가구류
	arstStsGrapVOMap.collAmtClot = getFieldValue($("input[name=arst_collAmtClot]"));						//회수액의류
	arstStsGrapVOMap.collAmtMach = getFieldValue($("input[name=arst_collAmtMach]"));						//회수액기계류
	arstStsGrapVOMap.collAmtFarmFortProd = getFieldValue($("input[name=arst_collAmtFarmFortProd]"));		//회수액농임산물
	arstStsGrapVOMap.collAmtAmhbProd = getFieldValue($("input[name=arst_collAmtAmhbProd]"));				//회수액축산물
	arstStsGrapVOMap.collAmtMarnProd = getFieldValue($("input[name=arst_collAmtMarnProd]"));				//회수액수산물
	arstStsGrapVOMap.collAmtMcgd = getFieldValue($("input[name=arst_collAmtMcgd]"));		//회수액잡화
	arstStsGrapVOMap.collAmtEtc = getFieldValue($("input[name=arst_collAmtEtc]"));		//회수액기타
	arstStsGrapVOMap.collAmtTot = getFieldValue($("#arst_collAmtTot"));					//회수액합계
	arstStsGrapVOMap.collDegrCd = getFieldValue($("select[name=arst_collDegrCd]"));		//회수정도
	
	
	//같은위법조항에 대해서도 같이 업데이트 해준다. 
	var arst_rltActCriNmCd = $("#arst_rltActCriNmCd").val();
	var arstStsGrapNum = $("#arst_arstStsGrapNum").val();
	var arstRcptNum = $("#arst_rcptNum").val();
	var arstStsGrapVOSubArray = new Array();
	
	$("a[data-name=arstStsGrapBtn]").each(function(){
		
		if(arst_rltActCriNmCd == $(this).data("rltactcrinmcd") && arstRcptNum == $(this).data("rcptnum")){
			var arstStsGrapVOSub = {
					arstStsGrapNum : $(this).data("arststsgrapnum")	//검거통계원표번호
					,stsGrapPublYrmh : arstStsGrapVOMap.stsGrapPublYrmh	//통계원표발행년월
					,famyVioYn : arstStsGrapVOMap.famyVioYn 			//가정폭력유무
					,schlVioYn : arstStsGrapVOMap.schlVioYn			//학교폭력유무
					,arstYearMontDt : arstStsGrapVOMap.arstYearMontDt	//검거년월일
					,occrYearMontDt : arstStsGrapVOMap.occrYearMontDt	//발생년월일
					,occrToArstPi : arstStsGrapVOMap.occrToArstPi		//발생부터검거까지기간
					,criMeth : arstStsGrapVOMap.criMeth			//범죄수법
					,trpsEnty : arstStsGrapVOMap.trpsEnty			//침입구
					,trpsWay : arstStsGrapVOMap.trpsWay			//침입방법
					,arstKornMan : arstStsGrapVOMap.arstKornMan		//검거한국인남자
					,arstKornWomn : arstStsGrapVOMap.arstKornWomn		//검거한국인여자
					,arstKornCorp : arstStsGrapVOMap.arstKornCorp		//검거한국인법인
					,arstForgMan : arstStsGrapVOMap.arstForgMan		//검거외국인남자
					,arstForgWomn : arstStsGrapVOMap.arstForgWomn		//검거외국인여자
					,arstForgCorp : arstStsGrapVOMap.arstForgCorp		//검거회국인법인
					,cmtdUnctClsf : arstStsGrapVOMap.cmtdUnctClsf		//기수미수별
					,acmpNum : arstStsGrapVOMap.acmpNum			//공범수
					,criToolType : arstStsGrapVOMap.criToolType		//범행도구종류
					,criToolActn : arstStsGrapVOMap.criToolActn		//범행도구조치
					,criToolAcqrWay : arstStsGrapVOMap.criToolAcqrWay	//범행도구입수방법
					,arstClue : arstStsGrapVOMap.arstClue			//검거단서
					,stgdDipWay : arstStsGrapVOMap.stgdDipWay		//장물처분방법
					,stgdMonyCospUse : arstStsGrapVOMap.stgdMonyCospUse	//장물금전소비용도
					,collAmtMony : arstStsGrapVOMap.collAmtMony		//회수액화폐
					,collAmtCar : arstStsGrapVOMap.collAmtCar		//회수액자동차
					,collAmtMarkSecu : arstStsGrapVOMap.collAmtMarkSecu	//회수액유가증권
					,collAmtJewy : arstStsGrapVOMap.collAmtJewy		//회수액귀금속
					,collAmtElecElenProd : arstStsGrapVOMap.collAmtElecElenProd	//회수액전기전자제품
					,collAmtMocyBike : arstStsGrapVOMap.collAmtMocyBike		//회수액오토바이자전거
					,collAmtFurnArtc : arstStsGrapVOMap.collAmtFurnArtc		//회수액가구류
					,collAmtClot : arstStsGrapVOMap.collAmtClot			//회수액의류
					,collAmtMach : arstStsGrapVOMap.collAmtMach			//회수액기계류
					,collAmtFarmFortProd : arstStsGrapVOMap.collAmtFarmFortProd	//회수액농임산물
					,collAmtAmhbProd : arstStsGrapVOMap.collAmtAmhbProd		//회수액축산물
					,collAmtMarnProd : arstStsGrapVOMap.collAmtMarnProd		//회수액수산물
					,collAmtMcgd : arstStsGrapVOMap.collAmtMcgd			//회수액잡화
					,collAmtEtc : arstStsGrapVOMap.collAmtEtc			//회수액기타
					,collAmtTot : arstStsGrapVOMap.collAmtTot			//회수액합계
					,collDegrCd : arstStsGrapVOMap.collDegrCd			//회수정도코드
					,incSpNum : $(this).data("incspnum")				//사건피의자번호
					//,rcptNum : $(this).data("rcptnum")				//사건접수번호
					,actVioNum : $(this).data("actvionum")				//법률위반번호
			}
			
			arstStsGrapVOSubArray.push(arstStsGrapVOSub);
		}
	});
	arstStsGrapVOMap.arstStsGrapVOList = arstStsGrapVOSubArray;
}

//피의자통계원표 데이터갱신
function syncSpStsGrapVOMap(){
	
	spStsGrapVOMap.spStsGrapNum = getFieldValue($("input[name=sp_spStsGrapNum]"));			//피의자통계원표번호
	spStsGrapVOMap.stsGrapPublYrmh = getFieldValue($("input[name=sp_stsGrapPublYrmh]"));		//통계원표발행년월
	
	spStsGrapVOMap.incSpNum = getFieldValue($("input[name=sp_incSpNum]"));			//사건피의자번호
	spStsGrapVOMap.rcptNum = b0101VOMap.rcptNum;			//통합사건접수번호(사건 재조회를 위한 사건번호이므로 부모사건번호 셋팅)
	spStsGrapVOMap.actVioNum = getFieldValue($("input[name=sp_actVioNum]"));		//법률번호
	
	spStsGrapVOMap.famyVioYn = getFieldValue($("input[name=sp_famyVioYn]"));			//가정폭력유무
	spStsGrapVOMap.schlVioYn = getFieldValue($("input[name=sp_schlVioYn]"));			//학교폭력유무
	spStsGrapVOMap.forgCdNaty = getFieldValue($("input[name=sp_forgCdNaty]"));		//외국인코드국적
	spStsGrapVOMap.forgCdPosi = getFieldValue($("input[name=sp_forgCdPosi]"));		//외국인코드신분
	spStsGrapVOMap.criTimeAge = getFieldValue($("input[name=sp_criTimeAge]"));		//범행시연령
	spStsGrapVOMap.gendDiv = getFieldValue($("input[name=sp_gendDiv]"));			//피의자성별
	
	spStsGrapVOMap.jobCd = getFieldValue($("select[name=sp_jobCd]"));				//직업코드
	
	//공무원일 경우에만 값을 셋팅함
	if(spStsGrapVOMap.jobCd == "00"){
		spStsGrapVOMap.puofBelgCd = getFieldValue($("input[name=sp_puofBelgCd]"));		//공무원소속코드
		spStsGrapVOMap.puofClasCd = getFieldValue($("input[name=sp_puofClasCd]"));		//공무원계급코드
		spStsGrapVOMap.puofDutyRelv = getFieldValue($("input[name=sp_puofDutyRelv]"));	//공무원직무관련성
	}else{
		spStsGrapVOMap.puofBelgCd = "";		//공무원소속코드
		spStsGrapVOMap.puofClasCd = "";		//공무원계급코드
		spStsGrapVOMap.puofDutyRelv = "";	//공무원직무관련성
	}
	
	spStsGrapVOMap.crrdCd = getFieldValue($("select[name=sp_crrdCd]"));				//전과코드
	spStsGrapVOMap.secvSituLastDipCont = getFieldValue($("select[name=sp_secvSituLastDipCont]"));		//재범상황전회처분내용
	spStsGrapVOMap.secvSituProtDip = getFieldValue($("select[name=sp_secvSituProtDip]"));	//재범상황보호처분
	spStsGrapVOMap.secvSituSecvPi = getFieldValue($("select[name=sp_secvSituSecvPi]"));		//재범상황재범기간
	spStsGrapVOMap.secvSituSecvType = getFieldValue($("select[name=sp_secvSituSecvType]"));	//재범상황재범종류
	spStsGrapVOMap.acmpRelt = getFieldValue($("select[name=sp_acmpRelt]"));					//공범관계
	spStsGrapVOMap.vicmRelt = getFieldValue($("select[name=sp_vicmRelt]"));					//피해자와의관계
	spStsGrapVOMap.criAftrHdot = getFieldValue($("select[name=sp_criAftrHdot]"));			//범행후은신처
	spStsGrapVOMap.drugCmusYn = getFieldValue($("select[name=sp_drugCmusYn]"));				//마약류등상용여부
	spStsGrapVOMap.criTimeMindStat = getFieldValue($("select[name=sp_criTimeMindStat]"));	//범행시정신상태
	spStsGrapVOMap.criMotv = getFieldValue($("select[name=sp_criMotv]"));					//범행동기
	spStsGrapVOMap.acab = getFieldValue($("select[name=sp_acab]"));							//학력
	
	spStsGrapVOMap.livgDegr = getFieldValue($("select[name=sp_livgDegr]"));		//생활정도
	spStsGrapVOMap.relg = getFieldValue($("select[name=sp_relg]"));				//종교
	spStsGrapVOMap.margRelt = getFieldValue($("select[name=sp_margRelt]"));		//혼인관계
	spStsGrapVOMap.pareRelt = getFieldValue($("select[name=sp_pareRelt]"));		//부모관계
	spStsGrapVOMap.arstPolf = getFieldValue($("select[name=sp_arstPolf]"));		//검거자(경찰)
	spStsGrapVOMap.actn = getFieldValue($("select[name=sp_actn]"));				//조치
	spStsGrapVOMap.confYn = getFieldValue($("select[name=sp_confYn]"));			//자백여부
	spStsGrapVOMap.arrtClsf = getFieldValue($("select[name=sp_arrtClsf]"));		//구속별
	spStsGrapVOMap.nonArrtClsf = getFieldValue($("select[name=sp_nonArrtClsf]"));	//불구속별
	spStsGrapVOMap.trfOp = getFieldValue($("select[name=sp_trfOp]"));				//송치의견
	spStsGrapVOMap.incHandPi = getFieldValue($("select[name=sp_incHandPi]"));		//사건처리기간
	
}

//날짜(년월일시) 통합코드
//targetId = 대상Id
function combineDateToString(targetId, isTime){
	var _year = $("select[name="+targetId+"_year] option:selected").val();
	var _month = $("select[name="+targetId+"_month] option:selected").val();
	var _day = $("select[name="+targetId+"_day] option:selected").val();
	
	if(isTime){
		var _time = $("select[name="+targetId+"_time] option:selected").val();
		return pad(_year,"4") + pad(_month,"2") + pad(_day,"2") + pad(_time,"2");
	}else{
		return pad(_year,"4") + pad(_month,"2") + pad(_day,"2");
	}
}

//날짜(년월일) 통합코드
//targetId = 대상Id
function combineDayToString(targetId){
	var _year = $("select[name="+targetId+"_year] option:selected").val();
	var _month = $("select[name="+targetId+"_month] option:selected").val();
	var _day = $("select[name="+targetId+"_day] option:selected").val();
	
	return pad(_year,"4") + pad(_month,"2") + pad(_day,"2");
}

//TODO 삭제 or 공통 필요 - select박스 select하는 함수
function setSelectBoxIndex(_$obj, index){
	_$obj.find("option:eq("+index+")").prop("selected", true);
	_$obj.prev('.txt').text(_$obj.find('option:selected').text());
}

function setSelectBoxValue(_$obj, value, isTxt){
	_$obj.find("option[value="+value+"]").prop("selected", true);
	if(isTxt){
		_$obj.prev('.txt').text(_$obj.find('option:selected').text());
	}
}


function initOccrStsGrapVOMap() {	
	occrStsGrapVOMap = {
			rcptNum : ""			//사건접수번호
			,occrStsGrapNum : ""	//발생통계원표번호
			,stsGrapPublYrmh : ""	//통계원표발행년월
			,famyVioYnCd : ""		//가정폭력유무
			,schlVioYnCd : ""		//학교폭력유무
			,forgSpYnCd : ""		//외국인피의자유무
			,occrYrmhDtDivCd : ""	//발생년월일시구분코드
			,occrYrmhDt : ""		//발생년월일시
			,occrDotw : ""			//발생요일
			,recgYrmhDt : ""		//인지년월일시
			,recgDotW : ""			//인지요일
			,occrToRecgPi : ""		//발생부터인지까지기간
			,criMeth : ""			//범죄수법
			,occrDtSpelSitu : ""	//발생일특수사정
			,criTimeWeth : ""		//범행시일기
			,criClue : ""			//수사단서
			,undcRsn : ""			//미신고이유
			,vicm : ""				//피해자
			,ageDivCd : ""			//연령구분코드
			,age : ""				//연령
			,forgCdNaty : ""		//외국인코드국적
			,forgCdPosi : ""		//외국인코드신분
			,vicmDamgTimeSitu : ""	//피해자피해시상황
			,occrAreaDiv : ""		//발생지구분
			,occrArea : ""			//발생지
			,occrPla : ""			//발생장소
			,propDamgDegr : ""		//재산피해정도
			,damgAmtMony : ""		//피해액화폐
			,damgAmtCar : ""		//피해액자동차
			,damgAmtMarkSecu : ""	//피해액유가증권
			,damgAmtJewy : ""			//피해액귀금속
			,damgAmtElecElenProd : ""	//피해액전기전자제품
			,damgAmtMocyBike : ""		//피해액오토바이자전거
			,damgAmtFurnArtc : ""		//피해액가구류
			,damgAmtClot : ""			//피해액의류
			,damgAmtMach : ""			//피해액기계류
			,damgAmtFarmFortProd : ""	//피해액농임산물
			,damgAmtAmhbProd : ""		//피해액축산물
			,damgAmtMarnProd : ""		//피해액수산물
			,damgAmtMcgd : ""			//피해액잡화
			,damgAmtEtc : ""			//피해액기타
			,damgAmtTot : ""			//피해액합계
			,bodyDamgZero : ""			//신체피해무
			,bodyDamgInjy : ""			//신체피해상해
			,bodyDamgDeth : ""			//신체피해사망
			,bodyDamgInjyMan : ""		//신체피해상해남자
			,bodyDamgInjyWomn : ""		//신체피해상해여자
			,bodyDamgDethMan : ""		//신체피해사망남자
			,bodyDamgDethWomn : ""		//신체피해사망여자
			,bodyDamgInjyDegr : ""		//신체피해상해정도
			,incSpNum : ""				//사건피의자번호
			,rcptNum : ""				//접수번호
			,actVioNum : ""				//법률위반번호
			,regUserId : ""				//등록자
			,regDate : ""        		//등록일자
			,updUserId : ""      		//수정자
			,updDate : ""        		//수정일자
			,occrStsGrapVOList : null	//발생통계원표리스트(같은위법조항일때 여기에 넣어서 업데이트한다)
	}
}

function initArstStsGrapVOMap() {	
	arstStsGrapVOMap = {
			arstStsGrapNum : ""		//검거통계원표번호
			,stsGrapPublYrmh : ""	//통계원표발행년월
			,famyVioYn : ""			//가정폭력유무
			,schlVioYn : ""			//학교폭력유무
			,arstYearMontDt : ""	//검거년월일
			,occrYearMontDt : ""	//발생년월일
			,occrToArstPi : ""		//발생부터검거까지기간
			,criMeth : ""			//범죄수법
			,trpsEnty : ""			//침입구
			,trpsWay : ""			//침입방법
			,arstKornMan : ""		//검거한국인남자
			,arstKornWomn : ""		//검거한국인여자
			,arstKornCorp : ""		//검거한국인법인
			,arstForgMan : ""		//검거외국인남자
			,arstForgWomn : ""		//검거외국인여자
			,arstForgCorp : ""		//검거회국인법인
			,cmtdUnctClsf : ""		//기수미수별
			,acmpNum : ""			//공범수
			,criToolType : ""		//범행도구종류
			,criToolActn : ""		//범행도구조치
			,criToolAcqrWay : ""	//범행도구입수방법
			,arstClue : ""			//검거단서
			,stgdDipWay : ""		//장물처분방법
			,stgdMonyCospUse : ""	//장물금전소비용도
			,collAmtMony : ""		//회수액화폐
			,collAmtCar : ""		//회수액자동차
			,collAmtMarkSecu : ""	//회수액유가증권
			,collAmtJewy : ""		//회수액귀금속
			,collAmtElecElenProd : ""	//회수액전기전자제품
			,collAmtMocyBike : ""		//회수액오토바이자전거
			,collAmtFurnArtc : ""		//회수액가구류
			,collAmtClot : ""			//회수액의류
			,collAmtMach : ""			//회수액기계류
			,collAmtFarmFortProd : ""	//회수액농임산물
			,collAmtAmhbProd : ""		//회수액축산물
			,collAmtMarnProd : ""		//회수액수산물
			,collAmtMcgd : ""			//회수액잡화
			,collAmtEtc : ""			//회수액기타
			,collAmtTot : ""			//회수액합계
			,collDegrCd : ""			//회수정도코드
			,incSpNum : ""				//사건피의자번호
			,rcptNum : ""				//사건접수번호
			,actVioNum : ""				//법률위반번호
			,regUserId : ""				//등록자
			,regDate : ""				//등록일자
			,updUserId : ""				//수정자
			,updDate : ""				//수정일자
			,arstStsGrapVOList : null	//검거통계원표리스트(같은위법조항일때 여기에 넣어서 업데이트한다)
	}
}

//피의자 통계원표 초기화
function initSpStsGrapVOMap() {
	spStsGrapVOMap = {
		spStsGrapNum : ""			//피의자통계원표번호
		,stsGrapPublYrmh : ""		//통계원표발행년월
		,famyVioYn : ""				//가정폭력유무
		,schlVioYn : ""				//학교폭력유무
		,forgCdNaty : ""			//외국인코드국적
		,forgCdPosi : ""			//외국인코드신분
		,criTimeAge : ""			//범행시연령
		,gendDiv : ""				//성별
		,jobCd : ""					//직업코드
		,puofBelgCd : ""			//공무원소속코드
		,puofClasCd : ""			//공무원계급코드
		,puofDutyRelv : ""			//공무원직무관련성
		,crrdCd : ""				//전과코드
		,secvSituLastDipCont : ""	//재범상황전회처분내용
		,secvSituProtDip : ""		//재범상황보호처분
		,secvSituSecvPi : ""		//재범상황재범기간
		,secvSituSecvType : ""		//재범상황재범종류
		,acmpRelt : ""				//공범관계
		,vicmRelt : ""				//피해자와의관계
		,criAftrHdot : ""			//범행후은신처
		,drugCmusYn : ""			//마약류등상용여부
		,criTimeMindStat : ""		//범행시정신상태
		,criMotv : ""				//범행동기
		,acab : ""					//학력
		,livgDegr : ""				//생활정도
		,relg : ""					//종교
		,margRelt : ""				//혼인관계
		,pareRelt : ""				//부모관계
		,arstPolf : ""				//검거자(경찰)
		,actn : ""					//조치
		,confYn : ""				//자백여부
		,arrtClsf : ""				//구속별
		,nonArrtClsf : ""			//불구속별
		,trfOp : ""					//송치의견
		,incHandPi : ""				//사건처리기간
		,incSpNum : ""				//사건피의자번호
		,actVioNum : ""				//법률위반번호
		,regUserId : ""				//등록자
		,regDate : ""				//등록일자
		,updUserId : ""				//수정자
		,updDate : ""				//수정일자
	}
}

//Map 데이터 초기화
function initIncSpVOGrapMap(){
	incSpVOGrapMap = {
			incSpNum : "" 		//사건피의자번호	
			,indvCorpDiv : ""	//개인법인구분
			,spNm : ""			//피의자명
			,spIdNum : ""		//피의자식별번호
			,spHomcForcPernDiv : ""	//내외국인구분
		}
}

//Map 데이터 초기화
function initB0102VOMap(){
	b0102VOMap = {
		incNum : ""		//사건번호
	}
}

//발생통계원표 
var occrStsGrapVOMap = {
		rcptNum : ""			//사건접수번호
		,occrStsGrapNum : ""		//발생통계원표번호
		,stsGrapPublYrmh : ""	//통계원표발행년월
		,famyVioYnCd : ""		//가정폭력유무
		,schlVioYnCd : ""		//학교폭력유무
		,forgSpYnCd : ""		//외국인피의자유무
		,occrYrmhDtDivCd : ""	//발생년월일시구분코드
		,occrYrmhDt : ""		//발생년월일시
		,occrDotw : ""			//발생요일
		,recgYrmhDt : ""		//인지년월일시
		,recgDotw : ""			//인지요일
		,occrToRecgPi : ""		//발생부터인지까지기간
		,criMeth : ""			//범죄수법
		,occrDtSpelSitu : ""	//발생일특수사정
		,criTimeWeth : ""		//범행시일기
		,criClue : ""			//수사단서
		,undcRsn : ""			//미신고이유
		,vicm : ""				//피해자
		,ageDivCd : ""			//연령구분코드
		,age : ""				//연령
		,forgCdNaty : ""		//외국인코드국적
		,forgCdPosi : ""		//외국인코드신분
		,vicmDamgTimeSitu : ""	//피해자피해시상황
		,occrAreaDiv : ""		//발생지구분
		,occrArea : ""			//발생지
		,occrPla : ""			//발생장소
		,propDamgDegr : ""		//재산피해정도
		,damgAmtMony : ""		//피해액화폐
		,damgAmtCar : ""		//피해액자동차
		,damgAmtMarkSecu : ""	//피해액유가증권
		,damgAmtJewy : ""			//피해액귀금속
		,damgAmtElecElenProd : ""	//피해액전기전자제품
		,damgAmtMocyBike : ""		//피해액오토바이자전거
		,damgAmtFurnArtc : ""		//피해액가구류
		,damgAmtClot : ""			//피해액의류
		,damgAmtMach : ""			//피해액기계류
		,damgAmtFarmFortProd : ""	//피해액농임산물
		,damgAmtAmhbProd : ""		//피해액축산물
		,damgAmtMarnProd : ""		//피해액수산물
		,damgAmtMcgd : ""			//피해액잡화
		,damgAmtEtc : ""			//피해액기타
		,damgAmtTot : ""			//피해액합계
		,bodyDamgZero : ""			//신체피해무
		,bodyDamgInjy : ""			//신체피해상해
		,bodyDamgDeth : ""			//신체피해사망
		,bodyDamgInjyMan : ""		//신체피해상해남자
		,bodyDamgInjyWomn : ""		//신체피해상해여자
		,bodyDamgDethMan : ""		//신체피해사망남자
		,bodyDamgDethWomn : ""		//신체피해사망여자
		,bodyDamgInjyDegr : ""		//신체피해상해정도
		,incSpNum : ""				//사건피의자번호
		,rcptNum : ""				//접수번호
		,actVioNum : ""				//법률위반번호
		,regUserId : ""				//등록자
		,regDate : ""        		//등록일자
		,updUserId : ""      		//수정자
		,updDate : ""        		//수정일자
	}

//검거통계원표
var arstStsGrapVOMap = {
		arstStsGrapNum : ""		//검거통계원표번호
		,stsGrapPublYrmh : ""	//통계원표발행년월
		,famyVioYn : ""			//가정폭력유무
		,schlVioYn : ""			//학교폭력유무
		,arstYearMontDt : ""	//검거년월일
		,occrYearMontDt : ""	//발생년월일
		,occrToArstPi : ""		//발생부터검거까지기간
		,criMeth : ""			//범죄수법
		,trpsEnty : ""			//침입구
		,trpsWay : ""			//침입방법
		,arstKornMan : ""		//검거한국인남자
		,arstKornWomn : ""		//검거한국인여자
		,arstKornCorp : ""		//검거한국인법인
		,arstForgMan : ""		//검거외국인남자
		,arstForgWomn : ""		//검거외국인여자
		,arstForgCorp : ""		//검거회국인법인
		,cmtdUnctClsf : ""		//기수미수별
		,acmpNum : ""			//공범수
		,criToolType : ""		//범행도구종류
		,criToolActn : ""		//범행도구조치
		,criToolAcqrWay : ""	//범행도구입수방법
		,arstClue : ""			//검거단서
		,stgdDipWay : ""		//장물처분방법
		,stgdMonyCospUse : ""	//장물금전소비용도
		,collAmtMony : ""		//회수액화폐
		,collAmtCar : ""		//회수액자동차
		,collAmtMarkSecu : ""	//회수액유가증권
		,collAmtJewy : ""		//회수액귀금속
		,collAmtElecElenProd : ""	//회수액전기전자제품
		,collAmtMocyBike : ""		//회수액오토바이자전거
		,collAmtFurnArtc : ""		//회수액가구류
		,collAmtClot : ""			//회수액의류
		,collAmtMach : ""			//회수액기계류
		,collAmtFarmFortProd : ""	//회수액농임산물
		,collAmtAmhbProd : ""		//회수액축산물
		,collAmtMarnProd : ""		//회수액수산물
		,collAmtMcgd : ""			//회수액잡화
		,collAmtEtc : ""			//회수액기타
		,collAmtTot : ""			//회수액합계
		,collDegrCd : ""			//회수정도코드
		,incSpNum : ""				//사건피의자번호
		,rcptNum : ""				//사건접수번호
		,actVioNum : ""				//법률위반번호
		,regUserId : ""				//등록자
		,regDate : ""				//등록일자
		,updUserId : ""				//수정자
		,updDate : ""				//수정일자
}

//피의자 통계원표 
var spStsGrapVOMap = {
		spStsGrapNum : ""			//피의자통계원표번호
		,stsGrapPublYrmh : ""		//통계원표발행년월
		,famyVioYn : ""				//가정폭력유무
		,schlVioYn : ""				//학교폭력유무
		,forgCdNaty : ""			//외국인코드국적
		,forgCdPosi : ""			//외국인코드신분
		,criTimeAge : ""			//범행시연령
		,gendDiv : ""				//성별
		,jobCd : ""					//직업코드
		,puofBelgCd : ""			//공무원소속코드
		,puofClasCd : ""			//공무원계급코드
		,puofDutyRelv : ""			//공무원직무관련성
		,crrdCd : ""				//전과코드
		,secvSituLastDipCont : ""	//재범상황전회처분내용
		,secvSituProtDip : ""		//재범상황보호처분
		,secvSituSecvPi : ""		//재범상황재범기간
		,secvSituSecvType : ""		//재범상황재범종류
		,acmpRelt : ""				//공범관계
		,vicmRelt : ""				//피해자와의관계
		,criAftrHdot : ""			//범행후은신처
		,drugCmusYn : ""			//마약류등상용여부
		,criTimeMindStat : ""		//범행시정신상태
		,criMotv : ""				//범행동기
		,acab : ""					//학력
		,livgDegr : ""				//생활정도
		,relg : ""					//종교
		,margRelt : ""				//혼인관계
		,pareRelt : ""				//부모관계
		,arstPolf : ""				//검거자(경찰)
		,actn : ""					//조치
		,confYn : ""				//자백여부
		,arrtClsf : ""				//구속별
		,nonArrtClsf : ""			//불구속별
		,trfOp : ""					//송치의견
		,incHandPi : ""				//사건처리기간
		,incSpNum : ""				//사건피의자번호
		,actVioNum : ""				//법률위반번호
		,regUserId : ""				//등록자
		,regDate : ""				//등록일자
		,updUserId : ""				//수정자
		,updDate : ""				//수정일자
}

//피의자 통계원표 피의자 정보
var incSpVOGrapMap = {
	incSpNum : "" 		//사건피의자번호	
	,indvCorpDiv : ""	//개인법인구분
	,spNm : ""			//피의자명
	,spIdNum : ""		//피의자식별번호
	,spHomcForcPernDiv : ""	//내외국인구분
}

//발생통계원표 발생지 
var jsonOccrAreaArray = 
{
	//서울
	"01":[
		{"label":"1-1. 종로","value":"1-1"}
		,{"label":"1-2. 중구","value":"1-2"}
		,{"label":"1-3. 용산","value":"1-3"}
		,{"label":"1-4. 성동","value":"1-4"}
		,{"label":"1-5. 광진","value":"1-5"}
		,{"label":"1-6. 동대문","value":"1-6"}
		,{"label":"1-7. 중랑","value":"1-7"}
		,{"label":"1-8. 성북","value":"1-8"}
		,{"label":"1-9. 강북","value":"1-9"}
		,{"label":"1-10. 도봉","value":"1-10"}
		,{"label":"1-11. 노원","value":"1-11"}
		,{"label":"1-12. 은평","value":"1-12"}
		,{"label":"1-13. 서대문","value":"1-13"}
		,{"label":"1-14. 마포","value":"1-14"}
		,{"label":"1-15. 양천","value":"1-15"}
		,{"label":"1-16. 강서","value":"1-16"}
		,{"label":"1-17. 구로","value":"1-17"}
		,{"label":"1-18. 금천","value":"1-18"}
		,{"label":"1-19. 영등포","value":"1-19"}
		,{"label":"1-20. 동작","value":"1-20"}
		,{"label":"1-21. 관악","value":"1-21"}
		,{"label":"1-22. 서초","value":"1-22"}
		,{"label":"1-23. 강남","value":"1-23"}
		,{"label":"1-24. 송파","value":"1-24"}
		,{"label":"1-25. 강동","value":"1-25"}
	]

	//부산
	,"02":[
		{"label":"2-1. 중구","value":"2-1"}
		,{"label":"2-2. 서구","value":"2-2"}
		,{"label":"2-3. 동구","value":"2-3"}
		,{"label":"2-4. 영도","value":"2-4"}
		,{"label":"2-5. 부산진","value":"2-5"}
		,{"label":"2-6. 동래","value":"2-6"}
		,{"label":"2-7. 남구","value":"2-7"}
		,{"label":"2-8. 북구","value":"2-8"}
		,{"label":"2-9. 해운대","value":"2-9"}
		,{"label":"2-10. 사하","value":"2-10"}
		,{"label":"2-11. 금정","value":"2-11"}
		,{"label":"2-12. 강서","value":"2-12"}
		,{"label":"2-13. 연재","value":"2-13"}
		,{"label":"2-14. 수영","value":"2-14"}
		,{"label":"2-15. 사상","value":"2-15"}
		,{"label":"2-16. 기장","value":"2-16"}
	]

	//대구
	,"03":[
		{"label":"3-1. 중구","value":"3-1"}
		,{"label":"3-2. 동구","value":"3-2"}
		,{"label":"3-3. 서구","value":"3-3"}
		,{"label":"3-4. 남구","value":"3-4"}
		,{"label":"3-5. 북구","value":"3-5"}
		,{"label":"3-6. 수성","value":"3-6"}
		,{"label":"3-7. 달서","value":"3-7"}
		,{"label":"3-8. 달성","value":"3-8"}
	]

	//인천
	,"04":[
		{"label":"4-1. 중구","value":"4-1"}
		,{"label":"4-2. 동구","value":"4-2"}
		,{"label":"4-3. 서구","value":"4-3"}
		,{"label":"4-4. 남구","value":"4-4"}
		,{"label":"4-5. 연수","value":"4-5"}
		,{"label":"4-6. 남동","value":"4-6"}
		,{"label":"4-7. 부평","value":"4-7"}
		,{"label":"4-8. 계양","value":"4-8"}
		,{"label":"4-9. 강화","value":"4-9"}
		,{"label":"4-10. 웅진","value":"4-10"}
	]

	//광주
	,"05":[
		{"label":"5-1. 동구","value":"5-1"}
		,{"label":"5-2. 서구","value":"5-2"}
		,{"label":"5-3. 남구","value":"5-3"}
		,{"label":"5-4. 북구","value":"5-4"}
		,{"label":"5-5. 광산","value":"5-5"}
	]

	//대전
	,"06":[
		{"label":"6-1. 중구","value":"6-1"}
		,{"label":"6-2. 동구","value":"6-2"}
		,{"label":"6-3. 서구","value":"6-3"}
		,{"label":"6-4. 유성","value":"6-4"}
		,{"label":"6-5. 대덕","value":"6-5"}
	]

	//울산
	,"07":[
		{"label":"7-1. 중구","value":"7-1"}
		,{"label":"7-2. 동구","value":"7-2"}
		,{"label":"7-3. 남구","value":"7-3"}
		,{"label":"7-4. 북구","value":"7-4"}
		,{"label":"7-5. 울주","value":"7-5"}
		,{"label":"54. 세종","value":"54"}
	]

	//경기
	,"08":[
		{"label":"8. 부천","value":"8"}
		,{"label":"9. 수원","value":"9"}
		,{"label":"10. 성남","value":"10"}
		,{"label":"12. 안양","value":"12"}
		,{"label":"16. 광명","value":"16"}
		,{"label":"18. 안산","value":"18"}
		,{"label":"20. 고양","value":"20"}
		,{"label":"23. 의정부","value":"23"}
		,{"label":"31. 평택","value":"31"}
		,{"label":"35. 군포","value":"35"}
		,{"label":"36. 남양주","value":"36"}
		,{"label":"45. 용인","value":"45"}
		,{"label":"46. 시흥","value":"46"}
		,{"label":"47. 파주","value":"47"}
		,{"label":"49. 이천","value":"49"}
		,{"label":"50. 구리","value":"50"}
		,{"label":"55. 동두천","value":"55"}
		,{"label":"56. 과천","value":"56"}
		,{"label":"57. 오산","value":"57"}
		,{"label":"58. 의왕","value":"58"}
		,{"label":"59. 하남","value":"59"}
		,{"label":"60. 안성","value":"60"}
		,{"label":"61. 김포","value":"61"}
		,{"label":"62. 화성","value":"62"}
		,{"label":"63. 광주","value":"63"}
		,{"label":"64. 양주","value":"64"}
		,{"label":"65. 포천","value":"65"}
		,{"label":"66. 여주","value":"66"}
	]
//	,"08":[
//		{"label":"9. 수원","value":"9"}
//		,{"label":"10. 성남","value":"10"}
//		,{"label":"23. 의정부","value":"23"}
//		,{"label":"12. 안양","value":"12"}
//		,{"label":"8. 부천","value":"8"}
//		,{"label":"16. 광명","value":"16"}
//		,{"label":"31. 평택","value":"31"}
//		,{"label":"55. 동두천","value":"55"}
//		,{"label":"18. 안산","value":"18"}
//		,{"label":"20. 고양","value":"20"}
//		,{"label":"56. 과천","value":"56"}
//		,{"label":"50. 구리","value":"50"}
//		,{"label":"36. 남양주","value":"36"}
//		,{"label":"57. 오산","value":"57"}
//		,{"label":"46. 시흥","value":"46"}
//		,{"label":"35. 군포","value":"35"}
//		,{"label":"58. 의왕","value":"58"}
//		,{"label":"59. 하남","value":"59"}
//		,{"label":"45. 용인","value":"45"}
//		,{"label":"47. 파주","value":"47"}
//		,{"label":"49. 이천","value":"49"}
//		,{"label":"60. 안성","value":"60"}
//		,{"label":"61. 김포","value":"61"}
//		,{"label":"62. 화성","value":"62"}
//		,{"label":"63. 광주","value":"63"}
//		,{"label":"64. 양주","value":"64"}
//		,{"label":"65. 포천","value":"65"}
//		,{"label":"66. 여주","value":"66"}
//	]

	//강원
	,"09":[
		{"label":"29. 춘천","value":"29"}
		,{"label":"30. 원주","value":"30"}
		,{"label":"37. 강릉","value":"37"}
		,{"label":"67. 동해","value":"67"}
		,{"label":"68. 태백","value":"68"}
		,{"label":"69. 속초","value":"69"}
		,{"label":"70. 삼척","value":"70"}
	]

	//충청
	,"10":[
		{"label":"13. 청주","value":"13"}
		,{"label":"27. 천안","value":"27"}
		,{"label":"38. 충주","value":"38"}
		,{"label":"41. 아산","value":"31"}
		,{"label":"51. 서산","value":"51"}
		,{"label":"52. 제천","value":"52"}
		,{"label":"53. 논산","value":"53"}
		,{"label":"71. 공주","value":"71"}
		,{"label":"72. 보령","value":"72"}
		,{"label":"73. 계룡","value":"73"}
		,{"label":"74. 당진","value":"74"}
	]
//	,"10":[
//		{"label":"13. 청주","value":"13"}
//		,{"label":"38. 충주","value":"38"}
//		,{"label":"52. 제천","value":"52"}
//		,{"label":"27. 천안","value":"27"}
//		,{"label":"71. 공주","value":"71"}
//		,{"label":"72. 보령","value":"72"}
//		,{"label":"41. 아산","value":"31"}
//		,{"label":"51. 서산","value":"51"}
//		,{"label":"53. 논산","value":"53"}
//		,{"label":"73. 계룡","value":"73"}
//		,{"label":"74. 당진","value":"74"}
//	]

	//전라
	,"11":[
		{"label":"11. 전주","value":"13"}
		,{"label":"22. 목포","value":"31"}
		,{"label":"24. 익산","value":"52"}
		,{"label":"25. 군산","value":"38"}
		,{"label":"28. 여수","value":"51"}
		,{"label":"34. 순천","value":"53"}
		,{"label":"44. 정읍","value":"27"}
		,{"label":"75. 남원","value":"71"}
		,{"label":"76. 김제","value":"72"}
		,{"label":"77. 나주","value":"73"}
		,{"label":"78. 광양","value":"74"}
	]
//	,"11":[
//		{"label":"11. 전주","value":"13"}
//		,{"label":"25. 군산","value":"38"}
//		,{"label":"24. 익산","value":"52"}
//		,{"label":"44. 정읍","value":"27"}
//		,{"label":"75. 남원","value":"71"}
//		,{"label":"76. 김제","value":"72"}
//		,{"label":"22. 목포","value":"31"}
//		,{"label":"28. 여수","value":"51"}
//		,{"label":"34. 순천","value":"53"}
//		,{"label":"77. 나주","value":"73"}
//		,{"label":"78. 광양","value":"74"}
//	]

	//경상
	,"12":[
		{"label":"15. 창원","value":"15"}
		,{"label":"17. 포항","value":"17"}
		,{"label":"19. 진주","value":"19"}
		,{"label":"26. 구미","value":"26"}
		,{"label":"32. 경주","value":"32"}
		,{"label":"33. 김해","value":"33"}
		,{"label":"39. 안동","value":"39"}
		,{"label":"40. 경산","value":"40"}
		,{"label":"42. 거제","value":"42"}
		,{"label":"43. 김천","value":"43"}
		,{"label":"48. 양산","value":"48"}
		,{"label":"79. 영주","value":"79"}
		,{"label":"80. 영천","value":"80"}
		,{"label":"81. 상주","value":"81"}
		,{"label":"82. 문경","value":"82"}
		,{"label":"83. 통영","value":"83"}
		,{"label":"84. 사천","value":"84"}
		,{"label":"85. 밀양","value":"85"}
	]
//	,"12":[
//		{"label":"17. 포항","value":"17"}
//		,{"label":"32. 경주","value":"32"}
//		,{"label":"43. 김천","value":"43"}
//		,{"label":"39. 안동","value":"39"}
//		,{"label":"26. 구미","value":"26"}
//		,{"label":"79. 영주","value":"79"}
//		,{"label":"80. 영천","value":"80"}
//		,{"label":"81. 상주","value":"81"}
//		,{"label":"82. 문경","value":"82"}
//		,{"label":"40. 경산","value":"40"}
//		,{"label":"15. 창원","value":"15"}
//		,{"label":"19. 진주","value":"19"}
//		,{"label":"83. 통영","value":"83"}
//		,{"label":"84. 사천","value":"84"}
//		,{"label":"33. 김해","value":"33"}
//		,{"label":"85. 밀양","value":"85"}
//		,{"label":"42. 거제","value":"42"}
//		,{"label":"48. 양산","value":"48"}
//	]

	//제주
	,"13":[
		{"label":"21. 제주","value":"21"}
		,{"label":"86. 서귀포","value":"86"}
	]

	//기타
	,"14":[
		{"label":"98. 기타도시","value":"98"}
		,{"label":"99. 도시이외","value":"99"}
	]

}

//통계원표 리포트맵
var b0102RTMap = {
	rexdataset : null
}

//통계원표 공통맵
var b0102VOMap = {
	rcptNum : ""		//접수번호
	, incNum : ""		//사건번호
}
