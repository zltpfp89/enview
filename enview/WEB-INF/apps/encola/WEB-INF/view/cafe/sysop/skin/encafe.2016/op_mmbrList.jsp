<%@page import="com.saltware.enview.codebase.CodeBundle"%>
<%@page import="com.saltware.enboard.security.SecurityMngr"%>
<%@page import="com.saltware.enview.code.EnviewCodeManager"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.saltware.encola.common.vo.CmntMmbrVO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.saltware.enview.components.dao.ConnectionContextForRdbms"%>
<%@page import="com.saltware.enview.components.dao.ConnectionContext"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<!-- 타이틀 박스 시작 -->
<div class="board_title_box">
	<ul>
		<li class="board_title fl">
			<span class="green_title">부서원 목록</span>
		</li>
		<li class="board_depth fl"><img src="<%=request.getContextPath()%>/kcomwel/images/common/ico/ico_home.gif" alt="홈" title="홈" />>&nbsp;부서마당&nbsp;>&nbsp;<span class="black11_text">부서원 목록</span></li>
	</ul>
</div>
<div class="text18_line pb10"><span class="gray_b_text">* 사용자 소속팀 :</span> 총  <c:out value="${cmntVO.mmbrTotCF}"/>명 &nbsp;[관리자 : <c:out value="${cmntVO.makerIdNm}"/>(<c:out value="${cmntVO.makerId}"/>)]</div>
<div class="table_box">
	<form id="all_listForm" name="all_listForm" style="display:inline" action="" method="post" onsubmit="return false;">
		<!-- 부서원 리스트 1장에 15줄이 디폴트 -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr class="table_33_line">
				<td width="5%" align="center"><input type="checkbox" name="checkbox" id="checkbox"  onchange="javascript:cfKcomwel.toggleCheckAll()"/></td>
				<td class="table_space"></td>
				<td width="6%" class="gr01">번호</td>
				<td class="table_space"></td>
				<td width="15%" class="gr01">이름</td>
				<td class="table_space"></td>
				<td width="14%" class="gr01">아이디</td>
				<td class="table_space"></td>
				<td width="12%" class="gr01">직급</td>
				<td class="table_space"></td>
				<td width="30%" class="gr01">전자메일</td>
				<td class="table_space"></td>
				<td width="18%" class="gr01">내선</td>
			</tr>
			<c:if test="${empty mmbrList}" var="isMmbrEmpty">
			<tr class="list_line">
					<td colspan="15" height="30" align="center">
						해당 직원이 조회되지 않았습니다.
					</td>
				</tr>
			</c:if>
			<c:if test="${!isMmbrEmpty}">
				<%
					CodeBundle cdBun = EnviewCodeManager.getInstance().getBundle( SecurityMngr.getLocale(request) );
					for(Object obj: (List)request.getAttribute("mmbrList")){
						CmntMmbrVO mmbr = (CmntMmbrVO)obj;
					   	String userId = mmbr.getUserId();
						ConnectionContext connCtxt = null;
						Map userInfo = new HashMap();
						try {
							connCtxt = new ConnectionContextForRdbms (true);
					
							Connection        conn  = null;
							PreparedStatement pstmt = null;
							ResultSet rslt = null;
							StringBuffer sb = new StringBuffer();
							
							String jikgeup = null;
							String offcTel = null;
							String emailAddr = null;
							
							try {
								conn = connCtxt.getConnection();
					
								sb.append("SELECT LEVEL_CD, OFFC_TEL, EMAIL_ADDR FROM USERPASS WHERE USER_ID =?");
								pstmt = conn.prepareStatement (sb.toString());
								pstmt.setString (1, userId);
								rslt = pstmt.executeQuery();
								if (rslt.next()) {
									jikgeup = rslt.getString(1) == null ? "-" : rslt.getString(1);
									offcTel = rslt.getString(2) == null ? "-" : rslt.getString(2);
									emailAddr = rslt.getString(3) == null ? "-" : rslt.getString(3);
									
									jikgeup = cdBun.getCodeName("PT", "52", jikgeup);
									request.setAttribute("jikgeup", jikgeup == null || "".equals(jikgeup) ? "-" : jikgeup);
									request.setAttribute("offcTel", offcTel);
									request.setAttribute("emailAddr", emailAddr);
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
				<c:set var="userInfo" value="${userInfo}"/>
				<tr ch="<c:out value="${status.index}"/>" class="list_line">
					<td width="5%" height="30" align="center">
						<input type="checkbox" id="all_checkRow" name="all_checkRow" class="cafecheckbox checkRow" value="<c:out value="${mmbr.userId}"/>"
							stateFlag="<c:out value="${mmbr.stateFlag}"/>" mmbrGrd="<c:out value="${mmbr.mmbrGrd}"/>"/>
					</td>
					<td height="30">&nbsp;</td>
					<td width="6%" height="30" align="center"><c:out value="${count + (opForm.pageNo-1) * 10 }"/></td>
					<td height="30" align="left">&nbsp;</td>
					<!-- 클릭시 사용자 레이어 노출 -->
					<td width="15%" height="30" align="center">
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
					<td height="30" align="left">&nbsp;</td>
					<td width="14%" height="30" align="center"><c:out value="${mmbr.userId}"/></td>
					<td height="30" align="center">&nbsp;</td>
					<td width="12%" height="30" align="center"><c:out value="${jikgeup}"/></td>
					<td height="30" align="center">&nbsp;</td>
					<td width="30%" height="30" align="center"><a href="#" target="_blank"><span class="g11_num"><c:out value="${emailAddr}"/></span></a></td>
					<td height="30" align="center">&nbsp;</td>
					<td width="18%" height="30" align="center" class="gray11_l_text"><c:out value="${offcTel}"/></td>
				</tr>
				<% } %>
			</c:if>
		</table>
	</form>
</div>
<!-- 페이지 넘버링 박스 시작 -->
<div style="margin-top:15px;" class="cafepanel">
	<table style="width:100%;">
		<tr>
			<td align="center">
				<div id="all_PAGE_ITERATOR"></div>
			</td>    
		</tr>
	</table>
</div>
<!-- 페이지 넘버링 박스 끝 -->
<form id="all_srchForm" name="all_srchForm" method="POST" onsubmit="return false;">
	<input type="hidden" id="srchGrd" name="srchGrd" value="<c:out value="${opForm.srchGrd}"/>"/>
	<input type="hidden" id="pageSize" name="pageSize" value="<c:out value="${opForm.pageSize}"/>"/>
	<input type="hidden" id="cmd" name="cmd" value="all"/>
	<input type="hidden" id="sortMethod" name="sortMethod" value="ASC"/>
	<input type="hidden" id="sortColumn" name="sortColumn" value="user_nick"/>
	<input type="hidden" id="pageNo" name="pageNo" value="<c:out value="${opForm.pageNo}"/>"/>
	<input type="hidden" id="totalSize" name="totalSize" value="<c:out value="${opForm.totalSize}"/>"/>
	<input type="hidden" id="pageFunction" name="pageFunction" value="cfKcomwel.doPageMmbrList"/>
	<input type="hidden" id="naviDivNm" name="naviDivNm" value="all_PAGE_ITERATOR"/>
	<input type="hidden" id="imgUrlPrefix" name="imgUrlPrefix" value="/kcomwel/images/common/ico"/>
</form>