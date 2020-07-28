<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String evcp = request.getContextPath();
%>

		<!-- pollAccordion -->
		<div id="pollAccordion">
			<h3><a href="#">설문관리</a></h3>
			<div class="board">
				<form name="apmPollEditForm" onsubmit="return false">
					<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board"> 
						<caption>게시판</caption>
						<colgroup>
							<col width="28%" />
							<col width="*" />
							<col width="28%" />
							<col width="*" />							
	                	</colgroup>
	                    <tbody>
							<tr>
								<td colspan="4">
									<img src="<%=evcp%>/board/images/admin/ic_triangle.gif" style="margin:0 5 0 0;" align="absmiddle">
									설문을 생성/수정/삭제 하실 수 있습니다.						
								</td>
							</tr>	                       
							<tr>
								<th class="L">설문 ID</th>
								<td class="L">
									<c:if test="${!empty boardVO}">
									<c:out value="${boardVO.boardId}"/>
									<input type="hidden" name="poll_boardId" id="poll_boardId" value="<c:out value="${boardVO.boardId}"/>">
									</c:if>
									<c:if test="${empty boardVO}">
									<input type="text" name="poll_boardId" id="poll_boardId" maxlength="12" class="txt_100per">
									</c:if>
								</td>
								<th class="L">활성화 여부</th>
								<td class="L">
									<c:forEach items="${activeList}" var="list">
									<input type="radio" name="poll_boardActive" id="poll_boardActive" value="<c:out value="${list.code}"/>" <c:if test="${list.code==boardVO.boardActive}">checked="true"</c:if>>
									<label for="poll_boardActive">&nbsp;<c:out value="${list.codeName}"/>&nbsp;&nbsp;</label>
									</c:forEach>
								</td>
							</tr>
							<tr>
								<th class="L">설문 명</th>
								<td class="L" colspan="3">
									<input type="text" name="poll_boardNm" id="poll_boardNm" maxlength="100" value="<c:out value="${boardVO.boardNm}"/>" class="txt_200">&nbsp;&nbsp;&nbsp;
									<a id="poll_boardNmLangBtn" href="javascript:ebUtil.getMLMngr().doShow(aPM,'apmMultiLangMngr','poll',document.getElementById('pollList'+aPM.m_selectRowIndex+'_boardId').value)" class="btn_B" >
										<span>제목</span>
									</a>
								</td>
							</tr>
							<tr>
								<th class="L">설문 설명</th>
								<td class="L" colspan="3">
									<input type="text" name="poll_boardTtl" id="poll_boardTtl" maxlength="100" value="<c:out value="${boardVO.boardTtl}"/>" class="txt_200">&nbsp;&nbsp;&nbsp;
									<a id="poll_boardTtlLangBtn" href="javascript:ebUtil.getMLMngr().doShow(aPM,'apmMultiLangMngr','poll',document.getElementById('pollList'+aPM.m_selectRowIndex+'_boardId').value)" class="btn_B" >
										<span>제목</span>
									</a>
								</td>
							</tr>
							<tr>
								<th class="L">스킨선택</th>
								<td class="L" colspan="3">
									<div class="sel_100">
										<select name="poll_boardSkin" id="poll_boardSkin" class="txt_100">
											<c:forEach items="${fileList}" var="list">
												<option value="<c:out value="${list.code}"/>" <c:if test="${boardVO.boardSkin==list.code}">selected="true"</c:if>><c:out value="${list.codeName}"/></option>
											</c:forEach>
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<th class="L">설문기간</th>
								<td class="L" colspan="3">
									<input type="text" name="poll_pollBgnYmd" id="poll_pollBgnYmd" value="<c:out value="${pollPropVO.pollBgnYmdF}"/>" class="txt_100" maxlength="10" disabled>
									<span class="sel_txt"><img src="<%=evcp%>/board/images/admin/calendar.gif" onclick="displayCalendar(new Date(),'poll_pollBgnYmd',event)"></span> 
									<span class="sel_txt"> ~ </span>
									<input type="text" name="poll_pollEndYmd" id="poll_pollEndYmd" value="<c:out value="${pollPropVO.pollEndYmdF}"/>" class="txt_100" maxlength="10" disabled>
									<span class="sel_txt"><img src="<%=evcp%>/board/images/admin/calendar.gif" onclick="displayCalendar(new Date(),'poll_pollEndYmd',event)"></span>
								</td>
							</tr>
							<tr>
								<th class="L">평가사용여부</th>
								<td class="L" colspan="3">
									<c:forEach	items="${radioList}" var="list">
									<input type=radio name="poll_evalYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.evalYn==list.code}">checked</c:if>>
									<label>&nbsp;<c:out value="${list.codeName}"/>&nbsp;&nbsp;</label>
									</c:forEach>
								</td>
							</tr>
							<c:if test="${!empty boardVO}">
								<tr>
									<th class="L">최종수정자</th>
									<td class="L"><c:out value="${boardVO.updUserId}"/></td>
									<th class="L">최종수정일시</th>
									<td class="L"><c:out value="${boardVO.updDatimF}"/></td>
								</tr>
							</c:if>                     	                        	                        	                        	                        	                        	
	                	</tbody>					
					</table>
					<!-- btnArea-->
					<div class="btnArea"> 
						<div class="rightArea">
							<a href="javascript:aPM.getPollMngr().doPollPreview()" class="btn_B"><span>미리보기</span></a>
							<c:if test="${!empty boardVO}">
								<a id="poll_add" href="javascript:aPM.getPollMngr().doSave('add')" class="btn_B"><span>신규</span></a>
							</c:if>
							<a id="poll_save" href="javascript:aPM.getPollMngr().doSave('save')" class="btn_B"><span>저장</span></a>
							<a id="poll_del" href="javascript:aPM.getPollMngr().doSave('del')" class="btn_B"><span>삭제</span></a>
						</div>
					</div>
					<!-- btnArea//-->
					<c:if test="${!empty boardVO}">
						<c:if test="${sessionScope.userInfo.hasAdminRole || sessionScope.userInfo.hasManagerRole || (sessionScope.userInfo.hasDomainManagerRole && sessionScope.userDomain.domainId == boardVO.domainId)}">
							<div class="board">
								<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board"> 
									<caption>게시판</caption>
									<colgroup>
										<col width="20%" />
										<col width="20%" />
										<col width="30%" />
										<col width="30%" />
									</colgroup>
									<tr>
										<td colspan="4">
											<img src="<%=evcp%>/board/images/admin/ic_triangle.gif" style="margin:0 5 0 0;" align="absmiddle">
											선택된 설문을 복사하여 새로운 설문을 생성하실 수 있습니다.										
										</td>
									</tr>								
									<tr>
										<td class="L" colspan="4">
											선택한 설문을 새로운 설문 ID&nbsp;
											<input type="text" name="poll_dstBoardId" id="poll_dstBoardId" maxlength="12" class="txt_100" />
											로 &nbsp;<a href="javascript:aPM.getPollMngr().doSave('dup')" class="btn_B"><span>복사</span></a>
										</td>
									</tr>
									<tr>
										<td colspan="4">
											<img src="<%=evcp%>/board/images/admin/ic_triangle.gif" style="margin:0 5 0 0;" align="absmiddle">
											선택된 설문을 다른 카테고리로 이동할 수 있습니다.<br>
											<%--선택된 설문을 다른 카테고리로 이동/복사하거나 현재 카테고리에서 삭제할 수 있습니다.<br>--%>
										<%--&nbsp;&nbsp;&nbsp;&nbsp;(<b>복사</b>: 동일설문을 다수의 카테고리에 배속. <b>삭제</b>: 설문을 해당 카테고리에서만 제거.)--%>
										</td>
									</tr>
									<tr>
										<td class="L" colspan="2">
											선택한 설문을
											<a href="javascript:aPM.getPollMngr().doCateBoardMove('MOVE')" class="btn_B"><span>이동</span></a>
										<%--설문에서 카테고리간 '복사'기능이 필요없는 것 같아 막아버림. '복사'가 없으면 '삭제'도 의미없음.2010.07.23.KWShin--%>
											<%--span class="btn_pack medium"><a href="javascript:aPM.getPollMngr().doCateBoardMove('COPY')">복사</a></span--%>
											<%--span class="btn_pack medium"><a href="javascript:aPM.getPollMngr().doCateBoardMove('DELETE')">삭제</a></span--%>
										</td>
										<td class="L">
											<a id="poll_selCate" href="javascript:aPM.getCateChooser().doShow('poll_trgtCateId','poll_trgtCateNm','poll_trgtCateDomainId')"  class="btn_B"><span >대상 카테고리 선택 >></span></a>
										</td>
										<td class="L">
											<input type="hidden" name="poll_trgtCateId" id="poll_trgtCateId">
											<input type="text" name="poll_trgtCateNm" id="poll_trgtCateNm" disabled="true" class="txt_100per">
											<input type="hidden" name="poll_trgtCateDomainId" id="poll_trgtCateDomainId">
										</td>
									</tr>							
								</table>
							</div>
						</c:if>
					</c:if>	
					<input type="hidden" name="poll_cmd" id="poll_cmd" value="<c:out value="${apForm.cmd}"/>"/>
				</form>	
			</div>
		</div>
		<!-- pollAccordion// -->