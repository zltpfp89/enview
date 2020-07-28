<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ page import="com.saltware.enview.test.TestManager"%>
<%@ page import="java.util.Hashtable"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Iterator"%>
<%
	Hashtable allData = TestManager.getInstance().getData();
	Map tmpMap = null;
	
	if( allData.containsKey("353930050315770") ) {
		tmpMap = (Map)allData.get("353930050315770");
	}
	else {
		tmpMap = new HashMap();
	}
	tmpMap.put("name", "nam");
	
	if( allData.containsKey("352316050469638") ) {
		tmpMap = (Map)allData.get("352316050469638");
	}
	else {
		tmpMap = new HashMap();
	}
	tmpMap.put("name", "lim");
	
	if( allData.containsKey("352316050467418") ) {
		tmpMap = (Map)allData.get("352316050467418");
	}
	else {
		tmpMap = new HashMap();
	}
	tmpMap.put("name", "yeon");
	
	if( allData.containsKey("ff22ee398ec7901ee2c787df8b5fe40ce7c397f1") ) {
		tmpMap = (Map)allData.get("ff22ee398ec7901ee2c787df8b5fe40ce7c397f1");
	}
	else {
		tmpMap = new HashMap();
	}
	tmpMap.put("name", "sun");

%>
<h1>Successfully Initialize Data</h1>