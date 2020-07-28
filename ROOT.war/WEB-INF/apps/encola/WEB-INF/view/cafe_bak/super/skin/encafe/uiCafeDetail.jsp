<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<c:if test="${suForm.cmd != 'bltn' && suForm.cmd != 'memo'}">
  <table cellpadding=0 cellspacing=0 border=0 width='100%' class="adformpanel">
	<tr><td height="2" colspan="4" width="100%" class="adformlimit"></td></tr>
	<tr height=30>
	  <td width="20%" class="adformlabel" align="right" style="padding:0px 10px 0px 10px">카페 이름</td>
	  <td class="adformfield" align="left"><c:out value="${cmntVO.cmntNm}"/></td>
	  <td width="20%" class="adformlabel" align="right" style="padding:0px 10px 0px 10px">카페 주소</td>
	  <td class="adformfieldlast" align="left"><c:out value="${cafeFullUrl}"/></td>
	</tr>
	<tr height=30>
	  <td width="20%" class="adformlabel" align="right" style="padding:0px 10px 0px 10px">공개 여부</td>
	  <td class="adformfield" align="left"><input type="checkbox" class="full_cafetextfield" checked="true" disabled="true"/><c:out value="${cmntVO.openYnNm}"/></td>
	  <td width="20%" class="adformlabel" align="right" style="padding:0px 10px 0px 10px">가입 방식</td>
	  <td class="adformfieldlast" align="left"><input type="checkbox" class="full_cafetextfield" checked="true" disabled="true" /><c:out value="${cmntVO.regTypeNm}"/></td>
	</tr>
	<tr height=30>
	  <td width="20%" class="adformlabel" align="right" style="padding:0px 10px 0px 10px">회원명 표시 방식</td>
	  <td class="adformfield" align="left"><input type="checkbox" class="full_cafetextfield" checked="true" disabled="true" /><c:out value="${cmntVO.nmTypeNm}"/></td>
	  <td width="20%" class="adformlabel" align="right" style="padding:0px 10px 0px 10px"><util:message key="mm.title.category"/><%--카테고리--%></td>
	  <td class="adformfieldlast" align="left">
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
	<tr height=30>
	  <td width="20%" class="adformlabel" align="right" style="padding:0px 10px 0px 10px"><util:message key="cf.title.cafe.tag"/><%--카페태그-%></td>
	  <td colspan="3" class="adformfieldlast" align="left">
	    <c:forEach items="${tagList}" var="tag" varStatus="status">
		  <c:out value="${tag.tag}"/><c:if test="${!status.last}">,&nbsp;</c:if>
		</c:forEach>
	  </td>
	</tr>
	<tr>
	  <td width="20%" class="adformlabel" align="right" style="padding:0px 10px 0px 10px">소개글</td>
	  <td colspan="3" class="adformfieldlast" align="left">
	    <textarea class="full_cafetextarea" style="width:98%;height:70px" readonly><c:out value="${cmntVO.cmntIntro}"/></textarea>
	  </td>
	</tr>
	<tr>
	  <td width="20%" class="adformlabel" align="right" style="padding:0px 10px 0px 10px">가입 환영 인사</td>
	  <td colspan="3" class="adformfieldlast" align="left">
	    <textarea class="full_cafetextarea" style="width:98%;height:70px" readonly><c:out value="${cmntVO.cmntWelcome}"/></textarea>
	  </td>
	</tr>
	<!--tr height=30>
	  <td width="20%" class="adformlabel" align="right" style="padding:0px 10px 0px 10px">소모임 개설 허용 갯수</td>
	  <td class="adformfieldlast" align="left"><c:out value="${cmntVO.somoLimitCnt}"/></td>
	</tr-->
	<c:if test="${suForm.cmd == 'func' && suForm.view == 'rcmd'}">
	<tr height=30>
	  <td width="20%" class="adformlabel" align="right" style="padding:0px 10px 0px 10px">추천 목록 순서</td>
	  <td conspan="3" class="adformfieldlast" align="left">
	    <input type="text" id="cafeDetail_favorOrder" id="cafeDetail_favorOrder" maxlength="3" value="<c:out value="${cmntVO.favorOrder}"/>"/>
	  </td>
	</tr>
	</c:if>
	<tr><td height="2" colspan="4" width="100%" class="adformlimit"></td></tr>
	<c:if test="${suForm.cmd == 'func' && (suForm.view == '2close' || suForm.view == 'closed')}">
	<tr height=30>
	  <td width="20%" class="adformlabel" align="right" style="padding:0px 10px 0px 10px">폐쇄 신청 일시</td>
	  <td class="adformfield" align="left"><c:out value="${cmntCloseVO.regDatimPF}"/></td>
	  <td width="20%" class="adformlabel" align="right" style="padding:0px 10px 0px 10px">페쇄 신청자 아이디</td>
	  <td class="adformfieldlast" align="left"><c:out value="${cmntCloseVO.regUserId}"/></td>
	</tr>
	<tr height=30>
	  <td width="20%" class="adformlabel" align="right" style="padding:0px 10px 0px 10px">폐쇄 상태</td>
	  <td class="adformfield" align="left"><input type="checkbox" class="full_cafetextfield" checked="true" disabled="true" /><c:out value="${cmntCloseVO.closeStateNm}"/></td>
	  <td width="20%" class="adformlabel" align="right" style="padding:0px 10px 0px 10px">강제 폐쇄 여부</td>
	  <td class="adformfieldlast" align="left"><input type="checkbox" class="full_cafetextfield" checked="true" disabled="true" /><c:out value="${cmntCloseVO.forceYnNm}"/></td>
	</tr>
	<c:if test="${suForm.view == 'closed'}">
	<tr height=30>
	  <td width="20%" class="adformlabel" align="right" style="padding:0px 10px 0px 10px">폐쇄 사유</td>
	  <td colspan="3" class="adformfieldlast" align="left"><input type="checkbox" class="full_cafetextfield" checked="true" disabled="true" /><c:out value="${cmntCloseVO.closeReasonNm}"/></td>
	</tr>
	<tr>
	  <td width="20%" class="adformlabel" align="right" style="padding:0px 10px 0px 10px">폐쇄의 변</td>
	  <td colspan="3" class="adformfieldlast" align="left">
	    <textarea class="full_cafetextarea" style="width:98%;height:70px" readonly><c:out value="${cmntCloseVO.closeRemark}"/></textarea>
	  </td>
	</tr>
	</c:if>
	<tr><td height="2" colspan="4" width="100%" class="adformlimit"></td></tr>
	</c:if>
	<tr>
	  <td colspan="2" height="50" align="left">
		<span class="btn_pack medium"><a href="javascript:superMngr.process('cafeHome')">카페홈보기</a></span>
		<span class="btn_pack medium"><a href="javascript:superMngr.process('cafeJigi')">카페관리</a></span>
		<c:if test="${suForm.cmd != 'func' || (suForm.cmd == 'func' && suForm.view != 'rcmd')}">
		  <span class="btn_pack medium"><a href="javascript:superMngr.process('rcmdCafe')">카페추천</a></span>
		</c:if>
		<c:if test="${suForm.cmd == 'func' && suForm.view == 'rcmd'}">
		  <span class="btn_pack medium"><a href="javascript:superMngr.process('rcmd-delete')" >추천목록에서 제거</a></span>
		  <span class="btn_pack medium"><a href="javascript:superMngr.process('rcmd-reorder')">추천목록 순서변경</a></span>
		</c:if>
	  </td>
	  <td colspan="2" height="50" align="right">
	    <c:if test="${cmntVO.cmntState == '10' || cmntVO.cmntState == '12'}">
		  <span class="btn_pack medium"><a href="javascript:superMngr.process('permit')">개설승인</a></span>
		</c:if>
		<c:if test="${cmntVO.cmntState == '11'}">
		  <span class="btn_pack medium"><a href="javascript:superMngr.getCloseReasonGetter().doShow()">강제폐쇄</a></span>
		</c:if>
		<c:if test="${cmntVO.cmntState == '13' || cmntVO.cmntState == '14' || cmntVO.cmntState == '15' || cmntVO.cmntState == '16'}">
		  <span class="btn_pack medium"><a href="javascript:superMngr.process('unclose')">폐쇄해제</a></span>
		</c:if>
		<span class="btn_pack medium"><a href="javascript:superMngr.process('delete')">카페삭제</a></span>
	  </td>
	</tr>
  </table>
</c:if>
<c:if test="${suForm.cmd == 'bltn'}">
  <table cellpadding=0 cellspacing=0 border=0 width='100%' class="adformpanel">
	<tr>
	  <td colspan="2" height="50" align="left">
	  </td>
	  <td colspan="2" height="50" align="right">
		<span class="btn_pack medium"><a href="javascript:superMngr.process('delete-bltn')">게시물삭제</a></span>
	  </td>
	</tr>
  </table>
</c:if>
<c:if test="${suForm.cmd == 'memo'}">
  <table cellpadding=0 cellspacing=0 border=0 width='100%' class="adformpanel">
	<tr>
	  <td colspan="2" height="50" align="left">
	  </td>
	  <td colspan="2" height="50" align="right">
		<span class="btn_pack medium"><a href="javascript:superMngr.process('delete-memo')">댓글(메모)삭제</a></span>
	  </td>
	</tr>
  </table>
</c:if>
