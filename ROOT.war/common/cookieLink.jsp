<%@page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@page import="java.util.Map"%>
<%!
private void addUserCookie( HttpServletResponse response, String name, String value) {
	String cookie = "";
	if( value!=null) {
		cookie = name + "=" + "; Domain=common.or.kr; Path=/";
	} else {
		cookie = name + "=null;Domain=common.or.kr;Expires=Thu, 01-Jan-1970 00:00:10 GMT;Path=/";
	}
	response.addHeader("Set-Cookie", cookie);
}
private  String toUnicode( String s) {
	if( s==null) {
		return "";
	}
	StringBuffer sb = new StringBuffer();
	for (int i = 0; i < s.length(); i++) {
		sb.append("%u").append( Integer.toHexString( (int)s.charAt(i)).toUpperCase());
	}
	return sb.toString();
}
%>
<%

Map userInfoMap = EnviewSSOManager.getUserInfoMap(request);
if( userInfoMap != null) {
	response.addHeader("Set-Cookie", "USR_ID=" + (String)userInfoMap.get("userId") + "; Domain=common.or.kr; Path=/");	
	response.addHeader("Set-Cookie", "USR_DEPT_NM=" + toUnicode((String)userInfoMap.get("deptNm")) + "; Domain=common.or.kr; Path=/");	
	response.addHeader("Set-Cookie", "USR_EMAIL_ID=" + (String)userInfoMap.get("emailAddr")+  "; Domain=common.or.kr; Path=/");	
	response.addHeader("Set-Cookie", "USR_FST_NM=" + toUnicode((String)userInfoMap.get("nmKor")) + "; Domain=common.or.kr; Path=/");
}
String url = request.getParameter("url");
url = url.replaceAll("[\\r\\n]", "");
response.sendRedirect(url);

%>
