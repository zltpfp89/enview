<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">
<%-- <script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/realtimeMonitorManager.js"></script> --%>
<script type="text/javascript" src="<%=request.getContextPath()%>/widget/javascript/FusionCharts.js"></script>
<script type="text/javascript">
	//var evSecurityCode = "<c:out value="${evSecurityCode}"/>";
</script>
<HTML>
<HEAD>
<TITLE></TITLE>

</HEAD>
<BODY>
<CENTER>
<div id="chart1div">
  This text is replaced by the Flash movie.
</div>
<script type="text/javascript">
   var chart1 = new FusionCharts("<%=request.getContextPath()%>/widget/Charts/RealTimeLine.swf", "ChId1", "300", "300", "0", "0");
   chart1.setDataURL("<%=request.getContextPath()%>/widget/data/RamData.xml");
   chart1.render("chart1div");
</script>
</BODY>
</HTML>