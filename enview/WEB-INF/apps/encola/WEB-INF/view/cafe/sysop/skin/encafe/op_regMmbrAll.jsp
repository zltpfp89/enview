<%@page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
request.setAttribute( "isAdmin", EnviewSSOManager.getUserInfo(request).getHasAdminRole());
request.setAttribute( "userId", EnviewSSOManager.getUserId(request,response));

%>
	<!-- 전체회원 정보 start -->
	<div class="board_btn_wrap">
	<form id="all_srchForm" name="all_srchForm" method="POST" onsubmit="return false;">
	<div class="board_btn_wrap_left">
		<util:message key="cf.title.mmbrCnt"/> : <strong class="font_blue rm30"><c:out value="${cmntVO.mmbrTotCF}"/></strong>
		<util:message key="cf.title.currentViews"/> : <strong class="font_blue"><c:out value="${opForm.totalSize}"/></strong>
	</div>
	<div class="board_btn_wrap_right">
		<fieldset>
				<legend>검색</legend>
				<select id="srchType" name="srchType">
				  <c:forEach items="${srchTypeList}" var="srchType">
	<option value="<c:out value="${srchType.code}"/>" <c:if test="${opForm.srchType==srchType.code}">selected</c:if>><c:out value="${srchType.codeName}"/></option>
	</c:forEach>
	</select>
	<div>
		<label for="search" class="none">검색어입력</label>
		<input type="text" id="srchKey" name="srchKey" value="<c:out value="${opForm.srchKey}"/>"/>
	<label for="search_submin"></label>
	<input type="submit" value="<util:message key="eb.title.search"/>" class="" id="search_submin" style="cursor:hand" onclick="cfOp.regMmbr.search('all_srchForm')">
	</div>
	<select id="srchGrd" name="srchGrd">
	  <c:forEach items="${srchGrdList}" var="srchGrd">
	<option value="<c:out value="${srchGrd.code}"/>" <c:if test="${opForm.srchGrd==srchGrd.code}">selected</c:if>><c:out value="${srchGrd.codeName}"/></option>
	</c:forEach>
	</select>
	<select id="pageSize" name="pageSize">
	  <c:forEach items="${pageSizeList}" var="pageSize">
	<option value="<c:out value="${pageSize.code}"/>" <c:if test="${opForm.pageSize==pageSize.code}">selected</c:if>><c:out value="${pageSize.codeName}"/></option>
	</c:forEach>
		</select>
	</fieldset>
	<input type="hidden" id="cmd" name="cmd" value="all"/>
	<input type="hidden" id="sortMethod" name="sortMethod" value="<c:out value="${opForm.sortMethod}"/>"/>
	<input type="hidden" id="sortColumn" name="sortColumn"/>
	<input type="hidden" id="pageNo" name="pageNo" value="<c:out value="${opForm.pageNo}"/>"/>
	<input type="hidden" id="totalSize" name="totalSize" value="<c:out value="${opForm.totalSize}"/>"/>
					<input type="hidden" id="pageFunction" name="pageFunction" value="cfOp.regMmbr.doPage"/>
					<input type="hidden" id="naviDivNm" name="naviDivNm" value="all_PAGE_ITERATOR"/>
			</div>
		</form>
	</div>
	<form id="all_listForm" name="all_listForm" style="display:inline" action="" method="post" onsubmit="return false;">
	<table class="table_type01" summary="게시판">
		<caption>게시판</caption>
		<colgroup>
			<col width="40px;">
			<col width="auto;">
			<col width="auto;">
			<col width="auto;">
			<col width="120px;">
			<col width="80px;">
			<col width="80px;">
			<col width="80px;">
			<col width="80px;">
		</colgroup>
		<thead>
			<tr style="cursor: pointer;">
				<th class="cafegridheader" align="center" width="30px">
				  <input type="checkbox" id="delCheck" class="cafecheckbox" onclick="cfOp.m_checkBox.chkAll(this)"/>
				</th>
				<%--
				<th><c:out value="${cmntVO.nmTypeNm}"/></th>
				 --%>
				 
				<th><util:message key="cf.title.nickname"/></th>
				<th><util:message key="mm.title.id"/></th>
				<th><util:message key="eb.info.ttl.name"/></th>
				<th><util:message key="cf.title.mmbrLevel"/></th>
				<th onclick="cfOp.regMmbr.sort('all_srchForm','reg_datim')">
					<util:message key="cf.title.joinDate"/>
					<c:if test="${opForm.sortColumn=='reg_datim' and opForm.sortMethod=='ASC'}">
				 		<img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/tiny_up_arrow.gif" style="margin-left:5px;margin-top:7px"/>
				 	</c:if>
					<c:if test="${opForm.sortColumn=='reg_datim' and opForm.sortMethod=='DESC'}">
				 		<img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/tiny_down_arrow.gif" style="margin-left:5px;margin-top:7px"/>
				 	</c:if>
				 </th>
				<th onclick="cfOp.regMmbr.sort('all_srchForm','last_access')"><span><util:message key="cf.title.last.visited"/>
					<c:if test="${opForm.sortColumn=='last_access' and opForm.sortMethod=='ASC'}">
				 		<img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/tiny_up_arrow.gif" style="margin-left:5px;margin-top:7px"/>
				 	</c:if>
					<c:if test="${opForm.sortColumn=='last_access' and opForm.sortMethod=='DESC'}">
				 		<img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/tiny_down_arrow.gif" style="margin-left:5px;margin-top:7px"/>
				 	</c:if>
				 </th>
				<th onclick="cfOp.regMmbr.sort('all_srchForm','visit_cnt')"><util:message key="cf.title.visitCnt"/> 
					<c:if test="${opForm.sortColumn=='visit_cnt' and opForm.sortMethod=='ASC'}">
				 		<img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/tiny_up_arrow.gif" style="margin-left:5px;margin-top:7px"/>
				 	</c:if>
					<c:if test="${opForm.sortColumn=='visit_cnt' and opForm.sortMethod=='DESC'}">
				 		<img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/tiny_down_arrow.gif" style="margin-left:5px;margin-top:7px"/>
				 	</c:if>
				</th>
				<th onclick="cfOp.regMmbr.sort('all_srchForm','bltn_cnt')"><util:message key="eb.title.bltnCnt"/>
					<c:if test="${opForm.sortColumn=='bltn_cnt' and opForm.sortMethod=='ASC'}">
				 		<img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/tiny_up_arrow.gif" style="margin-left:5px;margin-top:7px"/>
				 	</c:if>
					<c:if test="${opForm.sortColumn=='bltn_cnt' and opForm.sortMethod=='DESC'}">
				 		<img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/tiny_down_arrow.gif" style="margin-left:5px;margin-top:7px"/>
				 	</c:if>
				</th>
			</tr>
		</thead>
		<tbody id="all_listBody">
			<c:if test="${empty mmbrList}">
				<tr>
					<td colspan="7">
						<util:message key="cf.error.not.exist.member"/>
					</td>
				</tr>
			</c:if>
			<c:if test="${!empty mmbrList}">
				<c:forEach items="${mmbrList}" var="mmbr" varStatus="status">
					<c:set var="editable" value="Y"/>
					<c:if test="${mmbr.userId == userId}">
						<c:set var="editable" value="N"/>
					</c:if>
					<c:if test="${myGrd=='W' }">
						<c:if test="${mmbr.mmbrGrd=='W' or mmbr.mmbrGrd=='X'}">
							<c:set var="editable" value="N"/>
						</c:if>
					</c:if>
					<tr ch="<c:out value="${status.index}"/>" class="<c:if test="{$status % 2 != 0}">cafegridline</c:if>">
						<td>
					  	<input type="checkbox" ${ editable=="Y" ? "id='all_checkRow' name='all_checkRow'"  : "disabled='disabled'"} class="cafecheckbox" value="<c:out value="${mmbr.userId}"/>" stateFlag="<c:out value="${mmbr.stateFlag}"/>" mmbrGrd="<c:out value="${mmbr.mmbrGrd}"/>"/>
						</td>
						<%--
						<td>
						    <font style="cursor:pointer" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'"   onclick="cfOp.viewUserDtl('<c:out value="${mmbr.userId}"/>')">	</font>
						</td>
						 --%>
						<td>
						<c:out value="${mmbr.userNick}"/>
						</td>
						<td>
						<c:out value="${mmbr.userId}"/>
						</td>
						<td>
						<c:out value="${mmbr.nmKor}"/>
						</td>
						<td><c:out value="${mmbr.mmbrGrdNm}"/></td>
						<td><c:out value="${mmbr.regDatimPF}"/></td>
						<td><c:out value="${mmbr.lastAccessPF}"/></td>
						<td><c:out value="${mmbr.visitCntCF}"/></td>
						<td><c:out value="${mmbr.bltnCntCF}"/></td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>		
	
	<!-- 페이징 start -->
	<div class="paging tm20">
		<div id="all_PAGE_ITERATOR"></div>
	</div>
	<!-- //페이징 end -->
	
	<div class="board_btn_wrap tp30">
		<div class="board_btn_wrap_left">
			<strong><util:message key="cf.title.selectedMember"/></strong>
			<select id="all_changeGrd" name="all_changeGrd" class="lm10">
			  <c:forEach items="${changeGrdList}" var="changeGrd">
			<option value="<c:out value="${changeGrd.code}"/>" <c:if test="${opForm.changeGrd==changeGrd.code}">selected</c:if>><c:out value="${changeGrd.codeName}"/></option>
			</c:forEach>
			</select> 
			<a href="#" onclick="javascript:cfOp.regMmbr.changeGrade('all')" class="btn white"><util:message key="cf.prop.change"/></a>
			<a href="#" onclick="javascript:cfOp.regMmbr.checkChangeState('all','40')" class="btn white"><util:message key="cf.prop.activitySuspension"/></a>
			<a href="#" onclick="javascript:cfOp.regMmbr.checkChangeState('all','51')" class="btn white"><util:message key="cf.prop.withdrawal"/></a>
		</div>
	</div>
	</form>
	<!-- //기본정보 end -->