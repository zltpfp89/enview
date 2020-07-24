<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
					
<%--BEGIN::게시판지기 화면 본판--%>
<c:if test="${opForm.m == 'brdSysop'}">
	<div class="cafeadm_top">
		<h3><util:message key="cf.title.mng.cafeSysop"/></h3>
		<ul class="location">
			<li>HOME<span class="nextbar"></span></li>
			<li><util:message key="cf.title.mng.memberInfo"/><span class="nextbar"></span></li>
			<li class="last"><util:message key="cf.title.mng.cafeSysop"/></li>
		</ul>
	</div>

	<div class="board_btn_wrap top">
		<form id="brd_srchForm" name="brd_srchForm" method="POST" onsubmit="return false;">
			<div class="board_btn_wrap_right">
				<select id="pageSize" name="pageSize" onchange="cfOp.brdSysop.search('brd_srchForm')">
				  <c:forEach items="${pageSizeList}" var="pageSize">
				    <option value="<c:out value="${pageSize.code}"/>" <c:if test="${opForm.pageSize==pageSize.code}">selected</c:if>><c:out value="${pageSize.codeName}"/></option>
				  </c:forEach>
				</select>
			</div>
			<input type="hidden" id="cmd"          name="cmd" value="all"/>
			<input type="hidden" id="sortMethod"   name="sortMethod" value="<c:out value="${opForm.sortMethod}"/>"/>
			<input type="hidden" id="sortColumn"   name="sortColumn"/>
			<input type="hidden" id="pageNo"       name="pageNo" value="<c:out value="${opForm.pageNo}"/>"/>
			<input type="hidden" id="totalSize"    name="totalSize" value="<c:out value="${opForm.totalSize}"/>"/>
			<input type="hidden" id="pageFunction" name="pageFunction" value="cfOp.brdSysop.doPage"/>
			<input type="hidden" id="naviDivNm"    name="naviDivNm" value="brd_PAGE_ITERATOR"/>
		</form>
	</div>
	
	<!-- 게시판지기 관리 start -->
	<form id="brd_listForm" name="brd_listForm" style="display:inline" action="" method="post" onsubmit="return false;">
		<table class="table_type01" summary="게시판" id="grid-table" >
			<caption>게시판</caption>
			<colgroup>
			<col width="80px;">
			<col width="20%;">
			<col width="auto;">
			<col width="20%;">
			<col width="20%;">
			</colgroup>
			<thead>
				<tr style="cursor: pointer;">
					<th>
					  <input type="checkbox" id="delCheck" onclick="cfOp.m_checkBox.chkAll(this)"/>
					</th>
					<th><util:message key="eb.info.ttl.boardNm"/></th>
					<th><util:message key="cf.title.mng.cafeSysop"/>(<c:out value="${cmntVO.nmTypeNm}"/>)</th>
					<th><util:message key="cf.title.joinDate"/></th>
					<th><span><util:message key="cf.title.last.visited"/></th>
				</tr>
			</thead>
			<tbody id="brd_listBody">
			  <c:forEach items="${brdSysopList}" var="brdSysop" varStatus="status">
				  <tr ch="<c:out value="${status.index}"/>" >
					<td>
					  <input type="checkbox" id="brd_checkRow" name="brd_checkRow" class="cafecheckbox" value="<c:out value="${brdSysop.boardId}"/>" userId="<c:out value="${brdSysop.userId}"/>"/>
					</td>
					<td><c:out value="${brdSysop.boardNm}"/></td>
					<td>
					    <font style="cursor:pointer" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'"
		                      <c:if test="${!empty brdSysop.userId}">onclick="cfOp.viewUserDtl('<c:out value="${brdSysop.userId}"/>')"</c:if>>
					      <c:if test="${!empty brdSysop.userId}">
						    <c:if test="${cmntVO.nmType=='A'}"><c:out value="${brdSysop.userNick}"/></c:if>
					        <c:if test="${cmntVO.nmType=='I'}"><c:out value="${brdSysop.userId}"/></c:if>
					        <c:if test="${cmntVO.nmType=='N'}"><c:out value="${brdSsyop.nmKor}"/></c:if>
						  </c:if>
					      <c:if test="${empty brdSysop.userId}">-</c:if>
						</font>
					</td>
					<td>
					    <c:if test="${!empty brdSysop.regDatimPF}"><c:out value="${brdSysop.regDatimPF}"/></c:if>
					    <c:if test="${empty brdSysop.regDatimPF}">-</c:if>
					</td>
					<td>
					    <c:if test="${!empty brdSysop.lastAccessPF}"><c:out value="${brdSysop.lastAccessPF}"/></c:if>
					    <c:if test="${empty brdSysop.lastAccessPF}">-</c:if>
					</td>
				  </tr>
			  </c:forEach>
			 </tbody>
		</table>

	<!-- 페이징 start -->
	<div class="paging tm20">
		<div id="brd_PAGE_ITERATOR"></div>
	</div>
	<!-- //페이징 end -->
	
	</form>
	<div class="board_btn_wrap tp30">
		<div class="board_btn_wrap_left">
			<strong><util:message key="cf.title.mng.cafeSysop.board"/></strong>
			<a href="#" onclick="javascript:cfOp.brdSysop.selectCandidate()" class="btn white"><util:message key="cf.title.select"/></a>
			<a href="#" onclick="javascript:cfOp.brdSysop.removeBoardSysop()" class="btn white"><util:message key="cf.title.release"/></a>
		</div>
	</div>
</c:if>
<%--END::게시판지기 화면 본판--%>
<%--BEGIN::카페회원 목록 선택기--%>
<c:if test="${opForm.m == 'uiMmbrList'}">
<div class="board_btn_wrap top">
  <form id="brdUserChooserForm" style="display:inline" name="brdUserChooserForm" action="" method="post" onsubmit="return false;">
	<table class="table_type01">
	  <tr height=30>
		<td class='cafegridlast' align=right>
		  <input type="text" name="srchUserId" style="width:120;" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.id"/>');"
				 onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.id"/>');"
				 onkeypress="if(event.keyCode==13){cfOp.brdSysop.getUserChooser().doSearch(1);}"
			     <c:if test="${empty opForm.srchUserId}">value="<util:message key="eb.info.ttl.l.id"/>"</c:if>
				 <c:if test="${!empty opForm.srchUserId}">value="<c:out value="${opForm.srchUserId}"/>"</c:if>>
		  <input type="text" name="srchUserNick" style="width:160;" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.name"/>');"
				 onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.name"/>');"
				 onkeypress="if(event.keyCode==13){cfOp.brdSysop.getUserChooser().doSearch(1);}"
			     <c:if test="${empty opForm.srchUserNick}">value="<util:message key="eb.info.ttl.l.name"/>"</c:if>
				 <c:if test="${!empty opForm.srchUserNick}">value="<c:out value="${opForm.srchUserNick}"/>"</c:if>>
		<div class="board_btn_wrap_right">
			<fieldset>
				<label for="search_submin"></label>
				<input type="submit" value="검색" class="" id="search_submin" style="cursor:hand" onclick="cfOp.brdSysop.getUserChooser().doSearch(1)">
			</fieldset>
		</div>
		</td>
		
	  </tr>
	</table>
	<table class="table_type01">
		<colgroup>
			<col width="80px;">
			<col width="20%;">
			<col width="auto;">
		</colgroup>
		<thead>
			<tr style="cursor:pointer;">
			  <th>
				<input type="checkbox" id="delCheck" onclick="cfOp.brdSysop.getUserChooser().m_checkBox.chkAll(this)"/>
			  </th>
			  <th><util:message key="ev.title.statistics.userId"/></th>
			  <th><util:message key="ev.title.user.Username"/></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${mmbrList}" var="mmbr" varStatus="status">
			<tr>
			  <td>
				<input type="checkbox" id="userChooser_checkRow_<c:out value="${status.index}"/>" name="userChooser_checkRow" value="<c:out value="${mmbr.code}"/>">
			  </td>
			  <td onclick="cfOp.brdSysop.getUserChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${mmbr.code}"/></td>
			  <td onclick="cfOp.brdSysop.getUserChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${mmbr.codeName}"/></td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<input type='hidden' name='totalSize' value="<c:out value="${opForm.totalSize}"/>"/>
	
	<!-- 페이징 start -->
	<div class="paging tm20">
		<div id="brdUserChooserPageIterator"></div>
	</div>
	<!-- //페이징 end -->
	
  </form>
</div>
</c:if>
<%--END::카페회원 목록 선택기--%>
