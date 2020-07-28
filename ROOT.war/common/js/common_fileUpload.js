<!--
if( ! window.common )
    window.common = new Object();

var oEditors = [];

common.file = function() {	
	this.limitCount  = 0;
	this.cmd         = '';
	this.totFileSize = 0;
	this.sizeSF      = '';
	this.limitSize   = 0;
	this.isCancel    = true;
	this.fileList    = '';//파일업로드화면 로딩시 화면상단 스크립트에서 초기화
	this.totDelFileList = '';
}
common.file.prototype = {	
	cmd         : null,
	limitCount  : null,	// 최대 파일첨부 갯수
	limitSize   : null,	// 최대 첨부용량(전체)
	totFileSize : null,	// 첨부된 파일의 전체 용량
	sizeSF      : null,	// 
	isCancel    : null,
	fileList    : null,
	totDelFileList : null, // 업로드된 파일 목록에서 빼온 삭제한다고 선택된 파일 목록 
	smarteditor : null,
	vaultUploader : null,
	currentUploadFileCnt : 0,
	isNewFile : false,
	isuploadedCheck : true,
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 1. 편집화면 window.onload시 호출된다.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	edit_init : function() {
		commonFile.cmd         = document.editForm.cmd.value;
		commonFile.limitCount  = document.editForm.maxFileCnt.value;
		commonFile.limitSize   = document.editForm.limitSize.value;
		commonFile.totFileSize = document.editForm.totFileSize.value;
		commonFile.sizeSF      = document.editForm.sizeSF.value;
		/*commonFile.smarteditor = document.getElementById("smarteditor");*/
		commonFile.vaultUploader = document.getElementById("vault_upload");
		
		if(commonFile.vaultUploader && commonFile.limitCount > 0){
			commonFile.vaultUploader = new dhtmlXVaultObject({
				container:  "vault_upload",             // html container for vault
				uploadUrl:  "/sjpb/fileMngr?cmd=upload",           // html4/html5 upload url
				autoStart : false,
				buttonUpload : false,
				buttonClear : true
			});
			
			commonFile.vaultUploader.setHeight(200);
			commonFile.vaultUploader.attachEvent("onBeforeFileAdd", function (file) {
				if (file.size > (commonFile.vaultUploader.getMaxFileSize() / commonFile.limitCount)) {
					alert( "첨부파일 용량 초과입니다." + (104857600 / commonFile.limitCount) );
					return false; 
				}
				
				if (commonFile.limitCount <= commonFile.currentUploadFileCnt) {
					alert( "파일첨부 개수를 초과했습니다." + commonFile.limitCount );
					return false; 
				}
				
				commonFile.currentUploadFileCnt++;
				commonFile.isNewFile = true;
				
				return true;
			});
			
			commonFile.vaultUploader.attachEvent("onBeforeFileRemove", function (file) {
				if (file.uploaded == true) {
					var curDelFileList = file.serverName + "-" + file.size + "|";
					var unDelFileList = "";
					
					commonFile.totDelFileList += curDelFileList;
					document.setFileList.vaccum.value   = 'DIRECT';
					document.setFileList.delList.value   = commonFile.totDelFileList;
					document.setFileList.unDelList.value = unDelFileList;
					document.setFileList.submit();
				}
				
				commonFile.currentUploadFileCnt--;
				// 파일목록이 하나도 없으면 신규 파일이 없음으로 설정 2018.5.3
				if( commonFile.currentUploadFileCnt ==0) {
					commonFile.isNewFile = false;
				}
				
				return true;
			});
			
			commonFile.vaultUploader.attachEvent("onUploadFail", function(file, extra){
				alert(extra.info);
			});
			
			commonFile.vaultUploader.setStrings({
				done:		"업로드됨",			// text under filename in files list
				error:		"오류발생",			// text under filename in files list
				btnAdd:		"파일추가",			// button "add files"
				btnUpload:	"파일업로드",			// button "upload"
				btnCancel:	"취소",				// button "cancel uploading"
				btnClean:	"초기화",				// button "clear all"
				dnd:		"여기에 파일을 놓으세요."	// dnd text while the user is dragging files
			});
			
			// 수정화면에서 파일 목록이 있을경우
			if ($("#vault_fileList > li").size() > 0) {
				$("#vault_fileList > li").each(function (i) {
					var fileData =  $(this).attr("data");
					var data = fileData.split("^");
					
					var fileInfo = {
						name : data[1],
						serverName : data[0],
						size : data[2],
						extra : {
							fileId : data[0],
							fileNm : data[1],
							fileSize : data[2],
							fileType : data[3],
							filePath : data[4],
							fileCtype : data[5]
						}
					};
					
					/*var fileInfo = {
						name : $(this).attr("data-name"),
						serverName : $(this).attr("data-mask"),
						size : $(this).attr("data-size")
					};*/
					
					commonFile.vaultUploader.addFileRecord(fileInfo, "uploaded");
				});
			}
		} else {
			// 업로드 파일 리스트 초기화
			if( document.setFileList != null && document.setFileList.list == null) {
				if (commonFile.fileList != null) {
					var text = "";
					var val = "";
					var split = commonFile.fileList.split("|");
					
					$(split).each(function (index, data) {
						if (data != null && data != "" ) {
							var ary = data.split("^");
							commonFile.rebuildFile(ary[0], ary[1], ary[2], ary[3], ary[4], ary[5]);
						}
					});
				}
				
				$("#uploadFileList").bind("mousedown", function (e) {
					e.metaKey = true;    
				}).selectable();
			}
			
			// 업로드 영역 drop 이벤트 설정.
			// 지원하는 브라우저만 할것
			// 파일이 drop 되면 input[type=file]에 넣고 uploadFile 실행
		}
	},
	edit_destroy : function() {
		var unDelFileList = '';
		// 취소시
		if (commonFile.isCancel && commonFile.limitCount > 0) {
			if( document.setFileList.list != null) {
				// list객체가 있으면 select를 사용하는 옛날 방식으로 사용한다.
				for( var i = 1; i < document.setFileList.list.options.length; i++ ) {
					if( document.setFileList.list.options[i].value.length > 0 ) {
						if( commonFile.cmd.indexOf('MODIFY') > -1 ) {
							if (commonFile.fileList.indexOf( document.setFileList.list.options[i].value) == -1)
								unDelFileList += document.setFileList.list.options[i].value + '|';
						} else
							unDelFileList += document.setFileList.list.options[i].value + '|';
					}
				}
			} else {
				// jquery-ui selectable을 사용한다.
				$("#uploadFileList .ui-selected").each( function(){
					var data =  $(this).attr('data');
					if( commonFile.cmd.indexOf('MODIFY') > -1 ) {
						if (commonFile.fileList.indexOf( data) == -1)
							unDelFileList += document.setFileList.list.options[i].value + '|';
					} else
						unDelFileList += document.setFileList.list.options[i].value + '|';
				});
			}

			document.setFileList.delList.value = unDelFileList;

		//저장시
		} else if (!commonFile.isCancel && commonFile.limitCount > 0) {
			document.setFileList.delList.value = commonFile.totDelFileList;
		}
		
		if (document.setFileList.delList.value.length > 0) {
			document.setFileList.vaccum.value = 'INDIRECT';
			// 삭제화면을 보여주려면 다음 두 라인을 살린다.
			//document.setFileList.target = 'popup';
			//window.open('about:blank', 'popup', 'width=200, height=50');
			document.setFileList.submit();
		}
	},
	loadXMLDoc : function(xmlOrText, reqMethod, svrUrl, queryStr, async, asyncMethod) {
		
		if (svrUrl == null) {
			alert("Can't request to server. URL of servers is null.");
			return;
		}
		
		// 동작하러 가기전에 화면에 있는 메시지를 먼저 삭제한다.
		try {
			document.getElementById("adminErrMsg").innerHTML = "";
		} catch(e) {console.log(e)}
		
		var xmlDoc;
		var req;
		if( window.XMLHttpRequest ) {
			req = new XMLHttpRequest();
			if( async ) {
				req.onload = asyncMethod;
				req.open( reqMethod, svrUrl, true );
				if (reqMethod == "POST") {
					req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); 
					req.send(queryStr);
				} else
					req.send( null );
				return;
			} else { 
				req.open( reqMethod, svrUrl, false );
				if (reqMethod == "POST") {
					req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); 
					req.send(queryStr);
				} else
					req.send( null );
			}
		} else if( window.ActiveXObject ) {
			req = new ActiveXObject( "Microsoft.XMLHTTP" );
			if( req ) {
				if( async ) {
					req.onload = asyncMethod;
					req.open( reqMethod, svrUrl, true );
					if (reqMethod == "POST") {
						req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); 
						req.send(queryStr);
					} else
						req.send( null );
					return;
				} else {
					req.open( reqMethod, svrUrl, false );
					if (reqMethod == "POST") {
						req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); 
						req.send(queryStr);
					} else
						req.send( null );
				}
			}
		}
		
		if( req ) {
			if( req.status == 200 ) {
				// enBoard의 로그인 화면은 항상 response header에 다음과 같은 데이터를 내려보내준다.
				// XMLHttpRequest로 요청했는데, session time out 등의 이유로 logout 되버리면
				// 이 때 정상적으로 브라우저 화면을 로그인 화면으로 보내기 위함이다. 08.02.28.KWShin.
				var control = req.getResponseHeader("enboard.ajax.control");
				if (control != null  && control.length > 0) {
					if (control == "NEED_ADMIN_LOGIN" || control == "ALERT_ADMIN_LOGIN") {
						var loginUrl = req.getResponseHeader("enboard.ajax.loginUrl");
						if (loginUrl != null && loginUrl.length > 0) {
							parent.window.location = loginUrl;
						} else {
							parent.window.location = "./";
						}
					} else if (control == "ADMIN_ERROR") {
						document.getElementById("adminErrMsg").innerHTML = req.responseText;
						return "ADMIN_ERROR";
					}
				}
				control = req.getResponseHeader ("enview.ajax.control");
				if (control != null && control.length > 0) {
					//alert("control=" + control);
					window.location.href = control;
				}
				if( xmlOrText == "XML" ) {
					xmlDoc = req.responseXML;
					if( xmlDoc && typeof xmlDoc.childNodes != "undefined" && xmlDoc.childNodes.length == 0 ) {
						xmlDoc = null;
					}
				} else {
					xmlDoc = req.responseText;
				}
			} else {
				alert( "There was a problem retrieving the response :\n" + req.status + "[" + req.statusText + "]" );
			}
		} else {
			alert( "Sorry. This browser isn\'t equipped to read response." );
		}
		
		return xmlDoc;
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 업로드 제한 파일 갯수를 체크하고, Progress bar 를 보이도록 한 뒤, 
	// setUpload 폼을 서브밋한다.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	uploadFile : function() {
		if( commonFile.limitCount > 0 ) {
			var uploadCount = 0;
			// jquery-ui selectable 사용
			uploadCount = $("#uploadFileList li").length;

			if( commonFile.limitCount <= uploadCount ) {
				alert( "업로드 가능한 파일 갯수는 "+commonFile.limitCount+" 개 입니다.");
				return;
			}
			
			if ($("#selectFileName").val() == null || $("#selectFileName").val() == "") {
				alert("파일을 선택후 추가 버튼을 클릭하세요.")
				return;
			}

			/*document.getElementById('uploading').style.display = 'inline';*/
			$(".loading").show();
			this.ebUploadStatusSemaphore = "ON";
			/*this.displayUploadStatus();*/
			document.setUpload.submit();
		}
	},
	handleUpload : function ( text, val) {
		var html = "<li data='" + val + "'><img src=\"/common/images/icon_file_small.gif\" alt=\"" + text + "\" /> " + text + "</li>";
		// list객체가 없으면 jquery-ui의 selectable을 사용한다.
		$("#uploadFileList").append( html );
		$("#fileCnt").val($("#uploadFileList li").length);
		$("#uploadFileList").bind("mousedown", function (e) {
			  e.metaKey = true;    
		 }).selectable();
		
		/*try {
			parent.iframe_autoresize($(parent.document).find("iframe"));
		} catch (e) {}
		*/
	},
	handleDelete : function ( deletedList) {
		// list객체가 없으면 jquery-ui selectable을 사용한다.
		var delList = "";
		$("#uploadFileList li").each( function(){
			var data =  $(this).attr('data');
			for( var i=0; i < deletedList.length;i++) {
				if( data==deletedList[i]) {
					delList += data + "|"
					$(this).remove();
				}
			}

			//2016.05.20 김승식 수정
			try
			{
				parent.document.setFileList.delList = delList;
			}
			catch(e)
			{
				document.setFileList.delList = delList;
			}
		});
	},
	closeUpload : function() {
		//document.getElementById('uploading').style.display = 'none';
		$(".loading").hide();
		this.ebUploadStatusSemaphore = "OFF";
		clearTimeout (this.ebUploadStatusTimeoutID);
	},
	displayUploadStatus : function () {
		// 1초에 한번씩 서버로 요청을 보내서, FileUpload 서블릿이 세션에 매달아주는 파일의 업로드 현황을
		// 읽어와서 화면에 보여준다.
		// 2012.06.21.KWShin.
		var contextPath ="";
		var offset = location.href.indexOf(location.host) + location.host.length;
		var uriStr = location.href.substring(offset);
		var pos = 0;
		if ((pos = uriStr.indexOf("/board")) >= 0) {
			contextPath = uriStr.substring(0,pos);
		} else if ((pos = uriStr.indexOf("/cafe")) >= 0) {
			contextPath = uriStr.substring(0,pos);
		} else if ((pos = uriStr.indexOf("/enboard")) >= 0) {
			contextPath = uriStr.substring(0,pos);
		}
		clearTimeout (this.ebUploadStatusTimeoutID);
		var uploadStatus = this.loadXMLDoc("TEXT", "GET", contextPath+"/board/resource/getUploadStatus.jsp");
		document.getElementById("uploadStatus").innerHTML = uploadStatus;
		if (this.ebUploadStatusSemaphore == "ON") {
			this.ebUploadStatusTimeoutID = setTimeout("commonFile.displayUploadStatus()", 500);
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

		// list객체가 없으면 query-ui selectable 사용
		$("#uploadFileList .ui-selected").each( function(){
			var data =  $(this).attr('data');
			if( commonFile.fileList.indexOf( data) > -1 )
				// DB에 저장된 목록중 삭제대상
				curDelFileList += data + '|';
			else
				// DB에 저장되지 않는 목록중 삭제대상
				unDelFileList += data + '|';
			isSelected = true;
		});

		if (isSelected) {
			if (confirm("선택된 파일을 삭제하시겠습니까?")) {
				commonFile.totDelFileList += curDelFileList;

				document.setFileList.vaccum.value   = 'DIRECT';
				document.setFileList.delList.value   = commonFile.totDelFileList;//기존에 있던 파일로 저장시 DB데이터 처리하는 파일목록
				document.setFileList.unDelList.value = unDelFileList;//등록-수정화면에서 실제로 삭제되는 파일목록				
				document.setFileList.submit();
			}
		} else
			alert('삭제하고자 하는 파일을 선택하세요');
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// '저장' 버튼을 눌렀을 때.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	setForm : function () {
		if ( commonFile.vaultUploader ) {
			//파일 하나하나가 업로드될때마다 event
			commonFile.vaultUploader.attachEvent("onUploadFile", function (file, extra) {
				if(commonFile.isUploadedCheck){
					if(!file.uploaded) commonFile.isUploadedCheck = false;
				}
			});
			
			//모든 파일 업로드 후 event
			commonFile.vaultUploader.attachEvent("onUploadComplete", function (files) {
				if(commonFile.isUploadedCheck){
					// 파라미터로 받는 files에는 원파일명이 없다.(undefined)
					// getData로 받는 데이터에는 있음.(업로드 된 파일리스트)
					document.editForm.fileId.value = "";
					document.editForm.fileNm.value = "";
					document.editForm.fileSize.value = "";
					document.editForm.fileType.value = "";
					document.editForm.filePath.value = "";
					document.editForm.fileCtype.value = "";
					
					var fileList = commonFile.vaultUploader.getData();
					
					if (files.length > 0) {
						for (var i = 0 ; i < fileList.length ; i++) {
							document.editForm.fileId.value += fileList[i].extra.fileId + "|";
							document.editForm.fileNm.value += fileList[i].extra.fileNm + "|";
							document.editForm.fileSize.value += fileList[i].extra.fileSize + "|";
							document.editForm.fileType.value += fileList[i].extra.fileType + "|";
							document.editForm.filePath.value += fileList[i].extra.filePath + "|";
							document.editForm.fileCtype.value += fileList[i].extra.fileCtype + "|";
						}
					}
					
					$("#fileCnt").val(fileList.length);
					
					commonFile.isNewFile = false;
					commonFile.isCancel = false;
				} else {
					commonFile.isCancel = true;
				}
				
				//저장하는 ajax에서 반드시 선언되어야하는 함수
				try {
					setFormSuccess();
				} catch (e) {
					console.log(e);
				}
			});
			
			if (commonFile.isNewFile) {
				commonFile.vaultUploader.upload();
			} else {
				document.editForm.fileId.value = "";
				document.editForm.fileNm.value = "";
				document.editForm.fileSize.value = "";
				document.editForm.fileType.value = "";
				document.editForm.filePath.value = "";
				document.editForm.fileCtype.value = "";
				
				var fileList = commonFile.vaultUploader.getData();
				
				if (fileList.length > 0) {
					for (var i = 0 ; i < fileList.length ; i++) {
						document.editForm.fileId.value += fileList[i].extra.fileId + "|";
						document.editForm.fileNm.value += fileList[i].extra.fileNm + "|";
						document.editForm.fileSize.value += fileList[i].extra.fileSize + "|";
						document.editForm.fileType.value += fileList[i].extra.fileType + "|";
						document.editForm.filePath.value += fileList[i].extra.filePath + "|";
						document.editForm.fileCtype.value += fileList[i].extra.fileCtype + "|";
					}
				} else {
					document.editForm.fileId.value = "0";
					document.editForm.fileSize.value = "0";
				}
				
				$("#fileCnt").val(fileList.length);
				
				commonFile.isCancel = false;
				
				//저장하는 ajax에서 반드시 선언되어야하는 함수
				try {
					setFormSuccess();
				} catch (e) {
					console.log(e);
				}
			}
		} else {
			document.editForm.fileId.value = "0";
			document.editForm.fileNm.value = "";
			document.editForm.fileSize.value = "0";
			document.editForm.fileType.value = "";
			document.editForm.filePath.value = "";
			document.editForm.fileCtype.value = "";
			
			$("#fileCnt").val($("#uploadFileList li").length);
			
			if( commonFile.limitCount > 0 && document.setUpload) {
				var totalLimit = commonFile.limitSize * 1;
				var maxSize = document.setUpload.totalsize.value * 1;
				if( maxSize > totalLimit ) {
					alert( '업로드 가능한 파일 용량을 초과하였습니다.');
					commonFile.isCancel = true;
					return;
				}
				
				// list객체가 없으면 jquery-ui selectable 사용
				$("#uploadFileList li").each( function(){
					var data = $(this).attr('data');
					var ary = data.split("^");
					document.editForm.fileId.value += ary[0] + "|";
					document.editForm.fileNm.value += ary[1] + "|";
					document.editForm.fileSize.value += ary[2] + "|";
					document.editForm.fileType.value += ary[3] + "|";
					document.editForm.filePath.value += ary[4] + "|";
					document.editForm.fileCtype.value += ary[5] + "|";
				});
				
				// DB에서 삭제할 파일 정보 입력
				document.editForm.delFileIds.value = "";
				var delFileList = document.setFileList.delList.value;
					if (delFileList != null && delFileList != "") {
					var delArr = delFileList.split("|");
					$(delArr).each(function (index, data) {
						var ary = data.split("^");
						
						document.editForm.delFileIds.value += ary[0] + "|";
					});
				}
			}				
			
			commonFile.isCancel = false;
			//document.editForm.submit();
		}
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// '저장' 버튼을 눌렀을 때.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	save : function () {
		/*try {
				// 에디터의 내용이 textarea에 적용됩니다.
				document.editForm.contents.value = oEditors.getById["editorCntt"].getIR();	
			
		} catch (ex) {
			// FCKeditor 를 사용하지 않는 경우에는...
			document.editForm.contents.value = document.getElementById('editorCntt').value;
		}
		if (document.getElementById("editorCnttMaxBytes")) { // 입력제한값이 있으면...
			
			var div = document.createElement("div"); 
			div.innerHTML = document.editForm.contents.value; 

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
		}*/
		
		document.editForm.fileId.value = "";
		document.editForm.fileNm.value = "";
		document.editForm.fileSize.value = "";
		document.editForm.fileType.value = "";
		document.editForm.filePath.value = "";
		document.editForm.fileCtype.value = "";
		if( commonFile.limitCount > 0 && document.setUpload) {
			var totalLimit = commonFile.limitSize * 1;
			var maxSize = document.setUpload.totalsize.value * 1;
//			alert("maxSize=["+maxSize+"], totalLimit=["+totalLimit+"]");
			if( maxSize > totalLimit ) {
				alert( '업로드 가능한 파일 용량을 초과하였습니다.');
				return;
			}
			
			// list객체가 없으면 jquery-ui selectable 사용
			$("#uploadFileList li").each( function(){
				var data = $(this).attr('data');
				var ary = data.split("^");
				document.editForm.fileId.value += ary[0] + "|";
				document.editForm.fileNm.value += ary[1] + "|";
				document.editForm.fileSize.value += ary[2] + "|";
				document.editForm.fileType.value += ary[3] + "|";
				document.editForm.filePath.value += ary[4] + "|";
				document.editForm.fileCtype.value += ary[5] + "|";
			});
			
			// DB에서 삭제할 파일 정보 입력
			document.editForm.delFileIds.value = "";
			var delFileList = document.setFileList.delList.value;
				if (delFileList != null && delFileList != "") {
				var delArr = delFileList.split("|");
				$(delArr).each(function (index) {
					var data =  $(this).attr('data');
					var ary = data.split("^");
					
					document.editForm.delFileIds.value += ary[0] + "|";
				});
			}
		}				
		
		commonFile.isCancel = false;
		document.editForm.submit();
	},
	limitUpload : function() {
		if( commonFile.limitCount > 0 ) {
			var uploadCount = 0;
			for(var i=1; i < document.setFileList.list.length; i++) {
				if( document.setFileList.list.options[i].value.length > 0 ) uploadCount++;
			}
			if( commonFile.limitCount <= uploadCount ) {
				alert( "업로드 가능한 파일 갯수는 "+commonFile.limitCount+" 개 입니다.");
				return false;
			}
		}
		return true;
	},
	rebuildFile : function (fileId, fileName, fileSize, fileType, filePath, fileCtype) {
		
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
		var val = fileId + "^" + fileName + "^" + fileSize + "^" + fileType + "^" + filePath + "^" + fileCtype;
		this.handleUpload( text, val);		
	}
}
var commonFile = new common.file();
//-->