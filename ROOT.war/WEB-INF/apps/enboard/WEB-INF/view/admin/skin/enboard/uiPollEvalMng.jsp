<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String evcp = request.getContextPath();
%>
<%--BEGIN::설문평점목록--%>
<c:if test="${apForm.view == 'list'}">
	<!-- evalAccordion -->
	<div id="evalAccordion">
		<h3><a href="#">평점관리</a></h3>
		<div class="board">
			<form name="apmEvalEditForm" method="post" action="" onsubmit="return false">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<caption>게시판</caption>
					<colgroup>
						<col width="5%" />
						<col width="40%" />
						<col width="45%" />
					</colgroup>					
					<thead>
						<tr>
							<th class="first">순번</th>
							<th class="C"><span class="table_title">점수</span></th>
							<th class="C"><span class="table_title">내용</span></th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty evalList}">
							<tr><td class="C" colspan="3">배속된 설문평점이 존재하지 않습니다.</td></tr>
						</c:if>
						<c:if test="${!empty evalList}">
							<c:forEach items="${evalList}" var="evalList" varStatus='status'>
								<tr id='eval_pollTr<c:out value="${status.index}"/>' height="22" 
									onclick="ebUtil.selectTr('eval_pollTr',<c:out value="${status.index}"/>);aPM.getEvalMngr().pollRequest('','edit','upd','<c:out value="${evalList.evalSeq}"/>');">
  
									<input type="hidden" id="list_evalSeq" value="${evalList.evalSeq}">
									<input type="hidden" id="list_evalFrom" value="${evalList.evalFrom}">
									<input type="hidden" id="list_evalTo" value="${evalList.evalTo}">

									<td class="C"><c:out value="${status.index + 1}"/></td>
									<td class="C"><c:out value="${evalList.evalFrom}"/> ~ <c:out value="${evalList.evalTo}"/></td>
									<td class="L"><c:out value="${evalList.evalRemark}"/></td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
					<input type="hidden" id="eval_pollTrIndex">
				</table>
				<c:if test="${!empty apForm.boardId}"><%--설문이 선택되었을 때만 추가가 가능--%>
					<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || (sessionScope._enview_user_info_.hasDomainManagerRole && sessionScope._user_domain_.domainId == boardVO.domainId)}">
						<!-- btnArea-->
						<div class="btnArea">
							<div class="rightArea">
								<a href="javascript:aPM.getEvalMngr().pollRequest('', 'edit','ins','')" class="btn_B"><span>추가</span></a>					
							</div>
						</div>
						<!-- btnArea//-->						
					</c:if>
				</c:if>
			</form>
			<table id="grid-table" border="0" cellspacing="0" cellpadding="0" class="table_board">
			   <tr><td id="eval_pollArea" valign="top"></td></tr>
		 	</table>			
		</div>
	</div>
	<!-- evalAccordion// -->
</c:if>
<%--END::설문평점목록--%>

<%--BEGIN::설문평점 등록--%>
<c:if test="${apForm.view == 'edit'}">
	<a name=editTop></a>
	<div class="board">	
		<form name="frmPQE" method="post" action="" onsubmit="return false">
			<input type="hidden" id="eval_cmd"     name="eval_cmd"     value="<c:out value="${apForm.cmd}"/>">
			<input type="hidden" id="eval_view"    name="eval_view"    value="<c:out value="${apForm.view}"/>">
			<input type="hidden" id="eval_act"     name="eval_act"     value="<c:out value="${apForm.act}"/>">
			<input type="hidden" id="eval_boardId" name="eval_boardId" value="<c:out value="${apForm.boardId}"/>"/>
			<input type="hidden" id="eval_seq" 	 name="eval_seq" value="<c:out value="${apForm.evalSeq}"/>"/>
		 	<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<colgroup>
					<col width="20%" />
					<col width="80%" />
				</colgroup>						
				<tr>
					<td colspan="2">
						<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align='absmiddle'>
						설문 평점을 생성/수정/삭제 하실 수 있습니다.
					</td>
				</tr>
				<tr>
					<th class="L">점수</th>
					<td class="L">
				  		<input type="text" name="eval_from" id="eval_from" style="text-align:right" size="12" maxlength="12" value="<c:out value="${bltnPollEvalVO.evalFrom}"/>"> <span class="sel_txt">~</span> 
						<input type="text" name="eval_to" id="eval_to" style="text-align:right" size="12" maxlength="12" value="<c:out value="${bltnPollEvalVO.evalTo}"/>">
					</td>
				</tr>
				<tr>	
					<th class="L">내용</th>
					<td class="L">
						<textarea name="eval_remark" id="eval_remark" style="height:60;width:99%"><c:out value="${bltnPollEvalVO.evalRemark}"/></textarea>
					</td>
				</tr>
		 	</table>
		</form>
		<!-- btnArea-->
		<div class="btnArea">
			<div class="rightArea">
				<a href="javascript:aPM.getEvalMngr().pollRequest('list')" class="btn_B"><span>목록</span></a>
				<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || (sessionScope._enview_user_info_.hasDomainManagerRole && sessionScope._user_domain_.domainId == boardVO.domainId)}">
					<a href="javascript:aPM.getEvalMngr().pollRequest('save')" class="btn_B"><span>저장</span></a></span>
					<a href="javascript:aPM.getEvalMngr().pollRequest('del')" class="btn_B"><span>삭제</span></a></span>
				</c:if>						
			</div>
		</div>
		<!-- btnArea//-->
	</div>
</c:if>
<%--END::설문평점 등록--%>	

