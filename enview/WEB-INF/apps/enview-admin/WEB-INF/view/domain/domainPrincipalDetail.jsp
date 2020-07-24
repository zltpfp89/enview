
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/domainPrincipalManager.js"></script>

<!-- board -->
<div id="LangManager_EditFormPanel" class="board" >
	<!-- tab_list -->
	<div class="tab_list">
		<form id="DomainPrincipalManager_EditForm" style="display:inline" action="" method="post">
			<input type="hidden" id="DomainPrincipalManager_isCreate" />
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<input type='hidden' name='domainId' value=''/>
				<input type='hidden' name='principalId' value=''/>			
		 		<caption>게시판</caption>
				<colgroup>
					<col width="140px" />
					<col width="*" />
					<col width="140px" />
					<col width="*" />
				</colgroup>
				<tr>
					<th class="L"><util:message key='mm.title.id'/></th>
					<td class="L">
						<input type="text" readonly="readonly" id="DomainPrincipalManager_domainId" name="principal" value="<c:out value="${aDomainPrincipalVO.principal}"/>" maxLength="" label="<util:message key='mm.prop.domainPrincipal.domainId'/>" class="txt_100" />
					</td>
				  	<th class="L"><util:message key='mm.prop.domainPrincipal.userNm'/> </th>
				 	<td class="L">
						<input type="text" readonly="readonly" id="DomainPrincipalManager_principalId" name="userName" value="<c:out value="${aDomainPrincipalVO.principal}"/>" maxLength="" label="<util:message key='mm.prop.domainPrincipal.principalId'/>" class="txt_100" />
					</td>
				</tr>
				<tr>
					<th class="L"><util:message key='mm.prop.domainPrincipal.theme'/> </th>
				  	<td class="L" colspan="3">
				  		<%-- <input type="text" id="DomainPrincipalManager_theme" name="theme" value="<c:out value="${aDomainPrincipalVO.theme}"/>" maxLength="" label="<util:message key='mm.prop.domainPrincipal.theme'/>" class="full_webtextfield" /> --%>
				  		<div class="sel_100">
							<select id="DomainPrincipalManager_theme" name="theme" label="<util:message key='ev.title.domainPrincipalDetail.theme'/>" class='txt_100'>
								<option value=""></option>
								<c:forEach items="${themeList}" var="theme">
									<option value="<c:out value="${theme}"/>"><c:out value="${theme}"/></option>
								</c:forEach>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<th class="L"><util:message key='mm.prop.domainPrincipal.defaultPage'/> </th>
					<td class="L" colspan="3">
						<input type="text" id="DomainPrincipalManager_defaultPage" name="defaultPage" value="<c:out value="${aDomainPrincipalVO.defaultPage}"/>" maxLength="" label="<util:message key='mm.prop.domainPrincipal.defaultPage'/>" class="txt_400" style="width:75%;"/>
					  	<a href="javascript:aDomainPrincipalManager.getPageChooser().doShow(aDomainPrincipalManager.setDefaultPageChooserCallback)" class="btn_O"><span><util:message key='ev.title.selectPage'/></span></a>
					</td>
				</tr>
				<tr>
					<th class="L"><util:message key='mm.prop.domainPrincipal.subPage'/> </th>
				  	<td class="L" colspan="3">
				  		<input type="text" id="DomainPrincipalManager_subPage" name="subPage" value="<c:out value="${aDomainPrincipalVO.subPage}"/>" maxLength="" label="<util:message key='mm.prop.domainPrincipal.subPage'/>" class="txt_400" style="width:75%;"/>
				   		<a href="javascript:aDomainPrincipalManager.getPageChooser().doShow(aDomainPrincipalManager.setSubPageChooserCallback)" class="btn_O"><span><util:message key='ev.title.selectPage'/></span></a>
					</td>
				</tr>					
			</table>
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
					<a href="javascript:aDomainPrincipalManager.doUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>		
				</div>
			</div>
			<!-- btnArea//-->						
		</form>	
	</div>
</div>
<!-- board// -->

<div id="DomainPrincipalManager_DomainPrincipalChooser"></div>