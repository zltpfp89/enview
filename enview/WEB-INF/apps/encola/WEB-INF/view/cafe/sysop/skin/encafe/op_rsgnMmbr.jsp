<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<div class="cafeadm_top">
	<h3><util:message key="cf.title.mng.secessionMember"/></h3>
	<ul class="location">
		<li>HOME<span class="nextbar"></span></li>
		<li><util:message key="cf.title.mng.memberInfo"/><span class="nextbar"></span></li>
		<li class="last"><util:message key="cf.title.mng.secessionMember"/></li>
	</ul>
</div>
		
<!-- 게시판지기 관리 start -->
<div class="board_btn_wrap top">
	<div class="board_btn_wrap_right">
		<form id="rsgn_srchForm" name="rsgn_srchForm" method="POST" onsubmit="return false;">
			<fieldset>
				<legend>검색</legend>
					<select id="srchType" name="srchType">
					  <c:forEach items="${srchTypeList}" var="srchType">
					    <option value="<c:out value="${srchType.code}"/>" <c:if test="${opForm.srchType==srchType.code}">selected</c:if>><c:out value="${srchType.codeName}"/></option>
					  </c:forEach>
					</select>
				<div>
					<label for="search" class="none">검색어입력</label>
					<input type="text" id="rchKey" name="srchKey" value="<c:out value="${opForm.srchKey}"/>"/>
					<label for="search_submin"></label>
					<input type="submit" value="<util:message key="eb.title.search"/>" class="" id="search_submin" onclick="cfOp.rsgnMmbr.search('rsgn_srchForm')"/>
				</div>
				<select id="srchState" name="srchState">
				  <c:forEach items="${srchStateList}" var="srchState">
				    <option value="<c:out value="${srchState.code}"/>" <c:if test="${opForm.srchState==srchState.code}">selected</c:if>><c:out value="${srchState.codeName}"/></option>
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
		  	<input type="hidden" id="pageFunction" name="pageFunction" value="doPage"/>
		  	<input type="hidden" id="naviDivNm" name="naviDivNm" value="rsgn_PAGE_ITERATOR"/>
		</form>
	</div>
</div>
<form id="rsgn_listForm" name="rsgn_listForm" style="display:inline" action="" method="post" onsubmit="return false;">	 
<table id="grid-table" class="table_type01" summary="게시판">
	<caption>게시판</caption>
	<colgroup>
		<col width="80px;">
		<col width="12%;">
		<col width="12%;">
		<col width="15%;">
		<col width="auto;">
	</colgroup>
	<thead>
		<tr style="cursor: pointer;">
			<th><input type="checkbox" id="delCheck" onclick="cfOp.m_checkBox.chkAll(this)"/></th>
			<th><c:out value="${cmntVO.nmTypeNm}"/></th>
			<th><util:message key="ev.hnevent.label.state"/></th>
			<th onclick="cfOp.rsgnMmbr.sort('rsgn_srchForm','state_datim')"><util:message key="cf.title.statusChange.date"/>
				<img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/<c:if test="${opForm.sortMethod!='ASC'}">tiny_down_arrow.gif</c:if><c:if test="${opForm.sortMethod=='ASC'}">tiny_up_arrow.gif</c:if>" style="margin-left:5px"/>
			</th>
			<th><util:message key="eb.prop.reason"/></th>
		</tr>
		  
	</thead>
	<tbody>
	<c:if test="${empty mmbrList}">
		<tr>
			<td colspan="5">
				<util:message key="cf.error.not.exist.leaveMember"/>
			</td>
		</tr>
	</c:if>
	<c:if test="${!empty mmbrList}">
		<c:forEach items="${mmbrList}" var="mmbr" varStatus="status">
		  <tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:if test="{$status % 2 != 0}">cafegridline</c:if>">
			<td>
			  <input type="checkbox" id="rsgn_checkRow" name="rsgn_checkRow" value="<c:out value="${mmbr.userId}"/>" stateFlag="<c:out value="${mmbr.stateFlag}"/>" class="cafecheckbox"/>
			</td>
			<td>
			    <font style="cursor:pointer" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'"
                      onclick="cfOp.viewUserDtl('<c:out value="${mmbr.userId}"/>')">
			      <c:if test="${cmntVO.nmType=='A'}"><c:out value="${mmbr.userNick}"/></c:if>
			      <c:if test="${cmntVO.nmType=='I'}"><c:out value="${mmbr.userId}"/></c:if>
			      <c:if test="${cmntVO.nmType=='N'}"><c:out value="${mmbr.nmKor}"/></c:if>
				</font>
			</td>
			<td>
				<c:out value="${mmbr.stateFlagNm}"/>
			</td>
			<td>
				<c:out value="${mmbr.stateDatimPF}"/>
			</td>
			<td>
			  <c:if test="${mmbr.stateCode != '99'}"><c:out value="${mmbr.stateCodeNm}"/></c:if>
			  <c:if test="${mmbr.stateCode == '99'}"><c:out value="${mmbr.stateDesc}"/></c:if>
			</td>
		  </tr>
		</c:forEach>
	</c:if>
	</tbody>
</table>
</form>

<!-- 페이징 start -->
<div class="paging tm20">
	<div id="rsgn_PAGE_ITERATOR"></div>
</div>
<!-- //페이징 end -->		

<div class="board_btn_wrap tp30">
	<div class="board_btn_wrap_left">
		<strong><util:message key="cf.title.selectedMember"/></strong>
		<a href="#" onclick="javascript:cfOp.rsgnMmbr.changeState('rsgn','40')" class="btn white"><util:message key="cf.prop.realse.activitySuspension"/></a>
		<a href="#" onclick="javascript:cfOp.rsgnMmbr.changeState('rsgn','51')" class="btn white"><util:message key="cf.prop.withdrawal.cancel"/></a>
	</div>
</div>


					
