
var sjpbFile = null;
SjpbEditManager = function() {	
	this.limitCount  = 0;
	this.cmd         = '';
	this.totFileSize = 0;
	this.sizeSF      = '';
	this.limitSize   = 0;
	this.isCancel    = true;
	this.fileList    = '';//파일업로드화면 로딩시 화면상단 스크립트에서 초기화
	this.totDelFileList = '';
	this.initFlag = false;
}
SjpbEditManager.prototype = {	
	cmd         : null,
	limitCount  : null,	// 최대 파일첨부 갯수
	limitSize   : null,	// 최대 첨부용량(전체)
	totFileSize : null,	// 첨부된 파일의 전체 용량
	sizeSF      : null,	// 
	isCancel    : null,
	fileList    : null,
	totDelFileList : null, // 업로드된 파일 목록에서 빼온 삭제한다고 선택된 파일 목록 
	smarteditor : null,
	initFlag : null,
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 1. 편집화면 window.onload시 호출된다.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	init : function() {
		sjpbFile.vaultUploader = document.getElementById("vault_upload");
		sjpbFile.vaultUploader = new dhtmlXVaultObject({
			container:  "vault_upload",             // html container for vault
			uploadUrl:  "/sjpb/fileMngr?cmd=upload&rcptNum="+sjpbFile.rcptNum+"&subId=sub01",           // html4/html5 upload url
			autoStart : false,
			buttonUpload : false,
			buttonClear : true
		});
		sjpbFile.vaultUploader.setHeight(200);
		sjpbFile.vaultUploader.attachEvent("onBeforeFileAdd", function (file) {
			sjpbFile.currentUploadFileCnt++;
			sjpbFile.isNewFile = true;
			return true;
		});
		
		sjpbFile.vaultUploader.attachEvent("onBeforeFileRemove", function (file) {
			if (file.uploaded == true) {
				var curDelFileList = file.serverName + "-" + file.size + "|";
				var unDelFileList = "";
				sjpbFile.totDelFileList += curDelFileList;
				document.setFileList.vaccum.value   = 'DIRECT';
				document.setFileList.delList.value   = sjpbFile.totDelFileList;
				document.setFileList.unDelList.value = unDelFileList;				
				document.setFileList.submit();
			}
			sjpbFile.currentUploadFileCnt--;
			// 파일목록이 하나도 없으면 신규 파일이 없음으로 설정 2018.5.3
			if( sjpbFile.currentUploadFileCnt ==0) {
				sjpbFile.isNewFile = false;
			}
			return true;
		});
		
		sjpbFile.vaultUploader.setStrings({
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
				sjpbFile.vaultUploader.addFileRecord(fileInfo, "uploaded");
			});
		}
		

	
	
	
	// 업로드 파일 리스트 초기화
		if( document.setFileList != null && document.setFileList.list == null) {
			if (sjpbFile.fileList != null) {
				var text = "";
				var val = "";
				var split = sjpbFile.fileList.split("|");
				
				$(split).each(function (index, data) {
					if (data != null && data != "" ) {
						var ary = data.split("^");
						sjpbFile.rebuildFile(ary[0], ary[1], ary[2], ary[3], ary[4], ary[5]);
					}
				});
			}
			
			$("#uploadFileList").bind("mousedown", function (e) {
				e.metaKey = true;    
			}).selectable();
		}
			
		initFlag = true;
		return initFlag;
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
	rebuildFile : function (fileName, fileMask, fileSize) {
		if( sjpbFile.vaultUploader != null ) {
			var fileInfo = {
					name : fileName,
					serverName : fileMask,
					size : fileSize
				};

			sjpbFile.vaultUploader.addFileRecord(fileInfo, "uploaded");
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
	}
}

