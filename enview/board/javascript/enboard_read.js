<!--
if( ! window.enboard )
	window.enboard = new Object();
if( ! ebUtil )
	var ebUtil = new enboard.util();
	
enboard.read = function() {}

enboard.read.prototype = {
	useMemoFile : false,	
	vaultUploader : null,
	limitCount : 10,
	boardId : 'xxx',
	
	vaultUploader2 : null,
	currentUploadFileCnt2 : 0,
	isNewFile2 : false,
	
	initRead : function() {
		ebRead.loadAnchors();
		ebRead.loadDisabled();
		ebRead.imageResize();
		adminEventFree(window);
		
		ebRead.boardId     = document.setForm.boardId.value;
		ebRead.limitCount  = document.setForm.maxMemoFileCnt.value;
		
		ebRead.useMemoFile = document.getElementById("vault_upload") != null ;
		// 업로드 모듈 및 파일 리스트 초기화
		if( ebRead.useMemoFile ) {
			if ( ebRead.vaultUploader == null && ebRead.limitCount > 0) {
				ebRead.vaultUploader = new dhtmlXVaultObject({
				    container:  "vault_upload",             // html container for vault
				    uploadUrl:  "/board/fileMngr?cmd=upload&boardId=" + ebRead.boardId + "&subId=sub01",           // html4/html5 upload url
				    autoStart : false,
				    buttonUpload : false,
				    buttonClear : true
				});
				ebRead.vaultUploader.setHeight(150);
				ebRead.vaultUploader.attachEvent("onBeforeFileAdd", function (file) {
					if (file.size > (ebRead.vaultUploader.getMaxFileSize() / ebRead.limitCount)) {
						alert( ebUtil.getMessage('eb.info.upload.limit.size', (ebRead.vaultUploader.getMaxFileSize() / ebEdit.limitCount) ));
						return false; 
					}
					
					if (ebRead.limitCount <= ebRead.currentUploadFileCnt) {
						alert( ebUtil.getMessage('eb.info.upload.limit.cnt', ebEdit.limitCount ));
						return false; 
					}
					ebRead.currentUploadFileCnt++;
					ebRead.isNewFile = true;
				    return true;
				});
				
				ebRead.vaultUploader.attachEvent("onBeforeFileRemove", function (file) {
					if (file.uploaded == true) {
						/*
						var curDelFileList = file.serverName + "-" + file.size + "|";
						var unDelFileList = "";
						ebEdit.totDelFileList += curDelFileList;
						document.setFileList.vaccum.value   = 'DIRECT';
						document.setFileList.delList.value   = ebEdit.totDelFileList;
						document.setFileList.unDelList.value = unDelFileList;				
						document.setFileList.submit();
						*/
					}
					ebRead.currentUploadFileCnt--;
					// 파일목록이 하나도 없으면 신규 파일이 없음으로 설정 2018.5.3
					if( ebRead.currentUploadFileCnt ==0) {
						ebReadisNewFile = false;
					}
					return true;
				});
				
				ebRead.vaultUploader.attachEvent("onUploadFail", function(file, extra){
					alert(extra.info);
				});
				
				ebRead.vaultUploader.setStrings({
					done:       "업로드됨",     // text under filename in files list
				    error:      "오류발생",    // text under filename in files list
				    btnAdd:     "파일추가",   // button "add files"
				    btnUpload:  "파일업로드",   // button "upload"
				    btnCancel:  "취소",   // button "cancel uploading"
				    btnClean:   "초기화",    // button "clear all"
				 
				    dnd:        "여기에 파일을 놓으세요."   // dnd text while the user is dragging files
				});
			} // if useMemoFile	
		}
		
	},
	
	initVault2 : function () {
		// MODIFY/REPLY
		if ( ebRead.vaultUploader2 == null && ebRead.limitCount > 0) {
			ebRead.vaultUploader2 = new dhtmlXVaultObject({
			    container:  "vault_upload2",             // html container for vault
//			    uploadUrl:  "/dhtmlx/vault/handler/enboard_handler.jsp?boardId=" + ebEdit.boardId + "&subId=sub01",           // html4/html5 upload url
			    uploadUrl:  "/board/fileMngr?cmd=upload&boardId=" + ebRead.boardId + "&subId=sub01",           // html4/html5 upload url
			    autoStart : false,
			    buttonUpload : false,
			    buttonClear : true
			});
			ebRead.vaultUploader2.setHeight(150);
			//ebEdit.vaultUploader.setFilesLimit(ebEdit.limitCount);
			ebRead.vaultUploader2.attachEvent("onBeforeFileAdd", function (file) {
				if (file.size > (ebRead.vaultUploader.getMaxFileSize() / ebRead.limitCount)) {
					alert( ebUtil.getMessage('eb.info.upload.limit.size', (ebRead.vaultUploader.getMaxFileSize() / ebEdit.limitCount) ));
					return false; 
				}
				
				if (ebRead.limitCount <= ebRead.currentUploadFileCnt2) {
					alert( ebUtil.getMessage('eb.info.upload.limit.cnt', ebEdit.limitCount ));
					return false; 
				}
				ebRead.currentUploadFileCnt2++;
				ebRead.isNewFile2 = true;
			    return true;
			});
			
			ebRead.vaultUploader2.attachEvent("onBeforeFileRemove", function (file) {
				if (file.uploaded == true) {
					/*
					var curDelFileList = file.serverName + "-" + file.size + "|";
					var unDelFileList = "";
					ebEdit.totDelFileList += curDelFileList;
					document.setFileList.vaccum.value   = 'DIRECT';
					document.setFileList.delList.value   = ebEdit.totDelFileList;
					document.setFileList.unDelList.value = unDelFileList;				
					document.setFileList.submit();
					*/
				}
				ebRead.currentUploadFileCnt2--;
				// 파일목록이 하나도 없으면 신규 파일이 없음으로 설정 2018.5.3
				if( ebRead.currentUploadFileCnt2 ==0) {
					ebReadisNewFile2 = false;
				}
				return true;
			});
			
			ebRead.vaultUploader2.attachEvent("onUploadFail", function(file, extra){
				alert(extra.info);
			});
			
			ebRead.vaultUploader2.setStrings({
				done:       "업로드됨",     // text under filename in files list
			    error:      "오류발생",    // text under filename in files list
			    btnAdd:     "파일추가",   // button "add files"
			    btnUpload:  "파일업로드",   // button "upload"
			    btnCancel:  "취소",   // button "cancel uploading"
			    btnClean:   "초기화",    // button "clear all"
			 
			    dnd:        "여기에 파일을 놓으세요."   // dnd text while the user is dragging files
			});
		}
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
			
			document.setForm.fileName.value = "";
			document.setForm.fileMask.value = "";
			document.setForm.fileSize.value = "";
			
			if ( ebRead.vaultUploader  != null) {
				ebRead.vaultUploader.attachEvent("onUploadComplete", function (files) {
					var fileList = ebRead.vaultUploader.getData();
					if (files.length > 0) {
						for (var i = 0 ; i < fileList.length ; i++) {
							document.setForm.fileName.value += fileList[i].name + "|";
							document.setForm.fileMask.value += fileList[i].serverName + "|";
							document.setForm.fileSize.value += fileList[i].size + "|";
						}
					}
					ebRead.isNewFile = false;
					ebRead.isCancel = false;
					document.setForm.submit();
				});
			};
			
			if (ebRead.isNewFile) {
				ebRead.vaultUploader.upload();
			} else {
				document.setForm.submit();
			}
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
			
			if( ebRead.useMemoFile) {
				// init vault_upload2 if not inited
				ebRead.initVault2();
				// clear file list
				ebRead.vaultUploader2.clear();
				var vu2 = document.getElementById("vault_upload2");
				vu2.parentNode.removeChild( vu2);
				
				var vu2c = document.getElementById('memoReplyFileContainer_'+mbltnNo[0]+'_'+mbltnNo[1]);
				vu2c.appendChild( vu2);
			}
		
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
			
			if( ebRead.useMemoFile) {
				// init vault_upload2 if not inited
				ebRead.initVault2();
				// clear file list
				ebRead.vaultUploader2.clear();
				var vu2 = document.getElementById("vault_upload2");
				vu2.parentNode.removeChild( vu2);
				
				var vu2c = document.getElementById('memoReplyFileContainer_'+mbltnNo[0]+'_'+mbltnNo[1]);
				vu2c.appendChild( vu2);

				var fileNameAry = eval('document.memoReplyForm_'+mbltnNo[0]+'_'+mbltnNo[1]+'.fileName').value.split("|");
				var fileSizeAry = eval('document.memoReplyForm_'+mbltnNo[0]+'_'+mbltnNo[1]+'.fileSize').value.split("|");
				var fileMaskAry = eval('document.memoReplyForm_'+mbltnNo[0]+'_'+mbltnNo[1]+'.fileMask').value.split("|");
				for( var i=0; i < fileNameAry.length;i++) {
					if( fileNameAry[i] =='') continue;
					var fileInfo = {
							name : fileNameAry[i],
							serverName : fileMaskAry[i],
							size : fileSizeAry[i]
						};
					ebRead.vaultUploader2.addFileRecord(fileInfo, "uploaded");
				}
			}
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
			
			document.setForm.fileName.value = "";
			document.setForm.fileMask.value = "";
			document.setForm.fileSize.value = "";
			
			if ( ebRead.vaultUploader2  != null) {
				ebRead.vaultUploader2.attachEvent("onUploadComplete", function (files) {
					var fileList = ebRead.vaultUploader2.getData();
					if (files.length > 0) {
						for (var i = 0 ; i < fileList.length ; i++) {
							document.setForm.fileName.value += fileList[i].name + "|";
							document.setForm.fileMask.value += fileList[i].serverName + "|";
							document.setForm.fileSize.value += fileList[i].size + "|";
						}
					}
					ebRead.isNewFile2 = false;
					ebRead.isCancel2 = false;
					document.setForm.submit();
				});
			}
			
			if (ebRead.isNewFile2) {
				ebRead.vaultUploader2.upload();
			} else {
				document.setForm.submit();
			}
			
			
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