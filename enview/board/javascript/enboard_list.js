<!--
if( ! window.enboard )
    window.enboard = new Object();
if( ! ebUtil )
	var ebUtil = new enboard.util();

enboard.list = function() {}

enboard.list.prototype = {
	
	initList : function() {
		adminEventFree (window);

		try {
			if (document.getElementById("editorCntt")) {
				// FCKeditor 관련 초기화
				//var sBasePath = document.location.href.substring(0,document.location.href.lastIndexOf('fckeditor'));
				enLangKnd = eval('document.setTransfer.langKnd.value');
				var ebFCKeditor = new FCKeditor('editorCntt');
				ebFCKeditor.BasePath = ebUtil.getContextPath()+'/board/fckeditor/';
				ebFCKeditor.Config["CustomConfigurationsPath"] = ebUtil.getContextPath()+'/board/javascript/fckconfig_cafe.one.js';
				ebFCKeditor.Height = 100; // Chrome에서의 최소값:160
				ebFCKeditor.ReplaceTextarea();
			}
		} catch (e) {
			// 카페의 한줄메모장과 같이 목록화면에 편집화면이 있는 경우가 아니면
			// Exception이 떨어진다 --> Ignore...
		}
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 게시판 목록 맨앞 Checkbox 이미지 파일 토글/checkeditem 속성 값 바꾸어주기.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	checkBulletin : function( obj ) { 	
		var path = document.setForm.boardSkinDflt.value;

		if (obj.getAttribute("checkeditem") == "Y") {
			obj.setAttribute("checkeditem", "N");
			obj.innerHTML = "<img src=./images/board/skin/"+path+"/imgXox.gif>";
		} else {
			obj.setAttribute("checkeditem", "Y");
			obj.innerHTML = "<img src=./images/board/skin/"+path+"/imgOox.gif>";
		}
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 검색창에서 '검색' 버튼을 눌렀을 때.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	srchBulletin : function() {

		// srchType 필드가 스킨에 따라 checkbox이거나 select이거나 둘 다의 혼재일 수가 있다. 	
		var selectFirst = true;
		var arraySrchType = document.getElementsByName("srchType");
		for (var idx=0; idx<arraySrchType.length; idx++) {
			if (arraySrchType[idx].type == 'checkbox') {
				if (arraySrchType[idx].checked) {
					if (selectFirst) {
						selectFirst = false;
						document.setForm.srchType.value = arraySrchType[idx].value;
					} else {
						document.setForm.srchType.value += ',' + arraySrchType[idx].value;
					}
				}
			} else if (arraySrchType[idx].type == 'select-one') {
				for (var i=0; i<arraySrchType[idx].length; i++) {
					if (arraySrchType[idx].options[i].selected) {
						if (selectFirst) {
							selectFirst = false;
							document.setForm.srchType.value = arraySrchType[idx].options[i].value;
						} else {
							document.setForm.srchType.value += ',' + arraySrchType[idx].options[i].value;
						}
					}
				}
			} else if (arraySrchType[idx].type == 'select-multiple') {
				for (var i=0; i<arraySrchType[idx].length; i++) {
					if (arraySrchType[idx].options[i].selected) {
						if (selectFirst) {
							selectFirst = false;
							document.setForm.srchType.value = arraySrchType[idx].options[i].value;
						} else {
							document.setForm.srchType.value += ',' + arraySrchType[idx].options[i].value;
						}
					}
				}
			} else if (arraySrchType[idx].type == "radio") {
				if (arraySrchType[idx].checked) {
					if (selectFirst) {
						selectFirst = false;
						document.setForm.srchType.value = arraySrchType[idx].value;
					} else {
						document.setForm.srchType.value += ',' + arraySrchType[idx].value;
					}
				}
			} else {
				if (arraySrchType[idx] != document.setForm.srchType) {
					if (selectFirst) {
						selectFirst = false;
						document.setForm.srchType.value = arraySrchType[idx].value;
					} else {
						document.setForm.srchType.value += ',' + arraySrchType[idx].value;
					}
				}
			}
		}

		if (document.setForm.srchType.value == '') {
			//alert("검색대상을 선택하세요");
			alert(ebUtil.getMessage('eb.info.select.srchTrgt'));
			arraySrchType[0].focus();
			return false;
		}
		if (document.setForm.srchType.value.indexOf('Repl') >= 0) { // 답글여부조건이 있으면
			document.setSrch.srchReplYn[0].checked ? document.setForm.srchReplYn.value = 'Y' : document.setForm.srchReplYn.value = 'N'; 
		}
		if (document.setForm.srchType.value.indexOf('Memo') >= 0) { // 댓글여부조건이 있으면
			document.setSrch.srchMemoYn[0].checked ? document.setForm.srchMemoYn.value = 'Y' : document.setForm.srchMemoYn.value = 'N'; 
		}
		if (document.setForm.srchType.value.indexOf('RegD') == -1
		 && document.setForm.srchType.value.indexOf('Repl') == -1
		 && document.setForm.srchType.value.indexOf('Memo') == -1) { // 작성일/답글여부/댓글여부 검색이 없으면,
			if (document.setSrch.srchKey.value.trim().length == 0) {
				//alert('검색어를 입력하세요');
				alert(ebUtil.getMessage('eb.info.srchKey'));
				document.setSrch.srchKey.focus();
				return false;
			}
		}
		
		if (document.setSrch.srchKey)    document.setForm.srchKey.value    = document.setSrch.srchKey.value;
		if (document.setSrch.srchBgnReg) document.setForm.srchBgnReg.value = document.setSrch.srchBgnReg.value;
		if (document.setSrch.srchEndReg) document.setForm.srchEndReg.value = document.setSrch.srchEndReg.value;
		
		document.setForm.page.value = 1;
		document.setForm.method = 'post';	
		document.setForm.action = 'list.brd';
		document.setForm.submit();
		return false;
	},
	next : function( page ) {
		document.setForm.page.value = page;
		document.setForm.method = 'post';
		document.setForm.action = 'list.brd';
		document.setForm.submit();
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 목록화면에서 '더보기' 기능
	// 현재 페이지의 다음 페이지 목록을 요청하여, 현재 목록화면에 덧붙일 때 사용.
	// 2012.07.05.KWShin.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	more : function () {
		var moreBtn = document.getElementById("moreBtn");
		moreBtn.setAttribute ("page", parseInt(moreBtn.getAttribute("page")) + 1);
		document.setForm.page.value = moreBtn.getAttribute("page");
		
		var htmlData = ebUtil.loadXMLDoc("TEXT", "POST", ebUtil.getContextPath()+"/board/more.brd", ebUtil.completeParam (document.setForm, "dm=dm"))

		var listDiv = document.getElementById("listDiv");
		var tagLi = document.createElement("li");
		tagLi.style.listStyleType = "none";
		tagLi.style.padding = "0px 5px 0px 5px";
		tagLi.innerHTML = htmlData;
		listDiv.appendChild (tagLi);
		
		var page      = parseInt(moreBtn.getAttribute("page"));
		var totalPage = parseInt(moreBtn.getAttribute("totalPage"));
		if (page == totalPage) {
			var moreLi = document.getElementById("moreLi");
			moreLi.innerHTML = "";
		}
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 목록화면에서 '좋아요' 기능
	// 읽기화면에서 '추천/반대' 기능에서 '추천'을 클릭할 때와 동일.
	// 단, 목록화면에서 이루어지므로 서브밋의 결과를 '_blank'로 날려버림.
	// '좋아요' 건수를 보여주고 있다면, 그 건수에 해당하는 스트링을 담고 있는 객체를 cntFld 로 넘겨주면
	// 그 스트링에 1을 더하여 다시 뿌려준다.
	// 2012.07.06.KWShin.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	like : function (bltnNo, objFld, objCntFld) {
		
		if (!confirm (ebUtil.getMessage ('eb.info.confirm.like'))) return;

		document.setForm.bltnNo.value    = bltnNo;
		document.setForm.rtnBltnNo.value = bltnNo;
		document.setForm.cmd.value = "UP";
		
		var param = ebUtil.completeParam (document.setForm, "dm=dm");
		ebUtil.loadXMLDoc ("TEXT", "POST", ebUtil.getContextPath()+"/board/eval.brd", param);
		
		if (objFld) {
			objFld.innerHTML = "좋아했음";
		}
		if (objCntFld) {
			objCntFld.innerHTML = ebUtil.getNumWithComma (""+(parseInt(ebUtil.discardNonNum (objCntFld.innerHTML))+1));
		}
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 검색창 보였다 안보였다.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	showSrchForm : function() {
		var display = document.getElementById('divSrch').style.display;	
		if (display == '')
			document.getElementById('divSrch').style.display = 'none';
		else {
			document.getElementById('divSrch').style.display = '';
			document.setSrch.srchKey.focus();
		}
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 검색결과 화면에서 다시 '검색' 버튼이 눌렸을 때.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	disableSrch : function() {
	    window.open( 'list.brd?boardId='+document.setForm.cmpBrdId.value+'&wallUserId='+document.setForm.wallUserId.value, '_self' );
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 검색창에서 검색대상(제목/글쓴이/내용) 선택하기.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	selectSrchTrgt : function( trgt ) {
		var path = document.setForm.boardSkinDflt.value;
		
		document.getElementById('imgSubj').src = './images/board/skin/'+path+'/imgSubjOff.gif';
		document.getElementById('imgNm').src = './images/board/skin/'+path+'/imgNmOff.gif';
		document.getElementById('imgCntt').src = './images/board/skin/'+path+'/imgCnttOff.gif';
		
		obj = document.getElementById(trgt);
		obj.src = './images/board/skin/'+path+'/' +trgt+ 'On.gif';
		document.setSrch.srchTrgt.value = trgt;
	},
	writeBulletin : function() {
		document.setForm.method = 'post';
		document.setForm.cmd.value = 'WRITE';
		document.setForm.action = 'edit.brd';
		document.setForm.submit();
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 목록보기 화면 하단에서 카테고리를 선택하였을 때. 카테고리 검색.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	cateList : function(cid) {
		document.setForm.bltnCateId.value = cid;
		document.setForm.method = 'post';
		document.setForm.action = 'list.brd';
		document.setForm.submit();
	},
	
	showPwForm2 : function (boardId, bltnNo) {
		var cntt = "";
		cntt += "  <form name=setPass onsubmit='ebList.validatePassword2();return false;'>";
		cntt += "  <table width=200 height=24 cellpadding=0 cellspacing=0 border=1 bordercolor=white bordercolorlight=#99a9bc bordercolordark=#eeeeee>";
		cntt += "    <tr>";
		cntt += "      <td align=center>";
		cntt += "        비밀번호: <input type=password name=userPass style=height:18px;width:120>";
		cntt += "        <input type=hidden name=boardId>";
		cntt += "        <input type=hidden name=bltnNo>";
		cntt += "      </td>";
		cntt += "    </tr>";
		cntt += "  </table>";
		cntt += "  </form>";
		ebUtil.getPopupDialog().initModal (200,24);
		ebUtil.getPopupDialog().showModal (cntt);

		document.setPass.boardId.value = boardId;
		document.setPass.bltnNo.value = bltnNo;
		document.setPass.userPass.focus();
	},
	validatePassword2 : function() {
		if (!ebUtil.chkValue (document.setPass.userPass, ebUtil.getMessage('eb.info.ttl.o.password'), 'true')) return false;
		document.setForm.userPass.value = document.setPass.userPass.value;
		ebList.readBulletin (document.setPass.boardId.value, document.setPass.bltnNo.value, true);
		ebUtil.getPopupDialog().remove();
		return false;
	},
	
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 목록에서 제목을 선택하였을때 Link. 목록보기 화면에서 하단 '동시보기' 버튼을 클릭하였을 때 Link 처리.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	readBulletin : function( boardId, bltnNo, flag ) {
		if( flag==false) {
			ebList.showPwForm2( boardId, bltnNo);
			return;
		}
		var listOpt = "";
		try {
			listOpt = document.setForm.listOpt.value;
		} catch (e) {
			// silent
		}

		if (listOpt != null && listOpt.length > 0 ) {
			
			document.setForm.boardId.value = boardId;
			document.setForm.bltnNo.value = bltnNo;
			document.setForm.cmd.value = 'READ';

			if (document.setForm.miniTrgtWin.value == 'popup') {
				var param = ebUtil.completeParam(document.setForm, '');
				window.open ('read.brd?'+param, "ebMini", "height=600,width=800,scrollbars=yes,status=no,resizable=yes");
			} else {
				document.setForm.target = document.setForm.miniTrgtWin.value;
				document.setForm.action = document.setForm.miniTrgtUrl.value;
				document.setForm.submit();
			}


		} else {
			if( bltnNo < 0 ) { // 하단에서 동시보기를 클릭한 경우. bltnNo 에 -1 이 넘어온다.
				var isOne = true;
				var checkeditems = '';
				var obj = document.getElementsByName('box');
		
				for(var i =0; i < obj.length; i++) {
					isOne = false;
					if (obj[i].getAttribute('checkeditem') == 'Y')
						checkeditems += obj[i].getAttribute('value')+';';
				}
		
				if (isOne) {
					if (obj.length > 0 && obj.getAttribute('checkeditem') == 'Y')
						checkeditems = obj.getAttribute('value')+';';
				}
		
				if (checkeditems == '') {
					//alert('한번에 보실 글(동시보기할 글)을 선택해 주십시요.');
					alert(ebUtil.getMessage('eb.info.select.multiBltn'));
					return;
				}
		
				document.setForm.bltnNo.value = checkeditems;
			} else {
				document.setForm.bltnNo.value = bltnNo;
			}
			
			document.setForm.method = 'post';
			document.setForm.boardId.value = boardId;
			document.setForm.cmd.value = 'READ';
			document.setForm.action = 'read.brd';
			document.setForm.submit();
		}
	},
	/**
	 * 2014. 06. 23 추가: sns에서 게시물 보기
	 */
	toggleBulletin : function(boardId, bltnNo){
		var bltnCnttRow = document.getElementById('bltnCntt_' + boardId + '_' + bltnNo);
		if(bltnCnttRow.style.display == 'block'){
			bltnCnttRow.style.display = 'none';
			document.getElementById('bltnToggle_' + boardId + '_' + bltnNo).innerHTML = '＞';
		}else {
			bltnCnttRow.style.display = 'block';
			document.getElementById('bltnToggle_' + boardId + '_' + bltnNo).innerHTML = '∨';
		}
		
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 다문항설문에서 설문참여하기 버튼을 눌렀을 때 처리.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	actionPoll : function  (cmd, boardId, bltnNo, seq) {
		if (cmd == "poll-multi" && confirm(ebUtil.getMessage("eb.info.confirm.vote"))) {
			
			for (var i=1; i<=parseInt(document.pollForm.totalBltns.value); i++) {
				//var poll = document.getElementsByName("poll"+i);
				var poll = document.getElementById("poll"+i);
				var pollReply = document.getElementById("pollReply"+i);
				var pollMultiSelect = document.getElementById("pollMultiSelect"+i);
				var checkCnt = 1;
				if( pollMultiSelect) {
					checkCnt = pollMultiSelect.value;
				}
				
				if (poll && pollReply) {
					if (!ebUtil.chkCheckCnt(document.getElementsByName("poll"+i), checkCnt, ebUtil.getMessage("eb.info.ttl.o.pollCntt"), "true")) return; // 답변항목을
					var polls = document.getElementsByName("poll"+i);
					for (var j=0; j<polls.length; j++) {
						if (polls[j].checked && polls[j].value == pollReply.getAttribute("pollSeq")) {
							// 선택형과 서술형이 답변항목이 혼재된 설문문항에서 서술형항목이 선택되었을 때
							if (!ebUtil.chkValue(document.getElementById("pollReply"+i), ebUtil.getMessage("eb.info.ttl.o.pollReply"), "true")) return; // 서술형 답변을
						}
					}
				} else {
					if (poll) {
						//poll = document.getElementsByName("poll"+i);
						if (!ebUtil.chkCheckCnt(document.getElementsByName("poll"+i), checkCnt, ebUtil.getMessage("eb.info.ttl.o.pollCntt"), "true")) return; // 답변항목을
					} else if (pollReply) {
						if (!ebUtil.chkValue(document.getElementById("pollReply"+i), ebUtil.getMessage("eb.info.ttl.o.pollReply"), "true")) return; // 서술형 답변을
					}
				}
			}
			document.pollForm.cmd.value = "POLL-MULTI";
			document.pollForm.action = "poll.brd";		
			document.pollForm.submit();
		} else if (cmd == "selTA") {
			var polls = document.getElementsByName("poll"+seq);
			var pollReply = document.getElementById("pollReply"+seq);
			if (polls) { // 선택형과 서술형 답변항목이 혼재한 문항에서는 서술형 답변에 focus가 가면 선택형 답변을 선택해제 한다.
				for (var i=0; i<polls.length; i++) {
					// 체크박스인 경경우(다중선택인 경우) 체크를 해지 하지 않는다.
					if (polls[i].checked && polls[i].type!='checkbox' && polls[i].value != pollReply.getAttribute("pollSeq")) polls[i].checked = false;
					if (!(polls[i].checked) && polls[i].value == pollReply.getAttribute("pollSeq")) polls[i].checked = true;
				}
			}
		} else if (cmd == "showInsR") { // 결과보기 화면에서 서술형답변결과목록보기
			var urlStr = "poll.brd?cmd=INS-RSLT&boardId="+boardId+"&bltnNo="+bltnNo+"&pollSeq="+seq+"&listSetSize=5";
			window.open(urlStr, "_blank","width=380,resizable=yes");
		} else if (cmd == "rslt") { // 결과보기 화면에서 서술형답변결과목록보기
			var urlStr = "poll.brd?cmd=RSLT&boardId="+boardId;
			window.open(urlStr, "_blank");
		}
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 목록화면에서 '저장' 버튼을 눌렀을 때.
	// 이 함수는 목록화면(list)에 편집폼(setTransfer/editForm)이 포함되어 있는 경우에만 정상적으로 동작한다.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	saveOnList : function (rtnURI) {
		if (document.setTransfer.cmd.value.length == 0) { // cmd가 아직 할당 안 된 경우에는 "WRITE"(글쓰기모드)를 할당해준다.
			document.setTransfer.cmd.value = "WRITE";
		}
		ebEdit.save (rtnURI);
	},
	securityOnList : function(cmd, bltnNo, flag) {
		if (flag) {
			this.actionOnList (cmd, bltnNo)
		} else {
			this.showPwForm (cmd, bltnNo);
		}
	},
	showPwForm : function (cmd, bltnNo) {
		var cntt = "";
		cntt += "  <form name=setPass onsubmit='return ebList.validatePassword()'>";
		cntt += "  <table width=200 height=24 cellpadding=0 cellspacing=0 border=1 bordercolor=white bordercolorlight=#99a9bc bordercolordark=#eeeeee>";
		cntt += "    <tr>";
		cntt += "      <td align=center>";
		cntt += "        비밀번호: <input type=password id=userPass name=userPass style=height:18px;width:120>";
		cntt += "        <input type=hidden name=cmd>";
		cntt += "        <input type=hidden name=bltnNo>";
		cntt += "      </td>";
		cntt += "    </tr>";
		cntt += "  </table>";
		cntt += "  </form>";
		ebUtil.getPopupDialog().initModal (200,24);
		ebUtil.getPopupDialog().showModal (cntt);

		document.setPass.cmd.value = cmd;
		document.setPass.bltnNo.value = bltnNo;
		document.setPass.userPass.focus();
	},
	validatePassword : function() {
		if (!ebUtil.chkValue (document.setPass.userPass, ebUtil.getMessage('eb.info.ttl.o.password'), 'true')) return false;
		document.setForm.userPass.value = document.setPass.userPass.value;
		this.securityOnList (document.setPass.cmd.value, document.setPass.bltnNo.value, true);
		ebUtil.getPopupDialog().remove();
		return false;
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 목록화면에서 읽기화면에서 벌어지는 동작이 벌어졌을 때.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	actionOnList : function(cmd, bltnNo, bestLev) {
		if (cmd == 'reply') {

			// 답글의 원본글 내역을 상단의 편집필드 위쪽에 복사해서 보여주고, 기타 장식을 꾸민다.
			if (document.getElementById("rootBltnViewTitle")) document.getElementById("rootBltnViewTitle").innerHTML = "<font color=red><b>원본글</b></font>";
			if (document.getElementById("rootBltnView"))      document.getElementById("rootBltnView").innerHTML      = document.getElementById("rootBltnCntt"+bltnNo).innerHTML;
			if (document.getElementById("editFormTitle"))     document.getElementById("editFormTitle").innerHTML     = "<font color=red><b>답글</b></font>";
			if (document.getElementById("rootBltnCnttButtons"+bltnNo)) document.getElementById("rootBltnCnttButtons"+bltnNo).style.display = "none";
			try {
				FCKeditorAPI.GetInstance('editorCntt').SetData("");
			} catch (ex) {
				// FCKeditor 를 사용하지 않는 경우에는...
				document.getElementById("editorCntt").value = "";
			}
			var lines = document.getElementsByName("rootBltnViewLine");
			for (var i=0; i<lines.length; i++) lines[i].style.display = ""; 
			var spaces = document.getElementsByName("rootBltnViewSpaces");
			for (var i=0; i<spaces.length; i++) spaces[i].style.display = ""; 
			
			// 카페의 컨텐츠영역에 들어 있는 경우, iframe의 크기를 재조정하여준다.
			if (parent.cafe_cntt_iframe_autoresize) parent.cafe_cntt_iframe_autoresize();
			
			// '저장'시 SUBMIT이 되는 FORM에 필요한 데이터를 할당해주고,
			document.setTransfer.bltnNo.value = bltnNo;
			document.setTransfer.cmd.value = "REPLY";
			// 커서를 편집필드로 옮겨준다.
			document.editForm.editorCntt.focus();
		
		} else if (cmd == 'modify') {

			// 수정하고자 하는 원본글 내역을 상단의 편집필드 위쪽에 복사해서 보여주고, 기타 장식을 꾸민다.
			if (document.getElementById("rootBltnViewTitle")) document.getElementById("rootBltnViewTitle").innerHTML = "<font color=red><b>원본글</b></font>";
			if (document.getElementById("rootBltnView"))      document.getElementById("rootBltnView").innerHTML      = document.getElementById("rootBltnCntt"+bltnNo).innerHTML;
			if (document.getElementById("editFormTitle"))     document.getElementById("editFormTitle").innerHTML     = "<font color=red><b>수정</b></font>";
			if (document.getElementById("rootBltnCnttButtons"+bltnNo)) document.getElementById("rootBltnCnttButtons"+bltnNo).style.display = "none";
			try {
				FCKeditorAPI.GetInstance('editorCntt').SetData(document.getElementById("bltnCntt"+bltnNo).value);
			} catch (ex) {
				// FCKeditor 를 사용하지 않는 경우에는...
				document.getElementById("editorCntt").value = document.getElementById("bltnCntt"+bltnNo).value;
			}

			var lines = document.getElementsByName("rootBltnViewLine");
			for (var i=0; i<lines.length; i++) lines[i].style.display = ""; 
			var spaces = document.getElementsByName("rootBltnViewSpaces");
			for (var i=0; i<spaces.length; i++) spaces[i].style.display = ""; 
			
			// 카페의 컨텐츠영역에 들어 있는 경우, iframe의 크기를 재조정하여준다.
			if (parent.cafe_cntt_iframe_autoresize) parent.cafe_cntt_iframe_autoresize();
			
			// '저장'시 SUBMIT이 되는 FORM에 필요한 데이터를 할당해주고,
			document.setTransfer.bltnNo.value = bltnNo;
			document.setTransfer.cmd.value = "MODIFY";
			// 커서를 편집필드로 옮겨준다.
			document.editForm.editorCntt.focus();
		
		} else if (cmd == 'delete' && confirm(ebUtil.getMessage('eb.info.confirm.del'))) {
			document.setForm.bltnNo.value = bltnNo;
			document.setForm.method = "post";
			document.setForm.cmd.value = "DELETE";
			document.setForm.action = "save.brd";		
			document.setForm.submit();
		} else if (cmd == 'cancel') {
			if (document.getElementById("rootBltnViewTitle")) document.getElementById("rootBltnViewTitle").innerHTML = "";
			if (document.getElementById("rootBltnView"))      document.getElementById("rootBltnView").innerHTML      = "";
			if (document.getElementById("editFormTitle"))     document.getElementById("editFormTitle").innerHTML     = "";
			var lines = document.getElementsByName("rootBltnViewLine");
			for (var i=0; i<lines.length; i++) lines[i].style.display = "none"; 
			var spaces = document.getElementsByName("rootBltnViewSpaces");
			for (var i=0; i<spaces.length; i++) spaces[i].style.display = "none"; 
			
			// 카페의 컨텐츠영역에 들어 있는 경우, iframe의 크기를 재조정하여준다.
			if (parent.cafe_cntt_iframe_autoresize) parent.cafe_cntt_iframe_autoresize('cafeBoardFrame');
			
			document.setTransfer.bltnNo.value = "";
			document.setTransfer.cmd.value = "";
			try {
				FCKeditorAPI.GetInstance('editorCntt').SetData("");
			} catch (ex) {
				// FCKeditor 를 사용하지 않는 경우에는...
				document.getElementById("editorCntt").value = "";
				// 커서를 편집필드로 옮겨준다.
				document.editForm.editorCntt.focus();
			}
		}
	},
	showExcelForm : function (cmd) {
		if (cmd) {
			var cntt = ebUtil.loadXMLDoc ("TEXT", "POST", ebUtil.getContextPath()+"/board/excel.brd", ebUtil.completeParam (document.setForm, "view=XSLSEL"));
			ebUtil.getPopupDialog().initModal (null,null,"#FFFFFF");
			ebUtil.getPopupDialog().showModal (cntt);
		} else {
			ebUtil.getPopupDialog().remove();
		}
	},	
	downloadExcel : function (cmd) {
		var frm = document.frmScope;
		frm.method ='POST';
		frm.action = ebUtil.getContextPath()+"/board/excel.brd?view=XSLOUT&cmd="+cmd;
		frm.target = 'download';
		frm.submit();
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 갤러리형 게시판 목록화면에서 이미지 파일 로드 시 화면 크기 구성에 맞게 이미지의 크기를 조정.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	imageResize : function (elm,w,h) {
		ebUtil.imageResize (elm,w,h);
	},
	showFeedURL : function (cmd) {
		if (cmd == 'close') {
			ebUtil.getPopupDialog().remove();
			ebUtil.eventSet(document); // 풀었던 것을 원복한다.2012.08.09.KWShin.
		} else {
			var offset = location.href.indexOf(location.host) + location.host.length;
			var urlStr = location.href.substring(0,offset);
			urlStr += ebUtil.getContextPath();
			urlStr += "/board/"+cmd.toLowerCase()+".brd?boardId="+document.setForm.boardId.value;
			
			var cntt = "";
			cntt += "<table style=margin:10px>";
			cntt += "  <tr height=30>";
			cntt += "    <td align=left>";
			cntt += "      URL을 복사하여 "+cmd.toUpperCase()+" 뷰어에 등록하십시오.";
			cntt += "    </td>";
			cntt += "    <td align=right>";
			cntt += "      <font style=cursor:pointer onclick=ebList.showFeedURL('close')><b>X</b></font>";
			cntt += "    </td>";
			cntt += "  </tr>";
			cntt += "  <tr height=30>";
			cntt += "    <td align=left colspan=2>";
			cntt += "      <input type=text value='"+urlStr+"' size=70>";
			cntt += "    </td>";
			cntt += "  </tr>";
			cntt += "</table>";

			ebUtil.getPopupDialog().initModal (null,null,"#FFFFFF");
			ebUtil.getPopupDialog().showModal (cntt);
			ebUtil.eventReset(document); // ULR을 복사해야 하므로 잠시 푼다.2012.08.09.KWShin.
		}
	},
	xmlBulletin : function () {
		document.setForm.method = 'post';
		document.setForm.action = 'xml.brd';
		document.setForm.submit();
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// 만족도 조사. Draft.
// 2010.02.19. KWShin. Saltware.
///////////////////////////////////////////////////////////////////////////////////////////////////
function saveRcmd(frm) {
	if (!confirm("만족도조사에 참여하시겠습니까?")) return;
	var pntElms = document.getElementsByName("pnt");
	var chk = false;
	for (var i=0; i<pntElms.length; i++) {
		if (pntElms[i].checked) chk = true;
	}
	if (!chk) {
		alert("점수를 선택해 주십시오");
		return;
	}
	
	var	respText = loadXMLDoc("TEXT", "POST", "/enboard/bltnMngr", completeParam(frm, "cmd=cnttRcmd&reTag=Y"));
	
	if (respText == "OK!") {
		alert("만족도조사에 정상적으로 참여하셨습니다.\n참여해 주셔서 감사합니다.");
	} else if (respText == "notLogined") {
		alert("만족도조사에 참여하시려면 먼저 로그인하셔야 합니다.");
	} else if (respText == "systemError") {
		alert("죄송합니다. 만족도조사 처리 중 오류가 발생하였습니다.\n잠시 후 다시 시도해보시기 바랍니다.");
	} 
}

var ebList = new enboard.list();
var enLangKnd = "ko";
//-->