$(function(){
	pageInitB0301();
	
    $('.remaining').each(function () {
        // count 정보 및 count 정보와 관련된 textarea/input 요소를 찾아내서 변수에 저장한다.
        var $maxcount = $('.maxcount', this);
        var $count = $('.count', this);
        var $input = $("#mfCont");

        // .text()가 문자열을 반환하기에 이 문자를 숫자로 만들기 위해 1을 곱한다.
        var maximumByte = $maxcount.text() * 1;
        // update 함수는 keyup, paste, input 이벤트에서 호출한다.
        var update = function () {
            var before = $count.text() * 1;
            var str_len = $input.val().length;
            var cbyte = 0;
            var li_len = 0;
            for (i = 0; i < str_len; i++) {
                var ls_one_char = $input.val().charAt(i);
                if (escape(ls_one_char).length > 4) {
                    cbyte += 2; //한글이면 2를 더한다
                } else {
                    cbyte++; //한글아니면 1을 다한다
                }
                if (cbyte <= maximumByte) {
                    li_len = i + 1;
                }
            }
            // 사용자가 입력한 값이 제한 값을 초과하는지를 검사한다.
            if (parseInt(cbyte) > parseInt(maximumByte)) {
                alert('허용된 글자수가 초과되었습니다.\r\n\n초과된 부분은 자동으로 삭제됩니다.');
                var str = $input.val();
                var str2 = $input.val().substr(0, li_len);
                $input.val(str2);
                var cbyte = 0;
                for (i = 0; i < $input.val().length; i++) {
                    var ls_one_char = $input.val().charAt(i);
                    if (escape(ls_one_char).length > 4) {
                        cbyte += 2; //한글이면 2를 더한다
                    } else {
                        cbyte++; //한글아니면 1을 다한다
                    }
                }
            }
            $count.text(cbyte);
        };
        // input, keyup, paste 이벤트와 update 함수를 바인드한다
        $input.bind('input keyup keydown paste change', function () {
            setTimeout(update, 0)
        });
        update();
    });
});

var b0301VOMap = new Object();

		
//화면 진입시 동작함
function pageInitB0301(){
	
	//b0101VOMap 복사 
	b0301VOMap = cloneObj(parent.b0101VOMap);
	
	//피의자 그리기 
	renderIncSpHtmlB0301();
	
	//이벤트바인딩
	eventSetup();	
}

//이벤트처리
function eventSetup() {
	
    $('#iframeContainer iframe').onload = function() {alert('myframe is loaded');};
	
	//닫기버튼
	$("#closBtn, img.btn_close").on("click", function() {
		window.parent.commonLayerPopup.closeLayerPopupOnly();
	});		
	
	//수정요청버튼
	$("#cnfmBtn").on("click", function(e) {
		
		//유효성 체크
		var chkObjs = $("#b0301ContentsDiv");
		if(!chkValidate.check(chkObjs, true)) return;
		
		if(confirm("수정요청 하시겠습니까?") == true){
			//맵갱신
			syncB0301VOMap();
			
			b0301VOMap.mfCd = "02";	//피의자정보수정
			b0301VOMap.mfCont = $("#mfCont").val();
			
			goAjax("/sjpb/B/updateSpVio.face", b0301VOMap, callBackUpdateSpVioSuccess );
			
		}else{
			return;
		}
		
	});	
	
	
	
}

//수정요청 성공 콜백함수
function callBackUpdateSpVioSuccess(data){
	alert("사건 수정 요청이 되었습니다.");
	window.parent.commonLayerPopup.closeLayerPopup(b0301VOMap);
}

//피의자 그리기 
function renderIncSpHtmlB0301(){
	
	var personinfoHtml = new StringBuffer();
	//피의자 정보 리스트 가져오기 
//	$(".personinfo", parent.document).each(function() {
//		//personinfoHtml = $(this).clone().wrapAll("<div/>").parent();
//		personinfoHtml = $(this).clone(true);
//		debugger;
//		$("#b0301ContentsArea").append(personinfoHtml);
//	});
	$.each(parent.b0101VOMap.incSpVOList,function(i,incSpVO){
		
		var spIdNumDec =  Base64.decode(incSpVO.spIdNum);
		var spNmDec = Base64.decode(incSpVO.spNm);
		var spAddrDec = Base64.decode(incSpVO.spAddr);
		var spCnttNumDec = Base64.decode(incSpVO.spCnttNum);
		var spJobDec = Base64.decode(incSpVO.spJob);
		var spBsnsNmDec = Base64.decode(incSpVO.spBsnsNm);
		
		personinfoHtml.append('<div class="personinfo" data-name="personinfo">                                                                                                                                                                                                                                ');
		personinfoHtml.append('<table name="grid-table-sp" class="list" cellpadding="0" cellspacing="0">                                                                                                                                                                                                 ');
		
		
		personinfoHtml.append('	<input type="hidden" name="indvCorpDiv" value="'+incSpVO.indvCorpDiv+'" />   ');
		personinfoHtml.append('	<input type="hidden" name="spIdNum" value="'+spIdNumDec+'" />  ');
		personinfoHtml.append('	<input type="hidden" name="gendDiv" value="'+incSpVO.gendDiv+'" />  ');
		personinfoHtml.append('	<input type="hidden" name="spNm" value="'+spNmDec+'" />  ');
		personinfoHtml.append('	<input type="hidden" name="rcptNum" value="'+incSpVO.rcptNum+'" />  ');
		personinfoHtml.append('	<input type="hidden" name="h_incSpNum" value="'+incSpVO.incSpNum+'" />  ');
		personinfoHtml.append('	<input type="hidden" name="updateCd" value="M" />   ');
		
		personinfoHtml.append('   <colgroup>                                                                                                                                                                                                                                        ');
		personinfoHtml.append('   <col width="25%" />                                                                                                                                                                                                                               ');
		personinfoHtml.append('   <col width="25%" />                                                                                                                                                                                                                               ');
		personinfoHtml.append('   <col width="50%" />                                                                                                                                                                                                                               ');
		personinfoHtml.append('   </colgroup>                                                                                                                                                                                                                                       ');
		personinfoHtml.append('   <tbody>                                                                                                                                                                                                                                           ');
		personinfoHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		
		
		personinfoHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		personinfoHtml.append('		   <th class="C line_right" rowspan="3">피의자 정보</th>                                                                                                                                                                                             ');
		
		
		if(incSpVO.indvCorpDiv == "1"){
			personinfoHtml.append('	   <tr name="indvTR1">                                                                                                                                                                                                                                        ');
			personinfoHtml.append('		   <th class="C">성명</th>                                                                                                                                                                                                                       ');
			personinfoHtml.append('		   <td class="L">                                                                                                                                                                                                                   ');
			personinfoHtml.append('			   <label for="spIndvNm_'+i+'"></label><input type="text" class="w100per" id="spIndvNm_'+i+'" name="spIndvNm" value="'+ spNmDec+'" data-type="name" data-optional-value=false maxlength="20" title="성명"/>                                                                                                                                                    ');
			personinfoHtml.append('		   </td>                                                                                                                                                                                                                                        ');
			personinfoHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
			personinfoHtml.append('	   <tr name="indvTR2">                                                                                                                                                                                                                                             ');
			personinfoHtml.append('		   <th class="C"><span name="spIdNumTitle">주민등록번호</span></th>                                                                                                                                                                                                                    ');
			personinfoHtml.append('		   <td class="L">                                                                                                                                                                                                                   ');
			personinfoHtml.append('			   <label for="spIdNumA_'+i+'"></label><input type="text" class="w40per" id="spIdNumA_'+i+'" name="spIdNumA" value="'+getIdNumA(spIdNumDec)+'" data-type="rnnFront" data-optional-value=true maxlength="6" size="6" title="주민등록번호"/>                                                            ');
			personinfoHtml.append('		   	   ~ <label for="spIdNumB_'+i+'"></label><input type="text" class="w40per" id="spIdNumB_'+i+'" name="spIdNumB" value="'+getIdNumB(spIdNumDec)+'" data-type="rnnBack" data-optional-value=true maxlength="7" size="7" title="주민등록번호"/>                                                                                                                                                                                                                                        ');
			personinfoHtml.append('		   		&nbsp;<span name=\"gendDivSpan\"></span>                ');
			personinfoHtml.append('		   </td>                                                                                                                                                                                                                                        ');
			personinfoHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
		}
		
		if(incSpVO.indvCorpDiv == "2"){
			personinfoHtml.append('	   <tr name="corpTR1">                                                                                                                                                                                                                                             ');
			personinfoHtml.append('		   <th class="C">법인명 <em class=\"red\">*</em></th>                                                                                                                                                                                                                       ');
			personinfoHtml.append('		   <td class="L">                                                                                                                                                                                                                   ');
			personinfoHtml.append('			   <label for="spCorpNm_'+i+'"></label><input type="text" class="w100per" id="spCorpNm_'+i+'" name="spCorpNm" value="'+ spNmDec+'" data-type="name" data-optional-value=true maxlength="20" title="법인명"/>                                                                                                                                                    ');
			personinfoHtml.append('		   </td>                                                                                                                                                                                                                                        ');
			personinfoHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
			personinfoHtml.append('	   <tr name="corpTR2">                                                                                                                                                                                                                                             ');
			personinfoHtml.append('		   <th class="C">법인등록번호</th>                                                                                                                                                                                                                    ');
			personinfoHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                   ');
			personinfoHtml.append('			   <label for="spCorpIdNumA_'+i+'"></label><input type="text" class="w40per" id="spCorpIdNumA_'+i+'" name="spCorpIdNumA" value="'+getCorpIdNumA(spIdNumDec)+'" data-type="bizIdFront" title="법인등록번호" maxlength="6" data-optional-value=true  size="6"/>                                                                  ');
			personinfoHtml.append('		       ~ <label for="spCorpIdNumB_'+i+'"></label><input type="text" class="w40per" id="spCorpIdNumB_'+i+'" name="spCorpIdNumB" value="'+getCorpIdNumB(spIdNumDec)+'" data-type="bizIdBack" title="법인등록번호" maxlength="7" data-optional-value=true  size="7"/>                                                                                                                                                                                                                                    ');
			personinfoHtml.append('		   </td>                                                                                                                                                                                                                                        ');
			personinfoHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
		
		}
		
		personinfoHtml.append('   </tbody>                                                                                                                                                                                                                                          ');
		personinfoHtml.append('</table>                                                                                                                                                                                                                                             ');
		personinfoHtml.append('</div>                                                                                                                                                                                                                                             ');
	
	});	
	
	$("#b0301ContentsArea").html(personinfoHtml.toString());	
	//피의자 이벤트 바인딩
	eventSpSetup();
	
	//selct 퍼블 이벤트 바인딩
	setDefaultEvent();
	
	//사건 이벤트 바인딩
	eventIncSetup();
	
	//피의자 버튼 컨트롤(초기)
	spBtnControl(true);
	
	//피의자 정보 수정가능 
	areaSetWrite($(".personinfo"));
	
	//피의자 수정 버튼 숨김 
	$("a[name=updateSpVioBtn]").hide();
	
	//피의자 이동 이벤트 바인딩 
	
	
}

//Map 데이터 갱신
function syncB0301VOMap(isValid) {
	
	//피의자만 데이터에 담음 
	syncIncSpVO0301List(b0301VOMap);
	
}

//피의자 데이터 갱신
function syncIncSpVO0301List(paramMap) {
	
	//피의자정보 셋팅 n명
	//radio 는 data-name 으로 찾는다. 
	var incSpVOArray = new Array();
	$("div[data-name=personinfo]").each(function(i) {
		
		if ($(this).find("input[name=indvCorpDiv]").val() == "1") { //개인
			$(this).find("input[name=spIdNum]").val($(this).find("input[name=spIdNumA]").val() + "-" + $(this).find("input[name=spIdNumB]").val());
			$(this).find("input[name=spNm]").val($(this).find("input[name=spIndvNm]").val());
		} else { //법인
			$(this).find("input[name=spIdNum]").val($(this).find("input[name=spCorpIdNumA]").val() + "-" + $(this).find("input[name=spCorpIdNumB]").val());
			$(this).find("input[name=spNm]").val($(this).find("input[name=spCorpNm]").val());
			$(this).find("input[name=gendDiv]").val("");
		}
		
		var incSpVO = {
			incSpNum : $(this).find("input[name=h_incSpNum]").val()
			,rcptNum : $(this).find("input[name=rcptNum]").val()
			,indvCorpDiv : $(this).find("input[name=indvCorpDiv]").val()
			,spNm : Base64.encode($(this).find("input[name=spNm]").val())
			,gendDiv : $(this).find("input[name=gendDiv]").val()
			,spTpCd : "2"
			,spIdNum : Base64.encode($(this).find("input[name=spIdNum]").val())
			,inqOrd : i+1
			,spStatCd : "1"
			,updateCd : $(this).find("input[name=updateCd]").val()
		}
		
		
		incSpVOArray.push(incSpVO);
	});
	
	paramMap.incSpVOList = incSpVOArray;
}