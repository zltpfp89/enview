<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ page import="com.saltware.enview.test.TestManager"%>
<%@ page import="java.util.Hashtable"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%
	String imei = request.getParameter("imei");
	String latitude = request.getParameter("latitude");
	String longitude = request.getParameter("longitude");
	
	String name = "";
	if( imei != null ) {
		Hashtable allData = TestManager.getInstance().getData();
		if( allData.size() == 0 ) {
			Map tmpMap = new HashMap();
			tmpMap.put("name", "nam");
			allData.put("353930050315770", tmpMap);
			tmpMap = new HashMap();
			tmpMap.put("name", "lim");
			allData.put("352316050469638", tmpMap);
			tmpMap = new HashMap();
			tmpMap.put("name", "yeon");
			allData.put("352316050467418", tmpMap);
		}
		
		Map dataMap = TestManager.getInstance().getData(imei);
		dataMap.put("y", latitude);
		dataMap.put("x", longitude);
		name = (String)dataMap.get("name");
	}
	
	//System.out.println("##### imei=" + imei + ", latitude=" + latitude + ", longitude=" + longitude);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <title>Google Maps JavaScript API Example</title>
    <script type="text/javascript">
		function changeName(obj)
		{
			var iframe = document.getElementById("googleMapIF");
			var src = "/enview/statics/process/gpsView.jsp?imei=" + obj.options[obj.selectedIndex].value + "&latitude=<%=latitude%>&longitude=<%=longitude%>&name=<%=name%>";
			alert("src=" + src);
			iframe.src = src;
		}
   
   </script>
  </head>
  <body>
	<select id="zzz" name="zzz" onchange="changeName(this)">
		<option value="353930050315770">Nam</option>
		<option value="352316050469638">Lim</option>
		<option value="352316050467418">Yeon</option>
	</select>
    <iframe id='googleMapIF' frameborder=0 width="100%" height="800"></iframe>
  </body>
</html>
