
var aUserStatisticsManager = null;
UserStatisticsManager = function(evSecurityCode)
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
UserStatisticsManager.prototype =
{
	m_ajax : null,
	m_checkBox : null,
	m_validator : null,
	m_utility : null,
	m_contextPath : null,
	m_selectRowIndex : 0,
	m_dataStructure : null,
	m_evSecurityCode : null,
	
	init : function() { 
		
		this.m_dataStructure = [
			{"fieldName":"accessBrowser", "validation":""}
			,{"fieldName":"userIp", "validation":""}
			,{"fieldName":"orgName", "validation":""}
			,{"fieldName":"userId", "validation":""}
			,{"fieldName":"userName", "validation":""}
			,{"fieldName":"status", "validation":""}
			,{"fieldName":"timeStamp", "validation":""}
			,{"fieldName":"principalId", "validation":""}
			,{"fieldName":"orgCd", "validation":""}
			,{"fieldName":"elapsedTime", "validation":""}
			,{"fieldName":"extraInfo01", "validation":""}
			,{"fieldName":"extraInfo02", "validation":""}
			,{"fieldName":"extraInfo03", "validation":""}
			,{"fieldName":"extraInfo04", "validation":""}
			,{"fieldName":"extraInfo05", "validation":""}
			,{"fieldName":"domainId", "validation":""}
			
		]
		
		$(function() {
			$("#UserStatisticsManager_propertyTabs").tabs();
		});
		
		$.datepicker.setDefaults({
			showMonthAfterYear: true,
			changeMonth: true,
			changeYear: true,
			showButtonPanel: true,
			showAnim : 'slideDown',
			dateFormat : 'yy-mm-dd'
		});
		
		$('#UserStatisticsManager_startTimeStampCond').datepicker();	
		$('#UserStatisticsManager_endTimeStampCond').datepicker();	
		
		var now = new Date().format("yyyy-MM-dd");
		
		document.getElementById("UserStatisticsManager_startTimeStampCond").value = now;
		document.getElementById("UserStatisticsManager_endTimeStampCond").value = now;
		
		this.doRetrieve();
	},
	//조회조건 : 그룹ID선택	
	getGroupChooser : function () {
		var domainId = $('#UserStatisticsManager_domainCond').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId;
//		if( aGroupChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/group/listForChooser.admin", param, false, {
				success: function(data){
					document.getElementById("GroupManager_GroupChooser").innerHTML = data;
					aGroupChooser = new GroupChooser( aUserStatisticsManager.m_evSecurityCode, domainId, false );	//그룹ID를 한개만 선택할 수 있도록
				}});
//		}
		return aGroupChooser;
	},
	setGroupChooserCallback : function (rowArray) {
		if (rowArray == null) {
			document.getElementById("UserStatisticsManager_groupIdCond").value = "";
			document.getElementById("UserStatisticsManager_groupIdCond2").value = "";
		} else {
			document.getElementById("UserStatisticsManager_groupIdCond").value = rowArray[0].get("groupId");
			document.getElementById("UserStatisticsManager_groupIdCond2").value = rowArray[0].get("title") + "(" + rowArray[0].get("groupId") + ")";			
		}
		document.getElementById("UserStatisticsManager_groupIdCond2").focus();
	},
	//조회조건 : 역할ID선택	
	getRoleChooser : function () {
		var domainId = $('#UserStatisticsManager_domainCond').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId + "&";
//		if( aRoleChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/role/listForChooser.admin", param, false, {
				success: function(data){
					//alert(data);
					document.getElementById("RoleManager_RoleChooser").innerHTML = data;
					aRoleChooser = new RoleChooser(aUserStatisticsManager.m_evSecurityCode, domainId, false);	//역할ID를 한개만 선택할 수 있도록
				}});
//		}
		return aRoleChooser;
	},
	setRoleChooserCallback : function (rowArray) {
		if (rowArray == null) {
			document.getElementById("UserStatisticsManager_roleIdCond").value = "";
			document.getElementById("UserStatisticsManager_roleIdCond2").value = "";			
		} else {
			document.getElementById("UserStatisticsManager_roleIdCond").value = rowArray[0].get("principalId");
			document.getElementById("UserStatisticsManager_roleIdCond2").value = rowArray[0].get("title") + "(" + rowArray[0].get("roleId") + ")";			
		}
		document.getElementById("UserStatisticsManager_roleIdCond2").focus();
	},		
	onSelectPropertyTab : function (id) {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		switch(id) {
			case 0 : 
				break;
		
		}
		
		return true; 
	},
	initSearch : function () {
		var formElem = document.forms[ "UserStatisticsManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0;
	},
	doRetrieve : function () {
		var domainId = $('#UserManager_domainCond').val();
		if( domainId != undefined) {
			$('#UserStatisticsManager_domainCond').val( domainId);
		}
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "UserStatisticsManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		var std = null;
		var edd = null;
		var stdv = document.getElementById("UserStatisticsManager_startTimeStampCond").value;
		if( stdv != null ) {
			var stdvArray = stdv.split("-");
			std = new Date( stdvArray[0], stdvArray[1]-1, stdvArray[2], 0, 0, 0  );
		}
		var eddv = document.getElementById("UserStatisticsManager_endTimeStampCond").value;
		if( eddv != null ) {
			var eddvArray = eddv.split("-");
			edd = new Date( eddvArray[0], eddvArray[1]-1, eddvArray[2], 23, 59, 59 );
		}
		if( (edd.getTime()-std.getTime()) < 0 ) {
			alert(portalPage.getMessageResource('pt.ev.error.range.date'));
			return null;
		}
		this.m_ajax.send("POST", this.m_contextPath + "/userStatistics/listForAjax.admin", param, false, {success: function(data) { aUserStatisticsManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData2(
			"UserStatisticsManager",
			new Array(),
			new Array('domainNm', 'userId', 'userName', 'orgName', 'roleName', 'userIp', 'status', 'accessBrowser', 'timeStamp'),
			//new Array('accessBrowser','userIp','domainNm','orgName', 'roleName', 'userId', 'userName', 'status', 'timeStamp'),
			this.m_contextPath,
			resultObject);
				
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
		var formElem = document.forms[ "UserStatisticsManager_SearchForm" ];
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
		
	    this.m_checkBox.unChkAll( document.getElementById("UserStatisticsManager_ListForm") );
	    //document.getElementById('UserStatisticsManager[' + rowSeq + '].checkRow').checked = true;
	},
	doExportExcel : function() {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "UserStatisticsManager_SearchForm" ];
	    var formData = "";
	    for (var i=0; i < formElem.elements.length; i++) {
			var name = formElem.elements[ i ].name;
			var value = "";
			param += name + "=";
			if( name == "startTimeStampCond" ) {
				value = document.getElementById("UserStatisticsManager_startTimeStampCond").value;
			}
			else if( name == "endTimeStampCond" ) {
				value = document.getElementById("UserStatisticsManager_endTimeStampCond").value;
			}
			else {
				var tmp = formElem.elements[ i ].value;
				if( tmp.lastIndexOf("*") > 0 ) {
					value = "";
				}
				else {
					value = encodeURIComponent( tmp );
				}
			}
			param += value + "&";
	    }
		var url = this.m_contextPath + "/userStatistics/exportExcelForAjax.admin?" + param; 
		document.getElementById("exportExcelIF").src = url;
	}	
}
