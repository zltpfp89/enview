
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/domainLangManager.js"></script>

<form id="DomainLangManager_EditForm" style="display:inline" action="" method="post">
	<input type="hidden" id="DomainLangManager_isCreate" />
	<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
	<caption>게시판</caption>
		<colgroup>
			<col width="140px" />
			<col width="*" />
			<col width="140px" />
			<col width="*" />
		</colgroup>
		<tr>
			<th class="L"><util:message key='mm.prop.domainLang.domainId'/></th>
			<td class="L">
				<input type="text" readonly="readonly" id="DomainLangManager_domainId" name="domainId" value="<c:out value="${aDomainLangVO.domainId}"/>" maxLength="" label="<util:message key='mm.prop.domainLang.domainId'/>" class="txt_100" />
			</td>
			<th class="L"><util:message key='mm.prop.domainLang.langKnd'/></th>
			<td colspan="3" class="L">
				<div class="sel_100">
					<select id="DomainLangManager_langKnd" name="langKnd" class='txt_100' disabled="disabled" label="<util:message key='mm.prop.domainLang.langKnd'/>">
						<c:forEach items="${langKndList}" var="langKnd">
							<option value="<c:out value="${langKnd.code}"/>"><c:out value="${langKnd.codeName}"/></option>
						</c:forEach>
					</select>	
				</div>
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='mm.prop.domainLang.domainNm'/> <em>*</em></th>
			<td colspan="3"  class="L">
				<textarea id="DomainLangManager_domainNm" name="domainNm" value="<c:out value="${aDomainLangVO.domainNm}"/>" cols="80" rows="3" maxLength="256" label="<util:message key='mm.prop.domainLang.domainNm'/>" class="txtbox" >	</textarea>
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='mm.prop.domainLang.domainDesc'/></th>
			<td colspan="3" class="L">
				<textarea id="DomainLangManager_domainDesc" name="domainDesc" value="<c:out value="${aDomainLangVO.domainDesc}"/>" cols="80" rows="3" maxLength="1024" label="<util:message key='mm.prop.domainLang.domainDesc'/>" class="txtbox" >	</textarea>	
			</td>
		</tr>
	</table>
	<!-- btnArea-->
	<div class="btnArea">
		<div class="rightArea">
			<a href="javascript:aDomainLangManager.doUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>		
		</div>
	</div>
	<!-- btnArea//-->			
</form>

<div id="DomainLangManager_DomainLangChooser"></div>