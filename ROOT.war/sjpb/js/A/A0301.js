$(function(){
	pageInitA0301();
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

var a0301VOMap = new Object();

//화면 진입시 동작함
function pageInitA0301(){
	
	//a0101VOMap 복사 
	a0301VOMap = cloneObj(parent.a0101VOMap);
	
	//피의자 그리기 
	renderIncSpHtmlA0301();
	
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
	$("#cnfmBtn").off("click").on("click", function(e) {
		
		//유효성 체크
		var chkObjs = $("#a0301ContentsDiv");
		if(!chkValidate.check(chkObjs, true)) return;
		
		if(confirm("수정요청 하시겠습니까?") == true){
			//맵갱신
			synca0301VOMap();
			
			a0301VOMap.mfCd = "02";	//피의자정보수정
			a0301VOMap.mfCont = $("#mfCont").val();
			
			goAjax("/sjpb/A/updateSpVio.face", a0301VOMap, callBackUpdateSpVioSuccess );
			
		}else{
			return;
		}
	});	
	
}

//수정요청 성공 콜백함수
function callBackUpdateSpVioSuccess(data){
	alert("사건 수정 요청이 되었습니다.");
	window.parent.commonLayerPopup.closeLayerPopup(data.a0101VO);
}

//피의자 그리기 
function renderIncSpHtmlA0301(){
	
	//var personinfoHtml ;
	//피내사자 정보 리스트 가져오기 
	var personInfoTarget = $("#incSpContents", parent.document).clone().wrapAll("<div/>").parent();
	$("#a0301ContentsArea").append(personInfoTarget);
	
	$("#incSpContents").data("record-max", $("div[name=incSpDiv]").size());
	
	
//	$("div[name=incSpDiv]", parent.document).each(function() {
//		//personinfoHtml = $(this).clone().wrapAll("<div/>").parent();
//		personinfoHtml = $(this).clone(true);
//		$("#incSpContents").append(personinfoHtml);
//	});
	
	//피의자 이벤트 바인딩
	eventSpSetup();
	
	//selct 퍼블 이벤트 바인딩
	//setDefaultEvent();
	
	//사건 이벤트 바인딩
	//eventIncSetup();
	
	//피의자 버튼 컨트롤(초기)
	//spBtnControl(true);
	
	//피내사자 정보 수정가능 
	areaSetWrite($("div[name=incSpDiv]"));
	
	//피의자 수정 버튼 숨김 
	$("a[name=updateSpVioBtn]").hide();
	
	//피의자 이동 이벤트 바인딩 
	
}

//Map 데이터 갱신
function synca0301VOMap(isValid) {
	
	//피의자만 데이터에 담음 
	syncIncSpVOList(a0301VOMap);
	
}
