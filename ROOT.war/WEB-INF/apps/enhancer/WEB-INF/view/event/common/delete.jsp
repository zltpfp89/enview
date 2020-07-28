<%@ page contentType="text/html;charset=UTF-8" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%
	String   vaccum      = (String)request.getAttribute  ("vaccum");
	String[] deletedList = (String[])request.getAttribute("deletedList");
%>

<%
if ("DIRECT".equals(vaccum) && deletedList != null) { 
%>
<script language="javascript">
<!--
	var deletedList = new Array();
<% 
	for (int i = 0; i < deletedList.length; i++) 
		out.println("deletedList["+i+"] = '"+deletedList[i]+"';");	
%>
	for (var i = 0; i < parent.document.setFileList.list.length; i++) {
		for (var j = 0; j < <%=deletedList.length%>; j++) {
			if (parent.document.setFileList.list.options[i].value == deletedList[j]) {
				parent.document.setFileList.list.options[i].value = '';
				parent.document.setFileList.list.options[i].text = '';
			}
		}
	}

	var tmp1 = new Array();
	var tmp2 = new Array();
	var cnt = 0;
	for (var i = 1; i < parent.document.setFileList.list.length; i++) {
		if (parent.document.setFileList.list.options[i].value != '') {
			tmp1[cnt] = parent.document.setFileList.list.options[i].value;
			tmp2[cnt] = parent.document.setFileList.list.options[i].text;
			cnt++;
		}
	}

	for (var i = 1; i < parent.document.setFileList.list.length; i++) {
		parent.document.setFileList.list.options[i].value = '';
		parent.document.setFileList.list.options[i].text = '';
	}

	for (var i = 1; i < cnt+1; i++) {
		parent.document.setFileList.list.options[i].value = tmp1[i-1];
		parent.document.setFileList.list.options[i].text = tmp2[i-1];
	}
	
	var totalsize = eval("parent.document.setUpload.totalsize.value");	
	totalsize = (totalsize < 0) ? 0 : totalsize;

	var unit = "";
	var calsize = "";
	if ((1024 < totalsize) && (totalsize < 1024 * 1024)) {
		unit = " KB";
		calsize = (totalsize/1024)+"";
	} else if (1024 * 1024 <= totalsize) {
		unit = " MB";
		calsize = (totalsize/(1024*1024))+"";
	} else {
		unit = " Bytes";
   		calsize = totalsize+"";
	}

	if (calsize.indexOf(".") > -1) {
		var sosu = calsize.substring(calsize.indexOf("."), calsize.length);
		if (sosu.length > 4)
			calsize = calsize.substring(0,calsize.indexOf("."))+sosu.substring(0,4);
	}
	parent.document.setUpload.totalsize.value = totalsize;
	//parent.document.setUpload.viewsize.value = "TOTAL FILE SIZE : "+calsize+unit;

	location.href = '/snuEvent/blank.face';
//-->
</script>
<%
} else if ("INDIRECT".equals(vaccum)) { 
%>
<%-- 파일 삭제하는 것을 보여주려면 아래 코멘트를 푼다.090524.KWShin. --%>
<%--title>Delete File...</title>
<body bgcolor=#D6D3CE>
  <img src=./images/bbs/site/alert.gif align=absmiddle>&nbsp;&nbsp;<font style=font-size:9pt>파일 삭제중..</font><br>
  <center><input type=button name=bt style='width:80;font-size:9pt' value='확 인' onclick='terminate()'></center>
</body>
<script>
<!--
	function window.onload() {
		setTimeout('terminate()', 3000);
	}
	function terminate() {
		window.close();
	}
//-->
</script--%>
<%
} 
%>





















