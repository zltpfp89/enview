
var aNoticeMetadataManager = null;
// smarteditor
var oEditors = [];

NoticeMetadataManager = function(evSecurityCode)
{
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	this.m_validator = new enview.util.Validator();
	this.m_utility = new enview.util.Utility();
	this.m_contextPath = portalPage.getContextPath();
	this.m_selectRowIndex = 0;
	this.m_evSecurityCode = evSecurityCode;
	if( portalPage == null) portalPage = new enview.portal.Page();
	enviewMessageBox = new enview.portal.MessageBox(200, 100, 1000); 
}
NoticeMetadataManager.prototype =
{
	m_ajax : null,
	m_checkBox : null,
	m_validator : null,
	m_utility : null,
	m_contextPath : null,
	m_selectRowIndex : 0,
	m_dataStructure : null,
	m_evSecurityCode : null,
	uploadStatusSemaphore: "OFF",
	oFCKeditor : null, 
	smarteditor : null,
	
	init : function() { 
		
		this.m_dataStructure = [
			{"fieldName":"langKnd", "validation":""}
			,{"fieldName":"id", "validation":""}
			,{"fieldName":"noticeId", "validation":""}
			,{"fieldName":"title", "validation":"Required,MaxLength", "maxLength":"50"}
			,{"fieldName":"content", "validation":"Required"}
			
		]
		
		$(function() {
			this.smarteditor = document.getElementById("smarteditor");
		 	if( this.smarteditor) {
				nhn.husky.EZCreator.createInIFrame({
					oAppRef: oEditors,
					elPlaceHolder: "NoticeMetadataManager_content",
					sSkinURI: portalPage.getContextPath() + "/smarteditor/SmartEditor2Skin.html",	
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
						aNoticeMetadataManager.initSearch();
						aNoticeMetadataManager.doRetrieve();
						//예제 코드
						//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
					},
					fCreator: "createSEditor2"
				});
		 	} else {
				oFCKeditor = new FCKeditor( 'NoticeMetadataManager_content' ) ;
				oFCKeditor.BasePath= portalPage.getContextPath() +  "/fckeditor/";
//				oFCKeditor.BasePath = portalPage.getContextPath() + "/board/fckeditor/"
		        oFCKeditor.ToolbarSet = "NoticeMetadata";
//		        oFCKeditor.EditMode = "FCK_EDITMODE_SOURCE";
		        oFCKeditor.Height = 250;
		        oFCKeditor.ReplaceTextarea();
		 	}
//			$("#NoticeMetadataManager_propertyTabs").tabs();
		});
		
		$.datepicker.setDefaults({
			showMonthAfterYear: true,
			changeMonth: true,
			changeYear: true,
			showButtonPanel: true,
			showAnim : 'slideDown',
			dateFormat : 'yy-mm-dd'
		});
		
		
		
	},
	onSelectPropertyTab : function (id) {
		var param = "";	
		switch(id) {
			case 0 : 
				break;
		
		}
		
		return true; 
	},
	initSearch : function () {
		var formElem = document.forms[ "NoticeMetadataManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0;
	},
	doRetrieve : function () {
		//alert(1);
		this.doCreate();
		//alert(2);
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "NoticeMetadataManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/notice/noticeMetadata/listForAjax.admin", param, false, {success: function(data) { aNoticeMetadataManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		//alert(3);
		this.m_utility.setListData(
			"NoticeMetadataManager",
			new Array('id'),
			new Array('langKnd', 'title'),
			this.m_contextPath,
			resultObject);
		//alert(4);		
		if(resultObject.Data.length != 0) {
			this.doDefaultSelect(); 
		}
	},
	doPage : function (formName, pageNo)
	{
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = pageNo;
		
		this.m_selectRowIndex = 0;
		this.doRetrieve();
	},
	doSearch : function (formName)
	{
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = 1;
		
		this.m_selectRowIndex = 0;
		this.doRetrieve();
	},
	doSort : function (obj, sortColumn)
	{
		var formElem = document.forms[ "NoticeMetadataManager_SearchForm" ];
	    formElem.elements[ "sortColumn" ].value = sortColumn;
	    if( obj.ch % 2 == 0 ) {
			formElem.elements[ "sortMethod" ].value = "ASC";
	        obj.ch = 1;
	    }
	    else {
	        formElem.elements[ "sortMethod" ].value = "DESC";
	        obj.ch = 0;
	    }
		
		this.m_selectRowIndex = 0;
		this.doRetrieve();
	},
	doDefaultSelect : function ()
	{
		//alert(5);
		document.getElementById('NoticeMetadataManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "id=";
		param += document.getElementById('NoticeMetadataManager[' + this.m_selectRowIndex + '].id').value;
		
		this.m_ajax.send("POST", this.m_contextPath + "/notice/noticeMetadata/detailForAjax.admin", param, false, {success: function(data) { aNoticeMetadataManager.doSelectHandler(data); }}, 'text/json');
	},
	doSelect : function (obj)
	{
		var rowSeq = 0;
	    if(obj.nodeName=="SPAN") {
	        rowSeq = obj.parentNode.parentNode.getAttribute("ch");
	    }
	    else if(obj.nodeName=="TD") {
	        rowSeq = obj.parentNode.getAttribute("ch");
	    }
	    else if(obj.nodeName=="TR") {
	        rowSeq = obj.getAttribute("ch");
	    }
		
		this.m_selectRowIndex = rowSeq;
		
	    this.m_checkBox.unChkAll( document.getElementById("NoticeMetadataManager_ListForm") );
	    document.getElementById('NoticeMetadataManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "id=";
		param += document.getElementById('NoticeMetadataManager[' + rowSeq + '].id').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/notice/noticeMetadata/detailForAjax.admin", param, false, {success: function(data) { aNoticeMetadataManager.doSelectHandler(data); }}, 'text/json');
	},
	doSelectHandler : function(resultObject)
	{
		// clear file
		document.setUpload.reset();

		//this.m_utility.setFormDataFromXML(this.m_dataStructure, "NoticeMetadataManager", resultObject);
//		document.getElementById("NoticeMetadataManager_isCreate").value = "false";
//		document.getElementById("NoticeMetadataManager_id").value = this.m_ajax.retrieveElementValue("id", resultObject);
//		document.getElementById("NoticeMetadataManager_langKnd").value = this.m_ajax.retrieveElementValue("langKnd", resultObject);
//		document.getElementById("NoticeMetadataManager_title").value = this.m_ajax.retrieveElementValue("title", resultObject);
//		var temp = this.m_ajax.retrieveElementValue("content", resultObject);
		
		var metadata = resultObject.noticeMetadata;
//		alert( metaData);
//		alert( metaData.id + "," + metaData.langKnd + "," + metadata.content);
		document.getElementById("NoticeMetadataManager_isCreate").value = "false";
		document.getElementById("NoticeMetadataManager_id").value = metadata.id;
		document.getElementById("NoticeMetadataManager_langKnd").value = metadata.langKnd;
		document.getElementById("NoticeMetadataManager_title").value = metadata.title;
		
		// handle attach file
		attachFileManager.setFileList( metadata.fileList );
		
		// handle content
		var temp = metadata.content;
		/* var good = test.replace("&gt;",">");*/
		
		var temp =  temp.split("&gt;").join(">");
		temp =  temp.split("&lt;").join("<");
		temp =  temp.split("&amp;").join(" ");
		temp =  temp.split("&nbsp;").join(" ");
		temp =  temp.split("&#034;").join('"');
		temp =  temp.split("&#039;").join("'");
		temp =  temp.split("&#040;").join("(");
		temp =  temp.split("&#041;").join(")");
		temp =  temp.split("&#044;").join(",");
		
		document.getElementById("NoticeMetadataManager_content").value = temp;
		
		 if( smarteditor ) {
			oEditors.getById["NoticeMetadataManager_content"].exec("SET_IR", [temp]);
		 } else {
			var oEditor = FCKeditorAPI.GetInstance('NoticeMetadataManager_content') ;
		   	
			if ( oEditor.EditMode == FCK_EDITMODE_WYSIWYG)
			{
				//alert("no souce mode");
				oEditor.SwitchEditMode();
				oEditor.SetHTML(temp);
				oEditor.SwitchEditMode();
			}
		}
		/*var content = "<p><strong>&nbsp;�뗣뀑zzzz</strong></p>";	*/

		/*
		if( typeof(FCKeditorAPI) !== 'undefined' ) {
			var oEditor = FCKeditorAPI.GetInstance('NoticeMetadataManager_content') ;
			//var oEditor = new FCKeditor( 'NoticeMetadataManager_content' ) ;
			//var oEditor = this.m_oFCKeditor;
			if ( oEditor.EditMode == FCK_EDITMODE_WYSIWYG )
			{
				//alert("oEditor.EditMode = FCK_EDITMODE_WYSIWYG");
				//oEditor.EditMode = FCK_EDITMODE_SOURCE;
				oEditor.SwitchEditMode() ;
			}
			var content = this.m_ajax.retrieveElementValue("content", resultObject);
			oEditor.SetHTML( content );
			//oEditor.EditMode = FCK_EDITMODE_WYSIWYG;
			oEditor.SwitchEditMode() ;
		}
		*/

		document.getElementById("NoticeMetadataManager_id").readOnly = true;
		
		
		var propertyTabs = $("#NoticeMetadataManager_propertyTabs").tabs();
	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("NoticeMetadataManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		//this.m_utility.initFormData(this.m_dataStructure, "NoticeMetadataManager");
		document.getElementById("NoticeMetadataManager_isCreate").value = "true";
		document.getElementById("NoticeMetadataManager_title").value = "";
		document.getElementById("NoticeMetadataManager_content").value = "";
		document.getElementById("NoticeMetadataManager_content").value = "";
		/*
		if( typeof(FCKeditorAPI) !== 'undefined' ) {
			var oEditor = FCKeditorAPI.GetInstance('NoticeMetadataManager_content') ;
			oEditor.SetHTML( "" );
		}
		*/
		var propertyTabs = $("#NoticeMetadataManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	 
		document.getElementById("NoticeMetadataManager_noticeId").value = document.getElementById("NoticeMetadataManager_Master_noticeId").value; 
		document.getElementById("NoticeMetadataManager_id").readOnly = true;
		document.getElementById("NoticeMetadataManager_EditFormPanel").style.display = '';
	},
	doPreview : function() {
		if( smarteditor) {
			document.getElementById("NoticeMetadataManager_content").value = oEditors.getById["NoticeMetadataManager_content"].getIR();
		} else {
			var oEditor = FCKeditorAPI.GetInstance('NoticeMetadataManager_content');
			document.getElementById("NoticeMetadataManager_content").value = oEditor.GetXHTML(false);
		}
		aNoticeManager.doPreview();
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var isCreate = document.getElementById("NoticeMetadataManager_isCreate").value;
		var form = document.getElementById("NoticeMetadataManager_EditForm");
		
		if( smarteditor) {
			document.getElementById("NoticeMetadataManager_content").value = oEditors.getById["NoticeMetadataManager_content"].getIR();
		} else {
			var oEditor = FCKeditorAPI.GetInstance('NoticeMetadataManager_content');
			if ( oEditor.EditMode == FCK_EDITMODE_WYSIWYG)
			{
				  oEditor.SwitchEditMode();
				  var test = oEditor.GetXHTML(true);
				  //alert(test);
			}
			document.getElementById("NoticeMetadataManager_content").value = test;
		}
		
		
		var fileData = attachFileManager.getFileData();
//		alert( fileData.fileName + "\n" + fileData.fileMask + "\n" + fileData.fileSize);
		
		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		//var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param = "id=" + document.getElementById("NoticeMetadataManager_id").value;
		param += "&noticeId=" + document.getElementById("NoticeManager_noticeId").value;
        param += "&langKnd=" + encodeURIComponent( document.getElementById("NoticeMetadataManager_langKnd").value );
		param += "&title=" + encodeURIComponent( document.getElementById("NoticeMetadataManager_title").value );
		param += "&content=" + encodeURIComponent( document.getElementById("NoticeMetadataManager_content").value );
		var fileData = attachFileManager.getFileData();
		param += "&fileMask=" + encodeURIComponent( fileData.fileMask );
		param += "&fileName=" + encodeURIComponent( fileData.fileName );
		param += "&fileSize=" + encodeURIComponent( fileData.fileSize );
		
	
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/notice/noticeMetadata/addForAjax.admin", param, false, {
				success: function(data){
					aNoticeMetadataManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/notice/noticeMetadata/updateForAjax.admin", param, false, {
				success: function(data){
					aNoticeMetadataManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
					if(!smarteditor) {
						oEditor.SwitchEditMode();	
					}
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("NoticeMetadataManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('NoticeMetadataManager[' + rowCntArray[i] + '].id').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/notice/noticeMetadata/removeForAjax.admin", param, false, {
				success: function(data){
					aNoticeMetadataManager.initSearch();
					aNoticeMetadataManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
			
		}
	}
}


