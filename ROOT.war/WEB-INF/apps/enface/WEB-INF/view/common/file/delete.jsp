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
	parent.commonFile.handleDelete( deletedList);

	var contents = '';

	var totalsize = eval("parent.document.setUpload.totalsize.value");
	for (var i=0; i<deletedList.length; i++) {
		var fileSize = deletedList[i].split("^");
		totalsize -= eval(fileSize[2]);
	}
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
	parent.document.setUpload.viewsize.value = "TOTAL FILE SIZE : "+calsize+unit;
	//location.href = '/common/file/blank.common';
//-->
</script>

<%
}
%>