<%@page import="com.saltware.encola.common.vo.CommunityVO"%>
<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="com.saltware.encola.common.vo.CmntMenuVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% 
	CommunityVO cmntVO = (CommunityVO)request.getAttribute("cmntVO");
	String cafeUrl = "";
	if(cmntVO != null){
		cafeUrl = cmntVO.getCmntUrl();
	}
	CmntMenuVO menuVO = (CmntMenuVO)request.getAttribute("menuVO");
	String cnttType = "", cnttUrl = "";
	String paramMark = "?";
	if (menuVO != null) {
		cnttType = menuVO.getCnttType();
		cnttUrl  = menuVO.getCnttUrl();
		if (cnttUrl != null && cnttUrl.indexOf("?") != -1) paramMark = "&";
		pageContext.setAttribute("paramMark", paramMark);
	}
%>

	
<c:if test="${empty eachForm.cmd}">
	<input type="hidden" id="cnttDecoPrefs" name="cnttDecoPrefs" value="[ 
	<c:forEach items="${decoPrefs}" var="deco" varStatus="status">
	{ clazz:'<c:out value="${deco.decoType}"/>_<c:out value="${deco.name}"/>', value:'<c:out value="${deco.value}"/>'}<c:if test="${!status.last}">,</c:if>
		</c:forEach>
	]"/>
	<input type="hidden" id="CF0501_template">
	<input type="hidden" id="CF0501_decoId">
	<script type="text/javascript">
		var orgDecoId = cfCntt.getDeco().getOrgDecoPrefValue('CF0501_template');
		$('#CF0501_template').val(orgDecoId);
		
		cfEach.m_frameType = '<c:out value="${frameType}"/>';
		cfCntt.initCafeHomeLayout();
	</script>
	<c:if test="${!empty brdGrpList || !empty menuVO}">
		<div id="cafe_cntt_wrap" class="cafe_cntt_wrap">
			<div id="div_cafe_cntt" class="div_cafe_cntt frame_<c:out value="${frameType}"/>">
				<%--BEGIN::개별카페홈 게시판 설정이 정상적으로 있는 경우--%>
				<c:if test="${!empty brdGrpList}">
					<c:forEach items="${brdGrpList}" var="brdCfgList" varStatus="status">
						<c:forEach items="${brdCfgList}" var="brdCfg" varStatus="innerStatus">
							<c:set var="innerIndex" value="${innerStatus.index }"/>
						</c:forEach>
						<div class="cntt_panel <c:out value="${frameType}"/>">
						<c:forEach items="${brdCfgList}" var="brdCfg" varStatus="innerStatus">
							<c:if test="${innerStatus.index == 0 }">
								<c:if test="${innerIndex == 0 }">
									<c:set var="innerClass" value="innerCenter"/>
								</c:if>
								<c:if test="${innerIndex == 1 }">
									<c:set var="innerClass" value="innerLeft"/>
								</c:if>
							</c:if>
							<c:if test="${innerStatus.index == 1 }">
								<c:set var="innerClass" value="innerRight"/>
							</c:if>
							<div class="<c:out value="${innerClass}"/> <c:out value="${brdCfg.grpType}"/> cntt_<c:out value="${brdCfg.type}"/>_<c:out value="${brdCfg.id}"/>" id="cntt_<c:out value="${status.index}"/><c:out value="${innerStatus.index}"/>">
								<input class="bltnList" type="hidden" value="<%=request.getContextPath()%>/board/list.brd?boardId=<c:out value="${brdCfg.id}"/>&listOpt=cafeHome&frameType=<c:out value="${frameType}"/>&brdGrpType=<c:out value="${brdCfg.grpType}"/>&brdType=<c:out value="${brdCfg.type}"/>&brdIndex=cntt_<c:out value="${status.index}"/><c:out value="${innerStatus.index}"/><c:if test="${brdCfg.grpType == 'FLT20' && (brdCfg.type == 'IMG1' || brdCfg.type == 'IMG2')}">&pageSize=14</c:if>"/>
							</div>
							<input class="cntt_<c:out value="${status.index}"/><c:out value="${innerStatus.index}"/>_boardParam" name="frameType" type="hidden" value="<c:out value="${frameType}"/>"/>
							<input class="cntt_<c:out value="${status.index}"/><c:out value="${innerStatus.index}"/>_boardParam" name="brdGrpType" type="hidden" value="<c:out value="${brdCfg.grpType}"/>"/>
							<input class="cntt_<c:out value="${status.index}"/><c:out value="${innerStatus.index}"/>_boardParam" name="brdType" type="hidden" value="<c:out value="${brdCfg.type}"/>"/>
							<c:if test="${brdCfg.grpType == 'FLT20' && (brdCfg.type == 'IMG1' || brdCfg.type == 'IMG2')}">
								<input class="cntt_<c:out value="${status.index}"/><c:out value="${innerStatus.index}"/>_boardParam" name="pageSize" type="hidden" value="14"/>
							</c:if>
						</c:forEach>
						</div>
					</c:forEach>
				</c:if>
				<%--END::개별카페홈 게시판 설정이 정상적으로 있는 경우--%>
				<%--BEGIN::개별카페홈 게시판 설정이 없는 경우--%>
				<c:if test="${!empty menuVO}"><%--메뉴 중 초기메뉴로 설정되었거나 제일 순서가 빠른 것--%>
					<% if (cnttType.startsWith("2") || cnttType.startsWith("8")) { %>
						<iframe class="title_content" id="cafeBoardFrame" name="cafeBoardFrame" height=0
								src="<c:out value="${menuVO.cnttUrl}"/><c:out value="${paramMark}"/>cmntId=<c:out value="${cmntVO.cmntId}"/>&userId=<c:out value="${mmbrVO.userId}"/>&mmbrGrd=<c:out value="${mmbrVO.mmbrGrd}"/>"
								frameborder="0" scrolling=no
								onload="cfCntt.autoResize('cafeBoardFrame')">
						</iframe>
					<% } else if (cnttType.startsWith("1") || cnttType.startsWith("9")) { %>
						<iframe class="title_content" id="cafeBoardFrame" name="cafeBoardFrame" height=0
								src="<%=request.getContextPath()%>/board/list.brd?boardId=<c:out value="${menuVO.boardId}"/>"
								frameborder="0" scrolling=no
								onload="cfCntt.autoResize('cafeBoardFrame')">
						</iframe>
					<% } %>
				</c:if>
				<%--END::개별카페홈 게시판 설정이 없는 경우--%>
			</div>
			<c:if test="${menuUse.ggumigiBoard == 'true'}">
				<div id="cafecntt_mask" class="mask_panel mask_dashed cafecntt_mask">
					<div class="mask_button">꾸미기</div>
					<div class="mask_layer" id="cafecntt_mask_layer"></div>
				</div>
			</c:if>
			<c:if test="${menuUse.ggumigiBoard == 'false'}">
				<div id="cafecntt_mask" class="mask_panel cafecntt_mask">
					<div class="mask_layer2" id="cafecntt_mask_layer"></div>
				</div>
			</c:if>
			<form name="cntt_form" method="POST"></form>
			<script type="text/javascript">
				cfCntt.initBntlList();
				cfCntt.setEditable(<c:out value="${menuUse.ggumigiBoard}"/>);
			</script>
		</div>
	</c:if>
</c:if>
<c:if test="${!empty boardId }">
	<div id="cafe_cntt_wrap" class="cafe_cntt_wrap">
		<c:if test="${empty bltnNo}"><%--특정 게시판아이디가 넘어오는 경우--%>
			<iframe class="title_content" id="cafeBoardFrame" name="cafeBoardFrame" height=0
					src="<%=request.getContextPath()%>/board/list.brd?boardId=<c:out value="${boardId}"/>"
					frameborder="0" scrolling=no
					onload="cfCntt.autoResize('cafeBoardFrame')">
			</iframe>
		</c:if>
		<c:if test="${!empty boardId && !empty bltnNo}"><%--특정 게시물이 지정되어 넘어오는 경우--%>
			<iframe class="title_content" id="cafeBoardFrame" name="cafeBoardFrame" height=0
					src="<%=request.getContextPath()%>/board/read.brd?boardId=<c:out value="${boardId}"/>&bltnNo=<c:out value="${bltnNo}"/>&cmd=READ"
					frameborder="0" scrolling=no
					onload="cfCntt.autoResize('cafeBoardFrame')">
			</iframe>
		</c:if>
	</div>
</c:if>
<c:if test="${eachForm.cmd == 'selectMenu'}">
	<c:if test="${!empty menuVO}">
		<iframe class="title_content" id="cafeBoardFrame" name="cafeBoardFrame" frameborder="0" scrolling=no height=0
			<% if (cnttType.startsWith("2") || cnttType.startsWith("8")) { %>
				src="<c:out value="${menuVO.cnttUrl}"/><c:out value="${paramMark}"/>cmntId=<c:out value="${cmntVO.cmntId}"/>&userId=<c:out value="${mmbrVO.userId}"/>&mmbrGrd=<c:out value="${mmbrVO.mmbrGrd}"/>"
			<% } else if (cnttType.startsWith("1") || cnttType.startsWith("9")) { %>
				src="<%=request.getContextPath()%>/board/list.brd?boardId=<c:out value="${menuVO.boardId}"/>&cafeUrl=<%=cafeUrl%>"
			<% } %>
				onload="cfCntt.autoResize('cafeBoardFrame')">
		</iframe>
	</c:if>
</c:if>
<c:if test="${eachForm.cmd == 'searchCafe'}">
	<iframe class="title_content" id="cafeBoardFrame" name="cafeBoardFrame" frameborder="0" scrolling=no height=0
			src="<%=request.getContextPath()%>/board/list.brd?boardId=<c:out value="${cmntVO.cmntId}"/>SRCH&srchType=<c:out value="${srchType}"/>&srchKey=<c:out value="${srchKey}"/>&cafeUrl=<%=cafeUrl%>"
			onload="cfCntt.autoResize('cafeBoardFrame')">
	</iframe>
</c:if>
