<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<form id="all_srchForm" name="all_srchForm" method="POST" onsubmit="return false;">
	<!-- 타이틀 박스 시작 -->
	<div style="width:680px; height:24px;">
		<div class="board_select_box fl"><span class="oran_title">전체회원</span></div>
		<!-- 검색 -->
		<div class="board_but_box480 fr">
			<select id="srchType" name="srchType" class="common_text">
					<option value="srchGrp">그룹명</option>
			</select>
			&nbsp;
			<input type="text" id="srchKey" name="srchKey" class="input_board_search"  value="<c:out value="${opForm.srchKey}"/>"/>
			<img src="<%=request.getContextPath()%>/kcomwel/images/common/but/but_sg_search.gif" alt="검색" title="검색"  style="cursor:pointer;" class="h4_space" onclick="cfKcomwel.searchRegMmbr('all_srchForm')"/>
		</div>
	</div>
	<div class="clear pb05"></div>
	<input type="hidden" id="cmd" name="cmd" value="all"/>
	<input type="hidden" id="sortMethod" name="sortMethod" value="<c:out value="${opForm.sortMethod}"/>"/>
	<input type="hidden" id="sortColumn" name="sortColumn"/>
	<input type="hidden" id="pageNo" name="pageNo" value="<c:out value="${opForm.pageNo}"/>"/>
	<input type="hidden" id="totalSize" name="totalSize" value="<c:out value="${opForm.totalSize}"/>"/>
	<input type="hidden" id="pageFunction" name="pageFunction" value="cfOp.regMmbr.doPage"/>
	<input type="hidden" id="naviDivNm" name="naviDivNm" value="all_PAGE_ITERATOR"/>
	<input type="hidden" id="imgUrlPrefix" name="imgUrlPrefix" value="/kcomwel/Community/images/common/ico"/>
</form>
<form id="all_listForm" name="all_listForm" style="display:inline" action="" method="post" onsubmit="return false;">
	<!-- 리스트 테이블 시작 -->
	<div class="table_box">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr class="table_33_line">
				<td width="8%" class="gray_b_text"><input type="checkbox" name="checkbox" id="checkbox"  onchange="javascript:cfKcomwel.toggleCheckAll()" /></td>
				<td class="table_space"></td>
				<td width="92%" class="gray_b_text">부서명</td>
			</tr>
			<c:if test="${empty srchGroupList}" var="isGrpEmpty">
			<tr class="list_line">
					<td colspan="15" height="30" align="center">
						검색된 부서가 없습니다.
					</td>
				</tr>
			</c:if>
			<c:if test="${!isGrpEmpty}">
				<c:forEach items="${srchGroupList}" var="grp" varStatus="status">
				<tr ch="<c:out value="${status.index}"/>" class="list_line">
					<td width="8%"  height="30" align="center">
						<input type="checkbox" id="all_checkRow" name="all_checkRow" class="cafecheckbox checkRow" value="<c:out value="${mmbr.userId}"/>"
							stateFlag="<c:out value="${mmbr.stateFlag}"/>" mmbrGrd="<c:out value="${mmbr.mmbrGrd}"/>"/>
					</td>
					<td height="30">&nbsp;</td>
					<!-- 클릭시 사용자 레이어 노출 -->
					<td width="92%" height="30" align="center"><c:out value="${grp.groupName}"/></td>
				</tr>
				</c:forEach>
			</c:if>
		</table>
	</div>
</form>