<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.saltware.enview.sso.EnviewSSOManager" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	request.setAttribute("ROLE_BOOK_RSRC",  EnviewSSOManager.getUserInfo(request).getHasRole("ROLE_BOOK_RSRC")); // 자원예약관리자
%>
<div class="portlet">
	<h2>조사실 <span>예약현황</span></h2>
	<div class="reservation_list">
		<ul class="list_scroll">
			<c:if test="${not empty  list}">
				<c:forEach items="${list }" var="list">
					<c:if test="${ROLE_BOOK_RSRC eq true }">
					<li><a href="javascript:void(0);" class="lmenuOpen" id="tm002_sm003_lm006" target="_self" rel="/rsrc/selectResourceBookList.face?rsrc_id=${list.RSRC_ID}" rel2="" data-root="tm002" data-title="장비이용예약승인"><span class="survey">${list.RSRC_NM}</span><font color="#064594">[${list.OPR_APV_CLSF_NM}]</font>${list.OPR_CNTNS}</a><span class="date">${list.OPR_STRT_TM}~${list.OPR_END_TM}</span></li>					
					</c:if>
					<c:if test="${ROLE_BOOK_RSRC eq false }">
					<li><a href="javascript:void(0);" class="lmenuOpen" id="tm002_sm003_lm002" target="_self" rel="/rsrc/selectResourceCategoryView.face?rsrc_clsf=1" rel2="" data-root="tm002" data-title="조사실"><span class="survey">${list.RSRC_NM}</span><font color="#064594">[${list.OPR_APV_CLSF_NM}]</font>${list.OPR_CNTNS}</a><span class="date">${list.OPR_STRT_TM}~${list.OPR_END_TM}</span></li>
					</c:if>
				</c:forEach>
			</c:if>
			<c:if test="${empty list}">
				예약된 조사실이 없습니다.
			</c:if>
		</ul>
		<c:if test="${ROLE_BOOK_RSRC eq true }">
		<a href="javascript:void(0);" class="lmenuOpen more" id="tm002_sm003_lm006" target="_self" rel="/rsrc/selectResourceBookList.face?opr_apv_clsf=0" rel2="" data-root="tm002" data-title="장비이용예약승인"><img src="/sjpb/images/icon_more.png" alt="더보기버튼"></a>
		</c:if>
		<c:if test="${ROLE_BOOK_RSRC eq false }">
		<a href="javascript:void(0);" class="lmenuOpen more" id="tm002_sm003_lm002" target="_self" rel="/rsrc/selectResourceCategoryView.face?rsrc_clsf=1" rel2="" data-root="tm002" data-title="조사실"><img src="/sjpb/images/icon_more.png" alt="더보기버튼"></a>
		</c:if>
	</div>   
</div>