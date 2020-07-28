<%@page import="com.saltware.enview.security.EVSubject"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.saltware.enview.security.UserInfo"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ page import="com.saltware.enboard.vo.BulletinVO"%>
<%
	String evcp = request.getContextPath();
	UserInfo userInfo = EVSubject.getUserInfo();
	request.setAttribute("userInfo", userInfo);
%>

<%--BEGIN::게시글/댓글 검색이 아닌 경우--%>
<c:if test="${suForm.cmd != 'bltn' && suForm.cmd != 'memo'}">
	<c:if test="${suForm.cmd == 'func'}">
		<div class="tsearchArea">
				<p>
				<c:choose>
					<c:when test="${suForm.view == 'permit'}">개설 신청</c:when>
					<c:when test="${suForm.view == 'close'}">자진 폐쇄</c:when>
					<c:when test="${suForm.view == 'force'}">강제 폐쇄</c:when>
					<c:when test="${suForm.view == 'hit'}">방문수 순위</c:when>
					<c:when test="${suForm.view == 'mile'}">랭킹   순위</c:when>
					<c:when test="${suForm.view == 'mmbr'}">회원수 순위</c:when>
					<c:when test="${suForm.view == 'rcmd'}">추천 카페</c:when>
				</c:choose>
				
				</p>
		</div>	
	</c:if>
	<form id="superListForm" style="display:inline" name="superListForm" action="" method="post">
		<input type="hidden" id="superList_totalSize" name="superList_totalSize" value="<c:out value="${suForm.totalSize}"/>"/>
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<thead>
				<tr>
					<th class="C" width="40"><input type="checkbox" id="delCheck" onclick="superMngr.m_checkBox.chkAll(this)"/></th>
					<c:if test="${userInfo.hasAdminRole }"><th class="adgridheader" ch="0"><span class="table_title">도메인 명</span></th></c:if>
					<c:if test="${suForm.cmd == 'func' && (suForm.view == 'hit' || suForm.view == 'mile' || suForm.view == 'mmbr' || suForm.view == 'rcmd')}">
						<th class="C" ch="0"><span class="table_title">순위</span></th>
					</c:if>
					<th class="C" ch="0"><span class="table_title">카페 이름</span></th>
					<th class="C" ch="0"><span class="table_title">카페 주소</span></th>
					<c:if test="${suForm.cmd == 'func' && (suForm.view == 'hit' || suForm.view == 'mile' || suForm.view == 'mmbr')}">
						<th class="C" ch="0">
					  		<c:if test="${suForm.view == 'hit'}">
								<span class="table_title">방문 수</span>
							</c:if>
							<c:if test="${suForm.view == 'mile'}">
								<span class="table_title">마일리지</span>
							</c:if>
							<c:if test="${suForm.view == 'mmbr'}">
								<span class="table_title">회원 수</span>
							</c:if>
						</th>
					</c:if>
					<th class="C" ch="0"><span class="table_title">카페지기</span></th>
					<th class="C" ch="0"><span class="table_title">상태</span></th>
					<th class="C" ch="0"><span class="table_title">최종상태변경일</span></th>
				</tr>
			</thead>
		 	<tbody id="superListBody">
		   		<c:forEach items="${cafeList}" var="cafe" varStatus="status">
					<tr id="superList<c:out value="${status.index}"/>" <c:if test="${status.index % 2 == 1}">class="adgridline"</c:if>
					ch="<c:out value="${status.index}"/>" style="cursor:pointer">
						<td class="C">
							<input type="checkbox" id="superList<c:out value="${status.index}"/>_checkRow" class="webcheckbox" onclick="superMngr.doSelect(this)"/>
							<input type="hidden" id="superList<c:out value="${status.index}"/>_cmntId" value="<c:out value="${cafe.cmntId}"/>"/>
							<input type="hidden" id="superList<c:out value="${status.index}"/>_cmntUrl" value="<c:out value="${cafe.cmntUrl}"/>"/>
						</td>
						<c:if test="${userInfo.hasAdminRole }">
							<td class="C" onclick="superMngr.doSelect(this)">
								<c:out value="${cafe.domainNm}"/>
							</td>
						</c:if>
						<c:if test="${suForm.cmd == 'func' && (suForm.view == 'hit' || suForm.view == 'mile' || suForm.view == 'mmbr' || suForm.view == 'rcmd')}">
							<td class="C" onclick="superMngr.doSelect(this)">
								<c:out value="${cafe.rnum}"/>
							</td>
						</c:if>
						<td class="C" onclick="superMngr.doSelect(this)">
							<c:out value="${cafe.cmntNm}"/>
						</td>
						<td class="C" onclick="superMngr.doSelect(this)">
							<c:out value="${cafe.cmntUrl}"/>
						</td>
						<c:if test="${suForm.cmd == 'func' && (suForm.view == 'hit' || suForm.view == 'mile' || suForm.view == 'mmbr')}">
							<td class="C" onclick="superMngr.doSelect(this)">
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
						<td class="C" onclick="superMngr.doSelect(this)">
							<span id="superList<c:out value="${status.index}"/>_makerId_label"><c:out value="${cafe.makerIdNm}"/></span>
						</td>
						<td class="C" onclick="superMngr.doSelect(this)">
							<span id="superList<c:out value="${status.index}"/>_cmntState_label"><c:out value="${cafe.cmntStateNm}"/></span>
						</td>
						<td class="C" onclick="superMngr.doSelect(this)">
							<span id="superList<c:out value="${status.index}"/>_updDatim_label"><c:out value="${cafe.updDatimPF}"/></span>
						</td>
					</tr>
		   		</c:forEach>
				<tr>
					<td colspan="7">
						<c:if test="${empty cafeList}">
							<util:message key="ev.info.notFoundData"/>
						</c:if>
						<c:if test="${!empty cafeList}">
							전제 조회 건수는 <c:out value="${suForm.totalSize}"/>건 입니다
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
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<thead>
				<tr>
					<th class="C" width="40"><input type="checkbox" id="delCheck" onclick="superMngr.m_checkBox.chkAll(this)"/></th>
					<c:if test="${userInfo.hasAdminRole }">
						<th class="C" ch="0"><span class="table_title">도메인 명</span></th>
					</c:if>
					<th class="C" ch="0"><span class="table_title">카페 명</span></th>
					<th class="C" ch="0"><span class="table_title">게시판 명</span></th>
					<th class="C" ch="0"><span class="table_title">제목</span></th>
					<th class="C" ch="0"><span class="table_title">작성자</span></th>
					<th class="C" ch="0"><span class="table_title">작성일</span></th>
					<th class="C" ch="0"><span class="table_title">조회수</span></th>
				</tr>
			</thead>
		 	<tbody id="superListBody">
				<c:forEach items="${bltnList}" var="bltn" varStatus="status">
					<tr id="superList<c:out value="${status.index}"/>" <c:if test="${status.index % 2 == 1}">class="adgridline"</c:if>
					ch="<c:out value="${status.index}"/>" style="cursor:pointer">
						<td align="center" class="C">
							<input type="checkbox" id="superList<c:out value="${status.index}"/>_checkRow" class="webcheckbox"/>
							<input type="hidden" id="superList<c:out value="${status.index}"/>_boardId" value="<c:out value="${bltn.boardId}"/>"/>
							<input type="hidden" id="superList<c:out value="${status.index}"/>_bltnNo" value="<c:out value="${bltn.bltnNo}"/>"/>
						</td>
						<c:if test="${userInfo.hasAdminRole }">
							<td class="C" onclick="superMngr.doSelect(this)">
								<c:out value="${bltn.domainNm}"/>
							</td>
						</c:if>
						<td class="C" onclick="superMngr.doSelect(this)">
							<c:out value="${bltn.cmntNm}"/>
						</td>
						<td class="C" onclick="superMngr.doSelect(this)">
							<c:out value="${bltn.boardNm}"/>
						</td>
						<td class="L" onclick="superMngr.doSelect(this)">
							<c:if test="${bltn.boardType != 'F'}"><%--한줄메모장이 아니면--%>
								<font	style="cursor:pointer" 
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
						<td class="C" onclick="superMngr.doSelect(this)">
							<c:out value="${bltn.userNick}"/>
						</td>
						<td class="C" onclick="superMngr.doSelect(this)">
							<c:out value="${bltn.regDatimSF}"/>
						</td>
						<td class="C" onclick="superMngr.doSelect(this)">
							<c:out value="${bltn.bltnReadCnt}"/></span>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="8">
						<c:if test="${empty bltnList}">
							<util:message key="ev.info.notFoundData"/>
						</c:if>
						<c:if test="${!empty bltnList}">
							전제 조회 건수는 <c:out value="${suForm.totalSize}"/>건 입니다
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
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
		 	<thead>
				<tr>
					<th class="C"><input type="checkbox" id="delCheck" onclick="superMngr.m_checkBox.chkAll(this)"/></th>
					<c:if test="${userInfo.hasAdminRole }">
						<th class="C" ch="0"><span class="table_title">도메인 명</span></th>
					</c:if>
					<th class="C" ch="0"><span class="table_title">카페 명</span></th>
					<th class="C" ch="0"><span class="table_title">게시판 명</span></th>
					<th class="C" ch="0"><span class="table_title">댓글(메모)</span></th>
					<th class="C" ch="0"><span class="table_title">작성자</span></th>
					<th class="C" ch="0"><span class="table_title">작성일</span></th>
					<th class="C" ch="0"><span class="table_title">악플신고건수</span></th>
				</tr>
			</thead>
			<tbody id="superListBody">
				<c:forEach items="${memoList}" var="memo" varStatus="status">
					<tr id="superList<c:out value="${status.index}"/>" <c:if test="${status.index % 2 == 1}">class="adgridline"</c:if>
					ch="<c:out value="${status.index}"/>" style="cursor:pointer">
						<td class="C">
							<input type="checkbox" id="superList<c:out value="${status.index}"/>_checkRow" class="webcheckbox"/>
							<input type="hidden" id="superList<c:out value="${status.index}"/>_boardId" value="<c:out value="${memo.boardId}"/>"/>
							<input type="hidden" id="superList<c:out value="${status.index}"/>_bltnNo" value="<c:out value="${memo.bltnNo}"/>"/>
							<input type="hidden" id="superList<c:out value="${status.index}"/>_memoSeq" value="<c:out value="${memo.memoSeq}"/>"/>
						</td>
						<c:if test="${userInfo.hasAdminRole }">
							<td class="C" onclick="superMngr.doSelect(this)">
								<c:out value="${memo.domainNm}"/>
							</td>
						</c:if>
						<td class="C" onclick="superMngr.doSelect(this)">
							<c:out value="${memo.cmntNm}"/>
						</td>
						<td class="C" onclick="superMngr.doSelect(this)">
							<c:out value="${memo.boardNm}"/>
						</td>
						<td class="L" onclick="superMngr.doSelect(this)">
							<font style="cursor:pointer" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'"
							cmntUrl="<c:out value="${memo.cmntUrl}"/>" boardId="<c:out value="${memo.boardId}"/>" bltnNo="<c:out value="${memo.bltnNo}"/>"
							onclick="superMngr.doShowBulletin(this)"
							>
							     <c:out value="${memo.memoCntt}" escapeXml="false"/>
							</font>
						</td>
						<td class="C" onclick="superMngr.doSelect(this)">
							<c:out value="${memo.userNick}"/>
						</td>
						<td class="C" onclick="superMngr.doSelect(this)">
							<c:out value="${memo.regDatimSF}"/>
						</td>
						<td class="C" onclick="superMngr.doSelect(this)">
							<c:out value="${memo.badCnt}"/></span>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="8">
						<c:if test="${empty memoList}">
							<util:message key="ev.info.notFoundData"/>
						</c:if>
						<c:if test="${!empty memoList}">
							전제 조회 건수는 <c:out value="${suForm.totalSize}"/>건 입니다
						</c:if>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</c:if>
<%--END::댓글 검색--%>
