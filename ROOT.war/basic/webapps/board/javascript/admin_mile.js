AdmMileCdMngr = function() {
	//var offset = location.href.indexOf (location.host) + location.host.length;
	//this.m_contextPath = location.href.substring (offset, location.href.indexOf('/', offset + 1));
	this.m_contextPath = portalPage.getContextPath();
	this.m_ajax = new enview.util.Ajax();
	this.m_ajax.setContextPath (this.m_contextPath);
	this.m_pageNavi = new enview.util.PageNavigationUtil();
	this.m_checkBox = new enview.util.CheckBoxUtil();
}
AdmMileCdMngr.prototype = {
	m_contextPath : null,
	m_ajax        : null,
	m_pageNavi    : null,
	m_checkBox    : null,
	m_msgBox      : null,

	m_view   : null,
	m_act    : null,
	m_mileCd : null,
	
	m_groupChooser : null,
	m_roleChooser  : null,
	m_gradeChooser : null,
	
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 설명 : 마일리지 코드 관리 목록화면에서 요청이 발생했을 때.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	onMileCdList : function (view, act, mileCd) {

		this.m_view = view;
		this.m_act  = act;
		this.m_mileCd = mileCd;
		
		var frm = document.frmMCL;

		if (frm.srchMileCd.value == ebUtil.getMessage('eb.info.ttl.l.mileCd')) frm.srchMileCd.value = "";
		if (frm.srchMileNm.value == ebUtil.getMessage('eb.info.ttl.l.mileNm')) frm.srchMileNm.value = "";

		var param = "m=uiMileCdMng";
		param += "&view="+view + "&act="+act + "&cmd=ENBOARD.ADMIN" + "&mileCd="+mileCd;
		param = ebUtil.completeParam(frm, param)
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adMile.brd", param, true, {success: function(htmlData) { admMileCdMngr.onMileCdListHandler(htmlData); }});
	},
	onMileCdListHandler : function (htmlData) {
		if (this.m_view == "list") {
			document.getElementById("mngArea").innerHTML = htmlData;
		} else {
			document.getElementById("mileCdArea").innerHTML = htmlData;
			var param = "m=uiMileCdMng";
			param += "&view=sttgList&act=list&mileCd="+this.m_mileCd;
			this.m_ajax.send ("POST", this.m_contextPath+"/board/adMile.brd", param, true, {success: function(htmlData) { admMileCdMngr.onMileCdListHandler2(htmlData); }});
		}
		setTimeout("admMileCdMngr.mcdSrchFieldDelay()", 1);
	},
	mcdSrchFieldDelay : function () {
		// mngArea 에 innerHTML을 할당한 뒤 바로 srchMileCd 필드를 참조하면 에러가 난다.(IE에서만)
		// 그래서 Delay를 넣었다. 2009.03.30.KWShin.
		var frm = document.frmMCL;
		if (frm.srchMileCd.value == "") frm.srchMileCd.value = ebUtil.getMessage('eb.info.ttl.l.mileCd');
		if (frm.srchMileNm.value == "") frm.srchMileNm.value = ebUtil.getMessage('eb.info.ttl.l.mileNm');

		var pageNo    = frm.pageNo.value;
		var pageSize  = frm.pageSize.value;
		var totalSize = frm.totalSize.value;
		document.getElementById("mileCdPageIterator").innerHTML = this.m_pageNavi.getPageIteratorHtmlString (pageNo, pageSize, totalSize, "frmMCL", "admMileCdMngr.doMileCdPage");		
	},
	onMileCdListHandler2 : function (htmlData) {
		document.getElementById("sttgListArea").innerHTML = htmlData;	
	},
	doMileCdPage : function (formName, pageNo) {
		var frm = document.forms[formName];
	    frm.pageNo.value = pageNo;
		admMileCdMngr.onMileCdList("list","list");
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 설명 : 마일리지 코드 상세화면에서 동작이 발생했을 때.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	onMileCdForm : function (flag) {

		var frm = document.frmMCE;
		
		if (flag == "list") { // 목록화면으로

			admMileCdMngr.onMileCdList ("list","list");
			return;
			
		} else if (flag == "save") { // 수정/추가

			if (!ebUtil.chkValue (frm.mileCd, ebUtil.getMessage('eb.info.ttl.o.mileCd'), 'true')) return;
			if (!ebUtil.chkSelect(frm.domainId, 0, ebUtil.getMessage('eb.info.ttl.o.domainId'), 'true')) return;
			if (!ebUtil.chkValue (frm.mileNm, ebUtil.getMessage('eb.info.ttl.o.mileNm'), 'true')) return;
			if (!ebUtil.chkCheck (frm.mileActive, ebUtil.getMessage('eb.info.ttl.o.mileActive'), true)) return;
			if (!ebUtil.chkCheck (frm.mileIo, ebUtil.getMessage('eb.info.ttl.o.mileIo'), true)) return;
			if (!ebUtil.chkSelect (frm.mileSys, 1, ebUtil.getMessage('eb.info.ttl.o.mileSys'), true)) return;
			if (!ebUtil.chkValue (frm.milePnt, ebUtil.getMessage('eb.info.ttl.o.milePnt'), true)) return;
			if (!ebUtil.chkNum (frm.milePnt, ebUtil.getMessage('eb.info.ttl.p.milePnt'), true)) return;
			if (!ebUtil.chkCheck (frm.mileSttg, ebUtil.getMessage('eb.info.ttl.o.mileSttg'), true)) return;
			
			// Some value should be assigned to numeric fields, otherwise it causes spring's form binding error! 
			if (frm.tlimitCnt.value.length == 0) frm.tlimitCnt.value = 0; 
			if (frm.dlimitCnt.value.length == 0) frm.dlimitCnt.value = 0; 
			if (frm.wlimitCnt.value.length == 0) frm.wlimitCnt.value = 0; 
			if (frm.mlimitCnt.value.length == 0) frm.mlimitCnt.value = 0; 
			if (frm.ylimitCnt.value.length == 0) frm.ylimitCnt.value = 0; 

			if (ebUtil.getCheckedValue(frm.mileSttg) == 'Y') {
				if (!ebUtil.chkNum (frm.tlimitCnt, ebUtil.getMessage('eb.info.ttl.p.tlimit'), true)) return;
				if (!ebUtil.chkNum (frm.dlimitCnt, ebUtil.getMessage('eb.info.ttl.p.dlimit'), true)) return;
				if (!ebUtil.chkNum (frm.wlimitCnt, ebUtil.getMessage('eb.info.ttl.p.wlimit'), true)) return;
				if (!ebUtil.chkNum (frm.mlimitCnt, ebUtil.getMessage('eb.info.ttl.p.mlimit'), true)) return;
				if (!ebUtil.chkNum (frm.ylimitCnt, ebUtil.getMessage('eb.info.ttl.p.ylimit'), true)) return;
				if (frm.tlimitCnt.value <= 0 && frm.dlimitCnt.value <= 0 && frm.wlimitCnt.value <= 0
				 && frm.mlimitCnt.value <= 0 && frm.ylimitCnt.value <= 0) {
					alert(ebUtil.getMessage('mm.info.mileSttg'));
					frm.tlimitCnt.focus();
					return;
				}
			}

			frm.view.value = "list";
			if (frm.act.value == "sel") frm.act.value = "upd"; // 조회해서 들어왔으면 수정하러 가는거다..

		} else if (flag == "del") { // 삭제
			if (!confirm (ebUtil.getMessage('eb.info.confirm.del'))) return;

			frm.view.value = "list";
			frm.act.value = "del"; 
		}
		var param = "m=setMileCd"
		param = ebUtil.completeParam (frm, param);
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adMile.brd", param, true, {success: function(data) { admMileCdMngr.onMileCdFormHandler(data); }});
	},
	onMileCdFormHandler : function (data) {
		admMileCdMngr.getMsgBox().doShow (ebUtil.getMessage("mm.info.success"));
		var frm = document.frmMCE;
		admMileCdMngr.onMileCdList (frm.view.value,frm.act.value);
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 설명 : 마일리지 정책 관리 목록화면에서 요청이 발생했을 때.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	onMileSttgList : function (view, act, mileCd, prinId) {

		this.m_view   = view;
		this.m_act    = act;
		this.m_mileCd = mileCd;
		
		var frm = document.frmMSL;

		var param = "m=uiMileCdMng";
		param += "&view="+view + "&act="+act + "&mileCd="+mileCd + "&prinId="+prinId;
		param = ebUtil.completeParam (frm, param);
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adMile.brd", param, true, {success: function(htmlData) { admMileCdMngr.onMileSttgListHandler(htmlData); }});
	},
	onMileSttgListHandler : function (htmlData) {
		if (this.m_view == "sttgList") {
			document.getElementById("sttgListArea").innerHTML = htmlData;
		} else {
			document.getElementById("sttgArea").innerHTML = htmlData;
		}
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 설명 : 마일리지 정책 상세화면에서 동작이 발생했을 때.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	onMileSttgForm : function (flag) {

		var frm = document.frmMSE;
		
		if (flag == "list") { // 목록화면으로

			admMileCdMngr.onMileSttgList ("sttgList", "list", frm.mileCd.value, frm.prinId.value);
			return;

		} else if (flag == "save") { // 수정/추가

			if (!ebUtil.chkCheck (frm.prinType, ebUtil.getMessage('eb.info.ttl.o.prinType'), true)) return;
			if (!ebUtil.chkValue (frm.prinId, ebUtil.getMessage('eb.info.ttl.o.prinId'), true)) return;
			if (!ebUtil.chkValue (frm.milePnt, ebUtil.getMessage('eb.info.ttl.o.milePnt'), true)) return;
			if (!ebUtil.chkNum (frm.milePnt,ebUtil.getMessage('eb.info.ttl.p.milePnt'), true)) return;
			if (!ebUtil.chkCheck (frm.mileSttg, ebUtil.getMessage('eb.info.ttl.o.mileSttg'), true)) return;

			// Some value should be assigned to numeric fields, otherwise it causes spring's form binding error! 
			if (frm.tlimitCnt.value.length == 0) frm.tlimitCnt.value = 0; 
			if (frm.dlimitCnt.value.length == 0) frm.dlimitCnt.value = 0; 
			if (frm.wlimitCnt.value.length == 0) frm.wlimitCnt.value = 0; 
			if (frm.mlimitCnt.value.length == 0) frm.mlimitCnt.value = 0; 
			if (frm.ylimitCnt.value.length == 0) frm.ylimitCnt.value = 0; 

			if (ebUtil.getCheckedValue (frm.mileSttg) == 'Y') {
				if (!ebUtil.chkNum (frm.tlimitCnt, ebUtil.getMessage('eb.info.ttl.p.tlimit'), true)) return;
				if (!ebUtil.chkNum (frm.dlimitCnt, ebUtil.getMessage('eb.info.ttl.p.dlimit'), true)) return;
				if (!ebUtil.chkNum (frm.wlimitCnt, ebUtil.getMessage('eb.info.ttl.p.wlimit'), true)) return;
				if (!ebUtil.chkNum (frm.mlimitCnt, ebUtil.getMessage('eb.info.ttl.p.mlimit'), true)) return;
				if (!ebUtil.chkNum (frm.ylimitCnt, ebUtil.getMessage('eb.info.ttl.p.ylimit'), true)) return;
				if (frm.tlimitCnt.value <= 0 && frm.dlimitCnt.value <= 0 && frm.wlimitCnt.value <= 0
				 && frm.mlimitCnt.value <= 0 && frm.ylimitCnt.value <= 0) {
					alert(ebUtil.getMessage('mm.info.mileSttg'));
					frm.tlimitCnt.focus();
					return;
				}
			}

			frm.view.value = "sttgList";
			if (frm.act.value == "sel") frm.act.value = "upd"; // 조회해서 들어왔으면 수정하러 가는거다..

		} else if (flag == "del") { // 삭제
			if(!confirm(ebUtil.getMessage('eb.info.confirm.del'))) return;

			frm.view.value = "sttgList";
			frm.act.value = "del"; 
		}

		var param = "m=setMileSttg"
		param = ebUtil.completeParam (frm, param);
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adMile.brd", param, true, {success: function(data) { admMileCdMngr.onMileSttgFormHandler(data); }});
	},
	onMileSttgFormHandler : function (data) {
		admMileCdMngr.getMsgBox().doShow (ebUtil.getMessage("mm.info.success"));
		var frm = document.frmMSE;
		admMileCdMngr.onMileSttgList (frm.view.value, frm.act.value, frm.mileCd.value, frm.prinId.value);
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 설명 : 정책 입력 시 그룹/롤/등급 구분을 선택했을 때.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	changePrinType : function () {
		var checkedPrinType = ebUtil.getCheckedValue(document.frmMSE.prinType);
		if (checkedPrinType == "G")  admMileCdMngr.getGroupChooser().doShow(admMileCdMngr);
		if (checkedPrinType == "R" ) admMileCdMngr.getRoleChooser().doShow (admMileCdMngr);
		if (checkedPrinType == "g" ) admMileCdMngr.getGradeChooser().doShow(admMileCdMngr, document.frmMSE.mileCd.value);
	},
	doSelectGRG : function (act, grgId) {
		document.frmMSE.prinId.value     = grgId;
		document.frmMSE.showPrinId.value = grgId;
	},
	cancelSelectGRG : function () {
		document.frmMSE.prinId.value     = "";
		document.frmMSE.showPrinId.value = "";
	},
	getRoleChooser : function() {
		if (this.m_roleChooser) return this.m_roleChooser;
		this.m_roleChooser = new RoleChooser(this);
		return this.m_roleChooser;
	},
	getGroupChooser : function() {
		if (this.m_groupChooser) return this.m_groupChooser;
		this.m_groupChooser = new GroupChooser(this);
		return this.m_groupChooser;
	},
	getGradeChooser : function() {
		if (this.m_gradeChooser) return this.m_gradeChooser;
		this.m_gradeChooser = new GradeChooser(this);
		return this.m_gradeChooser;
	},
	getMsgBox : function() {
		if (this.m_msgBox == null) {
			if ( enviewMessageBox == null ) {
				enviewMessageBox = new enview.portal.MessageBox(300, 100, 1000);
			}
			this.m_msgBox = enviewMessageBox;
		}
		return this.m_msgBox
	}
}
RoleChooser = function (parent) {
	this.m_elmArea = document.getElementById("abmRoleChooser");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_pageNavi = parent.m_pageNavi;
	this.m_checkBox = parent.m_checkBox;
	
	$("#abmRoleChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:600, 
		modal: true,
		buttons: {
			Cancel: function() {
				admMileCdMngr.getRoleChooser().m_pageNo = 1;
				admMileCdMngr.getRoleChooser().m_caller.cancelSelectGRG();
				$(this).dialog('close');
			},
			Apply: function() {
				if (!ebUtil.chkCheck (document.getElementsByName("roleChooser_checkRow"), '역할을', true)) return;
				admMileCdMngr.getRoleChooser().m_pageNo = 1;
				admMileCdMngr.getRoleChooser().m_caller.doSelectGRG('role',ebUtil.getCheckedValue (document.getElementsByName("roleChooser_checkRow")));
				$(this).dialog('close');
			}
		}
	});
}
RoleChooser.prototype = {
	m_elmArea : null,
	m_checkedRow : null,
	m_contextPath : null,
	m_ajax : null,
	m_pageNavi : null,
	m_checkBox : null,
	m_caller : null,

	m_pageNo : 1,
	m_pageSize : 5,
	m_totalSize : null,
	
	doGet : function() {
		var param = "m=uiMileGRGList";
		param += "&view="       + "chooseList";
		param += "&act="        + "role";
		param += "&pageNo="     + this.m_pageNo;
		param += "&pageSize="   + this.m_pageSize;
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adMile.brd", param, true, {success: function(htmlData) { admMileCdMngr.getRoleChooser().doGetHandler (htmlData); }});		
	},
	doShow : function (caller) {
		this.m_caller = caller;
		admMileCdMngr.getRoleChooser().doGet();
		$('#abmRoleChooser').dialog('open');
	},
	doGetHandler : function (htmlData) {
		this.m_checkedRow = null; // 초기화
		this.m_elmArea.innerHTML = htmlData;
		this.m_totalSize = document.abmRoleChooserForm.totalSize.value;
		document.getElementById("abmRoleChooserPageIterator").innerHTML 
		= this.m_pageNavi.getPageIteratorHtmlString (this.m_pageNo, this.m_pageSize, this.m_totalSize, "abmRoleChooserForm", "admMileCdMngr.getRoleChooser().doPage");
		
		var frm = document.abmRoleChooserForm;
		if (frm.srchShortPath.value     == "") frm.srchShortPath.value     = ebUtil.getMessage('eb.info.ttl.l.roleId');
		if (frm.srchPrincipalName.value == "") frm.srchPrincipalName.value = ebUtil.getMessage('eb.info.ttl.l.roleNm');
	},
	doPage : function (formName, pageNo) {
		this.m_pageNo = pageNo;
		admMileCdMngr.getRoleChooser().doGet();
	},
	doSelect : function (idx) {
		this.m_checkBox.unChkAll(document.abmRoleChooserForm);   
		var checkedRow = document.getElementById ("roleChooser_checkRow_"+idx).checked = true;
	},
	doSearch : function() {
		var frm = document.abmRoleChooserForm;
		if (frm.srchShortPath.value     == ebUtil.getMessage('eb.info.ttl.l.roleId')) frm.srchShortPath.value     = "";
		if (frm.srchPrincipalName.value == ebUtil.getMessage('eb.info.ttl.l.roleNm')) frm.srchPrincipalName.value = "";
		var param = "m=uiMileGRGList";
		param += "&view="       + "chooseList";
		param += "&act="        + "role";
		param += "&pageNo="     + 1;
		param += "&pageSize="   + this.m_pageSize;
		param += "&srchShortPath=" + frm.srchShortPath.value;
		param += "&srchPrincipalName=" + frm.srchPrincipalName.value;
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adMile.brd", param, true, {success: function(htmlData) { admMileCdMngr.getRoleChooser().doGetHandler (htmlData); }});		
	}
}
GroupChooser = function (parent) {
	this.m_elmArea = document.getElementById("abmGroupChooser");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_pageNavi = parent.m_pageNavi;
	this.m_checkBox = parent.m_checkBox;
	
	$("#abmGroupChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:600, 
		modal: true,
		buttons: {
			Cancel: function() {
				admMileCdMngr.getGroupChooser().m_pageNo = 1;
				admMileCdMngr.getGroupChooser().m_caller.cancelSelectGRG();
				$(this).dialog('close');
			},
			Apply: function() {
				if( !ebUtil.chkCheck( document.getElementsByName("groupChooser_checkRow"), '그룹을', true )) return;
				admMileCdMngr.getGroupChooser().m_pageNo = 1;
				admMileCdMngr.getGroupChooser().m_caller.doSelectGRG('group',ebUtil.getCheckedValue (document.getElementsByName("groupChooser_checkRow")));
				$(this).dialog('close');
			}
		}
	});
}
GroupChooser.prototype = {
	m_elmArea : null,
	m_checkedRow : null,
	m_ajax : null,
	m_pageNavi : null,
	m_contextPath : null,
	m_checkBox : null,
	m_caller : null,

	m_pageNo : 1,
	m_pageSize : 5,
	m_totalSize : null,
	
	doGet : function() {
		var param = "m=uiMileGRGList";
		param += "&view="       + "chooseList";
		param += "&act="        + "group";
		param += "&pageNo="     + this.m_pageNo;
		param += "&pageSize="   + this.m_pageSize;
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adMile.brd", param, true, {success: function(htmlData) { admMileCdMngr.getGroupChooser().doGetHandler(htmlData); }});		
	},
	doShow : function (caller) {
		this.m_caller = caller;
		admMileCdMngr.getGroupChooser().doGet();
		$('#abmGroupChooser').dialog('open');
	},
	doGetHandler : function (htmlData) {
		this.m_checkedRow = null; // 초기화
		this.m_elmArea.innerHTML = htmlData;
		this.m_totalSize = document.abmGroupChooserForm.totalSize.value;
		document.getElementById("abmGroupChooserPageIterator").innerHTML 
		= this.m_pageNavi.getPageIteratorHtmlString (this.m_pageNo, this.m_pageSize, this.m_totalSize, "abmGroupChooserForm", "admMileCdMngr.getGroupChooser().doPage");
		
		var frm = document.abmGroupChooserForm;
		if( frm.srchShortPath.value     == "") frm.srchShortPath.value     = ebUtil.getMessage('eb.info.ttl.l.groupId');
		if (frm.srchPrincipalName.value == "") frm.srchPrincipalName.value = ebUtil.getMessage('eb.info.ttl.l.groupNm');

	},
	doPage : function (formName, pageNo) {
		this.m_pageNo = pageNo;
		this.doSearch( pageNo);
	},
	doSelect : function (idx) {
		this.m_checkBox.unChkAll(document.abmGroupChooserForm);   
		var checkedRow = document.getElementById ("groupChooser_checkRow_"+idx).checked = true;
	},
	doSearch : function( pageNo) {
		var frm = document.abmGroupChooserForm;
		if( pageNo==null) {
			pageNo=1;
		}
		if (frm.srchShortPath.value     == ebUtil.getMessage('eb.info.ttl.l.groupId')) frm.srchShortPath.value     = "";
		if (frm.srchPrincipalName.value == ebUtil.getMessage('eb.info.ttl.l.groupNm')) frm.srchPrincipalName.value = "";
		var param = "m=uiMileGRGList";
		param += "&view="       + "chooseList";
		param += "&act="        + "group";
		param += "&pageNo="     + pageNo;
		param += "&pageSize="   + this.m_pageSize;
		param += "&srchShortPath=" + frm.srchShortPath.value;
		param += "&srchPrincipalName=" + frm.srchPrincipalName.value;
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adMile.brd", param, true, {success: function(htmlData) { admMileCdMngr.getGroupChooser().doGetHandler (htmlData); }});		
	}
}
GradeChooser = function (parent) {
	this.m_elmArea = document.getElementById("abmGradeChooser");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_pageNavi = parent.m_pageNavi;
	this.m_checkBox = parent.m_checkBox;
	
	$("#abmGradeChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:600, 
		modal: true,
		buttons: {
			Cancel: function() {
				admMileCdMngr.getGradeChooser().m_pageNo = 1;
				admMileCdMngr.getGradeChooser().m_caller.cancelSelectGRG();
				$(this).dialog('close');
			},
			Apply: function() {
				if (!ebUtil.chkCheck (document.getElementsByName("gradeChooser_checkRow"), '등급을', true)) return;
				admMileCdMngr.getGradeChooser().m_pageNo = 1;
				admMileCdMngr.getGradeChooser().m_caller.doSelectGRG('grade',ebUtil.getCheckedValue (document.getElementsByName("gradeChooser_checkRow")));
				$(this).dialog('close');
			}
		}
	});
}
GradeChooser.prototype = {
	m_elmArea : null,
	m_checkedRow : null,
	m_ajax : null,
	m_pageNavi : null,
	m_contextPath : null,
	m_checkBox : null,
	m_caller : null,
	m_curMileCd : null,
	
	m_pageNo : 1,
	m_pageSize : 5,
	m_totalSize : null,
	
	doGet : function() {
		var param = "m=uiMileGRGList";
		param += "&view="       + "chooseList";
		param += "&act="        + "grade";
		param += "&mileCd="     + this.m_curMileCd;
		param += "&pageNo="     + this.m_pageNo;
		param += "&pageSize="   + this.m_pageSize;
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adMile.brd", param, true, {success: function(htmlData) { admMileCdMngr.getGradeChooser().doGetHandler(htmlData); }});		
	},
	doShow : function (caller, mileCd) {
		this.m_caller = caller;
		this.m_curMileCd = mileCd;
		admMileCdMngr.getGradeChooser().doGet();
		$('#abmGradeChooser').dialog('open');
	},
	doGetHandler : function (htmlData) {
		this.m_checkedRow = null; // 초기화
		this.m_elmArea.innerHTML = htmlData;
		this.m_totalSize = document.abmGradeChooserForm.totalSize.value;
		document.getElementById("abmGradeChooserPageIterator").innerHTML 
		= this.m_pageNavi.getPageIteratorHtmlString (this.m_pageNo, this.m_pageSize, this.m_totalSize, "abmGradeChooserForm", "admMileCdMngr.getGradeChooser().doPage");
		
		var frm = document.abmGradeChooserForm;
		if( frm.srchShortPath.value     == "") frm.srchShortPath.value     = ebUtil.getMessage('eb.info.ttl.l.gradeId');
		if (frm.srchPrincipalName.value == "") frm.srchPrincipalName.value = ebUtil.getMessage('eb.info.ttl.l.gradeNm');

	},
	doPage : function (formName, pageNo) {
		this.m_pageNo = pageNo;
		admMileCdMngr.getGradeChooser().doGet();
	},
	doSelect : function (idx) {
		this.m_checkBox.unChkAll(document.abmGradeChooserForm);   
		var checkedRow = document.getElementById ("gradeChooser_checkRow_"+idx).checked = true;
	},
	doSearch : function() {
		var frm = document.abmGradeChooserForm;
		if (frm.srchShortPath.value     == ebUtil.getMessage('eb.info.ttl.l.gradeId')) frm.srchShortPath.value     = "";
		if (frm.srchPrincipalName.value == ebUtil.getMessage('eb.info.ttl.l.gradeNm')) frm.srchPrincipalName.value = "";
		var param = "m=uiMileGRGList";
		param += "&view="       + "chooseList";
		param += "&act="        + "group";
		param += "&mileCd="     + this.m_curMileCd;
		param += "&pageNo="     + 1;
		param += "&pageSize="   + this.m_pageSize;
		param += "&srchShortPath=" + frm.srchShortPath.value;
		param += "&srchPrincipalName=" + frm.srchPrincipalName.value;
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adMile.brd", param, true, {success: function(htmlData) { admMileCdMngr.getGradeChooser().doGetHandler (htmlData); }});		
	}
}
AdmMileageMngr = function() {
	//var offset = location.href.indexOf (location.host) + location.host.length;
	//this.m_contextPath = location.href.substring (offset, location.href.indexOf('/', offset + 1));
	this.m_contextPath = portalPage.getContextPath();
	this.m_ajax = new enview.util.Ajax();
	this.m_ajax.setContextPath (this.m_contextPath);
	this.m_pageNavi = new enview.util.PageNavigationUtil();
	this.m_checkBox = new enview.util.CheckBoxUtil();
}
AdmMileageMngr.prototype = {
	m_contextPath : null,
	m_ajax        : null,
	m_pageNavi    : null,
	m_checkBox    : null,
	m_msgBox      : null,

	m_view   : null,
	m_act    : null,
	m_mileCd : null,
	
	m_groupChooser : null,
	m_roleChooser  : null,
	m_gradeChooser : null,
	
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 설명 : 마일리지 내역 관리 목록화면에서 요청이 발생했을 때.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	onMileageList : function (view, act, userId, mileCd, mileDatim) {

		this.m_view = view;
		this.m_act   = act;
		
		var frm = document.frmML;

		if (frm.srchUserId.value == ebUtil.getMessage('eb.info.ttl.l.userId')) frm.srchUserId.value = "";
		if (frm.srchMileCd.value == ebUtil.getMessage('eb.info.ttl.l.mileCd')) frm.srchMileCd.value = "";

		var param = "m=uiMileageMng";
		param += "&view="+view+"&act="+act;
		param += "&userId="+userId + "&mileCd="+mileCd + "&mileDatim="+mileDatim;
		param = ebUtil.completeParam (frm, param);
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adMile.brd", param, true, {success: function(htmlData) { admMileageMngr.onMileageListHandler(htmlData); }});
	},
	onMileageListHandler : function (htmlData) {
		if (this.m_view == "list") {
			document.getElementById("mngArea").innerHTML = htmlData;
		} else {
			document.getElementById("mileArea").innerHTML = htmlData;
		}
		setTimeout("admMileageMngr.mileSrchFieldDelay()", 100);
	},
	mileSrchFieldDelay : function () {
		var frm = document.frmML;
		if (frm.srchUserId.value == "") frm.srchUserId.value = ebUtil.getMessage('eb.info.ttl.l.userId');
		if (frm.srchMileCd.value == "") frm.srchMileCd.value = ebUtil.getMessage('eb.info.ttl.l.mileCd');

		var pageNo    = frm.pageNo.value;
		var pageSize  = frm.pageSize.value;
		var totalSize = frm.totalSize.value;
		document.getElementById("mileagePageIterator").innerHTML = this.m_pageNavi.getPageIteratorHtmlString (pageNo, pageSize, totalSize, "frmML", "admMileageMngr.doMileagePage");
				
	},
	doMileagePage : function (formName, pageNo) {
		var frm = document.forms[formName];
	    frm.pageNo.value = pageNo;
		admMileageMngr.onMileageList("list","list");
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	//설명 : 마일리지 내역 상세화면에서 동작이 발생했을 때.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	onMileageForm : function (flag) {

		var frm = document.frmME;
		
		if (flag == "list") { // 목록화면으로

			admMileageMngr.onMileageList ("list","list");
			return;
			
		} else if (flag == "save") { // 수정/추가
			if (!ebUtil.chkValue(frm.userId, ebUtil.getMessage('eb.info.ttl.o.userId'), 'true')) return;
			if (!ebUtil.chkValue(frm.mileDatim, ebUtil.getMessage('eb.info.ttl.o.mileDatim'), 'true')) return;
			if (!ebUtil.chkNum  (frm.mileDatim, ebUtil.getMessage('eb.info.ttl.p.mileDatim'), true)) return;
			if (!ebUtil.chkValue(frm.mileCd, ebUtil.getMessage('eb.info.ttl.o.mileCd'), 'true')) return;
			if (!ebUtil.chkSelect(frm.domainId, 0, ebUtil.getMessage('eb.info.ttl.o.domainId'), 'true')) return;
			if (!ebUtil.chkSelect(frm.mileSys, 1, ebUtil.getMessage('eb.info.ttl.o.mileSys'), true)) return;
			if (!ebUtil.chkCheck(frm.mileIo, ebUtil.getMessage('eb.info.ttl.o.mileIo'), true)) return;
			if (!ebUtil.chkValue(frm.milePnt, ebUtil.getMessage('eb.info.ttl.o.milePnt'), true)) return;
			if (!ebUtil.chkNum(frm.milePnt, ebUtil.getMessage('eb.info.ttl.p.milePnt'), true)) return;
			if (!ebUtil.chkValue(frm.mileSum, ebUtil.getMessage('eb.info.ttl.o.mileSum'), true)) return;
			if (!ebUtil.chkNum(frm.mileSum, ebUtil.getMessage('eb.info.ttl.p.mileSum'), true)) return;

			frm.view.value = "list";
			if (frm.act.value == "sel") frm.act.value = "upd"; // 조회해서 들어왔으면 수정하러 가는거다..

		} else if (flag == "del") { // 삭제
			if (!confirm (ebUtil.getMessage('eb.info.confirm.del'))) return;

			frm.view.value = "list";
			frm.act.value = "del"; 
		}

		var param = "m=setMileage";
		param = ebUtil.completeParam (frm, param);
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adMile.brd", param, true, {success: function(data) { admMileageMngr.onMileageFormHandler(data); }});
	},
	onMileageFormHandler : function () {
		admMileageMngr.getMsgBox().doShow (ebUtil.getMessage("mm.info.success"));
		var frm = document.frmME;
		admMileageMngr.onMileageList (frm.view.value, frm.act.value, frm.userId.value, frm.mileCd.value, frm.mileDatim.value);
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 설명 : 정책 입력 시 그룹/롤/등급 구분을 선택했을 때.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	changePrinType : function () {
		var checkedPrinType = ebUtil.getCheckedValue(document.frmME.prinType);
		if (checkedPrinType == null || checkedPrinType == "") admMileageMngr.cancelSelectGRG();
		else if (checkedPrinType == "G")  admMileCdMngr.getGroupChooser().doShow(admMileageMngr);
		else if (checkedPrinType == "R" ) admMileCdMngr.getRoleChooser().doShow (admMileageMngr);
		else if (checkedPrinType == "g" ) admMileCdMngr.getGradeChooser().doShow(admMileageMngr, document.frmME.mileCd.value);
	},
	doSelectGRG : function (act, grgId) {
		document.frmME.prinId.value     = grgId;
		document.frmME.showPrinId.value = grgId;
	},
	cancelSelectGRG : function () {
		document.frmME.prinId.value     = "";
		document.frmME.showPrinId.value = "";
	},
	getMsgBox : function() {
		if (this.m_msgBox == null) {
			if ( enviewMessageBox == null ) {
				enviewMessageBox = new enview.portal.MessageBox(300, 100, 1000);
			}
			this.m_msgBox = enviewMessageBox;
		}
		return this.m_msgBox
	}
}

