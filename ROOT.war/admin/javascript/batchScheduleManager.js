
var aBatchScheduleManager = null;
BatchScheduleManager = function(evSecurityCode)
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
BatchScheduleManager.prototype =
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
			{"fieldName":"scheduleId", "validation":""}
			,{"fieldName":"actionId", "validation":"Required"}
			,{"fieldName":"actionName0", "validation":"Required"}
			,{"fieldName":"executeCycle", "validation":"Required"}
			,{"fieldName":"executeHour", "validation":""}
			,{"fieldName":"executeMin", "validation":""}
			,{"fieldName":"executeSec", "validation":""}
			,{"fieldName":"isLogging", "validation":""}
			,{"fieldName":"updUserId", "validation":""}
			,{"fieldName":"updDatim", "validation":""}
			
		]
		
		$(function() {
			$("#BatchScheduleManager_propertyTabs").tabs();
		});
		
	},
	getBatchActionChooser : function () {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		if( aBatchActionChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/batchAction/listForChooser.admin", param, false, {
				success: function(data){
					//alert(data);
					document.getElementById("BatchActionManager_BatchActionChooser").innerHTML = data;
					aBatchActionChooser = new BatchActionChooser( aBatchScheduleManager.m_evSecurityCode );
				}});
		}
		return aBatchActionChooser;
	},
	setBatchActionChooserCallback : function (rowArray) {
		document.getElementById("BatchScheduleManager_actionId").value = rowArray[0].get("actionId");
		document.getElementById("BatchScheduleManager_actionName0").value = rowArray[0].get("actionName");
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
		var formElem = document.forms[ "BatchScheduleManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "BatchScheduleManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/batchSchedule/listForAjax.admin", param, false, {success: function(data) { aBatchScheduleManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"BatchScheduleManager",
			new Array('scheduleId'),
			new Array('scheduleId', 'actionName0', 'updUserId', 'updDatim'),
			this.m_contextPath,
			resultObject);
				
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
		var formElem = document.forms[ "BatchScheduleManager_SearchForm" ];
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
		if( document.getElementById('BatchScheduleManager[' + this.m_selectRowIndex + '].checkRow') ) {
			document.getElementById('BatchScheduleManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
			
			var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		
			param += "scheduleId=";
			param += document.getElementById('BatchScheduleManager[' + this.m_selectRowIndex + '].scheduleId').value;
			
			this.m_ajax.send("POST", this.m_contextPath + "/batchSchedule/detailForAjax.admin", param, false, {success: function(data) { aBatchScheduleManager.doSelectHandler(data); }});
		}
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
		
	    this.m_checkBox.unChkAll( document.getElementById("BatchScheduleManager_ListForm") );
	    document.getElementById('BatchScheduleManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "scheduleId=";
		param += document.getElementById('BatchScheduleManager[' + rowSeq + '].scheduleId').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/batchSchedule/detailForAjax.admin", param, false, {success: function(data) { aBatchScheduleManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		//this.m_utility.setFormDataFromXML(this.m_dataStructure, "BatchScheduleManager", resultObject);
		document.getElementById("BatchScheduleManager_isCreate").value = false;
		document.getElementById("BatchScheduleManager_scheduleId").value = portalPage.getAjax().retrieveElementValue("scheduleId", resultObject);
		document.getElementById("BatchScheduleManager_actionName0").value = portalPage.getAjax().retrieveElementValue("actionName0", resultObject);
		document.getElementById("BatchScheduleManager_actionId").value = portalPage.getAjax().retrieveElementValue("actionId", resultObject);
		document.getElementById("BatchScheduleManager_executeCycle").value = portalPage.getAjax().retrieveElementValue("executeCycle", resultObject).trim();
		document.getElementById("BatchScheduleManager_executeHour").value = portalPage.getAjax().retrieveElementValue("executeHour", resultObject).trim();
		document.getElementById("BatchScheduleManager_executeMin").value = portalPage.getAjax().retrieveElementValue("executeMin", resultObject).trim();
		document.getElementById("BatchScheduleManager_executeSec").value = portalPage.getAjax().retrieveElementValue("executeSec", resultObject).trim();
		
		//alert("=" + portalPage.getAjax().retrieveElementValue("executeMin", resultObject) + "=");
		//alert(document.getElementById("BatchScheduleManager_executeMin").value);
		//alert(portalPage.getAjax().retrieveElementValue("executeSec", resultObject));
		//alert(document.getElementById("BatchScheduleManager_executeSec").value);
		
		var isLogging = portalPage.getAjax().retrieveElementValue("isLogging", resultObject);
		document.getElementById("BatchScheduleManager_isLogging").checked = (isLogging == "true") ? true : false;
		document.getElementById("BatchScheduleManager_updUserId").value = portalPage.getAjax().retrieveElementValue("updUserId", resultObject);
		document.getElementById("BatchScheduleManager_updDatim").value = portalPage.getAjax().retrieveElementValue("updDatim", resultObject);
	
		document.getElementById("BatchScheduleManager_scheduleId").readOnly = true;
		document.getElementById("BatchScheduleManager_actionId").readOnly = true;
		document.getElementById("BatchScheduleManager_updUserId").readOnly = true;
		document.getElementById("BatchScheduleManager_updDatim").readOnly = true;
		
		var executeDay = portalPage.getAjax().retrieveElementValue("executeDay", resultObject);
		var year = "";
		var month = "";
		var day = "";
		if( executeDay != null ) {
			year = executeDay.substring(0, 4);
			month = executeDay.substring(4, 6);
			day = executeDay.substring(6, 8);
		}
		
		var cycle = document.getElementById("BatchScheduleManager_executeCycle").value;
		if( cycle == "01" ) { // every day
			document.getElementById("BatchScheduleManager_selectYear").style.display = "none";
			document.getElementById("BatchScheduleManager_selectMonthDay").style.display = "none";
			document.getElementById("BatchScheduleManager_selectDay").style.display = "none";
			document.getElementById("BatchScheduleManager_selectWeek").style.display = "none";
		}
		else if( cycle == "02" ) { // every week
			document.getElementById("BatchScheduleManager_selectYear").style.display = "none";
			document.getElementById("BatchScheduleManager_selectMonthDay").style.display = "none";
			document.getElementById("BatchScheduleManager_selectDay").style.display = "none";
			document.getElementById("BatchScheduleManager_selectWeek").style.display = "";

			var executeWeeks = portalPage.getAjax().retrieveElementValue("executeWeeks", resultObject);
			if( executeWeeks != null ) {
				var executeWeekArray = executeWeeks.split(",");
				for(var i=0; i<executeWeekArray.length; i++) {
					document.getElementById("BatchScheduleManager_executeWeek" + executeWeekArray[i]).checked = true;
				}
			}
		}
		else if( cycle == "03" ) { // every month
			document.getElementById("BatchScheduleManager_selectYear").style.display = "none";
			document.getElementById("BatchScheduleManager_selectMonthDay").style.display = "none";
			document.getElementById("BatchScheduleManager_selectDay").style.display = "";
			document.getElementById("BatchScheduleManager_selectWeek").style.display = "none";
			
			document.getElementById("BatchScheduleManager_executeDay").value = day;
		}
		else if( cycle == "04" ) { // every year
			document.getElementById("BatchScheduleManager_selectYear").style.display = "none";
			document.getElementById("BatchScheduleManager_selectMonthDay").style.display = "";
			document.getElementById("BatchScheduleManager_selectDay").style.display = "none";
			document.getElementById("BatchScheduleManager_selectWeek").style.display = "none";
			
			document.getElementById("BatchScheduleManager_executeMonth").value = month;
			document.getElementById("BatchScheduleManager_executeMonthDay").value = day;
		}
		else if( cycle == "05" ) { // once
			document.getElementById("BatchScheduleManager_selectYear").style.display = "";
			document.getElementById("BatchScheduleManager_selectMonthDay").style.display = "none";
			document.getElementById("BatchScheduleManager_selectDay").style.display = "none";
			document.getElementById("BatchScheduleManager_selectWeek").style.display = "none";
			
			document.getElementById("BatchScheduleManager_executeYear").value = year;
			document.getElementById("BatchScheduleManager_executeYearMonth").value = month;
			document.getElementById("BatchScheduleManager_executeYearMonthDay").value = day;
		}
		else if( cycle == "06" ) { // every hour
			document.getElementById("BatchScheduleManager_selectYear").style.display = "none";
			document.getElementById("BatchScheduleManager_selectMonthDay").style.display = "none";
			document.getElementById("BatchScheduleManager_selectDay").style.display = "none";
			document.getElementById("BatchScheduleManager_selectWeek").style.display = "none";
			document.getElementById("BatchScheduleManager_selectHour").style.display = "";
			document.getElementById("BatchScheduleManager_selectMin").style.display = "";
		}
		else if( cycle == "07" ) { // every min
			document.getElementById("BatchScheduleManager_selectYear").style.display = "none";
			document.getElementById("BatchScheduleManager_selectMonthDay").style.display = "none";
			document.getElementById("BatchScheduleManager_selectDay").style.display = "none";
			document.getElementById("BatchScheduleManager_selectWeek").style.display = "none";
			document.getElementById("BatchScheduleManager_selectHour").style.display = "none";
			document.getElementById("BatchScheduleManager_selectMin").style.display = "";
		}
		
		var propertyTabs = $("#BatchScheduleManager_propertyTabs").tabs();
	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("BatchScheduleManager_EditFormPanel").style.display = '';
		
		$('#doRun').css('display', 'inline-block');
	},
	doCreate : function() 
	{
		document.getElementById("BatchScheduleManager_isCreate").value = true;
		document.getElementById("BatchScheduleManager_scheduleId").value = "";
		document.getElementById("BatchScheduleManager_actionName0").value = "";
		document.getElementById("BatchScheduleManager_actionId").value = "";
		document.getElementById("BatchScheduleManager_executeCycle").value = "01";
		document.getElementById("BatchScheduleManager_executeHour").value = "0";
		document.getElementById("BatchScheduleManager_executeMin").value = "0";
		document.getElementById("BatchScheduleManager_executeSec").value = "0";
		document.getElementById("BatchScheduleManager_isLogging").checked = true;
		
		document.getElementById("BatchScheduleManager_updUserId").value = "";
		document.getElementById("BatchScheduleManager_updDatim").value = "";
		
		document.getElementById("BatchScheduleManager_selectYear").style.display = "none";
		document.getElementById("BatchScheduleManager_selectMonthDay").style.display = "none";
		document.getElementById("BatchScheduleManager_selectDay").style.display = "none";
		document.getElementById("BatchScheduleManager_selectWeek").style.display = "none";
		
		var propertyTabs = $("#BatchScheduleManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	
		document.getElementById("BatchScheduleManager_scheduleId").readOnly = true;
		document.getElementById("BatchScheduleManager_EditFormPanel").style.display = '';
		
		$('#doRun').css('display', 'none');
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var isCreate = document.getElementById("BatchScheduleManager_isCreate").value;
		var form = document.getElementById("BatchScheduleManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		//var param = this.m_utility.getFormData(this.m_dataStructure, form);
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&actionId=" + document.getElementById("BatchScheduleManager_actionId").value;
		param += "&scheduleId=" + document.getElementById("BatchScheduleManager_scheduleId").value;
		param += "&executeCycle=" + document.getElementById("BatchScheduleManager_executeCycle").value;
		param += "&updUserId=" + document.getElementById("BatchScheduleManager_updUserId").value;
		param += "&executeHour=" + document.getElementById("BatchScheduleManager_executeHour").value;
		param += "&executeMin=" + document.getElementById("BatchScheduleManager_executeMin").value;
		param += "&executeSec=" + document.getElementById("BatchScheduleManager_executeSec").value;
		param += "&isLogging=" + document.getElementById("BatchScheduleManager_isLogging").checked;
		
		
		var cycle = document.getElementById("BatchScheduleManager_executeCycle").value;
		if( cycle == "01" ) { // every day
			
		}
		else if( cycle == "02" ) { // every week
			var executeWeeks = "";
			var isFirst = true;
			for(var i=1; i<=7; i++) {
				if( document.getElementById("BatchScheduleManager_executeWeek" + i).checked == true ) {
					if( isFirst == false ) executeWeeks += ",";
					executeWeeks += i;
					isFirst = false;
				}
			}
			if( executeWeeks.length > 0 ) {
				param += "&executeWeeks=" + executeWeeks;
			}
		}
		else if( cycle == "03" ) { // every month
			param += "&executeDay=000000" + document.getElementById("BatchScheduleManager_executeDay").value;
		}
		else if( cycle == "04" ) { // every year
			param += "&executeDay=0000" + 
				document.getElementById("BatchScheduleManager_executeMonth").value + 
				document.getElementById("BatchScheduleManager_executeMonthDay").value;
		}
		else if( cycle == "05" ) { // once
			param += "&executeDay=" + 
				document.getElementById("BatchScheduleManager_executeYear").value
				document.getElementById("BatchScheduleManager_executeYearMonth").value + 
				document.getElementById("BatchScheduleManager_executeYearMonthDay").value;
		}
	
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/batchSchedule/addForAjax.admin", param, false, {
				success: function(data){
					aBatchScheduleManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/batchSchedule/updateForAjax.admin", param, false, {
				success: function(data){
					aBatchScheduleManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
		
		$('#doRun').css('display', 'inline-block');
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("BatchScheduleManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode ;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('BatchScheduleManager[' + rowCntArray[i] + '].scheduleId').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/batchSchedule/removeForAjax.admin", param, false, {
				success: function(data){
					aBatchScheduleManager.m_selectRowIndex = 0;
					aBatchScheduleManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
			
		}
	},
	doChangeExecuteCycle : function (obj) {
		var cycle = obj.options[obj.selectedIndex].value;
		//alert("cycle=" + cycle);
		if( cycle == "01" ) { // every day
			document.getElementById("BatchScheduleManager_selectYear").style.display = "none";
			document.getElementById("BatchScheduleManager_selectMonthDay").style.display = "none";
			document.getElementById("BatchScheduleManager_selectDay").style.display = "none";
			document.getElementById("BatchScheduleManager_selectWeek").style.display = "none";
			document.getElementById("BatchScheduleManager_selectHour").style.display = "";
			document.getElementById("BatchScheduleManager_selectMin").style.display = "";
		}
		else if( cycle == "02" ) { // every week
			document.getElementById("BatchScheduleManager_selectYear").style.display = "none";
			document.getElementById("BatchScheduleManager_selectMonthDay").style.display = "none";
			document.getElementById("BatchScheduleManager_selectDay").style.display = "none";
			document.getElementById("BatchScheduleManager_selectWeek").style.display = "";
			document.getElementById("BatchScheduleManager_selectHour").style.display = "";
			document.getElementById("BatchScheduleManager_selectMin").style.display = "";
		}
		else if( cycle == "03" ) { // every month
			document.getElementById("BatchScheduleManager_selectYear").style.display = "none";
			document.getElementById("BatchScheduleManager_selectMonthDay").style.display = "none";
			document.getElementById("BatchScheduleManager_selectDay").style.display = "";
			document.getElementById("BatchScheduleManager_selectWeek").style.display = "none";
			document.getElementById("BatchScheduleManager_selectHour").style.display = "";
			document.getElementById("BatchScheduleManager_selectMin").style.display = "";
		}
		else if( cycle == "04" ) { // every year
			document.getElementById("BatchScheduleManager_selectYear").style.display = "none";
			document.getElementById("BatchScheduleManager_selectMonthDay").style.display = "";
			document.getElementById("BatchScheduleManager_selectDay").style.display = "none";
			document.getElementById("BatchScheduleManager_selectWeek").style.display = "none";
			document.getElementById("BatchScheduleManager_selectHour").style.display = "";
			document.getElementById("BatchScheduleManager_selectMin").style.display = "";
		}
		else if( cycle == "05" ) { // once
			document.getElementById("BatchScheduleManager_selectYear").style.display = "";
			document.getElementById("BatchScheduleManager_selectMonthDay").style.display = "none";
			document.getElementById("BatchScheduleManager_selectDay").style.display = "none";
			document.getElementById("BatchScheduleManager_selectWeek").style.display = "none";
			document.getElementById("BatchScheduleManager_selectHour").style.display = "";
			document.getElementById("BatchScheduleManager_selectMin").style.display = "";
		}
		else if( cycle == "06" ) { // every hour
			document.getElementById("BatchScheduleManager_selectYear").style.display = "none";
			document.getElementById("BatchScheduleManager_selectMonthDay").style.display = "none";
			document.getElementById("BatchScheduleManager_selectDay").style.display = "none";
			document.getElementById("BatchScheduleManager_selectWeek").style.display = "none";
			document.getElementById("BatchScheduleManager_selectHour").style.display = "";
			document.getElementById("BatchScheduleManager_selectMin").style.display = "";
			
		}
		else if( cycle == "07" ) { // every min
			document.getElementById("BatchScheduleManager_selectYear").style.display = "none";
			document.getElementById("BatchScheduleManager_selectMonthDay").style.display = "none";
			document.getElementById("BatchScheduleManager_selectDay").style.display = "none";
			document.getElementById("BatchScheduleManager_selectWeek").style.display = "none";
			document.getElementById("BatchScheduleManager_selectHour").style.display = "none";
			document.getElementById("BatchScheduleManager_selectMin").style.display = "";
		}
	},
	doRun : function() {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		param += "scheduleId=" + document.getElementById("BatchScheduleManager_scheduleId").value;
		this.m_ajax.send("POST", this.m_contextPath + "/batchSchedule/runScheduleForAjax.admin", param, false, {
			success: function(data){
				enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
			}});
	}
	
}

