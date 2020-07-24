
var attachFileManager = null;

$(function() {
	if( attachFileManager ==null) {
		attachFileManager = new AttachFileManager();
		attachFileManager.init();
	}
});

AttachFileManager = function(evSecurityCode)
{
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	this.m_validator = new enview.util.Validator();
	this.m_utility = new enview.util.Utility();
	this.m_contextPath = portalPage.getContextPath();
	this.m_selectRowIndex = 0;
	this.m_evSecurityCode = evSecurityCode;
	this.limitCount = 5;
	if( portalPage == null) portalPage = new enview.portal.Page();
	enviewMessageBox = new enview.portal.MessageBox(200, 100, 1000); 
}

AttachFileManager.prototype =
{
	m_ajax : null,
	m_checkBox : null,
	m_validator : null,
	m_utility : null,
	m_contextPath : null,
	m_evSecurityCode : null,
	uploadStatusSemaphore: "OFF",
	uploadStatusTimeoutID : null,
	limitCount : 5,
	init : function() { 
		$("#uploadFileList").bind("mousedown", function (e) {
		      e.metaKey = true;    
		 }).selectable();
	},
	
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 업로드 제한 파일 갯수를 체크하고, Progress bar 를 보이도록 한 뒤, 
	// setUpload 폼을 서브밋한다.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	uploadFile : function() {
			var uploadCount = 0;
			
			// jquery-ui selectable 사용
			uploadCount = $("#uploadFileList li").length;

			if( this.limitCount <= uploadCount ) {
				enviewMessageBox.doShow( portalPage.getMessageResource('ev.error.upload.limit.cnt') + '(' + this.limitCount + ')');
				return;
			}

//			if(!ebUtil.chkValue( document.setUpload.filename, ebUtil.getMessage('eb.info.ttl.o.file'), 'true')) return;
			if( document.setUpload.attachFile.value == '') {
				enviewMessageBox.doShow( portalPage.getMessageResource('ev.error.upload.file.select'));
				return;
			}
			document.getElementById('uploading').style.display = 'inline';
			this.uploadStatusSemaphore = "ON";
//			this.displayUploadStatus();
			document.setUpload.action = "/attachFile/fileMngr?cmd=upload";
			document.setUpload.submit();
	},
	
	handleUpload : function ( fileName, fileMask, fileSize, fileSizeSF) {
		var text = fileName + '(' + fileSizeSF + ')';
		var val = fileMask + '-' + fileSize;
		var totalSize = parseInt( document.setUpload.totalsize.value);
		totalSize += fileSize;
		document.setUpload.totalsize.value = totalSize;
		
		// list객체가 없으면 jquery-ui의 selectable을 사용한다.
		$("#uploadFileList").append( "<li data='" + val + "'>" + text + "</li>" );
		$("#uploadFileList").bind("mousedown", function (e) {
		      e.metaKey = true;    
		 }).selectable();
	},
	
	handleDelete : function ( deletedList) {
		// list객체가 없으면 jquery-ui selectable을 사용한다.
		$("#uploadFileList li").each( function(){
			var data =  $(this).attr('data');
			for( var i=0; i < deletedList.length;i++) {
				if( data==deletedList[i]) {
					$(this).remove();
				}
			}
		});
	},
	
	closeUpload : function() {
		document.getElementById('uploading').style.display = 'none';
		this.uploadStatusSemaphore = "OFF";
		clearTimeout (this.uploadStatusTimeoutID);
	},
	displayUploadStatus : function () {
		// 1초에 한번씩 서버로 요청을 보내서, FileUpload 서블릿이 세션에 매달아주는 파일의 업로드 현황을
		// 읽어와서 화면에 보여준다.
		// 2012.06.21.KWShin.
		clearTimeout (this.uploadStatusTimeoutID);
		this.m_ajax.send("POST", this.m_contextPath + "/board/resource/getUploadStatus.jsp", '', false, {
			success: function(data){
				document.getElementById("uploadStatus").innerHTML = data;
				if (this.uploadStatusSemaphore == "ON") {
					this.uploadStatusTimeoutID = setTimeout("aNoticeMetadataManager.displayUploadStatus()", 500);
				}
			}});
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 현재 선택된 파일을 전체 선택된 파일 목록에 추가하고, 
	// 전체 선택된 파일 목록과 선택되지 않은 파일 목록을 서브밋.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	deleteFile : function() {
		$("#uploadFileList .ui-selected").each( function(){
			var data =  $(this).remove();
			isSelected = true;
		});
		if (!isSelected) {
			//alert('삭제하고자 하는 파일을 선택하세요');
			alert(portalPage.getMessageResource('eb.info.select.file.delete'));
		}
		/*
		
		
		var isSelected = false;
		var curDelFileList = '';
		var unDelFileList = '';
		// list객체가 없으면 query-ui selectable 사용
		$("#uploadFileList .ui-selected").each( function(){
			var data =  $(this).attr('data');
			if( attachFileManager.fileList.indexOf( data) > -1 )
				// 방금 선택된 파일들을 전체 삭제 파일 리스트에 추가.
				curDelFileList += data + '|';
			else
				unDelFileList += data + '|';
			isSelected = true;
		});
		
		if (isSelected) {
			if (confirm(portalPage.getMessageResource('eb.info.confirm.del'))) {
				document.setUpload.action = "/attachFile/fileMngr?cmd=delete";
				attachFileManager.totDelFileList += curDelFileList;
				document.setFileList.vaccum.value   = 'DIRECT';
				document.setFileList.delList.value   = attachFileManager.totDelFileList;
				document.setFileList.unDelList.value = unDelFileList;				
				document.setFileList.submit();
			}
		} else
			//alert('삭제하고자 하는 파일을 선택하세요');
			alert(portalPage.getMessageResource('eb.info.select.file.delete'));
		*/	
	},
	
	getFileData : function() {
		var fileName = "";
		var fileMask = "";
		var fileSize = "";
		// list객체가 없으면 jquery-ui selectable 사용
		$("#uploadFileList li").each( function(){
			var data =  $(this).attr('data');
			var ary = data.split("-");
			fileMask += ary[0] + "|";
			fileSize += ary[1] + "|";
			// 파일명 뒤에 붙은 파일크기 정보를 잘라내고 순수한 파일명만 서버로 올린다.
			var manuFileNm = $(this).text();
			manuFileNm = manuFileNm.substring(0, manuFileNm.lastIndexOf("(")).trim();
			fileName += manuFileNm + "|";
		});
		
		var ret = {};
		ret.fileName = fileName;
		ret.fileMask = fileMask;
		ret.fileSize = fileSize;
		return ret;
	},
	setFileList : function( fileList) {
		// clear list
		var totalSize = 0;
		
		$("#uploadFileList").empty();
		for ( var i = 0; i < fileList.length; i++) {
			var file = fileList[i];
			var tags = "<li data='" + file.fileMask + '-' + file.fileSize + "'>" + file.fileName + "(" + file.fileSizeSF + ")" + "</li>" ;
			$("#uploadFileList").append( tags);
			totalSize += file.fileSize;
		}
		document.setUpload.totalsize.value = totalSize;
		
		$("#uploadFileList").bind("mousedown", function (e) {
		      e.metaKey = true;    
		 }).selectable();
	},
	limitUpload : function() {
		if( attachFileManager.limitCount > 0 ) {
			var uploadCount = $("#uploadFileList li").length;
			if( attachFileManager.limitCount <= uploadCount ) {
				alert( portalPage.getMessageResource('ev.error.upload.limit.cnt') + '(' + attachFileManager.limitCount + '}');
				return false;
			}
		}
		return true;
	},
	
	
}


