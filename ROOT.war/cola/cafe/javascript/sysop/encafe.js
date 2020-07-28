<!--
var oEditors = [];
if (!window.cafe)
    window.cafe = new Object();

cafe.op = function() {
	this.m_ajax = new enview.util.Ajax();
	this.m_pageNavi = new enview.util.PageNavigationUtil();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	this.m_contextPath = ebUtil.getContextPath();
	
	this.baseInfo = new cafe.op.baseInfo(this);
	this.regInfo  = new cafe.op.regInfo (this);
	this.menuMng  = new cafe.op.menuMng (this);
	this.bltnMng  = new cafe.op.bltnMng (this);
	this.regMmbr  = new cafe.op.regMmbr (this);
	this.brdSysop = new cafe.op.brdSysop(this);
	this.rsgnMmbr = new cafe.op.rsgnMmbr(this);
	this.mmbrGrd  = new cafe.op.mmbrGrd (this);
}
cafe.op.prototype = {
	m_ajax : null,
	m_pageNavi : null,
	m_checkBox : null,
	m_contextPath : null,
	m_m : null,
	
	baseInfo : null,
	regInfo: null,
	statistics : null,
	menuMng : null,
	bltnMng : null,
	somoMng : null,
	regMmbr : null,
	brdSysop : null,
	rsgnMmbr : null,
	mmbrGrd : null,
	mailSms : null,
	homeDeco : null,
	ttlDeco : null,
	gateDeco : null,
	decoArch : null,
	rcmdDeco : null,
	
	getMsgBox : function() {
		if (this.m_msgBox == null) {
			if ( enviewMessageBox == null ) {
				enviewMessageBox = new enview.portal.MessageBox(200, 120, 1000);
			}
			this.m_msgBox = enviewMessageBox;
		}
		return this.m_msgBox
	},
	chgOpArea : function(m) {
		this.m_m = m;
		var param = "m=" + m;
		param += "&cmntId=" + document.transferForm.cmntId.value;
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(htmlData) { cfOp.chgOpAreaHandler(htmlData); }});
	},
	chgOpAreaHandler : function(htmlData) {
		document.getElementById("opArea").innerHTML = htmlData;
		if (this.m_m == "baseInfo") {
			$(function() {
				// $("#baseInfoTabs").tabs();
				var tab = $('.tab_wrap');
				tab.removeClass('js_off');
				tab.css('height', tab.find('>ul>li>div:visible').height()+40);
				function onSelectTab(){
					var t = $(this);
					var myClass = t.parent('li').attr('class');
					t.parents('.tab_wrap:first').attr('class', 'tab_wrap '+myClass);
					tab.css('height', t.next('div').height()+40);
				}
				tab.find('>ul>li>a').click(onSelectTab).focus(onSelectTab);
			});
			cfOp.baseInfo.m_curTabId = null; // 본판부터 다시 호출될때는 초기화해주어야 한다.
			cfOp.baseInfo.selectTab(0);
		} else  if (this.m_m == "regMmbr") {
			$(function() {
				$("#regMmbrTabs").tabs();
			});
			cfOp.regMmbr.m_curTabId = null; // 본판부터 다시 호출될때는 초기화해주어야 한다.
			cfOp.regMmbr.selectTab(0);
		} else if (this.m_m == "brdSysop") {
			cfOp.brdSysop.init();
		} else if (this.m_m == "rsgnMmbr") {
			cfOp.rsgnMmbr.init();
		} else if (this.m_m == "menuMng" ) {
			cfOp.menuMng.init();
		} else  if (this.m_m == "bltnMng") {
			$(function() {
				$("#bltnMngTabs").tabs();
			});
			cfOp.bltnMng.m_curTabId = null; // 본판부터 다시 호출될때는 초기화해주어야 한다.
			cfOp.bltnMng.selectTab(0);
		}else  if (this.m_m == "regInfo") {
			$(function() {
				 $( ".datepicker" ).datepicker({
					  	dateFormat: "yy.mm.dd"
				  });
				 $( "#reg_denyBgnYmd" ).datepicker().on('change', function (e) { 
//					 alert( $( "#reg_denyBgnYmd" ).val());
					 $( "#reg_denyEndYmd" ).datepicker( "option", "minDate", $( "#reg_denyBgnYmd" ).datepicker().val());
				 });
				 
			});
		}
		if( parent.autoresize_iframe_portlets) {
			parent.autoresize_iframe_portlets()
		}
		
		
	},
	goJigi : function() {
		var frm = document.transferForm;
		frm.m.value = "goJigi";
		frm.action = this.m_contextPath+"/cafe/" + frm.cmntUrl.value;
		frm.submit();
	},
	goEachHome : function() {
		var frm = document.transferForm;
		frm.m.value = "";
		frm.action = this.m_contextPath+"/cafe/" + frm.cmntUrl.value;
		frm.submit();
	},
	popupView : function(src) {
		src.popupView();
	},
	viewUserDtl : function(userId) {
	}
}
cafe.op.baseInfo = function (parent) {
	this.m_parent = parent;
	this.m_ajax = parent.m_ajax;
	this.m_contextPath = parent.m_contextPath;
}
cafe.op.baseInfo.prototype = {
	m_parent : null,
	m_ajax : null,
	m_contextPath : null,
	m_curTabId : null,
	
	selectTab : function (tabId) {
		if (this.m_curTabId == tabId ) return;
		this.m_curTabId = tabId;
		var param = "m=baseInfo";
		param += "&cmntId=" + document.transferForm.cmntId.value;
		switch (tabId) {
			case 0: param += "&cmd=base"; this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(htmlData) { cfOp.baseInfo.selectTabHandler(htmlData); }}); break;
			case 1: param += "&cmd=rule"; this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(htmlData) { cfOp.baseInfo.selectTabHandler(htmlData); }}); break;
			case 2: param += "&cmd=close"; this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(htmlData) { cfOp.baseInfo.selectTabHandler(htmlData); }}); break;
			// case 3: param += "&cmd=tran"; this.m_ajax.send("POST",
			// this.m_contextPath+"/cafe/op.cafe", param, true, {success:
			// function(htmlData) { cfOp.baseInfo.selectTabHandler(htmlData);
			// }}); break;
		}
	},
	selectTabHandler : function (htmlData) {
		// alert(this.m_curTabId+"="+htmlData);
		switch (this.m_curTabId) {
			case 0: 
				document.getElementById("baseInfoBaseTab").innerHTML = htmlData; 
				var openYn = ebUtil.getCheckedValue(document.getElementsByName('base_openYn'));
				var regTypes = document.getElementsByName('base_regType');
				if( openYn=='Y') {
					regTypes[0].disabled = false;
					regTypes[1].disabled = false;
					regTypes[2].disabled = true;
				}  else {
					regTypes[0].disabled = true;
					regTypes[1].disabled = true;
					regTypes[2].disabled = false;
				}
				break;
			case 1: document.getElementById("baseInfoRuleTab").innerHTML = htmlData; break;
			case 2: 
				document.getElementById("baseInfoCloseTab").innerHTML = htmlData;
				if (document.getElementById('close_content')) {
					// FCKeditor 관련 초기화
					enLangKnd = eval("document.transferForm.langKnd.value"); 
					/*
					 * var ebFCKeditor = new FCKeditor('close_content');
					 * ebFCKeditor.BasePath = ebUtil.getContextPath() +
					 * '/board/fckeditor/';
					 * ebFCKeditor.Config["CustomConfigurationsPath"] =
					 * ebUtil.getContextPath()+'/cola/cafe/javascript/fckconfig_close_cafe.js';
					 * ebFCKeditor.Height = 300; ebFCKeditor.ReplaceTextarea();
					 */
					/*
					 * var dextEditor = null;
					 * 
					 * //DEXT5.config.InitServerXml = ebUtil.getContextPath() +
					 * "/dext/config/enboard_editor.xml"; DEXT5.config.InitXml =
					 * "enboard_editor.xml"; DEXT5.config.Width = "100%";
					 * DEXT5.config.Height = "400px"; DEXT5.config.HandlerUrl =
					 * ebUtil.getContextPath() +
					 * "/dext5editor/handler/enboard_handler.jsp";
					 * DEXT5.config.DevelopLangage = "JAVA";
					 * DEXT5.config.RunTimes = "html5";
					 * DEXT5.config.FrameFullScreen = '1';
					 * 
					 * DEXT5.config.EditorHolder = "editorCntt";
					 * 
					 * dextEditor = new Dext5editor("editorCntt");
					 */
					var skinUrl= ebUtil.getContextPath() + "/board/smarteditor/SmartEditor2NoImageSkin.html";	// 사진업로드
																												// 불가능한
																												// 스마트
																												// 에디터
																												// 스킨
					
					nhn.husky.EZCreator.createInIFrame({
						oAppRef: oEditors,
						elPlaceHolder: "close_content",
						sSkinURI: skinUrl,	
						htParams : {
							bUseToolbar : true,				// 툴바 사용 여부
															// (true:사용/
															// false:사용하지 않음)
							bUseVerticalResizer : false,		// 입력창 크기 조절바 사용
																// 여부 (true:사용/
																// false:사용하지
																// 않음)
							bUseModeChanger : true,			// 모드 탭(Editor |
															// HTML | TEXT) 사용
															// 여부 (true:사용/
															// false:사용하지 않음)
							// aAdditionalFontList : aAdditionalFontSet, // 추가
							// 글꼴 목록
							fOnBeforeUnload : function(){
								// alert("완료!");
							}
						}, // boolean
						fOnAppLoad : function(){
							// 예제 코드
							// oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이
							// 완료된 후에 본문에 삽입되는 text입니다."]);
						},
						fCreator: "createSEditor2"
					});
					
					
				}
				break;
			case 3: document.getElementById("baseInfoTranTab").innerHTML = htmlData; break;
		}
			var tab = "#tab"+this.m_curTabId;
			$(".cafeadm_tabmenu ul li").removeClass("on");
			$(tab).addClass("on");
			$(".tabcontent").hide();
			var activeTab = $(tab).children("a").attr("onclick");
			$("#" + activeTab).show();

			if( parent.autoresize_iframe_portlets) {
				setTimeout( parent.autoresize_iframe_portlets(), 200);
			}
			
			
	},
	checkBaseInfoBase : function() {
		if (!ebUtil.chkValue (document.getElementById("base_cmntNm"), "카페명을", "true")) return;
		/*
		 * if (document.getElementById("base_somoLimitCnt").value != "") { if
		 * (!ebUtil.chkNum(document.getElementById("base_somoLimitCnt"), "소모임 개설
		 * 허용 갯수에", "true")) return; }
		 */
		var cateHier = parseInt(document.setForm.cateHier.value);
		var cateSelected = false;
		var emlCateId = null;
		for (var i=cateHier; i>0; i--) {
			elmCateId = document.getElementById ("base_cateId"+i);
			if (ebUtil.getSelectedValue(elmCateId) != null && ebUtil.getSelectedValue(elmCateId) != "") {
				cateSelected = true;
				break;
			}
		}
		
		
		
		if( !ebUtil.checkLength(document.getElementById ("baseInfoBaseFileForm"))) {
//		if( !ebUtil.checkLength(document.getElementById ("base_cmntNm"))) {
			return;
		}
		
		if (!cateSelected) if (!ebUtil.chkSelect (elmCateId, 1, "카테고리를", "true")) return;

		var cmntTags = "";
		for (var i=1; i<=8; i++) {
			var tag = document.getElementById("base_cmntTag"+i).value;
			if (tag.length > 0) cmntTags += tag + ",";
		}
		if (cmntTags == "") {
			if (!ebUtil.chkValue (document.getElementById("base_cmntTag1"), "검색태그를", "true")) return;
		} else {
			cmntTags = cmntTags.substring(0, cmntTags.length-1); // remove
																	// ','.
		}
		if (!ebUtil.chkValue (document.getElementById("base_cmntIntro"), "카페 소개글을", "true")) return;
		if (!ebUtil.chkLength (document.getElementById("base_cmntIntro"), "카페 소개글", 600, "true")) return;
		if (document.getElementById("base_cmntWelcome").value.length > 0) {
			if (!ebUtil.chkLength (document.getElementById("base_cmntWelcome"), "가입 환영 인사", 600, "true")) return;
		}
		var frm = document.baseInfoBaseFileForm;
		frm.action = this.m_contextPath+"/cafe/op.cafe?m=setBaseInfoBaseCafeImg&cmntId=" + document.transferForm.cmntId.value;
		frm.target = "baseInfoBaseImg";
		frm.submit();
	},
	setBaseInfoBase : function() {
		var cmntTags = "";
		for (var i=1; i<=8; i++) {
			var tag = document.getElementById("base_cmntTag"+i).value;
			if (tag.length > 0) cmntTags += tag + ",";
		}
		var param = "m=setBaseInfoBase";
		param += "&cmntId=" + document.transferForm.cmntId.value;
		param += "&cmntNm=" + document.getElementById("base_cmntNm").value;
		param += "&openYn=" + ebUtil.getCheckedValue (document.getElementsByName("base_openYn"));
//		param += "&openYn=" + document.getElementById("base_openYn").value
		param += "&regType=" + ebUtil.getCheckedValue (document.getElementsByName("base_regType"));
//		param += "&nmType=" + ebUtil.getCheckedValue (document.getElementsByName("base_nmType"));
		param += "&nmType=" + document.getElementById("base_nmType").value;
		//ebUtil.getCheckedValue (document.getElementsByName("base_nmType"));
		
		var cateHier = document.setForm.cateHier.value;
		var elmCateId = null;
		for (var i=cateHier; i>0; i--) {
			elmCateId = document.getElementById ("base_cateId"+i);
			if (ebUtil.getSelectedValue(elmCateId) != null && ebUtil.getSelectedValue(elmCateId) != "") {
				param += "&cateId=" + ebUtil.getSelectedValue(elmCateId);
				break;
			}
		}
		
		param += "&cmntTag=" + cmntTags;
		param += "&cmntIntro=" + document.getElementById("base_cmntIntro").value;
		param += "&cmntWelcome=" + document.getElementById("base_cmntWelcome").value;
		param += "&fileMask=" + document.setForm.cmntImgFileMask.value;

		this.m_ajax.send( "POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(data) { cfOp.baseInfo.setBaseInfoBaseHandler(data); }});
	},
	setBaseInfoBaseHandler : function(data) {
		cfOp.getMsgBox().doShow (ebUtil.getMessage("mm.info.common.success"));
		cfOp.chgOpArea('baseInfo')
	},
	setBaseInfoRule : function() {
		if (!ebUtil.chkValue (document.getElementById("rule_cmntRule"), "운영 회칙을", "true")) return;
		var param = "m=setBaseInfoRule";
		param += "&cmntId=" + document.transferForm.cmntId.value;
		param += "&cmntRule=" + document.getElementById("rule_cmntRule").value;

		this.m_ajax.send( "POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(data) { cfOp.baseInfo.setBaseInfoRuleHandler(data); }});
	},
	setBaseInfoRuleHandler : function(data) {
		cfOp.getMsgBox().doShow (ebUtil.getMessage("mm.info.common.success"));
	},
	closeCafe : function (flag) {
		
		if (document.getElementById("close_try").value == "already") {
			if (flag == "realtime" || flag == "defered")
				alert("이미 카페 폐쇄를 신청하셨습니다.");
			else if (flag == "cancel")
				alert("이미 카페 폐쇄를 취소하셨습니다.");
			return;
		}
		/*
		if (flag == "defered" || flag == "cancel") {
			if (!ebUtil.chkValue (document.getElementById("close_title"), "공지 제목을", "true")) return;
			try {
// document.getElementById("set_close_content").value =
// DEXT5.getBodyValue('editorCntt');
				document.getElementById("set_close_content").value = oEditors.getById["editorCntt"].getIR()
			} catch (ex) {
				// FCKeditor 를 사용하지 않는 경우에는...
				document.getElementById("set_close_content").value = document.getElementById("close_content").value;
			}
			if (!ebUtil.chkValue (document.getElementById("set_close_content"), "공지내용을", "false")) return;
		} else if (flag == "realtime") {
			alert ("카페가 폐쇄되면 게시글을 포함한 모든 데이터를 복구할 수 없습니다!");
		}
		if (flag == "realtime" || flag == "defered")
			if (!confirm ("정말 카페를 폐쇄하시겠습니까?")) return;
		else if (flag == "cancel") {
			if (!confirm ("카페를 폐쇄를 취소하시겠습니까?")) return;
		}
		*/
		
		var param = "m=setBaseInfoClose";
		param += "&cmntId=" + document.transferForm.cmntId.value;
		/*
		if (flag == "defered" || flag == "cancel") {
			param += "&title=" + document.getElementById("close_title").value;
			param += "&content=" + document.getElementById("set_close_content").value;
			// document.setTransfer.bltnCntt.value =	DEXT5.getBodyValue('editorCntt');
		}
		*/
		this.m_ajax.send ("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(data) { cfOp.baseInfo.closeCafeHandler(data); }});
		
	},
	closeCafeHandler : function () {
		cfOp.getMsgBox().doShow (ebUtil.getMessage("mm.info.success"));
		//document.getElementById("close_try").value = "already";
		// 기본정보 조회
		cfOp.chgOpArea('baseInfo');
	},
	setOpenType : function (val) {
		ebUtil.setCheckedValue(document.getElementsByName('base_openYn'), val);
		var regTypes = document.getElementsByName('base_regType');
		if( val=='Y') {
			regTypes[0].disabled = false;
			regTypes[1].disabled = false;
			regTypes[2].disabled = true;
			ebUtil.setCheckedValue(document.getElementsByName('base_regType'), 'A');
		}  else {
			regTypes[0].disabled = true;
			regTypes[1].disabled = true;
			regTypes[2].disabled = false;
			ebUtil.setCheckedValue(document.getElementsByName('base_regType'), 'V');
		}
	}
}
cafe.op.regInfo = function (parent) {
	this.m_parent = parent;
	this.m_ajax = parent.m_ajax;
	this.m_contextPath = parent.m_contextPath;
}
cafe.op.regInfo.prototype = {
	m_parent : null,
	m_ajax : null,
	m_contextPath : null,
	
	checkLimitQuiz : function(elm) {
		ebUtil.setCheckedValue (document.getElementsByName(elm.id), elm.value); // radio
																				// buttons
																				// 토클
																				// 연동
																				// 처리.
		if (ebUtil.getCheckedValue (document.getElementsByName(elm.id)) == "N") {
			document.getElementById("reg_quizDiv").style.display = "none";
		} else {
			document.getElementById("reg_quizDiv").style.display = "";
		}
	},
	checkLimitQstn : function(elm) {
		ebUtil.setCheckedValue (document.getElementsByName(elm.id), elm.value);
		if (ebUtil.getCheckedValue (document.getElementsByName(elm.id)) == "N") {
			document.getElementById("reg_qstnDiv").style.display = "none";
		} else {
			document.getElementById("reg_qstnDiv").style.display = "";
		}
	},
	changeQstnType : function(elm) {
		document.getElementById("reg_newQstn").value = "";
		if (ebUtil.getSelectedValue(elm) == "A") { // 질문이 '선택형'이면.
			document.getElementById("reg_newAnswDiv").style.display = "";
		} else { // '서술형'이면 답변항목 초기화하고 감추기.
			var maxAnswCnt = document.getElementById("reg_maxQstnCnt").value;
			for (var i=1; i<=maxAnswCnt; i++) document.getElementById("reg_newAnsw"+i).value = "";
			document.getElementById("reg_newAnswDiv").style.display = "none";
		}
	},
	registRegQstn : function() {
		var curQstnCnt = document.getElementById("reg_curQstnCnt").value;
		var maxQstnCnt = document.getElementById("reg_maxQstnCnt").value;
		if (curQstnCnt >= maxQstnCnt) {
			alert("가입설문은 최대 "+maxQstnCnt+"문항까지 등록 가능합니다.");
			return;
		}		
		if (!ebUtil.chkValue(document.getElementById("reg_newQstn"), "가입설문을", "true")) return;

		var qstnType = ebUtil.getSelectedValue(document.getElementById("reg_qstnType"));
		var maxAnswCnt = document.getElementById("reg_maxAnswCnt").value;
		if (qstnType == "A") { // 질문이 '선택형'이면.
			var answCnt = 0;
			for (var i=1; i<=maxAnswCnt; i++) {
				if (document.getElementById("reg_newAnsw"+i).value.length > 0) answCnt++;
			}
			if (answCnt < 2) {
				alert("가입설문의 답변항목을 2개 이상 입력하십시오");
				return;
			}
		}
		var param = "m=setRegInfoRegQstn";
		param += "&cmd=" + "ins";
		param += "&cmntId=" + document.transferForm.cmntId.value;
		param += "&qstnType=" + qstnType;
		param += "&qstnCntt=" + document.getElementById("reg_newQstn").value;
		if (qstnType == "A") { // '선택형' 설문이면.
			param += "&answCntt=";
			for (var i=1; i<=maxAnswCnt; i++) {
				if (document.getElementById("reg_newAnsw"+i).value.length > 0) {
					param += "[[SEP]]" + document.getElementById("reg_newAnsw"+i).value
				}
			}
		}
		this.m_ajax.send ("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(htmlData) { cfOp.regInfo.registRegQstnHandler(htmlData); }});
	},
	registRegQstnHandler : function(htmlData) {
		document.getElementById("reg_regQstnUl").innerHTML = htmlData;
	},
	deleteRegQstn : function(seq) {
		if( !confirm (ebUtil.getMessage("ev.info.remove"))) return;
		var param = "m=setRegInfoRegQstn";
		param += "&cmd=" + "del";
		param += "&cmntId=" + document.transferForm.cmntId.value;
		param += "&qstnSeq=" + seq;
		this.m_ajax.send ("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(htmlData) { cfOp.regInfo.registRegQstnHandler(htmlData); }});
	},
	setCmntLimit : function() {
		if (ebUtil.getCheckedValue (document.getElementsByName("reg_limitQuiz")) == "Y") {
			if (!ebUtil.chkValue (document.getElementById("reg_regQuizQstn"), "가입퀴즈 질문을", "true")) return;
			if (!ebUtil.chkValue (document.getElementById("reg_regQuizAnsw"), "가입퀴즈 정답을", "true")) return;
		}
		if (ebUtil.getCheckedValue (document.getElementsByName("reg_limitTerm")) == "Y") {
			if (!ebUtil.chkValue (document.getElementById("reg_denyBgnYmd"), "가입 제한 시작일자를", "true")) return;
			if (!ebUtil.chkValue (document.getElementById("reg_denyEndYmd"), "가입 제한 종료일자를", "true")) return;
		}
		
		if('Y'== ebUtil.getCheckedValue (document.getElementsByName("reg_limitAge"))) {
			var b = ebUtil.getSelectedValue (document.getElementById("reg_ageBgnYyyy"));
			var e = ebUtil.getSelectedValue (document.getElementById("reg_ageEndYyyy"));
			if( b > e) {
				alert( "시작년도가 끝년도보다 작습니다");
				document.getElementById("reg_ageBgnYyyy").focus();
				return;
			}
			
		}
		
		
		
		var param = "m=setCmntLimit";
		param += "&cmntId=" + document.transferForm.cmntId.value;
		param += "&limitSex=" + ebUtil.getCheckedValue (document.getElementsByName("reg_limitSex"));
		param += "&limitAge=" + ebUtil.getCheckedValue (document.getElementsByName("reg_limitAge"));
		param += "&ageBgnYyyyB=" + ebUtil.getSelectedValue (document.getElementById("reg_ageBgnYyyyB"));
		param += "&ageBgnYyyyA=" + ebUtil.getSelectedValue (document.getElementById("reg_ageBgnYyyyA"));
		param += "&ageBgnYyyy=" + ebUtil.getSelectedValue (document.getElementById("reg_ageBgnYyyy"));
		param += "&ageEndYyyy=" + ebUtil.getSelectedValue (document.getElementById("reg_ageEndYyyy"));
		param += "&locCode=" + ebUtil.getSelectedValue (document.getElementById("reg_locCode"));
		param += "&majorCode=" + ebUtil.getSelectedValue (document.getElementById("reg_majorCode"));
		param += "&cllgCode=" + ebUtil.getSelectedValue (document.getElementById("reg_cllgCode"));
		param += "&orgCode=" + ebUtil.getSelectedValue (document.getElementById("reg_orgCode"));
		param += "&limitQuiz=" + ebUtil.getCheckedValue (document.getElementsByName("reg_limitQuiz"));
		param += "&regQuizQstn=" + document.getElementById("reg_regQuizQstn").value;
		param += "&regQuizAnsw=" + document.getElementById("reg_regQuizAnsw").value;
		param += "&limitQstn=" + ebUtil.getCheckedValue (document.getElementsByName("reg_limitQstn"));
		param += "&limitTerm=" + ebUtil.getCheckedValue (document.getElementsByName("reg_limitTerm"));
		param += "&denyBgnYmd=" + document.getElementById("reg_denyBgnYmd").value;
		param += "&denyEndYmd=" + document.getElementById("reg_denyEndYmd").value;
		
		this.m_ajax.send ("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(data) { cfOp.regInfo.setCmntLimitHandler(data); }});
	},
	setCmntLimitHandler : function(data) {
		cfOp.getMsgBox().doShow (ebUtil.getMessage("mm.info.common.success"));
		cfOp.chgOpArea('regInfo');
	}
}
cafe.op.regMmbr = function (parent) {
	this.m_parent = parent;
	this.m_pageNavi = parent.m_pageNavi;
	this.m_ajax = parent.m_ajax;
	
	this.m_contextPath = parent.m_contextPath;
}
cafe.op.regMmbr.prototype = {
	m_parent : null,
	m_ajax : null,
	m_pageNavi : null,
	m_contextPath : null,
	m_curTabId : null,
	m_stateCodeGetter : null,

	selectTab : function (tabId, reset) {
		if( reset != "true") if (this.m_curTabId == tabId ) return;
		this.m_curTabId = tabId;
		var param = "m=regMmbr";
		param += "&cmntId=" + document.transferForm.cmntId.value;
		switch (tabId) {
			case 0: param += "&cmd=all"; this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(htmlData) { cfOp.regMmbr.selectTabHandler(htmlData); }}); break;
			case 1: param += "&cmd=gup"; this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(htmlData) { cfOp.regMmbr.selectTabHandler(htmlData); }}); break;
			case 2: param += "&cmd=inv"; this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(htmlData) { cfOp.regMmbr.selectTabHandler(htmlData); }}); break;
		}
	},
	selectTabHandler : function (htmlData) {
		switch (this.m_curTabId) {
			case 0: document.getElementById("regMmbrAllTab").innerHTML = htmlData; cfOp.regMmbr.genPageNavi("all_srchForm"); break;
			case 1: document.getElementById("regMmbrGupTab").innerHTML = htmlData; cfOp.regMmbr.genPageNavi("gup_srchForm"); break;
			case 2: document.getElementById("regMmbrInvTab").innerHTML = htmlData; cfOp.regMmbr.genPageNavi("inv_srchForm"); break;
		}
		var tab = "#reg_tab"+this.m_curTabId;
		$(".cafeadm_tabmenu ul li").removeClass("on");
		$(tab).addClass("on");
		$(".tabcontent").hide();
		var activeTab = $(tab).children("a").attr("onclick");
		$("#" + activeTab).show();
		if( parent.autoresize_iframe_portlets) {
			setTimeout( parent.autoresize_iframe_portlets(), 200);
		}
	},
	genPageNavi : function (formNm) {
		var frm = document.forms[formNm];
		// alert("frm=["+frm+"],formNm=["+formNm+"]");
		var pageNo = document.forms[formNm].pageNo.value;
		var pageSize = frm.pageSize.value;
		var totalSize = frm.totalSize.value;
		var pageFunction = frm.pageFunction.value;
		var naviDivNm = frm.naviDivNm.value;
		
		document.getElementById(naviDivNm).innerHTML = this.m_pageNavi.getPageIteratorHtmlStringCafe (pageNo, pageSize, totalSize, frm.name, pageFunction, this.m_contextPath);
	},
	doPage : function (formNm, pageNo) {
		var frm = document.forms[formNm];
	    frm.pageNo.value = pageNo;
		cfOp.regMmbr.search(formNm);
	},
	search : function (formNm) {
		var frm = document.forms[formNm];
		var param = "m=regMmbr";
		param += "&cmntId=" + document.transferForm.cmntId.value;
		param = ebUtil.completeParam (frm, param);
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(htmlData) { cfOp.regMmbr.selectTabHandler(htmlData); }});
	},
	sort : function (formNm, colNm) {
		var frm = document.forms[formNm];
		if (frm.sortMethod.value == "ASC") frm.sortMethod.value = "DESC";
		else                               frm.sortMethod.value = "ASC";
		frm.sortColumn.value = colNm;
		cfOp.regMmbr.search(formNm);
	},
	changeGrade : function(opt) {
		if (!ebUtil.chkCheck(document.getElementsByName(opt+"_checkRow"), "회원을", "false")) return;

		var mmbrGrd = document.getElementById(opt+"_changeGrd").value;
		if( mmbrGrd=='X') {
			
			if( ebUtil.chkCheckCnt( document.getElementsByName(opt+"_checkRow"), 1, "카페지기는 한명만 설정할 수 있습니다", true )) {
				var userId = ebUtil.getCheckedValue( document.getElementsByName(opt+"_checkRow"));
				var param = "m=setCafeAdmin";
				param += "&cmntId=" + document.transferForm.cmntId.value;
				param += "&userId=" + userId;
				this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(data) { cfOp.regMmbr.setCafeAdminHandler(data); }});
			}
			return;
		}
		
		
		var param = "m=setRegMmbrChangeGrade";
		param += "&cmntId=" + document.transferForm.cmntId.value;
		param += "&userId=" + ebUtil.getCheckedValues(document.getElementsByName(opt+"_checkRow"));
		param += "&mmbrGrd=" + document.getElementById(opt+"_changeGrd").value;
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(data) { cfOp.regMmbr.changeGradeHandler(data); }});
	},
	changeGradeHandler : function(data) {
		cfOp.getMsgBox().doShow (ebUtil.getMessage("mm.info.common.success"));
		cfOp.regMmbr.selectTab(this.m_curTabId, "true");
	},
	setCafeAdmin : function( userId) {
		var param = "m=setCafeAdmin";
		param += "&cmntId=" + document.transferForm.cmntId.value;
		param += "&userId=" + userId;
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(data) { cfOp.regMmbr.setCafeAdminHandler(data); }});
	},
	setCafeAdminHandler : function(data) {
		cfOp.getMsgBox().doShow (ebUtil.getMessage("mm.info.common.success"));
		cfOp.regMmbr.selectTab(this.m_curTabId, "true");
	},
	checkChangeState : function(opt, state) {
		if (!ebUtil.chkCheck(document.getElementsByName(opt+"_checkRow"), "회원을", "false")) return;
		var checkList = document.getElementsByName(opt+"_checkRow");
		for (var i=0; i<checkList.length; i++) {
			if (checkList[i].checked) {
				if (checkList[i].getAttribute("stateFlag") == state) {
					// alert(ebUtil.getMessage("cf.error.cant.change.same.state"));
					alert( ebUtil.getMessage("cf.error.cant.change.same.state"));
					return;
				}
				if (checkList[i].getAttribute("mmbrGrd") == "X") {
					// alert(ebUtil.getMessage("cf.error.cant.change.sysop.grade"));
					// // 카페지기 등급 변경 불가.
					if (state == "21" || state == "23" || state == "40" || state == "51") { // 가입거부/초대거부/활동중지/강제탈퇴
						alert(ebUtil.getMessage("cf.error.cant.change.sysop.state")); // 카페지기 등급 변경 불가.
					} else {
						alert(ebUtil.getMessage("cf.error.cant.change.sysop.grade")); // 카페지기 등급 변경 불가.
					}
					return;
				}
			}
		}		
		if (state == "21" || state == "23" || state == "40" || state == "51") { // 가입거부/초대거부/활동중지/강제탈퇴
			cfOp.regMmbr.getStateCodeGetter().doShow(opt, state);
		} else {
			cfOp.regMmbr.changeState(opt, state);
		}
	},
	changeState : function(opt, state) {
		var param = "m=setRegMmbrChangeState";
		param += "&cmntId=" + document.transferForm.cmntId.value;
		param += "&userId=" + ebUtil.getCheckedValues(document.getElementsByName(opt+"_checkRow"));
		param += "&stateFlag=" + state;
		if (state == "21" || state == "23" || state == "40" || state == "51") { // 가입거부/초대거부/활동중지/강제탈퇴
			param += "&stateCode=" + ebUtil.getCheckedValue(document.getElementsByName("stateCodeGetter_stateCode"));
			param += "&stateDesc=" + document.getElementById("stateCodeGetter_stateDesc").value;
		}
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(data) { cfOp.regMmbr.changeStateHandler(data); }});
	},
	changeStateHandler : function(data) {
		cfOp.getMsgBox().doShow (ebUtil.getMessage("mm.info.common.success"));
		cfOp.regMmbr.selectTab(this.m_curTabId, "true");
	},
	getStateCodeGetter : function() {
		if (this.m_stateCodeGetter == null) {
			this.m_stateCodeGetter = new cafe.op.regMmbr.StateCodeGetter(this);
		}
		return this.m_stateCodeGetter;
	}
}
cafe.op.regMmbr.StateCodeGetter = function(parent) {
	this.m_elmArea = document.getElementById("stateCodeGetter");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	
	$("#stateCodeGetter").dialog({
		autoOpen: false,
		resizable: false,
		modal: true,
		buttons: {
			Close: function() {
				$(this).dialog("close");
			},
			Confirm: function() {
				cfOp.regMmbr.getStateCodeGetter().confirm();
			}
		}
	});
}
cafe.op.regMmbr.StateCodeGetter.prototype = {
	m_elmArea : null,
	m_contextPath : null,
	m_opt : null,
	m_state : null,
	
	doShow : function(opt, state) {
		this.m_opt = opt;
		this.m_state = state;
		cfOp.regMmbr.getStateCodeGetter().doGet();
		$('#stateCodeGetter').dialog('open');
	},
	doGet : function() {
		var param = "m=regMmbrStateCodeGetter";
		param += "&cmntId=" + document.transferForm.cmntId.value;
		param += "&stateFlag=" + this.m_state;
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(htmlData) { cfOp.regMmbr.getStateCodeGetter().doGetHandler(htmlData); }});
	},
	doGetHandler : function(htmlData) {
		this.m_elmArea.innerHTML = htmlData;
	},
	confirm : function() {
		if (!ebUtil.chkCheck (document.getElementsByName("stateCodeGetter_stateCode"), "사유코드를", "true")) return;
		if (ebUtil.getCheckedValue (document.getElementsByName("stateCodeGetter_stateCode")) == "99") {
			if (!ebUtil.chkValue (document.getElementById("stateCodeGetter_stateDesc"), "기타 사유를", "true")) return;
			if (!ebUtil.chkLength (document.getElementById("stateCodeGetter_stateDesc"), "기타 사유", 256, "true")) return;
		}
		cfOp.regMmbr.changeState(this.m_opt, this.m_state);
		$("#stateCodeGetter").dialog("close");
	}
}
cafe.op.brdSysop = function (parent) {
	this.m_parent      = parent;
	this.m_pageNavi    = parent.m_pageNavi;
	this.m_ajax        = parent.m_ajax;
	this.m_checkBox    = parent.m_checkBox;
	this.m_contextPath = parent.m_contextPath;
}
cafe.op.brdSysop.prototype = {
	m_parent      : null,
	m_pageNavi    : null,
	m_ajax        : null,
	m_checkBox    : null,
	m_contextPath : null,

	init : function() {
		cfOp.brdSysop.genPageNavi("brd_srchForm");
	},
	genPageNavi : function (formNm) {
		var frm = document.forms[formNm];
		// alert("frm=["+frm+"],formNm=["+formNm+"]");
		var pageNo       = document.forms[formNm].pageNo.value;
		var pageSize     = frm.pageSize.value;
		var totalSize    = frm.totalSize.value;
		var pageFunction = frm.pageFunction.value;
		var naviDivNm    = frm.naviDivNm.value;
		
		document.getElementById(naviDivNm).innerHTML = this.m_pageNavi.getPageIteratorHtmlStringCafe (pageNo, pageSize, totalSize, frm.name, pageFunction, this.m_contextPath);
	},
	doPage : function (formNm, pageNo) {
		var frm = document.forms[formNm];
	    frm.pageNo.value = pageNo;
		cfOp.brdSysop.search(formNm);
	},
	search : function (formNm) {
		var frm = document.forms[formNm];
		var param = "m=brdSysop";
		param += "&cmntId=" + document.transferForm.cmntId.value;
		param = ebUtil.completeParam (frm, param);
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(htmlData) { cfOp.brdSysop.searchHandler(htmlData); }});
	},
	searchHandler : function(htmlData) {
		document.getElementById("opArea").innerHTML = htmlData;
		cfOp.brdSysop.genPageNavi("brd_srchForm");
	},
	sort : function (formNm, colNm) {
		var frm = document.forms[formNm];
		if (frm.sortMethod.value == "ASC") frm.sortMethod.value = "DESC";
		else                               frm.sortMethod.value = "ASC";
		frm.sortColumn.value = colNm;
		cfOp.brdSysop.search(formNm);
	},
	selectCandidate : function() {
		if (!ebUtil.chkCheck (document.getElementsByName("brd_checkRow"), "게시판을", "true")) return;
		cfOp.brdSysop.getUserChooser().doShow (document.transferForm.cmntId.value);
	},
	addBoardSysop : function (userIds) {
		var param = "m=setBoardSysop";
		param += "&cmd=ins";
		param += "&cmntId="  + document.transferForm.cmntId.value;
		param += "&boardId=" + ebUtil.getCheckedValues (document.getElementsByName("brd_checkRow"));
		param += "&userId="  + userIds;
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(data) { cfOp.brdSysop.addBoardSysopHandler(data); }});
	},
	addBoardSysopHandler : function(data) {
		cfOp.getMsgBox().doShow (ebUtil.getMessage("mm.info.common.success"));
//		cfOp.chgOpArea("brdSysop");
		cfOp.brdSysop.search('brd_srchForm');
	},
	removeBoardSysop : function () {
		var userIds = "";
		var elms = document.getElementsByName("brd_checkRow");
		for (var i=0; i<elms.length; i++) {
			if (elms[i].checked) {
				var userId = elms[i].getAttribute("userId");
				if (userId != null && userId != "") {
					userIds += elms[i].value + "," + userId + ";";
				}
			}
		}
		if (userIds != "") userIds = userIds.substr (0, userIds.length-1);
		if (userIds == "") {
			alert("해제하시고자 하는 게시판지기를 선택하십시오.");
			return;
		}
		
		var param = "m=setBoardSysop";
		param += "&cmd=del";
		param += "&cmntId="  + document.transferForm.cmntId.value;
		param += "&userId="  + userIds;
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(data) { cfOp.brdSysop.removeBoardSysopHandler(data); }});
	},
	removeBoardSysopHandler : function (data) {
		cfOp.getMsgBox().doShow (ebUtil.getMessage("mm.info.common.success"));
//		cfOp.chgOpArea("brdSysop");
		cfOp.brdSysop.search('brd_srchForm');
	},
	getUserChooser : function() {
		if (this.m_userChooser == null) {
			this.m_userChooser = new cafe.op.brdSysop.UserChooser(this);
		}
		return this.m_userChooser;
	}
}
cafe.op.brdSysop.UserChooser = function (parent) {
	this.m_elmArea = document.getElementById("brdUserChooser");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_pageNavi = parent.m_pageNavi;
	this.m_checkBox = parent.m_checkBox;
	
	$("#brdUserChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:600, 
		modal: true,
		buttons: {
			Cancel: function() {
				$(this).dialog('close');
			},
			Apply: function() {
				if (!ebUtil.chkCheck (document.getElementsByName("userChooser_checkRow"), '추가하고자 하는 사용자를', "true")) return;
				cfOp.brdSysop.addBoardSysop (ebUtil.getCheckedValues (document.getElementsByName("userChooser_checkRow")));
				$(this).dialog('close');
			}
		}
	});
}
cafe.op.brdSysop.UserChooser.prototype = {
	m_elmArea : null,
	m_checkedRow : null,
	m_contextPath : null,
	m_ajax : null,
	m_pageNavi : null,
	m_checkBox : null,
	m_curCmntId : null,
	m_pageNo : 1,
	m_pageSize : 5,
	m_totalSize : null,
	
	doShow : function (cmntId) {
		this.m_curCmntId = cmntId;
		cfOp.brdSysop.getUserChooser().m_pageNo = 1;
		cfOp.brdSysop.getUserChooser().doGet();
		$('#brdUserChooser').dialog('open');
	},
	doGet : function() {
		var param = "m=uiMmbrList";
		param += "&cmntId="    + this.m_curCmntId;
		param += "&pageNo="     + this.m_pageNo;
		param += "&pageSize="   + this.m_pageSize;
		this.m_ajax.send ("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(htmlData) { cfOp.brdSysop.getUserChooser().doGetHandler(htmlData); }});		
	},
	doGetHandler : function (htmlData) {
		this.m_checkedRow = null; // 초기화
		this.m_elmArea.innerHTML = htmlData;
		this.m_totalSize = document.brdUserChooserForm.totalSize.value;
		document.getElementById("brdUserChooserPageIterator").innerHTML 
		= this.m_pageNavi.getPageIteratorHtmlStringCafe( this.m_pageNo, this.m_pageSize, this.m_totalSize, "brdUserChooserForm", "cfOp.brdSysop.getUserChooser().doPage");
		
		var frm = document.brdUserChooserForm;
		if (frm.srchUserId.value == "")    frm.srchUserId.value   = ebUtil.getMessage('eb.info.ttl.l.id');
		if (frm.srchUserNick.value  == "") frm.srchUserNick.value = ebUtil.getMessage('eb.info.ttl.l.name');

	},
	doPage : function (formName, pageNo) {
		this.m_pageNo = pageNo;
		cfOp.brdSysop.getUserChooser().doSearch();
	},
	doSelect : function (idx) {
		var checkedRow = document.getElementById("userChooser_checkRow_"+idx );
		if (checkedRow.checked) checkedRow.checked = false;
		else                   checkedRow.checked = true;
	},
	doSearch : function(pageNo) {
		
		if (pageNo != null) this.m_pageNo = pageNo;
		
		var frm = document.brdUserChooserForm;
		if (frm.srchUserId.value == ebUtil.getMessage('eb.info.ttl.l.id'))      frm.srchUserId.value    = "";
		if (frm.srchUserNick.value  == ebUtil.getMessage('eb.info.ttl.l.name')) frm.srchUserNick.value  = "";
		var param = "m=uiMmbrList";
		param += "&cmntId="       + this.m_curCmntId;
		param += "&pageNo="       + this.m_pageNo;
		param += "&pageSize="     + this.m_pageSize;
		param += "&srchUserId="   + frm.srchUserId.value;
		param += "&srchUserNick=" + frm.srchUserNick.value;
		this.m_ajax.send ("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(htmlData) { cfOp.brdSysop.getUserChooser().doGetHandler(htmlData); }});		
	}
}
cafe.op.rsgnMmbr = function (parent) {
	this.m_parent = parent;
	this.m_pageNavi = parent.m_pageNavi;
	this.m_ajax = parent.m_ajax;
	
	this.m_contextPath = parent.m_contextPath;
}
cafe.op.rsgnMmbr.prototype = {
	m_parent : null,
	m_ajax : null,
	m_pageNavi : null,
	m_contextPath : null,

	init : function() {
		cfOp.rsgnMmbr.genPageNavi("rsgn_srchForm");
	},
	genPageNavi : function (formNm) {
		var frm = document.forms[formNm];
		// alert("frm=["+frm+"],formNm=["+formNm+"]");
		var pageNo = document.forms[formNm].pageNo.value;
		var pageSize = frm.pageSize.value;
		var totalSize = frm.totalSize.value;
		var pageFunction = frm.pageFunction.value;
		var naviDivNm = frm.naviDivNm.value;
		
		document.getElementById(naviDivNm).innerHTML = this.m_pageNavi.getPageIteratorHtmlStringCafe (pageNo, pageSize, totalSize, frm.name, pageFunction, this.m_contextPath);
	},
	doPage : function (formNm, pageNo) {
		var frm = document.forms[formNm];
	    frm.pageNo.value = pageNo;
		cfOp.rsgnMmbr.search(formNm);
	},
	search : function (formNm) {
		var frm = document.forms[formNm];
		var param = "m=rsgnMmbr";
		param += "&cmntId=" + document.transferForm.cmntId.value;
		param = ebUtil.completeParam (frm, param);
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(htmlData) { cfOp.rsgnMmbr.searchHandler(htmlData); }});
	},
	searchHandler : function(htmlData) {
		document.getElementById("opArea").innerHTML = htmlData;
		cfOp.rsgnMmbr.genPageNavi("rsgn_srchForm");
	},
	sort : function (formNm, colNm) {
		var frm = document.forms[formNm];
		if (frm.sortMethod.value == "ASC") frm.sortMethod.value = "DESC";
		else                               frm.sortMethod.value = "ASC";
		frm.sortColumn.value = colNm;
		cfOp.rsgnMmbr.search(formNm);
	},
	changeState : function(opt, state) {
		if (!ebUtil.chkCheck(document.getElementsByName(opt+"_checkRow"), "회원을", "false")) return;
		var checkList = document.getElementsByName(opt+"_checkRow");
		for (var i=0; i<checkList.length; i++) {
			if (checkList[i].checked) {
				if (checkList[i].getAttribute("stateFlag") != state) {
					alert("해제하고자 하는 상태에 해당하지 않는 사용자가 포함되었습니다.");
					return;
				}
			}
		}		
		var param = "m=setRsgnMmbrChangeState";
		param += "&cmntId=" + document.transferForm.cmntId.value;
		param += "&userId=" + ebUtil.getCheckedValues(document.getElementsByName(opt+"_checkRow"));
		param += "&stateFlag=" + state;
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(data) { cfOp.rsgnMmbr.changeStateHandler(data); }});
	},
	changeStateHandler : function(data) {
		cfOp.getMsgBox().doShow (ebUtil.getMessage("mm.info.common.success"));
		cfOp.rsgnMmbr.search("rsgn_srchForm");
	}
}
cafe.op.mmbrGrd = function (parent) {
	this.m_parent = parent;
	this.m_pageNavi = parent.m_pageNavi;
	this.m_ajax = parent.m_ajax;
	
	this.m_contextPath = parent.m_contextPath;
}
cafe.op.mmbrGrd.prototype = {
	m_parent : null,
	m_ajax : null,
	m_pageNavi : null,
	m_contextPath : null,
	
	selectGradeCnt : function(elm) {
		var gradeCnt = elm.value;
		var gradeTRs = document.getElementsByName("grd_gradeTr");
		for (var i=0; i<gradeTRs.length-2; i++) { // Loop에서 W/X 등급은 제외.
			if (gradeTRs[i].getAttribute("seq") <= gradeCnt-2) {
				gradeTRs[i].style.display = "";
			} else {
				gradeTRs[i].style.display = "none";
			}
		}
		var grdupTRs = document.getElementsByName("grd_grdupTr");
		for (var i=0; i<grdupTRs.length; i++) {
			if (grdupTRs[i].getAttribute("seq") <= gradeCnt - 4) {
				grdupTRs[i].style.display = "";
			} else {
				grdupTRs[i].style.display = "none";
			}
		}
	},
	setCheckAll : function(e) {
		var grdupTRs = document.getElementsByName("grd_grdupTr");
		for (var i=0; i<grdupTRs.length; i++) {
			var shortGrd = grdupTRs[i].getAttribute("shortGrd");
			document.getElementById("grd_checkRow"+shortGrd).checked = e.checked;		
		}
	}
	,
	setCmntGrdup : function() {
		var param = "m=setCmntGrdup";
		param += "&cmntId=" + document.transferForm.cmntId.value;
		
		var gradeNms = "";
		var gradeTRs = document.getElementsByName("grd_gradeTr");
		for (var i=0; i<gradeTRs.length; i++) {
			if (gradeTRs[i].style.display == "none") {
				gradeNms += gradeTRs[i].getAttribute("shortGrd") + ":del:dm" + elmGradeNm.value + ",";
			} else {
				var elmGradeNm = document.getElementById("grd_gradeNm"+gradeTRs[i].getAttribute("seq"));
				if (!ebUtil.chkValue   (elmGradeNm, "등급명을", "ture")) return;
				if (!ebUtil.chkSpecial (elmGradeNm, "등급명에", "true")) return;

				gradeNms += gradeTRs[i].getAttribute("shortGrd") + ":upd:" + elmGradeNm.value + ",";
			}
		}
		if (gradeNms.length > 0) gradeNms = gradeNms.substring(0,gradeNms.length-1); // Remove
																						// last
																						// ','
		
		param += "&gradeNm=" + gradeNms;
		
		var gradeCds = "";
		var grdupTRs = document.getElementsByName("grd_grdupTr");
		for (var i=0; i<grdupTRs.length; i++) {
			var shortGrd = grdupTRs[i].getAttribute("shortGrd");
			if (grdupTRs[i].style.display == "none") {
				gradeCds += shortGrd + ":del:dm:dm:dm:dm,";
			} else {
				if (document.getElementById("grd_checkRow"+shortGrd).checked) {
					if (!ebUtil.chkValue (document.getElementById("grd_bltnCnt"+shortGrd), "게시글 수를", "true")) return;
					if (!ebUtil.chkValue (document.getElementById("grd_memoCnt"+shortGrd), "댓글 수를", "true")) return;
					if (!ebUtil.chkValue (document.getElementById("grd_visitCnt"+shortGrd), "방문 횟수를", "true")) return;
					if (!ebUtil.chkNum (document.getElementById("grd_bltnCnt"+shortGrd), "게시글 수에", "true")) return;
					if (!ebUtil.chkNum (document.getElementById("grd_memoCnt"+shortGrd), "댓글 수에", "true")) return;
					if (!ebUtil.chkNum (document.getElementById("grd_visitCnt"+shortGrd), "방문 횟수에", "true")) return;
					gradeCds += shortGrd + ":upd:";
					gradeCds += document.getElementById ("grd_bltnCnt"+shortGrd).value + ":";
					gradeCds += document.getElementById ("grd_memoCnt"+shortGrd).value + ":";
					gradeCds += document.getElementById ("grd_visitCnt"+shortGrd).value + ":";
					gradeCds += ebUtil.getSelectedValue (document.getElementById("grd_upKind"+shortGrd)) + ",";
				}
			}
		}
		if (gradeCds.length > 0) gradeCds = gradeCds.substring (0,gradeCds.length -1); // Remove
																						// last
																						// ','
		
		param += "&gradeCd=" + gradeCds;

		this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(data) { cfOp.mmbrGrd.setCmntGrdupHandler(data); }});
	},
	setCmntGrdupHandler : function(data) {
		cfOp.getMsgBox().doShow (ebUtil.getMessage("mm.info.common.success"));
		cfOp.chgOpArea("mmbrGrd");
	}
}
cafe.op.menuMng = function (parent) {
	this.m_parent      = parent;
	this.m_pageNavi    = parent.m_pageNavi;
	this.m_ajax        = parent.m_ajax;
	this.m_contextPath = parent.m_contextPath;
	this.m_menuIdx = 1;
}
cafe.op.menuMng.prototype = {
	m_parent      : null,
	m_ajax        : null,
	m_pageNavi    : null,
	m_contextPath : null,
	m_trash       : null,
	m_menuIdx : null,
	
	init : function() {
		// $("#menu_menuTree").sortable({placeholder: 'cafeformlabel'});
		$("#menu_menuTree").sortable();
		// $("#menu_menuTree").disableSelection();
	},
	affectMenuItem : function(flag) {
		if (flag == "add") {
		
			// 선택이 안되어 있을 때 경고창
			if( $("li.menuList[isSelected='T']").size() <= 0 ){
				alert('추가할 메뉴의 상위 메뉴를 선택하세요.');
				return;
			}
			
// 선택이 안되어 있을 때 선택 후 추가
// if( $("li.menuList[isSelected='T']").size() <= 0 ){
// this.selectMenu($("li.menuList")[0]);
// }
			// 메뉴아이템 복사
			var menuType   = $("select[id='menu_menuType']").children("option:selected").attr("value");
			var menuTypeNm = $("select[id='menu_menuType']").children("option:selected").text();
			var cnttType   = $("select[id='menu_menuType']").children("option:selected").attr("cnttType");
			var cnttUrl    = $("select[id='menu_menuType']").children("option:selected").attr("cnttUrl");
			
			var addMenuIdx = "N" + (++this.m_menuIdx);
			$("li.menuList[isSelected='T']").after($("li.menuList[isSelected='T']").clone().attr("menuId", addMenuIdx).attr("menuType", menuType).attr("isSelected","F").attr("cnttType",cnttType).css("background","#ffffff"));
			$("li[menuId='"+addMenuIdx+"'] > ul").attr("id","menu_hiddenUl"+addMenuIdx).attr("name","menu_hiddenUl"+addMenuIdx);
			$("li[menuId='"+addMenuIdx+"']").attr("menuLevel","1");

			if (menuType == "S") {
				$("li[menuId='"+addMenuIdx+"'] > span").text("---------------------");
			} else {
				$("li[menuId='"+addMenuIdx+"'] > span").text(menuTypeNm);
			}
			if (menuType == "G") {
				$("li[menuId='"+addMenuIdx+"'] > img").css("display","").attr("menuId",addMenuIdx);
			} else {
				$("li[menuId='"+addMenuIdx+"'] > img").css("display","none").attr("menuId",addMenuIdx);
			}

			// 메뉴아이템에 따른 우측 편집화면 복사
			var srcMenuId = $("li.menuList[isSelected='T']").attr("menuId");
			var menuForm = $("div[id='menu_form"+srcMenuId+"']").clone().attr("id","menu_form"+addMenuIdx);

			// 복사 후 기타 설정
			$(menuForm).find("input[id*='menu_initMenuYn']").each(function(i) {
				$(this).attr("id","menu_initMenuYn"+addMenuIdx);
				$(this).attr("name","menu_initMenuYn"+addMenuIdx);
			});
			$(menuForm).find("input[id*='menu_menuHideYn']").each(function(i) {
				$(this).attr("id","menu_menuHideYn"+addMenuIdx);
				$(this).attr("name","menu_menuHideYn"+addMenuIdx);
			});
			$(menuForm).find("input[id*='menu_groupFoldYn']").each(function(i) {
				$(this).attr("id","menu_groupFoldYn"+addMenuIdx);
				$(this).attr("name","menu_groupFoldYn"+addMenuIdx);
			});
			$(menuForm).find("input[id*='menu_anonYn']").each(function(i) {
				$(this).attr("id","menu_anonYn"+addMenuIdx);
				$(this).attr("name","menu_anonYn"+addMenuIdx);
			});

			$("div[id='menu_form"+srcMenuId+"']").after(menuForm);			
			$("#menu_form"+addMenuIdx).css("display","none");
			
			ebUtil.setCheckedValue($("div#menu_form"+addMenuIdx).find("input[id*='menu_initMenuYn']").get(), "N");
			ebUtil.setCheckedValue($("div#menu_form"+addMenuIdx).find("input[id*='menu_menuHideYn']").get(), "N");
			ebUtil.setCheckedValue($("div#menu_form"+addMenuIdx).find("input[id*='menu_groupFoldYn']").get(), "N");
			ebUtil.setCheckedValue($("div#menu_form"+addMenuIdx).find("input[id*='menu_anonYn']").get(), "N");

			if (menuType == "E" || menuType == "S") { // '여백'이거나 '분리자'이면.

				$("#menu_form"+addMenuIdx).find("tr").css("display","none");
				$("#menu_form"+addMenuIdx).find("input#menu_menuNm").val(menuTypeNm);
				$("#menu_form"+addMenuIdx).find("input#menu_menuDesc").val(menuTypeNm);
				$("#menu_form"+addMenuIdx).find("tr#trComment"+menuType).css("display","");
				$("#menu_form"+addMenuIdx).find("tr#trGridLimit").css("display","");

			} else { // '여백'도 아니고 '분리자'도 아니면.
				
				$("#menu_form"+addMenuIdx).find("input#menu_menuNm").val(menuTypeNm);
				$("#menu_form"+addMenuIdx).find("tr#trMenuNm").css("display","");
				if (cnttType.substring(0,1) == "9") $("#menu_form"+addMenuIdx).find("input#menu_menuNm").attr("disabled",true);
				else                                $("#menu_form"+addMenuIdx).find("input#menu_menuNm").attr("disabled",false);
				
				$("#menu_form"+addMenuIdx).find("input#menu_menuDesc").val(menuTypeNm);
				if (menuType != "M" || cnttType.substring(0,1) == "9") $("#menu_form"+addMenuIdx).find("tr#trMenuDesc").css("display","none");
				else                                                   $("#menu_form"+addMenuIdx).find("tr#trMenuDesc").css("display","");
				
				$("#menu_form"+addMenuIdx).find("input#menu_cnttUrl").val(cnttUrl);
				if (menuType == "M" && cnttType == "20") $("#menu_form"+addMenuIdx).find("tr#trCnttUrl").css("display","");
				else                                     $("#menu_form"+addMenuIdx).find("tr#trCnttUrl").css("display","none");

				if (menuType != "M") {
					$("#menu_form"+addMenuIdx).find("tr#trInitMenuYn").css("display","none");
					$("#menu_form"+addMenuIdx).find("tr#trMenuHideYn").css("display","none");
					$("#menu_form"+addMenuIdx).find("tr#trGroupFoldYn").css("display","");
					$("#menu_form"+addMenuIdx).find("tr#trAnonYn").css("display","none");
					$("#menu_form"+addMenuIdx).find("tr#trGrade").css("display","none");
				} else {
					$("#menu_form"+addMenuIdx).find("tr#trInitMenuYn").css("display","");
					$("#menu_form"+addMenuIdx).find("tr#trMenuHideYn").css("display","");
					$("#menu_form"+addMenuIdx).find("tr#trGroupFoldYn").css("display","none");
					if (menuType != "M" || cnttType.substring(0,1) == "2" || cnttType.substring(0,1) == "8" || cnttType.substring(0,1) == "9")
						$("#menu_form"+addMenuIdx).find("tr#trAnonYn").css("display","none");
					else
						$("#menu_form"+addMenuIdx).find("tr#trAnonYn").css("display","");
					$("#menu_form"+addMenuIdx).find("tr#trGrade").css("display","");
					$("#menu_form"+addMenuIdx).find("select#menu_readGrade").val("C"); // 디폴트는
																						// 모두
																						// '운영자'등급으로
					$("#menu_form"+addMenuIdx).find("select#menu_wrtGrade").val("C"); // 디폴트는
																						// 모두
																						// '운영자'등급으로
					$("#menu_form"+addMenuIdx).find("select#menu_replyGrade").val("C"); // 디폴트는
																						// 모두
																						// '운영자'등급으로
					$("#menu_form"+addMenuIdx).find("select#menu_memoGrade").val("C"); // 디폴트는
																						// 모두
																						// '운영자'등급으로
					if (cnttType.substring(0,1) == "2" || cnttType.substring(0,1) == "8") {
						$("#menu_form"+addMenuIdx).find("span#menu_readGradeNm") .html("조    회");
						$("#menu_form"+addMenuIdx).find("span#menu_wrtGradeNm")  .html("생    성");
						$("#menu_form"+addMenuIdx).find("span#menu_replyGradeNm").html("수    정");
						$("#menu_form"+addMenuIdx).find("span#menu_memoGradeNm") .html("삭    제");
					} else {
						$("#menu_form"+addMenuIdx).find("span#menu_readGradeNm") .html("읽    기");
						$("#menu_form"+addMenuIdx).find("span#menu_wrtGradeNm")  .html("쓰    기");
						$("#menu_form"+addMenuIdx).find("span#menu_replyGradeNm").html("답글쓰기");
						$("#menu_form"+addMenuIdx).find("span#menu_memoGradeNm") .html("댓글쓰기");
					}
				}
				
				if (cnttType == "14") $("#menu_form"+addMenuIdx).find("div#divMemoGrade").css("display","none");
				else                  $("#menu_form"+addMenuIdx).find("div#divMemoGrade").css("display","");

				$("#menu_form"+addMenuIdx).find("tr#trCommentS").css("display","none");
				$("#menu_form"+addMenuIdx).find("tr#trCommentE").css("display","none");
			}
		} else if (flag == "remove") {
			var cnttType = $("li.menuList[isSelected='T']").attr("cnttType");
			if (cnttType.length > 0 && (cnttType.substring(0,1) == "8")) {
				alert("선택된 게시판은 삭제할 수 없습니다.");
				return;
			}
			var menuId = $("li.menuList[isSelected='T']").attr("menuId");
			$("li.menuList[isSelected='T']").remove();
			$("div#menu_form"+menuId).remove();
			
		} else if (flag == "first") {
			if ($("li[id='menu_menuLi']:first").attr("menuId") == $("li.menuList[isSelected='T']").attr("menuId")) return;
			$("li[id='menu_menuLi']:first").before($("li.menuList[isSelected='T']"));
		} else if (flag == "up") {
			$("li.menuList[isSelected='T']").prev().before($("li.menuList[isSelected='T']"));
		} else if (flag == "down") {
			$("li.menuList[isSelected='T']").next().after($("li.menuList[isSelected='T']"));
		} else if (flag == "last") {
			if ($("li[id='menu_menuLi']:last").attr("menuId") == $("li.menuList[isSelected='T']").attr("menuId")) return;
			$("li[id='menu_menuLi']:last").after($("li.menuList[isSelected='T']"));
		} else if (flag == "indent") {
			if ( $("li.menuList[isSelected='T']").attr("menuType") == "M") {
				var menuLabel = $("li.menuList[isSelected='T'] > span").text();
				if ($("li.menuList[isSelected='T']").attr("menuLevel") == "1") {
					$("li.menuList[isSelected='T']").attr("menuLevel","2");
					$("li.menuList[isSelected='T'] > span").toggleClass("indent_2");
					$("li.menuList[isSelected='T'] > span").text("└" + menuLabel);
				} else {
					$("li.menuList[isSelected='T']").attr("menuLevel","1");
					$("li.menuList[isSelected='T'] > span").toggleClass("indent_2");
					$("li.menuList[isSelected='T'] > span").text(menuLabel.replace("└",""));
				}
			}
		}
	},
	toggleMenuGroup : function(elm) {
		var menuId = elm.getAttribute("menuId");
		var isCollapsed = $("li[menuId='"+menuId+"']").attr("isCollapsed");
		if (isCollapsed == "F") {
			var inCollapse = false;
			var menus = document.getElementsByName("menu_menuLi");
			for (var i=0; i<menus.length; i++) {
				// alert("2::curMenuId=["+menus[i].getAttribute("menuId")+"],curMenuType=["+menus[i].getAttribute("menuType")+"],inCollapse=["+inCollapse+"]");
				if (menus[i].getAttribute("menuId") == menuId) {
					inCollapse = true;
				} else {
					if (inCollapse && menus[i].getAttribute("menuType") != "M") {
						break;
					}
					if (inCollapse && menus[i].getAttribute("menuType") == "M") {
						$('li[menuId="'+menus[i].getAttribute("menuId")+'"]').appendTo($('ul[name="menu_hiddenUl'+menuId+'"]'));
					}
				}
			}
			$("li[menuId='"+menuId+"']").attr("isCollapsed","T");
			elm.src = this.m_contextPath + "/cola/cafe/images/sysop/encafe/tiny_down_arrow.gif";
		} else {
			$('li[menuId="'+menuId+'"]').after($('ul[name="menu_hiddenUl'+menuId+'"] > li'));
			$("li[menuId='"+menuId+"']").attr("isCollapsed","F");
			elm.src = this.m_contextPath + "/cola/cafe/images/sysop/encafe/tiny_up_arrow.gif";
		}
	},
	selectMenu : function(nElm) {
		// 먼저 현재 선택되어 있던 메뉴의 변경 내역을 체크한다.
		var cId = $("li.menuList[isSelected='T']").attr("menuId");
		if (cId != null && cId.length > 0) {
			var cType = $("li.menuList[isSelected='T']").attr("menuType");
			if (cType != 'E' && cType != 'S') {
				if (!ebUtil.chkValue($("div#menu_form"+cId).find("input#menu_menuNm")[0], "메뉴명을", "true")) return;
			}
			var cCntt = $("li.menuList[isSelected='T']").attr("cnttType");
			if (cType == 'M' && cCntt.substring(0,1) != "8" && cCntt.substring(0,1) != "9") {
				if (!ebUtil.chkValue($("div#menu_form"+cId).find("input#menu_menuDesc")[0], "메뉴설명을", "true")) return;
			}
		}
		// 새롭게 선택된 메뉴를 현재 선택된 메뉴로 바꾸어 준다.
		$(nElm).attr("isSelected", "T"); 
		$(nElm).addClass('menu_selected');
		var nId = $(nElm).attr("menuId");
		$("li.menuList[menuId!='"+nId+"']").attr("isSelected", "F").removeClass('menu_selected');
		// 선택된 메뉴내역을 보여주고 나머지 메뉴내역을 숨긴다.
		$("div[id='menu_form"+nId+"']").css("display","");
		$("div[id*='menu_form']").filter("div[id!='menu_form"+nId+"']").css("display","none");
	},
	// ////////////////////////////////////////////////////////////////////////////////////////////////////////
	// setCmntMenu()는 원래 아래와 같이 코딩되어 있었으나, IE7 이하 버전에서 객체가 제대로 선택되지 않아 수정하였으며,
	// 원본을 setCmntMenuIE8() 로 이름을 바꾸어 참고용으로 백업하였다.
	// IE7 이하에서는 연속적인 select가 제대로 동작하지 않는다.
	// 즉, 다음과 같은 구문은 객체를 제대로 선택해오지 못한다.
	// $("div#menu_form"+cId+" input#menu_initMenuYn"+cId)
	// 이를 다음과 같이 바꾸어야 한다.
	// $("div#menu_form"+cId).find("input#menu_initMenuYn"+cId)
	// 2012.03.14.KWShin.
	// ////////////////////////////////////////////////////////////////////////////////////////////////////////
	setCmntMenuIE8 : function() {
		var dataAll = "";
		$("li#menu_menuLi").each(function(i) {
			
			var data = "";
			var cId = $(this).attr("menuId");
			
			data += "[[sep]]" + cId;
			data += "[[sep]]" + $(this).attr("menuLevel");
			data += "[[sep]]" + ebUtil.getCheckedValue($("div#menu_form"+cId+" input#menu_initMenuYn"+cId).get());
			data += "[[sep]]" + ebUtil.getCheckedValue($("div#menu_form"+cId+" input#menu_menuHideYn"+cId).get());
			data += "[[sep]]" + ebUtil.getCheckedValue($("div#menu_form"+cId+" input#menu_groupFoldYn"+cId).get());
			data += "[[sep]]" + $(this).attr("menuType");
			data += "[[sep]]" + $(this).attr("cnttType");
			data += "[[sep]]" + $("div#menu_form"+cId+" input#menu_menuNm").val();
			data += "[[sep]]" + $("div#menu_form"+cId+" input#menu_menuDesc").val();
			data += "[[sep]]" + ebUtil.getCheckedValue($("div#menu_form"+cId+" input#menu_anonYn"+cId).get());
			data += "[[sep]]" + ebUtil.getSelectedValue($("div#menu_form"+cId+" select#menu_readGrade").get(0));
			data += "[[sep]]" + ebUtil.getSelectedValue($("div#menu_form"+cId+" select#menu_wrtGrade").get(0));
			data += "[[sep]]" + ebUtil.getSelectedValue($("div#menu_form"+cId+" select#menu_replyGrade").get(0));
			data += "[[sep]]" + ebUtil.getSelectedValue($("div#menu_form"+cId+" select#menu_memoGrade").get(0));
			// alert(data);
			dataAll += "[[SEP]]" + data.substring(7); // 맨처음 분리자 제거 후 결합.
		});
		var param = "m=setCmntMenu";
		param += "&cmntId=" + document.transferForm.cmntId.value;
		param += "&menuDesc=" + encodeURIComponent(dataAll.substring(7)); // 맨처음 분리자 제거 후 전송.
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(data) { cfOp.menuMng.setCmntMenuHandler(data); }});
	},
	setCmntMenu : function() {
		var dataAll = "";
		var elms = document.getElementsByName("menu_menuLi");
		for (var i=0; i<elms.length; i++) {
			
			var data = "";
			var cId = $(elms[i]).attr("menuId");
			
			data += "[[sep]]" + cId;
			data += "[[sep]]" + $(elms[i]).attr("menuLevel");
			data += "[[sep]]" + ebUtil.getCheckedValue($("div#menu_form"+cId).find("input#menu_initMenuYn"+cId).get());
			data += "[[sep]]" + ebUtil.getCheckedValue($("div#menu_form"+cId).find("input#menu_menuHideYn"+cId).get());
			data += "[[sep]]" + ebUtil.getCheckedValue($("div#menu_form"+cId).find("input#menu_groupFoldYn"+cId).get());
			data += "[[sep]]" + $(elms[i]).attr("menuType");
			data += "[[sep]]" + $(elms[i]).attr("cnttType");
			data += "[[sep]]" + $("div#menu_form"+cId).find("input#menu_menuNm").val();
			data += "[[sep]]" + $("div#menu_form"+cId).find("input#menu_menuDesc").val();
			data += "[[sep]]" + $("div#menu_form"+cId).find("input#menu_cnttUrl").val();
			data += "[[sep]]" + ebUtil.getCheckedValue($("div#menu_form"+cId).find("input#menu_anonYn"+cId).get());
			data += "[[sep]]" + ebUtil.getSelectedValue($("div#menu_form"+cId).find("select#menu_readGrade")[0]);
			data += "[[sep]]" + ebUtil.getSelectedValue($("div#menu_form"+cId).find("select#menu_wrtGrade")[0]);
			data += "[[sep]]" + ebUtil.getSelectedValue($("div#menu_form"+cId).find("select#menu_replyGrade")[0]);
			data += "[[sep]]" + ebUtil.getSelectedValue($("div#menu_form"+cId).find("select#menu_memoGrade")[0]);
			// alert(data);
			dataAll += "[[SEP]]" + data.substring(7); // 맨처음 분리자 제거 후 결합.
		}
		var param = "m=setCmntMenu";
		param += "&cmntId=" + document.transferForm.cmntId.value;
		param += "&menuDesc=" + encodeURIComponent(dataAll.substring(7)); // 맨처음 분리자 제거 후 전송.
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(data) { cfOp.menuMng.setCmntMenuHandler(data); }});
	},
	setCmntMenuHandler : function(data) {
		cfOp.getMsgBox().doShow (ebUtil.getMessage("mm.info.common.success"));
		cfOp.chgOpArea("menuMng");
	},
	cancel : function() {
		cfOp.chgOpArea("menuMng");
	},
	checkInitMenu : function (elm) {
		$("li[id='menu_menuLi']").each( function(i) {
			if (elm.value != "Y") return;
			var valueInitMenuYn = ebUtil.getCheckedValue(document.getElementsByName("menu_initMenuYn"+this.getAttribute("menuId")));
			if (valueInitMenuYn == "Y" && elm.id != "menu_initMenuYn"+this.getAttribute("menuId")) {
				ebUtil.setCheckedValue(document.getElementsByName(elm.getAttribute("name")), "N");
				alert("이미 카페홈 게시판으로 설정된 메뉴가 존재합니다.");
				return;
			}
		});
	},
	getTrash : function () {
		if (this.m_trash == null) {
			this.m_trash = new cafe.op.menuMng.trash(this);
		}
		return this.m_trash;
	}
}
cafe.op.menuMng.trash = function (parent) {
	this.m_parent      = parent;
	this.m_pageNavi    = parent.m_pageNavi;
	this.m_ajax        = parent.m_ajax;
	this.m_contextPath = parent.m_contextPath;
}
cafe.op.menuMng.trash.prototype = {
	m_parent      : null,
	m_ajax        : null,
	m_pageNavi    : null,
	m_contextPath : null,
	
	doGet : function() {
		var param = "m=menuMngTrash";
		param += "&cmntId=" + document.transferForm.cmntId.value;
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(htmlData) { cfOp.menuMng.getTrash().doGetHandler(htmlData); }});
	},
	doGetHandler : function(htmlData) {
		document.getElementById("opArea").innerHTML = htmlData;
	},
	doRecover : function () {
		var param = "m=setCmntMenuTrash";
		param += "&cmd=recover";
		param += "&cmntId=" + document.transferForm.cmntId.value;
		param += "&menuDesc=" + ebUtil.getCheckedValues(document.getElementsByName("trash_checkRow"));
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(data) { cfOp.menuMng.getTrash().doRecoverHandler(data); }});
	},
	doRecoverHandler : function (data) {
		cfOp.getMsgBox().doShow (ebUtil.getMessage("mm.info.common.success"));
		cfOp.menuMng.getTrash().doGet();
	}
}
cafe.op.bltnMng = function (parent) {
	this.m_parent = parent;
	this.m_pageNavi = parent.m_pageNavi;
	this.m_ajax = parent.m_ajax;
	this.m_checkBox = parent.m_checkBox;
	this.m_contextPath = parent.m_contextPath;
}
cafe.op.bltnMng.prototype = {
	m_parent : null,
	m_ajax : null,
	m_pageNavi : null,
	m_checkBox : null,
	m_contextPath : null,
	m_curTabId : null,
	m_stateCodeGetter : null,
	m_curEvent : null,
	m_timeoutId : null,
	m_selectRowIndex : -1,

	selectTab : function (tabId, reset) {
		if( reset != "true") if (this.m_curTabId == tabId) return;
		this.m_curTabId = tabId;
		var param = "m=bltnMng";
		param += "&cmntId=" + document.transferForm.cmntId.value;
		switch (tabId) {
			case 0: param += "&cmd=all"; this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(htmlData) { cfOp.bltnMng.selectTabHandler(htmlData); }}); break;
			case 1: param += "&cmd=ntc"; this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(htmlData) { cfOp.bltnMng.selectTabHandler(htmlData); }}); break;
			// case 2: param += "&cmd=bad"; this.m_ajax.send("POST",
			// this.m_contextPath+"/cafe/op.cafe", param, true, {success:
			// function(htmlData) { cfOp.bltnMng.selectTabHandler(htmlData);
			// }}); break;
		}
	},
	selectTabHandler : function (htmlData) {
		switch (this.m_curTabId) {
			case 0: 
				document.getElementById("bltnMngAllTab").innerHTML = htmlData;
				cfOp.bltnMng.genPageNavi("all_srchForm");
				break;
			case 1: 
				document.getElementById("bltnMngNtcTab").innerHTML = htmlData; 
				cfOp.bltnMng.genPageNavi("ntc_srchForm");
				if (document.getElementById("ntc0_checkRow")) {
					cfOp.bltnMng.selectNotice(document.getElementById("ntc0_checkRow").parentNode);
				}
				break;
			// case 2:
			// document.getElementById("bltnMngBadTab").innerHTML = htmlData;
			// cfOp.bltnMng.genPageNavi("bad_srchForm");
			// break;
		}
		var tab = "#bltn_tab"+this.m_curTabId;
		$(".cafeadm_tabmenu ul li").removeClass("on");
		$(tab).addClass("on");
		$(".tabcontent").hide();
		var activeTab = $(tab).children("a").attr("onclick");
		$("#" + activeTab).show();
		if( parent.autoresize_iframe_portlets) {
			setTimeout( parent.autoresize_iframe_portlets(), 200);
		}
		
	},
	genPageNavi : function (formNm) {
		var frm = document.forms[formNm];
		var pageNo = document.forms[formNm].pageNo.value;
		var pageSize = frm.pageSize.value;
		var totalSize = frm.totalSize.value;
		var pageFunction = frm.pageFunction.value;
		var naviDivNm = frm.naviDivNm.value;

		document.getElementById(naviDivNm).innerHTML = this.m_pageNavi.getPageIteratorHtmlStringCafe (pageNo, pageSize, totalSize, frm.name, pageFunction, this.m_contextPath);
	},
	doPage : function (formNm, pageNo) {
		var frm = document.forms[formNm];
	    frm.pageNo.value = pageNo;
		cfOp.bltnMng.search(formNm);
	},
	search : function (formNm) {
		var frm = document.forms[formNm];
		var param = "m=bltnMng";
		param += "&cmntId=" + document.transferForm.cmntId.value;
		param = ebUtil.completeParam (frm, param);
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(htmlData) { cfOp.bltnMng.selectTabHandler(htmlData); }});
	},
	sort : function (formNm, colNm) {
		var frm = document.forms[formNm];
		if (frm.sortMethod.value == "ASC") frm.sortMethod.value = "DESC";
		else                               frm.sortMethod.value = "ASC";
		frm.sortColumn.value = colNm;
		cfOp.bltnMng.search(formNm);
	},
	moveBulletin : function (cmd) {
		var selectedItems = '';
		var checkedBltns = document.getElementsByName("all_checkRow");
		for (var i=0; i<checkedBltns.length; i++) {
			if(checkedBltns[i].checked == true)
				selectedItems += ";" + checkedBltns[i].value;
		}
		if (selectedItems.length == 0) {
			alert(ebUtil.getMessage('eb.info.bltn.notSelected')); // '선택된 게시물이
																	// 없습니다'
			return;
		}

		var srcCnttType = ebUtil.getSelectedAttr (document.getElementById("srchBoard"), "cnttType");
		var dstCnttType = ebUtil.getSelectedAttr (document.getElementById("all_changeBrd"), "cnttType");
		var srchBoard   = ebUtil.getSelectedValue (document.getElementById("srchBoard"));
		var changeBrd   = ebUtil.getSelectedValue (document.getElementById("all_changeBrd"));
		if ("MOVE" == cmd) {
			if (srchBoard == changeBrd) {
				// alert(ebUtil.getMessage("pt.eb.info.same.board"));
				alert("동일 게시판입니다.");
				return;
			}
			if (srcCnttType == "12") {
				 alert(ebUtil.getMessage("cf.error.cant.move2qna")); return;
				 // 'Q/A형 게시판의 글은 다른 유형의 게시판으로 이동할 수 없습니다.'
			}
			if (dstCnttType == "14") {
				 alert(ebUtil.getMessage("cf.error.cant.move2one")); return;
				 // "선택한 유형의 게시판의 글은 한줄메모장 유형의 게시판으로 이동할 수 없습니다."
			}
			if (!confirm (ebUtil.getMessage('eb.info.confirm.move'))) return; // '정말
																				// 이동하시겠습니까?'
		} else if ("DELETE" == cmd) {
			if (!confirm (ebUtil.getMessage('eb.info.confirm.del'))) return; // '정말
																				// 삭제하시겠습니까?'
		} else if ("SPAM" == cmd) {
			if (!confirm (ebUtil.getMessage('eb.info.confirm.spam'))) return; // '정말
																				// 스팸
																				// 처리하시겠습니까?'
		}

		var param = "m=moveBulletin"
		param += "&cmd="           + cmd;
		param += "&cmntId="        + document.transferForm.cmntId.value;
		param += "&srchBoard="     + srchBoard;
		param += "&changeBrd="     + changeBrd;
		param += "&selectedItems=" + selectedItems.substring(1); // 첫번째 ';' 제거.
		
		$(document).ajaxStart(function(){
			if($("#loading").length==0) {
				$("<div id='loading' class='loading'/>").appendTo('body');
			}
			$("#loading").show();
		});

		$(document).ajaxComplete(function(){
			$("#loading").hide();
		});
		
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, { 
			success: function(data) { cfOp.bltnMng.moveBulletinHandler(data); }
		});
	},
	moveBulletinHandler : function (data) {
		cfOp.getMsgBox().doShow (ebUtil.getMessage("mm.info.move.success"));
		cfOp.bltnMng.search ("all_srchForm");
	},
	readBltn : function (boardId, bltnNo) {
		var frm = document.all_listForm;
		frm.boardId.value = boardId;
		frm.bltnNo.value  = bltnNo;
		frm.action = this.m_contextPath+"/cafe/"+document.transferForm.cmntUrl.value;
		frm.target = "_blank";
		frm.submit();
	},
	showBltnCntt : function (showFlag, boardId, bltnNo, evt) {
		if (showFlag) {
			this.m_curEvent = evt = (evt) ? evt : ((window.event) ? window.event : null);
			// 본 함수가 onmouseover 에서 호출되므로 마우스가 스쳐지나가는 경우같이 굳이 보여줄 필요가 없는 경우에는
			// 서버에 부하를 주지 않도록, onmouseout 에서 해제되도록 지연을 시킴.2012.02.21.KWShin.
			this.m_timeoutId = setTimeout ("cfOp.bltnMng.showBltnCnttReal('"+boardId+"','"+bltnNo+"')", 600);
		} else {
			clearTimeout (this.m_timeoutId);
			ebUtil.getPopupDialog().remove();
		}
	},
	showBltnCnttReal : function (boardId, bltnNo) {
		var param = "m=getBltnCntt";
		param += "&cmntId="+document.transferForm.cmntId.value;
		param += "&boardId="+boardId;
		param += "&bltnNo="+bltnNo;
		ebUtil.getPopupDialog().init (500);
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, { success: function(htmlData) { ebUtil.getPopupDialog().show (cfOp.bltnMng.m_curEvent,htmlData); }});
	},
	selectNotice : function (elm) {
		this.m_selectRowIndex = elm.parentNode.getAttribute("ch");
		this.m_checkBox.unChkAll (document.getElementById("ntc_listForm"));
		document.getElementById ('ntc'+this.m_selectRowIndex+'_checkRow').checked = true;
		
		var param = "m=bltnMng";
		param += "&cmd=ntc";
		param += "&view=edit";
		param += "&cmntId=" + document.transferForm.cmntId.value;
		param += "&noticeId=" + document.getElementById ('ntc'+this.m_selectRowIndex+'_checkRow').value;
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(htmlData) { cfOp.bltnMng.selectNoticeHandler(htmlData); }});
	},
	selectNoticeHandler : function (htmlData) {
		document.getElementById("noticeDatail_cmd").value = "upd";
		document.getElementById("noticeDetailArea").innerHTML = htmlData;
		
		if (document.getElementById('ntc_content')) {
			// FCKeditor 관련 초기화
			enLangKnd = eval("document.transferForm.langKnd.value"); 
			/*
			 * var ebFCKeditor = new FCKeditor('close_content');
			 * ebFCKeditor.BasePath = ebUtil.getContextPath() +
			 * '/board/fckeditor/';
			 * ebFCKeditor.Config["CustomConfigurationsPath"] =
			 * ebUtil.getContextPath()+'/cola/cafe/javascript/fckconfig_close_cafe.js';
			 * ebFCKeditor.Height = 300; ebFCKeditor.ReplaceTextarea();
			 */
			var dextEditor = null;
			
			// DEXT5.config.InitServerXml = ebUtil.getContextPath() +
			// "/dext/config/enboard_editor.xml";
			DEXT5.config.InitXml = "enboard_editor.xml";
			DEXT5.config.Width = "100%";
			DEXT5.config.Height = "400px";
			DEXT5.config.HandlerUrl = ebUtil.getContextPath() + "/dext5editor/handler/enboard_handler.jsp";
			DEXT5.config.DevelopLangage = "JAVA";
			DEXT5.config.RunTimes = "html5";
			DEXT5.config.FrameFullScreen = '1';
			
			DEXT5.config.EditorHolder = "editorCntt";
			
			dextEditor = new Dext5editor("editorCntt");;
		}
	},
	processNotice : function (flag) {
		
		var cmdElm = document.getElementById("noticeDatail_cmd");
		
		if (flag == "add") {

			cmdElm.value = "add";
		
			var param = "m=bltnMng";
			param += "&cmd=ntc";
			param += "&view=edit";
			param += "&cmntId=" + document.transferForm.cmntId.value;
			this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(htmlData) { cfOp.bltnMng.processNoticeHandler(htmlData); }});
		
		} else if (flag == "save") {
			
			if (cmdElm.value == "add") cmdElm.value = "ins";
			
			if (!ebUtil.chkValue (document.getElementById("ntc_title"), "제목을", "true")) return;
			if (!ebUtil.chkValue (document.getElementById("ntc_startDate"), "공지시작일자를", "true")) return;
			if (!ebUtil.chkValue (document.getElementById("ntc_endDate"), "공지종료일자를", "true")) return;
			try {
				document.getElementById("set_ntc_content").value = DEXT5.getBodyValue('editorCntt');
			} catch (ex) {
				// FCKeditor 를 사용하지 않는 경우에는...
				document.getElementById("set_ntc_content").value = document.getElementById("ntc_content").value;
			}
			if (!ebUtil.chkValue (document.getElementById("set_ntc_content"), "공지내용을", "false")) return;
			if (!confirm ("공지내역을 저장하시겠습니까?")) return;
			
			var param = "m=setCafeNotice";
			param += "&cmd="       + cmdElm.value;
			param += "&cmntId="    + document.transferForm.cmntId.value;
			if (cmdElm.value == "upd") param += "&noticeId=" + document.getElementById ('ntc'+this.m_selectRowIndex+'_checkRow').value;
			param += "&startDate=" + document.getElementById("ntc_startDate").value;
			param += "&endDate="   + document.getElementById("ntc_endDate").value;
			param += "&title="     + document.getElementById("ntc_title").value;
			param += "&content="   + document.getElementById("set_ntc_content").value;
			this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(htmlData) { cfOp.bltnMng.processNoticeHandler(htmlData); }});

		} else if (flag == "del") {

			if (!confirm ("공지내역을 삭제하시겠습니까?")) return;

			var param = "m=setCafeNotice";
			param += "&cmd=" + "del";
			param += "&cmntId=" + document.transferForm.cmntId.value;
			param += "&noticeId=" + document.getElementById ('ntc'+this.m_selectRowIndex+'_checkRow').value;
			this.m_ajax.send("POST", this.m_contextPath+"/cafe/op.cafe", param, true, {success: function(htmlData) { cfOp.bltnMng.processNoticeHandler(htmlData); }});
		}
	},
	processNoticeHandler : function (data) {
		var cmd = document.getElementById("noticeDatail_cmd").value;
		if (cmd == "add") {
			document.getElementById("noticeDetailArea").innerHTML = data;
			
			if (document.getElementById('ntc_content')) {
				// FCKeditor 관련 초기화
				enLangKnd = eval("document.transferForm.langKnd.value"); 
				/*
				 * var ebFCKeditor = new FCKeditor('close_content');
				 * ebFCKeditor.BasePath = ebUtil.getContextPath() +
				 * '/board/fckeditor/';
				 * ebFCKeditor.Config["CustomConfigurationsPath"] =
				 * ebUtil.getContextPath()+'/cola/cafe/javascript/fckconfig_close_cafe.js';
				 * ebFCKeditor.Height = 300; ebFCKeditor.ReplaceTextarea();
				 */
				var dextEditor = null;
				
				// DEXT5.config.InitServerXml = ebUtil.getContextPath() +
				// "/dext/config/enboard_editor.xml";
				DEXT5.config.InitXml = "enboard_editor.xml";
				DEXT5.config.Width = "100%";
				DEXT5.config.Height = "400px";
				DEXT5.config.HandlerUrl = ebUtil.getContextPath() + "/dext5editor/handler/enboard_handler.jsp";
				DEXT5.config.DevelopLangage = "JAVA";
				DEXT5.config.RunTimes = "html5";
				DEXT5.config.FrameFullScreen = '1';
				
				DEXT5.config.EditorHolder = "editorCntt";
				
				dextEditor = new Dext5editor("editorCntt");;
			}
			$(function() {
				 $( ".datepicker" ).datepicker({
					  	dateFormat: "yy.mm.dd"
				  });
			});
			
		} else {
			if (cmd == "ins") {
				cfOp.getMsgBox().doShow (ebUtil.getMessage("ev.info.success.add"));
			} else if (cmd == "upd") {
				cfOp.getMsgBox().doShow (ebUtil.getMessage("ev.info.success.update"));
			} else if (cmd == "del") {
				cfOp.getMsgBox().doShow (ebUtil.getMessage("ev.info.success.delete"));
			}
			cfOp.bltnMng.selectTab (1, "true");
		}
	}
}
var cfOp = new cafe.op();
var ebLangKnd = "ko";
// -->

