var aPageStatisticsManagerTest = null;

PageStatisticsManagerTest = function()
{
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	this.m_validator = new enview.util.Validator();
	this.m_utility = new enview.util.Utility();
	this.m_contextPath = this.m_utility.getContextPath();
	this.m_selectRowIndex = 0;
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

	
	init : function() { 
		this.m_dataStructure = [
			 {"fieldName":"title", "validation":""}
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
			$("#PageStatisticsManager_propertyTabs").tabs();
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
	},
	getGroupChooser : function () {
		if( aGroupChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/group/listForChooser.admin", "", false, {
				success: function(data){
					//alert(data);
					document.getElementById("GroupManager_GroupChooser").innerHTML = data;
					aGroupChooser = new GroupChooser();
				}});
			
			//alert(data);
		}
		return aGroupChooser;
	},
	setGroupChooserCallback : function (rowArray) {
		document.getElementById("PageStatisticsManager_groupIdCond").value = rowArray[0].get("groupId");;
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
		//formElem.elements[ "pageSize" ].value = 100;
	},
	getTotalSessionCount : function () {
		this.m_ajax.send("POST", this.m_contextPath + "/currentSession/getTotalSessionCountForAjax.admin", "", false, 
			{
				success: function(data) { 
					//alert( data.totalSessionCount );
					document.getElementById("PageStatisticsManager_totalSession").value = data.totalSessionCount;
				}
			}
		);
	},
	doRetrieve : function () {
		var param = "";
		var formElem = document.forms[ "PageStatisticsManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
				alert(param);
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
		
			return null;
		}
		
		this.m_ajax.send("POST", this.m_contextPath + "/pageStatistics/listForAjax.admin", param, false, 
				{success: function(data) 
					{ 
							aPageStatisticsManagerTest.doRetrieveHandler(data); 
					}
		);
	},
	doRetrieveHandler : function( resultObject )
	{
		document.getElementById("PageStatisticsManager_totalHits").value = resultObject.totalHits;
		document.getElementById("PageStatisticsManager_totalMaxTime").value = resultObject.totalMaxTime;
		document.getElementById("PageStatisticsManager_totalMinTime").value = resultObject.totalMinTime;
		document.getElementById("PageStatisticsManager_totalAverageTime").value = Math.floor(resultObject.totalAverageTime);

		this.m_utility.setListData("PageStatisticsManager",new Array(),new Array('title', 'path', 'hits', 'maxTime', 'minTime', 'averageTime'),this.m_contextPath,resultObject);
		test("PageStatisticsManager",new Array(),new Array('title', 'path', 'hits', 'maxTime', 'minTime', 'averageTime'),this.m_contextPath,resultObject);
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
	    alert("호출2");
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
		var param = "";
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
		window.open(url);
	}
}

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
	},
	doRetrieveHandler : function( resultObject ) 
	{
		//alert(resultObject);
	       
		this.m_utility.setListData("PageStatisticsChooser",new Array(),new Array('title', 'path', 'hits', 'maxTime', 'minTime', 'averageTime'),this.m_contextPath,	resultObject);
		test("PageStatisticsChooser",new Array(),new Array('title', 'path', 'hits', 'maxTime', 'minTime', 'averageTime'),this.m_contextPath,resultObject);
		
	},
	doPage : function (formName, pageNo)
	{
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = pageNo;
		this.doRetrieve();
	},
	doSearch : function (formName)
	{
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
		
		if( this.m_parent != null ) 
		{
			this.m_checkBox.unChkAll( document.getElementById("PageStatisticsManager_ListForm") );
			document.getElementById('PageStatisticsChooser[' + rowSeq + '].checkRow').checked = true;
			this.m_parent.doApply();
			return;
		}
		
		$('#PageStatisticsManager_PageStatisticsChooser').dialog('close');
		
		if( this.m_sourceElement != null )
		{
			
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