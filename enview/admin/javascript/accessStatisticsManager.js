
var aAccessStatisticsManager = null;
AccessStatisticsManager = function(evSecurityCode)
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
AccessStatisticsManager.prototype =
{
	m_ajax : null,
	m_checkBox : null,
	m_validator : null,
	m_utility : null,
	m_contextPath : null,
	m_selectRowIndex : 0,
	m_dataStructure : null,
	m_currentYear : null,
	m_currentMonth : null,
	m_currentDate : null,
	m_evSecurityCode : null,
	
	init : function() { 
		
		this.m_dataStructure = [
			 {"fieldName":"currentUser", "validation":""}
			,{"fieldName":"domainId", "validation":""}
			,{"fieldName":"todayUser", "validation":""}
			,{"fieldName":"averageUser", "validation":""}
			,{"fieldName":"accumulateUser", "validation":""}
			,{"fieldName":"registUser", "validation":""}
			,{"fieldName":"secessionUser", "validation":""}
			
		]
		
		$(function() {
			$("#AccessStatisticsManager_propertyTabs").tabs();
		});
		
		$.datepicker.setDefaults({
			showMonthAfterYear: true,
			changeMonth: true,
			changeYear: true,
			showButtonPanel: true,
			showAnim : 'slideDown',
			dateFormat : 'yy-mm-dd'
		});
		
		$('#AccessStatisticsManager_startTimeStampCond').datepicker();	
		$('#AccessStatisticsManager_endTimeStampCond').datepicker();	
		
		
		var now = new Date();
		this.m_currentYear = now.getYear();
		this.m_currentMonth = now.getMonth() + 1;
		this.m_currentDate = now.getDate();
		document.getElementById("AccessStatisticsManager_searchYear").value = this.m_currentYear;
		document.getElementById("AccessStatisticsManager_searchMonth").value = this.m_currentMonth;

		var nowStr = new Date().format("yyyy-MM-dd");
		document.getElementById("AccessStatisticsManager_startTimeStampCond").value = nowStr;
		document.getElementById("AccessStatisticsManager_endTimeStampCond").value = nowStr;
		//document.getElementById("AccessStatisticsManager_startTimeStampCond").value = this.m_currentYear + "-" + this.m_currentMonth + "-" + this.m_currentDate;
		//document.getElementById("AccessStatisticsManager_endTimeStampCond").value = this.m_currentYear + "-" + this.m_currentMonth + "-" + this.m_currentDate;
		
		this.getTotalSessionCount();
		this.onSelectPropertyTab(0);
	},
	getGroupChooser : function () {
		var domainId = $('#AccessStatisticsManager_domainCond').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId;
//		if( aGroupChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/group/listForChooser.admin", param, false, {
				success: function(data){
					//alert(data);
					document.getElementById("GroupManager_GroupChooser").innerHTML = data;
					aGroupChooser = new GroupChooser( aAccessStatisticsManager.m_evSecurityCode, domainId );
				}});
//		}
		return aGroupChooser;
	},
	setGroupChooserCallback : function (rowArray) {
		document.getElementById("AccessStatisticsManager_groupIdCond").value = rowArray[0].get("groupId");
		document.getElementById("AccessStatisticsManager_groupIdCond").focus();
	},
	onSelectPropertyTab : function (id) {
		switch( id ) {
			case 0:
				document.getElementById("AccessStatisticsManager.SELECT_DATE").style.display = "";
				document.getElementById("AccessStatisticsManager.SELECT_YEAR").style.display = "none";
				document.getElementById("AccessStatisticsManager.SELECT_MONTH").style.display = "none";
				document.getElementById("AccessStatisticsManager_queryType").value = 1;
				aAccessStatisticsManager.doRetrieveTime();
				break;
			case 1:
				document.getElementById("AccessStatisticsManager.SELECT_DATE").style.display = "none";
				document.getElementById("AccessStatisticsManager.SELECT_YEAR").style.display = "";
				document.getElementById("AccessStatisticsManager.SELECT_MONTH").style.display = "";
				document.getElementById("AccessStatisticsManager_queryType").value = 2;
				aAccessStatisticsManager.doRetrieveDay();
				break;
			case 2:
				document.getElementById("AccessStatisticsManager.SELECT_DATE").style.display = "none";
				document.getElementById("AccessStatisticsManager.SELECT_YEAR").style.display = "";
				document.getElementById("AccessStatisticsManager.SELECT_MONTH").style.display = "none";
				document.getElementById("AccessStatisticsManager_queryType").value = 3;
				aAccessStatisticsManager.doRetrieveMonth();
				break;
			case 3:
				document.getElementById("AccessStatisticsManager.SELECT_DATE").style.display = "none";
				document.getElementById("AccessStatisticsManager.SELECT_YEAR").style.display = "none";
				document.getElementById("AccessStatisticsManager.SELECT_MONTH").style.display = "none";
				document.getElementById("AccessStatisticsManager_queryType").value = 4;
				aAccessStatisticsManager.doRetrieveYear();
				break;
			case 4:
				document.getElementById("AccessStatisticsManager.SELECT_DATE").style.display = "none";
				document.getElementById("AccessStatisticsManager.SELECT_YEAR").style.display = "none";
				document.getElementById("AccessStatisticsManager.SELECT_MONTH").style.display = "none";
				document.getElementById("AccessStatisticsManager_queryType").value = 5;
				aAccessStatisticsManager.doRetrieveWeek();
		}
	},
	getTotalSessionCount : function () {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		this.m_ajax.send("POST", this.m_contextPath + "/currentSession/getTotalSessionCountForAjax.admin", param, false, 
			{
				success: function(data) { 
					//alert( data.totalSessionCount );
					document.getElementById("AccessStatisticsManager_currentUser").value = data.totalSessionCount;
				}
			}
		);
	},
	initSearch : function () {
		var formElem = document.forms[ "AccessStatisticsManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
	},
	doSearch : function (formName)
	{
		alert("호출");
		
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = 1;
		var queryType = formElem.elements[ "queryType" ].value;
		
		switch( queryType )
		{
			case "1": this.doRetrieveTime();
				break;
			case "2": this.doRetrieveDay();
				break;
			case "3": this.doRetrieveMonth();
				break;
			case "4": this.doRetrieveYear();
				break;
			case "5": this.doRetrieveWeek();
				break;
		}
	},
	getParam : function () {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "AccessStatisticsManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		var std = null;
		var edd = null;
		var stdv = document.getElementById("AccessStatisticsManager_startTimeStampCond").value;
		if( stdv != null ) {
			var stdvArray = stdv.split("-");
			std = new Date( stdvArray[0], stdvArray[1]-1, stdvArray[2], 0, 0, 0  );
		}
		var eddv = document.getElementById("AccessStatisticsManager_endTimeStampCond").value;
		if( eddv != null ) {
			var eddvArray = eddv.split("-");
			edd = new Date( eddvArray[0], eddvArray[1]-1, eddvArray[2], 23, 59, 59 );
		}
		if( (edd.getTime()-std.getTime()) < 0 ) {
			alert(portalPage.getMessageResource('pt.ev.error.range.date'));
			return null;
		}
		
		return param;
	},
	doRetrieveTime : function () {
		
		var param = this.getParam();
		
		alert(param);
		if( param == null ) return;
		this.m_ajax.send("POST", this.m_contextPath + "/accessStatistics/listForAjax.admin", param, false, {success: function(data) { aAccessStatisticsManager.doRetrieveTimeHandler(data); }});
	},
	doRetrieveTimeHandler : function( resultObject ) {
		//alert(this.m_ajax);
		var bodyElem = document.getElementById('AccessStatisticsManager.TimeListBody');
	    var tr_tag = null;
	    var td_tag = null;

		//var f = document.getElementById("AccessStatisticsManager.ListForm");

		for(; bodyElem.hasChildNodes(); )
			bodyElem.removeChild( bodyElem.childNodes[0] );
		
		for(i=0; i<resultObject.Data.length; i++) {
			tr_tag = document.createElement('tr');
			tr_tag.id = "AccessStatisticsManager.TimeListForm:Statistics[" + i + "]";
			tr_tag.setAttribute("ch", i);
			tr_tag.setAttribute("style", "cursor:pointer;");
			if( i % 2 == 0 ) {
				tr_tag.setAttribute("class", "even");
				tr_tag.setAttribute("className", "even");
			}
			else {
				tr_tag.setAttribute("class", "odd");
				tr_tag.setAttribute("className", "odd");
			}
			
			td_tag = document.createElement('td');
			td_tag.setAttribute("class", "webgridbody");
			td_tag.setAttribute("className", "webgridbody");
			td_tag.align = "left";
			switch( resultObject.Data[ i ].row ) {
				case "00" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">00" + portalPage.getMessageResource('pt.ev.property.item.time') + "~ 01" + portalPage.getMessageResource('pt.ev.property.item.time') + "</span>"; break;
				case "01" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">01" + portalPage.getMessageResource('pt.ev.property.item.time') + "~ 02" + portalPage.getMessageResource('pt.ev.property.item.time') + "</span>"; break;
				case "02" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">02" + portalPage.getMessageResource('pt.ev.property.item.time') + "~ 03" + portalPage.getMessageResource('pt.ev.property.item.time') + "</span>"; break;
				case "03" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">03" + portalPage.getMessageResource('pt.ev.property.item.time') + "~ 04" + portalPage.getMessageResource('pt.ev.property.item.time') + "</span>"; break;
				case "04" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">04" + portalPage.getMessageResource('pt.ev.property.item.time') + "~ 05" + portalPage.getMessageResource('pt.ev.property.item.time') + "</span>"; break;
				case "05" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">05" + portalPage.getMessageResource('pt.ev.property.item.time') + "~ 06" + portalPage.getMessageResource('pt.ev.property.item.time') + "</span>"; break;
				case "06" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">06" + portalPage.getMessageResource('pt.ev.property.item.time') + "~ 07" + portalPage.getMessageResource('pt.ev.property.item.time') + "</span>"; break;
				case "07" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">07" + portalPage.getMessageResource('pt.ev.property.item.time') + "~ 08" + portalPage.getMessageResource('pt.ev.property.item.time') + "</span>"; break;
				case "08" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">08" + portalPage.getMessageResource('pt.ev.property.item.time') + "~ 09" + portalPage.getMessageResource('pt.ev.property.item.time') + "</span>"; break;
				case "09" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">09" + portalPage.getMessageResource('pt.ev.property.item.time') + "~ 10" + portalPage.getMessageResource('pt.ev.property.item.time') + "</span>"; break;
				case "10" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">10" + portalPage.getMessageResource('pt.ev.property.item.time') + "~ 11" + portalPage.getMessageResource('pt.ev.property.item.time') + "</span>"; break;
				case "11" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">11" + portalPage.getMessageResource('pt.ev.property.item.time') + "~ 12" + portalPage.getMessageResource('pt.ev.property.item.time') + "</span>"; break;
				case "12" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">12" + portalPage.getMessageResource('pt.ev.property.item.time') + "~ 13" + portalPage.getMessageResource('pt.ev.property.item.time') + "</span>"; break;
				case "13" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">13" + portalPage.getMessageResource('pt.ev.property.item.time') + "~ 14" + portalPage.getMessageResource('pt.ev.property.item.time') + "</span>"; break;
				case "14" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">14" + portalPage.getMessageResource('pt.ev.property.item.time') + "~ 15" + portalPage.getMessageResource('pt.ev.property.item.time') + "</span>"; break;
				case "15" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">15" + portalPage.getMessageResource('pt.ev.property.item.time') + "~ 16" + portalPage.getMessageResource('pt.ev.property.item.time') + "</span>"; break;
				case "16" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">16" + portalPage.getMessageResource('pt.ev.property.item.time') + "~ 17" + portalPage.getMessageResource('pt.ev.property.item.time') + "</span>"; break;
				case "17" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">17" + portalPage.getMessageResource('pt.ev.property.item.time') + "~ 18" + portalPage.getMessageResource('pt.ev.property.item.time') + "</span>"; break;
				case "18" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">18" + portalPage.getMessageResource('pt.ev.property.item.time') + "~ 19" + portalPage.getMessageResource('pt.ev.property.item.time') + "</span>"; break;
				case "19" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">19" + portalPage.getMessageResource('pt.ev.property.item.time') + "~ 20" + portalPage.getMessageResource('pt.ev.property.item.time') + "</span>"; break;
				case "20" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">20" + portalPage.getMessageResource('pt.ev.property.item.time') + "~ 21" + portalPage.getMessageResource('pt.ev.property.item.time') + "</span>"; break;
				case "21" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">21" + portalPage.getMessageResource('pt.ev.property.item.time') + "~ 22" + portalPage.getMessageResource('pt.ev.property.item.time') + "</span>"; break;
				case "22" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">22" + portalPage.getMessageResource('pt.ev.property.item.time') + "~ 23" + portalPage.getMessageResource('pt.ev.property.item.time') + "</span>"; break;
				case "23" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">23" + portalPage.getMessageResource('pt.ev.property.item.time') + "~ 24" + portalPage.getMessageResource('pt.ev.property.item.time') + "</span>"; break;
			}
			tr_tag.appendChild( td_tag );
			
			td_tag = document.createElement('td');
			td_tag.setAttribute("class", "webgridbodylast");
			td_tag.setAttribute("className", "webgridbodylast");
			td_tag.align = "left";
			if( resultObject.Data[ i ].count ) {
				td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].count.label\">" +
								   "<img src=\"" + this.m_contextPath + "/admin/images/bar_l.gif\" height=\"12\" align=\"absmiddle\">" +
								   "<img src=\"" + this.m_contextPath + "/admin/images/bar.gif\" width=\"" + resultObject.Data[ i ].size + "\" height=\"12\" align=\"absmiddle\">" +
								   "<img src=\"" + this.m_contextPath + "/admin/images/bar_r.gif\" height=\"12\" align=\"absmiddle\">" +
								   "&nbsp;&nbsp;(" + resultObject.Data[ i ].count + ")</span>";
			}
			else {
				td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].count.label\">&nbsp;</span>";
			}
			tr_tag.appendChild( td_tag );
			
			bodyElem.appendChild( tr_tag );
		}
	},
	
	doRetrieveDay : function () {
		var param = this.getParam();
		//alert("param=" + param);
		if( param == null ) return;
		this.m_ajax.send("POST", this.m_contextPath + "/accessStatistics/listForAjax.admin", param, false, {success: function(data) { aAccessStatisticsManager.doRetrieveDayHandler(data); }});
	},
	doRetrieveDayHandler : function( resultObject ) {
		//alert(this.m_ajax);
		var bodyElem = document.getElementById('AccessStatisticsManager.DayListBody');
	    var tr_tag = null;
	    var td_tag = null;

		//var f = document.getElementById("AccessStatisticsManager.ListForm");

		for(; bodyElem.hasChildNodes(); )
			bodyElem.removeChild( bodyElem.childNodes[0] );
		
		for(i=0; i<resultObject.Data.length; i++) {
			tr_tag = document.createElement('tr');
			tr_tag.id = "AccessStatisticsManager.DayListForm:Statistics[" + i + "]";
			tr_tag.setAttribute("ch", i);
			tr_tag.setAttribute("style", "cursor:pointer;");
			if( i % 2 == 0 ) {
				tr_tag.setAttribute("class", "even");
				tr_tag.setAttribute("className", "even");
			}
			else {
				tr_tag.setAttribute("class", "odd");
				tr_tag.setAttribute("className", "odd");
			}
			
			td_tag = document.createElement('td');
			td_tag.setAttribute("class", "webgridbody");
			td_tag.setAttribute("className", "webgridbody");
			td_tag.align = "left";
			td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">" + resultObject.Data[ i ].row + portalPage.getMessageResource('pt.ev.property.item.day') + "</span>";
			tr_tag.appendChild( td_tag );
			
			td_tag = document.createElement('td');
			td_tag.setAttribute("class", "webgridbodylast");
			td_tag.setAttribute("className", "webgridbodylast");
			td_tag.align = "left";
			if( resultObject.Data[ i ].count ) {
				td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].count.label\">" +
								   "<img src=\"" + this.m_contextPath + "/admin/images/bar_l.gif\" height=\"12\" align=\"absmiddle\">" +
								   "<img src=\"" + this.m_contextPath + "/admin/images/bar.gif\" width=\"" + resultObject.Data[ i ].size + "\" height=\"12\" align=\"absmiddle\">" +
								   "<img src=\"" + this.m_contextPath + "/admin/images/bar_r.gif\" height=\"12\" align=\"absmiddle\">" +
								   "&nbsp;&nbsp;(" + resultObject.Data[ i ].count + ")</span>";
			}
			else {
				td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].count.label\">&nbsp;</span>";
			}
			tr_tag.appendChild( td_tag );
			
			bodyElem.appendChild( tr_tag );
		}
	},
	
	doRetrieveMonth : function () {
		var param = this.getParam();
		if( param == null ) return;
		this.m_ajax.send("POST", this.m_contextPath + "/accessStatistics/listForAjax.admin", param, false, {success: function(data) { aAccessStatisticsManager.doRetrieveMonthHandler(data); }});
	},
	doRetrieveMonthHandler : function( resultObject ) {
		//alert(this.m_ajax);
		var bodyElem = document.getElementById('AccessStatisticsManager.MonthListBody');
	    var tr_tag = null;
	    var td_tag = null;

		//var f = document.getElementById("AccessStatisticsManager.ListForm");

		for(; bodyElem.hasChildNodes(); )
			bodyElem.removeChild( bodyElem.childNodes[0] );
		for(i=0; i<resultObject.Data.length; i++) {
			tr_tag = document.createElement('tr');
			tr_tag.id = "AccessStatisticsManager.MonthListForm:Statistics[" + i + "]";
			tr_tag.setAttribute("ch", i);
			tr_tag.setAttribute("style", "cursor:pointer;");
			if( i % 2 == 0 ) {
				tr_tag.setAttribute("class", "even");
				tr_tag.setAttribute("className", "even");
			}
			else {
				tr_tag.setAttribute("class", "odd");
				tr_tag.setAttribute("className", "odd");
			}
			
			td_tag = document.createElement('td');
			td_tag.setAttribute("class", "webgridbody");
			td_tag.setAttribute("className", "webgridbody");
			td_tag.align = "left";
			td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">" + resultObject.Data[ i ].row + portalPage.getMessageResource('pt.ev.property.item.month') + "</span>";
			tr_tag.appendChild( td_tag );
			
			td_tag = document.createElement('td');
			td_tag.setAttribute("class", "webgridbodylast");
			td_tag.setAttribute("className", "webgridbodylast");
			td_tag.align = "left";
			if( resultObject.Data[ i ].count ) {
				td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].count.label\">" +
								   "<img src=\"" + this.m_contextPath + "/admin/images/bar_l.gif\" height=\"12\" align=\"absmiddle\">" +
								   "<img src=\"" + this.m_contextPath + "/admin/images/bar.gif\" width=\"" + resultObject.Data[ i ].size + "\" height=\"12\" align=\"absmiddle\">" +
								   "<img src=\"" + this.m_contextPath + "/admin/images/bar_r.gif\" height=\"12\" align=\"absmiddle\">" +
								   "&nbsp;&nbsp;(" + resultObject.Data[ i ].count + ")</span>";
			}
			else {
				td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].count.label\">&nbsp;</span>";
			}
			tr_tag.appendChild( td_tag );
			
			bodyElem.appendChild( tr_tag );
		}
	},
	
	doRetrieveYear : function () {
		var param = this.getParam();
		if( param == null ) return;
		this.m_ajax.send("POST", this.m_contextPath + "/accessStatistics/listForAjax.admin", param, false, {success: function(data) { aAccessStatisticsManager.doRetrieveYearHandler(data); }});
	},
	doRetrieveYearHandler : function( resultObject ) {
		//alert(this.m_ajax);
		var bodyElem = document.getElementById('AccessStatisticsManager.YearListBody');
	    var tr_tag = null;
	    var td_tag = null;

		//var f = document.getElementById("AccessStatisticsManager.ListForm");

		for(; bodyElem.hasChildNodes(); )
			bodyElem.removeChild( bodyElem.childNodes[0] );
		
		for(i=0; i<resultObject.Data.length; i++) {
			tr_tag = document.createElement('tr');
			tr_tag.id = "AccessStatisticsManager.YearListForm:Statistics[" + i + "]";
			tr_tag.setAttribute("ch", i);
			tr_tag.setAttribute("style", "cursor:pointer;");
			if( i % 2 == 0 ) {
				tr_tag.setAttribute("class", "even");
				tr_tag.setAttribute("className", "even");
			}
			else {
				tr_tag.setAttribute("class", "odd");
				tr_tag.setAttribute("className", "odd");
			}
			
			td_tag = document.createElement('td');
			td_tag.setAttribute("class", "webgridbody");
			td_tag.setAttribute("className", "webgridbody");
			td_tag.align = "left";
			td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">" + resultObject.Data[ i ].row + portalPage.getMessageResource('pt.ev.property.item.year') + "</span>";
			tr_tag.appendChild( td_tag );
			
			td_tag = document.createElement('td');
			td_tag.setAttribute("class", "webgridbodylast");
			td_tag.setAttribute("className", "webgridbodylast");
			td_tag.align = "left";
			if( resultObject.Data[ i ].count ) {
				td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].count.label\">" +
								   "<img src=\"" + this.m_contextPath + "/admin/images/bar_l.gif\" height=\"12\" align=\"absmiddle\">" +
								   "<img src=\"" + this.m_contextPath + "/admin/images/bar.gif\" width=\"" + resultObject.Data[ i ].size + "\" height=\"12\" align=\"absmiddle\">" +
								   "<img src=\"" + this.m_contextPath + "/admin/images/bar_r.gif\" height=\"12\" align=\"absmiddle\">" +
								   "&nbsp;&nbsp;(" + resultObject.Data[ i ].count + ")</span>";
			}
			else {
				td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].count.label\">&nbsp;</span>";
			}
			tr_tag.appendChild( td_tag );
			
			bodyElem.appendChild( tr_tag );
		}
	},
	
	doRetrieveWeek : function () {
		var param = this.getParam();
		if( param == null ) return;
		this.m_ajax.send("POST", this.m_contextPath + "/accessStatistics/listForAjax.admin", param, false, {success: function(data) { aAccessStatisticsManager.doRetrieveWeekHandler(data); }});
	},
	doRetrieveWeekHandler : function( resultObject ) {
		//alert(this.m_ajax);
		var bodyElem = document.getElementById('AccessStatisticsManager.WeekListBody');
	    var tr_tag = null;
	    var td_tag = null;

		//var f = document.getElementById("AccessStatisticsManager.ListForm");

		for(; bodyElem.hasChildNodes(); )
			bodyElem.removeChild( bodyElem.childNodes[0] );
		
		for(i=0; i<resultObject.Data.length; i++) {
			tr_tag = document.createElement('tr');
			tr_tag.id = "AccessStatisticsManager.WeekListForm:Statistics[" + i + "]";
			tr_tag.setAttribute("ch", i);
			tr_tag.setAttribute("style", "cursor:pointer;");
			if( i % 2 == 0 ) {
				tr_tag.setAttribute("class", "even");
				tr_tag.setAttribute("className", "even");
			}
			else {
				tr_tag.setAttribute("class", "odd");
				tr_tag.setAttribute("className", "odd");
			}
			
			td_tag = document.createElement('td');
			td_tag.setAttribute("class", "webgridbody");
			td_tag.setAttribute("className", "webgridbody");
			td_tag.align = "left";
			//td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">" + resultObject.Data[ i ].row + "</span>";
			
			switch( resultObject.Data[ i ].row ) {
				case "1" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">" + portalPage.getMessageResource('pt.ev.property.item.week.sun') + "</span>"; break;
				case "2" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">" + portalPage.getMessageResource('pt.ev.property.item.week.mon') + "</span>"; break;
				case "3" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">" + portalPage.getMessageResource('pt.ev.property.item.week.tue') + "</span>"; break;
				case "4" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">" + portalPage.getMessageResource('pt.ev.property.item.week.wed') + "</span>"; break;
				case "5" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">" + portalPage.getMessageResource('pt.ev.property.item.week.thu') + "</span>"; break;
				case "6" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">" + portalPage.getMessageResource('pt.ev.property.item.week.fri') + "</span>"; break;
				case "7" : td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].row.label\">" + portalPage.getMessageResource('pt.ev.property.item.week.sat') + "</span>"; break;
			}
			
			tr_tag.appendChild( td_tag );
			
			td_tag = document.createElement('td');
			td_tag.setAttribute("class", "webgridbodylast");
			td_tag.setAttribute("className", "webgridbodylast");
			td_tag.align = "left";
			if( resultObject.Data[ i ].count ) {
				td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].count.label\">" +
								   "<img src=\"" + this.m_contextPath + "/admin/images/bar_l.gif\" height=\"12\" align=\"absmiddle\">" +
								   "<img src=\"" + this.m_contextPath + "/admin/images/bar.gif\" width=\"" + resultObject.Data[ i ].size + "\" height=\"12\" align=\"absmiddle\">" +
								   "<img src=\"" + this.m_contextPath + "/admin/images/bar_r.gif\" height=\"12\" align=\"absmiddle\">" +
								   "&nbsp;&nbsp;(" + resultObject.Data[ i ].count + ")</span>";
			}
			else {
				td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"Statistic[" + i + "].count.label\">&nbsp;</span>";
			}
			tr_tag.appendChild( td_tag );
			
			bodyElem.appendChild( tr_tag );
		}
	}
}
