<!--
if( ! window.enboard )
    window.enboard = new Object();
if( ! ebUtil )
	var ebUtil = new enboard.util();
var oEditors = [];

enboard.edit = function() {
	this.boardId     = '';
	this.limitCount  = 0;
	this.badNick     = '';
	this.badCntt     = '';
	this.maxPoint    = 0;
	this.cmd         = '';
	this.totFileSize = 0;
	this.sizeSF      = '';
	this.skin        = 'default';
	this.limitSize   = 0;
	this.thumbSize   = 0;

	this.isCancel    = true;
	this.fileList    = '';
	this.pollSeq     = 0;
	this.totDelFileList = '';
	this.ie          = true;

	this.ebSessionKeepTimeoutID = "";
	this.ebUploadStatusTimeoutID = "";
	this.ebUploadStatusSemaphore = "";
}
enboard.edit.prototype = {

	boardId     : null,
	boardRid    : null,
	limitCount  : null,
	badNick     : null,
	badCntt     : null,
	maxPoint    : null,
	cmd         : null,
	totFileSize : null,
	sizeSF      : null,
	skin        : null,
	limitSize   : null,
	thumbSize   : null,

	isCancel    : null,
	fileList    : null,
	pollSeq     : null, // 설문 갯수
	totDelFileList : null, // 업로드된 파일 목록에서 빼온 삭제한다고 선택된 파일 목록 
	ie          : null,
	WinPreview  : null, // 미리보기 플래그

	ebSessionKeepTimeoutID : null, // Session 유지를 위한 타임아웃ID
	
	accSetMngr  : null,
	jweditor    : null,
	smarteditor : null,
	vaultUploader : null,			// DHTMLX Vault 업로더
	extraUploader : null,			// 기타 업로더 제품용
	currentUploadFileCnt : 0,
	isNewFile : false,
	
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 1. 편집화면 window.onload시 호출된다.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	edit_init : function() {
		ebEdit.boardId     = document.setTransfer.boardId.value;
		ebEdit.boardRid    = document.setTransfer.boardRid.value;
		ebEdit.limitCount  = document.setTransfer.maxFileCnt.value;
		ebEdit.badNick     = document.setTransfer.badNickDflt.value;
		ebEdit.badCntt     = document.setTransfer.badCnttDflt.value;
		ebEdit.maxPoint    = document.setTransfer.mileTot.value;
		ebEdit.cmd         = document.setTransfer.cmd.value;
		ebEdit.totFileSize = document.setTransfer.totFileSize.value;
		ebEdit.sizeSF      = document.setTransfer.sizeSF.value;
		ebEdit.skin        = document.setTransfer.boardSkinDflt.value;
		ebEdit.limitSize   = document.setTransfer.limitSize.value;
		ebEdit.thumbSize   = document.setTransfer.thumbSize.value;

		ebEdit.ebSessionKeepTimeoutID = setTimeout("ebEdit.ebSessionKeepDelay()", 200000);

		ebEdit.ie = eval('document.setTransfer.ie.value');
		enLangKnd = eval('document.setTransfer.langKnd.value');
		//var sBasePath = document.location.href.substring(0,document.location.href.lastIndexOf('fckeditor'));
		ebEdit.jweditor = document.getElementById("jweditor");
		ebEdit.smarteditor = document.getElementById("smarteditor");
		ebEdit.vaultUploader = document.getElementById("vault_upload");
		
		// 업로드 모듈 및 파일 리스트 초기화
		if ( ebEdit.vaultUploader && ebEdit.limitCount > 0) {
			ebEdit.vaultUploader = new dhtmlXVaultObject({
			    container:  "vault_upload",             // html container for vault
			    uploadUrl:  "/dhtmlx/vault/handler/enboard_handler.jsp?boardId=" + ebEdit.boardId + "&subId=sub01",           // html4/html5 upload url
			    autoStart : false,
			    buttonUpload : false,
			    buttonClear : true
			});
			ebEdit.vaultUploader.setHeight(200);
			//ebEdit.vaultUploader.setFilesLimit(ebEdit.limitCount);
			ebEdit.vaultUploader.attachEvent("onBeforeFileAdd", function (file) {
				if (file.size > (ebEdit.vaultUploader.getMaxFileSize() / ebEdit.limitCount)) {
					alert( ebUtil.getMessage('eb.info.upload.limit.size', (ebEdit.vaultUploader.getMaxFileSize() / ebEdit.limitCount) ));
					return false; 
				}
				
				if (ebEdit.limitCount <= ebEdit.currentUploadFileCnt) {
					alert( ebUtil.getMessage('eb.info.upload.limit.cnt', ebEdit.limitCount ));
					return false; 
				}
				ebEdit.currentUploadFileCnt++;
				ebEdit.isNewFile = true;
			    return true;
			});
			
			ebEdit.vaultUploader.attachEvent("onBeforeFileRemove", function (file) {
				if (file.uploaded == true) {
					var curDelFileList = file.serverName + "-" + file.size + "|";
					var unDelFileList = "";
					ebEdit.totDelFileList += curDelFileList;
					document.setFileList.vaccum.value   = 'DIRECT';
					document.setFileList.delList.value   = ebEdit.totDelFileList;
					document.setFileList.unDelList.value = unDelFileList;				
					document.setFileList.submit();
				}
				ebEdit.currentUploadFileCnt--;
				// 파일목록이 하나도 없으면 신규 파일이 없음으로 설정 2018.5.3
				if( ebEdit.currentUploadFileCnt ==0) {
					ebEdit.isNewFile = false;
				}
				return true;
			});
			
			ebEdit.vaultUploader.setStrings({
				done:       "업로드됨",     // text under filename in files list
			    error:      "오류발생",    // text under filename in files list
			    btnAdd:     "파일추가",   // button "add files"
			    btnUpload:  "파일업로드",   // button "upload"
			    btnCancel:  "취소",   // button "cancel uploading"
			    btnClean:   "초기화",    // button "clear all"
			 
			    dnd:        "여기에 파일을 놓으세요."   // dnd text while the user is dragging files
			});
			
			// 수정화면에서 파일 목록이 있을경우
			if ($("#vault_fileList > li").size() > 0) {
				$("#vault_fileList > li").each(function (i) {
					var fileInfo = {
						name : $(this).attr("data-name"),
						serverName : $(this).attr("data-mask"),
						size : $(this).attr("data-size")
					};
					ebEdit.vaultUploader.addFileRecord(fileInfo, "uploaded");
				});
			}
			
		}
		if( document.setFileList != null && document.setFileList.list == null) {
			$("#uploadFileList").bind("mousedown", function (e) {
			      e.metaKey = true;    
			 }).selectable();
		}		
		
		if (!ebEdit.jweditor && ! ebEdit.smarteditor) {
			// FCKeditor 관련 초기화
			var ebFCKeditor = new FCKeditor('editorCntt');
			//ebFCKeditor.BasePath   = sBasePath + 'fckeditor/';
			ebFCKeditor.BasePath = ebUtil.getContextPath() + "/board/fckeditor/"
			ebFCKeditor.Config["CustomConfigurationsPath"] = ebUtil.getContextPath()+'/board/javascript/fckconfig_'+ebEdit.skin+'.js';
			ebFCKeditor.Height	   = 300;
			ebFCKeditor.ReplaceTextarea();
			
			ebFCKeditor.boardId   = ebEdit.boardRid;   //fckeditor 내에서 이미지 대화상자를 띄울때 전달해줄 parameter 추가.
			ebFCKeditor.thumbSize = ebEdit.thumbSize; //fckeditor 내에서 이미지 대화상자를 띄울때 전달해줄 parameter 추가.
			ebFCKeditor.limitUpload = ebEdit.limitUpload;
			ebFCKeditor.rebuildFile = ebEdit.rebuildFile;
		}
		if( ebEdit.smarteditor) {
			var skinUrl= ebUtil.getContextPath() + "/board/smarteditor/SmartEditor2NoImageSkin.html";	//사진업로드 불가능한 스마트 에디터 스킨
			
			if( ebEdit.limitCount > 0 && ( document.setUpload || ebEdit.vaultUploader)) {	//파일첨부가 가능한 상태이면...
				skinUrl= ebUtil.getContextPath() + "/board/smarteditor/SmartEditor2Skin.html";	//사진업로드 가능한 스마트 에디터 스킨
			}
			
			nhn.husky.EZCreator.createInIFrame({
				oAppRef: oEditors,
				elPlaceHolder: "editorCntt",
				sSkinURI: skinUrl,	
				htParams : {
					bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseVerticalResizer : false,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
					//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
					fOnBeforeUnload : function(){
						//alert("완료!");
					}
				}, //boolean
				fOnAppLoad : function(){
					//예제 코드
					//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
				},
				fCreator: "createSEditor2"
			});
		}
		
		if(document.editForm.bltnBgnYmd) {
			$('#bltnBgnYmd').datepicker({ dateFormat: "yy.mm.dd" });
			$('#bltnEndYmd').datepicker({ dateFormat: "yy.mm.dd" });
			
			if(ebEdit.cmd != 'MODIFY'){
				$('#bltnBgnYmd').val(new Date().format("yyyy.MM.dd"));
				$('#bltnEndYmd').val(new Date().format("yyyy.MM.dd"));
			}
			
			if(document.editForm.bltnBgnYmdHm) {
				var hours = 0;
				var mins = 0;
				var hh = '';
				var hhmm = '';
				var hhmmText = '';
				for(var i = 0 ; i < 24 * (60/15); i++){
					var selected = '';
					var selected2 = '';
					hh24 = (hours< 10 ? '0' + hours : hours);
					hh12 = hh24 - 12;
					mm = (mins < 10 ? '0' + mins : mins);
					hh24mm = hh24 + ':' + mm;
					if(hh12 >= 0){
						hh12 = (hh12 < 10 ? '0' + hh12 : hh12);
						hh12mm = hh12 + ':' + mm + ' PM';
					} else hh12mm = hh24 + ':' + mm + ' AM';
					
					if(ebEdit.cmd == 'MODIFY') {
						if(hh24mm == $('#bltnBgnYmdHm').val().substring(11,16)) selected = 'selected="selected"';
						if(hh24mm == $('#bltnEndYmdHm').val().substring(11,16)) selected2 = 'selected="selected"';
					}
					
					$('<option ' + selected + ' value=' + hh24mm + '>' + hh12mm + '</option>').appendTo('#bltnBgnHm');
					$('<option ' + selected2 + ' value=' + hh24mm + '>' + hh12mm + '</option>').appendTo('#bltnEndHm');
					
					mins += 15;
					if(mins >= 60) {
						mins = 0;
						hours++;
					}
				}
				if(document.editForm.isAllday) {
					if($('#isAllday').is(':checked')) {
						$('#bltnBgnHm').css('display', 'none');
						$('#bltnEndHm').css('display', 'none');
					}
					
					$('#isAllday').change(function(){
						var $this = $(this);
						if($this.is(':checked')) {
							$('#bltnBgnHm').css('display', 'none');
							$('#bltnEndHm').css('display', 'none');
							$('#bltnBgnHm').val('00:00');
							$('#bltnEndHm').val('00:00');
						} else {
							$('#bltnBgnHm').css('display', '');
							$('#bltnEndHm').css('display', '');
						}
					});
				}
			}
		}
		
		
		adminEventFree(window); // 일반사용자 마우스 우측 버튼 사용 금지.
		
		/*if( ebEdit.limitCount > 0 ) {
			if( document.setTransfer.cmd.value == 'MODIFY' ) {
				document.setUpload.totalsize.value = ebEdit.totFileSize;
				document.setUpload.viewsize.value = 'TOTAL FILE SIZE : ' + ebEdit.sizeSF;
			}
		}*/

		var divs = document.getElementsByTagName("div");
		for (var i=0; i<divs.length; i++) {
			if (divs[i].id.indexOf('setPollDiv') > -1) {
				if (divs[i].style.display == '') ebEdit.pollSeq++; // 보여지고 있는 갯수만 산출.
			}
		}	

		if (document.setTransfer.accSetYn.value == 'Y') {
			if (document.editForm.ableListGrade) ebUtil.setSelectedValues (document.editForm.ableListGrade, document.setTransfer.ableListGrade.value);
			if (document.editForm.ableListGroup) ebUtil.setSelectedValues (document.editForm.ableListGroup, document.setTransfer.ableListGroup.value);
			if (document.editForm.ableListRole ) ebUtil.setSelectedValues (document.editForm.ableListRole,  document.setTransfer.ableListRole.value );
			if (document.editForm.ableReadGrade) ebUtil.setSelectedValues (document.editForm.ableReadGrade, document.setTransfer.ableReadGrade.value);
			if (document.editForm.ableReadGroup) ebUtil.setSelectedValues (document.editForm.ableReadGroup, document.setTransfer.ableReadGroup.value);
			if (document.editForm.ableReadRole ) ebUtil.setSelectedValues (document.editForm.ableReadRole,  document.setTransfer.ableReadRole.value );
		}
		
		if( document.editForm.userNick && document.editForm.userNick.type != 'hidden' )
			document.editForm.userNick.focus();
		else
			document.editForm.bltnSubj.focus();

	},
	mobile_edit_init : function() {
		ebEdit.boardId     = document.setTransfer.boardId.value;
		ebEdit.boardRid    = document.setTransfer.boardRid.value;
		ebEdit.limitCount  = document.setTransfer.maxFileCnt.value;
		ebEdit.badNick     = document.setTransfer.badNickDflt.value;
		ebEdit.badCntt     = document.setTransfer.badCnttDflt.value;
		ebEdit.maxPoint    = document.setTransfer.mileTot.value;
		ebEdit.cmd         = document.setTransfer.cmd.value;
		ebEdit.totFileSize = document.setTransfer.totFileSize.value;
		ebEdit.sizeSF      = document.setTransfer.sizeSF.value;
		ebEdit.skin        = document.setTransfer.boardSkinDflt.value;
		ebEdit.limitSize   = document.setTransfer.limitSize.value;
		ebEdit.thumbSize   = document.setTransfer.thumbSize.value;

		ebEdit.ie = eval('document.setTransfer.ie.value');
		
		adminEventFree(window); // 일반사용자 마우스 우측 버튼 사용 금지.
	},
	ebSessionKeepDelay : function () {
		// 5분에 한번씩 서버로 요청을 보내서, session-timeout이 짧게 잡혀있는 서버환경에서
		// 게시물을 오래 편집하여도 세션이 끊어지지 않도록 조치하여준다.
		// 2010.03.26.KWShin.
		ebUtil.loadXMLDoc("TEXT", "GET", ebUtil.getContextPath()+"/board/resource/session_keeping.jsp");
		//alert("KEEPING!!");
		clearTimeout( ebEdit.ebSessionKeepTimeoutID );
		ebEdit.ebSesssionKeepTimoutID = setTimeout("ebEdit.ebSessionKeepDelay()", 180000);
	},
	edit_destroy : function() {
		
		var unDelFileList = '';
		// 취소시
		if (ebEdit.isCancel && ebEdit.limitCount > 0) {
			if( document.setFileList.list != null) {
				// list객체가 있으면 select를 사용하는 옛날 방식으로 사용한다.
				for( var i = 1; i < document.setFileList.list.options.length; i++ ) {
					if( document.setFileList.list.options[i].value.length > 0 ) {
						if( ebEdit.cmd == 'MODIFY' ) {
							if (ebEdit.fileList.indexOf( document.setFileList.list.options[i].value) == -1)
								unDelFileList += document.setFileList.list.options[i].value + '|';
						} else
							unDelFileList += document.setFileList.list.options[i].value + '|';
					}
				}
			} else {
				// jquery-ui selectable을 사용한다.
				$("#uploadFileList .ui-selected").each( function(){
					var data =  $(this).attr('data');
					if( ebEdit.cmd == 'MODIFY' ) {
						if (ebEdit.fileList.indexOf( data) == -1)
							unDelFileList += document.setFileList.list.options[i].value + '|';
					} else
						unDelFileList += document.setFileList.list.options[i].value + '|';
				});
			}

			document.setFileList.delList.value = unDelFileList;

		//저장시
		} else if (!ebEdit.isCancel && ebEdit.limitCount > 0) {
			document.setFileList.delList.value = ebEdit.totDelFileList;
		}
		
		if (document.setFileList.delList.value.length > 0) {
			document.setFileList.vaccum.value = 'INDIRECT';
			// 삭제화면을 보여주려면 다음 두 라인을 살린다.
			//document.setFileList.target = 'popup';
			//window.open('about:blank', 'popup', 'width=200, height=50');
			document.setFileList.submit();
		}
	},
	mobile_edit_destroy : function() {},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 업로드 제한 파일 갯수를 체크하고, Progress bar 를 보이도록 한 뒤, 
	// setUpload 폼을 서브밋한다.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	uploadFile : function() {
		if( ebEdit.limitCount > 0 ) {
			var uploadCount = 0;
			
			if( document.setFileList.list != null) {
				// list객체가 있으면 select를 사용하는 옛날 방식으로 사용한다.
				for (var i = 1; i < document.setFileList.list.length; i++) {
					if (document.setFileList.list.options[i].value.length > 0) uploadCount++;
				}
			} else {
				// jquery-ui selectable 사용
				uploadCount = $("#uploadFileList li").length;
				
			}

			if( ebEdit.limitCount <= uploadCount ) {
				alert( ebUtil.getMessage('eb.info.upload.limit.cnt', ebEdit.limitCount ));
				return;
			}

			if(!ebUtil.chkValue( document.setUpload.filename, ebUtil.getMessage('eb.info.ttl.o.file'), 'true')) return;

			document.getElementById('uploading').style.display = 'inline';
			this.ebUploadStatusSemaphore = "ON";
			this.displayUploadStatus();
			document.setUpload.action = "fileMngr?cmd=upload&boardId="+document.setUpload.boardId.value;
			document.setUpload.submit();
		}
	},
	
	handleUpload : function ( text, val) {
		if( document.setFileList.list != null) {
			// list객체가 있으면 select를 사용하는 옛날 방식으로 사용한다.
			var listIndex = -1;
			for (k = 0; k < document.setFileList.list.options.length; k++) {
				if (document.setFileList.list.options[k].value == "") {
					listIndex = k;	
					break;
				}
			}
			if( listIndex != -1) {
				document.setFileList.list.options[listIndex].text = text;
				document.setFileList.list.options[listIndex].value = val;
			} else {
				document.setFileList.list.options[ document.setFileList.list.options.length] = new Option( text, val);
			}
		} else {
			// list객체가 없으면 jquery-ui의 selectable을 사용한다.
			$("#uploadFileList").append( "<li data='" + val + "'>" + text + "</li>" );
			$("#uploadFileList").bind("mousedown", function (e) {
			      e.metaKey = true;    
			 }).selectable();
		}
	},
	
	handleDelete : function ( deletedList) {
		if( document.setFileList.list != null) {
			// list객체가 있으면 select를 사용하는 옛날 방식으로 사용한다.
			for (var i = document.setFileList.list.length - 1; i >= 0; i--) {
				for (var j = 0; j < deletedList.length; j++) {
					if (document.setFileList.list.options[i].value == deletedList[j]) {
						document.setFileList.list.options[i] = null;
						break;
					}
				}
			}			
		} else {
			// list객체가 없으면 jquery-ui selectable을 사용한다.
			$("#uploadFileList li").each( function(){
				var data =  $(this).attr('data');
				for( var i=0; i < deletedList.length;i++) {
					if( data==deletedList[i]) {
						$(this).remove();
					}
				}
			});
		}
	},
	
	closeUpload : function() {
		document.getElementById('uploading').style.display = 'none';
		this.ebUploadStatusSemaphore = "OFF";
		clearTimeout (this.ebUploadStatusTimeoutID);
	},
	displayUploadStatus : function () {
		// 1초에 한번씩 서버로 요청을 보내서, FileUpload 서블릿이 세션에 매달아주는 파일의 업로드 현황을
		// 읽어와서 화면에 보여준다.
		// 2012.06.21.KWShin.
		clearTimeout (this.ebUploadStatusTimeoutID);
		var uploadStatus = ebUtil.loadXMLDoc("TEXT", "GET", ebUtil.getContextPath()+"/board/resource/getUploadStatus.jsp");
		document.getElementById("uploadStatus").innerHTML = uploadStatus;
		if (this.ebUploadStatusSemaphore == "ON") {
			this.ebUploadStatusTimeoutID = setTimeout("ebEdit.displayUploadStatus()", 500);
		}
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 현재 선택된 파일을 전체 선택된 파일 목록에 추가하고, 
	// 전체 선택된 파일 목록과 선택되지 않은 파일 목록을 서브밋.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	deleteFile : function() {
		var isSelected = false;
		var curDelFileList = '';
		var unDelFileList = '';
		if( document.setFileList.list != null) {
			// list객체가 있으면 select를 사용하는 옛날 방식으로 사용한다.
			for (var i = 1; i < document.setFileList.list.length; i++) {
				if (document.setFileList.list.options[i].value.length > 0 &&
					document.setFileList.list.options[i].selected) {
					if( ebEdit.fileList.indexOf( document.setFileList.list.options[i].value ) > -1 )
						// 방금 선택된 파일들을 전체 삭제 파일 리스트에 추가.
						curDelFileList += document.setFileList.list.options[i].value + '|';
					else
						unDelFileList += document.setFileList.list.options[i].value + '|';
					isSelected = true;
				}
			}
		} else {
			// list객체가 없으면 query-ui selectable 사용
			$("#uploadFileList .ui-selected").each( function(){
				var data =  $(this).attr('data');
				if( ebEdit.fileList.indexOf( data) > -1 )
					// 방금 선택된 파일들을 전체 삭제 파일 리스트에 추가.
					curDelFileList += data + '|';
				else
					unDelFileList += data + '|';
				isSelected = true;
			});
		}

		
		if (isSelected) {
			if (confirm(ebUtil.getMessage('eb.info.confirm.del'))) {
				ebEdit.totDelFileList += curDelFileList;
				document.setFileList.vaccum.value   = 'DIRECT';
				document.setFileList.delList.value   = ebEdit.totDelFileList;
				document.setFileList.unDelList.value = unDelFileList;				
				document.setFileList.submit();
			}
		} else
			//alert('삭제하고자 하는 파일을 선택하세요');
			alert(ebUtil.getMessage('eb.info.select.file.delete'));
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// Progress bar 를 보이도록 한 뒤, setPoll 폼을 서브밋한다.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	uploadPollImg : function(evt) {
		evt = (evt) ? evt : ((window.event) ? window.event : null);
		var elm = (evt.target) ? evt.target : evt.srcElement;
		var seq = elm.id;

		var setPollForm = document.forms['setPoll'+seq];
		if (setPollForm) {
			if (document.forms['setPoll'+seq].elements['pollFile'+seq].value.length == 0) {
				alert(ebUtil.getMessage('eb.info.file'));
				document.forms['setPoll'+seq].elements['pollFile'+seq].focus();
				return false;
			}
			document.getElementById('uploading').style.display = 'inline';
			setPollForm.submit();
		}
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 선택된 문항의 설문이미지 파일을 서버에서 삭제한다.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	deletePollImg : function(evt) {
		evt = (evt) ? evt : ((window.event) ? window.event : null);
		var elm = (evt.target) ? evt.target : evt.srcElement;
		var seq = elm.id;

		var setPollForm = document.forms['setPoll'+seq];
		document.setPollDel.seq.value = seq;
		document.setPollDel.fileMask.value = setPollForm.fileMask.value;
		if (document.setPollDel.fileMask.value.length == 0) {
			alert(ebUtil.getMessage('mm.info.notExist.delFile'));
		} else {
			if (confirm(ebUtil.getMessage('eb.info.confirm.del'))) {
				document.setPollDel.submit();
			}
		}
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// '목록보기' 버튼을 눌렀을 때.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	list : function()  {
		document.setTransfer.method = "post";
		document.setTransfer.action = "list.brd";
		document.setTransfer.submit();
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// '저장' 버튼을 눌렀을 때.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	save : function (rtnURI) {
		if (document.editForm.userNick) {
			if (!ebUtil.chkValue( document.editForm.userNick, ebUtil.getMessage('eb.info.ttl.o.name'), 'true')) return;
			if (!ebUtil.chkBadCntt( document.editForm.userNick, ebUtil.getMessage('eb.info.ttl.name'), ebEdit.badNick, 'true')) return;
			document.setTransfer.userNick.value = document.editForm.userNick.value;
		}

		if (document.editForm.anonFlag) document.setTransfer.anonFlag.value = (document.editForm.anonFlag.checked) ? "Y" : "N";
		if (document.editForm.userPass) { // 비밀번호 필드가 있는 경우
			if (!(document.editForm.anonFlag) || document.editForm.anonFlag.checked) {
				if (!ebUtil.chkValue( document.editForm.userPass, ebUtil.getMessage('eb.info.ttl.o.password'), 'true')) return;
				if (!ebUtil.chkLength( document.editForm.userPass, ebUtil.getMessage('eb.info.ttl.password'), 12, 'true')) return;
				document.setTransfer.userPass.value = document.editForm.userPass.value;
			}
		}
		
		document.setTransfer.bltnSubj.value = document.editForm.bltnSubj.value;
		try {
			if (ebEdit.jweditor) {
				document.setTransfer.bltnCntt.value = document.getElementById("jweditor").BodyHtml;
			} else if (ebEdit.smarteditor) {
				// 에디터의 내용이 textarea에 적용됩니다.
//				oEditors.getById["editorCntt"].exec("UPDATE_CONTENTS_FIELD", []);	
//				document.setTransfer.bltnCntt.value = document.getElementById('editorCntt').value;
//				var sHTML = oEditors.getById["editorCntt"].getIR();
//				alert(sHTML);
				document.setTransfer.bltnCntt.value = oEditors.getById["editorCntt"].getIR();	
			} else {
				document.setTransfer.bltnCntt.value = FCKeditorAPI.GetInstance('editorCntt').GetData();
			}
		} catch (ex) {
			// FCKeditor 를 사용하지 않는 경우에는...
			document.setTransfer.bltnCntt.value = document.getElementById('editorCntt').value;
		}
		if (document.getElementById("editorCnttMaxBytes")) { // 입력제한값이 있으면...
			
			var div = document.createElement("div"); 
			div.innerHTML = document.setTransfer.bltnCntt.value; 

			var contents; 
			if (document.all) contents = div.innerText; 
			else              contents = div.textContent; 

			var charlength = 0;
			for (var i=0; i<contents.length; i++) {
				ch = escape(contents.charAt(i));
				if (ch.length == 1) {
					charlength++;
				} else if (ch.indexOf("%u") != -1) {
					charlength += 2;
				} else if (ch.indexOf("%") != -1) {
					charlength += ch.length/3;
				}
			}
			if (charlength > eval(document.getElementById("editorCnttMaxBytes").value)) {
				alert("최대 "+document.getElementById("editorCnttMaxBytes").value+" Byte까지 입력하실 수 있습니다.");
				return;
			}
		}
		// max length가 지정된 필드의 길이 체크
		if( ! ebUtil.checkLength( document.editForm)) {
			return;
		}
		
		if (!ebUtil.chkValue (document.editForm.bltnSubj,    ebUtil.getMessage('eb.info.ttl.o.bltnSubj'), 'true'))  return;
		var bltnCntt = document.setTransfer.bltnCntt.value;
		if (bltnCntt == "<br />" || bltnCntt == "&nbsp;") document.setTransfer.bltnCntt.value = ""; // 아무것도 입력안해도 FCKeditor가 디폴트로 '<br />' 또는 '&nbsp;'를 넣어준다. 
		if (!ebUtil.chkValue (document.setTransfer.bltnCntt, ebUtil.getMessage('eb.info.ttl.o.bltnCntt'), 'false')) return;
		if (!ebUtil.chkBadCntt(document.editForm.bltnSubj,    ebUtil.getMessage('eb.info.ttl.bltnSubj'), ebEdit.badCntt, 'true'))  return;
		if (!ebUtil.chkBadCntt(document.setTransfer.bltnCntt, ebUtil.getMessage('eb.info.ttl.bltnCntt'), ebEdit.badCntt, 'false')) return;

		// 디폴트로 ext_str0 ~ ext_str9 까지의 확장필드를 처리함. 이외의 확장필드들에 대해서는 처리 루틴을 수기로 기입해주어야 함.
		for( var i=0; i<10; i++) {
			var srcExtObj = eval('document.editForm.ext_str'+i);
			var dstExtObj = eval('document.setTransfer.ext_str'+i);
			if (srcExtObj) dstExtObj.value = srcExtObj.value;
		}
		
		if (document.editForm.bltnTopTag) document.setTransfer.bltnTopTag.value = ebUtil.getCheckedValue (document.getElementsByName('bltnTopTag'));
		if (document.editForm.bltnBgnYmd) document.setTransfer.bltnBgnYmd.value = document.editForm.bltnBgnYmd.value;
		if (document.editForm.bltnEndYmd) document.setTransfer.bltnEndYmd.value = document.editForm.bltnEndYmd.value;
		if (document.editForm.cateList)   document.setTransfer.cateId.value     = document.editForm.cateList.value;
		if (document.editForm.cateRadio) {
			var radioObj = document.editForm.cateRadio;
			for (i = 0; i < radioObj.length; i++)
				if (radioObj[i].checked) {
					document.setTransfer.cateId.value = radioObj[i].value;
					break;
				}
		}
		if (document.editForm.bltnSecretYn) document.setTransfer.bltnSecretYn.value = (document.editForm.bltnSecretYn.checked)? "Y":"N";
		else                                document.setTransfer.bltnSecretYn.value = "N";
		
		if (document.editForm.ableListGrade) document.setTransfer.ableListGrade.value = ebUtil.getSelectedValues(document.editForm.ableListGrade);
		if (document.editForm.ableListGroup) document.setTransfer.ableListGroup.value = ebUtil.getSelectedValues(document.editForm.ableListGroup);
		if (document.editForm.ableListRole ) document.setTransfer.ableListRole.value  = ebUtil.getSelectedValues(document.editForm.ableListRole );
		if (document.editForm.ableReadGrade) document.setTransfer.ableReadGrade.value = ebUtil.getSelectedValues(document.editForm.ableReadGrade);
		if (document.editForm.ableReadGroup) document.setTransfer.ableReadGroup.value = ebUtil.getSelectedValues(document.editForm.ableReadGroup);
		if (document.editForm.ableReadRole ) document.setTransfer.ableReadRole.value  = ebUtil.getSelectedValues(document.editForm.ableReadRole );
		
		if (document.editForm.accSetTempList) {
			if (document.editForm.accSetTempList.value.length > 0 && document.setTransfer.accSetInfo.value.length == 0) {
				if (!confirm ("게시물 접근허용권한이 변경되었으나 '적용'되지 않았습니다. 변경내역을 무시하겠습니까?")) return;
			}
		}

		document.setTransfer.pollCntt.value = '';
		document.setTransfer.pollMask.value = '';
		for( var i=0; i<document.forms.length; i++ ) {
			if( document.forms[i].name.indexOf('setPoll') > -1 ) {
				var seq = document.forms[i].elements['seq'].value;
				var cntt = document.forms[i].elements['poll'+seq].value;
				var file = document.forms[i].elements['fileMask'].value;
				document.setTransfer.pollCntt.value += cntt + "|";
				if( cntt.length > 0 ) { // 설문항목이 있을 때만 이미지가 의미가 있겠지..
					if( file.length <= 0 )  
						document.setTransfer.pollMask.value += "#|"; // Token 갯수를 맞추기 위해 '#'을 올려준다. 서버에서 이를 걸러 실제로 fileMask 필드에는 아무것도 저장하지 않는다.
					else 
						document.setTransfer.pollMask.value += file + "|";
				}
			}
		}

		document.setTransfer.betPnt.value = 0;
		if( document.editForm.betPnt ) {
			if( !ebUtil.chkNum( document.editForm.betPnt, ebUtil.getMessage('eb.info.ttl.p.point'), 'true')) return;
			if( parseInt( document.editForm.betPnt.value) > parseInt( ebEdit.maxPoint )) {
				alert( ebUtil.getMessage('eb.info.point.limit.input', ebEdit.maxPoint));
				return;
			}
			document.setTransfer.betPnt.value = (document.editForm.betPnt.value == '') ? 0 : document.editForm.betPnt.value;
		}

		if (ebEdit.jweditor) {
			// Send image file.
			ebEdit.jweditor.ImgFileReadUrl = "http://" + location.host + ebUtil.getContextPath() + "/board/upload/editor/"+ebEdit.boardRid+"/";
			if (ebEdit.jweditor.HttpSendImg (ebUtil.getContextPath()+"/board/fileMngr?cmd=upload&boardId="+ebEdit.boardRid+"&subId=subJW") < 0) {
				alert ("SendImg::"+ebEdit.jweditor.GetHTTPErrText());
				//ebEdit.jwAddCurrentUploadFile();
				//ebEdit.jwSendCancel();
			return ;
			} 
			// Send movie, flash file.
			ebEdit.jweditor.MFFileReadUrl = "http://" + location.host + ebUtil.getContextPath() + "/board/upload/editor/"+ebEdit.boardRid+"/";
			if (ebEdit.jweditor.HttpSendMediaFlash (ebUtil.getContextPath()+"/board/fileMngr?cmd=upload&boardId="+ebEdit.boardRid+"&subId=subJW") < 0) {
				alert ("SendMedia::"+ebEdit.jweditor.GetHTTPErrText());
				//ebEdit.jwAddCurrentUploadFile();
				//ebEdit.jwSendCancel();
			return ;
			}
			// 본문내용 Validation을 위해 이미 윗부분에서 할당했으나,
			// 편집기에서 삽입된 이미지 등이 존재할 경우 그 파일을 Upload한 후 파일의 URL 경로가 변경되므로
			// 다시 한번 본문 내용을 할당해준다.
			document.setTransfer.bltnCntt.value = document.getElementById("jweditor").BodyHtml;
		}
		
		if ( ebEdit.vaultUploader ) {
			ebEdit.vaultUploader.attachEvent("onUploadComplete", function (files) {
				// 파라미터로 받는 files에는 원파일명이 없다.(undefined)
				// getData로 받는 데이터에는 있음.(업로드 된 파일리스트)
				document.setTransfer.fileName.value = "";
				document.setTransfer.fileMask.value = "";
				document.setTransfer.fileSize.value = "";

				var fileList = ebEdit.vaultUploader.getData();
				if (files.length > 0) {
					for (var i = 0 ; i < fileList.length ; i++) {
						document.setTransfer.fileName.value += fileList[i].name + "|";
						document.setTransfer.fileMask.value += fileList[i].serverName + "|";
						document.setTransfer.fileSize.value += fileList[i].size + "|";
					}
				}
				ebEdit.isNewFile = false;
				ebEdit.isCancel = false;
				if (rtnURI != null) document.setTransfer.rtnURI.value = rtnURI;
				document.setTransfer.method = "post";
				document.setTransfer.action = "save.brd";
				document.setTransfer.submit();
			});
			
			
			if (ebEdit.isNewFile) {
				ebEdit.vaultUploader.upload();
			} else {
				document.setTransfer.fileName.value = "";
				document.setTransfer.fileMask.value = "";
				document.setTransfer.fileSize.value = "";

				var fileList = ebEdit.vaultUploader.getData();
				if (fileList.length > 0) {
					for (var i = 0 ; i < fileList.length ; i++) {
						document.setTransfer.fileName.value += fileList[i].name + "|";
						document.setTransfer.fileMask.value += fileList[i].serverName + "|";
						document.setTransfer.fileSize.value += fileList[i].size + "|";
					}
				}
				ebEdit.isCancel = false;
				if (rtnURI != null) document.setTransfer.rtnURI.value = rtnURI;
				document.setTransfer.method = "post";
				document.setTransfer.action = "save.brd";
				document.setTransfer.submit();
			}
			
		} else {
			document.setTransfer.fileName.value = "";
			document.setTransfer.fileMask.value = "";
			document.setTransfer.fileSize.value = "";
			if( ebEdit.limitCount > 0 && document.setUpload) {
				var totalLimit = ebEdit.limitSize * 1;
				var maxSize = document.setUpload.totalsize.value * 1;
//				alert("maxSize=["+maxSize+"], totalLimit=["+totalLimit+"]");
				if( maxSize > totalLimit ) {
					alert( ebUtil.getMessage('eb.info.upload.limit.size', ebEdit.limitSize ));
					return;
				}
				if( document.setFileList.list ) {
					// list객체가 있으면 select를 사용하는 옛날 방식으로 사용한다.
						for( var i=1; i<document.setFileList.list.options.length; i++ ) {
							if( document.setFileList.list.options[i].value.length > 0 ) {
								var ary = document.setFileList.list.options[i].value.split("-");
								document.setTransfer.fileMask.value += ary[0] + "|";
								document.setTransfer.fileSize.value += ary[1] + "|";
								// 파일명 뒤에 붙은 파일크기 정보를 잘라내고 순수한 파일명만 서버로 올린다.
								var manuFileNm = document.setFileList.list.options[i].text;
								manuFileNm = manuFileNm.substring(0, manuFileNm.lastIndexOf("(")-1);
								document.setTransfer.fileName.value += manuFileNm + "|";
							}
						}
				} else {
					// list객체가 없으면 jquery-ui selectable 사용
					$("#uploadFileList li").each( function(){
						var data =  $(this).attr('data');
						var ary = data.split("-");
						document.setTransfer.fileMask.value += ary[0] + "|";
						document.setTransfer.fileSize.value += ary[1] + "|";
						// 파일명 뒤에 붙은 파일크기 정보를 잘라내고 순수한 파일명만 서버로 올린다.
						var manuFileNm = $(this).text();
						manuFileNm = manuFileNm.substring(0, manuFileNm.lastIndexOf("(")-1);
						document.setTransfer.fileName.value += manuFileNm + "|";
					});
				}
			}
			
			ebEdit.isCancel = false;
			if (rtnURI != null) document.setTransfer.rtnURI.value = rtnURI;
			document.setTransfer.method = "post";
			document.setTransfer.action = "save.brd";
			document.setTransfer.submit();
		}
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 글을 작성하다가 '재작성' 버튼을 클릭했을 때
	// 올라 쓰는데가 없다?-일단 막았다. 에러나면 풀어라...2012.09.06.KWShin.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	/*
	rewrite : function() {
		if (!confirm(ebUtil.getMessage('eb.info.confirm.rewrite'))) return;
		
		var ebFCKeditor = FCKeditorAPI.GetInstance('editorCntt');
		
		//FCKUndo.SaveUndoStep();
		ebFCKeditor.SetData('');
		//FCKUndo.Typing = true;
		
		document.editForm.bltnSubj.value = '';
		document.editForm.bltnSubj.focus();
	},
	*/
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// iframe 'formEditor' 내의 필드들을 'setTransfer' form으로 옮겨준다.
	// 양식형 게시판 작업 시 작성된 것으로, 양식형 기능을 포기하면서 사용하지 않는 함수이다.2011.12.30.KWShin.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	form2transfer : function() {
		if( document.setTransfer != null && document.getElementById('formEditor') != null ) {
			var frm  = document.setTransfer;
			var dcmt = null;
			if (ebEdit.ie) dcmt = formEditor.document;
			else	dcmt = document.getElementById('formEditor').contentDocument;
			
			for (var i=0; i<dcmt.all.length; i++) {
				if( dcmt.all[i].type == "radio" ) {
					if (dcmt.all[i].checked) {
						frm.elements["EBFORM_"+dcmt.all[i].name].value = dcmt.all[i].value;
					}
				} else if( dcmt.all[i].type == "select-one" || dcmt.all[i].type == "select-multiple") {
					var selectFirst = true;
					for (var j=0; j<dcmt.all[i].length; j++) {
						if (dcmt.all[i].options[j].selected) {
							if (selectFirst) {
								selectFirst = false;
								frm.elements["EBFORM_"+dcmt.all[i].name].value = dcmt.all[i].options[j].value;
							} else {
								frm.elements["EBFORM_"+dcmt.all[i].name].value += "," + dcmt.all[i].options[j].value;
							}
						}
					}
				} else if (dcmt.all[i].type == "text" || dcmt.all[i].type == "hidden" 
						|| dcmt.all[i].type == "password" || dcmt.all[i].type == "textarea" ) {
					frm.elements["EBFORM_"+dcmt.all[i].name].value = dcmt.all[i].value;
				}
			}
		}
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 익명글쓰기 기능이 있는 게시판에서 '익명글쓰기'를 선택했을 때
	///////////////////////////////////////////////////////////////////////////////////////////////////
	checkAbleAnon : function (elm) {
		
		var editUser = document.editForm.userNick;
		var tranUser = document.setTransfer.userNick;
		
		if (elm.checked) { // '익명글쓰기'일 때
			tranUser.value = editUser.value;
			editUser.value = '';
			editUser.readOnly = false;
		} else { // '익명글쓰기'가 아닐 때
			editUser.value = tranUser.value;
			editUser.readOnly = true;
		}
	},
	limitUpload : function() {
		if( ebEdit.limitCount > 0 ) {
			var uploadCount = 0;
			for(var i=1; i < document.setFileList.list.length; i++) {
				if( document.setFileList.list.options[i].value.length > 0 ) uploadCount++;
			}
			if( ebEdit.limitCount <= uploadCount ) {
				alert( ebUtil.getMessage('eb.info.upload.limit.cnt', ebEdit.limitCount));
				return false;
			}
		}
		return true;
	},
	rebuildFile : function (fileName, fileMask, fileSize) {
		if( this.vaultUploader != null ) {
			var fileInfo = {
					name : fileName,
					serverName : fileMask,
					size : fileSize
				};
				this.vaultUploader.addFileRecord(fileInfo, "uploaded");
				return;
		}
		var totalSize = eval("document.setUpload.totalsize.value");
		totalSize = eval(totalSize) + eval(fileSize);
	  
		var unit = "";
		var calsize = "";
			if ((1024 < totalSize) && (totalSize < 1024 * 1024)) {
			unit = " KB";
				calsize = (totalSize/1024)+"";
		} else if (1024 * 1024 <= totalSize) {
			unit = " MB";
			calsize = (totalSize/(1024*1024))+"";
		} else {
			unit = " Bytes";
				calsize = totalSize+"";
		}
	  
		if (calsize.indexOf(".") > -1) {
			var sosu = calsize.substring(calsize.indexOf("."), calsize.length);
	  
			if (sosu.length > 4)
				calsize = calsize.substring(0,calsize.indexOf("."))+sosu.substring(0,4);
		}
	  
		document.setUpload.totalsize.value = totalSize;
		document.setUpload.viewsize.value = "TOTAL FILE SIZE : "+calsize+unit;
		
		var fsize = eval(fileSize); var funit = "";
		if ((fsize > 1024) && (fsize < 1024 * 1024)) {
			funit = " KB";
			fsize = fsize/1024 + "";
		} else if (fsize >= 1024 * 1024) {
			funit = " MB";
			fsize = fsize/(1024*1024) + "";
		} else {
			funit = " Bytes";
			fsize = fsize + "";
		}
		if (fsize.indexOf(".") > -1) {
			var fsosu = fsize.substring(fsize.indexOf("."), fsize.length);
			if (fsosu.length > 4)
				fsize = fsize.substring(0,fsize.indexOf("."))+fsosu.substring(0,4);
		}

		// 파일명 뒤에 파일 사이즈를 같이 보여준다.
		var text = fileName + " (" + fsize + funit + ")";
		var val = fileMask+'-'+fileSize;
		this.handleUpload( text, val);
	},
	loadPoll : function() {
		var obj = document.getElementsByName('poll_c');
		var len = obj.length;

		for( var i=0; i<len; i++ ) 
			document.getElementsByName('poll_c')[i].style.width = document.getElementsByName('pollSize')[i].value;
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 설문형 게시판에서 답병항목 추가/삭제 버튼을 눌렀을 때. 답변항목을 추가/삭제한다.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	poll : function( flag ) {
		if( flag == '+' ) {
			ebEdit.pollSeq++;
			if( ebEdit.pollSeq == 10 ) {
				alert( ebUtil.getMessage('eb.info.poll.limit.item'));
				ebEdit.pollSeq--;
				return;
			}
			document.getElementById('setPollDiv'+ebEdit.pollSeq).style.display = '';
			document.forms['setPoll'+ebEdit.pollSeq].elements['pollCntt'+ebEdit.pollSeq].value = '';
		} else {
			if( ebEdit.pollSeq == 2 ) {
				alert( ebUtil.getMessage('eb.info.poll.min.item'));
				return;
			}
			document.getElementById('setPollDiv'+ebEdit.pollSeq).style.display = 'none';
			document.forms['setPoll'+ebEdit.pollSeq].elements['pollCntt'+ebEdit.pollSeq].value = '';
			ebEdit.pollSeq--;
		}
	},
	getAccSetMngr : function () {
		if (this.accSetMngr == null) this.accSetMngr = new enboard.edit.AccSetMngr();
		return this.accSetMngr;
	}
}
enboard.edit.AccSetMngr = function() {}
enboard.edit.AccSetMngr.prototype = {
	
	m_pageNo : 1,
	m_pageSize : 10,
	m_boardId : null,
	m_bltnNo : null,
	
	m_groupTree : null,
	m_roleTree : null,
	
	doShow : function (cmd, boardId, bltnNo) {

		this.m_boardId = boardId;
		this.m_bltnNo  = bltnNo;
		
		if (cmd == "true") {
			var param = "view=main";
			param += this.m_boardId == null ? "" : "&boardId="+this.m_boardId;
			param += this.m_bltnNo  == null ? "" : "&bltnNo="+this.m_bltnNo;
			var cntt = ebUtil.loadXMLDoc ("TEXT", "POST", ebUtil.getContextPath()+"/board/accSet.brd", param);
			if (document.getElementById("jweditor")) { // JWEditor 사용 시 ActiveX 를 가리기 위한 조치.
				document.getElementById("jweditor").style.display = "none";
			}
			ebUtil.getPopupDialog().initModal (null,null,"#FFFFFF");
			ebUtil.getPopupDialog().showModal (cntt, 100, 100);
			
			this.selectScope (ebUtil.getCheckedValue (document.getElementsByName ("scopeType")));
			
			var bodyElm = document.getElementById ('baListBody');
			var trs = bodyElm.children;
			var trIdx = trs.length / 3;
			var accSetTempList = document.getElementById("accSetTempList").value;
			if (accSetTempList != null && accSetTempList.length > 0) {
				
				var accSetTemps = accSetTempList.split(";");
				
				for (var i=0; i<accSetTemps.length; i++) {
					
					var accSetTemp = accSetTemps[i].substring (0,accSetTemps[i].indexOf("="));
					var infos = accSetTemp.split(",");
					var auths = accSetTemps[i].substring (accSetTemps[i].indexOf("=") + 1);

					
					tagTR = document.createElement('tr');
					tagTD = document.createElement('td');
					tagTD.setAttribute ("height", "1");
					tagTD.setAttribute ("colspan", "3");
					tagTD.setAttribute("class", "adgridlimit");
					tagTD.setAttribute("className", "adgridlimit");
					tagTR.appendChild (tagTD);
					bodyElm.appendChild (tagTR);

					tagTR = document.createElement('tr');
					tagTR.setAttribute ("height", "22");
					tagTR.onmouseover = new Function ("ebUtil.activeLine(this,true)");
					tagTR.onmouseout = new Function ("ebUtil.activeLine(this,false)");
					tagTR.setAttribute ("prinId", infos[0]); // Keep 'PRINCIPAL_ID'!!
					tagTR.setAttribute ("style", "cursor:pointer");
					if (trIdx % 2 == 1) {
						tagTR.setAttribute("class", "adgridline");
						tagTR.setAttribute("className", "adgridline");
					}
					
					tagTD = document.createElement('td');
					tagTD.align = "center";
					tagTD.setAttribute("class", "adgrid");
					tagTD.setAttribute("className", "adgrid");
					tagTD.innerHTML = infos[1];
					tagTR.appendChild (tagTD);
					
					tagTD = document.createElement('td');
					tagTD.setAttribute("class", "adgrid");
					tagTD.setAttribute("className", "adgrid");
					tagTD.align = "left";
					tagTD.innerHTML = infos[2];
					tagTR.appendChild (tagTD);
					
					tagTD = document.createElement('td');
					tagTD.setAttribute("class", "adgridlast");
					tagTD.setAttribute("className", "adgridlast");
					tagTD.align = "left";
					tagTD.innerHTML = infos[3];
					tagTR.appendChild (tagTD);
					
					bodyElm.appendChild (tagTR);
					
					tagTR = document.createElement('tr');
					tagTR.setAttribute ("height", "22");
					if (trIdx++ % 2 == 1) {
						tagTR.setAttribute("class", "adgridline");
						tagTR.setAttribute("className", "adgridline");
					}
					tagTR.setAttribute ("accSetTemp", accSetTemp);
					
					tagTD = document.createElement('td');
					tagTD.align = "center";
					tagTD.setAttribute("colspan", "3");
					tagTD.setAttribute("class", "adgridlast");
					tagTD.setAttribute("className", "adgridlast");
					var cntt = "";
					cntt += "<div style='float:left'><input type=checkbox id='accSet_"+infos[0]+"_0' name='accSet_"+infos[0]+"_0' value='bltnList'" +(auths.substring(0,1) == "Y" ? "checked=true" : "")+"/>목록조회</div>";
					cntt += "<div style='float:left'><input type=checkbox id='accSet_"+infos[0]+"_1' name='accSet_"+infos[0]+"_1' value='bltnRead'" +(auths.substring(1,2) == "Y" ? "checked=true" : "")+"/>글읽기</div>";
					cntt += "<div style='float:left'><input type=checkbox id='accSet_"+infos[0]+"_2' name='accSet_"+infos[0]+"_2' value='fileDown'" +(auths.substring(2,3) == "Y" ? "checked=true" : "")+"/>파일다운로드</div>";
					cntt += "<div style='float:left'><input type=checkbox id='accSet_"+infos[0]+"_3' name='accSet_"+infos[0]+"_3' value='bltnReply'"+(auths.substring(3,4) == "Y" ? "checked=true" : "")+"/>답글쓰기</div>";
					cntt += "<div style='float:left'><input type=checkbox id='accSet_"+infos[0]+"_4' name='accSet_"+infos[0]+"_4' value='memoWrite'"+(auths.substring(4,5) == "Y" ? "checked=true" : "")+"/>댓글쓰기</div>";
					cntt += "<div style='float:left'><input type=checkbox id='accSet_"+infos[0]+"_5' name='accSet_"+infos[0]+"_5' value='memoReply'"+(auths.substring(5)   == "Y" ? "checked=true" : "")+"/>댓답글쓰기</div>";
					tagTD.innerHTML = cntt;
					tagTR.appendChild (tagTD);

					bodyElm.appendChild (tagTR);
				}
			}
			
		} else if (cmd == "false") {
			this.setAccSetTempList();
			ebUtil.getPopupDialog().remove();
			if (document.getElementById("jweditor")) { // JWEditor 사용 시 가렸던 ActiveX 를 보이게 하기 위한 조치.
				document.getElementById("jweditor").style.display = "";
			}
		}
	},
	selectScope : function (scope) {
	
		document.getElementById('grugListDiv').innerHTML = "";
		
		if (scope == "G") {
			
			this.m_groupTree = new dhtmlXTreeObject (document.getElementById('grugListDiv'),"100%","100%",0);
			this.m_groupTree.setImagePath (ebUtil.getContextPath()+"/dhtmlx/imgs/dhxtree_skyblue/");
			this.m_groupTree.enableCheckBoxes (1);
			this.m_groupTree.setOnClickHandler (this.nodeSelectOnGroupTree);
			this.m_groupTree.enableAutoTooltips (true);
			this.m_groupTree.setXMLAutoLoading (ebUtil.getContextPath()+"/board/accSet.brd?view=tree&cmd=accSet"+(this.m_boardId==null?"":"&boardId="+this.m_boardId)+(this.m_bltnNo==null?"":"&bltnNo="+this.m_bltnNo)); 
			this.m_groupTree.load (ebUtil.getContextPath()+"/board/accSet.brd?view=tree&id=100&act=root&cmd=accSet"+(this.m_boardId==null?"":"&boardId="+this.m_boardId)+(this.m_bltnNo==null?"":"&bltnNo="+this.m_bltnNo)); 

		} else if (scope == "R") {
		
			this.m_roleTree = new dhtmlXTreeObject (document.getElementById('grugListDiv'),"100%","100%",0);
			this.m_roleTree.setImagePath (ebUtil.getContextPath()+"/dhtmlx/imgs/dhxtree_skyblue/");
			this.m_roleTree.enableCheckBoxes (1);
			this.m_roleTree.setOnClickHandler (this.nodeSelectOnRoleTree);
			this.m_roleTree.enableAutoTooltips (true);
			this.m_roleTree.setXMLAutoLoading (ebUtil.getContextPath()+"/board/accSet.brd?view=tree&cmd=accSet"+(this.m_boardId==null?"":"&boardId="+this.m_boardId)+(this.m_bltnNo==null?"":"&bltnNo="+this.m_bltnNo)); 
			this.m_roleTree.load (ebUtil.getContextPath()+"/board/accSet.brd?view=tree&id=10&act=root&cmd=accSet"+(this.m_boardId==null?"":"&boardId="+this.m_boardId)+(this.m_bltnNo==null?"":"&bltnNo="+this.m_bltnNo)); 
		
		} else if (scope == "U") {
			
			var param = "view=user";
			param += this.m_boardId == null ? "" : "&boardId="+this.m_boardId;
			param += this.m_bltnNo  == null ? "" : "&bltnNo="+this.m_bltnNo;
			var cntt = ebUtil.loadXMLDoc ("TEXT", "POST", ebUtil.getContextPath()+"/board/accSet.brd", param);
			document.getElementById("grugListDiv").innerHTML = cntt;
			
			this.setUserPageIterator();
		
		} else if (scope == "g") {
		
			var param = "view=grade";
			param += this.m_boardId == null ? "" : "&boardId="+this.m_boardId;
			param += this.m_bltnNo  == null ? "" : "&bltnNo="+this.m_bltnNo;
			var cntt = ebUtil.loadXMLDoc ("TEXT", "POST", ebUtil.getContextPath()+"/board/accSet.brd", param);
			document.getElementById("grugListDiv").innerHTML = cntt;
		}
	},
	setUserPageIterator : function () {
		
		var currentPage = document.userForm.pageNo.value;
		var totalPage   = document.userForm.totalPage.value;
		var setSize     = 10; // 하단 Page Iterator에서의 Navigation 갯수
		var imgUrl      = "./images/board/skin/enboard/";
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
			firstP = "<font onclick=ebEdit.getAccSetMngr().doUserSearch('1') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
			firstP += " onmouseout=this.style.textDecoration='none'><img src='"+imgUrl+afpImg+"' align=absmiddle border=0 alt='맨 앞 페이지로 가기'></font>";
			cursor = startPage - 1;
			prevSet = "<font onclick=ebEdit.getAccSetMngr().doUserSearch('"+cursor+"') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
			prevSet += " onmouseout=this.style.textDecoration='none'><img src='"+imgUrl+apsImg+"' align=absmiddle border=0 alt='열 페이지 앞으로 가기'></font>";
		} else {
			firstP  = "<img src='"+imgUrl+pfpImg+"' align=absmiddle border=0>"; 
			prevSet = "<img src='"+imgUrl+ppsImg+"' align=absmiddle border=0>"; 
		}
			
		cursor = startPage;
		while( cursor <= endPage ) {
			if( cursor == currentPage ) 
				curList += "<font color=#"+color+">"+currentPage+"</font>&nbsp;";
			else {
				curList += "<font onclick=ebEdit.getAccSetMngr().doUserSearch('"+cursor+"') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
				curList += " onmouseout=this.style.textDecoration='none'>"+cursor+"</font>&nbsp;";
			}
			
			cursor++;
		}
				 
		if ( totalPage > endPage) {
			lastP = "<font onclick=ebEdit.getAccSetMngr().doUserSearch('"+totalPage+"') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
			lastP += " onmouseout=this.style.textDecoration='none'><img src='"+imgUrl+alpImg+"' align=absmiddle border=0 alt='맨 끝 페이지로 가기'></font>";
			cursor = endPage + 1;  
			nextSet = "<font onclick=ebEdit.getAccSetMngr().doUserSearch('"+cursor+"') style='cursor:pointer' onmouseover=this.style.textDecoration='underline'";
			nextSet += " onmouseout=this.style.textDecoration='none'><img src='"+imgUrl+ansImg+"' align=absmiddle border=0 alt='열 페이지 뒤로 가기'></font>";
		} else {
			lastP  = "<img src='"+imgUrl+plpImg+"' align=absmiddle border=0>"; 
			nextSet = "<img src='"+imgUrl+pnsImg+"' align=absmiddle border=0>"; 
		}
		
		curList = firstP +"&nbsp;"+ prevSet +"&nbsp;&nbsp;"+ curList +"&nbsp;&nbsp;"+ nextSet +"&nbsp;"+ lastP;
		
		document.getElementById("userPageIterator").innerHTML = curList;
	},
	doUserSearch : function (pageNo) {
		if (pageNo != null) this.m_pageNo = pageNo;
		var frm = document.userForm;
		if (frm.srchUserId.value == ebUtil.getMessage('eb.info.ttl.l.id'))  frm.srchUserId.value = "";
		if (frm.srchNmKor.value  == ebUtil.getMessage('eb.info.ttl.l.name')) frm.srchNmKor.value = "";
		
		var param = "view=user";
		param += this.m_boardId == null ? "" : "&boardId="+this.m_boardId;
		param += this.m_bltnNo  == null ? "" : "&bltnNo="+this.m_bltnNo;
		param += "&pageNo="     + this.m_pageNo;
		param += "&pageSize="   + this.m_pageSize;
		param += "&srchUserId=" + frm.srchUserId.value;
		param += "&srchNmKor="  + frm.srchNmKor.value;
		var cntt = ebUtil.loadXMLDoc ("TEXT", "POST", ebUtil.getContextPath()+"/board/accSet.brd", param);
		document.getElementById("grugListDiv").innerHTML = cntt;
		
		this.setUserPageIterator();
		
		frm = document.userForm;
		if (frm.srchUserId.value == "") frm.srchUserId.value = ebUtil.getMessage('eb.info.ttl.l.id');
		if (frm.srchNmKor.value  == "") frm.srchNmKor.value  = ebUtil.getMessage('eb.info.ttl.l.name');
	},
	doUserSelect : function (idx) {
		document.getElementById("user_checkRow_"+idx).checked = !(document.getElementById("user_checkRow_"+idx).checked);
	},
	doGradeSelect : function (idx) {
		document.getElementById("grade_checkRow_"+idx).checked = !(document.getElementById("grade_checkRow_"+idx).checked);
	},
	addGrugList : function () {
		var entry = "";
		var grug = ebUtil.getCheckedValue (document.getElementsByName("scopeType"));
		if (grug == "G") {
			if (this.m_groupTree.getAllChecked() == null || this.m_groupTree.getAllChecked() == "") {
				alert("권한을 설정할 그룹을 선택하십시오.");
				return;
			}
			entry = this.m_groupTree.getAllChecked();
		} else if (grug == "R") {
			if (this.m_roleTree.getAllChecked() == null || this.m_roleTree.getAllChecked() == "") {
				alert("권한을 설정할 역할을 선택하십시오.");
				return;
			}
			entry = this.m_roleTree.getAllChecked();
		} else if (grug == "U") {
			if (!ebUtil.chkCheck (document.getElementsByName("user_checkRow"), '권한을 설정할 사용자를', true)) return;
			entry = ebUtil.getCheckedValues (document.getElementsByName("user_checkRow"));
		} else if (grug == "g") {
			if (!ebUtil.chkCheck (document.getElementsByName("grade_checkRow"), '권한을 설정할 등급을', true)) return;
			entry = ebUtil.getCheckedValues (document.getElementsByName("grade_checkRow"));
		}
		
		var bodyElm = document.getElementById ('baListBody');
	    var tagTR = null;
	    var tagTD = null;
		
		var cks = entry.split(",");
		var trs = bodyElm.children;
		var trIdx = trs.length / 3;
		for (var i=0; i<cks.length; i++) {
			var notExist = true;
			for (var j=0; j<trs.length; j++) {
				if (cks[i] == trs[j].getAttribute("prinId")) {
					notExist = false;
					break;
				}
			}
			if (notExist) {
				var accSetTemp = "";
			
				tagTR = document.createElement('tr');
				tagTD = document.createElement('td');
				tagTD.setAttribute ("height", "1");
				tagTD.setAttribute ("colspan", "3");
				tagTD.setAttribute("class", "adgridlimit");
				tagTD.setAttribute("className", "adgridlimit");
				tagTR.appendChild (tagTD);
				bodyElm.appendChild (tagTR);

				tagTR = document.createElement('tr');
				tagTR.setAttribute ("height", "22");
				tagTR.onmouseover = new Function ("ebUtil.activeLine(this,true)");
				tagTR.onmouseout = new Function ("ebUtil.activeLine(this,false)");
				tagTR.setAttribute ("prinId", cks[i]); // Keep 'PRINCIPAL_ID'!!
				accSetTemp = cks[i];
				tagTR.setAttribute ("style", "cursor:pointer");
				if (trIdx % 2 == 1) {
					tagTR.setAttribute("class", "adgridline");
					tagTR.setAttribute("className", "adgridline");
				}
				
				tagTD = document.createElement('td');
				tagTD.align = "center";
				tagTD.setAttribute("class", "adgrid");
				tagTD.setAttribute("className", "adgrid");
				if (grug == "G") {
					tagTD.innerHTML = "그룹";
					accSetTemp += ",그룹";
				} else if (grug == "R") {
					tagTD.innerHTML = "역할";
					accSetTemp += ",역할";
				} else if (grug == "U") {
					tagTD.innerHTML = "사용자";
					accSetTemp += ",사용자";
				} else if (grug == "g") {
					tagTD.innerHTML = "등급";
					accSetTemp += ",등급";
				}
				tagTR.appendChild (tagTD);
				
				tagTD = document.createElement('td');
				tagTD.setAttribute("class", "adgrid");
				tagTD.setAttribute("className", "adgrid");
				tagTD.align = "left";
				if (grug == "G") {
					tagTD.innerHTML = this.m_groupTree.getUserData(cks[i],"shortPath");
					accSetTemp += "," + this.m_groupTree.getUserData(cks[i],"shortPath");
				} else if (grug == "R") {
					tagTD.innerHTML = this.m_roleTree.getUserData(cks[i],"shortPath");
					accSetTemp += "," + this.m_roleTree.getUserData(cks[i],"shortPath");
				} else if (grug == "U") {
					var userElms = document.getElementsByName("user_checkRow");
					for (var k=0; k<userElms.length; k++) {
						if (userElms[k].value == cks[i]) {
							tagTD.innerHTML = userElms[k].getAttribute("userId");
							accSetTemp += "," + userElms[k].getAttribute("userId");
							break;
						}
					}
				} else {
					var gradeElms = document.getElementsByName("grade_checkRow");
					for (var k=0; k<gradeElms.length; k++) {
						if (gradeElms[k].value == cks[i]) {
							tagTD.innerHTML = gradeElms[k].getAttribute("gradeId");
							accSetTemp += "," + gradeElms[k].getAttribute("gradeId");
							break;
						}
					}
				}
				tagTR.appendChild (tagTD);
				
				tagTD = document.createElement('td');
				tagTD.setAttribute("class", "adgridlast");
				tagTD.setAttribute("className", "adgridlast");
				tagTD.align = "left";
				if (grug == "G") {
					tagTD.innerHTML = this.m_groupTree.getItemText(cks[i]);
					accSetTemp += "," + this.m_groupTree.getItemText(cks[i]);
				} else if (grug == "R") {
					tagTD.innerHTML = this.m_roleTree.getItemText(cks[i]);
					accSetTemp += "," + this.m_roleTree.getItemText(cks[i]);
				} else if (grug == "U") {
					var userElms = document.getElementsByName("user_checkRow");
					for (var k=0; k<userElms.length; k++) {
						if (userElms[k].value == cks[i]) {
							tagTD.innerHTML = userElms[k].getAttribute("userNm");
							accSetTemp += "," + userElms[k].getAttribute("userNm");
							break;
						}
					}
				} else if (grug == "g") {
					var gradeElms = document.getElementsByName("grade_checkRow");
					for (var k=0; k<gradeElms.length; k++) {
						if (gradeElms[k].value == cks[i]) {
							tagTD.innerHTML = gradeElms[k].getAttribute("gradeNm");
							accSetTemp += "," + gradeElms[k].getAttribute("gradeNm");
							break;
						}
					}
				}
				tagTR.appendChild (tagTD);
				
				bodyElm.appendChild (tagTR);
				
				tagTR = document.createElement('tr');
				tagTR.setAttribute ("height", "22");
				if (trIdx++ % 2 == 1) {
					tagTR.setAttribute("class", "adgridline");
					tagTR.setAttribute("className", "adgridline");
				}
				tagTR.setAttribute ("accSetTemp", accSetTemp);
				
				tagTD = document.createElement('td');
				tagTD.align = "center";
				tagTD.setAttribute("colspan", "3");
				tagTD.setAttribute("class", "adgridlast");
				tagTD.setAttribute("className", "adgridlast");
				var cntt = "";
				cntt += "<div style='float:left'><input type=checkbox id='accSet_"+cks[i]+"_0' name='accSet_"+cks[i]+"_0' value='bltnList'/>목록조회</div>";
				cntt += "<div style='float:left'><input type=checkbox id='accSet_"+cks[i]+"_1' name='accSet_"+cks[i]+"_1' value='bltnRead'/>글읽기</div>";
				cntt += "<div style='float:left'><input type=checkbox id='accSet_"+cks[i]+"_2' name='accSet_"+cks[i]+"_2' value='fileDown'/>파일다운로드</div>";
				cntt += "<div style='float:left'><input type=checkbox id='accSet_"+cks[i]+"_3' name='accSet_"+cks[i]+"_3' value='bltnReply'/>답글쓰기</div>";
				cntt += "<div style='float:left'><input type=checkbox id='accSet_"+cks[i]+"_4' name='accSet_"+cks[i]+"_4' value='memoWrite'/>댓글쓰기</div>";
				cntt += "<div style='float:left'><input type=checkbox id='accSet_"+cks[i]+"_5' name='accSet_"+cks[i]+"_5' value='memoReply'/>댓답글쓰기</div>";
			    tagTD.innerHTML = cntt;
				tagTR.appendChild (tagTD);

				bodyElm.appendChild (tagTR);
			}
		}
	},
	setAccSetInfo : function () {
		
		this.setAccSetTempList();
		
		var accSetInfo = "";
		var bodyElm = document.getElementById ('baListBody');
		var trs = bodyElm.children;
		for (var i=0; i<trs.length; i++) {
			var prinId = trs[i].getAttribute("prinId");
			if (prinId != null && prinId.length > 0) {
				var auths = "";
				for (j=0; j<6; j++) {
					auths += document.getElementById("accSet_"+prinId+"_"+j).checked ? "Y" : "N";
				}
				accSetInfo += prinId + "=" + auths + ";";
			}
		}
		document.setTransfer.accSetInfo.value = accSetInfo.substring (0,accSetInfo.length - 1); // 마지막 ';' 제거 후 할당.
		ebUtil.getPopupDialog().remove();
		if (document.getElementById("jweditor")) { // JWEditor 사용 시 가렸던 ActiveX 를 보이게 하기 위한 조치.
			document.getElementById("jweditor").style.display = "";
		}

	},
	setAccSetTempList : function () {
		
		var accSetTempList = "";
		var bodyElm = document.getElementById ('baListBody');
		var trs = bodyElm.children;
		for (var i=0; i<trs.length; i++) {
			var accSetTemp = trs[i].getAttribute("accSetTemp");
			if (accSetTemp != null && accSetTemp.length > 0) {
				var infos = accSetTemp.split(",");
				var auths = "";
				for (j=0; j<6; j++) {
					auths += document.getElementById("accSet_"+infos[0]+"_"+j).checked ? "Y" : "N";
				}
				accSetTempList += accSetTemp + "=" + auths + ";";
			}
		}
		if (accSetTempList.length > 0) document.getElementById("accSetTempList").value = accSetTempList.substring(0,accSetTempList.length - 1); // 마지막 ';' 제거 후 할당.
	}
}
var ebEdit = new enboard.edit();
var ebLangKnd = "ko";
//-->
