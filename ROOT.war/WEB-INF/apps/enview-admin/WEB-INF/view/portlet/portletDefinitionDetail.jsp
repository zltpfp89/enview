
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%@ page import="com.saltware.enview.Enview"%>
<%@ page import="com.saltware.enview.session.SessionManager"%>
<%@ page import="com.saltware.enview.code.EnviewCodeManager"%>
<%@ page import="com.saltware.enview.codebase.CodeBundle"%>
<%@ page import="com.saltware.enview.util.EnviewLocale"%>
<%@ page import="java.util.List"%>

<%
	SessionManager enviewSessionManager = (SessionManager)Enview.getComponentManager().getComponent("com.saltware.enview.session.SessionManager");
	String langKnd = EnviewLocale.getLocale(request, enviewSessionManager);
	CodeBundle enviewCodeBundle = EnviewCodeManager.getInstance().getBundle( langKnd );
	request.setAttribute("cacheCodeList", (List)enviewCodeBundle.getCodes("PT", "114", 0, 0, true));
	
%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletDefinitionManager.js"></script>

<form id="PortletDefinitionManager_EditForm" style="display:inline" action="" method="post">
	<input type="hidden" id="PortletDefinitionManager_isCreate">
	<input type="hidden" id="PortletDefinitionManager_resourceBundle" name="resourceBundle"/>
	<table cellpadding="0" cellspacing="0" summary="게시판" class="table_board">  
		<caption>게시판</caption>
		<colgroup>
			<col width="140px" />
			<col width="*" />
			<col width="140px" />
			<col width="*" />
		</colgroup>
		<tr class="first">
			<th class="L"><util:message key='ev.prop.portletDefinition.name'/> <em>*</em></th>
			<td class="L">
				<input type="text" id="PortletDefinitionManager_name" name="name" size="25" value="<c:out value="${aPortletDefinitionVO.name}"/>" maxLength="25" style="IME-MODE:disabled;" label="<util:message key='ev.prop.portletDefinition.name'/>" class="txt_100per" />
			</td>
			<th class="L"><util:message key='ev.prop.portletDefinition.expirationCache'/> <em>*</em></th>
			<td class="L">
				<div class="sel_200">
					<select id="PortletDefinitionManager_expirationCache" name="expirationCache" label="<util:message key='ev.prop.portletDefinition.expirationCache'/>" class='txt_200'>
						<c:forEach items="${cacheCodeList}" var="cache">
							<option value="<c:out value="${cache.code}"/>"><c:out value="${cache.codeName}"/></option>
						</c:forEach>
					</select>
				</div>
			</td>
		</tr>
		<tr >
			<th class="L"><util:message key='ev.title.portlet.title'/> <em>*</em></th>
			<td class="L">
				<input id="PortletDefinitionManager_title1" type="text" name="title1" value="<c:out value="${aPortletDefinitionVO.title1}"/>" maxLength="300" label="<util:message key='ev.title.portlet.title'/>" class="txt_100per" />	
			</td>
			<th class="L"><util:message key='ev.prop.portletApplication.appName'/> <em>*</em></th>
			<td class="L">
				<input type="text" id="PortletDefinitionManager_applicationTitle" name="applicationTitle" readonly="readonly" class="txt_100per"/>
				<input type="hidden" id="PortletDefinitionManager_applicationName" name="applicationName"/>
			</td>
		</tr>
		<tr >
			<th class="L"><util:message key='ev.title.portlet.portletIcon'/> <em>*</em></th>
			<td colspan="3" class="L">
				/images/portlets/&nbsp;<input id="PortletDefinitionManager_iconName3" type="text" name="iconName3" value="" maxLength="300" label="<util:message key='ev.title.portlet.portletIcon'/>" class="txt_200"/>	
				<a href="javascript:aPortletDefinitionManager.getIconChooser().doShow(aPortletDefinitionManager.setIconChooserCallback);" class="btn_O"><span><util:message key='ev.title.selectIcon'/></span></a>
			</td>
		</tr>
		<tr >
			<th class="L"><util:message key='ev.prop.portletDefinition.portletClassName'/></th>
			<td colspan="3" class="L">
				<input type="text" id="PortletDefinitionManager_className" name="className" value="<c:out value="${aPortletDefinitionVO.className}"/>" maxLength="" style="IME-MODE:disabled;width:75%;" label="<util:message key='ev.prop.portletDefinition.portletClassName'/>" class="txt_100" />
				<div class="sel_200">
					<select id="PortletDefinitionManager_ClassName_Select" onchange="aPortletDefinitionManager.changeSelectItem(this)" class="txt_200">
						<option value="com.saltware.enview.portlet.common.IFrameGenericPortlet">IFrame Portlet</option>  
						<option value="com.saltware.enview.portlet.common.DynamicContentPortlet">Dynamic Portlet</option>  												
						<!--option value="com.saltware.enview.portlet.common.rss.RSSPortlet">RSS Portlet</option-->  
					</select>
				</div>
			</td>
		</tr>
		<tr >
			<th class="L"><util:message key='ev.title.portlet.keywords'/> <em>*</em></th> 
			<td colspan="3" class="L">
				<input type="text" id="PortletDefinitionManager_keywords" name="keywords" value="<c:out value="${aPortletDefinitionVO.keywords}"/>" cols="80" rows="3" maxLength="200" label="<util:message key='ev.title.portlet.keywords'/>" style="width:75%;"></textarea>
				<div class="sel_100">
					<select class="txt_100" onchange="aPortletDefinitionManager.selectKeyword(this)">
						<option value=""></option>
						<c:forEach items="${keywordList}" var="keyword" varStatus="status">
							<option value="<c:out value="${keyword}"/>"><c:out value="${keyword}"/></option>  
						</c:forEach>
					</select>
				</div>
			</td>
		</tr>
		<tr >
			<th class="L"><util:message key='ev.title.portlet.description'/> <em>*</em></th> 
			<td colspan="3" class="L">
				<textarea id="PortletDefinitionManager_description2" name="description2" value="<c:out value="${aPortletDefinitionVO.description2}"/>" cols="60" rows="3" maxLength="200" label="<util:message key='ev.title.portlet.description'/>" class="txtbox"></textarea>
			</td>
		</tr>
	</table>
	<!-- btnArea-->
	<div class="btnArea"> 
		<div class="rightArea">
			<a href="javascript:aPortletDefinitionManager.doUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
		</div>
	</div>
	<!-- btnArea//-->
</form>

<div id="PortletDefinitionManager_PortletDefinitionChooser"></div>