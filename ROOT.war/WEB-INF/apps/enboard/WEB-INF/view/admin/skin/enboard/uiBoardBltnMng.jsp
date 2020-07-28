<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>
		<!-- bltnAccordion -->
		<div id="bltnAccordion">
			<h3><a href="#">게시물관리</a></h3>
			<!-- board -->
			<div class="board first">            
			  <c:if test="${boardVO.boardId != boardVO.boardRid || boardVO.mergeType != 'A'}">
			    <img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
			    가상게시판이나 통합게시판에는 실 게시물이 존재하지 않습니다.
			  </c:if>
	            <c:if test="${boardVO.boardId == boardVO.boardRid && boardVO.mergeType == 'A'}">
					<!-- searchArea-->
					<div class="tsearchArea">
						<p id="message">게시물 총 <c:out value="${boardSttVO.totalBltns}"/> 건</p>
						<fieldset>
							<form id="bltnMngForm" name="bltnMngForm" onsubmit="return false;">
								<input type="hidden" id="bltn_page" name="bltn_page"			 value="<c:out value="${boardSttVO.page}"/>"/>
								<input type="hidden" id="bltn_totalBltns" name="bltn_totalBltns" value="<c:out value="${boardSttVO.totalBltns}"/>"/>
								<input type="hidden" id="bltn_pageFunc"	name="bltn_pageFunc"	 value="aBM.getBltnMngr().doPage"/>
								<input type="hidden" id="bltn_formName"	name="bltn_formName"	 value="bltnMngForm"/>
								

								<div class="sel_100">
									<select id="bltn_srchType" name="bltn_srchType" class="txt_100">
										<option value="Subj" <c:if test="${bsForm.srchType=='Subj'}">selected</c:if>>제	목</option>
										<option value="Cntt" <c:if test="${bsForm.srchType=='Cntt'}">selected</c:if>>내	용</option>
										<option value="Nick" <c:if test="${bsForm.srchType=='Nick'}">selected</c:if>>닉네임</option>
									</select>
								</div>
								
								<input type="text" id="bltn_srchKey" name="bltn_srchKey" value="<c:out value="${bsForm.srchKey}"/>" onkeydown="if(event.keyCode==13){aBM.getBltnMngr().doSearch();}" class="txt_100" /> 

								<div class="sel_100">
									<select id="bltn_srchDelFlag" name="bltn_srchDelFlag" class="txt_100">
										<option value="" <c:if test="${bsForm.srchDelFlag==''}">selected</c:if>>정상</option>
										<option value="A" <c:if test="${bsForm.srchDelFlag=='A'}">selected</c:if>>전체</option>
										<option value="Y" <c:if test="${bsForm.srchDelFlag=='Y'}">selected</c:if>>삭제</option>
									</select>
								</div>

								<div class="sel_100">
									<select id="bltn_pageSize" name="bltn_pageSize" class="txt_100">
										<option value="10"	<c:if test="${boardSttVO.pageSize==10}"> selected</c:if>>10 건씩</option>
										<option value="20"	<c:if test="${boardSttVO.pageSize==20}"> selected</c:if>>20 건씩</option>
										<option value="30"	<c:if test="${boardSttVO.pageSize==30}"> selected</c:if>>30 건씩</option>
										<option value="50"	<c:if test="${boardSttVO.pageSize==50}"> selected</c:if>>50 건씩</option>
										<option value="100" <c:if test="${boardSttVO.pageSize==100}">selected</c:if>>100 건씩</option>
									</select>
								</div>
								
								
								<a href="#none" onclick="javascript:aBM.getBltnMngr().doSearch()" class="btn_search">
									<span><util:message key='ev.title.search'/></span>
								</a>													
							</form>
						</fieldset>
					</div>
					<!-- searchArea//-->            
	            
				<table id="grid-table" border="0" cellspacing="0" cellpadding="0" class="table_board">
				<caption>게시판리스트</caption>
					<colgroup>
						<col width="30px" />
						<col width="*" />
						<col width="80px" />
						<col width="100px" />
						<col width="100px" />
						<col width="50px" />
					</colgroup>
					<thead>
						<tr>
							<th class="C first"><span class="table_title">선택</span></th>
							<th class="C"><span class="table_title">제목</span></th>
							<th class="C"><span class="table_title">삭제여부</span></th>
							<th class="C"><span class="table_title">닉네임</span></th>
							<th class="C"><span class="table_title">작성일자</span></th>
							<th class="C"><span class="table_title">조회수</span></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${bltnList}" var="bltn" varStatus="status">
							<tr>
								<td class="C">
									<input type="checkbox" style="border:none" id="bltn_checkRow" name="bltn_checkRow" value="<c:out value="${bltn.bltnNo}"/>" />
								</td>
								<td class="L">
									<span style="width:<c:out value="${bltn.bltnLevLen}"/>"></span>
									<c:if test="${bltn.bltnLev != '1'}"><img src="<%=evcp%>/board/images/admin/i_re.gif"></c:if>
									<font onclick="aBM.getBltnMngr().readBltn('<c:out value="${bltn.bltnNo}"/>')" style="cursor:pointer" onmouseover="this.style.textDecoration='underline'" 
											onmouseout="this.style.textDecoration='none'"><c:out value="${bltn.bltnSubj}"/></font>
								</td>
								<td class="C">
									${bltn.delFlag}
								</td>
								<td class="C">
									<c:if test="${empty bltn.userNick}">.</c:if>
									<c:if test="${!empty bltn.userNick}"><c:out value="${bltn.userNick}"/></c:if>
								</td>
								<td class="C"><c:out value="${bltn.regDatim}"/></td>
								<td class="C"><c:out value="${bltn.bltnReadCnt}"/></td>
							</tr>
						</c:forEach>					
					</tbody>						
				</table>
				<!-- tcontrol-->
				<div class="tcontrol">
					<!-- paging -->
					<div class="paging" id="bltn_PAGE_ITERATOR">				
					</div>
					<!-- paging//-->
				</div>
				<!-- tcontrol//-->
				<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || sessionScope._user_domain_.domainId == boardVO.domainId}">
					<!-- btnArea-->
					<div class="btnArea"> 
						<div class="rightArea">
							<input type="text" id="bltn_dstBoardId" name="bltn_dstBoardId" disabled="true" class="txt_100"/>
							<input type="text" id="bltn_dstBoardNm" name="bltn_dstBoardNm" disabled="true" class="txt_100"/>
							<a href="javascript:aBM.getBoardChooser().doShow('bltn_dstBoardId','bltn_dstBoardNm')" class="btn_B"><span>대상게시판선택</span></a>
							<a href="javascript:aBM.getBltnMngr().doBltnMng('MOVE')" class="btn_W"><span>이동</span></a>
							<a href="javascript:aBM.getBltnMngr().doBltnMng('COPY')" class="btn_W"><span>복사</span></a>
							<a href="javascript:aBM.getBltnMngr().doBltnMng('DELETE')" class="btn_W"><span>삭제</span></a>
						</div>
						<font color='red'>* 삭제 시 삭제 플래그 설정없이 데이타베이스에서 삭제되니 주의하시기 바랍니다.</font> 
					</div>
					<!-- btnArea//-->
				</c:if>								
	            </c:if>
			</div>
			<!-- board// -->
		</div>
		<!-- bltnAccordion// -->