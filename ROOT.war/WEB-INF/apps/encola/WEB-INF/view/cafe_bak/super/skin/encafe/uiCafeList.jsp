<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ page import="com.saltware.enboard.vo.BulletinVO"%>
<%
	String evcp = request.getContextPath();
%>
<%--BEGIN::게시글/댓글 검색이 아닌 경우--%>
<c:if test="${suForm.cmd != 'bltn' && suForm.cmd != 'memo'}">
  <c:if test="${suForm.cmd == 'func'}">
	  <span style="margin-left:20px">
	    <img src="<%=evcp%>/cola/cafe/images/super/encafe/ic_triangle.gif" width="10" height="9" align="absmiddle">
		<font class="adformlabel" style="margin:10px 0px 20px 0px">
		  <c:choose>
			<c:when test="${suForm.view == 'permit'}">개설 신청</c:when>
			<c:when test="${suForm.view == 'close'}">자진 폐쇄</c:when>
			<c:when test="${suForm.view == 'force'}">강제 폐쇄</c:when>
			<c:when test="${suForm.view == 'hit'}">방문수 순위</c:when>
			<c:when test="${suForm.view == 'mile'}">랭킹   순위</c:when>
			<c:when test="${suForm.view == 'mmbr'}">회원수 순위</c:when>
			<c:when test="${suForm.view == 'rcmd'}">추천 카페</c:when>
		  </c:choose>
		</font>
	  </span>
  </c:if>
	  <form id="superListForm" style="display:inline" name="superListForm" action="" method="post">
	    <input type="hidden" id="superList_totalSize" name="superList_totalSize" value="<c:out value="${suForm.totalSize}"/>"/>
		<table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
		  <thead>
			<tr><td height="2" colspan="8" class="adgridlimit"></td></tr>
			<tr style="cursor: pointer;">
			  <th class="adgridheader" align="center"><input type="checkbox" id="delCheck" onclick="superMngr.m_checkBox.chkAll(this)"/></th>
			  <c:if test="${suForm.cmd == 'func' && (suForm.view == 'hit' || suForm.view == 'mile' || suForm.view == 'mmbr' || suForm.view == 'rcmd')}">
			  <th class="adgridheader" ch="0"><span>순위</span></th>
			  </c:if>
			  <th class="adgridheader" ch="0"><span>카페 주소</span></th>
			  <th class="adgridheader" ch="0"><span>카페 이름</span></th>
			  <c:if test="${suForm.cmd == 'func' && (suForm.view == 'hit' || suForm.view == 'mile' || suForm.view == 'mmbr')}">
			  <th class="adgridheader" ch="0">
			    <c:if test="${suForm.view == 'hit'}">
			      <span>방문 수</span>
				</c:if>
			    <c:if test="${suForm.view == 'mile'}">
			      <span>마일리지</span>
				</c:if>
			    <c:if test="${suForm.view == 'mmbr'}">
			      <span>회원 수</span>
				</c:if>
			  </th>
			  </c:if>
			  <th class="adgridheader" ch="0"><span>카페지기</span></th>
			  <th class="adgridheader" ch="0"><span>상태</span></th>
			  <th class="adgridheaderlast" ch="0"><span>최종상태변경일</span></th>
			</tr>
		  </thead>
		  <tbody id="superListBody">
		    <c:forEach items="${cafeList}" var="cafe" varStatus="status">
		    <tr id="superList<c:out value="${status.index}"/>" <c:if test="${status.index % 2 == 1}">class="adgridline"</c:if>
			    ch="<c:out value="${status.index}"/>" style="cursor:pointer" onmouseover="ebUtil.activeLine(this,true)" onmouseout="ebUtil.activeLine(this,false)" >
			  <td align="center" class="adgrid">
			    <input type="checkbox" id="superList<c:out value="${status.index}"/>_checkRow" class="webcheckbox" onclick="superMngr.doSelect(this)"/>
				<input type="hidden" id="superList<c:out value="${status.index}"/>_cmntId" value="<c:out value="${cafe.cmntId}"/>"/>
				<input type="hidden" id="superList<c:out value="${status.index}"/>_cmntUrl" value="<c:out value="${cafe.cmntUrl}"/>"/>
			  </td>
			  <c:if test="${suForm.cmd == 'func' && (suForm.view == 'hit' || suForm.view == 'mile' || suForm.view == 'mmbr' || suForm.view == 'rcmd')}">
			  <td align="left" class="adgrid" onclick="superMngr.doSelect(this)">
			    <c:out value="${cafe.rnum}"/>
			  </td>
			  </c:if>
			  <td align="left" class="adgrid" onclick="superMngr.doSelect(this)">
			    <c:out value="${cafe.cmntUrl}"/>
			  </td>
			  <td align="left" class="adgrid" onclick="superMngr.doSelect(this)">
			    <c:out value="${cafe.cmntNm}"/>
			  </td>
			  <c:if test="${suForm.cmd == 'func' && (suForm.view == 'hit' || suForm.view == 'mile' || suForm.view == 'mmbr')}">
			  <td align="left" class="adgrid" onclick="superMngr.doSelect(this)">
			    <c:if test="${suForm.view == 'hit'}">
			      <c:out value="${cafe.hitTotCF}"/>
				</c:if>
			    <c:if test="${suForm.view == 'mile'}">
			      <c:out value="${cafe.mileTotCF}"/>
				</c:if>
			    <c:if test="${suForm.view == 'mmbr'}">
			      <c:out value="${cafe.mmbrTotCF}"/>
				</c:if>
			  </td>
			  </c:if>
			  <td align="left" class="adgrid" onclick="superMngr.doSelect(this)">
			    <span id="superList<c:out value="${status.index}"/>_makerId_label"><c:out value="${cafe.makerIdNm}"/></span>
			  </td>
			  <td align="left" class="adgrid" onclick="superMngr.doSelect(this)">
			    <span id="superList<c:out value="${status.index}"/>_cmntState_label"><c:out value="${cafe.cmntStateNm}"/></span>
			  </td>
			  <td align="left" class="adgridlast" onclick="superMngr.doSelect(this)">
			    <span id="superList<c:out value="${status.index}"/>_updDatim_label"><c:out value="${cafe.updDatimPF}"/></span>
			  </td>
			</tr>
			</c:forEach>
			<tr><td height="2" colspan="8" class="adgridlimit"></td></tr>
			<tr>
			  <td height="22" colspan="8">
				<c:if test="${empty cafeList}">
			      <span><util:message key="ev.info.notFoundData"/></span>
				</c:if>
				<c:if test="${!empty cafeList}">
			      <span>전제 조회 건수는 <c:out value="${suForm.totalSize}"/>건 입니다</span>
				</c:if>
			  </td>
			</tr>
		  </tbody>
		</table>
	  </form>
</c:if>
<%--END::게시글/댓글 검색이 아닌 경우--%>
<%--BEGIN::게시글 검색--%>
<c:if test="${suForm.cmd == 'bltn'}">
	  <form id="superListForm" style="display:inline" name="superListForm" action="" method="post">
	    <input type="hidden" id="superList_totalSize" name="superList_totalSize" value="<c:out value="${suForm.totalSize}"/>"/>
		<table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
		  <thead>
			<tr><td height="2" colspan="7" class="adgridlimit"></td></tr>
			<tr style="cursor: pointer;">
			  <th class="adgridheader" align="center"><input type="checkbox" id="delCheck" onclick="superMngr.m_checkBox.chkAll(this)"/></th>
			  <th class="adgridheader" ch="0"><span>카페 명</span></th>
			  <th class="adgridheader" ch="0"><span>게시판 명</span></th>
			  <th class="adgridheader" ch="0"><span>제목</span></th>
			  <th class="adgridheader" ch="0"><span>작성자</span></th>
			  <th class="adgridheader" ch="0"><span>작성일</span></th>
			  <th class="adgridheaderlast" ch="0"><span>조회수</span></th>
			</tr>
		  </thead>
		  <tbody id="superListBody">
		    <c:forEach items="${bltnList}" var="bltn" varStatus="status">
		    <tr id="superList<c:out value="${status.index}"/>" <c:if test="${status.index % 2 == 1}">class="adgridline"</c:if>
			    ch="<c:out value="${status.index}"/>" style="cursor:pointer" onmouseover="ebUtil.activeLine(this,true)" onmouseout="ebUtil.activeLine(this,false)" >
			  <td align="center" class="adgrid">
			    <input type="checkbox" id="superList<c:out value="${status.index}"/>_checkRow" class="webcheckbox"/>
				<input type="hidden" id="superList<c:out value="${status.index}"/>_boardId" value="<c:out value="${bltn.boardId}"/>"/>
				<input type="hidden" id="superList<c:out value="${status.index}"/>_bltnNo" value="<c:out value="${bltn.bltnNo}"/>"/>
			  </td>
			  <td align="center" class="adgrid" onclick="superMngr.doSelect(this)">
			    <c:out value="${bltn.cmntNm}"/>
			  </td>
			  <td align="center" class="adgrid" onclick="superMngr.doSelect(this)">
			    <c:out value="${bltn.boardNm}"/>
			  </td>
			  <td align="left" class="adgrid" onclick="superMngr.doSelect(this)">
				<c:if test="${bltn.boardType != 'F'}"><%--한줄메모장이 아니면--%>
			      <font style="cursor:pointer" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'"
				      cmntUrl="<c:out value="${bltn.cmntUrl}"/>" boardId="<c:out value="${bltn.boardId}"/>" bltnNo="<c:out value="${bltn.bltnNo}"/>"
				      onclick="superMngr.doShowBulletin(this)"
				  >
				    <c:out value="${bltn.bltnSubj}" escapeXml="false"/>
				  </font>
				</c:if>
				<c:if test="${bltn.boardType == 'F'}"><%--한줄메모장--%>
				    <c:out value="${bltn.bltnCntt}" escapeXml="false"/>
				</c:if>
			  </td>
			  <td align="center" class="adgrid" onclick="superMngr.doSelect(this)">
			    <c:out value="${bltn.userNick}"/>
			  </td>
			  <td align="left" class="adgrid" onclick="superMngr.doSelect(this)">
			    <c:out value="${bltn.regDatimSF}"/>
			  </td>
			  <td align="right" class="adgridlast" onclick="superMngr.doSelect(this)">
			    <c:out value="${bltn.bltnReadCnt}"/></span>
			  </td>
			</tr>
			</c:forEach>
			<tr><td height="2" colspan="7" class="adgridlimit"></td></tr>
			<tr>
			  <td height="22" colspan="7">
				<c:if test="${empty bltnList}">
			      <span><util:message key="ev.info.notFoundData"/></span>
				</c:if>
				<c:if test="${!empty bltnList}">
			      <span>전제 조회 건수는 <c:out value="${suForm.totalSize}"/>건 입니다</span>
				</c:if>
			  </td>
			</tr>
		  </tbody>
		</table>
	  </form>
</c:if>
<%--END::게시글 검색--%>
<%--BEGIN::댓글 검색--%>
<c:if test="${suForm.cmd == 'memo'}">
	  <form id="superListForm" style="display:inline" name="superListForm" action="" method="post">
	    <input type="hidden" id="superList_totalSize" name="superList_totalSize" value="<c:out value="${suForm.totalSize}"/>"/>
		<table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
		  <thead>
			<tr><td height="2" colspan="7" class="adgridlimit"></td></tr>
			<tr style="cursor: pointer;">
			  <th class="adgridheader" align="center"><input type="checkbox" id="delCheck" onclick="superMngr.m_checkBox.chkAll(this)"/></th>
			  <th class="adgridheader" ch="0"><span>카페 명</span></th>
			  <th class="adgridheader" ch="0"><span>게시판 명</span></th>
			  <th class="adgridheader" ch="0"><span>댓글(메모)</span></th>
			  <th class="adgridheader" ch="0"><span>작성자</span></th>
			  <th class="adgridheader" ch="0"><span>작성일</span></th>
			  <th class="adgridheaderlast" ch="0"><span>악플신고건수</span></th>
			</tr>
		  </thead>
		  <tbody id="superListBody">
		    <c:forEach items="${memoList}" var="memo" varStatus="status">
		    <tr id="superList<c:out value="${status.index}"/>" <c:if test="${status.index % 2 == 1}">class="adgridline"</c:if>
			    ch="<c:out value="${status.index}"/>" style="cursor:pointer" onmouseover="ebUtil.activeLine(this,true)" onmouseout="ebUtil.activeLine(this,false)" >
			  <td align="center" class="adgrid">
			    <input type="checkbox" id="superList<c:out value="${status.index}"/>_checkRow" class="webcheckbox"/>
				<input type="hidden" id="superList<c:out value="${status.index}"/>_boardId" value="<c:out value="${memo.boardId}"/>"/>
				<input type="hidden" id="superList<c:out value="${status.index}"/>_bltnNo" value="<c:out value="${memo.bltnNo}"/>"/>
				<input type="hidden" id="superList<c:out value="${status.index}"/>_memoSeq" value="<c:out value="${memo.memoSeq}"/>"/>
			  </td>
			  <td align="center" class="adgrid" onclick="superMngr.doSelect(this)">
			    <c:out value="${memo.cmntNm}"/>
			  </td>
			  <td align="center" class="adgrid" onclick="superMngr.doSelect(this)">
			    <c:out value="${memo.boardNm}"/>
			  </td>
			  <td align="left" class="adgrid" onclick="superMngr.doSelect(this)">
			    <font style="cursor:pointer" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'"
				      cmntUrl="<c:out value="${memo.cmntUrl}"/>" boardId="<c:out value="${memo.boardId}"/>" bltnNo="<c:out value="${memo.bltnNo}"/>"
				      onclick="superMngr.doShowBulletin(this)"
				>
			      <c:out value="${memo.memoCntt}" escapeXml="false"/>
				</font>
			  </td>
			  <td align="center" class="adgrid" onclick="superMngr.doSelect(this)">
			    <c:out value="${memo.userNick}"/>
			  </td>
			  <td align="left" class="adgrid" onclick="superMngr.doSelect(this)">
			    <c:out value="${memo.regDatimSF}"/>
			  </td>
			  <td align="right" class="adgridlast" onclick="superMngr.doSelect(this)">
			    <c:out value="${memo.badCnt}"/></span>
			  </td>
			</tr>
			</c:forEach>
			<tr><td height="2" colspan="7" class="adgridlimit"></td></tr>
			<tr>
			  <td height="22" colspan="7">
				<c:if test="${empty memoList}">
			      <span><util:message key="ev.info.notFoundData"/></span>
				</c:if>
				<c:if test="${!empty memoList}">
			      <span>전제 조회 건수는 <c:out value="${suForm.totalSize}"/>건 입니다</span>
				</c:if>
			  </td>
			</tr>
		  </tbody>
		</table>
	  </form>
</c:if>
<%--END::댓글 검색--%>
