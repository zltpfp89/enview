<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="jdbc.monitor.*" %>
<html>
<head>
<title>JDBC Monitoring</title>
<meta http-equiv="Expires" content="0">
</head>
<style>
body         {  font-family: "±¼¸²,arial"; font-size: 9pt; color: #555555; background-color: #FFFFFF; margin-top: 10px; margin-left: 15px; line-height: 13pt; }
table        {  font-family: "±¼¸²,arial"; font-size: 9pt; color: #555555; background-color: #555555; line-height: 13pt; width: 900px; border-style: none}
td           {  font-family: "±¼¸²,arial"; font-size: 9pt; color: #555555; background-color: #FFFFFF; line-height: 13pt; height: 18px; text-align: left}
.title   {  font-family: "±¼¸²", "arial"; font-size: 9pt; color: #FFFFFF; background-color: #6479A2; text-align: center; height: 20px;}
.danger_row   {  font-family: "±¼¸²", "arial"; font-size: 9pt; color: #415E8E; background-color: #CAD9F0;  height: 20px;}
.td_left     {  text-align: left}
.td_right    {  text-align: right}
.td_center   {  text-align: center}
</style>
<body>
SQL List<br>
<table cellpadding="2" cellspacing="1">
  <tr> 
    <td class='title' rowspan="2" >#</td>
    <td  class='title' rowspan="2">SQL String</td>
    <td class='title' colspan="4">Execute Statics</td>
    <td class='title' colspan="4">Patch Statics</td>
    <td class='title' rowspan="2">RecentExecTime</td>
  </tr>
  <tr> 
    <td class='title'>#</td>
    <td class='title' >Max</td>
    <td class='title'>Min</td>
    <td class='title'>Avg</td>
    <td class='title'>#</td>
    <td class='title' >Max</td>
    <td class='title'>Min</td>
    <td class='title'>Avg</td>
  </tr>
  <%!
	final int ONE_HOUR = 1000 * 60 * 60;
  %>
  <%
	String row_class = "";
    MonitoringManager manager = MonitoringManager.getInstance();
    HashMap map = manager.getSqlList();
	SimpleDateFormat formatter = new SimpleDateFormat ("MM/dd,HH:mm:ss", java.util.Locale.KOREA);
	Iterator iter = map.values().iterator();
	long now = System.currentTimeMillis();
	int i = 1;
    while(iter.hasNext()){
        SQLExecDataModel data = (SQLExecDataModel)iter.next();
%> 
  <tr> 
    <td class=td_left><%= i++ %></td>
    <td class=td_left><code><%= data.getSql() %></code></td>
    <td class=td_right><%= data.getCallCount() %></td>
    <td class=td_right><%= data.getMaxExecTime() %></td>
    <td class=td_right><%= data.getMinExecTime() %></td>
    <td class=td_right><%= data.getAvgExecTime() %></td>
    <td class=td_right><%= data.getPatchCount() %></td>
    <td class=td_right><%= data.getMaxPatchTime() %></td>
    <td class=td_right><%= data.getMinPatchTime() %></td>
    <td class=td_right><%= data.getAvgPatchTime() %></td>
    <td class=td_right><%= formatter.format(new java.util.Date(data.getLatestCallTime())) %></td>
  </tr>
  <%
     }
%> 
</table>
calling#:Calling Count, Max:Max Executing Time(ms), Min:Min(ms), Avg:Average(ms), RecentExecTime: Recent Executing Time.
<br>
<br>Open Connection List<br>
<table cellpadding="2" cellspacing="1">
  <tr> 
    <td class='title' >#</td>
    <td class='title' >Type</td>
    <td class='title' >Created</td>
    <td class='title' >Recent</td>
    <td class='title' >SQL String</td>
  </tr>
  <%
    HashMap connList = manager.getConnectionList();
	iter = connList.values().iterator();
	i = 1;
	while(iter.hasNext()){
        ResourceDataModel resource = (ResourceDataModel)iter.next();
		if(now - resource.getLatestExecTime() > ONE_HOUR) row_class = "danger_row"; else row_class = "";
  %> 
  <tr> 
    <td class='<%= row_class %>'><%= i++ %></td>
    <td class='<%= row_class %>'><%= resource.getClassName() %></td>
    <td class='<%= row_class %>'><%= formatter.format(new java.util.Date(resource.getStartTime())) %></td>
    <td class='<%= row_class %>'><%= formatter.format(new java.util.Date(resource.getLatestExecTime())) %></td>
    <td class='<%= row_class %>'><code><%= resource.getSql() %></code></td>
  </tr>
  <%
     }
  %> 
</table>
Type:Class Name, Created:The Time Connection's created, Recent:Recent Executing Time, SQL String: Recent Executing SQL.
<br>

<br>Open Statement List<br>
<table cellpadding="2" cellspacing="1">
  <tr> 
    <td class='title' >#</td>
    <td class='title' >Type</td>
    <td class='title' >Created</td>
    <td class='title' >Recent</td>
    <td class='title' >SQL String</td>
  </tr>
<%
    HashMap stmtList = manager.getStatementList();
	iter = stmtList.values().iterator();
	i = 1;
    //for(int i=0; i < unclosedStmtList.values().size(); i++){
	while(iter.hasNext()){
        ResourceDataModel resource = (ResourceDataModel)iter.next();
		if(now - resource.getLatestExecTime() > ONE_HOUR) row_class = "danger_row"; else row_class = "";
%>
  <tr> 
    <td class='<%= row_class %>'><%= i++ %></td>
    <td class='<%= row_class %>'><%= resource.getClassName() %></td>
    <td class='<%= row_class %>'><%= formatter.format(new java.util.Date(resource.getStartTime())) %></td>
    <td class='<%= row_class %>'><%= formatter.format(new java.util.Date(resource.getLatestExecTime())) %></td>
    <td class='<%= row_class %>'><code><%= resource.getSql() %></code></td>
  </tr>
  <%
     }
%> 
</table>
Type:Class Name, Created:The Time Statement's created, Recent:Recent Executing Time SQL, String: Recent Executing SQL.
<br>
<br>Open ResultSet List<br>
<table cellpadding="2" cellspacing="1">
  <tr> 
    <td class='title' >#</td>
    <td class='title' >Type</td>
    <td class='title' >Created</td>
    <td class='title' >Recent</td>
    <td class='title' >SQL String</td>
  </tr>
<%
    HashMap rsetList = manager.getResultSetList();
	iter = rsetList.values().iterator();
	i = 1;
    //for(int i=0; i < unclosedStmtList.values().size(); i++){
	while(iter.hasNext()){
        ResourceDataModel resource = (ResourceDataModel)iter.next();
		if(now - resource.getLatestExecTime() > ONE_HOUR) row_class = "danger_row"; else row_class = "";
%>
  <tr> 
    <td class='<%= row_class %>'><%= i++ %></td>
    <td class='<%= row_class %>'><%= resource.getClassName() %></td>
    <td class='<%= row_class %>'><%= formatter.format(new java.util.Date(resource.getStartTime())) %></td>
    <td class='<%= row_class %>'><%= formatter.format(new java.util.Date(resource.getLatestExecTime())) %></td>
    <td class='<%= row_class %>'><code><%= resource.getSql() %></code></td>
  </tr>
  <%
     }
%> 
</table>
Type:Class Name, Created:The Time Statement's created, Recent:Recent Executing Time SQL, String: Recent Executing SQL.
</body>
</html>
