<!--
if( ! window.cafe )
    window.cafe = new Object();

cafe.home = function() {
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	this.m_validator = new enview.util.Validator();
	this.m_contextPath = ebUtil.getContextPath();
}
cafe.home.prototype = {
	m_ajax : null,
	m_checkBox : null,
	m_validator : null,
	m_contextPath : null,
	m_regMngr : null,
	m_favorMngr : null,
	m_msgBox : null,
	
	m_cateIdOrder : null,
	m_topHitTimeoutID : null,
	m_topMileTimeoutID : null,
	m_topMmbrTimeoutID : null,
	m_curMainTopTabId : null,
	m_initView1 : null,
	m_initView2 : null,
	m_mainSrchForm : null,
	
	m_currRankCntt : null,
	
	m_isLogin : null,
	

	getMsgBox : function() {
		if (this.m_msgBox == null) {
			if ( enviewMessageBox == null ) {
				enviewMessageBox = new enview.portal.MessageBox(200, 100, 1000);
			}
			this.m_msgBox = enviewMessageBox;
		}
		return this.m_msgBox
	},
	
	setIsUserLogin: function(flag){
		this.m_isLogin = flag;
	},
	
	getIsUserLogin: function(){
		return this.m_isLogin;
	},
	
	initCafeHome : function(initView) {
		this.initCookieInfo();
		this.setNewNoteAmount();
		
		if (initView == null) initView = "";
		var pos = initView.indexOf(".");
		if (pos == -1) {
			this.m_initView1 = "main";
			this.m_initView2 = "rcmd";
		} else {
			this.m_initView1 = initView.substring(0, pos);
			this.m_initView2 = initView.substring(pos+1);
		}
		if (this.m_initView1 == "main") {
			$("#rankArea").css("display","");
			$("#mineArea").css("display","");
			$("#mineMenuArea").css("display","none");
			$("#cateMenuArea").css("display","none");
			$("#bannerArea").css("display","");
			//this.uiTopHitCafe();
			this.RankCafe();
			this.m_currRankCntt = "hit";
		} else if (this.m_initView1 == "mine") {
			$("#rankArea").css("display","none");
			$('#mineArea').css("display", "none");
			$("#mineMenuArea").css("display","");
			$("#cateMenuArea").css("display","none");
			$("#bannerArea").css("display","");
		} else if (this.m_initView1 == "cate") {
			$("#rankArea").css("display","none");
			$('#mineArea').css("display", "none");
			$("#mineMenuArea").css("display","none");
			$("#cateMenuArea").css("display","");
			$("#bannerArea").css("display","none");
			this.uiCateMenuList();
		}
	
		this.uiCnttTop();
		
		if (this.m_initView1 == "main") {
//			this.uiCntt2nd();
//			this.uiCntt3rd();
		}
	},
	
	initCookieInfo : function(){
		var userinfo = GetCookie('EnviewLoginID');
		if( userinfo ) {
			var userinfoArray = userinfo.split(";");
			if( userinfoArray[0] ) {
				$('#userid').val(userinfoArray[0]);
				$('#pwd').focus();
			}
			else {
				$('#userid').focus();
			}
			
			if( userinfoArray[1] == "1" ) {
				$('#saveid').attr('checked' ,true);
			}
			else {
				$('#saveid').removeAttr('checked');
			}
		}
	},
	RankCafe : function() {
		this.uiTopHitCafe();
		this.uiTopMileCafe();
		this.uiTopMmbrCafe();
	},
	uiTopHitCafe : function() {
		var param = "m=uiTopCafeList&cmd=hit";
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/home.cafe", param, true, {success: function(htmlData) { cfHome.uiHitRankCafeHandler(htmlData); }});
		//this.m_topMmbrTimeoutID = setTimeout("cfHome.uiTopHitCafe()", 30000);
	},
	uiLCafeHandler : function(htmlData) {
		
//		document.getElementById("topHitArea").innerHTML = htmlData;
		document.getElementById("HitRankCnttArea").innerHTML = htmlData;
	},
	uiTopMileCafe : function() {
		var param = "m=uiTopCafeList&cmd=mile";
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/home.cafe", param, true, {success: function(htmlData) { cfHome.uiMileRankCafeHandler(htmlData); }});
		//this.m_topMmbrTimeoutID = setTimeout("cfHome.uiTopMileCafe()", 30000);
	},
	uiTopMileCafeHandler : function(htmlData) {
//		document.getElementById("topMileArea").innerHTML = htmlData;
		document.getElementById("MileRankCnttArea").innerHTML = htmlData;
		
	},
	uiTopMmbrCafe : function() {
		var param = "m=uiTopCafeList&cmd=mmbr";
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/home.cafe", param, true, {success: function(htmlData) { cfHome.uiMmbrRankCafeHandler(htmlData); }});
		//this.m_topMmbrTimeoutID = setTimeout("cfHome.uiTopMmbrCafe()", 30000);
	},
	uiTopMmbrCafeHandler : function(htmlData) {
//		document.getElementById("topMmbrArea").innerHTML = htmlData;
		document.getElementById("MmbrRankCnttArea").innerHTML = htmlData;
	},
	
	uiHitRankCafeHandler : function(htmlData) {
		if(document.getElementById("HitRankCnttArea") != null){
			document.getElementById("HitRankCnttArea").innerHTML = htmlData;
		}
	},
	uiMileRankCafeHandler : function(htmlData) {
		if(document.getElementById("MileRankCnttArea") != null){
			document.getElementById("MileRankCnttArea").innerHTML = htmlData;
		}
	},
	uiMmbrRankCafeHandler : function(htmlData) {
		if(document.getElementsByClassName("MmbrRankCnttArea") != null){
		    var tags = document.getElementsByClassName("MmbrRankCnttArea"); 
		    for (i = 0; i < tags.length; i++) {
		    	tags[ i ].innerHTML = htmlData;
		    }
		}
	},
	uiCateMenuList : function(cateId) {
		var param = "m=uiCateMenuList";
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/home.cafe", param, true, {success: function(htmlData) { cfHome.uiCateMenuListHandler(htmlData,cateId); }});
	},
	uiCateMenuListHandler : function(htmlData,cateId) {
		document.getElementById("cateMenuList").innerHTML = htmlData;
		if(cateId){
			$("#category_"+cateId).css('color','#526ab8');
			$("#category_"+cateId).css('text-decoration', 'underline');
		}else{
			$( ".lnb_dep1 > li:first-child a" ).css('color','#526ab8');
			$( ".lnb_dep1 > li:first-child a" ).css('text-decoration', 'underline');
		}
	},
	uiCnttTop : function() {
		var param = "";
		if (this.m_initView1 == "main") {
			param += "m=uiMainTopCntt";
		} else if (this.m_initView1 == "mine") {
			param += "m=uiMineTopCntt";
			param += "&initView=" + this.m_initView1 + "." + this.m_initView2;
			param += "&cmd=notFavor";
		} else if (this.m_initView1 == "cate") {
			param += "m=uiCateTopCntt";
			param += "&initView=" + this.m_initView1 + "." + this.m_initView2;
		}
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/home.cafe", param, true, {success: function(htmlData) { cfHome.uiCnttTopHandler(htmlData); }});
	},
	uiCnttTopHandler : function(htmlData) {
		document.getElementById("cnttTopArea").innerHTML = htmlData;
		if (this.m_initView1 == "main") {
			var tabId = this.m_initView2 == "rcmd" ? 0 : (this.m_initView2 == "favor" ? 1 : (this.m_initView2 == "rcnt" ? 2 : (this.m_initView2 == "srch" ? 3 : 0)));
			this.selectMainTopTab (tabId);
		}
	},
	selectMainTopTab : function (tabId) {
		this.m_curMainTopTabId = tabId;
		switch (tabId) {
			case 0:
				var param = "m=uiFavorCafeList&cmd=rcmd";
				this.m_ajax.send("POST", this.m_contextPath+"/cafe/home.cafe", param,  true, {success: function(htmlData) { cfHome.selectMainTopTabHandler(htmlData);}});
				break;
			case 1: 
				var param = "m=uiFavorCafeList&cmd=favor";
				this.m_ajax.send("POST", this.m_contextPath+"/cafe/home.cafe", param, true, {success: function(htmlData) { cfHome.selectMainTopTabHandler(htmlData); }});
				break;
			case 2: 
				var param = "m=uiFavorCafeList&cmd=rcnt";
				this.m_ajax.send("POST", this.m_contextPath+"/cafe/home.cafe", param,  true, {success: function(htmlData) { cfHome.selectMainTopTabHandler(htmlData); }});
				break;
		}
	},
	selectMainTopTabHandler : function(htmlData) {
		switch (this.m_curMainTopTabId) {
			case 0: document.getElementById("main_cafe_tab1").innerHTML = htmlData; break;
			case 1: document.getElementById("main_cafe_tab2").innerHTML = htmlData; break;
			case 2: document.getElementById("main_cafe_tab3").innerHTML = htmlData; break;
		}
		$("li.main_cafe_tab, li.main_cafe_tab a").removeClass("on");
		$("#tab"+this.m_curMainTopTabId).addClass("on");
		$("#tab"+this.m_curMainTopTabId).children("a").addClass("on");
		$(".main_cafe_cont").hide();
		var activeTab = $("#tab"+this.m_curMainTopTabId).children("a").attr("onclick");
		$("#" + activeTab).show();
	},
	uiCntt2nd : function() {
		var param = "m=uiMainHotIssue";
		param += "&view=" + "init";
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/home.cafe", param, true, {success: function(htmlData) { cfHome.uiCntt2ndHandler(htmlData); }});
	},
	uiCntt2ndHandler : function(htmlData) {
		document.getElementById("cntt2ndArea").innerHTML = htmlData;
	},
	selectHotIssue : function(issue) {
		var param = "m=uiMainHotIssue";
		param += "&view=" + "cafe";
		param += "&cmntTag=" + issue;
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/home.cafe", param, true, {success: function(htmlData) { cfHome.selectHotIssueHandler(htmlData); }});
	},
	selectHotIssueHandler : function(htmlData) {
		document.getElementById("hotIssueCafeArea").innerHTML = htmlData;
	},
	uiCntt3rd : function() {
		var param = "m=uiMainHotCate";
		param += "&view=" + "init";
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/home.cafe", param, true, {success: function(htmlData) { cfHome.uiCntt3rdHandler(htmlData); }});
	},
	uiCntt3rdHandler : function(htmlData) {
		document.getElementById("cntt3rdArea").innerHTML = htmlData;
	},
	selectHotCate : function(cate) {
		var param = "m=uiMainHotCate";
		param += "&view=" + "cafe";
		param += "&cateId=" + cate;
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/home.cafe", param, true, {success: function(htmlData) { cfHome.selectHotCateHandler(htmlData); }});
	},
	selectHotCateHandler : function(htmlData) {
		document.getElementById("hotCateCafeArea").innerHTML = htmlData;
	},
	showFavorCafeEdit : function() {
		this.initCafeHome("mine.favorEdit");
	},
	selectCateMenu : function(cateNm, cateId, cateLevel ,main) {
		if(main){
			this.m_initView1 = "cate";
			this.m_initView2 = "init";
			$("#rankArea").css("display","none");
			$('#mineArea').css("display", "none");
			$("#mineMenuArea").css("display","none");
			$("#cateMenuArea").css("display","");
			$("#bannerArea").css("display","none");
			this.uiCateMenuList(cateId);	
		}
		$(".category").css('color','');
		$(".category").css('text-decoration', 'none');
		$("#category_"+cateId).css('color','#526ab8');
		$("#category_"+cateId).css('text-decoration', 'underline');
		var param = "m=uiCateTopCntt";
		param += "&initView=" + this.m_initView1 + "." + this.m_initView2;
		param += "&cateId=" + cateId;
		param += "&cateNm=" + cateNm;
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/home.cafe", param, true, {success: function(htmlData) { cfHome.uiCnttTopHandler(htmlData); }});
	},
	show3rdCateMenu : function(cateId) {
		$("font[id='cate_font_"+cateId+"']").css('color','#526ab8');
		$("font[id*='cate_font']").filter("font[id!='cate_font_"+cateId+"']").css("color","");
		$("ul[id='cate_ul_"+cateId+"']").css("display","");
		$("ul[id*='cate_ul']").filter("ul[id!='cate_ul_"+cateId+"']").css("display","none");
	},
	uiMakeCafe : function() {
		var param = "m=uiMakeCafe";
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/home.cafe", param, true, {success: function(htmlData) { cfHome.uiMakeCafeHandler(htmlData); }});
	},
	uiMakeCafeHandler : function(htmlData) {
		document.getElementById("cnttTopArea").innerHTML = htmlData;
	},
	checkMakeCafe : function() {
		// maxlength 체크
		ebUtil.checkLength( document.makeCafeFileForm);
		
		if (!ebUtil.chkValue (document.getElementById("makeCafe_cmntNm"), "카페명을", "true")) return;
		if (!ebUtil.chkValue (document.getElementById("makeCafe_cmntUrl"), "주소를", "true")) return;
		if (!ebUtil.chkTableName (document.getElementById("makeCafe_cmntUrl"), "주소에", "true")) return;
		if (!ebUtil.chkCheck (document.getElementsByName("makeCafe_openYn"), "공개 여부를", "true")) return;
		
		var cateHier = parseInt(document.setForm.cateHier.value);
		var cateSelected = false;
		var elmCateId = null;
		for (var i=cateHier; i>0; i--) {
			elmCateId = document.getElementById ("makeCafe_cateId"+i);
			if (ebUtil.getSelectedValue(elmCateId) != null && ebUtil.getSelectedValue(elmCateId) != "") {
				cateSelected = true;
				break;
			}
		}
		if (!cateSelected) if (!ebUtil.chkSelect (elmCateId, 1, "카테고리를", "true")) return;
		
		var cmntTags = "";
		for (var i=1; i<=8; i++) {
			var tag = document.getElementById("makeCafe_cmntTag"+i).value;
			if (tag.length > 0) cmntTags += tag + ",";
		}
		if (cmntTags == "") {
			if (!ebUtil.chkValue (document.getElementById("makeCafe_cmntTag1"), "검색태그를", "true")) return;
		} else {
			cmntTags = cmntTags.substring(0, cmntTags.length-1); // remove ','.
		}
		if (!ebUtil.chkValue (document.getElementById("makeCafe_cmntIntro"), "카페 소개글을", "true")) return;
		if (!ebUtil.chkLength (document.getElementById("makeCafe_cmntIntro"), "카페 소개글", 600, "true")) return;

		if (!ebUtil.chkValue (document.getElementById("file"), "카페 대표 이미지를", "ture")) return;

		var cmntUrlValidted = $('#cmntUrlValidted').val();
		if(cmntUrlValidted == "false") {
			alert('카페 주소를 다시 입력하세요.');
			$('#makeCafe_cmntUrl').select();
			return;
		}
		$("#btns_make_cafe").html("카페를 만들고 있습니다...");
		var frm = document.makeCafeFileForm;
		frm.action = this.m_contextPath+"/cafe/home.cafe?m=setMakeCafeImg";
		frm.target = "makeCafeImg";
		frm.submit();
	},
	setMakeCafe : function() {
		var cmntTags = "";
		for (var i=1; i<=8; i++) {
			var tag = document.getElementById("makeCafe_cmntTag"+i).value;
			if (tag.length > 0) cmntTags += tag + ",";
		}
		var param = "m=setMakeCafe";
		param += "&cmntNm=" + encodeURIComponent( document.getElementById("makeCafe_cmntNm").value);
		param += "&cmntUrl=" + document.getElementById("makeCafe_cmntUrl").value;
		param += "&openYn=" + ebUtil.getCheckedValue (document.getElementsByName("makeCafe_openYn"));
		
		var cateHier = parseInt(document.setForm.cateHier.value);
		var elmCateId = null;
		for (var i=cateHier; i>0; i--) {
			elmCateId = document.getElementById ("makeCafe_cateId"+i);
			if (ebUtil.getSelectedValue(elmCateId) != null && ebUtil.getSelectedValue(elmCateId) != "") {
				param += "&cateId=" + ebUtil.getSelectedValue(elmCateId);
				break;
			}
		}
		
		param += "&cmntTag=" + encodeURIComponent( cmntTags);
		param += "&cmntIntro=" + encodeURIComponent( document.getElementById("makeCafe_cmntIntro").value);
		param += "&themeNm=" + document.getElementById("makeCafe_themeNm").value;
		param += "&fileMask=" + document.setForm.cmntImgFileMask.value;

		this.m_ajax.send( "POST", this.m_contextPath+"/cafe/home.cafe", param, true, {success: function(data) { cfHome.setMakeCafeHandler(data); }});
	},
	setMakeCafeHandler : function(data) {
		document.getElementById("file").value = ""; // 파일이 이미 업로드 됐으니 간섭을 피하기 위해 지워버린다.
		alert('카페 생성이 완료되었습니다.');
		location.href = this.m_contextPath + "/cafe";
	},
	cancelMakeCafe : function() {
		location.href = "./cafe";
	},
	deleteCafe : function() {
		if( !confirm( ebUtil.getMessage ("ev.info.remove"))) return;
		var param = "m=setDeleteCafe";
		param += "&cmntUrl=" + document.getElementById("makeCafe_cmntUrl").value;
		this.m_ajax.send( "POST", this.m_contextPath+"/cafe/home.cafe", param, true, {success: function(data) { cfHome.deleteCafeHandler(data); }});
	},
	deleteCafeHandler : function() {
		cfHome.getMsgBox().doShow (ebUtil.getMessage("mm.info.common.success"));
	},
	selectCateId : function(elm, order) {
		this.m_cateIdOrder = order;
		this.m_cafeIdPrefix = elm.id.substring(0, elm.id.length-1);
		var elmNext = document.getElementById(this.m_cafeIdPrefix+(order+1));
		var elmNNext = document.getElementById(this.m_cafeIdPrefix+(order+2));
		if (elmNext) {
			for (var i=elmNext.length; i>0; i--) {
				elmNext.remove(i);
			}
			if (ebUtil.getSelectedValue(elm) == "") {
				ebUtil.setSelectedValue(elmNext, "");
				elmNext.readonly = "true";
			} else {
				var param = "m=getChildCateList";
				param += "&cateId=" + ebUtil.getSelectedValue(elm);
				this.m_ajax.send( "POST", this.m_contextPath+"/cafe/home.cafe", param, true, {success: function(data) { cfHome.selectCateIdHandler(data); }});
			}
			if (elmNNext) {
				for (var i=elmNNext.length; i>0; i--) {
					elmNNext.remove(i);
				}
				ebUtil.setSelectedValue(elmNNext, "");
			}
		}
	},
	selectCateIdHandler : function(data) {
		var elmNext = document.getElementById(this.m_cafeIdPrefix+(this.m_cateIdOrder+1));
		var tagOption = null;
		for (var i=0; i<data.Data.length; i++) {
			tagOption = document.createElement("option");
			tagOption.value = data.Data[i].cateId;
			tagOption.text = data.Data[i].cateNm;
			elmNext.add (tagOption, elmNext.options[null]);
		}
		elmNext.focus();
	},
	focusCmntTag : function(elm, seq) {
		var idPrefix = elm.id.substring(0,elm.id.length-1);
		document.getElementById(idPrefix+(seq+1)).style.display = "";
	},
	
	keyCheckCmntUrl : function(elm) {
//		var text = elm.value;
//		elm.value =  text.replace(/[^a-zA-Z0-9]/gi, '');
    },
	
	dupCheckCmntUrl : function(elm) {
		if (elm.value.length == 0) return;
		if (document.getElementById("makeCafe_cmntUrlRslt").innerHTML != "") return;
		
		var text = elm.value;
		var newText =  text.replace(/[^a-zA-Z0-9]/gi, '');
		if( text != newText) {
			var msg = "<font color='red'>" + ebUtil.getMessage('mm.info.cant.special') + "</font>";
			document.getElementById("makeCafe_cmntUrlRslt").innerHTML = msg;
			$('#cmntUrlValidted').val(false);
			return ;
		}
		

		var param = "m=dupCheckCmntUrl";
		param += "&cmntUrl=" + elm.value;
		this.m_ajax.send( "POST", this.m_contextPath+"/cafe/home.cafe", param, true, {success: function(data) { cfHome.dupCheckCmntUrlHandler(data); }});
	},
	dupCheckCmntUrlHandler : function(data) {
		if (data.ReasonCd == "cf.error.already.used.url") {
			var htmlStr = "<font color=red>"+data.Reason+"</font>";
			document.getElementById("makeCafe_cmntUrlRslt").innerHTML = htmlStr;
			$('#cmntUrlValidted').val(false);
		} else {
			document.getElementById("makeCafe_cmntUrlRslt").innerHTML = data.Reason;
			$('#cmntUrlValidted').val(true);
		}
	},
	dupCheckCmntUrlReset : function() {
		document.getElementById("makeCafe_cmntUrlRslt").innerHTML = "";
		$('#cmntUrlValidted').val(false);
	}
	,
	doDelete : function() {
		if (!ebUtil.chkCheck (document.getElementsByName("multiLang_checkRow"), '언어를', true)) return;
		if (confirm (ebUtil.getMessage("ev.info.remove"))) {
			document.getElementById("multiLang_act").value = "del";
			var param = "m=setMultiLang";
			param += "&act=" + "del";
			param += "&tblNm=" + this.m_tblNm;
			param += "&langKnd=" + ebUtil.getCheckedValues (document.getElementsByName("multiLang_checkRow"));
			if (this.m_tblNm == "board" || this.m_tblNm == "poll") {
				param += "&boardId=" + this.m_pk1;
			} else if (this.m_tblNm == "bltnCate") {
				param += "&boardId=" + this.m_pk1;
				param += "&bltnCateId=" + this.m_pk2;
			} else if (this.m_tblNm == "bltnExtnProp") {
				param += "&boardId=" + this.m_pk1;
				param += "&fldNm=" + this.m_pk2;
			}
			this.m_ajax.send ("POST", this.m_contextPath+"/board/adBoard.brd", param, true, {success: function(data) { ebUtil.getMLMngr().doSaveHandler(data); }});
		}
	},
	doSaveHandler : function (data) {
		var act = document.getElementById("multiLang_act").value;
		if (act == "ins") {
			ebUtil.getMLMngr().m_caller.getMsgBox().doShow (ebUtil.getMessage("ev.info.success.add"));
		} else if (act == "upd") {
			ebUtil.getMLMngr().m_caller.getMsgBox().doShow (ebUtil.getMessage("ev.info.success.update"));
		} else if (act == "del") {
			ebUtil.getMLMngr().m_caller.getMsgBox().doShow (ebUtil.getMessage("ev.info.success.delete"));
		}
		ebUtil.getMLMngr().doGet();
	},
	searchCafeList : function () {
		var param = "m=uiFavorCafeList&cmd=srch&view=init";
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/home.cafe", param,  true, {success: function(htmlData) { 
			document.getElementById("cnttTopArea").innerHTML = htmlData; 
			var frm = document.srchCafeForm;
			param = "m=uiFavorCafeList&cmd=srch&view=list";
			param += "&pageNo=1";
			cfHome.m_ajax.send("POST", cfHome.m_contextPath+"/cafe/home.cafe", ebUtil.completeParam(frm, param),  true, {success: function(htmlData) { cfHome.searchCafeListHandler(htmlData); }});  
		}});
	},
	
	searchCafeListHandler : function (htmlData) {
		document.getElementById("srchCafeRsltListDiv").innerHTML = htmlData;
		cfHome.setPageIndex (document.getElementById("srchCafe_pageIndex"),
							 document.getElementById("srchCafe_pageNo").value,
							 document.getElementById("srchCafe_totalPage").value,
							 "cfHome.searchCafeNext"
							);
	},
	searchCafeNext : function (page) {
		var frm = document.srchCafeForm;
		var param = "m=uiFavorCafeList&cmd=srch&view=list";
		param += "&pageNo="+page;
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/home.cafe", ebUtil.completeParam(frm, param),  true, {success: function(htmlData) { cfHome.searchCafeListHandler(htmlData); }});
	},
	changeSrchType : function (type) {
		ebUtil.setSelectedValue (document.srchCafeForm.srchType, type);
		cfHome.searchCafeList();
	},
	changeSrchSort : function (sort) {
		document.srchCafeForm.srchSort.value = sort;
		cfHome.searchCafeList();
	},
	searchCafeExtn : function (frm) {
		this.m_mainSrchForm = frm;
		cfHome.initCafeHome('main.srch'); // 카페찾기 화면 초기화를 진행한 후,
	},
	setPageIndex : function (elm, currentPage, totalPage, scriptNm, imgUrlPrefix) {
		// elm: 생성된 page navigation을 innerHTML로 넣어줄 대상 객체.
		// currentPage: 현재 선택된 페이지 번호
		// totalPage:   페이지의 총수. 한 페이지는 setSize 만큼씩의 데이터를 갖는다. 단, 마지막 페이지는 예외.
		var setSize     = 10; // 하단 Page Iterator에서의 Navigation 갯수
		var imgUrl      = ebUtil.getContextPath()+"/snu_cafe/images/";
		if (imgUrlPrefix != null) imgUrl = imgUrlPrefix;
		var color       = "808080";
		
		var afpImg = "imgFirstActive.gif";
		var pfpImg = "imgFirstPassive.gif";
		var alpImg = "imgLastActive.gif";
		var plpImg = "imgLastPassive.gif";
		var apsImg = "imgPrev10Active.gif";
		var ppsImg = "imgPrev10Passive.gif";
		var ansImg = "imgNext10Active.gif";
		var pnsImg = "imgNext10Passive.gif";
		
		var startPage;    
		var endPage;      
		var cursor;      
		var curList = "";
		var prevSet = "";
		var nextSet = "";
		var firstP  = "";
		var lastP   = "";

		moduloCP = (currentPage - 1) % setSize / setSize ;
		startPage = Math.ceil((((currentPage - 1) / setSize) - moduloCP)) * setSize + 1;
		moduloSP = ((startPage - 1) + setSize) % setSize / setSize;
		endPage   = Math.ceil(((((startPage - 1) + setSize) / setSize) - moduloSP)) * setSize;

		if (totalPage <= endPage) endPage = totalPage;
			
		if (currentPage > setSize) {
			firstP = "<a onclick="+scriptNm+"('1') class='btn first' href='#'>맨처음</a>";
			cursor = startPage - 1;
			prevSet ="<a onclick="+scriptNm+"('"+cursor+"') class='btn prev' href='#'>이전</a> ";
		} else {
			firstP  = "<a class='btn first' href='#'>맨처음</a>";
			prevSet = "<a class='btn prev' href='#'>이전</a> "; 
		}
			
		cursor = startPage;
		while( cursor <= endPage ) {
			if( cursor == currentPage ) 
				curList += "<a class='active' href='#'>"+cursor+"</a>";
			else {
				curList += "<a href='#' onclick="+scriptNm+"('"+cursor+"')>"+cursor+"</a>";
			}
			
			cursor++;
		}
				 
		if ( totalPage > endPage) {
			lastP = "<a onclick="+scriptNm+"('"+totalPage+"') class='btn last' href='#'>맨 뒤</a>";
			cursor = endPage + 1;  
			nextSet = "<a onclick="+scriptNm+"('"+cursor+"') class='btn next' href='#'>열 페이지 뒤로 가기</a>";
		} else {
			lastP  = "<a class='btn last' href='#'>맨 뒤</a>";
			nextSet = "<a class='btn next' href='#'>열 페이지 뒤로 가기</a>";
		}
		
		curList = firstP +"&nbsp;"+ prevSet +"&nbsp;&nbsp;"+ curList +"&nbsp;&nbsp;"+ nextSet +"&nbsp;"+ lastP;
		
		elm.innerHTML = curList;
	},
	getRegMngr : function() {
		if (this.m_regMngr == null) {
			this.m_regMngr = new cafe.home.regMngr(this);
		}
		return this.m_regMngr;
	},
	getFavorMngr : function() {
		if (this.m_favorMngr == null) {
			this.m_favorMngr = new cafe.home.favorMngr(this);
		}
		return this.m_favorMngr;
	}, 
	
	login : function() {
		if(event.keyCode == 0 || event.keyCode == 13){
			var isSaveLoginID = $("#saveid").attr('checked');
			if( isSaveLoginID == true || isSaveLoginID == 'checked') {
				var id = $('#userid').val();
				var today = new Date();
				var expires = new Date();
				expires.setTime(today.getTime() + 1000*60*60*24*365);
				SetCookie('EnviewLoginID', id+";1", expires, '/');
			}
			else {
				//DeleteCookie('EnviewLoginID', '/');
				var today = new Date();
				var expires = new Date();
				expires.setTime(today.getTime() + 1000*60*60*24*365);
				SetCookie('EnviewLoginID', ";0", expires, '/');
			}
			
			var param = "&userId=" + document.getElementById("userid").value;
			param += "&password=" + document.getElementById("pwd").value;
			location.href = this.m_contextPath + "/user/loginProcess.face?destination=/cafe/" + param;
		}
	},
	
	logout : function() {
		location.href = this.m_contextPath + "/user/logout.face?destination=/cafe";
	},
	
	go2Cafe : function(cmntUrl){
		location.href = this.m_contextPath + "/cafe/" + cmntUrl;
	},
	prevRankCntt : function() {
		switch(this.m_currRankCntt){
			case "hit": this.uiTopMmbrCafe(); this.m_currRankCntt = "mmbr"; document.getElementById("rankName").innerHTML = "회원수 랭킹"; break;
			case "mile": this.uiTopHitCafe(); this.m_currRankCntt = "hit"; document.getElementById("rankName").innerHTML = "인기 랭킹"; break;
			case "mmbr": this.uiTopMileCafe(); this.m_currRankCntt = "mile"; document.getElementById("rankName").innerHTML = "활동 랭킹"; break;
		}
	},
	
	nextRankCntt : function() {
		switch(this.m_currRankCntt){
			case "hit": this.uiTopMileCafe(); this.m_currRankCntt = "mile"; document.getElementById("rankName").innerHTML = "활동 랭킹"; break;
			case "mile": this.uiTopMmbrCafe(); this.m_currRankCntt = "mmbr"; document.getElementById("rankName").innerHTML = "회원수 랭킹"; break;
			case "mmbr": this.uiTopHitCafe(); this.m_currRankCntt = "hit"; document.getElementById("rankName").innerHTML = "인기 랭킹"; break;
		}
	},
	
	setNewNoteAmount : function(){
		if(this.m_isLogin){
			var param = "";
			this.m_ajax.send("POST", this.m_contextPath+"/note/newNote.hanc", param,  true, {success: function(htmlData) { 
				document.getElementById("newNoteAmount").innerHTML = htmlData; 
			}});
		}
	},
	
	resignCafe : function (cafeUrl) {
		if (!confirm ("정말 탈퇴하시겠습니까?")) return;
		var param = "m=setResignCafe";
		param += "&cafeUrl=" + cafeUrl;
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/each.cafe", param, true, {success: function(data) { cfHome.resignCafeHandler(data); }});
	},
	
	resignCafeHandler : function (data) {
		alert("정상적으로 탈퇴 처리 되었습니다.");
		this.initCafeHome("main.mine");
	},
	
	cancelCafeJoin : function (cafeUrl) {
		if (!confirm ("정말 취소 하시겠습니까?")) return;
		var param = "m=setCancelCafeJoin";
		param += "&cafeUrl=" + cafeUrl;
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/each.cafe", param, true, {success: function(data) { cfHome.cancelCafeJoinHandler(data); }});
	},
	
	cancelCafeJoinHandler : function (data) {
		alert("정상적으로 가입 신청 취소 처리 되었습니다.");
		this.initCafeHome("mine.wait");
	},
	
	toggleCategory : function(id){
		if(id.indexOf('category_') == 0) id = id.substring('category_'.length);
		if($('#category_' + id).attr('isOpen') == 'false'){
			$('.parentCategory_' + id).show();
			$('#category_' + id).attr('isOpen', 'true');
		}else {
			$('#category_' + id).attr('isOpen', 'false');
			$('.parentCategory_' + id).hide();
		}
	},
	
	toggleFavorCafe : function(cmntId){
		var param = "m=toggleFavorCafe";
		param += "&cmntId=" + cmntId;
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/home.cafe", param, true, {success: function(data) { cfHome.toggleFavorCafeHandler(data, cmntId); }});
	},
	
	toggleFavorCafeHandler : function(data, cmntId){
		var starId = "star_" + cmntId;
		var star = document.getElementById(starId);
		if(star.className=='icon on'){
			star.className='icon off'
		}else{
			star.className='icon on'
		}
	}
}
cafe.home.regMngr = function(parent) {
	this.m_parent = parent;
	this.m_ajax = parent.m_ajax;
	this.m_contextPath = parent.m_contextPath;
}
cafe.home.regMngr.prototype = {
	m_parent : null,
	m_ajax : null,
	m_contextPath : null,
	m_cmd : null,
	
	regCmntMmbr : function(cmd) {
		this.m_cmd = cmd;
		if (cmd == "12") { // 초대요청
			
			if (document.getElementById("retry").value == "true") {
				alert("이미 초대요청을 하셨습니다.");
				return;
			}
			var param = "m=regCmntMmbr";
			param += "&cmd=" + cmd;
			param += "&cmntUrl=" + document.getElementById("cmntUrl").value;
			this.m_ajax.send( "POST", this.m_contextPath+"/cafe/home.cafe", param, true, {success: function(data) { cfHome.getRegMngr().regCmntMmbrHandler(data); }});
		
		} else if (cmd == "13") { // 초대요청취소
			
			if (document.getElementById("retry").value == "true") {
				alert("이미 초대요청을 취소하셨습니다.");
				return;
			}
			if (!confirm("정말 초대요청을 취소하시겠습니까?")) return;
			var param = "m=regCmntMmbr";
			param += "&cmd=" + cmd;
			param += "&cmntUrl=" + document.getElementById("cmntUrl").value;
			this.m_ajax.send( "POST", this.m_contextPath+"/cafe/home.cafe", param, true, {success: function(data) { cfHome.getRegMngr().regCmntMmbrHandler(data); }});
		
		} else if (cmd == "rereg") { // 재가입요청(자진탈퇴 취소)
			/*
			if (document.getElementById("retry").value == "true") {
				alert("이미 재가입 하셨습니다.");
				return;
			}
			*/
			if (!confirm("재가입 하시겠습니까?")) return;
			var param = "m=regCmntMmbr";
			param += "&cmd=" + cmd;
			param += "&cmntUrl=" + document.getElementById("cmntUrl").value;
			this.m_ajax.send( "POST", this.m_contextPath+"/cafe/home.cafe", param, true, {success: function(data) { cfHome.getRegMngr().regCmntMmbrHandler(data); }});
 		
		} else if (cmd == "regView") { // 회원가입 화면 요청
			
			var frm = document.regForm;
			frm.action = this.m_contextPath+"/cafe/"+document.getElementById("cmntUrl").value;
			frm.submit();
		
		} else if (cmd == "10") { // 가입신청

			if (document.getElementById("retry").value == "true") {
				alert("이미 가입 하셨습니다.");
				return;
			}

			var param = "m=regCmntMmbr";
			param += "&cmd=" + cmd;
			param += "&cmntUrl=" + document.getElementById("cmntUrl").value;

			if (!ebUtil.chkValue(document.getElementById("userNick"), "닉네임을", "ture")) return;
			param += "&userNick=" + encodeURIComponent(document.getElementById("userNick").value);

			if (document.getElementById("regQuizAnsw")) {
				if (!ebUtil.chkValue(document.getElementById("regQuizAnsw"), "가입퀴즈 답변을", "ture")) return;
				param += "&regQuizAnsw=" + encodeURIComponent(document.getElementById("regQuizAnsw").value);
			}
			var answCntt = "";
			var qstnList = document.getElementsByName("regQstnLi");
			if (qstnList && qstnList.length > 0) {
				for (var i=0; i<qstnList.length; i++) {
					var seq = qstnList[i].getAttribute("qstnSeq");
					if (qstnList[i].getAttribute("qstnType") == "A") {
						if (!ebUtil.chkCheck(document.getElementsByName("answSeq"+seq), "가입설문 답변을", "ture")) return;
						answCntt += ebUtil.getCheckedValue(document.getElementsByName("answSeq"+seq)) + "[[SEP]]";
					} else if (qstnList[i].getAttribute("qstnType") == "B") {
						if (!ebUtil.chkValue(document.getElementById("contents"+seq), "가입설문 답변을", "ture")) return;
						answCntt += document.getElementById("contents"+seq).value + "[[SEP]]";
					}
				}
				if (answCntt.length > 0) {
					param += "&answCntt=" + answCntt.substring(0, answCntt.length-7); // 마지막 '[[SEP]]' 제거하고 할당.
				}
			}
//			param += "&openId="   + ebUtil.getCheckedValue (document.getElementsByName("umInfo_openId"));
//			param += "&openNm="   + ebUtil.getCheckedValue (document.getElementsByName("umInfo_openNm"));
//			param += "&openSex="  + ebUtil.getCheckedValue (document.getElementsByName("umInfo_openSex"));
			
			this.m_ajax.send( "POST", this.m_contextPath+"/cafe/home.cafe", param, true, {success: function(data) { cfHome.getRegMngr().regCmntMmbrHandler(data); }});
		}
	},
	regCmntMmbrHandler : function(data) {
		if (this.m_cmd == "12" ) {
			document.getElementById("retry").value = "true";
			alert("초대요청 메일이 정상적으로 발송되었습니다.");
			//cfHome.getMsgBox().doShow("초대요청 메일이 정상적으로 발송되었습니다.");
		} else if (this.m_cmd == "13") {
			document.getElementById("retry").value = "true";
			alert("초대요청이 정상적으로 취소 처리되었습니다.");
		} else if (this.m_cmd == "10" || this.m_cmd == "rereg") {
//			document.getElementById("retry").value = "true";
			if (data.RegType == "A") { // '가입유형'이 '자동가입'이면 개별카페홈으로 gogo!
				if( data.Welcome == null || data.Welcome == '' ) {
					alert("카페 회원가입이 완료되었습니다.");
				} else {
					alert(data.Welcome);
				}
			} else {
				alert("카페 회원가입이 신청되었습니다.");
			}
		}
		var cmntUrl = document.getElementById("cmntUrl").value;
		location.href = this.m_contextPath+"/cafe/"+cmntUrl;
	}	
}
cafe.home.favorMngr = function(parent) {
	this.m_parent = parent;
	this.m_ajax = parent.m_ajax;
	this.m_contextPath = parent.m_contextPath;
}
cafe.home.favorMngr.prototype = {
	m_parent : null,
	m_ajax : null,
	m_contextPath : null,
	
	select : function(obj) {
		$('.favorEditLi').removeClass('selected');
		$('.favorEditLi').attr("isSelected", "F");
		if(obj){
			var selectedCafe = $(obj);
			selectedCafe.attr("isSelected","T");
			selectedCafe.addClass('selected');
		}
	},
	add : function() {
		var addCmnt = $(".favorEditMyLi[isSelected='T']");
		if($(addCmnt).length > 0){
			$(addCmnt).attr('id', 'favor_edit_favorLi_' + $(addCmnt).attr('id').substring('favor_edit_MyLi_'.length));
			$(addCmnt).removeClass('favorEditMyLi');
			$(addCmnt).addClass('favorEditFavorLi');
			$(addCmnt).remove();
			$(addCmnt).appendTo($("ul#favor_edit_favorUl"));
			cfHome.getFavorMngr().select();
		} else {
			alert('추가할 카페를 선택해주세요');
		}
	},
	rem : function() {
		var remCmnt =  $(".favorEditFavorLi[isSelected='T']");
		if($(remCmnt).length > 0){
			$(remCmnt).attr('id', 'favor_edit_MyLi_' + $(remCmnt).attr('id').substring('favor_edit_favorLi_'.length));
			$(remCmnt).removeClass('favorEditFavorLi');
			$(remCmnt).addClass('favorEditMyLi');
			$(remCmnt).remove();
			$(remCmnt).appendTo($("ul#favor_edit_allUl"));
			cfHome.getFavorMngr().select();
		} else {
			alert('제거할 카페를 선택해주세요');
		}
	},
	move : function(flag) {
		if (flag == "first") {
			if ($("li.favorEditFavorLi:first").attr("cmntId") == $("li.favorEditFavorLi").filter("li[isSelected='T']").attr("cmntId")) return;
			$("li.favorEditFavorLi:first").before($("li.favorEditFavorLi").filter("li[isSelected='T']"));
		} else if (flag == "up") {
			$("li.favorEditFavorLi").filter("li[isSelected='T']").prev().before($("li.favorEditFavorLi").filter("li[isSelected='T']"));
		} else if (flag == "down") {
			$("li.favorEditFavorLi").filter("li[isSelected='T']").next().after($("li.favorEditFavorLi").filter("li[isSelected='T']"));
		} else if (flag == "last") {
			if ($("li.favorEditFavorLi:last").attr("cmntId") == $("li.favorEditFavorLi").filter("li[isSelected='T']").attr("cmntId")) return;
			$("li.favorEditFavorLi:last").after($("li.favorEditFavorLi").filter("li[isSelected='T']"));
		}
	},
	save : function() {
		var data = "";
		$("li.favorEditFavorLi").each(function(i) {
			data += "," + $(this).attr("cmntId");
		});
		var param = "m=setFavorCafe";
		param += "&cmntId=" + data.substring(1); // 맨처음 ',' 제거 후 전송.
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/home.cafe", param, true, {success: function(data) { cfHome.getFavorMngr().saveHandler(data); }});
	},
	saveHandler : function(data) {
		cfHome.getMsgBox().doShow (ebUtil.getMessage("mm.info.common.success"));
		cfHome.initCafeHome('mine.favorEdit');
	},
	cancel : function() {
		cfHome.initCafeHome('mine.favor');
	}
}
var cfHome = new cafe.home();

$(document).ready(function(){
	$('#userid').focus(function(){
		if($('#userid').val() == '아이디'){
			$('#userid').val('');
		}
	});
	$('#userid').blur(function(){
		if($('#userid').val() == ''){
			$('#userid').val('아이디');
		}
	});
	
	$('#pwd').focus(function(){
		if($('#pwd').val() == '비밀번호'){
			$('#pwd').val('');
		}
	});
		
	$('#pwd').blur(function(){
		if($('#pwd').val() == ''){
			$('#pwd').val('비밀번호');
		}
	});
});


//포틀릿1
jQuery(function($){
	var tab = $('.tab_wrap');
	tab.removeClass('js_off');
	function onSelectTab(){
		var t = $(this);
		var myClass = t.parent('li').attr('class');
		t.parents('.tab_wrap:first').attr('class', 'tab_wrap '+myClass);
	}
	tab.find('>ul>li>a').click(onSelectTab).focus(onSelectTab);
});