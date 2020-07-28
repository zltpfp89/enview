<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%--BEGIN::게시판지기 화면 본판--%>
<c:if test="${opForm.m == 'brdSysop'}">
<div class="cafepanel" style="width:100%;">
  <br style='line-height:5px;'>
  <div>
	<form id="brd_srchForm" name="brd_srchForm" method="POST" onsubmit="return false;">
	  <table width="100%">
	    <tr>
		  <td align="right">
			<select id="pageSize" name="pageSize" onchange="cfOp.brdSysop.search('brd_srchForm')">
			  <c:forEach items="${pageSizeList}" var="pageSize">
			    <option value="<c:out value="${pageSize.code}"/>" <c:if test="${opForm.pageSize==pageSize.code}">selected</c:if>><c:out value="${pageSize.codeName}"/></option>
			  </c:forEach>
			</select>
		  </td>
	  </tr>
	  </table>    
	  <input type="hidden" id="cmd"          name="cmd" value="all"/>
	  <input type="hidden" id="sortMethod"   name="sortMethod" value="<c:out value="${opForm.sortMethod}"/>"/>
	  <input type="hidden" id="sortColumn"   name="sortColumn"/>
	  <input type="hidden" id="pageNo"       name="pageNo" value="<c:out value="${opForm.pageNo}"/>"/>
	  <input type="hidden" id="totalSize"    name="totalSize" value="<c:out value="${opForm.totalSize}"/>"/>
	  <input type="hidden" id="pageFunction" name="pageFunction" value="cfOp.brdSysop.doPage"/>
	  <input type="hidden" id="naviDivNm"    name="naviDivNm" value="brd_PAGE_ITERATOR"/>
	</form>
  </div>
  <div class="cafegridpanel">
	<form id="brd_listForm" name="brd_listForm" style="display:inline" action="" method="post" onsubmit="return false;">
	  <table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
		<thead>
		  <tr><td colspan="100" height="5"></td></tr>
		  <tr><td colspan="100" height="2" class="cafegridlimit"></td></tr>
		  <tr style="cursor: pointer;">
			<th class="cafegridheader" align="center" width="30px">
			  <input type="checkbox" id="delCheck" onclick="cfOp.m_checkBox.chkAll(this)"/>
			</th>
			<th class="cafegridheader"><span>게시판명</span></th>
			<th class="cafegridheader"><span>게시판지기(<c:out value="${cmntVO.nmTypeNm}"/>)</span></th>
			<th class="cafegridheader"><span>가입일</span></th>
			<th class="cafegridheaderlast"><span>최종방문일</span></th>	
		  </tr>
		</thead>
		<tbody id="brd_listBody">
		  <c:forEach items="${brdSysopList}" var="brdSysop" varStatus="status">
		  <tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:if test="{$status % 2 != 0}">cafegridline</c:if>"
              onmouseover="ebUtil.activeLine(this,true)" onmouseout="ebUtil.activeLine(this,false)">
			<td align="center" class="cafegrid">
			  <input type="checkbox" id="brd_checkRow" name="brd_checkRow" class="cafecheckbox" value="<c:out value="${brdSysop.boardId}"/>" userId="<c:out value="${brdSysop.userId}"/>"/>
			</td>
			<td align="left" class="cafegrid"><span style="margin-left:10px"><c:out value="${brdSysop.boardNm}"/></span></td>
			<td align="left" class="cafegrid">
			  <span style="margin-left:10px">
			    <font style="cursor:pointer" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'"
                      <c:if test="${!empty brdSysop.userId}">onclick="cfOp.viewUserDtl('<c:out value="${brdSysop.userId}"/>')"</c:if>>
			      <c:if test="${!empty brdSysop.userId}">
				    <c:if test="${cmntVO.nmType=='A'}"><c:out value="${brdSysop.userNick}"/></c:if>
			        <c:if test="${cmntVO.nmType=='I'}"><c:out value="${brdSysop.userId}"/></c:if>
			        <c:if test="${cmntVO.nmType=='N'}"><c:out value="${brdSsyop.nmKor}"/></c:if>
				  </c:if>
			      <c:if test="${empty brdSysop.userId}">-</c:if>
				</font>
			  </span>
			</td>
			<td align="left" class="cafegrid">
			  <span style="margin-left:10px">
			    <c:if test="${!empty brdSysop.regDatimPF}"><c:out value="${brdSysop.regDatimPF}"/></c:if>
			    <c:if test="${empty brdSysop.regDatimPF}">-</c:if>
			  </span>
			</td>
			<td align="left" class="cafegridlast">
			  <span style="margin-left:10px">
			    <c:if test="${!empty brdSysop.lastAccessPF}"><c:out value="${brdSysop.lastAccessPF}"/></c:if>
			    <c:if test="${empty brdSysop.lastAccessPF}">-</c:if>
			  </span>
			</td>
		  </tr>
		  </c:forEach>
		  <tr><td colspan="100" height="2" class="cafegridlimit"></td></tr>
		  <tr><td colspan="100" height="5"></td></tr>
		  <tr style="cursor:pointer;">
		    <td colspan="100">
			  <span style="margin-left:30px">선택된 게시판에 게시판 지기</span>
			  <span style="margin-left:10px">
				<input type="button" value="선정" onclick="cfOp.brdSysop.selectCandidate()"/>
				<input type="button" value="해제" onclick="cfOp.brdSysop.removeBoardSysop()"/>
			  </span>
			</td>
		  </tr>
		</tbody>
	  </table>
	</form>
  </div>
  <div>
	<table style="width:100%;">
	<tr>
	  <td align="center">
		<div id="brd_PAGE_ITERATOR"></div>
	  </td>    
	</tr>
	</table>
  </div>
</div>
</c:if>
<%--END::게시판지기 화면 본판--%>
<%--BEGIN::카페회원 목록 선택기--%>
<c:if test="${opForm.m == 'uiMmbrList'}">
<div class="cafegridpanel" style="width:100%">
  <form id="brdUserChooserForm" style="display:inline" name="brdUserChooserForm" action="" method="post" onsubmit="return false;">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
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
		  <img src="<%=request.getContextPath()%>/board/images/button/btn_search.gif" width="48" height="20" align="absmiddle" style="cursor:hand" onclick="cfOp.brdSysop.getUserChooser().doSearch(1)">
		</td>
	  </tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <thead>
		<tr><td height="2" colspan="3" class="cafegridlimit"></td></tr>
		<tr style="cursor:pointer;width:10%">
		  <th class="cafegridheader" align="center">
			<input type="checkbox" id="delCheck" onclick="cfOp.brdSysop.getUserChooser().m_checkBox.chkAll(this)"/>
		  </th>
		  <th class="cafegridheader" ch="0" align="center" width=40%><span>사용자 ID</span></th>
		  <th class="cafegridheaderlast" ch="0" align="center" width=50%><span>사용자 명</span></th>
		</tr>
	  </thead>
	  <tbody>
		<tr><td height=1 colspan=3></td></tr>
		<c:forEach items="${mmbrList}" var="mmbr" varStatus="status">
		<tr height=22 <c:if test="${status.index % 2 == 1 }">class='cafegridline'</c:if> onmouseover="ebUtil.activeLine(this,true)" onmouseout="ebUtil.activeLine(this,false)">
		  <td align='center' class='cafegrid'>
			<input type="checkbox" id="userChooser_checkRow_<c:out value="${status.index}"/>" name="userChooser_checkRow" value="<c:out value="${mmbr.code}"/>">
		  </td>
		  <td align='left' class='cafegrid' onclick="cfOp.brdSysop.getUserChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${mmbr.code}"/></td>
		  <td align='left' class='cafegridlast' onclick="cfOp.brdSysop.getUserChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${mmbr.codeName}"/></td>
		</tr>
		<tr><td height=1 colspan=3></td></tr>
		</c:forEach>
		<tr><td height=2 colspan=3 class='cafegridlimit'></td></tr>
		<tr><td align="center" colspan=3><div id="brdUserChooserPageIterator"></div></td></tr>
	  </tbody>
	</table>
	<input type='hidden' name='totalSize' value="<c:out value="${opForm.totalSize}"/>"/>
  </form>
</div>
</c:if>
<%--END::카페회원 목록 선택기--%>
