var aPageStatisticsManager = null;


PageStatisticsManager = function(evSecurityCode)
{
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	this.m_validator = new enview.util.Validator();
	this.m_utility = new enview.util.Utility();
	this.m_contextPath = this.m_utility.getContextPath();
	this.m_selectRowIndex = 0;
	this.m_evSecurityCode = evSecurityCode;
	if( portalPage == null) portalPage = new enview.portal.Page();
	enviewMessageBox = new enview.portal.MessageBox(200, 100, 1000); 
}
PageStatisticsManager.prototype =
{
	m_ajax : null,
	m_checkBox : null,
	m_validator : null,
	m_utility : null,
	m_contextPath : null,
	m_selectRowIndex : 0,
	m_dataStructure : null,
	m_evSecurityCode : null,

	init : function() 
	{ 
		
		this.m_dataStructure = [
			{"fieldName":"domainNm", "validation":""}
			,{"fieldName":"title", "validation":""}
			,{"fieldName":"path", "validation":""}
			,{"fieldName":"hits", "validation":""}
			,{"fieldName":"maxTime", "validation":""}
			,{"fieldName":"minTime", "validation":""}
			,{"fieldName":"averageTime", "validation":""}
			,{"fieldName":"totalSession", "validation":""}
			,{"fieldName":"totalHits", "validation":""}
			,{"fieldName":"totalMaxTime", "validation":""}
			,{"fieldName":"totalMinTime", "validation":""}
			,{"fieldName":"totalAverageTime", "validation":""}
			
		]
		
		$(function() {
			$("#PageStatisticsManager_propertyTabs").tabs({
				beforeActivate: function( event, ui ) {
					if (barChart != null) {
						barChart.destructor();
					} 
					if (pieChart != null) {
						pieChart.destructor();
					}
				}, activate : function( event, ui) {
					aPageStatisticsManager.doRetrieve();
				}
			});
		});
		
		$.datepicker.setDefaults({
			showMonthAfterYear: true,
			changeMonth: true,
			changeYear: true,
			showButtonPanel: true,
			showAnim : 'slideDown',
			dateFormat : 'yy-mm-dd'
		});
		
		$('#PageStatisticsManager_startTimeStampCond').datepicker();	
		$('#PageStatisticsManager_endTimeStampCond').datepicker();	
		
		var nowStr = new Date().format("yyyy-MM-dd");
		document.getElementById("PageStatisticsManager_startTimeStampCond").value = nowStr;
		document.getElementById("PageStatisticsManager_endTimeStampCond").value = nowStr;
		
		this.getTotalSessionCount();
		this.doRetrieve();
	    
	},
	//조회조건 : 그룹ID선택		
	getGroupChooser : function () {
		var domainId = $('#PageStatisticsManager_domainCond').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId;
//		if( aGroupChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/group/listForChooser.admin", param, false, {
				success: function(data){document.getElementById("GroupManager_GroupChooser").innerHTML = data;aGroupChooser = new GroupChooser( aPageStatisticsManager.m_evSecurityCode, domainId, false );	//그룹ID를 한개만 선택할 수 있도록
				}});
//		}
		return aGroupChooser;
	},
	//조회조건 : 역할ID선택	
	getRoleChooser : function () {
		var domainId = $('#PageStatisticsManager_domainCond').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId + "&";
//		if( aRoleChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/role/listForChooser.admin", param, false, {
				success: function(data){
					//alert(data);
					document.getElementById("RoleManager_RoleChooser").innerHTML = data;
					aRoleChooser = new RoleChooser(aPageStatisticsManager.m_evSecurityCode, domainId, false);	//역할ID를 한개만 선택할 수 있도록
				}});
//		}
		return aRoleChooser;
	},	
	onSelectPropertyTab : function (id)
	{
		if(id==0)
			{
					pageStatisticsManager.doRetrieve();
			}
	},
	setGroupChooserCallback : function (rowArray) {
		if (rowArray == null) {
			document.getElementById("PageStatisticsManager_groupIdCond").value = "";
			document.getElementById("PageStatisticsManager_groupIdCond2").value = "";
		} else {
			document.getElementById("PageStatisticsManager_groupIdCond").value = rowArray[0].get("groupId");;
			document.getElementById("PageStatisticsManager_groupIdCond2").value = rowArray[0].get("title") + "(" + rowArray[0].get("groupId") + ")";			
		}
		document.getElementById("PageStatisticsManager_groupIdCond2").focus();
	},
	setRoleChooserCallback : function (rowArray) {
		if (rowArray == null) {
			document.getElementById("PageStatisticsManager_roleIdCond").value = "";
			document.getElementById("PageStatisticsManager_roleIdCond2").value = "";
		} else {
			document.getElementById("PageStatisticsManager_roleIdCond").value = rowArray[0].get("principalId");
			document.getElementById("PageStatisticsManager_roleIdCond2").value = rowArray[0].get("title") + "(" + rowArray[0].get("roleId") + ")";	
		}
		document.getElementById("PageStatisticsManager_roleIdCond2").focus();
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
		var formElem = document.forms[ "PageStatisticsManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
	},
	
	getTotalSessionCount : function () {
		var domainId = $('#PageStatisticsManager_domainCond').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		param += "&domainId=" + domainId;
		this.m_ajax.send("POST", this.m_contextPath + "/currentSession/getTotalSessionCountForAjax.admin", param, false, 
			{
				success: function(data) { 
					//alert( data.totalSessionCount );
					document.getElementById("PageStatisticsManager_totalSession").value = data.totalSessionCount;
				}
			}
		);
	},
	
	doRetrieve : function () {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "PageStatisticsManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		var std = null;
		var edd = null;
		var stdv = document.getElementById("PageStatisticsManager_startTimeStampCond").value;
		if( stdv != null ) {
			var stdvArray = stdv.split("-");
			std = new Date( stdvArray[0], stdvArray[1]-1, stdvArray[2], 0, 0, 0  );
		}
		var eddv = document.getElementById("PageStatisticsManager_endTimeStampCond").value;
		if( eddv != null ) {
			var eddvArray = eddv.split("-");
			edd = new Date( eddvArray[0], eddvArray[1]-1, eddvArray[2], 23, 59, 59 );
		}
		if( (edd.getTime()-std.getTime()) < 0 ) {
			alert(portalPage.getMessageResource('pt.ev.error.range.date'));
			return null;
		}
		
		this.m_ajax.send("POST", this.m_contextPath + "/pageStatistics/listForAjax.admin", param, false, {success: function(data) { aPageStatisticsManager.doRetrieveHandler(data); }});
		//alert(this.m_ajax.send);
	},
	doRetrieveHandler : function( resultObject ) {
		this.getTotalSessionCount();
		document.getElementById("PageStatisticsManager_totalHits").value = resultObject.totalHits;
		document.getElementById("PageStatisticsManager_totalMaxTime").value = resultObject.totalMaxTime;
		document.getElementById("PageStatisticsManager_totalMinTime").value = resultObject.totalMinTime;
		document.getElementById("PageStatisticsManager_totalAverageTime").value = Math.floor(resultObject.totalAverageTime);
		
		this.m_utility.setListData2("PageStatisticsManager",	new Array(),new Array('domainNm','title', 'path', 'hits', 'maxTime', 'minTime', 'averageTime'),this.m_contextPath,	resultObject);
		this.doCreateChart(resultObject);

	},
	doCreateChart : function (resultObject) {
		var result = resultObject.Data;
		chartDraw(result, "", "PageListBody_column", "PageListBody_pie");
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
		//alert("test");
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = 1;
		
		this.m_selectRowIndex = 0;
		this.doRetrieve();
	},
	doSort : function (obj, sortColumn)
	{
		var formElem = document.forms[ "PageStatisticsManager_SearchForm" ];
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
	
	onSelectPropertyTab : function ()
	{
		//this.doRetrieve();//alert("호출");
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
		
	    this.m_checkBox.unChkAll( document.getElementById("PageStatisticsManager_ListForm") );
	    document.getElementById('PageStatisticsManager[' + rowSeq + '].checkRow').checked = true;
	},
	doExportExcel : function() {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "PageStatisticsManager_SearchForm" ];
	    var formData = "";
	    for (var i=0; i < formElem.elements.length; i++) {
			var name = formElem.elements[ i ].name;
			var value = "";
			param += name + "=";
			if( name == "startTimeStampCond" ) {
				value = document.getElementById("PageStatisticsManager_startTimeStampCond").value;
			}
			else if( name == "endTimeStampCond" ) {
				value = document.getElementById("PageStatisticsManager_endTimeStampCond").value;
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
		var url = this.m_contextPath + "/pageStatistics/exportExcelForAjax.admin?" + param; 
		document.getElementById("exportExcelIF").src = url;
	}
}

/*
// 페이지 매니져 원본
var aPageStatisticsChooser = null;
PageStatisticsChooser = function(callback, parent)
{
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	if( portalPage == null) portalPage = new enview.portal.Page();
	this.m_selectRowIndex = 0;
	this.m_contextPath = this.m_utility.getContextPath();
	this.m_domElement = document.getElementById("PageStatisticsManager_PageStatisticsChooser");
	this.m_callback = callback;
	this.m_parent = parent;
	enviewMessageBox = new enview.portal.MessageBox(200, 100, 1000); 
	
	$("#PageStatisticsManager_PageStatisticsChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:540, 
		height:400,
		modal: true,
		buttons: {
			"Apply": function() {
				aPageStatisticsChooser.doApply();
			},
			Cancel: function() {
				$(this).dialog('close');
			}
		}
	});
	
	this.init();
}

PageStatisticsChooser.prototype =
{
	m_domElement : null,
	m_checkBox : null,
	m_sourceElement : null,
	m_callback : null,
	m_parent : null,
	
	init : function() {
		
	},
	whenSrchFocus : function ( obj, lvS ) {
		if( obj.value == lvS ) obj.value = "";
	},
	whenSrchBlur : function ( obj, lvS ) {
		if( obj.value == "" ) obj.value = lvS;
	},
	doShow : function (source)
	{
		if( source ) {
			this.m_sourceElement = source;
		}
		
		this.doRetrieve();
		$('#PageStatisticsManager_PageStatisticsChooser').dialog('open');
	},
	doRetrieve : function () {
		var param = "";
		var formElem = document.forms[ "PageStatisticsChooser_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/pageStatistics/listForAjax.admin", param, false, {success: function(data) { aPageStatisticsChooser.doRetrieveHandler(data); }});
		Chart_Value("PageStatisticsManager",	new Array(),new Array('title', 'path', 'hits', 'maxTime', 'minTime', 'averageTime'),this.m_contextPath,	resultObject);
	},
	doRetrieveHandler : function( resultObject ) {
		this.m_utility.setListData(
			"PageStatisticsChooser",
			new Array(),
			new Array('title', 'path', 'hits', 'maxTime', 'minTime', 'averageTime'),
			this.m_contextPath,
			resultObject);
	},
	doPage : function (formName, pageNo)
	{
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = pageNo;
		
		this.doRetrieve();
	},
	doSearch : function (formName)
	{
		//alert("test");
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = 1;
		
		this.doRetrieve();
	},
	doSort : function (obj, sortColumn)
	{
		var formElem = document.forms[ "PageStatisticsChooser_SearchForm" ];
	    formElem.elements[ "sortColumn" ].value = sortColumn;
	    if( obj.ch % 2 == 0 ) {
			formElem.elements[ "sortMethod" ].value = "ASC";
	        obj.ch = 1;
	    }
	    else {
	        formElem.elements[ "sortMethod" ].value = "DESC";
	        obj.ch = 0;
	    }
		
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
		
		if( this.m_parent != null ) {
			this.m_checkBox.unChkAll( document.getElementById("PageStatisticsManager_ListForm") );
			document.getElementById('PageStatisticsChooser[' + rowSeq + '].checkRow').checked = true;
			this.m_parent.doApply();
			return;
		}
		
		$('#PageStatisticsManager_PageStatisticsChooser').dialog('close');
		
		if( this.m_sourceElement != null ) {
			
		}
		else {
			var result = new Array(1);
			var rowMap = new Map();
			
			result[0] = rowMap;
			
			this.m_callback(result);
		}
	},
	getSelectedItems : function ()
	{
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("PageStatisticsChooser_ListForm") );
		if( rowCnts == "" ) return;
		
		var rowCntArray = rowCnts.split(",");
		if( rowCntArray.length > 0 ) {
			if( rowCntArray.length > 1 ) {
				alert( portalPage.getMessageResource('ev.info.select.onlyone') );
				return;
			}
			
			var result = new Array(rowCntArray.length);
			for(var i=0; i<rowCntArray.length; i++) {
				var rowMap = new Map();
			
				rowMap.put("id", document.getElementById('PageStatisticsChooser[' + rowCntArray[i] + '].id').value);	
				result[i] = rowMap;
			}
			
			return result;
		}
		
		return null;
	},
	doApply : function ()
	{
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("PageStatisticsChooser_ListForm") );
		if( rowCnts == "" ) return;
		
		var rowCntArray = rowCnts.split(",");
		if( rowCntArray.length > 0 ) {
			if( rowCntArray.length > 1 ) {
				alert( portalPage.getMessageResource('ev.info.select.onlyone') );
				return;
			}
			
			$('#PageStatisticsManager_PageStatisticsChooser').dialog('close');
			
			if( this.m_sourceElement != null ) {
				
			}
			else {
				var result = new Array(rowCntArray.length);
				for(var i=0; i<rowCntArray.length; i++) {
					var rowMap = new Map();
				
					result[i] = rowMap;
				}
				
				this.m_callback(result);
			}
		}
	}
}

*/