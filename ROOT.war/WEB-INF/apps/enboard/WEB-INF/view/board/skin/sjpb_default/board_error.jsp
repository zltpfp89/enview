<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String cmd = request.getParameter("cmd");
	String boardId = request.getParameter("boardId");
	String bltnNo = request.getParameter("bltnNo");
%>
<c:set var="cmd" value="${ cmd }" />
<c:set var="boardId" value="${ boardId }" />
<c:set var="bltnNo" value="${ bltnNo }" />

<html>
	<head>
		<title>error</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<script>
		  // <!--
		  if ("<c:out value="${baseForm.reasonCd}"/>" == "eb.error.must.auth.realMan") { // �Ǹ������� �޾ƾ� �ϴ� ��Ȳ�̸�
			if ("READ" == "<c:out value="${ cmd }"/>") {
				location.href = "realManSet.jsp?rtnUrl=read.brd?boardId=<c:out value="${ boardId }"/>&bltnNo=<c:out value="${ bltnNo }"/>&cmd=<c:out value="${ cmd }"/>";
			} else if ("WRITE" == "<c:out value="${ cmd }"/>" || "REPLY" == "<c:out value="${ cmd }"/>" || "MODIFY" == "<c:out value="${ cmd }"/>") {
				location.href = "realManSet.jsp?rtnUrl=edit.brd?boardId=<c:out value="${ boardId }"/>&bltnNo=<c:out value="${ bltnNo }"/>&cmd=<c:out value="${ cmd }"/>";
			} else {
				location.href = "realManSet.jsp?rtnUrl=list.brd?boardId=<c:out value="${ boardId }"/>";
			}
		  }
		  //-->
		</script>	
	</head>
	<body>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
		  <tr>
		    <td align="center" valign="middle">
		      <table width="344" border="0" cellspacing="0" cellpadding="0" height="147">
		        <tr>
		        	<%--
		          <td background='/board/images/board/skin/<%=request.getAttribute("boardSkin")%>/board_error_bg.gif' valign="bottom" align="center">&nbsp;
		           --%>
		          <td valign="bottom" align="center">&nbsp;
		            <table width="240" border="0" cellspacing="0" cellpadding="0" height="100">
		              <tr height=70 valign=middle>
		                <td width="80" align="center">
		                  <img src='/board/images/board/skin/<%=request.getAttribute("boardSkin")%>/alert.gif' width="38" height="41">
		                </td>  
		                <td style="font-family:Dotum;font-size:9pt;font-color:#999999" width="160" >
		                <c:choose>
		                 <c:when test="${baseForm.reasonCd=='eb.error.boardId.invalid' && boardId=='empty'}">
		                 <util:message key="eb.error.boardId.select"/>
						</c:when>
		                 <c:otherwise>
		                  <c:out value="${baseForm.reason}"/>
		                 </c:otherwise>
		                 </c:choose>
		                </td>
		              </tr>
		              <tr height=30 valign=top>
		                <td colspan=2 align=center>
		                  <a onclick='window.history.back()'>
		                    <img src='/board/images/board/skin/<%=request.getAttribute("boardSkin")%>/login_alert_history_btn.gif' width="83" height="18">
		                  </a>
		                </td>
		              </tr>
		            </table>
		          </td>
		        </tr>
		      </table>
		    </td>
		  </tr>
		</table>
	</body>
</html>

