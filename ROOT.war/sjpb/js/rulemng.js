var pRule = null;

function RuleInfo() {
	this.ruleCd = null;
	this.ruleNm = null;
	this.ruleEx1 = null;
	this.ruleEx2 = null;
	this.ruleEx3 = null;
	this.ruleEx4 = null;
	this.ruleEx5 = null;
	this.ruleEx6 = null;
}

RuleUtil = function(){
	
}

RuleUtil.prototype = {
	formId : null,
	formObj : null,
	notUsed : "",
	idRuleArr : null,
	pwdRuleArr : null,
	usePrePwd : true,
	
	init : function(formId, formObj) {
		this.formId = formId;
		this.formObj = formObj;
		
		this.loadIdData();
		this.loadPwdData();
	},
	loadIdData : function() {
		// ID 정보 가져오기
		$.ajax({
			type : 'POST',
			url : '/idmng/idajax.face',
			async : false,
			dataType : 'json',
			success : function(data, textStatus){
				var json = data.json;
				if(json.result == 'success') {
					var list = json.list;
					if(list != null && list.length > 0) {	
						pRule.idRuleArr = new Array();
						var tmp = null;
						
						for(var i = 0; i<list.length; i++) {
							tmp = new RuleInfo();
							tmp.ruleCd = list[i].ruleCd;
							tmp.ruleNm = list[i].ruleNm;
							tmp.ruleEx1 = list[i].ruleEx1;
							tmp.ruleEx2 = list[i].ruleEx2;
							tmp.ruleEx3 = list[i].ruleEx3;
							tmp.ruleEx4 = list[i].ruleEx4;
							tmp.ruleEx5 = list[i].ruleEx5;
							tmp.ruleEx6 = list[i].ruleEx6;
							pRule.idRuleArr.push(tmp);
						}
						
						
					} else {
						// 리스트가 조회되지 않을 때
						
					}
				} else if(json.result == 'error') {
					
				}				
			},
			error : function(x, e, textStatus, errorThrown, XMLHttpRequest){
				alert(e);
			}
		});
	},
	loadPwdData : function() {
		// PWD 정보 가져오기
		$.ajax({
			type : 'POST',
			url : '/pwdmng/pwdajax.face',
			async : false,
			dataType : 'json',
			success : function(data, textStatus){
				var json = data.json;
				if(json.result == 'success') {
					var list = json.list;
					if(list != null && list.length > 0) {
							
						pRule.pwdRuleArr = new Array();
						var tmp = null;
						
						for(var i = 0; i<list.length; i++) {
							tmp = new RuleInfo();
							tmp.ruleCd = list[i].ruleCd;
							tmp.ruleNm = list[i].ruleNm;
							tmp.ruleEx1 = list[i].ruleEx1;
							tmp.ruleEx2 = list[i].ruleEx2;
							tmp.ruleEx3 = list[i].ruleEx3;
							tmp.ruleEx4 = list[i].ruleEx4;
							tmp.ruleEx5 = list[i].ruleEx5;
							tmp.ruleEx6 = list[i].ruleEx6;
							pRule.pwdRuleArr.push(tmp);
						}
						
					} else {
						// 리스트가 조회되지 않을 때
						
					}
				} else if(json.result == 'error') {
					
				}				
			},
			error : function(x, e, textStatus, errorThrown, XMLHttpRequest){
				alert(e);
			}
		});
	},
	setNotUsed : function(notUsed) {
		this.notUsed = notUsed;
	},
	getNotUsed : function() {
		return this.notUsed;
	},
	checkInit : function() {
		
		if(this.formId == null || this.formId == "" || this.formObj == null) {
			alert("정책 초기화 먼저 실행해주시길 바랍니다.");
			return false;
		}
		
		return true;
	},
	update : function() {
		if(this.checkInit() == false) return;
		
		var html = '<input type="hidden" name="notUsed" value="'+this.notUsed+'" />';
		$("#"+this.formId).append(html);
		
		if(document.all) document.charset = 'utf-8';
		this.formObj.acceptCharset = 'utf-8';
		this.formObj.submit();
	},
	checkId : function(id) {
		
		if(this.checkInit() == false) return "문제가 발생했습니다.";
		
		var msg = null;
		var code = "";
		var regExp = /\s/g; // 공백 체크 정규식
		
		if(id == null || id == '') {
			return "아이디를 입력해주세요.";
		}
		
		for(var i = 0; i<pRule.idRuleArr.length; i++) {
			
			code = pRule.idRuleArr[i].ruleCd;
			
			if(code === "ACCEPT_SPACE") {
				if(pRule.idRuleArr[i].ruleEx1 == 'N' && id.match(regExp) != null) {
					msg = "아이디에는 공백이 들어갈 수 없습니다.";
					break;
				}
			} else if(code === "ID_LENGTH_MIN") {
				if(id.length < Number(pRule.idRuleArr[i].ruleEx1)) {
					msg = "아이디는 최소 "+pRule.idRuleArr[i].ruleEx1+"자 이상 입력해주세요.";
					break;
				}
			} else if(code === "ID_LENGTH_MAX") {
				if(id.length > Number(pRule.idRuleArr[i].ruleEx1)) {
					msg = "아이디는 최대 "+pRule.idRuleArr[i].ruleEx1+"자까지 입력해주세요.";
					break;
				}
			} else {
				if(id == null || id == '') {
					msg = "아이디를 입력해주세요.";
					break;
				}
			}
		}
		
		return msg;
		
	}, checkPwd : function(pass) {
		
		if(this.checkInit() == false) return "문제가 발생했습니다.";
		
		var msg = "";
		var code = "";
		var regExp = /\s/g; // 공백 체크 정규식
		var regSp = /[~!@\#$%<>^&*\()\-=+_\']/gi; // 특수문자 체크 정규식
		var regNum = /[0-9]/; // 숫자 체크 정규식
		var regEng = /[a-z]|[A-Z]/; // 영문 체크 정규식
		
		if(pass == null || pass == '') {
			return "비밀번호를 입력해주세요.";
		}
		
		for(var i = 0; i<pRule.pwdRuleArr.length; i++) {
			
			code = pRule.pwdRuleArr[i].ruleCd;
			
			if(code === "PRE_USEED_PWD") {
				// 이전에 사용했던 비밀번호 허용 여부는
				// 함수로 별로도 나눠서 처리
				// checkUsePrePwd(pass); 사용
				if(pRule.pwdRuleArr[i].ruleEx1 == 'N') {
					pRule.usePrePwd = false;
				} else {
					pRule.usePrePwd = true;
				}
			} else if(code === "PWD_LENGTH_USE") {
				var lengStdObj = getValueInArray("PWD_LENGTH_STD", pRule.pwdRuleArr);
				var lengMinObj = getValueInArray("PWD_LENGTH_MIN", pRule.pwdRuleArr);
				var lengMaxObj = getValueInArray("PWD_LENGTH_MAX", pRule.pwdRuleArr);
				
				if(lengStdObj.ruleEx1 == 'S') { // 특수문자가 기준일 때
					if(pass.match(regSp) != null && (pass.length < lengMinObj.ruleEx1 || pass.length > lengMaxObj.ruleEx1)) {
						msg = "특수문자 포함시 "+lengMinObj.ruleEx1+"자 이상 "+lengMaxObj.ruleEx1+"자 이하로 입력해주세요.";
						break;
					} else if(pass.match(regSp) == null && (pass.length < lengMinObj.ruleEx2 || pass.length > lengMaxObj.ruleEx2)) {
						msg = "특수문자 미포함시 "+lengMinObj.ruleEx2+"자 이상 "+lengMaxObj.ruleEx2+"자 이하로 입력해주세요.";
						break;
					}
				} else if(lengStdObj.ruleEx1 == 'E') { // 영문이 기준일 때
					if(pass.match(regEng) != null && (pass.length < lengMinObj.ruleEx1 || pass.length > lengMaxObj.ruleEx1)) {
						msg = "영문 포함시 "+lengMinObj.ruleEx1+"자 이상 "+lengMaxObj.ruleEx1+"자 이하로 입력해주세요.";
						break;
					} else if(pass.match(regEng) == null && (pass.length < lengMinObj.ruleEx2 || pass.length > lengMaxObj.ruleEx2)) {
						msg = "영문 미포함시 "+lengMinObj.ruleEx2+"자 이상 "+lengMaxObj.ruleEx2+"자 이하로 입력해주세요.";
						break;
					}
				} else if(lengStdObj.ruleEx1 == 'N') { // 숫자가 기준일 때
					if(pass.match(regNum) != null && (pass.length < lengMinObj.ruleEx1 || pass.length > lengMaxObj.ruleEx1)) {
						msg = "숫자 포함시 "+lengMinObj.ruleEx1+"자 이상 "+lengMaxObj.ruleEx1+"자 이하로 입력해주세요.";
						break;
					} else if(pass.match(regNum) == null && (pass.length < lengMinObj.ruleEx2 || pass.length > lengMaxObj.ruleEx2)) {
						msg = "숫자 미포함시 "+lengMinObj.ruleEx2+"자 이상 "+lengMaxObj.ruleEx2+"자 이하로 입력해주세요.";
						break;
					}
				} else {
					if(pass.length < lengMinObj.ruleEx3 || pass.length > lengMaxObj.ruleEx3) {
						msg = "비밀번호를 "+lengMinObj.ruleEx3+"자 이상 "+lengMaxObj.ruleEx3+"자 이하로 입력해주세요.";
						break;
					} 
				}
				
			} else if(code === "REQ_CHAR_TYPE") {
				if(pRule.pwdRuleArr[i].ruleEx1 == "S" || pRule.pwdRuleArr[i].ruleEx2 == "S" || pRule.pwdRuleArr[i].ruleEx3 == "S") {
					if(pass.match(regSp) == null) {
						msg = "비밀번호에 특수문자가 포함되어야합니다.";
						break;
					}
				}
				if(pRule.pwdRuleArr[i].ruleEx1 == "N" || pRule.pwdRuleArr[i].ruleEx2 == "N" || pRule.pwdRuleArr[i].ruleEx3 == "N") {
					if(pass.match(regNum) == null) {
						msg = "비밀번호에 숫자가 포함되어야합니다.";
						break;
					}
				}
				if(pRule.pwdRuleArr[i].ruleEx1 == "E" || pRule.pwdRuleArr[i].ruleEx2 == "E" || pRule.pwdRuleArr[i].ruleEx3 == "E") {
					if(pass.match(regSp) == null) {
						msg = "비밀번호에 영문이 포함되어야합니다.";
						break;
					}
				}
			} else if(code === "SAME_CHAR_MAX_CNT") {
				var cntSame = 0; 
				
				for(var cnti = 0; cnti<(pass.length-1); cnti++) {
					for(var cntj = cnti+1; cntj<pass.length; cntj++) {
						if(pass.charAt(cnti) == pass.charAt(cntj)) {
							cntSame++;
						}
					}
				}
				
				if(cntSame > pRule.pwdRuleArr[i].ruleEx1) {
					msg = "동일문자 반복 횟수를 초과했습니다.";
					break;
				}
			} else if(code === "SAME_STR_MAX_CNT") {
				var cntSameStr = Number(pRule.pwdRuleArr[i].ruleEx1);
				var tmpStr = "";
				var rst = true;
				
				for(var cnt = 0; cnt < pass.length; cnt++) {
					tmpStr = pass.charAt(cnt);
					for(var mcnt = 1; mcnt <= cntSameStr; mcnt++) {
						tmpStr += tmpStr;
					}
					if(pass.search(tmpStr) > -1) {
						msg = "동일문자열 연속 횟수를 초과했습니다.";
						rst = false;
						break;
					}
				}
				
				if(rst == false) break;
				
			} else {
				if(pass == null || pass == '') {
					msg = "";
					break;
				}
			}
		}
		
		return msg;
		
	},
	checkUsePrePwd : function(pass) { 
		var result = true;
		
		if(pRule != null && pRule.usePrePwd == false) {
			$.ajax({
				type : 'POST',
				url : '/pwdmng/checkPrePwd.face',
				async : false,
				dataType : 'json',
				data : {
					pass : pass
				},
				success : function(data, textStatus){
					var json = data.json;
					if(json.result == 'success') { // 사용할 수 있는 비밀번호
						result = true;
					} else { // 이전에 사용한 비밀번호
						result = false;
					}				
				},
				error : function(x, e, textStatus, errorThrown, XMLHttpRequest){
				
				}
			});
		} 
		
		return result;
	},
	writeRuleComment : function() {
		var html = "";
		
		if(this.checkInit() == false) return;
		
		for(var i = 0; i<pRule.pwdRuleArr.length; i++) {
			
			code = pRule.pwdRuleArr[i].ruleCd;
			
			if(code === "PWD_LENGTH_USE") {
				var stdStr = "";
				var lengStdObj = getValueInArray("PWD_LENGTH_STD", pRule.pwdRuleArr);
				var lengMinObj = getValueInArray("PWD_LENGTH_MIN", pRule.pwdRuleArr);
				var lengMaxObj = getValueInArray("PWD_LENGTH_MAX", pRule.pwdRuleArr);
				
				if(lengStdObj.ruleEx1 == 'S') { // 특수문자가 기준일 때
					stdStr = "특수문자"
				} else if(lengStdObj.ruleEx1 == 'E') { // 영문이 기준일 때
					stdStr = "영문"
				} else if(lengStdObj.ruleEx1 == 'N') { // 숫자가 기준일 때
					stdStr = "숫자"
				} else {
					stdStr = ""
				}
				
				if(stdStr == "") {
					html += "<li>비밀번호는 <span>최소 "+lengMinObj.ruleEx3+"자에서 최대 "+lengMaxObj.ruleEx3+"자까지</span> 사용하실 수 있습니다.</li>";
				} else {
					html += "<li>" + stdStr + " 포함 시 <span>최소 "+lengMinObj.ruleEx1+"자에서 최대 "+lengMaxObj.ruleEx1+"자</span>까지 사용 가능하며, ";
					html += stdStr + " 미 포함 시 <span>최소 "+lengMinObj.ruleEx2+"자에서 최대 "+lengMaxObj.ruleEx2+"자</span>까지 사용하실 수 있습니다.</li>";
				}
				
			} else if(code === "REQ_CHAR_TYPE") {
				var reqStr = "";
				
				if(pRule.pwdRuleArr[i].ruleEx1 != null) {
					if(reqStr != "") reqStr += ",";
					reqStr += pRule.pwdRuleArr[i].ruleEx1;
				}
				
				if(pRule.pwdRuleArr[i].ruleEx2 != null) {
					if(reqStr != "") reqStr += ",";
					reqStr += pRule.pwdRuleArr[i].ruleEx2;
				}
				
				if(pRule.pwdRuleArr[i].ruleEx3 != null) {
					if(reqStr != "") reqStr += ",";
					reqStr += pRule.pwdRuleArr[i].ruleEx3;
				}
				
				if(reqStr != "") {
					reqStr = replaceAll(reqStr,"S","특수문자");
					reqStr = replaceAll(reqStr,"E","영어");
					reqStr = replaceAll(reqStr,"N","숫자");
					//reqStr = replaceAll(reqStr,",","와 ");
					
					html += "<li>비밀번호에는 <span>"+reqStr+"</span>가 반드시 포함되어야 합니다.</li>";
				}
				
			} else if(code === "SAME_CHAR_MAX_CNT") {
				html += "<li>연속적인 숫자와 문자 사용은 금지합니다.</li>";
			} 
			
		}
		
		html += "<li>비밀번호에는<span> 아이디를 포함</span>해서 사용하실 수 없습니다.</li>";
				
		return html;
	}
}

$(document).ready(function () {	
	
	if(pRule ==null) {
		pRule = new RuleUtil();
	}
	
	$(".isuse").each(function(index){
		if($(this).prop("checked")) {
			setIsUse($(this));
		}
	});
	
	$(".isuse").change(function(){
		setIsUse($(this));
	});
	
	$("#pwdmngForm").find("input[type=text]").on( "keypress", function( event ) {
		return digit_check(event);
	});
	
	$("#idmngForm").find("input[type=text]").on( "keypress", function( event ) {
		return digit_check(event);
	});
});	

function digit_check(evt){
	var code = evt.which?evt.which:event.keyCode;
	if(code < 48 || code > 57){
		return false;
	}
}

function setIsUse(obj) {
	var isuse = obj.val();
	var className = obj.attr("data");
	
	if(isuse == 'Y') {
		$("."+className).prop("disabled",false);
		setNotUsed(className, false);
	} else {
		$("."+className).prop("disabled",true);
		setNotUsed(className, true);
	}
}

function setNotUsed(className, isDisabled) {
	if(this.pRule != null) {
		
		var tmp = this.pRule.getNotUsed();
		
		if(isDisabled == true) {
			if(tmp != null && tmp != "") tmp += ",";
			tmp += className;
		} else {
			tmp = replaceAll(tmp,className,"");
			tmp = replaceAll(tmp,",,",",");
			
			if(tmp.lastIndexOf(",") == (tmp.length-1)) {
				tmp = tmp.substring(0,tmp.length-1);
			}
		}
		
		this.pRule.setNotUsed(tmp);
	}
}

function replaceAll(text, f , t) {
	while(true) {
		if(text.indexOf(f) < 0) break;
		text = text.replace(f, t);
	}
	
	return text;
}

function getValueInArray(key, array) {
	var obj = null;
	for(var i = 0; i<array.length; i++) {
		obj = array[i];
		if(obj.ruleCd === key) {
			break;
		} 
	}
	return obj;
}
function checkPrivateUserInfoRutin() {

	$.ajax({
		type : 'POST',
		url : '/common/checkPrivateUserInfoRutin.face',
		async : false,
		dataType : 'json',
		success : function(data, textStatus){
			if(data.result == 'success') {
				
				if(data.json.isChange == true) {
					window.location.href = "/statics/sjpbProcess/userPolicyAgree.jsp"; 
				}
			} 
		},
		error : function(x, e, textStatus, errorThrown, XMLHttpRequest){
		
		}
	});
}


function checkChangeRutin() {
	$.ajax({
		type : 'POST',
		url : '/pwdmng/checkChangeRutin.face',
		async : false,
		dataType : 'json',
		success : function(data, textStatus){
			if(data.result == 'success') {
				if(data.json.isChange == true) {
					window.location.href = "/statics/sjpbProcess/passwordChangeReq.jsp"; 
				}
			} 
		},
		error : function(x, e, textStatus, errorThrown, XMLHttpRequest){
		
		}
	});
}