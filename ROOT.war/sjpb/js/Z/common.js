var loadingFlag = true;
$(document).ready(function(){
	
	
	
	//data-type이 숫자, 주민등록번호일 경우에는 숫자만 입력가능하도록 설정 
	$("input[data-type=phone], input[data-type*=rnn], input[data-type=number]").keydown(function(e){
		setKeyDownNum(e);
	});
	
	//달력이벤트
	$(".datepicker").datepicker({
		  dateFormat: "yy-mm-dd" ,
		  changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
		  changeYear: true,
		  showButtonPanel: true,
		  currentText: '오늘 날짜'
	});		
	
	//해당 영역안에서는 스크롤을 별도로 처리하게끔 (장점: 바디 스크롤바 고정, 단점: 스크롤 가속 없음)
	/*
	$('.area-mousewheel').on('mousewheel', function (e) {
	  if (e.originalEvent.wheelDelta >= 120) {
	    this.scrollTop -= 50;
	  } else if (e.originalEvent.wheelDelta <= -120) {
	    this.scrollTop += 50;
	  }
	  return false;
	});
	*/
});

//숫자만 입력 가능하도록 설정 
function setKeyDownNum(e){
	var key;
    if(window.event) {
    	key = window.event.keyCode; //IE
    }
    else{
    	key = e.which; //firefox
    }
    var event;
    if (key == 0 || key == 8 || key == 46 || key == 9){
        event = e || window.event;
        if (typeof event.stopPropagation != "undefined") {
            event.stopPropagation();
        } else {
            event.cancelBubble = true;
        }   
        return;
    }
    if (key < 48 || (key > 57 && key < 96) || key > 105 || e.shiftKey) {
        e.preventDefault ? e.preventDefault() : e.returnValue = false;
    }
}

var StringBuffer = function() {
    this.buffer = new Array();
};
StringBuffer.prototype.append = function(str) {
    this.buffer[this.buffer.length] = str;
};
StringBuffer.prototype.toString = function() {
    return this.buffer.join("");
};

//유효성검사
var chkValidate = {
		
	/**
     * formData 유효성검사
     * 
     * 검사할 대상의 input, select노드의 data-type 속성과 title 속성필요.
     * 
     * ex) 	var chkObjs = $("#CodebaseManager_Child_ListForm");
     * 		if(!chkValidate.check(chkObjs, true)) return;
     * 
     * 		data-type : (필수값)
     * 			1. name			이름
     *          2. date         날짜
     * 			3. rnnFront		주민등록번호앞자리
     * 			4. rnnBack		주민등록번호뒷자리
     * 			5. phone		연락처번호
     * 			6. number		숫자형식
     *			7. email		이메일형식 
     * 			8. radio		
     * 			9. select		
     * 			10. required	기타, 필수값만 체크함
     * 			
     * 
     * formData 	: jQuery formObj (ex. $("#CodebaseManager_Child_ListForm"))
     * isAlert 		: alert 여부 
     * 
     */
	check : function(formData, isAlert){
		var result = true;		//유효성 결과 true: 정상 false: 비정상
		var bEmpty = true;		//미입력여부
		var elementName;		//노드이름
		var dataType;			//노드타입
		var target;				//target Obj (jquery)
		var data;				//input 값
		var requiredValue;      //필수값 여부
		var optionalValue;		//옵션여부 
		
		formData.find("input[data-type], select[data-type], textarea[data-type]").each(function(i){
			target = $(this);
			elementName = target.attr("name");
			dataType = target.attr("data-type"); 
			data = getFieldValue(target);
			if (target.data("optional-value") == undefined) {
				optionalValue = false;
			} else {
				optionalValue = target.data("optional-value");	
			}
			
			//이름 
			if(dataType == "name"){				
				if(isNull(data)){
					//필수값인 경우만 확인
					if(!optionalValue) {
						bEmpty = false;
						return false;
					}
				}
				
			//날짜 
			}else if(dataType == "date"){				
				if(isNull(data)) {
					//필수값인 경우만 확인
					if(!optionalValue) {
						bEmpty = false;
						return false;
					}
				} else {
					if(!isValidDate(data)){
						bEmpty = false;
						return false;
					}
				}
				
			//날짜 Front
			}else if(dataType == "dateFront"){				
				if(isNull(data)) {
					//필수값인 경우만 확인
					if(!optionalValue) {
						bEmpty = false;
						return false;
					}
				} else {
					if(!isValidDate(data)){
						bEmpty = false;
						return false;
					}
				}
				
			//날짜 Back
			}else if(dataType == "dateBack"){				
				if(isNull(data)) {
					//필수값인 경우만 확인
					if(!optionalValue) {
						bEmpty = false;
						return false;
					}
				} else {
					if(!isValidDate(data)){
						bEmpty = false;
						return false;
					}else{
						
						//종료일이 시작일보다 앞설수 없음 
						var dateFront = $(this).parent().find("input[data-type=dateFront]").val().replace(/-/gi,"");
						var dateBack = $(this).val().replace(/-/gi,"");
						
						if(Number(dateFront) > Number(dateBack)){
							alert("시작일이 종료일보다 클 수 없습니다.");
							target.focus();
							result = false;
							return false;
						}
						
					}
				}
				
			//이메일 email
			}else if(dataType == "email"){				
				if(isNull(data)) {
					//필수값인 경우만 확인
					if(!optionalValue) {
						bEmpty = false;
						return false;
					}
				} else {
					if(!isValidEmail(data)){
						if(isAlert){
							alert("["+target.attr("title")+"] 이메일 형식이 올바르지 않습니다.");
							target.focus();
						}
						result = false;
						return false;
					}
				}
				
			//주민등록번호 앞자리
			}else if(dataType == "rnnFront"){
				if(isNull(data)){
					//필수값인 경우만 확인
					if(!optionalValue) {
						bEmpty = false;
						return false;
					}
				}else{
					var yy = data.substring(0,2);
					var mm = data.substring(2,4);
					var dd = data.substring(4,6);
					
					if(data.length != 6){
						if(isAlert){
							alert("["+target.attr("title")+"] 6자리로 입력하세요.");
							target.focus();
						}
						result = false;
						return false;
					}else{
						//나머지 유효성은 뒷자리에서 검사한다. 
					}
				}
				
			//주민등록번호 뒷자리
			}else if(dataType == "rnnBack"){
				if(isNull(data)){
					//필수값인 경우만 확인
					if(!optionalValue) {
						bEmpty = false;
						return false;
					}
				}else{
					
					if(data.length != 7){
						if(isAlert){
							alert("["+target.attr("title")+"] 7자리로 입력하세요.");
							target.focus();
						}
						result = false;
						return false;
					}else{
						//주민등록번호 앞자리 + 뒷자리를 조합하여 유효성 체크 
						var rnnFront = target.parent().find("input[data-type=rnnFront]").val();	//rnnFront는 있는걸 전제로함.
						var rnnBack = data;
						var rrn = rnnFront + rnnBack;	//주민등록번호 앞자리 + 뒷자리 
						
						//주민등록번호, 외국인등록번호, 법인등록번호 유효성검사
						if(!ssnCheck.allCheck(rrn)){
							if(isAlert){
								alert("["+target.attr("title")+"] 유효하지 않습니다.");
								target.focus();
							}
							result = false;
							return false;
						}
					}
				}
				
			//법인등록번호 앞자리
			}else if(dataType == "bizIdFront"){
				if(isNull(data)){
					//필수값인 경우만 확인
					if(!optionalValue) {
						bEmpty = false;
						return false;
					}
				}else{
					
					if(data.length != 6){
						if(isAlert){
							alert("["+target.attr("title")+"] 6자리로 입력하세요.");
							target.focus();
						}
						result = false;
						return false;
					}else{
						//나머지 유효성은 뒷자리에서 검사한다. 
					}
				}
				
			//법인등록번호 뒷자리
			}else if(dataType == "bizIdBack"){
				if(isNull(data)){
					//필수값인 경우만 확인
					if(!optionalValue) {
						bEmpty = false;
						return false;
					}
				}else{
					
					if(data.length != 7){
						if(isAlert){
							alert("["+target.attr("title")+"] 7자리로 입력하세요.");
							target.focus();
						}
						result = false;
						return false;
					}else{
						//법인등록번호 앞자리 + 뒷자리를 조합하여 유효성 체크 
						var bizIdFront = target.parent().find("input[data-type=bizIdFront]").val();	//bizIdFront는 있는걸 전제로함.
						var bizIdBack = data;
						var bizId = bizIdFront + bizIdBack;	//사업자등록번호  
						
						//법인등록번호 유효성검사
//						if(!ssnCheck.fnBsnCheck(bizId)){
//							if(isAlert){
//								alert("["+target.attr("title")+"] 유효하지 않습니다.");
//								target.focus();
//							}
//							result = false;
//							return false;
//						}
					}
				}	
				
			//연락처
			}else if(dataType == "phone"){
				if(isNull(data)){
					
					//필수값인 경우만 확인
					if(!optionalValue) {
						bEmpty = false;
						return false;
					}
					
				}
				
			//숫자
			}else if(dataType == "number"){
				if(isNull(data)){
					
					//필수값인 경우만 확인
					if(!optionalValue) {
						bEmpty = false;
						return false;
					}
					
				}else{
					if(!isNumberOnly(data)){
						alert("["+target.attr("title")+"] 숫자만 입력해주세요.");
						target.focus();
						result = false;
						return false;
					}
				}
			
			//radio 선택박스
			}else if(dataType == "radio"){
				var radioArr = document.getElementsByName(elementName);
				
				if(!hasCheckedRadio(radioArr)){
					if(isAlert){
						alert("["+target.attr("title")+"] 선택해주세요.");
						target.focus();
					}
					result = false;
					return false;
				}
				
			//checkbox
			}else if(dataType == "checkbox"){
				var checkArr = document.getElementsByName(elementName);
				
				if(!hasCheckedBox(checkArr)){
					if(isAlert){
						alert("["+target.attr("title")+"] 선택해주세요.");
						target.focus();
					}
					result = false;
					return false;
				}
				
			//selectbox 선택박스
			}else if(dataType == "select"){
				if(isNull(data) || data == -1){
					bEmpty = false;
					return false;
				}
			}
			
			//그외 필수값체크 (null여부만 체크함)
			else if(dataType == "required"){
				if(isNull(data)){
					//필수값인 경우만 확인
					if(!optionalValue) {
						bEmpty = false;
						return false;
					}
				}
			}
		});
		
		//미입력 여부체크
		if(!bEmpty){
			if(isAlert){
				if (target.data("error-message")) {
					alert(target.data("error-message"));
				} else {
					alert("["+target.attr("title")+"] 필수입력사항입니다.");
				}
				target.focus();
			}
			return false;
		}
		
		return result;
	}
}


//ssnCheck.allCheck('1234561234567');
var ssnCheck = {
		
    /**
     * 유효성검사. allCheck("8201011234567");
     */
    allCheck : function(rrn) {
//        if (this.fnrrnCheck(rrn) || this.fnfgnCheck(rrn) || this.fnBsnCheck(rrn)) {
        if (this.fnrrnCheck(rrn) || this.fnfgnCheck(rrn) ) {
            return true;
        }
        return false;
    },

    /**
     * 주민등록번호 유효성검사
     */
    fnrrnCheck : function(rrn) {
    	
        var sum = 0;         

        if (rrn.length != 13) {
            return false;
        } else if (rrn.substr(6, 1) != 1 && rrn.substr(6, 1) != 2 && rrn.substr(6, 1) != 3 && rrn.substr(6, 1) != 4) {
            return false;
        }
         

        for (var i = 0; i < 12; i++) {
            sum += Number(rrn.substr(i, 1)) * ((i % 8) + 2);
        }         

        if (((11 - (sum % 11)) % 10) == Number(rrn.substr(12, 1))) {
            return true;
        }         

        return false;

    },

    /**
     * 외국인등록번호 유효성검사
     * @param rrn
     * @returns
     */
    fnfgnCheck : function(rrn) {

        var sum = 0;

        if (rrn.length != 13) {
            return false;
        } else if (rrn.substr(6, 1) != 5 && rrn.substr(6, 1) != 6 && rrn.substr(6, 1) != 7 && rrn.substr(6, 1) != 8) {
            return false;
        }

        if (Number(rrn.substr(7, 2)) % 2 != 0) {
            return false;
        }

        for (var i = 0; i < 12; i++) {
            sum += Number(rrn.substr(i, 1)) * ((i % 8) + 2);
        }

        if ((((11 - (sum % 11)) % 10 + 2) % 10) == Number(rrn.substr(12, 1))) {
            return true;
        }
        return false;
    }

    /**
     * 법인등록번호 유효성검사
     * @param bubinNum
     * @returns {Boolean}
     */

//    fnBsnCheck : function(bubinNum) {
//
//        var as_Biz_no = String(bubinNum);
//        var I_TEMP_SUM = 0;
//        var I_CHK_DIGIT = 0;
//
//        if (bubinNum.length != 13) {
//            return false;
//        }
//
//        for(var index01 = 1; index01 < 13; index01++) {
//            var i = index01 % 2;
//            var j = 0; 
//
//            if (i == 1) {
//                j = 1;  
//            } else if (i == 0) {
//                j = 2;
//            }
//			
//            I_TEMP_SUM = I_TEMP_SUM + parseInt(as_Biz_no.substring(index01 - 1, index01), 10) * j;
//
//        }
//
//        I_CHK_DIGIT = I_TEMP_SUM % 10;
//
//        if (I_CHK_DIGIT != 0) {
//            I_CHK_DIGIT = 10 - I_CHK_DIGIT; 
//        }
//
//        if (as_Biz_no.substring(12, 13) != String(I_CHK_DIGIT)) {
//            return false;
//        } else {
//            return true;
//        }

//    }

};


/**
 * 사업자등록번호 체크한다
 */

function checkBizID(bizID) {  //사업자등록번호 체크

    // bizID는 숫자만 10자리로 해서 문자열로 넘긴다. 
    var checkID = new Array(1, 3, 7, 1, 3, 7, 1, 3, 5, 1);
    var tmpBizID, i, chkSum=0, c2, remander; 
    bizID = bizID.replace(/-/gi,'');

    for (i=0; i<=7; i++) chkSum += checkID[i] * bizID.charAt(i);
    c2 = "0" + (checkID[8] * bizID.charAt(8)); 
    c2 = c2.substring(c2.length - 2, c2.length);
    chkSum += Math.floor(c2.charAt(0)) + Math.floor(c2.charAt(1));
    remander = (10 - (chkSum % 10)) % 10 ;
    if (Math.floor(bizID.charAt(9)) == remander) return true ; // OK!
    return false; 

} 


/**
 * 입력값이  null 인지 체크한다
 */

function isNull(input){
       if (input == null || input == ""){
             return true;
       }else{
             return false;
       }
}

/**
 * 입력값에 특정 문자가 있는지 체크하는 로직이며
 * 특정문자를 허용하고 싶지 않을때 사용할수도 있다
 * if (containsChars(form.name, "!,*&^%$#@~;")){
 *       alert("특수문자를 사용할수 없습니다");
 * }
 */

function containsChars(input, chars){
       for (var i=0; i < input.value.length; i++){
             if (chars.indexOf(input.value.charAt(i)) != -1){
                    return true;
             }
       }
       return false;
}

/**
 * 입력값이 특정 문자만으로 되어있는지 체크하며
 * 특정문자만을 허용하려 할때 사용한다.
 * if (containsChars(form.name, "ABO")){
 *    alert("혈액형 필드에는 A,B,O 문자만 사용할수 있습니다.");
 * }
 */

function containsCharsOnly(input, chars){
       for (var i=0; i < input.value.length; i++){
             if (chars.indexOf(input.value.charAt(i)) == -1){
                    return false;
             }
       }
       return true;
}
/**
 * 입력값이 특정 문자만으로 되어있는지 체크하며
 * 특정문자만을 허용하려 할때 사용한다.
 * if (containsChars(form.name, "ABO")){
 *    alert("혈액형 필드에는 A,B,O 문자만 사용할수 있습니다.");
 * }
 */

function containsNumberOnly(input, chars){

	for (var i=0; i < input.length; i++){
		if (chars.indexOf(input.charAt(i)) == -1){
			return false;
		}
		
	}
	return true;
}

/**
 * 입력값이 숫자만 있는지 체크한다.
 */
function isNumer(input){
       var chars = "0123456789";
       return containsCharsOnly(input, chars);
}

/**
 * 입력값이 숫자만 있는지 체크한다.
 */
function isNumberOnly(input){
	var chars = "0123456789";
	return containsNumberOnly(input, chars);
}


/**
 * 입력값이 숫자, 대시"-" 로 되어있는지 체크한다
 * 전화번호나 우편번호, 계좌번호에 -  체크할때 유용하다
 */
function isNumDash(input){
       var chars = "-0123456789";
       return containsCharsOnly(input, chars);
}



/**
 * 입력값이 전화번호 형식(숫자-숫자-숫자)인지 체크한다
 */
function isValidPhone(input){
       var format = /^(\d+)-(\d+)-(\d+)$/;
       return isValidFormat(input, format);
}

/**
 * 입력값이 유효한 날짜 형식인지 체크한다
 */
function isValidDate(input){
       var format = /\b\d{4}[-]\d{1,2}[-]\d{1,2}\b/

       if (isValidFormat(input, format)) {
       
	       var oDate = new Date();
	       oDate.setFullYear(input.substring(0,4));
	       oDate.setMonth(parseInt(input.substring(5,7))-1);
	       oDate.setDate(input.substring(8));
	       
	       if(oDate.getFullYear() != input.substring(0,4) 
	  		   || oDate.getMonth() + 1 != input.substring(5,7)
	           || oDate.getDate() != input.substring(8)) {
	    	   return false;
	       }
	       return true;
       } else {
    	   return false;
       }
}

/**
 * 입력값이 유효한 이메일(email) 형식인지 체크한다
 */
function isValidEmail(input) {
	var format = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
	return format.test(input);
}

/**
 * 입력값과 포맷으로 유효한지 확인한다.
 */
function isValidFormat(input, format){
	var patt = new RegExp(format);
    return patt.test(input);
}

/**
 * 입력값의 바이트 길이를 리턴한다.
 * if (getByteLength(form.title) > 100){
 *    alert("제목은 한글 50자 (영문 100자) 이상 입력할수 없습니다");
 * }
 */
function getByteLength(input){
   var byteLength = 0;
   for (var inx = 0; inx < input.value.charAt(inx); inx++)     {
     var oneChar = escape(input.value.charAt(inx));
     if (oneChar.length == 1){
            byteLength++;
     }else if (oneChar.indexOf("%u") != -1){
            byteLength += 2;
     }else if (oneChar.indexOf("%") != -1){
            byteLength += oneChar.length / 3;
     }
   }
   return byteLength;
}

/**
 * 선택된 라디오버튼이 있는지 체크
 */
function hasCheckedRadio(input) {
	if (input.length > 1) {
		for (var inx = 0; inx < input.length; inx++) {
			if (input[inx].checked)
				return true;
		}
	} else {
		if (input.checked)
			return true;
	}
	return false;
}

/**
 * 선택된 체크박스가 있는지 체크
 */
function hasCheckedBox(input) {
	return hasCheckedRadio(input);
}


/**
 * 주민/법인/외국인번호 앞자리 가져오기
 */
function getIdNumA(idNum) {
	var idNumA = "";
	if (idNum != null) {		
		var idNumFields = idNum.split('-');
		if (idNumFields != null && idNumFields.length == 2) {
			idNumA = idNumFields[0];
		}
	}	
	return idNumA;
}

/**
 * 주민/법인/외국인번호 뒷자리 가져오기
 */
function getIdNumB(idNum) {
	var idNumB = "";
	if (idNum != null) {		
		var idNumFields = idNum.split('-');
		if (idNumFields != null && idNumFields.length == 2) {
			idNumB = idNumFields[1];
		} 
	} 
	return idNumB;
}

/**
 * 법인등록번호 앞자리 가져오기
 */
function getCorpIdNumA(corpIdNum) {
	var corpIdNumA = "";
	if (corpIdNum != null) {
		var corpIdNumFields = corpIdNum.split('-');
		if (corpIdNumFields != null && corpIdNumFields.length == 2) {
			corpIdNumA = corpIdNumFields[0];
		} 
	} 
	return corpIdNumA;
}

/**
 * 법인등록번호 앞자리 가져오기
 */
function getCorpIdNumB(corpIdNum) {
	var corpIdNumB = "";
	if (corpIdNum != null) {
		var corpIdNumFields = corpIdNum.split('-');
		if (corpIdNumFields != null && corpIdNumFields.length == 2) {
			corpIdNumB = corpIdNumFields[1];
		} 
	} 
	return corpIdNumB;
}

/**
 * 연락처 앞자리 가져오기
 */
function getCnttNumA(cnttNum) {
	var cnttNumA = "";
	if (cnttNum != null) {
		var cnttNumFields = cnttNum.split('-');
		if (cnttNumFields != null && cnttNumFields.length == 3) {
			cnttNumA = cnttNumFields[0];
		} 
	} 
	return cnttNumA;
}

/**
 * 연락처 중간자리 가져오기
 */
function getCnttNumB(cnttNum) {
	var cnttNumB = "";
	if (cnttNum != null) {
		var cnttNumFields = cnttNum.split('-');
		if (cnttNumFields != null && cnttNumFields.length == 3) {
			cnttNumB = cnttNumFields[1];
		} 
	} 
	return cnttNumB;
}

/**
 * 연락처 마지막자리 가져오기
 */
function getCnttNumC(cnttNum) {
	var cnttNumC = "";
	if (cnttNum != null) {
		var cnttNumFields = cnttNum.split('-');
		if (cnttNumFields != null && cnttNumFields.length == 3) {
			cnttNumC = cnttNumFields[2];
		} 
	} 
	return cnttNumC;
}

/**
 * IP 앞자리 가져오기
 */
function getAcesIpA(acesIp) {
	var acesIpA = "";
	if (acesIp != null) {
		var acesIpFields = acesIp.split('.');
		if (acesIpFields != null && acesIpFields.length == 4) {
			acesIpA = acesIpFields[0];
		} 
	} 
	return acesIpA;
}

/**
 * IP 두번째자리 가져오기
 */
function getAcesIpB(acesIp) {
	var acesIpB = "";
	if (acesIp != null) {
		var acesIpFields = acesIp.split('.');
		if (acesIpFields != null && acesIpFields.length == 4) {
			acesIpB = acesIpFields[1];
		} 
	} 
	return acesIpB;
}

/**
 * IP 세번째자리 가져오기
 */
function getAcesIpC(acesIp) {
	var acesIpC = "";
	if (acesIp != null) {
		var acesIpFields = acesIp.split('.');
		if (acesIpFields != null && acesIpFields.length == 4) {
			acesIpC = acesIpFields[2];
		} 
	} 
	return acesIpC;
}

/**
 * IP 마지막자리 가져오기
 */
function getAcesIpD(acesIp) {
	var acesIpD = "";
	if (acesIp != null) {
		var acesIpFields = acesIp.split('.');
		if (acesIpFields != null && acesIpFields.length == 4) {
			acesIpD = acesIpFields[3];
		} 
	} 
	return acesIpD;
}

/**
 * 클립레포트 생성을 위한 JSON to XML
 */
//JSON to Report XML
function objectToXml(obj) {
  var xml = '';

  for (var prop in obj) {
      if (!obj.hasOwnProperty(prop)) {
          continue;
      }

      if (obj[prop] == undefined)
          continue;

      xml += "<" + prop + ">";
      if (typeof obj[prop] == "object")
          xml += objectToXml(new Object(obj[prop]));
      else
          xml += ("<![CDATA[" + obj[prop] + "]]>");

      xml += "</" + prop + ">";
  }
  
  return xml.replace(/\<[0-9]+\>/g,'\<rexrow\>').replace(/\<\/[0-9]+\>/g,'\<\/rexrow\>');

}

/**
 * 클립리포트 서비스 팝업 띄우기
 * 호출전 reportForm에 아래 hidden 값 세팅
 * 	reptNm : 레포트 파일명
 *	xmlData : 레포트 매팅용 XML 데이터
 */
function openReportService(reportForm) {
	
	//클립레포트 서비스 URL
	var reportServiceUrl = "/ClipReport4/SJPBReport.jsp"; 
	//var reportServiceUrl = "http://98.34.132.78:8088/ClipReport4/SJPBReport.jsp";

	window.open("" ,"popForm","toolbar=no, width=1000, height=900, directories=no, status=no, scrollorbars=no, resizable=no"); 
	reportForm.action =reportServiceUrl; 
	reportForm.method="post";
	reportForm.target="popForm";	
	reportForm.submit();
	
}

/**
 * 클립리포트 서비스 팝업 띄우기
 * 호출전 reportForm에 아래 hidden 값 세팅
 * 	reptNm : 레포트 파일명
 *	seqNum : 변수명
 */
function openReportServiceFSS(reportForm) {
	
	//클립레포트 서비스 URL
	var reportServiceUrl = "/ClipReport4/FSSReport.jsp"; 
	//var reportServiceUrl = "http://98.34.132.78:8088/ClipReport4/SJPBReport.jsp";
	
	window.open("" ,"popForm","toolbar=no, width=1000, height=900, directories=no, status=no, scrollorbars=no, resizable=no"); 
	reportForm.action =reportServiceUrl; 
	reportForm.method="post";
	reportForm.target="popForm";	
	reportForm.submit();
	
}

/**
 * 클립리포트 서비스 pdf 다운로드
 * 	reptNm : 레포트 파일명
 */
function openDownloadReportServiceFSS(reportForm) {
	
	//클립레포트 서비스 URL
	var downloadReportServiceUrl = "/ClipReport4/FSSDownLoadReport.jsp"; 
	
	reportForm.action =downloadReportServiceUrl; 
	reportForm.method="post";
	reportForm.target="invisible";	
	reportForm.submit();
}

/*
 *	ajax (Map, form.serialize() )
 *	
 *  호출방법	
 *
 *	1. 성공 콜백함수 호출(기본) 
 *  ex) goAjax("/sjpb/B/inquirySp.face", b0101VOMap, callBackInquirySpSuccess)
 * 
 * 	2. 성공 콜백함수 호출(같이 넘겨야할 변수가 있을경우)
 *	ex) goAjax("/sjpb/B/inquirySp.face", b0101VOMap, function(data){callBackInquirySpSuccess(data, "aaa")}); 
 */
function goAjax(ajaxUrl, DataMap, callbackFunction, option) {	
	//option : true(비동기식), false(동기식- ajax완료 후에 진행)
	
	var _dataType 		= "json";
	var _option 		= option == null ? false : option;
	
	if(typeof DataMap == "object"){
		var _data = JSON.stringify(DataMap);
		var _contentType 	= "application/json; charset=UTF-8";
	}else{
		var _data = DataMap;
		var _contentType 	= "application/x-www-form-urlencoded; charset=UTF-8";
	}
	
	jQuery.ajax({
		url			: ajaxUrl,
		type		: "POST",
		async		: _option,
		dataType	: _dataType,
		contentType : _contentType,
		data		: _data,
		cache		: false,
		
		beforeSend: function(xhr) {

			if($("#holdon-overlay").length == 0){
				if(loadingFlag) holdonShow();
			}
		},
		success: function (data) {
			 
			if (typeof callbackFunction == "function") {
				callbackFunction(data);
			}
		},
		complete: function (xhr) {
			if(loadingFlag) holdonClose();
		},
		error: function (xhr, status, error) {
			if(loadingFlag) holdonClose();
			alert('서버오류 입니다. 관리자에게 확인하세요. ' + error);
		}
		
	});
}


/*
 *	ajax ( 기본 )
 *	
 *  호출방법	
 *
 *	1. 성공 콜백함수 호출(기본) 
 *  ex) goAjax("/sjpb/B/inquirySp.face", b0101VO, callBackInquirySpSuccess)
 * 
 * 	2. 성공 콜백함수 호출(같이 넘겨야할 변수가 있을경우)
 *	ex) goAjax("/sjpb/B/inquirySp.face", b0101VO, function(data){callBackInquirySpSuccess(data, "aaa")}); 
 */
function goAjaxDefault(ajaxUrl, DataMap, callbackFunction, option) {	
	//option : true(비동기식), false(동기식- ajax완료 후에 진행)
	
	var _dataType 		= "json";
	var _option 		= option == null ? false : option;
	var _data 			= DataMap;
	
	jQuery.ajax({
		url			: ajaxUrl,
		type		: "POST",
		async		: _option,
		dataType	: _dataType,
		data		: _data,
		cache		: false,
		
		beforeSend: function(xhr) {
			if(loadingFlag) holdonShow();
		},
		success: function (data) {
			 
			if (typeof callbackFunction == "function") {
				callbackFunction(data);
			}
		},
		complete: function (xhr) {
			if(loadingFlag) holdonClose();
		},
		error: function (xhr, status, error) {
			if(loadingFlag) holdonClose();
			alert('서버오류 입니다. 관리자에게 확인하세요. ' + error);
		}
		
	});
}


//부서검색
function fn_showDeptSearch(type) {
	var param = "";
	
	if (isDefined(type)) {
		param = {
			"chkType" : type
		};
	}
	
	fn_showDialogPopup({
		showAreaId : "deptSearchLayer",
		url : getContextPath() + "/comm/user/deptLayerPopup.face",
		param : param,
		title : "부서검색",
		width : 400,
		modal : true,
		buttons : [ { text : "확인", class:"btn_gray", click: function() { try{fn_getChkDeptInfo();}catch(e){console.log(e);}$("#deptSearchLayer").dialog("close"); } }]
	});
}

function fn_showLayerPopup(opts) {
	var defaultOpts = {
			showAreaId : "layerPopupDiv"
			, url : ""
			, center : true
			, top : 0
			, left : 0
			, width : '100%'
			, height : '100%'
			, param : {}
			, callback : null
	};
	
	var mergeOpts = $.extend(true, {}, defaultOpts, opts);
	
	if (mergeOpts.url == null || mergeOpts.url == "") {
		alert("잘못된 요청입니다. 옵션의 url을 확인하십시오.");
		return;
	}
	var showObj = $("#" + mergeOpts.showAreaId).attr("id");
	if (showObj == null || showObj == undefined) {
		// 해당 아이디가 없는경우 body 태그 밑에 생성한다.
		var html = "<div id='" + mergeOpts.showAreaId + "'></div>";
		$("body").append(html);
	}
	
	$("#" + mergeOpts.showAreaId).load(mergeOpts.url, mergeOpts.param, function (res, status, xhr) {
		$("#" + mergeOpts.showAreaId + " > div.sub_layer_popup").css({
    		"width" : mergeOpts.width,
    		"height" : mergeOpts.height,
    		"left" : mergeOpts.left,
    		"top"  : mergeOpts.top,
    		"position" : "relative"
    	}).show();
		
		if (mergeOpts.center) {
			// 현제창의 중앙으로 이동시킨다.
			var windowWidth = 0;
			var windowHeight = 0;
			var layerWidth = 0;
			var layerHeight = 0;
			
			var windowWidth = $(window).width();
        	var windowHeight = $(window).height() ;
        	
        	if (mergeOpts.width > 0) {
        		layerWidth = mergeOpts.width
        	} else {
        		layerWidth = $("#" + mergeOpts.showAreaId).width();
        	}
        	
        	if (mergeOpts.height > 0) {
        		layerHeight = mergeOpts.height
        	} else {
        		layerHeight = $("#" + mergeOpts.showAreaId).height();
        	}
        	
        	$("#" + mergeOpts.showAreaId).css({
        		"left" : (windowWidth/2) - (layerWidth/2),
        		"top"  : ((windowHeight/2) - (layerHeight/2)) - 50 < 0 ? 20 : ((windowHeight/2) - (layerHeight/2)) - 50,
        		"position" : "absolute"
        	});
		} else {
			$("#" + mergeOpts.showAreaId).css({
        		"left" : mergeOpts.left,
        		"top"  : mergeOpts.top,
        		"position" : "absolute"
        	});
		}
		
		$("#" + mergeOpts.showAreaId).draggable({ containment: "parent", handle: "div.layer_popup_header", cursor: "move" });
		try {
			// 필요시 콜백처리용
			if (mergeOpts.callback != null) {
				mergeOpts.callback.complete(html, status, xhr);
			}
		} catch (e) {}
		
		try {
			if (parent != null) {
				parent.autoresize_iframe_portlets();
			} else {
				autoresize_iframe_portlets();
			}
		} catch (e) {}
	});
}

function fn_showLayerPopup(opts) {
	var defaultOpts = {
			showAreaId : "layerPopupDiv"
			, url : ""
			, center : true
			, top : 0
			, left : 0
			, width : '100%'
			, height : '100%'
			, param : {}
			, callback : null
	};
	
	var mergeOpts = $.extend(true, {}, defaultOpts, opts);
	
	if (mergeOpts.url == null || mergeOpts.url == "") {
		alert("잘못된 요청입니다. 옵션의 url을 확인하십시오.");
		return;
	}
	var showObj = $("#" + mergeOpts.showAreaId).attr("id");
	if (showObj == null || showObj == undefined) {
		// 해당 아이디가 없는경우 body 태그 밑에 생성한다.
		var html = "<div id='" + mergeOpts.showAreaId + "'></div>";
		$("body").append(html);
	}
	
	$("#" + mergeOpts.showAreaId).load(mergeOpts.url, mergeOpts.param, function (res, status, xhr) {
		$("#" + mergeOpts.showAreaId + " > div.sub_layer_popup").css({
    		"width" : mergeOpts.width,
    		"height" : mergeOpts.height,
    		"left" : mergeOpts.left,
    		"top"  : mergeOpts.top,
    		"position" : "relative"
    	}).show();
		
		if (mergeOpts.center) {
			// 현제창의 중앙으로 이동시킨다.
			var windowWidth = 0;
			var windowHeight = 0;
			var layerWidth = 0;
			var layerHeight = 0;
			
			var windowWidth = $(window).width();
        	var windowHeight = $(window).height() ;
        	
        	if (mergeOpts.width > 0) {
        		layerWidth = mergeOpts.width
        	} else {
        		layerWidth = $("#" + mergeOpts.showAreaId).width();
        	}
        	
        	if (mergeOpts.height > 0) {
        		layerHeight = mergeOpts.height
        	} else {
        		layerHeight = $("#" + mergeOpts.showAreaId).height();
        	}
        	
        	$("#" + mergeOpts.showAreaId).css({
        		"left" : (windowWidth/2) - (layerWidth/2),
        		"top"  : ((windowHeight/2) - (layerHeight/2)) - 50 < 0 ? 20 : ((windowHeight/2) - (layerHeight/2)) - 50,
        		"position" : "absolute"
        	});
		} else {
			$("#" + mergeOpts.showAreaId).css({
        		"left" : mergeOpts.left,
        		"top"  : mergeOpts.top,
        		"position" : "absolute"
        	});
		}
		
		$("#" + mergeOpts.showAreaId).draggable({ containment: "parent", handle: "div.layer_popup_header", cursor: "move" });
		try {
			// 필요시 콜백처리용
			if (mergeOpts.callback != null) {
				mergeOpts.callback.complete(html, status, xhr);
			}
		} catch (e) {}
		
		try {
			if (parent != null) {
				parent.autoresize_iframe_portlets();
			} else {
				autoresize_iframe_portlets();
			}
		} catch (e) {}
	});
}

function fn_showDialogPopup(opts) {
	var defaultOpts = {
		 title : "",
		 width:"auto",
		 height:"auto",
		 modal : true,
		 showAreaId : "layerPopupDiv",
		 position : {my : "center top+20", at : "center top+20", of : "body"},
		 param : null
	};
	
	var mergeOpts = $.extend(true, {}, defaultOpts, opts);
	
	if (mergeOpts.showAreaId == null || mergeOpts.showAreaId == "") {
		mergeOpts.showAreaId == "layerPopupDiv";
	}
	
	if (mergeOpts.url == null || mergeOpts.url == "") {
		$("#" + mergeOpts.showAreaId).dialog({
			title : mergeOpts.title,
			width:mergeOpts.width,
			height:mergeOpts.height,
			modal : mergeOpts.modal,
			position : mergeOpts.position,
			buttons : mergeOpts.buttons
		});
	} else {
		fn_makeDiv(mergeOpts.showAreaId);
		$("#" + mergeOpts.showAreaId).load( mergeOpts.url, mergeOpts.param, function() {
			// 다이얼로그 오픈시 focus 순서로 인해 자동으로 focus되어 스크롤바가 이동한다.
			// * focus 순서
			// 1.autofocus attribute 가 있는 태그
			// 2.다이얼로그 내용중에 최초 tab 키로 이동 할수 있는 태그
			// 3.다이얼로그 버튼페널중에 최초 tab키로 이동 할 수 있는 태그
			// 4.다이얼로그 닫기 버튼
			// 5.다이얼로그 자체
			$("#" + mergeOpts.showAreaId).prepend("<input type='hidden' autofocus='autofocus'/>");
			$("#" + mergeOpts.showAreaId).dialog({
				title : mergeOpts.title,
				width : mergeOpts.width,
				height : mergeOpts.height,
				modal : mergeOpts.modal,
				position : mergeOpts.position,
				buttons : mergeOpts.buttons,
				autoOpen : false,
				open : function () {
					try {
						if (parent != null) {
							parent.autoresize_iframe_portlets();
						} else {
							autoresize_iframe_portlets();
						}
						$("#" + mergeOpts.showAreaId).scrollTop(0);
					} catch (e) {}
				}
		    });
		    
			$("#" + mergeOpts.showAreaId).dialog("open").on("dialogclose", function (e, ui) {
		    	try {
		    		fn_delDialogContent(mergeOpts.showAreaId);
		    		
		    		if (parent != null) {
						parent.autoresize_iframe_portlets();
					} else {
						autoresize_iframe_portlets();
					}
		    	} catch (e) {}
		    });
	    });
	}
}

function fn_delDialogContent(id) {
	$("#" + id).remove();
}

/**
 * url 이외에는 기본값으로 셋팅됨</br>
 * SecurityInterceptor에서 세션 체크 후 header로 넘어오는 로그인 페이지 이동 로직 추가</br>
 * 성공시 opts.success에 callback function을 호출
 * 에러시 opts.error에 callback function을 호출
 * @param opts
 */
function fn_ajax(opts) {
	var defaultOpts = {
			  type		: "POST"
			, async		: true
			, dataType	: "json"
			, ajaxEnview: true
			, cache		: true
			, callback	: { success : function (data) {fn_ajaxSuccess(data);}, error : function (data) {fn_ajaxError(data);}, complete : function () {} }
	};
	
	var mergeOpts = $.extend(true, {}, defaultOpts, opts);
	
	if (mergeOpts.ajaxEnview) mergeOpts.param = mergeOpts.param + "&__ajax_call__=true";

	$.ajax({
		type: mergeOpts.type,
		url: mergeOpts.url,
		data: mergeOpts.param,
		dataType: mergeOpts.dataType,
		async: mergeOpts.async,
		cache: mergeOpts.cache,
		beforeSend: function () {
			$(".dataLoading").show();
		},
		success: function(data, textStatus, jqXHR) {
			// 헤더에 enview.ajax.control 값이 있다면 로그인 페이지로 이동시킨다.
			var redirectUrl = jqXHR.getResponseHeader("enview.ajax.control");
			
			if( redirectUrl != null && redirectUrl.length>0 ) {
				window.location.href = redirectUrl;
				return;
			}
			
			if(mergeOpts.dataType != "html") {
				if (data.status == "error" || data.status == "ERROR" || !isDefined(data.status)) {
					mergeOpts.callback.error(data);
				} else {
					mergeOpts.callback.success(data);
				}
			} else {
				mergeOpts.callback.success(data);
			}
		}, 
		error: function(jqXHR, textStatus, errorThrows) {
			mergeOpts.callback.error({"status":"ERROR", "msg":"처리중 오류가 발생하였습니다."});
		},
		complete: function(jqXHR, textStatus) {
			$(".dataLoading").hide();
		}
	});
}

function holdonShow(){
    HoldOn.open({
        theme:"sk-rect",
        message:"<h4>데이터 처리중입니다.</h4>"
    });
    
}

function holdonClose(){
	HoldOn.close();
}

// id에 맞는 div객체를 찾고 없으면 새로 만든다.
function fn_makeDiv( id) {
	var check = $("#" + id).attr("id");
	if( check==null) {
		var html = "<div id='" + id + "'></div>";
		$("body").append(html);
	}
}


/**
 * Date		:	2014.08.12
 * name		:	Developwon
 * subject 	: 	null, undefined 체크
 * param 	: 	str(변수)
 * return 	:	boolean	
 */
function isDefined(str)	{				
    var isResult = false;
    var str_temp = str + "";
    str_temp = str_temp.replace(" ", "");
    
    if(str_temp != "undefined" && str_temp != "" && str_temp != "null")
    {
        isResult = true;
    }
     
    return isResult;
}


function getContextPath(){
    var oset = location.href.indexOf(location.host) + location.host.length;
    //var ctxPath = location.href.substring(oset, location.href.indexOf('/', oset + 1));
    var ctxPath = location.href.substring(oset, location.href.indexOf('/', oset));
    
    return ctxPath;
}

//공통레이어팝업
var commonLayerPopup = {
	
	//콜백클로즈함수
	callBackCloseFunction : null,	

	// 레이어 오픈
	// commonLayerPopup.openLayerPopup('/sjpb/C/C0301.face', "1000px", "300px", test1);
	openLayerPopup : function(url, width, height, callBackCloseFunc, top) {
		$('#iframeBlock').fadeIn();
	    $('#iframeContainer').fadeIn();
		
	    $('#iframeContainer iframe').attr('src', url);

	    this.callBackCloseFunction = callBackCloseFunc;
	    
	    $('#iframeContainer').css({"width":width,"height":height})  
	    
	    $('#iframeContainer').draggable();
	    //상단위치 조정이 필요할 시 (default : 50px)
	    if (top && top != "") {
	    	 $('#iframeContainer').css({"width":width,"height":height,"top":top})
	    } else {
	    	$('#iframeContainer').css({"width":width,"height":height})
	    }
	    
	    $('#iframeContainer iframe').load(function() {
	        //$('#iframeLoader').fadeOut(function() {
	            //$('#iframeContainer iframe').fadeIn();	        	
	        //});
	    	$('#iframeLoader').hide();
	    	$('#iframeContainer iframe').show();
	    	
	    });
	},

	//레이어 닫기
	// commonLayerPopup.closeLayerPopup(callBackData);
	closeLayerPopup : function(callBackData) {

	    $('#iframeContainer').fadeOut();	    
	    $('#iframeBlock').fadeOut();
	    
	    //콜백함수 호출
		if (typeof this.callBackCloseFunction == 'function') {
		   this.callBackCloseFunction(callBackData); 
		}		
	}
}

//숫자 자리수 채우기 
//ex) pad(5,7) = 0000005
function pad(n, width) {
	n = n + '';
	return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
}

//요일구하기 
//yyyy : 년도, mm : 월, dd : 일 
//ex) getDayOfWeek("2018-09-17") : 월
function getDayOfWeek(yyyy_mm_dd){
	var week = ['일', '월', '화', '수', '목', '금', '토'];
	var dayOfWeek = week[new Date(yyyy_mm_dd).getDay()];
	return dayOfWeek;
}

/**
 * YYYY-MM-DD 형태의 문자를 YYYYMMDD 형태로 변환
 * @param argDate
 * @returns {XML|string}
 */
function fncDateToStr(argDate){
    var tmp = '';
    if(argDate !== undefined){
        var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
        tmp = String(argDate).replace(/(^\s*)|(\s*$)/gi, '').replace(regExp, ''); // 공백 및 특수문자 제거
    }
    return tmp;
}

/**
 * YYYYMMDD 형태의 문자를 YYYY-MM-DD 형태로 변환
 * @param argStr : 변환할 데이터
 * @returns 변환된 데이터
 */
function fncStrToDate(argStr){
    var retVal;
    if(argStr !== undefined && String(argStr) !== ''){
        var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
        var tmp = String(argStr).replace(/(^\s*)|(\s*$)/gi, '').replace(regExp, ''); // 공백 및 특수문자 제거
        if(tmp.length <= 4){
            retVal = tmp;
        } else if(tmp.length > 4 && tmp.length <= 6){
            retVal = tmp.substr(0, 4) + '-' + tmp.substr(4, 2);
        } else if(tmp.length > 6 && tmp.length <= 8){
            retVal = tmp.substr(0, 4) + '-' + tmp.substr(4, 2) + '-' + tmp.substr(6, 2);
        } else {
            retVal = '';
        }
    }
    return retVal;
}

//공통레이어팝업
var commonLayerPopup = {
	
	//콜백클로즈함수
	callBackCloseFunction : null,	

	// 레이어 오픈
	// commonLayerPopup.openLayerPopup('/sjpb/C/C0301.face', "1000px", "300px", test1);
	openLayerPopup : function(url, width, height, callBackCloseFunc, top) {
		
		$('#iframeBlock').fadeIn();
	    $('#iframeContainer').fadeIn();
		
	    $('#iframeContainer iframe').attr('src', url);

	    this.callBackCloseFunction = callBackCloseFunc;
	    
	    $('#iframeContainer').css({"width":width,"height":height})  
	    
	    //상단위치 조정이 필요할 시 (default : 50px)
	    if (top && top != "") {
	    	 $('#iframeContainer').css({"width":width,"height":height,"top":top})
	    } else {
	    	$('#iframeContainer').css({"width":width,"height":height})
	    }
	    
	    $('#iframeContainer iframe').load(function() {
	        //$('#iframeLoader').fadeOut(function() {
	            //$('#iframeContainer iframe').fadeIn();	        	
	        //});
	    	$('#iframeLoader').hide();
	    	$('#iframeContainer iframe').show();
	    	
	    });
	    
	},

	//레이어 닫기
	// window.parent.commonLayerPopup.closeLayerPopup(callBackData);
	closeLayerPopup : function(callBackData) {

	    $('#iframeContainer').fadeOut();	    
	    $('#iframeBlock').fadeOut();
	    
	    //콜백함수 호출
		if (typeof this.callBackCloseFunction == 'function') {
		   this.callBackCloseFunction(callBackData); 
		}		
	},
	
	//레이어 닫기 (콜백없이)
	// window.parent.commonLayerPopup.closeLayerPopupOnly();
	closeLayerPopupOnly : function() {

	    $('#iframeContainer').fadeOut();	    
	    $('#iframeBlock').fadeOut();
	    
	}	

}

//통합 값 셋팅 함수
// _$obj : jquery 타겟
// value : 값 
//ex) setFieldValue($("input[name=occr_occrYrmhDtDotw]"), occrStsGrapVOMap.occrDotw);
function setFieldValue(_$obj, value){
	var nodeName = _$obj[0].nodeName.toUpperCase();
	if(nodeName == "INPUT"){
		var type = _$obj.attr("type").toUpperCase();
		var objName = _$obj.attr("name");
		if(type == "TEXT" || type == "HIDDEN" || type == "PASSWORD"){
			_$obj.val(value);
		}else if(type == "RADIO"){
			if(value == null){	//전체 체크해제 
				$("input[name="+objName+"]").prop("checked", false);
			}else{
				$("input[name="+objName+"]:radio[value='"+value+"']").prop("checked", true);
			}
		}else if(type == "CHECKBOX"){
			if(value == null){	//전체 체크해제 
				$("input[name="+objName+"]").prop("checked",false);
			}else{	
				$("input[name="+objName+"]:checkbox[value='"+value+"']").prop("checked", true);
			}
		}
	}else if(nodeName == "SELECT"){
		//_$obj.find("option[value="+value+"]").prop("selected", true);
		_$obj.val(value);
		_$obj.prev('.txt').text(_$obj.find('option:selected').text());
		
	}else if(nodeName == "TEXTAREA"){
		_$obj.val(value);
		
	//p, span ...
	}else{
		_$obj.html(value);
	}
}

//통합 값 얻기 함수
//_$obj : jquery 타겟
//ex) getFieldValue($("input[name=occr_occrYrmhDtDotw]"));
function getFieldValue(_$obj){
	var result;
	var nodeName = _$obj[0].nodeName.toUpperCase();
	var objName = _$obj.attr("name");
	if(nodeName == "INPUT"){
		var type = _$obj.attr("type").toUpperCase();
		if(type == "TEXT" || type == "HIDDEN" || type == "PASSWORD"){
			result = _$obj.val();
		}else if(type == "RADIO"){
			result = $("input[name="+objName+"]:checked").val();
		}else if(type == "CHECKBOX"){
			result = $("input[name="+objName+"]:checked").val();
		}
	}else if(nodeName == "SELECT"){
		result = $("select[name="+objName+"] option:selected").val();
		
	}else if(nodeName == "TEXTAREA"){
		result = _$obj.val();
		
	//p, span ...
	}else{
		result = _$obj.html();
	}
	
	return result;
}

//null체크 값 가져오기 
function getParamValue(param){
	return isNull(param) ? "" : param ;
}


////////////////////////////////////////////////////
// Map 구조 구현 
//var map = new Map();
//map.put("name","홍길동");
//map.get("name");
//map.length;
function Map() {
	 this.elements = {};
	 this.length = 0;
}

Map.prototype.put = function(key,value) {
	 this.length++;
	 this.elements[key] = value;
}



Map.prototype.get = function(key) {
	 return this.elements[key];
}
////////////////////////////////////////////////////

////////////////////////////////////////////////////
//List 구조 구현
var list = new List();
//list.add("홍길동");
//console.log(list.get(0));
//console.log(list.length);

function List() {
	   this.elements = {};
	   this.idx = 0;
	   this.length = 0;
}



List.prototype.add = function(element) {
   this.length++;
   this.elements[this.idx++] = element;
};



List.prototype.get = function(idx) {
   return this.elements[idx];
};
////////////////////////////////////////////////////

//전체날짜기간을 ?년?개월 포맷으로 변환 
function humanise (diff) {
	  // The string we're working with to create the representation
	  var str = "";
	  // Map lengths of `diff` to different time periods
	  //var values = [["년", 365], ["개월", 30], ["일", 1]];
	  var values = [["년", 365], ["개월", 30]];

	  // Iterate over the values...
	  for (var i=0;i<values.length;i++) {
	    var amount = Math.floor(diff / values[i][1]);

	    // ... and find the largest time value that fits into the diff
	    if (amount >= 1) {	  
	       str += amount + values[i][0] + " ";

	       // and subtract from the diff
	       diff -= amount * values[i][1];
	    }
	  }
	  if ($.trim(str)=="") str = "0개월";	  
	  return $.trim(str);	  
}

//탭 리사이즈 함수 
//탭내의 iframe 사이즈가 변경될때마다 호출해야 함.
function autoResize() {	
	if(parent.autoresize_iframe_portlet){
		parent.autoresize_iframe_portlet(); 
	}
}



//파일업로드 로직 초기화
function fn_init(){
	
	if (sjpbFile != null) {
		sjpbFile.vaultUploader.unload();
		sjpbFile = null;
	}
	sjpbFile = new SjpbEditManager();
	sjpbFile.init();
	
}

//패스워드 생성기
function password_generator( len ) {
    var length = (len)?(len):(10);
    var string = "abcdefghijklmnopqrstuvwxyz"; //to upper 
    var numeric = '0123456789';
    var punctuation = '!@#$%^&*()_+~`|}{[]\:;?><,./-=';    
    var password = "";
    var character = "";
    var crunch = true;
    while( password.length<length ) {
        entity1 = Math.ceil(string.length * Math.random()*Math.random());
        entity2 = Math.ceil(numeric.length * Math.random()*Math.random());
        entity3 = Math.ceil(punctuation.length * Math.random()*Math.random());
        hold = string.charAt( entity1 );
        hold = (password.length%2==0)?(hold.toUpperCase()):(hold);
        character += hold;
        character += numeric.charAt( entity2 );
        character += punctuation.charAt( entity3 );
        password = character;
    }
    password=password.split('').sort(function(){return 0.5-Math.random()}).join('');
    return password.substr(0,len);
}

//영역 잡아서 영역안에있는 input, textarea 데이터 맵에 넣기 
//ex) setAreaMap($("#contentsArea"), m0127VOMap);
//1. input일 경우, datepickerd이면 DB저장을위해 yyyyMMdd 형태로 받기
function setAreaMap(div, map){
	var target;				//target Obj (jquery)
	var elementName;		//노드이름
	var nodeName;
	
	div.find("input, textarea").each(function() {
		target = $(this);
		elementName = target.attr("name");
		nodeName = target[0].nodeName.toUpperCase();
		
		//datepicker이면, yyyy-MM-dd로 노출한다. 2018.11.09 추가
		if(nodeName == "INPUT" && target.hasClass("datepicker")){
			map[elementName] = new Date(toDateStr(getFieldValue(target))).format("yyyyMMdd");
		}else{
			map[elementName] = getFieldValue(target);
		}
		
	});
}

//영역 잡아서 데이터 맵에 있는 데이터 input, textarea, span, td 에 넣기 
//ex) getAreaMap($("#contentsArea"), m0127VOMap);
//1. input일 경우, datepickerd이면 화면노출을 위해 yyyy-MM-dd 형태로 보여주기
function getAreaMap(div, map){
	var target;				//target Obj (jquery)
	var elementName;		//노드이름
	var nodeName;
	
	div.find("input, textarea, span, td").each(function() {
		target = $(this);
		elementName = target.attr("name");
		nodeName = target[0].nodeName.toUpperCase();
		
		//datepicker이면, yyyy-MM-dd로 노출한다. 2018.11.09 추가
		if(nodeName == "INPUT" && target.hasClass("datepicker")){
			map[elementName] = new Date(toDateStr(map[elementName])).format("yyyy-MM-dd");
		}
		
		setFieldValue(target ,map[elementName]);
	});
}

//ex) date_str : yyyyMMdd, yyyy-MM-dd, yyyy/MM/dd
function toDateStr(date_str){
	//1. yyyyMMdd (8자리)
	//2. yyyy-MM-dd, yyyy/MM/dd (10자리)
	var returnStr = "";
	var sYear;
	var sMonth;
	var sDate;
	
	//값이 있을경우에만 
	if(!isNull(date_str)){
		if(date_str.length == 8){
			sYear = date_str.substring(0,4);
		    sMonth = date_str.substring(4,6);
		    sDate = date_str.substring(6,8);
		    
		    returnStr = sYear+"/"+sMonth+"/"+sDate;
		    
		}else if(date_str.length == 10){
			sYear = date_str.substring(0,4);
		    sMonth = date_str.substring(5,7);
		    sDate = date_str.substring(8,10);
		    
		    returnStr = sYear+"/"+sMonth+"/"+sDate;
		}
	}
	return returnStr;
}

//날짜포멧 관련 S
Date.prototype.format = function(f) {
    if (!this.valueOf()) return "";
 
    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var d = this;
     
    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
        switch ($1) {
            case "yyyy": return d.getFullYear();
            case "yy": return (d.getFullYear() % 1000).zf(2);
            case "MM": return (d.getMonth() + 1).zf(2);
            case "dd": return d.getDate().zf(2);
            case "E": return weekName[d.getDay()];
            case "HH": return d.getHours().zf(2);
            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
            case "mm": return d.getMinutes().zf(2);
            case "ss": return d.getSeconds().zf(2);
            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
            default: return $1;
        }
    });
};
 
String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
Number.prototype.zf = function(len){return this.toString().zf(len);};
//날짜포멧 관련 E

//서식관리 날짜,시,분,초 세팅
function Fn_M_SettingDate(data,str){ // Fn_M_Date
	if(data != null && data != "" && data != " "){
		var year = data.substring(0,4)+"-";
		var Month = data.substring(4,6)+"-";
		var Day = data.substring(6,8);
		var Hour = data.substring(8,10);
		var Min = data.substring(10,12);
		$("#"+str+"Cal").val(year+Month+Day);
		$("#"+str+"Hour").val(Hour);
		$("#"+str+"Min").val(Min);
	}
}
//서식관리 날짜,시,분,초 저장형식
function Fn_M_StoreDate(Cal,Hour,Min){ // Fn_M_setDate
	
	var Year = isNull(Cal) ? "" : Cal.substring(0,4);
	var Month = isNull(Cal) ? "" : Cal.substring(5,7);
	var Day = isNull(Cal) ? "" : Cal.substring(8,10);
	var H = isNull(Hour) ? "00" : ("00"+Hour).slice(-2);
	var M = isNull(Min) ? "00" : ("00"+Min).slice(-2);
	var Date = Year+Month+Day+H+M;
	
	if(Cal != null && Cal != "" && Cal !=" "){
			return Date;
	}else{
		return "";
	}
}
//시분초 데이터 정제
function Fn_M_CheckingDate(str,Cal,Hour,Min){
	
	if(Cal == null || Cal ==""){
			if((Hour != null && Hour !="")||(Min != null && Min !="")){	
				alert(str+"날짜를 입력해주세요.");
				return false;
			}
	}
}
//시,분,초 데이터 지우기
function Fn_M_CleanDate(str){
	$("#"+str+"Cal").val("");
	$("#"+str+"Hour").val("");
	$("#"+str+"Min").val("");
}
//현재날짜 2019.01.01 표시
function set_M_CurDate(str){
	var date = new Date();
	$(str).html(date.getFullYear()+"."+(date.getMonth()+1)+"."+date.getDate());
}
//20181201 -> 2018.12.01 html로 변환
function set_M_DateFormat(str,data){
	$(str).html(data.substring(0,4)+"."+data.substring(4,6)+"."+data.substring(6,8));
}
//초기화
function fn_M_init(form){
	$("#"+form)[0].reset();	
}
//object를 복사한다. 
function cloneObj(obj) {
  if (obj === null || typeof(obj) !== 'object')
  return obj;

  var copy = obj.constructor();

  for (var attr in obj) {
    if (obj.hasOwnProperty(attr)) {
      copy[attr] = obj[attr];
    }
  }
  return copy;
}

//2018.11.19 추가 S
//서식관리에서 사용 
function setUiRcptNum(parentObj){
	
	//검색조건 노출
	//사건에서 보여질 경우, 사건에 필요한것만 노출 
	if(parentObj.viewType == 'inc'){
		$("[data-view-type=inc]").show();
		$("[data-view-type=mng]").hide();
		
	//문서관리쪽에서 보여질경우, 문서관리에 필요한것만 노출
	//수정불가 
	}else{
		$("[data-view-type=inc]").hide();
		$("[data-view-type=mng]").show();
		
	}
	
	//필요한 데이터 만들기 
	var incMap = {
			rcptNum : ""
			,rcptIncNum : ""
			,pareIncNum : ""
			,incNum : ""
			,combIncYn : ""
		}
	
	//사건맵이 있으면
	if(parentObj.parent.b0101VOMap != null){
		incMap.rcptNum = getParamValue(parentObj.parent.b0101VOMap.rcptNum);			//접수번호
		incMap.rcptIncNum = getParamValue(parentObj.parent.b0101VOMap.rcptIncNum);		//사건번호
		incMap.pareIncNum = getParamValue(parentObj.parent.b0101VOMap.pareIncNum);		//부모사건번호
		incMap.incNum = getParamValue(parentObj.parent.b0101VOMap.incNum);		//부모사건번호
		incMap.combIncYn = getParamValue(parentObj.parent.b0101VOMap.combIncYn);		//부모사건번호
	}
	
	return incMap;
	
}
//2018.11.19 추가 E

//쿠키 추가 
function setCookie(c_name,value){
    var exdate=new Date();
    var c_value=escape(value);
    document.cookie=c_name + "=" + c_value + "; path=/";
}
//초기화 함수
function fn_j_init(form){
	$("#"+form)[0].reset();
	//select 값 초기화
	$("#"+form).find("select").each(function() {
		$(this).find("option:eq(0)").prop("selected", true);
		$(this).prev('.txt').text($(this).find('option:selected').text());
	});
	$("input[type=checkbox][checked]").each(function () {
		$(this).attr('checked', false);
	});
	$("#"+form+" input[type='text']").val(""); 
}