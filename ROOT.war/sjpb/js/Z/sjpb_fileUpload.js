
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
	isNewFile : false,
	isUploadedCheck : true,
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// 1. 편집화면 window.onload시 호출된다.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	init : function(appId) {
		if(appId == null){ appId = "common"; }
		sjpbFile.vaultUploader = document.getElementById("vault_upload");
		sjpbFile.vaultUploader = new dhtmlXVaultObject({
			container:  "vault_upload",             // html container for vault
			uploadUrl:  "/sjpb/fileMngr?cmd=upload&appId="+appId+"&rcptNum="+sjpbFile.rcptNum+"&subId=sub01",           // html4/html5 upload url
			autoStart : false,
			buttonUpload : false,
			buttonClear : true
		});
		sjpbFile.vaultUploader.setHeight(200);
		sjpbFile.vaultUploader.attachEvent("onBeforeFileAdd", function (file) {
			if(appId=="fax" && file.name.indexOf("pdf") == -1 && file.name.indexOf("PDF") == -1){
				alert("pdf 파일만 업로드 가능합니다.");
				return false;
			}
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
			if( sjpbFile.fileList.indexOf(data) > -1 )
				// DB에 저장된 목록중 삭제대상
				curDelFileList += data + '|';
			else
				// DB에 저장되지 않는 목록중 삭제대상
				unDelFileList += data + '|';
			isSelected = true;
		});

		if (isSelected) {
			if (confirm("선택된 파일을 삭제하시겠습니까?")) {
				sjpbFile.totDelFileList += curDelFileList;

				document.setFileList.vaccum.value   = 'DIRECT';
				document.setFileList.delList.value   = sjpbFile.totDelFileList;//기존에 있던 파일로 저장시 DB데이터 처리하는 파일목록
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
		if ( sjpbFile.vaultUploader ) {
			//파일 하나하나가 업로드될때마다 event
			sjpbFile.vaultUploader.attachEvent("onUploadFile", function (file, extra) {
				if(sjpbFile.isUploadedCheck){
					if(!file.uploaded) sjpbFile.isUploadedCheck = false;
				}
			});
			
			//모든 파일 업로드 후 event
			sjpbFile.vaultUploader.attachEvent("onUploadComplete", function (files) {
				if(sjpbFile.isUploadedCheck){
					// 파라미터로 받는 files에는 원파일명이 없다.(undefined)
					// getData로 받는 데이터에는 있음.(업로드 된 파일리스트)
					document.editForm.fileId.value = "";
					document.editForm.fileNm.value = "";
					document.editForm.fileSize.value = "";
					document.editForm.fileType.value = "";
					document.editForm.filePath.value = "";
					document.editForm.fileCtype.value = "";
					
					var fileList = sjpbFile.vaultUploader.getData();
					if (files.length > 0) {
						for (var i = 0 ; i < fileList.length ; i++) {
							document.editForm.fileId.value += fileList[i].serverName + "|";
							document.editForm.fileNm.value += fileList[i].name + "|";
							document.editForm.fileSize.value += fileList[i].size + "|";
							document.editForm.fileType.value += fileList[i].type + "|";
							document.editForm.filePath.value += fileList[i].path + "|";
							document.editForm.fileCtype.value += fileList[i].cType + "|";
						}
					}
					
					console.log(fileList);
					
					$("#fileCnt").val(fileList.length);

					sjpbFile.isNewFile = false;
					sjpbFile.isCancel = false;
				} else {
					sjpbFile.isCancel = true;
				}
				
				//저장하는 ajax에서 반드시 선언되어야하는 함수
				try {
					setFormSuccess();
				} catch (e) {
					console.log(e);
				}
			});
			
			if (sjpbFile.isNewFile) {
				sjpbFile.vaultUploader.upload();
			} else {
				document.editForm.fileId.value = "";
				document.editForm.fileNm.value = "";
				document.editForm.fileSize.value = "";
				document.editForm.fileType.value = "";
				document.editForm.filePath.value = "";
				document.editForm.fileCtype.value = "";
				
				var fileList = sjpbFile.vaultUploader.getData();
				if (fileList.length > 0) {
					for (var i = 0 ; i < fileList.length ; i++) {
						document.editForm.fileId.value += fileList[i].serverName + "|";
						document.editForm.fileNm.value += fileList[i].name + "|";
						document.editForm.fileSize.value += fileList[i].size + "|";
						document.editForm.fileType.value += fileList[i].type + "|";
						document.editForm.filePath.value += fileList[i].path + "|";
						document.editForm.fileCtype.value += fileList[i].cType + "|";
					}
				} else {
					document.editForm.fileId.value = "0";
					document.editForm.fileSize.value = "0";
				}
				
				$("#fileCnt").val(fileList.length);
				
				sjpbFile.isCancel = false;
				
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
			
			if( sjpbFile.limitCount > 0 && document.setUpload) {
				var totalLimit = sjpbFile.limitSize * 1;
				var maxSize = document.setUpload.totalsize.value * 1;
				if( maxSize > totalLimit ) {
					alert( '업로드 가능한 파일 용량을 초과하였습니다.');
					sjpbFile.isCancel = true;
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
			
			sjpbFile.isCancel = false;
		}
	}
}

