<%@page import="java.util.List"%>
<%@page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html; charset=UTF-8"%>
<pre>
<%
	Map userInfoMap = EnviewSSOManager.getUserInfoMap(request);
	if( userInfoMap != null) {
//		out.println( userInfoMap.toString().replaceAll(",", "\n"));
		String[] keys = (String[])userInfoMap.keySet().toArray(new String[0]);
		Object value;
		for( int i=0; i < keys.length; i++) {
			value = userInfoMap.get(keys[i]);
			if( value instanceof String) {
				out.println( keys[i] + "=" + value );
			} else if( value instanceof List) {
				out.print( keys[i] + "=" );
				List list = (List)value;
				for(int j=0; j<list.size(); j++) {
					if( j>0) {
						out.print(",");
					}
					out.print( list.get(j));
				}
				out.println();
			} else {
				out.println( keys[i] + "=" + value );
			}
			out.println("<br>");
		}
		
	}
	
%>
</pre>