<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Set" %>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager" %>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="java.net.*" %>
<script>
function go() {
	document.location.href="http://commonlcds.common.or.kr:8400/KRCEIS/flex/Main.html";
}

setTimeout("go()", 2000);
</script>
<iframe src="/common/link/epLink.common?pcd=pcd:portal_content/com.saltware.Karico/Common/Roles/common.r.myhome/common.sap_r3.iv.WFApproval&" width="0"  height="0"></iframe>
 