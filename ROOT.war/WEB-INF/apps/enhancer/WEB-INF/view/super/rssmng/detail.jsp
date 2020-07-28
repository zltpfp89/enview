<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<c:if test="${feed.serviceType == 'SERVICE' }" var="isService"/>
<c:if test="${userInfo.hasAdminRole || userInfo.hasManagerRole }" var="isSuperAdmin" />
<c:if test="${(userInfo.hasAdminRole || userInfo.hasManagerRole) || (userInfo.hasDomainManagerRole && feed.domainId != 0)}" var="isEditable"/>

<!-- RssManager_DetailTabPage -->
<div id="RssManager_DetailTabPage" class="board">														
	<form id="feedForm" name="feedForm" method="post" action="<%=request.getContextPath()%>/hancer/rss/detailFeed.hanc">
		<input	type="hidden" id="feedId" name="id" value="<c:out value="${feed.id}"/>" />
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
	 		<caption>게시판</caption>
			<colgroup>
				<col width="140px" />
				<col width="*" />
				<col width="140px" />
				<col width="*" />
			</colgroup>	
			<c:if test="${isSuperAdmin && isService}">
				<tr>
					<th class="L"><util:message key='ev.prop.domain.domain'/> </th>
					<td colspan="3" class="L">
						<div class="sel_100">
							<select id="domainId" name="domainId" class="txt_100" onchange="javascript:enFeed.initCategoryByDomain();">
								<option value="-1">* <util:message key='ev.prop.domain.domain'/> *</option>
								<c:forEach items="${domainList}" var="domain">
									<option <c:if test="${feed.domainId == domain.domainId}">selected="selected"</c:if> value="<c:out value="${domain.domainId}"/>"><c:out value="${domain.domainNm}"/></option>
								</c:forEach>
							</select>
						</div>	
					</td>
				</tr>
			</c:if>
			<c:if test="${!isSuperAdmin || !isService}"><input type="hidden" id="domainId" value="<c:out value="${domainInfo.domainId}"/>"/></c:if>
			<tr>
				<th class="L"><util:message key="hn.rss.label.feedName"/></th>
				<td colspan="3" class="L">
					<c:if test="${isService}">
						<input type="text" id="name" name="name" value="<c:out value="${feed.name}"/>" size="100" class="txt_600" <c:if test="${!isEditable}">readonly="readonly"</c:if>/>
					</c:if>
					<c:if test="${!isService}">
						<c:out value="${feed.name}"/>
					</c:if>
				</td>
			</tr>
			<tr>
				<th class="L"><util:message key="hn.rss.label.category"/> <em>*</em></th>
				<td colspan="3" class="L">
					<div class="sel_100">
						<select	id="categoryId" name="categoryId" size="1" class="txt_100" <c:if test="${!isEditable}">disabled="disabled"</c:if>>
							<option value="-1"><util:message key="hn.rss.label.category"/></option>
							<c:forEach items="${categoryList}" var="category">
								<option value="<c:out value="${category.id}"/>" <c:if test="${feed.categoryId == category.id}"> selected</c:if>>
									<c:out value="${category.name}" />(<c:out value="${category.domainNm }"/>)
								</option>
							</c:forEach>
						</select>
					</div>	
					&nbsp;
					<c:if test="${isService}">
						<%-- <img src="<%=request.getContextPath()%>/hancer/images/rss/button/rss_cate.gif" onclick="javascript:enRss.popupCategory()" alt="<util:message key="hn.rss.label.category"/>" style="cursor:pointer"> --%>
						<a href="javascript:enRss.popupCategory()" class="btn_W"><span><util:message key="hn.rss.label.category"/></span></a>
					</c:if>
				</td>
			</tr>
			<tr>
				<th class="L"><util:message key="hn.rss.label.feedUrl"/> <em>*</em></th>
				<td colspan="3" class="L">
					<c:if test="${isService}">
						<input type="text" id="url" name="url" value="<c:out value="${feed.url}"/>"	size="100" class="txt_600" <c:if test="${!isEditable}">readonly="readonly"</c:if>/>
					</c:if>
					<c:if test="${!isService}">
						<c:out value="${feed.url}"/>
					</c:if>
				</td>
			</tr>
			<tr>
				<th class="L"><util:message key="hn.rss.label.homepage"/> </th>
				<td colspan="3" class="L">
					<c:if test="${isService}">
						<input type="text" id="homepage" name="homepage" value="<c:out value="${feed.homepage}"/>" size="100" class="txt_600" <c:if test="${!isEditable}">readonly="readonly"</c:if>/>
					</c:if>
					<c:if test="${!isService}">
						<c:out value="${feed.homepage}"/>
					</c:if>
				</td>
			</tr>
			<tr>
				<th class="L"><util:message key="hn.rss.label.states"/> </th>
				<td colspan="3" class="L">
					<c:out value="${feed.statusText}" />
					<input type="hidden" id="feedStatus" value="<c:out value="${feed.status }"/>">
				</td>
			</tr>
			<c:if test="${!isService}">
				<tr>
					<th class="L"><util:message key="hn.rss.label.isAllowed"/> </th>
					<td colspan="3" class="L">
						<c:out value="${feed.allowedText}"/>
						&nbsp;
						<c:if test="${not empty feed.id}">
						<c:if test="${feed.isAllowed == 0 || feed.isAllowed == 2 }">
							<a href="javascript:enFeed.acceptRequest();" class="btn_B"><span><util:message key="hn.rss.label.allowed"/></span></a>
							&nbsp;
							<a href="javascript:enFeed.denyRequest();" class="btn_B"><span><util:message key="hn.rss.label.notAllowed"/></span></a>
						</c:if>
						<c:if test="${feed.isAllowed == 1 }">
							<a href="javascript:enFeed.acceptCancelRequest();" class="btn_B"><span><util:message key="hn.rss.label.cancelAllow"/></span></a>
						</c:if>
						<c:if test="${feed.isAllowed == 3 }">
							<a href="javascript:enFeed.acceptRequest();" class="btn_B"><span><util:message key="hn.rss.label.allowed"/></span></a>
						</c:if>
						</c:if>
					</td>
				</tr>
				<tr>
					<th class="L"><util:message key="hn.rss.label.orderer"/> </th>
					<td class="L" colspan="3"><c:out value="${feed.requestUserName}"/></td>
				</tr>
				<tr style="height:100px; line-height:120px;">
					<th class="L"><util:message key="hn.rss.label.allowedGroup"/></th>
					<td class="L">
							<select id="permittedList" multiple="multiple" size="5" style="width:180px">
								<c:forEach items="${permittedList }" var="permitted" varStatus="status">
									<option value="<c:out value="${permitted.groupId}"/>"><c:out value="${permitted.groupName}"/></option>
								</c:forEach>
							</select>
						&nbsp;
						<a href="javascript:enFeed.removeGroup();" class="btn_B"><span><util:message key="hn.rss.label.delete"/></span></a>
					</td>
					<th class="L"><util:message key="hn.rss.label.notAllowedGroup"/></th>
					<td class="L">
							<select id="unpardonedList" multiple="multiple" size="5" style="width:180px">
								<c:forEach items="${unpardonedList }" var="permitted" varStatus="status">
									<option value="<c:out value="${permitted.groupId}"/>"><c:out value="${permitted.groupName}"/></option>
								</c:forEach>
							</select>
						&nbsp;
						<a href="javascript:enFeed.addGroup();" class="btn_B"><span><util:message key="hn.rss.label.add"/></span></a>
					</td>
				</tr>
			</c:if>
		</table>
		<c:if test="${isEditable}">
			<!-- btnArea-->
			<div class="btnArea">
				<c:if test="${not empty feed.id}">
					<div id="RssManager_Child_EditButtons" class="rightArea">
						<a href="javascript:enFeed.update()" class="btn_B"><span><util:message key="hn.rss.label.save"/></span></a>
					</div>
				</c:if>
			</div>
			<!-- btnArea//-->					
		</c:if>
	</form>
</div>
<!-- RssManager_DetailTabPage// -->