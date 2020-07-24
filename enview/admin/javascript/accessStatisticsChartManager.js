/*window.onload = initPage;
function initPage()
{
	chart1="Column3D.swf";
}

function selectEvent(selectObj) 
{ 
	   selectObj.value;
	   chart1 = selectObj.value;
	   alert(selectObj.name+"선택됨");
	   
		switch(selectObj.name)
		{
			case "select1":
				 aAccessStatisticsManager.onSelectPropertyTab(0);
			break;
			
			case "select2":
				 aAccessStatisticsManager.onSelectPropertyTab(1);
			break;
			
			case "select3":
				 aAccessStatisticsManager.onSelectPropertyTab(2);
			break;
			
			case "select4":
				 aAccessStatisticsManager.onSelectPropertyTab(3);
			break;
			
			case "select5":
				 aAccessStatisticsManager.onSelectPropertyTab(3);
			break;
		}
}*/

var widthsize=document.body.clientWidth;
var heightsize=document.body.clientHeight;

function size1()
{
	//alert("리사이징");
	widthsize = document.body.clientWidth;
	heightsize = document.body.clientHeight;
	aAccessStatisticsManager.onSelectPropertyTab(0);
}

function size2()
{
	widthsize = document.body.clientWidth;
	heightsize = document.body.clientHeight;
	aAccessStatisticsManager.onSelectPropertyTab(1);
}

function size3()
{
	widthsize = document.body.clientWidth;
	heightsize = document.body.clientHeight;
	aAccessStatisticsManager.onSelectPropertyTab(2);
}

function size4()
{
	widthsize = document.body.clientWidth;
	heightsize = document.body.clientHeight;
	aAccessStatisticsManager.onSelectPropertyTab(3);
}
function size5()
{
	widthsize = document.body.clientWidth;
	heightsize = document.body.clientHeight;
	aAccessStatisticsManager.onSelectPropertyTab(4);
}

var aAccessStatisticsManager = null;
AccessStatisticsChartManager = function(evSecurityCode)
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
AccessStatisticsChartManager.prototype =
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
	m_selectedTabId : 0,
	
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
			$("#AccessStatisticsManager_propertyTabs").tabs({
				beforeActivate: function( event, ui ) {
					if (barChart != null) {
						barChart.destructor();
					} 
					if (pieChart != null) {
						pieChart.destructor();
					}
				}, activate : function( event, ui) {
					aAccessStatisticsManager.doSearch('AccessStatisticsManager_SearchForm');
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
		
		$('#AccessStatisticsManager_startTimeStampCond').datepicker();	
		$('#AccessStatisticsManager_endTimeStampCond').datepicker();	
		
		
		var now = new Date();
		this.m_currentYear = now.getFullYear();
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
	//조회조건 : 그룹ID선택	
	getGroupChooser : function () {
		var domainId = $('#AccessStatisticsManager_domainCond').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId;
//		if( aGroupChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/group/listForChooser.admin", param, false, {
				success: function(data){
					//alert(data);
					document.getElementById("GroupManager_GroupChooser").innerHTML = data;
					aGroupChooser = new GroupChooser( aAccessStatisticsManager.m_evSecurityCode, domainId, false );	//그룹ID를 한개만 선택할 수 있도록
				}});
//		}
		return aGroupChooser;
	},
	setGroupChooserCallback : function (rowArray) {
		if (rowArray == null) {
			document.getElementById("AccessStatisticsManager_groupIdCond").value = "";
			document.getElementById("AccessStatisticsManager_groupIdCond2").value = "";
			
		} else {
			document.getElementById("AccessStatisticsManager_groupIdCond").value = rowArray[0].get("groupId");
			document.getElementById("AccessStatisticsManager_groupIdCond2").value = rowArray[0].get("title") + "(" + rowArray[0].get("groupId") + ")";
		}
		document.getElementById("AccessStatisticsManager_groupIdCond2").focus();
	},
	//조회조건 : 역할ID선택	
	getRoleChooser : function () {
		var domainId = $('#AccessStatisticsManager_domainCond').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId + "&";
//		if( aRoleChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/role/listForChooser.admin", param, false, {
				success: function(data){
					//alert(data);
					document.getElementById("RoleManager_RoleChooser").innerHTML = data;
					aRoleChooser = new RoleChooser(aAccessStatisticsManager.m_evSecurityCode, domainId, false);		//역할ID를 한개만 선택할 수 있도록
				}});
//		}
		return aRoleChooser;
	},
	setRoleChooserCallback : function (rowArray) {
		if (rowArray == null) {
			document.getElementById("AccessStatisticsManager_roleIdCond").value = "";
			document.getElementById("AccessStatisticsManager_roleIdCond2").value = "";
		} else {
			document.getElementById("AccessStatisticsManager_roleIdCond").value = rowArray[0].get("principalId");
			document.getElementById("AccessStatisticsManager_roleIdCond2").value = rowArray[0].get("title") + "(" + rowArray[0].get("roleId") + ")";
		}
		document.getElementById("AccessStatisticsManager_roleIdCond2").focus();
	},			
	onSelectPropertyTab : function (id) {
		this.m_selectedTabId = id;
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
	doChange : function(){
		this.doRetrieve();
		var propertyTabs = $("#AccessStatisticsManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
		this.onSelectPropertyTab(0);
	},
	getTotalSessionCount : function () {
		var domainId = $('#AccessStatisticsManager_domainCond').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		param += "&domainId=" + domainId;
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
		var param = "";
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
	doCreateChart : function (type, resultObject) {
		var strXML = "";
		var arr = new Array();	
		var year = new Array();	
		var week = new Array("일요일","월요일","화요일","수요일","목요일","금요일","토요일");
		var data = resultObject.Data;
		switch (type) {
		case 1:		
			$(data).each(function (index) {
				this.row = parseInt(this.row) + "시";
				
//				this.row = parseInt('0' + this.row) + 1;
				/*
				if (parseInt(this.row) < 9) {
					this.row = this.row + "~0" + ( parseInt(this.row) + 1);
				} else {
					this.row = this.row + "~" + (parseInt(this.row) + 1);
				}
				*/
			});
			
			chartDraw(data, widthsize,"TimeListBody_column","TimeListBody_pie");
			break;
		case 2:
			window.onresize = size2;
			$(data).each(function (index) {
				this.row = parseInt(this.row) + '일';
//				this.row = parseInt(this.row);
			});
			chartDraw(data, widthsize, "DayListBody_column","DayListBody_pie");
			break;
		case 3:
			window.onresize = size3;
			$(data).each(function (index) {
					this.row = parseInt(this.row) + "월";
			});
			chartDraw(data, widthsize, "MonthListBody_column","MonthListBody_pie");
			break;
		case 4:
			window.onresize = size4;
			$(data).each(function (index) {
				this.row = this.row + "년";
			});
			chartDraw(data, widthsize, "YearListBody_column","YearListBody_pie");
			break;
		case 5:
			window.onresize = size5;
			$(data).each(function (index) {
				this.row = week[this.row-1];
			});
			chartDraw(data, widthsize, "WeekListBody_column","WeekListBody_pie");
			break;			
		default:
			break;
		}
	},
	doRetrieve : function(){
		var param = this.getParam();
		if( param == null ) return;
		param += "&evSecurityCode=" + this.m_evSecurityCode;
		this.m_ajax.send("POST", this.m_contextPath + "/accessStatistics/detailForAjax.admin", param, false, {success: function(data) { aAccessStatisticsManager.doRetrieveHandler(data); }});
	},
	
	doRetrieveHandler : function( resultObject ) {
		var domainId = resultObject.domainId;
		var domain = resultObject.domain;
		var domainNm = resultObject.domainNm;
		var todayAccessCount = resultObject.todayAccessCount;
		var averageAccessCount = resultObject.averageAccessCount;
		var accumulateAccessCount = resultObject.accumulateAccessCount;
		
		if(parseInt(domainId) == 0) {
			domain = "Domain Total";
			domainNm = "Domain Total";
		}
		$('#AccessStatisticsManager_domain').val(domain);
		$('#AccessStatisticsManager_domainNm').val(domainNm);
		this.getTotalSessionCount();
		$('#AccessStatisticsManager_todayUser').val(todayAccessCount);
		$('#AccessStatisticsManager_averageUser').val(averageAccessCount);
		$('#AccessStatisticsManager_accumulateUser').val(accumulateAccessCount);
		
	},
		
	doRetrieveTime : function () 
	{
		var param = this.getParam();
		if( param == null ) return;
		param += "&evSecurityCode=" + this.m_evSecurityCode;
		this.m_ajax.send("POST", this.m_contextPath + "/accessStatistics/chartDataForAjax.admin", param, false, {success: function(data) { aAccessStatisticsManager.doRetrieveTimeHandler(data); }});
    },
	doRetrieveTimeHandler : function(resultObject)
	{
		this.doRetrieveHandler(resultObject);
		window.onresize = size1;
		this.doCreateChart(1, resultObject);
	},        
	
	doRetrieveDay : function () {
		var param = this.getParam();
		//alert("param=" + param);
		if( param == null ) return;
		param += "&evSecurityCode=" + this.m_evSecurityCode;
		this.m_ajax.send("POST", this.m_contextPath + "/accessStatistics/chartDataForAjax.admin", param, false, {success: function(data) { aAccessStatisticsManager.doRetrieveDayHandler(data); }});
	},
	doRetrieveDayHandler : function( resultObject ) {
		this.doRetrieveHandler(resultObject);
		window.onresize = size2;
		this.doCreateChart(2, resultObject);	
	},
	
	doRetrieveMonth : function () {
		var param = this.getParam();
		if( param == null ) return;
		param += "&evSecurityCode=" + this.m_evSecurityCode;
		this.m_ajax.send("POST", this.m_contextPath + "/accessStatistics/chartDataForAjax.admin", param, false, {success: function(data) { aAccessStatisticsManager.doRetrieveMonthHandler(data); }});
	},
	
	doRetrieveMonthHandler : function(resultObject)  {
		this.doRetrieveHandler(resultObject);
		window.onresize = size3;
		this.doCreateChart(3, resultObject);
    },
	
	doRetrieveYear : function () {
		var param = this.getParam();
		if( param == null ) return;
		param += "&evSecurityCode=" + this.m_evSecurityCode;
		this.m_ajax.send("POST", this.m_contextPath + "/accessStatistics/chartDataForAjax.admin", param, false, {success: function(data) { aAccessStatisticsManager.doRetrieveYearHandler(data); }});
	},
	
	//년도별 현황
	doRetrieveYearHandler : function( resultObject ) {
		this.doRetrieveHandler(resultObject);
		this.doCreateChart(4, resultObject);
	},
	
	doRetrieveWeek : function () {
		var param = this.getParam();
		if( param == null ) return;
		param += "&evSecurityCode=" + this.m_evSecurityCode;
		this.m_ajax.send("POST", this.m_contextPath + "/accessStatistics/chartDataForAjax.admin", param, false, {success: function(data) { aAccessStatisticsManager.doRetrieveWeekHandler(data); }});
	},
	
	//주간별 현황 
	doRetrieveWeekHandler : function(resultObject) {
		this.doRetrieveHandler(resultObject);
		this.doCreateChart(5, resultObject);
	},
	doExportExcel : function() {
		var formElem = document.forms[ "AccessStatisticsManager_SearchForm" ];
	    formElem.elements[ "pageNo" ].value = 1;
		
		var param = this.getParam();
		if( param == null ) return;
		param += "&evSecurityCode=" + this.m_evSecurityCode;
		
		var url = this.m_contextPath + "/accessStatistics/exportExcelForAjax.admin?" + param; 
		document.getElementById("exportExcelIF").src = url;
	}	
}
