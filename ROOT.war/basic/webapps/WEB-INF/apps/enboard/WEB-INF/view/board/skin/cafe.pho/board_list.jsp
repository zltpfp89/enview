<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${boardSttVO.listOpt == 'cafeHome'}">
		<jsp:include page="cafeHomeList.jsp"/>
	</c:when>
	<c:otherwise> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.saltware.enview.request.RequestContext"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld"%>
<%@page import="com.saltware.enview.components.dao.ConnectionContextForRdbms"%>
<%@page import="com.saltware.enview.components.dao.ConnectionContext"%>
<%@page import="com.saltware.encola.cafe.dao.HomeDAO"%>
<%@page import="com.saltware.enboard.vo.BoardVO"%>
<%@page import="com.saltware.enview.components.dao.DAOFactory"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/decorations/layout/css/jquery/base/jquery.ui.all.css" />
		
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/cola/cafe/css/each/encafe.css" />
		<%@include file="../../include/board_cafe.jsp" %>
	<%
		if( request.getAttribute("windownId") == null ) {
	%>
		<%--포틀릿으로서 동작하고 있지 않을 때에는 enView의 Javascript를 포함시켜준다--%>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
		<c:if test="${empty secPmsnVO}">
			<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/ui/i18n/jquery.ui.datepicker-<%=request.getLocale().getLanguage()%>.js"></script>
			<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<%=request.getLocale().getLanguage()%>_mm.js"></script>
			<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<%=request.getLocale().getLanguage()%>_eb.js"></script>
		</c:if>
		<c:if test="${!empty secPmsnVO}">
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/ui/i18n/jquery.ui.datepicker-<c:out value="${secPmsnVO.locale}"/>.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${secPmsnVO.locale}"/>_mm.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${secPmsnVO.locale}"/>_eb.js"></script>
		</c:if>
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portal_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/utility.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validator.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_util.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/calendar/calendar.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/calendar/ko-kr/generatecalendar.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_list.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_read.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_edit.js"></script>
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/fckeditor/fckeditor.js"></script>
	<%
		}
	%>  
		<script type="text/javascript">
			function adminEventFree (win) {
				// 관리자/중간관리자가 아니면 바로 return.
				<c:if test="${secPmsnVO.isAdmin != 'true'}">
					return;
				</c:if>
				ebUtil.eventReset (win.document);
				for (var i=0; i<win.frames.length; i++) {
					try {
						adminEventFree (win.frames[i]);
					} catch(e) {}
				}
			}
			ebUtil.eventSet();			
		</script>
	</head>
	<body class="CF0802_bgColor">
		<%-- 게시판 데이타 전송 Form --%>
		<form name=setForm method=post>
			<input type=hidden name="boardId"       value="<c:out value="${boardSttVO.boardId}"/>"/>
			<input type=hidden name="cmpBrdId"      value="<c:out value="${boardSttVO.cmpBrdId}"/>"/>
			<input type=hidden name="srchKey"       value="<c:out value="${boardSttVO.srchKey}"/>"/>
			<input type=hidden name="srchType"      value="<c:out value="${boardSttVO.srchType}"/>"/>
			<input type=hidden name="srchBgnReg"    value="<c:out value="${boardSttVO.srchBgnReg}"/>"/>
			<input type=hidden name="srchEndReg"    value="<c:out value="${boardSttVO.srchEndReg}"/>"/>
			<input type=hidden name="srchReplYn"    value="<c:out value="${boardSttVO.srchReplYn}"/>"/>
			<input type=hidden name="srchMemoYn"    value="<c:out value="${boardSttVO.srchMemoYn}"/>"/>
			<input type=hidden name="page"          value="<c:out value="${boardSttVO.page}"/>"/>
			<input type=hidden name="pageSize"      value="<c:out value="${boardSttVO.pageSize}"/>"/>
			<input type=hidden name="cateId"        value="<c:out value="${boardSttVO.cateId}"/>"/>
			<input type=hidden name="bltnCateId"    value="<c:out value="${boardSttVO.bltnCateId}"/>"/>
			<input type=hidden name="listOpt"       value="<c:out value="${boardSttVO.listOpt}"/>"/>
			<input type=hidden name="onlyReplYn"    value="<c:out value="${boardSttVO.onlyReplYn}"/>"/>
			<input type=hidden name="onlyMemoYn"    value="<c:out value="${boardSttVO.onlyMemoYn}"/>"/>
			<input type=hidden name="wallUserId"    value="<c:out value="${boardSttVO.wallUserId}"/>"/>
			<input type=hidden name="systemCurrentTimeMillis" value="1<c:out value="${boardSttVO.systemCurrentTimeMillis}"/>"/>
			<input type=hidden name="boardSkinDflt" value="<c:out value="${boardVO.boardSkinDflt}"/>"/>
			<input type=hidden name="miniTrgtWin"   value="<c:out value="${boardVO.miniTrgtWin}"/>"/>
			<input type=hidden name="miniTrgtUrl"   value="<c:out value="${boardVO.miniTrgtUrl}"/>"/>
			<input type=hidden name=bltnNo>
			<%--다음 rtnBltnNo 는 목록화면에서 직접 읽기화면의 기능(e.g. 'eval-up')을 호출했을 때 필요로 된다.2012.07.05.KWShin.--%>
			<input type=hidden name=rtnBltnNo>
			<input type=hidden name=cmd>
			<input type=hidden name=rtnURI>
			<input type=hidden name=userPass>
		</form>
		<iframe name=download frameborder=0 width=0 height=0></iframe>
		<jsp:include page="list.jsp"/>		
	</body>
</html>
	</c:otherwise>
</c:choose>