<%@page import="java.util.Map"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.saltware.enview.components.dao.ConnectionContextForRdbms"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.saltware.enview.components.dao.ConnectionContext"%>
<%@page import="java.util.List"%>
<%@page import="com.saltware.encola.common.vo.CmntMmbrVO"%>
<%@page import="com.saltware.enboard.security.SecurityMngr"%>
<%@page import="com.saltware.enview.code.EnviewCodeManager"%>
<%@page import="com.saltware.enview.codebase.CodeBundle"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<form id="inv_srchForm" name="inv_srchForm" method="POST" onsubmit="return false;">
	<div style="width:680px; height:24px;">
		<div class="board_select_box fl"><span class="oran_title">승인대기</span></div>
		<!-- 검색 -->
		<div class="board_but_box480 fr">
			<select id="srchType" name="srchType" class="common_text">
				<c:forEach items="${srchTypeList}" var="srchType">
					<option value="<c:out value="${srchType.code}"/>" <c:if test="${opForm.srchType==srchType.code}">selected</c:if>><c:out value="${srchType.codeName}"/></option>
				</c:forEach>
			</select>
			&nbsp;
			<input name="board_search" type="text"  class="input_board_search" id="board_search"/>
			<img src="<%=request.getContextPath()%>/kcomwel/images/common/but/but_sg_search.gif" alt="검색" title="검색"  style="cursor:pointer;" class="h4_space"  onclick="cfKcomwel.searchRegMmbr('inv_srchForm')"/>
		</div>
	</div>
	<div class="clear pb10"></div>
	<!-- 정렬조건 -->
	<div class="board_line_box">
		<div class="fl" style=" width:280px; height:20px;"> * 총 회원수 : <span class="g12_num"><c:out value="${cmntVO.mmbrTotCF}"/></span>&nbsp;/&nbsp;현재 조회수 : <span class="g12_num"><c:out value="${opForm.totalSize}"/></span></div>
		<div class="fr" style=" width:300px; height:20px; text-align:right;">
			<select id="pageSize" name="pageSize" class="common_text">
				<c:forEach items="${pageSizeList}" var="pageSize">
					<option value="<c:out value="${pageSize.code}"/>" <c:if test="${opForm.pageSize==pageSize.code}">selected</c:if>><c:out value="${pageSize.codeName}"/></option>
				</c:forEach>
			</select>
		</div>
	</div>
	<div class="clear pb05"></div>
	<input type="hidden" id="cmd" name="cmd" value="inv"/>
	<input type="hidden" id="sortMethod" name="sortMethod" value="<c:out value="${opForm.sortMethod}"/>"/>
	<input type="hidden" id="sortColumn" name="sortColumn"/>
	<input type="hidden" id="pageNo" name="pageNo" value="<c:out value="${opForm.pageNo}"/>"/>
	<input type="hidden" id="totalSize" name="totalSize" value="<c:out value="${opForm.totalSize}"/>"/>
	<input type="hidden" id="pageFunction" name="pageFunction" value="cfOp.regMmbr.doPage"/>
	<input type="hidden" id="naviDivNm" name="naviDivNm" value="inv_PAGE_ITERATOR"/>
	<input type="hidden" id="imgUrlPrefix" name="imgUrlPrefix" value="/kcomwel/Community/images/common/ico"/>
</form>
<form id="inv_listForm" name="inv_listForm" style="display:inline" action="" method="post" onsubmit="return false;">
	<!-- 리스트 테이블 시작 -->
	<div class="table_box">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr class="table_33_line">
				<td width="8%" class="gray_b_text">
					<input type="checkbox" name="checkbox" id="checkbox" onchange="javascript:cfKcomwel.toggleCheckAll()" />
				</td>
				<td class="table_space"></td>
				<td width="20%" class="gray_b_text">사용자명</td>
				<td class="table_space"></td>
				<td width="21%" class="gray_b_text">부서</td>
				<td class="table_space"></td>
				<td width="21%" class="gray_b_text">직위</td>
				<td class="table_space"></td>
				<td width="15%" class="gray_b_text">상태</td>
				<td class="table_space"></td>
				<td width="15%" class="gray_b_text">신청일</td>
			</tr>
			<c:if test="${empty mmbrList}" var="isMmbrEmpty">
			<tr class="list_line">
					<td colspan="15" height="30" align="center">
						승인대기 중인 회원이 존재하지 않습니다.
					</td>
				</tr>
			</c:if>
			<c:if test="${!isMmbrEmpty}">
				<%
					CodeBundle cdBun = EnviewCodeManager.getInstance().getBundle( SecurityMngr.getLocale(request) );
					for(Object obj: (List)request.getAttribute("mmbrList")){
						CmntMmbrVO mmbr = (CmntMmbrVO)obj;
						if(mmbr.getMmbrGrd().equals("X")) continue;
					   	String userId = mmbr.getUserId();
						ConnectionContext connCtxt = null;
						try {
							connCtxt = new ConnectionContextForRdbms (true);
					
							Connection        conn  = null;
							PreparedStatement pstmt = null;
							ResultSet rslt = null;
							StringBuffer sb = new StringBuffer();
							
							String jikwi = null;
							
							try {
								conn = connCtxt.getConnection();
					
								sb.append("SELECT LEVEL_CD, OFFC_TEL, EMAIL_ADDR FROM USERPASS WHERE USER_ID =?");
								pstmt = conn.prepareStatement (sb.toString());
								pstmt.setString (1, userId);
								rslt = pstmt.executeQuery();
								if (rslt.next()) {
									jikwi = rslt.getString(1) == null ? "-" : rslt.getString(1);
									
									jikwi = cdBun.getCodeName("PT", "53", jikwi);
									request.setAttribute("jikwi", jikwi == null || "".equals(jikwi) ? "-" : jikwi);
								}
							} catch (Exception e) {
								throw e;
							} finally {
								if(rslt != null) rslt.close(); 
								if(pstmt != null) pstmt.close(); 
								if(conn != null) conn.close();
							}
							
						} catch (Exception e) {
							if (connCtxt != null) connCtxt.rollback();
						} finally {
							if (connCtxt != null) connCtxt.release();
						}
						request.setAttribute("mmbr", mmbr);
						
						int count = ((List)request.getAttribute("mmbrList")).indexOf(obj) + 1;
						
						request.setAttribute("count", count);
				%>
				<tr ch="<c:out value="${count}"/>" class="list_line">
					<td width="8%" height="30" align="center">
						<input index="<c:out value="${count}"/>" type="checkbox" class="checkRow" id="inv_checkRow" name="inv_checkRow" value="<c:out value="${mmbr.userId}"/>"
				 		stateFlag="<c:out value="${mmbr.stateFlag}"/>" mmbrGrd="<c:out value="${mmbr.mmbrGrd}"/>"/>
					</td>
					<td height="30">&nbsp;</td>
					<td width="20%" height="30" align="center">
						<div class="namebox">
							<a href="javascript:cfKcomwel.selectMmbr('<c:out value="${mmbr.userId}"/>')" onclick="this.blur();">
								<span class="gr03">
									<c:out value="${mmbr.nmKor}"/>
								</span>
							</a>
							<div class="user_view" style="display:none;" id="user_<c:out value="${mmbr.userId}"/>">
								<ul>
									<li class="doc_normal_text black11_text">- <a href="javascript:cfKcomwel.popUserView('<c:out value="${mmbr.userId}"/>');">사원정보</a></li>
									<li class="doc_normal_text black11_text">- <a href="#">메일발송</a></li>
									<li class="doc_normal_text black11_text">- <a href="#">일정조회</a></li>
								</ul>
							</div>
						</div>
					</td>
					<td height="30" align="center">&nbsp;</td>
					<td width="21%" height="30" align="center">서울지역본부</td>
					<td height="30">&nbsp;</td>
					<td width="21%" height="30" align="center"><c:out value="${jikwi }"/></td>
					<td height="30">&nbsp;</td>
					<td width="15%" height="30" align="center"class="<c:if test = "${ mmbr.stateFlag == 10 }">black11_text</c:if><c:if test = "${ mmbr.stateFlag != 10 }">red11_text</c:if>">
						<c:out value="${mmbr.stateFlagNm}"/>
					</td>
					<td height="30">&nbsp;</td>
					<td width="15%" height="30" align="center" class="g11d_num"><c:out value="${mmbr.regDatimPF}"/></td>
				</tr>
				<% } %>
			</c:if>
		</table>
	</div>
	<!-- 리스트 테이블 끝 -->
	<div class="pt05"></div>
	<!-- 이동조건 -->
	<div class="board_line_box gray_db_text">* 선택한 회원을 &nbsp;
	<img src="<%=request.getContextPath()%>/kcomwel/Community/images/common/but/but_sg_approve.gif" alt="가입승인" title="가입승인" class="btn h4_space" onclick="javascript:cfKcomwel.checkChangeState('inv','20', 'kcomwel_cafe')"/><img src="<%=request.getContextPath()%>/kcomwel/Community/images/common/but/but_sg_del.gif" alt="삭제" title="삭제" class="btn h4_space" onclick="javascript:cfKcomwel.checkChangeState('inv','21', 'kcomwel_cafe')"/>&nbsp; 합니다.</div>
	<!-- 페이지 넘버링 박스 시작 -->
	<div id="inv_PAGE_ITERATOR" class="pageno"></div>
	<!-- 페이지 넘버링 박스 끝 -->
</form>