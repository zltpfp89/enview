<%@page import="com.saltware.enview.security.EVSubject"%>
<%@page import="com.saltware.enview.security.UserInfo"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	UserInfo userInfo = EVSubject.getUserInfo();
	request.setAttribute("userInfo", userInfo);
%>
<c:if test="${suForm.cmd != 'bltn' && suForm.cmd != 'memo'}">
	<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
		<c:if test="${userInfo.hasAdminRole }">
			<tr>
				<th class="R">도메인 명</th>
				<td colspan="3" class="L"><c:out value="${cmntVO.domainNm}"/></td>
			</tr>
		</c:if>
		<tr>
			<th class="R">카페 이름</th>
			<td class="L"><c:out value="${cmntVO.cmntNm}"/></td>
			<th class="R">카페 주소</th>
			<td class="L"><c:out value="${cafeFullUrl}"/></td>
		</tr>
		<tr>
		  	<th class="R">공개 여부</th>
			<td class="L"><input type="checkbox" checked="true" disabled="true"/><c:out value="${cmntVO.openYnNm}"/></td>
			<th class="R">가입 방식</th>
			<td class="L"><input type="checkbox" checked="true" disabled="true" /><c:out value="${cmntVO.regTypeNm}"/></td>
		</tr>
		<tr>
			<th class="R">회원명 표시 방식</th>
			<td class="L"><input type="checkbox" checked="true" disabled="true" /><c:out value="${cmntVO.nmTypeNm}"/></td>
			<th class="R">카테 고리</th>
			<td class="L">
				<c:if test="${suForm.cateHier >= '1'}">
					<c:out value="${cmntCate1.cateNm}"/>
				</c:if>
				<c:if test="${suForm.cateHier >= '2'}">
					<c:if test="${!empty cmntCate2}">&nbsp;▶&nbsp;<c:out value="${cmntCate2.cateNm}"/></c:if>
				</c:if>
				<c:if test="${suForm.cateHier >= '3'}">
					<c:if test="${!empty cmntCate3}">&nbsp;▶&nbsp;<c:out value="${cmntCate3.cateNm}"/></c:if>
				</c:if>
			</td>
		</tr>
		<tr>
			<th class="R">카페 태그</th>
			<td colspan="3" class="L">
				<c:forEach items="${tagList}" var="tag" varStatus="status">
					<c:out value="${tag.tag}"/><c:if test="${!status.last}">,&nbsp;</c:if>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<th class="R">소개글</th>
			<td colspan="3" class="L">
				<textarea class="txtbox" readonly><c:out value="${cmntVO.cmntIntro}"/></textarea>
			</td>
		</tr>
		<tr>
			<th class="R">가입 환영 인사</th>
			<td colspan="3" class="L">
			 	<textarea class="txtbox" readonly><c:out value="${cmntVO.cmntWelcome}"/></textarea>
			</td>
		</tr>
		<!--tr>
		  <th class="R">소모임 개설 허용 갯수</td>
		  <td class="L"><c:out value="${cmntVO.somoLimitCnt}"/></td>
		</tr-->
		<c:if test="${suForm.cmd == 'func' && suForm.view == 'rcmd'}">
			<tr>
				<th class="R">추천 목록 순서</th>
				<td conspan="3" class="L">
				 	<input type="text" id="cafeDetail_favorOrder" id="cafeDetail_favorOrder" class="txt_100" maxlength="3" value="<c:out value="${cmntVO.favorOrder}"/>"/>
				</td>
			</tr>
		</c:if>
		<c:if test="${suForm.cmd == 'func' && (suForm.view == '2close' || suForm.view == 'closed')}">
			<tr>
				<th class="R">폐쇄 신청 일시</th>
				<td class="L"><c:out value="${cmntCloseVO.regDatimPF}"/></td>
				<th class="R">페쇄 신청자 아이디</th>
				<td class="L"><c:out value="${cmntCloseVO.regUserId}"/></td>
			</tr>
			<tr>
			  	<th class="R">폐쇄 상태</th>
				<td class="L"><input type="checkbox" checked="true" disabled="true" /><c:out value="${cmntCloseVO.closeStateNm}"/></td>
				<th class="R">강제 폐쇄 여부</th>
				<td class="L"><input type="checkbox" checked="true" disabled="true" /><c:out value="${cmntCloseVO.forceYnNm}"/></td>
			</tr>
			<c:if test="${suForm.view == 'closed'}">
				<tr>
					<th class="R">폐쇄 사유</th>
					<td colspan="3" class="L"><input type="checkbox" checked="true" disabled="true" /><c:out value="${cmntCloseVO.closeReasonNm}"/></td>
				</tr>
				<tr>
				  	<th class="R">폐쇄의 변</th>
					<td colspan="3" class=L">
				  		<textarea class="txt_box" readonly><c:out value="${cmntCloseVO.closeRemark}"/></textarea>
				  	</td>
				</tr>
			</c:if>
		</c:if>
		<!-- btnArea-->
		<div class="btnArea"> 
			<div class="leftArea">
				<a href="javascript:superMngr.process('cafeHome')" class="btn_W"><span>카페홈보기</span></a>
				<a href="javascript:superMngr.process('cafeJigi')" class="btn_W"><span>카페관리</span></a>
				<c:if test="${suForm.cmd != 'func' || (suForm.cmd == 'func' && suForm.view != 'rcmd')}">
					<a href="javascript:superMngr.process('rcmdCafe')" class="btn_W"><span>카페추천</span></a>
				</c:if>
				<c:if test="${suForm.cmd == 'func' && suForm.view == 'rcmd'}">
					<a href="javascript:superMngr.process('rcmd-delete')" class="btn_W"><span>추천목록에서 제거</span></a>
					<a href="javascript:superMngr.process('rcmd-reorder')" class="btn_W"><span>추천목록 순서변경</span></a>
				</c:if>
			</div>
			<div class="rightArea">
				<c:if test="${cmntVO.cmntState == '10' || cmntVO.cmntState == '12'}">
					<a href="javascript:superMngr.process('permit')" class="btn_W"><span>개설승인</span></a>
				</c:if>
				<c:if test="${cmntVO.cmntState == '11'}">
					<a href="javascript:superMngr.getCloseReasonGetter().doShow()" class="btn_W"><span>강제폐쇄</span></a>
				</c:if>
				<c:if test="${cmntVO.cmntState == '13' || cmntVO.cmntState == '14' || cmntVO.cmntState == '15' || cmntVO.cmntState == '16'}">
					<a href="javascript:superMngr.process('unclose')" class="btn_W"><span>폐쇄해제</span></a>
				</c:if>
				<a href="javascript:superMngr.process('delete')" class="btn_W"><span>카페삭제</span></a>
			</div>
		</div>
		<!-- btnArea//-->
	</table>
</c:if>
<c:if test="${suForm.cmd == 'bltn'}">
	<!-- btnArea-->
	<div class="btnArea"> 
		<div class="rightArea">
			<a href="javascript:superMngr.process('delete-bltn')" class="btn_B"><span>게시물삭제</span></a>
		</div>
	</div>
	<!-- btnArea//-->
</c:if>
<c:if test="${suForm.cmd == 'memo'}">
	<!-- btnArea-->
	<div class="btnArea"> 
		<div class="rightArea">
			<a href="javascript:superMngr.process('delete-memo')" class="btn_B"><span>댓글(메모)삭제</span></a>
		</div>
	</div>
	<!-- btnArea//-->
</c:if>
