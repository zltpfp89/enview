<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${boardSttVO.listOpt == 'cafeHome'}">
		<jsp:include page="cafeHomeOne.jsp"/>
	</c:when>
	<c:otherwise> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.saltware.enview.request.RequestContext"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld"%>
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
		<form name=setTransfer method=post action=list.brd>   
			<input type=hidden name=boardId       value=<c:out value="${boardSttVO.boardId}"/>>
			<input type=hidden name=cmpBrdId      value=<c:out value="${boardSttVO.cmpBrdId}"/>>
			<input type=hidden name=srchKey       value=<c:out value="${boardSttVO.srchKey}"/>>
			<input type=hidden name=srchType      value=<c:out value="${boardSttVO.srchType}"/>>
			<input type=hidden name=srchBgnReg    value=<c:out value="${boardSttVO.srchBgnReg}"/>>
			<input type=hidden name=srchEndReg    value=<c:out value="${boardSttVO.srchEndReg}"/>>
			<input type=hidden name=srchReplYn    value=<c:out value="${boardSttVO.srchReplYn}"/>>
			<input type=hidden name=srchMemoYn    value=<c:out value="${boardSttVO.srchMemoYn}"/>>
			<input type=hidden name=page          value=<c:out value="${boardSttVO.page}"/>>
			<input type=hidden name=cateId        value=<c:out value="${boardSttVO.cateId}"/>>
			<input type=hidden name=bltnCateId    value=<c:out value="${boardSttVO.bltnCateId}"/>>
			<input type=hidden name=bltnNo        value=<c:out value="${boardSttVO.bltnNo}"/>>
			<input type=hidden name=cmd       	  value=<c:out value="${boardSttVO.cmd}"/>>
			<input type=hidden name=ie            value=<c:out value="${boardSttVO.ie}"/>>
			<input type=hidden name=onlyReplYn    value=<c:out value="${boardSttVO.onlyReplYn}"/>>
			<input type=hidden name=onlyMemoYn    value=<c:out value="${boardSttVO.onlyMemoYn}"/>>
			<input type=hidden name=accSetYn      value=<c:out value="${boardVO.accSetYn}"/>>
			<input type=hidden name=boardSkinDflt value=<c:out value="${boardVO.boardSkinDflt}"/>>
			<input type=hidden name=boardWidth    value=<c:out value="${boardVO.boardWidth}"/>>
			<input type=hidden name=maxFileCnt    value=<c:out value="${boardVO.maxFileCnt}"/>>
			<input type=hidden name=thumbSize     value=<c:out value="${boardVO.thumbSize}"/>>
			<input type=hidden name=badNickDflt   value=<c:out value="${boardVO.badNickDflt}"/>>
			<input type=hidden name=badCnttDflt   value=<c:out value="${boardVO.badCnttDflt}"/>>
			<input type=hidden name=limitSize     value=<c:out value="${boardVO.limitSize}"/>>
			<input type=hidden name=ableListGrade value=<c:out value="${bltnVO.ableListGrade}"/>>
			<input type=hidden name=ableListGroup value=<c:out value="${bltnVO.ableListGroup}"/>>
			<input type=hidden name=ableListRole  value=<c:out value="${bltnVO.ableListRole}"/>>
			<input type=hidden name=ableReadGrade value=<c:out value="${bltnVO.ableReadGrade}"/>>
			<input type=hidden name=ableReadGroup value=<c:out value="${bltnVO.ableReadGroup}"/>>
			<input type=hidden name=ableReadRole  value=<c:out value="${bltnVO.ableReadRole}"/>>
			<input type=hidden name=totFileSize   value=<c:out value="${bltnVO.totFileSize}"/>>
			<input type=hidden name=sizeSF        value=<c:out value="${bltnVO.sizeSF}"/>>
			<c:set var="loginInfo" value="${secPmsnVO.loginInfo}"/>
			<input type=hidden name=mileTot       value=<c:out value="${loginInfo.mile_tot}"/>>
			<input type=hidden name=bltnSubj>
			<input type=hidden name=bltnCntt>
			<input type=hidden name=ext_str0>
			<input type=hidden name=ext_str1>
			<input type=hidden name=ext_str2>
			<input type=hidden name=ext_str3>
			<input type=hidden name=ext_str4>
			<input type=hidden name=ext_str5>
			<input type=hidden name=ext_str6>
			<input type=hidden name=ext_str7>
			<input type=hidden name=ext_str8>
			<input type=hidden name=ext_str9>
			<input type=hidden name=bltnSecretYn>
			<input type=hidden name=userNick>
			<input type=hidden name=userPass>
			<input type=hidden name=anonFlag>
			<input type=hidden name=fileName>
			<input type=hidden name=fileMask>
			<input type=hidden name=fileSize>
			<input type=hidden name=pollCntt>
			<input type=hidden name=pollMask>
			<input type=hidden name=betPnt>
			<input type=hidden name=bltnTopTag>
			<input type=hidden name=bltnBgnYmd>
			<input type=hidden name=bltnEndYmd>
			<input type=hidden name=rtnURI>
			<input type=hidden name=langKnd value=<c:out value="${secPmsnVO.locale}"/>>
		</form>
		
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
		<jsp:include page="list.jsp"/>		
	</body>
</html>
	</c:otherwise>
</c:choose>


