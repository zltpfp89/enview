<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<form id='MyPageEditorDialog.EditForm' name='MyPageEditorDialogEditForm' method='post'>
	<input type='hidden' id='MyPageEditorDialog.isCreate'>
	<input type='hidden' id='MyPageEditorDialog.path' name='path' value='" + portalPage.getPath() + "'>
	<table border='0' cellpadding='1' cellspacing='0' class='webformpanel'>
		<tr><td colspan='4' class='webformheaderline'></td></tr>
		<tr>
			<td width='30%' class='webformlabel'><util:message key='ev.title.page.pageEditingName'/></td>
			<td class='webformfield'>
				<input type='text' id='MyPageEditorDialog.title' name='title' value='' maxLength='6' class='full_webtextfield'>
			</td>
		</tr>
		<tr id='MyPageEditorDialog.PageTheme'>
			<td class='webformlabel'><util:message key='ev.title.page.pageEditingPageTheme'/></td>
			<td class='webformfield'>
				<select id='MyPageEditorDialog.SELECT_THEME' name='theme'>
					<c:forEach items="${myPageThemeList}" var="theme">
					<option value="<c:out value="${theme}"/>"><c:out value="${theme}"/></option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr id='MyPageEditorDialog.PageLayout'>
			<td class='webformlabel'><util:message key='ev.title.page.pageEditingLayout'/></td>
			<td class='webformfield'>
				<select id='MyPageEditorDialog.SELECT_LAYOUT' name='layout' onchange=''>
					<c:forEach items="${layoutList}" var="layout">
					<option value="<c:out value="${layout.name}"/>"><c:out value="${layout.displayName}"/></option>
					</c:forEach>
				</select>
			</td>
		</tr>
	</table>
</form>
		

		
			

