<!--
if( ! window.enboard )
	window.enboard = new Object();
if( ! ebUtil )
	var ebUtil = new enboard.util();
	
enboard.read = function() {}

enboard.read.prototype = {
	initRead : function() {
		ebRead.loadAnchors();
		ebRead.loadDisabled();
		ebRead.imageResize();
		adminEventFree(window);
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 설문형 게시판에서 설문결과를 보여주는 막대그래프의 길이를 설정하여준다.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	loadPoll : function() {
		var obj = document.getElementsByName('pollC');
		var len = obj.length;

		for( var i=0; i<len; i++ ) 
			obj[i].style.width = document.getElementsByName('pollGraphSize')[i].value;
	},
	actionSecurity : function(cmd, bltnNo, flag) {
		if (flag) {
			this.actionBulletin(cmd, bltnNo)
		} else {
			this.showPwForm(cmd, bltnNo);
		}
	},
	showBadBltnForm : function (cmd, boardId, bltnNo) {
		if (cmd == "true") {
			var param = "view=main";
			param += "&boardId="+boardId;
			param += "&bltnNo="+bltnNo;
			
			var cntt = ebUtil.loadXMLDoc ("TEXT", "POST", ebUtil.getContextPath()+"/board/badBltn.brd", param);
			
			ebUtil.getPopupDialog().initModal (600,100);
			ebUtil.getPopupDialog().showModal (cntt);
		} else {
			ebUtil.getPopupDialog().remove();
		}
	},
	showPwForm : function (cmd, bltnNo) {
		var cntt = "";
		cntt += "  <form name=setPass onsubmit='return ebRead.validatePassword()'>";
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
		this.actionSecurity (document.setPass.cmd.value, document.setPass.bltnNo.value, true);
		ebUtil.getPopupDialog().remove();
		return false;
	},
	actionBulletin : function(cmd, bltnNo, bestLev) {

		if (cmd == 'search') {
			window.history.back();
			return;
		
		} else if (cmd == 'list') {
			document.setForm.method = "post";
			document.setForm.action = "list.brd";		
			document.setForm.submit();
		
		} else if (cmd == 'write') {
			ebList.writeBulletin();
		
		} else if (cmd == 'reply') {
			document.setForm.bltnNo.value = bltnNo;
			document.setForm.method = "post";
			document.setForm.cmd.value = "REPLY";
			document.setForm.action = "edit.brd";		
			document.setForm.submit();
		
		} else if (cmd == 'modify') {
			document.setForm.bltnNo.value = bltnNo;
			document.setForm.method = "post";
			document.setForm.cmd.value = "MODIFY";
			document.setForm.action = "edit.brd";		
			document.setForm.submit();
		
		} else if (cmd == 'delete' && confirm(ebUtil.getMessage('eb.info.confirm.del'))) {
			document.setForm.bltnNo.value = bltnNo;
			document.setForm.method = "post";
			document.setForm.cmd.value = "DELETE";
			document.setForm.action = "save.brd";		
			document.setForm.submit();
		} else if (cmd == 'bad-bltn' && confirm(ebUtil.getMessage('eb.info.confirm.report'))) {	//게시물 신고
			document.setForm.bltnNo.value = bltnNo;
			document.setForm.memoSeq.value = 0;
			document.setForm.method = "post";
			document.setForm.cmd.value = "BAD-BLTN";
			document.setForm.action = "memo.brd";
			document.setForm.userNick.value = document.badBltnForm.userNick.value;
			document.setForm.memoCntt.value = document.badBltnForm.badBltnCntt.value;
			document.setForm.rtnURI.value = "read.brd";
			document.setForm.befCmd.value = "READ";
			document.setForm.submit();
		} else if (cmd == 'write-memo') {
			var badNick = document.setForm.badNickDflt.value;
			var badCntt = document.setForm.badCnttDflt.value;

			var objNick = eval('document.memoForm_'+bltnNo+'.userNick');
			if( objNick ) {
				if (!ebUtil.chkValue( objNick, ebUtil.getMessage('eb.info.ttl.o.name'), 'true')) return;
				if (!ebUtil.chkBadCntt( objNick, ebUtil.getMessage('eb.info.ttl.name'), badNick, 'true')) return;
			}
			var objCntt = eval('document.memoForm_'+bltnNo+'.memoCntt');
			if( !ebUtil.chkValue( objCntt, ebUtil.getMessage('eb.info.ttl.o.memo'), 'true')) return;
			if( !ebUtil.chkBadCntt( objCntt, ebUtil.getMessage('eb.info.ttl.memo'), badCntt, 'true')) return;
			
			// 내용의 maxlenth를 체크한다
			if( !ebUtil.checkLength1(objCntt)) {
				return;
			}
			
			document.setForm.bltnNo.value = bltnNo;
			document.setForm.method = "post";
			document.setForm.cmd.value = "WRITE";
			document.setForm.action = "memo.brd";
			document.setForm.userNick.value = objNick.value;
			document.setForm.memoCntt.value = objCntt.value;
			document.setForm.submit();
		
		} else if (cmd == 'reply-init-memo') {
			var mbltnNo = bltnNo.split(";");
			var divs = document.getElementsByTagName('div');
			for( var i=0; i<divs.length; i++) {
				if( divs[i].id.indexOf('memoReplyDiv') != -1) {
					if( divs[i].id == "memoReplyDiv_"+mbltnNo[0]+"_"+mbltnNo[1] ) {
						divs[i].style.display = "";
					} else {
						divs[i].style.display = "none";
					}
				}
			}
			var objCntt = eval('document.memoReplyForm_'+mbltnNo[0]+'_'+mbltnNo[1]+'.memoCntt');
			objCntt.value = '';
			var objRorm = eval('document.memoReplyForm_'+mbltnNo[0]+'_'+mbltnNo[1]+'.rorm');
			objRorm.value = 'REPLY';
		
		} else if (cmd == 'modify-init-memo') {
			var mbltnNo = bltnNo.split(";");
			var divs = document.getElementsByTagName('div');
			for( var i=0; i<divs.length; i++) {
				if( divs[i].id.indexOf('memoReplyDiv') != -1) {
					if( divs[i].id == "memoReplyDiv_"+mbltnNo[0]+"_"+mbltnNo[1] ) {
						divs[i].style.display = "";
					} else {
						divs[i].style.display = "none";
					}
				}
			}
			var objCntt = eval('document.memoReplyForm_'+mbltnNo[0]+'_'+mbltnNo[1]+'.memoCntt');
			var objOrgCntt = eval('document.memoReplyForm_'+mbltnNo[0]+'_'+mbltnNo[1]+'.memoOrgCntt');
			objCntt.value = objOrgCntt.value;
			var objRorm = eval('document.memoReplyForm_'+mbltnNo[0]+'_'+mbltnNo[1]+'.rorm');
			objRorm.value = 'MODIFY';
		
		} else if (cmd == 'cancel-memo') {
			var mbltnNo = bltnNo.split(";");
			document.getElementById('memoReplyDiv_'+mbltnNo[0]+'_'+mbltnNo[1]).style.display = 'none';
		
		} else if (cmd == 'rorm-memo') {
			var badNick = document.setForm.badNickDflt.value;
			var badCntt = document.setForm.badCnttDflt.value;

			var mbltnNo = bltnNo.split(";");
			var objNick = eval('document.memoReplyForm_'+mbltnNo[0]+'_'+mbltnNo[1]+'.userNick');
			if( objNick ) {
				if( !ebUtil.chkValue( objNick, ebUtil.getMessage('eb.info.ttl.o.name'), 'true')) return;
				if( !ebUtil.chkBadCntt( objNick, ebUtil.getMessage('eb.info.ttl.name'), badNick, 'true')) return;
			}
			var objCntt = eval('document.memoReplyForm_'+mbltnNo[0]+'_'+mbltnNo[1]+'.memoCntt');
			if( !ebUtil.chkValue( objCntt, ebUtil.getMessage('eb.info.ttl.o.memo'), 'true')) return;
			if( !ebUtil.chkBadCntt( objCntt, ebUtil.getMessage('eb.info.ttl.memo'), badCntt, 'true')) return;

			// 내용의 maxlenth를 체크한다
			if( !ebUtil.checkLength1(objCntt)) {
				return;
			}
			
			var objRorm = eval('document.memoReplyForm_'+mbltnNo[0]+'_'+mbltnNo[1]+'.rorm');

			document.setForm.bltnNo.value  = mbltnNo[0];
			document.setForm.memoSeq.value = mbltnNo[1];
			document.setForm.method = "post";
			document.setForm.cmd.value = objRorm.value;
			document.setForm.action = "memo.brd";
			document.setForm.userNick.value = objNick.value;
			document.setForm.memoCntt.value = objCntt.value;
			document.setForm.submit();
		
		} else if (cmd == 'login-memo') {
			document.setForm.bltnNo.value = bltnNo;
			document.setForm.method = "post";
			document.setForm.action = "login.do";
			document.setForm.rtnURI.value = "read.brd?boardId="+document.setForm.boardId.value+"&bltnNo="+bltnNo+"&cmd=READ&page=1&categoryId=-1";
			document.setForm.submit();
		
		} else if (cmd == 'delete-memo' && confirm(ebUtil.getMessage('eb.info.confirm.del'))) {
			var mbltnNo = bltnNo.split(";");
			document.setForm.bltnNo.value = mbltnNo[0];
			document.setForm.memoSeq.value = mbltnNo[1];
			document.setForm.method = "post";
			document.setForm.cmd.value = "DELETE";
			document.setForm.action = "memo.brd";		
			document.setForm.submit();
		
		} else if (cmd == 'bad-memo' && confirm(ebUtil.getMessage('eb.info.confirm.report'))) {
			var mbltnNo = bltnNo.split(";");
			document.setForm.bltnNo.value = mbltnNo[0];
			document.setForm.memoSeq.value = mbltnNo[1];
			document.setForm.method = "post";
			document.setForm.cmd.value = "BAD";
			document.setForm.action = "memo.brd";		
			document.setForm.rtnURI.value = "read.brd";
			document.setForm.befCmd.value = "READ";
			document.setForm.submit();

		} else if (cmd == 'permit_yes' && confirm(ebUtil.getMessage('eb.info.confirm.permit'))) {
			document.setForm.bltnNo.value = bltnNo;
			document.setForm.cmd.value = "PERMIT";
			document.setForm.action = "permit.brd";		
			document.setForm.submit();

		} else if (cmd == 'permit_no' && confirm(ebUtil.getMessage('eb.info.confirm.prohibit'))) {
			document.setForm.bltnNo.value = bltnNo;
			document.setForm.cmd.value = "PROHIBIT";
			document.setForm.action = "permit.brd";		
			document.setForm.submit();	
		
		} else if (cmd == 'eval-up' && confirm(ebUtil.getMessage('eb.info.confirm.recommend'))) {
			document.setForm.bltnNo.value = bltnNo;
			document.setForm.cmd.value = "UP";
			document.setForm.action = "eval.brd";		
			document.setForm.submit();
		
		} else if (cmd == 'eval-dn' && confirm(ebUtil.getMessage('eb.info.confirm.recommend'))) {
			document.setForm.bltnNo.value = bltnNo;
			document.setForm.cmd.value = "DN";
			document.setForm.action = "eval.brd";		
			document.setForm.submit();	
		
		} else if (cmd == 'eval' && confirm(ebUtil.getMessage('eb.info.confirm.recommend'))) {
			var objPnt = document.getElementsByName('pnt');
			var len = objPnt.length;
			for (var i=0; i < len; i++) 
				if (objPnt[i].checked == true) break;
			document.setForm.bltnNo.value = bltnNo;
			document.setForm.cmd.value = "MULTI";
			document.setForm.evalPnt.value = objPnt[i].value;
			document.setForm.action = "eval.brd";		
			document.setForm.submit();	
		
		} else if (cmd == 'poll' && confirm(ebUtil.getMessage('eb.info.confirm.vote'))) {
			var f = eval('document.pollForm_'+bltnNo);
			
			document.setForm.pollSeq.value = '';
			for (var i=0; i<f.poll.length; i++) {
				if (f.poll[i].checked == true)  
					document.setForm.pollSeq.value = f.poll[i].value;
			}

			if (document.setForm.pollSeq.value == '') {
				//alert('투표할 보기를 골라주세요');
				alert(ebUtil.getMessage('eb.info.select.poll'));
				return;
			}
			document.setForm.bltnNo.value = bltnNo;
			document.setForm.cmd.value = "POLL";
			document.setForm.action = "poll.brd";		
			document.setForm.submit();
		} else if (cmd == 'best') {
			var	bestLevStr = '';
			if (bestLev == '9') {
				//bestLevStr = '최우수 답변으로';
				bestLevStr = ebUtil.getMessage('eb.info.ttl.p.bestRspn');
			}
			//var confirmStr = '이 답변을 ' + bestLevStr + ' 선택하시겠습니까?';
			var confirmStr = ebUtil.getMessage('eb.info.confirm.selectRspn', bestLevStr);
			if (confirm(confirmStr)) { 
				document.setForm.bltnNo.value = bltnNo;
				document.setForm.bltnBestLevel.value = bestLev;
				document.setForm.cmd.value = "BEST";
				document.setForm.action = "best.brd";
				document.setForm.submit();
			}
		}	
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 이전글, 다음글 버튼이 눌렸을 때의 처리.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	readPrevNextBltn : function(boardId, bltnNo) {
		document.setForm.boardId.value = boardId;
		document.setForm.bltnNo.value = bltnNo;
		document.setForm.method = 'post';
		document.setForm.cmd.value = 'READ';
		document.setForm.action = 'read.brd';
		document.setForm.submit();
	},
	loadDisabled : function() {
		var dis = document.setForm.memoWritableYn.value;

		if (dis == 'N') {
			for (var i = 0; i < document.forms.length; i++) {
				var f = document.forms[i];
				if (f.name.indexOf('memoForm') > -1) {
					//f.style.display = "none";
					for (var k = 0; k < f.elements.length; k++) {
						if (f.elements[k].name.indexOf('memoCntt') > -1) {
							f.elements[k].style.backgroundColor = '#dddddd';
							f.elements[k].disabled = true;					
						} else if (f.elements[k].name.indexOf('userNick') > -1) {
							f.elements[k].style.backgroundColor = '#dddddd';
							f.elements[k].disabled = true;					
						// 권한이 없는 경우, 버튼을 동작하게 해서 로그인으로 연결하고자 할 때 아래를 막는다.
						//} else if (f.elements[k].name.indexOf('memoBttn') > -1) {
						//	f.elements[k].disabled = true;
						}
					}
				}
			}
		}
	},
	loadAnchors : function() {
		var anchors = document.getElementsByTagName("a");
		for (i = 0; i < anchors.length; i++) {
			if (anchors.item(i).target == '' && anchors.item(i).href != '')
				anchors.item(i).target="_blank";
		}
	},
	imageResize : function() {
		var boardWidth = 650;
		if (document.setForm) {
			boardWidth = document.setForm.boardWidth.value - 20;
		} else if (document.setTransfer) {
			boardWidth = document.setTransfer.boardWidth.value - 20;
		}
		var obj = document.getElementsByName('ebImg');
		for (var i=0; i<obj.length; i++) {
			if (obj[i].width > boardWidth) {
				var scale = boardWidth / obj[i].width;
				var x = Math.ceil(obj[i].width * scale);
				var y = Math.ceil(obj[i].height * scale);
				//alert("boardWidth=["+boardWidth+"],scale=["+scale+"],x=["+x+"],y=["+y+"]");
				obj[i].width  = x;
				obj[i].height = y;
			}
		}
	}
}
var ebRead = new enboard.read();
//-->