<!--
if( ! window.ekr_id )
    window.ekr_id = new Object();

var oEditors = [];

ekr_id.file = function() {	
	this.limitCount  = 0;
	this.cmd         = '';
	this.totFileSize = 0;
	this.sizeSF      = '';
	this.limitSize   = 0;
	this.isCancel    = true;
	this.fileList    = '';//파일업로드화면 로딩시 화면상단 스크립트에서 초기화
	this.totDelFileList = '';
}
ekr_id.file.prototype = {	
	cmd         : null,
	limitCount  : null,	// 최대 파일첨부 갯수
	limitSize   : null,	// 최대 첨부용량(전체)
	totFileSize : null,	// 첨부된 파일의 전체 용량
	sizeSF      : null,	// 
	isCancel    : null,
	fileList    : null,
	totDelFileList : null, // 업로드된 파일 목록에서 빼온 삭제한다고 선택된 파일 목록 
	smarteditor : null,
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 1. 편집화면 window.onload시 호출된다.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	edit_init : function() {
		ekrFile_id.cmd         = document.editForm_id.cmd.value;
		ekrFile_id.limitCount  = 1;
		ekrFile_id.limitSize   = document.editForm_id.limitSize.value;
		ekrFile_id.totFileSize = document.editForm_id.totFileSize.value;
		ekrFile_id.sizeSF      = document.editForm_id.sizeSF.value;
		
		// 업로드 파일 리스트 초기화
		if( document.setFileList_id != null && document.setFileList_id.list == null) {
			if (ekrFile_id.fileList != null) {
				var text = "";
				var val = "";
				var split = ekrFile_id.fileList.split("|");
				
				$(split).each(function (index, data) {
					if (data != null && data != "" ) {
						var ary = data.split("^");
						ekrFile_id.rebuildFile(ary[0], ary[1], ary[2], ary[3], ary[4], ary[5]);
					}
				});
			}
			
//			$("#uploadFileList_id").bind("mousedown", function (e) {
//				e.metaKey = true;    
//			}).selectable();
		}
		
		// 업로드 영역 drop 이벤트 설정.
		// 지원하는 브라우저만 할것
		// 파일이 drop 되면 input[type=file]에 넣고 uploadFile 실행
		
	},
	edit_destroy : function() {
		var unDelFileList = '';
		// 취소시
		if (ekrFile_id.isCancel && ekrFile_id.limitCount > 0) {
			if( document.setFileList_id.list != null) {
				// list객체가 있으면 select를 사용하는 옛날 방식으로 사용한다.
				for( var i = 1; i < document.setFileList_id.list.options.length; i++ ) {
					if( document.setFileList_id.list.options[i].value.length > 0 ) {
						if( ekrFile_id.cmd.indexOf('MODIFY') > -1 ) {
							if (ekrFile_id.fileList.indexOf( document.setFileList_id.list.options[i].value) == -1)
								unDelFileList += document.setFileList_id.list.options[i].value + '|';
						} else
							unDelFileList += document.setFileList_id.list.options[i].value + '|';
					}
				}
			} else {
				// jquery-ui selectable을 사용한다.
				$("#uploadFileList_id .ui-selected").each( function(){
					var data =  $(this).attr('data');
					if( ekrFile_id.cmd.indexOf('MODIFY') > -1 ) {
						if (ekrFile_id.fileList.indexOf( data) == -1)
							unDelFileList += document.setFileList_id.list.options[i].value + '|';
					} else
						unDelFileList += document.setFileList_id.list.options[i].value + '|';
				});
			}

			document.setFileList_id.delList.value = unDelFileList;

		//저장시
		} else if (!ekrFile_id.isCancel && ekrFile_id.limitCount > 0) {
			document.setFileList_id.delList.value = ekrFile_id.totDelFileList;
		}
		
		if (document.setFileList_id.delList.value.length > 0) {
			document.setFileList_id.vaccum.value = 'INDIRECT';
			// 삭제화면을 보여주려면 다음 두 라인을 살린다.
			//document.setFileList_id.target = 'popup';
			//window.open('about:blank', 'popup', 'width=200, height=50');
			document.setFileList_id.submit();
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
		if( ekrFile_id.limitCount > 0 ) {
			var uploadCount = 0;
			uploadCount = $("#uploadFileList_id li").length;

			if( ekrFile_id.limitCount <= uploadCount ) {
				alert( "업로드 가능한 파일 갯수는 "+ekrFile_id.limitCount+" 개 입니다.");
				return;
			}
			
			if ($("#selectFileName_id").val() == null || $("#selectFileName_id").val() == "") {
				alert("파일을 선택후 추가 버튼을 클릭하세요.");
				return;
			}
			$(".loading").show();
			this.ebUploadStatusSemaphore = "ON";
			document.setUpload_id.submit();
		}
	},
	handleUpload : function ( text, val) {
		var html = "<li data='" + val + "'><img src=\"/fss/reference/images/icon_file_small.gif\" alt=\"" + text + "\" /> " + text + "</li>";
		// list객체가 없으면 jquery-ui의 selectable을 사용한다.
		$("#uploadFileList_id").append( html );
		$("#editForm_id > #fileCnt").val($("#uploadFileList_id li").length);
//		$("#uploadFileList_id").bind("mousedown", function (e) {
//			  e.metaKey = true;    
//		 }).selectable();
		
		/*try {
			parent.iframe_autoresize($(parent.document).find("iframe"));
		} catch (e) {}
		*/
	},
	handleDelete : function ( deletedList) {
		// list객체가 없으면 jquery-ui selectable을 사용한다.
		var delList = "";
		$("#uploadFileList_id li").each( function(){
			var data =  $(this).attr('data');
			for( var i=0; i < deletedList.length;i++) {
				if( data==deletedList[i]) {
					delList += data + "|"
					$(this).remove();
				}
			}
			
			document.setFileList_id.delList = delList;
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
			this.ebUploadStatusTimeoutID = setTimeout("ekrFile_id.displayUploadStatus()", 500);
		}
	},
	
	fileUploadCallback:function (){
		$("#uploadFileList_id li").each( function(){
			$(this).remove();
		});
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
		$("#uploadFileList_id .ui-selected").each( function(){
			var data =  $(this).attr('data');
			if( ekrFile_id.fileList.indexOf( data) > -1 )
				// DB에 저장된 목록중 삭제대상
				curDelFileList += data + '|';
			else
				// DB에 저장되지 않는 목록중 삭제대상
				unDelFileList += data + '|';
			isSelected = true;
		});

		if (isSelected) {
			if (confirm("선택된 파일을 삭제하시겠습니까?")) {
				ekrFile_id.totDelFileList += curDelFileList;
				
				document.setFileList_id.vaccum.value   = 'DIRECT';
				document.setFileList_id.delList.value   = ekrFile_id.totDelFileList;//기존에 있던 파일로 저장시 DB데이터 처리하는 파일목록
				document.setFileList_id.unDelList.value = unDelFileList;//등록-수정화면에서 실제로 삭제되는 파일목록
				document.setFileList_id.submit();
			}
		} else
			alert('삭제하고자 하는 파일을 선택하세요');
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// '저장' 버튼을 눌렀을 때.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	setForm : function () {
		
		document.editForm_id.fileId.value = "";
		document.editForm_id.fileNm.value = "";
		document.editForm_id.fileSize.value = "0";
		document.editForm_id.fileType.value = "";
		document.editForm_id.filePath.value = "";
		document.editForm_id.fileCtype.value = "";
		$("#editForm_id > #fileCnt").val($("#uploadFileList_id li").length);
		if( ekrFile_id.limitCount > 0 && document.setUpload_id) {
			var totalLimit = ekrFile_id.limitSize * 1;
			var maxSize = document.setUpload_id.totalsize.value * 1;
			if( maxSize > totalLimit ) {
				alert( '업로드 가능한 파일 용량을 초과하였습니다.');
				ekrFile_id.isCancel = true;
				return;
			}
			
			// list객체가 없으면 jquery-ui selectable 사용
			$("#uploadFileList_id li").each( function(){
				var data = $(this).attr('data');
				var ary = data.split("^");
				document.editForm_id.fileId.value += ary[0] + "|";
				document.editForm_id.fileNm.value += ary[1] + "|";
				document.editForm_id.fileSize.value += ary[2] + "|";
				document.editForm_id.fileType.value += ary[3] + "|";
				document.editForm_id.filePath.value += ary[4] + "|";
				document.editForm_id.fileCtype.value += ary[5] + "|";
			});
			
			// DB에서 삭제할 파일 정보 입력
			document.editForm_id.delFileIds.value = "";
			var delFileList = document.setFileList_id.delList.value;
				if (delFileList != null && delFileList != "") {
				var delArr = delFileList.split("|");
				$(delArr).each(function (index, data) {
					var ary = data.split("^");
					
					document.editForm_id.delFileIds.value += ary[0] + "|";
				});
			}
		}				
		
		ekrFile_id.isCancel = false;
		//document.editForm_id.submit();
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// '저장' 버튼을 눌렀을 때.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	save : function () {
		/*try {
				// 에디터의 내용이 textarea에 적용됩니다.
				document.editForm_id.contents.value = oEditors.getById["editorCntt"].getIR();	
			
		} catch (ex) {
			// FCKeditor 를 사용하지 않는 경우에는...
			document.editForm_id.contents.value = document.getElementById('editorCntt').value;
		}
		if (document.getElementById("editorCnttMaxBytes")) { // 입력제한값이 있으면...
			
			var div = document.createElement("div"); 
			div.innerHTML = document.editForm_id.contents.value; 

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
		
		document.editForm_id.fileId.value = "";
		document.editForm_id.fileNm.value = "";
		document.editForm_id.fileSize.value = "";
		document.editForm_id.fileType.value = "";
		document.editForm_id.filePath.value = "";
		document.editForm_id.fileCtype.value = "";
		if( ekrFile_id.limitCount > 0 && document.setUpload_id) {
			var totalLimit = ekrFile_id.limitSize * 1;
			var maxSize = document.setUpload_id.totalsize.value * 1;
//			alert("maxSize=["+maxSize+"], totalLimit=["+totalLimit+"]");
			if( maxSize > totalLimit ) {
				alert( '업로드 가능한 파일 용량을 초과하였습니다.');
				return;
			}
			
			// list객체가 없으면 jquery-ui selectable 사용
			$("#uploadFileList_id li").each( function(){
				var data = $(this).attr('data');
				var ary = data.split("^");
				document.editForm_id.fileId.value += ary[0] + "|";
				document.editForm_id.fileNm.value += ary[1] + "|";
				document.editForm_id.fileSize.value += ary[2] + "|";
				document.editForm_id.fileType.value += ary[3] + "|";
				document.editForm_id.filePath.value += ary[4] + "|";
				document.editForm_id.fileCtype.value += ary[5] + "|";
			});
			
			// DB에서 삭제할 파일 정보 입력
			document.editForm_id.delFileIds.value = "";
			var delFileList = document.setFileList_id.delList.value;
				if (delFileList != null && delFileList != "") {
				var delArr = delFileList.split("|");
				$(delArr).each(function (index) {
					var data =  $(this).attr('data');
					var ary = data.split("^");
					
					document.editForm_id.delFileIds.value += ary[0] + "|";
				});
			}
		}				
		
		ekrFile_id.isCancel = false;
		document.editForm_id.submit();
	},
	limitUpload : function() {
		if( ekrFile_id.limitCount > 0 ) {
			var uploadCount = 0;
			for(var i=1; i < document.setFileList_id.list.length; i++) {
				if( document.setFileList_id.list.options[i].value.length > 0 ) uploadCount++;
			}
			if( ekrFile_id.limitCount <= uploadCount ) {
				alert( "업로드 가능한 파일 갯수는 "+ekrFile_id.limitCount+" 개 입니다.");
				return false;
			}
		}
		return true;
	},
	rebuildFile : function (fileId, fileName, fileSize, fileType, filePath, fileCtype) {
		
		var totalSize = eval("document.setUpload_id.totalsize.value");
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
	  
		document.setUpload_id.totalsize.value = totalSize;
		document.setUpload_id.viewsize.value = "TOTAL FILE SIZE : "+calsize+unit;
		
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
var ekrFile_id = new ekr_id.file();
//-->