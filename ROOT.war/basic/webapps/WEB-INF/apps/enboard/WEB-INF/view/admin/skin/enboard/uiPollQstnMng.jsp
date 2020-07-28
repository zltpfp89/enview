<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String evcp = request.getContextPath();
%>
<%--BEGIN::설문문항목록--%>
<c:if test="${apForm.view == 'listQ'}">
	<!-- qstnAccordion -->
	<div id="qstnAccordion">
		<h3><a href="#">문항관리</a></h3>
		<div class="board">
			<form name="apmQstnEditForm" method="post" action="" onsubmit="return false">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<caption>게시판 리스트</caption>
					<colgroup>
						<col width="50px" />
						<col width="*" />
					</colgoup>
					<thead>
						<tr>
							<th class="first">순번</th>
							<th class="C"><span class="table_title">문항</span></th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty pollQList}">
							<tr><td class="C" colspan="2">배속된 설문문항이 존재하지 않습니다.</td></tr>
						</c:if>
						<c:if test="${!empty pollQList}">
							<c:forEach items="${pollQList}" var="pollQ" varStatus='status'>
								<tr id='qstn_pollQTr<c:out value="${status.index}"/>' height="22"  
								onclick="ebUtil.selectTr('qstn_pollQTr',<c:out value="${status.index}"/>);aPM.getQstnMngr().pollRequest('','editQ','upd','<c:out value="${pollQ.bltnNo}"/>');">
									<td class="C"><c:out value="${pollQ.bltnGq}"/></td>
									<td class="L"><c:out value="${pollQ.bltnCntt}"/></td>
								</tr>
							</c:forEach>
						</c:if>							
					</tbody>
					<input type="hidden" id="qstn_pollQTrIndex">
				</table>
				<c:if test="${!empty apForm.boardId}"><%--설문이 선택되었을 때만 추가가 가능--%>
					<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || (sessionScope._enview_user_info_.hasDomainManagerRole && sessionScope._user_domain_.domainId == boardVO.domainId)}">
						<!-- btnArea-->
						<div class="btnArea">
							<div class="rightArea"><a href="javascript:aPM.getQstnMngr().pollRequest('', 'editQ','ins','')" class="btn_B"><span>추가</span></a></div>
						</div>
						<!-- btnArea//-->
					</c:if>
				</c:if>
			</form>
			<table id="grid-table" border="0" cellspacing="0" cellpadding="0" class="table_board">
			    <tr><td id="qstn_pollQArea" valign="top"></td></tr>
			</table>			
		</div>
	</div>
	<!-- qstnAccordion// -->
</c:if>
<%--END::설문문항목록--%>

<%--BEGIN::설문문항내역 및 답변항목목록--%>
<c:if test="${apForm.view == 'editQ'}">
 	<a name=editTop></a>
 	<div class="board">
		<form name="frmPQE" method="post" action="" onsubmit="return false">
			<input type="hidden" id="qstn_cmd"     name="qstn_cmd"     value="<c:out value="${apForm.cmd}"/>">
			<input type="hidden" id="qstn_view"    name="qstn_view"    value="<c:out value="${apForm.view}"/>">
			<input type="hidden" id="qstn_act"     name="qstn_act"     value="<c:out value="${apForm.act}"/>">
			<input type="hidden" id="qstn_boardId" name="qstn_boardId" value="<c:out value="${apForm.boardId}"/>"/>
			<input type="hidden" id="qstn_bltnNo"  name="qstn_bltnNo"  value="<c:out value="${apForm.bltnNo}"/>"/>
			<input type="hidden" id="qstn_pollSeq" name="qstn_pollSeq" value="<c:out value="${apForm.pollSeq}"/>"/>
			<input type="hidden" id="qstn_fileMask" name="qstn_fileMask" value="<c:out value="${bltnVO.fileMask}"/>"> 	
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<caption>게시판</caption>
				<colgroup>
					<col width="20%"/>
					<col width="*">
				</colgroup>
				<tr>
					<td colspan="4">
						<img src="<%=evcp%>/board/images/admin/ic_triangle.gif" style="margin:0 5 0 0;" align="absmiddle">
						설문을 생성/수정/삭제 하실 수 있습니다.
					</td>
				</tr>
				<tr>
					<th class="L">설문문항 번호</th>
					<td class="L" colspan="3">
						<input type="text" name="qstn_bltnGq" id="qstn_bltnGq" size="8" maxlength="8" value="<c:out value="${bltnVO.bltnGq}"/>">
					</td>
				</tr>
				<tr>	
					<th class="L">설문문항</th>
					<td class="L" colspan="3">
						<textarea name="qstn_bltnCntt" id="qstn_bltnCntt" style="height:60;width:99%"><c:out value="${bltnVO.bltnCntt}"/></textarea>
					</td>
				</tr>
				<tr>
					<th class="L">다중선택</th>
					<td class="L" colspan="3">
						<div class="sel_100">
							<select name="qstn_betPnt" id="qstn_betPnt" class="txt_100">
								<option value="0" <c:if test="${bltnVO.betPnt==0}">selected="true"</c:if>></option>
								<option value="2" <c:if test="${bltnVO.betPnt==2}">selected="true"</c:if>>2</option>
								<option value="3" <c:if test="${bltnVO.betPnt==3}">selected="true"</c:if>>3</option>
								<option value="4" <c:if test="${bltnVO.betPnt==4}">selected="true"</c:if>>4</option>
								<option value="5" <c:if test="${bltnVO.betPnt==5}">selected="true"</c:if>>5</option>
								<option value="-1" <c:if test="${bltnVO.betPnt==-1}">selected="true"</c:if>>제한없음</option>
							</select>
						</div>					
				    </td>
				</tr>
				<c:if test="${boardVO.pollImgYn == 'Y'}"><%--답변항목 아이콘을 사용할 때만--%>
					<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || (sessionScope._enview_user_info_.hasDomainManagerRole && sessionScope._user_domain_.domainId == boardVO.domainId)}">
						<tr>
							<th class="L">설문이미지</th>
						  	<td class="L" colspan="3">
								<form name="setPollQ" method="post" enctype="multipart/form-data" target="download" action="<%=evcp%>/board/fileMngr?cmd=upload&boardId=<c:out value="${apForm.boardId}"/>">
						    		<table>
										<tr><%--이미지 업로드 파일콘트롤.--%>
											<td colspan="3">
												<img id="qstn_imgPoll" src="${bltnVO.pollImageSrc}" align='absmiddle' style='border:1px #dddddd solid; max-width:600px;max-height:400px; '  onerror="this.src='${requestContext.contextPath}/images/no.gif'"/><br/>
								  				<input type="file" id="pollFile" name="pollFile">
												<!-- btnArea-->
												<div class="btnArea">
													<div class="rightArea">
														<a href="javascript:aPM.getQstnMngr().uploadPollImgQ(event)" class="btn_B"><span>이미지올리기</span></a>
														<a href="javascript:aPM.getQstnMngr().deletePollImgQ(event)" class="btn_B"><span>이미지내리기</span></a>
													</div>
												</div>
												<!-- btnArea//-->					  				
								  				<br/>
								  				* 이미지를 올린 뒤 저장해야 이미지가 변경 됩니다.
											</td>
						  				</tr>
									</table>
								   	<input type="hidden" name="subId"   value="sub11">
								   	<input type="hidden" name="mode"    value="pollQ">
									<input type="hidden" name="seq"      value="<c:out value="${bltnPollVO.pollSeq}"/>">
									<input type="hidden" name="fileMask" value="<c:out value="${bltnPollVO.fileMask}"/>">
								</form>
						  	</td>
						</tr>
			   		</c:if>
			    </c:if>
			    <c:if test="${apForm.act != 'ins'}">
					<tr>
						<th class="L">최종수정자</th>
						<td class="L"><c:out value="${bltnVO.userId}"/></td>
						<th class="L">최종수정일시</th>
						<td class="L"><c:out value="${bltnVO.updDatimF}"/></td>
					</tr>		    
			    </c:if>
			</table>
		</form>
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<tr>
				<td class="L">
					<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || (sessionScope._enview_user_info_.hasDomainManagerRole && sessionScope._user_domain_.domainId == boardVO.domainId)}">
						<!-- btnArea-->
						<div class="btnArea">
							<div class="leftArea">
								<a href="javascript:aPM.getBoardChooser().doShow('qstn_dstBoardId','qstn_dstBoardNm')" class="btn_B"><span>대상 설문 선택 >></span></a>
								<input type='hidden' name='qstn_dstBoardId' id='qstn_dstBoardId'><input type='text' name='qstn_dstBoardNm' id='qstn_dstBoardNm' class="txt_200" disabled='true'>
								<a href="javascript:aPM.getQstnMngr().pollRequest('qDup')" id="qstn_dupBtn" class="btn_B"><span>복사</span></a>
							</div>
						</div>
						<!-- btnArea//-->
					</c:if>
			 	</td>
			 	<td class="R">
					<!-- btnArea-->
					<div class="btnArea">
						<div class="rightArea">
							<a href="javascript:aPM.getQstnMngr().pollRequest('qList')" class="btn_B"><span>목록</span></a>
							<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || (sessionScope._enview_user_info_.hasDomainManagerRole && sessionScope._user_domain_.domainId == boardVO.domainId)}">
								<a href="javascript:aPM.getQstnMngr().pollRequest('qSave')" class="btn_B"><span>저장</span></a>
								<a href="javascript:aPM.getQstnMngr().pollRequest('qDel')" class="btn_B"><span>삭제</span></a>
							</c:if>							
						</div>
					</div>
					<!-- btnArea//-->	
			  	</td>
			</tr>		
		</table>
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<caption>게시판</caption>
			<colgroup>
				<col width="13%"/>
				<col width="16%"/>
				<col width="*"/>
				<col width="16%"/>
			</colgroup>
			<thead>
				<tr>
					<th class="first">순번</th>
					<th class="C"><span class="table_title">유형</span></th>
					<th class="C"><span class="table_title">답변항목</span></th>
					<th class="C"><span class="table_title">배점</span></th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty bltnVO.pollList}">
					<tr><td colspan="4" class="C">배속된 답변항목이 존재하지 않습니다.</td></tr>
			    </c:if>
				<c:if test="${!empty bltnVO.pollList}">
					<c:forEach items="${bltnVO.pollList}" var="pollA" varStatus='status'>
						<tr id='qstn_pollATr<c:out value="${status.index}"/>' height=22 
							onclick="ebUtil.selectTr('qstn_pollATr',<c:out value="${status.index}"/>);aPM.getQstnMngr().pollRequest('','editA','upd','<c:out value="${pollA.bltnNo}"/>','<c:out value="${pollA.pollSeq}"/>');">
							<td class="C"><c:out value="${pollA.pollSeq}"/></td>
							<td class="C">
								<c:out value="${pollA.pollKindNm}"/>
								<%--아래 Hidden field는 답병항목 편집 시 admin_poll.js의 pollRequest()에서 서술형의 중복 여부를 체크하기 위해 쓰임.--%>
								<input type='hidden' name='qstn_pollSequ' id='qstn_pollSequ' value='<c:out value="${pollA.pollSeq}"/>'/>
								<input type='hidden' name='qstn_pollKind' id='qstn_pollKind' value='<c:out value="${pollA.pollKind}"/>'/>
							</td>
							<td class="C">
								<c:if test="${pollA.pollKind == 'A'}"><c:out value="${pollA.pollCntt}"/></c:if>
								<c:if test="${pollA.pollKind == 'B'}">
									<c:if test="${empty pollA.pollCntt}"> 
										이 답변항목은 '서술형'입니다
									</c:if>
									<c:if test="${!empty pollA.pollCntt}"> 
										<c:out value="${pollA.pollCntt}"/>
									</c:if>
								</c:if>
							</td>
							<td class="C"><c:out value="${pollA.pollPnt}"/></td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		  	<input type="hidden" id="qstn_pollATrIndex">			
		</table>
		<!-- btnArea-->
		<div class="btnArea">
			<div class="rightArea">
			    <c:if test="${!empty bltnVO.bltnNo}"><%--설문문항이 선택되었을 때만 추가가 가능--%>
					<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || (sessionScope._enview_user_info_.hasDomainManagerRole && sessionScope._user_domain_.domainId == boardVO.domainId)}">
						<a href="javascript:aPM.getQstnMngr().pollRequest('','editA','ins','<c:out value="${bltnVO.bltnNo}"/>','0')" class="btn_B"><span>답변항목추가</span></a>
					</c:if>
				</c:if>							
			</div>
		</div>
		<!-- btnArea//-->
		<table id="grid-table" border="0" cellspacing="0" cellpadding="0" class="table_board">
		    <tr><td id="qstn_pollAArea" valign="top"></td></tr>
		</table>
	</div>
</c:if>
<%--END::설문문항내역 및 답변항목목록--%>

<%--BEGIN::답변항목내역--%>
<c:if test="${apForm.view == 'editA'}">
	<div class="board">
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<caption>게시판</caption>
			<colgroup>
				<col width="23%"/>
				<col width="*"/>
				<col width="23%"/>
				<col width="*"/>
			</colgroup>
			<form name="frmPAE" method="post" action="" onsubmit="return false">
				<input type="hidden" id="answ_cmd"     name="answ_cmd"     value="<c:out value="${apForm.cmd}"/>">
				<input type="hidden" id="answ_view"    name="answ_view"    value="<c:out value="${apForm.view}"/>">
				<input type="hidden" id="answ_act"     name="answ_act"     value="<c:out value="${apForm.act}"/>">
				<input type="hidden" id="answ_boardId" name="answ_boardId" value="<c:out value="${apForm.boardId}"/>">
				<input type="hidden" id="answ_bltnNo"  name="answ_bltnNo"  value="<c:out value="${apForm.bltnNo}"/>">
				<input type="hidden" id="answ_fileMask"  name="answ_fileMask"  size=40 value="<c:out value="${bltnPollVO.fileMask}"/>">
				<tr>
					<td colspan="4">
						<img src="<%=evcp%>/board/images/admin/ic_triangle.gif" style="margin:0 5 0 0;" align="absmiddle">
						답변항목내역을 생성/수정/삭제 하실 수 있습니다.			
					</td>
				</tr>
				<tr>
					<th class="L">답변항목 번호</th>
					<td colspan="3">
						<c:if test="${apForm.act != 'ins'}">
							<input type="text" name="answ_pollSeq" id="answ_pollSeq" style="width:100px" maxlength="6" value="<c:out value="${bltnPollVO.pollSeq}"/>">
						</c:if>
						<c:if test="${apForm.act == 'ins'}">
							<input type="text" name="answ_pollSeq" id="answ_pollSeq" style="width:100px" maxlength="6">
						</c:if>
					</td>
				</tr>				
				<tr>
					<th class="L">답변항목 유형</th>
					<td class="L">
						<c:forEach items="${kindList}" var="list">
							<input type="radio" name="answ_pollKind" id="answ_pollKind" value="<c:out value="${list.code}"/>" 
						  	<c:if test="${bltnPollVO.pollKind==list.code}">checked=true</c:if>
							<%--onclick="pollRequest('selKind')"--%>
							><c:out value="${list.codeName}"/>&nbsp;&nbsp;
						</c:forEach>
					</td>
					<th class="L">답변항목 배점</th>
					<td class="L">
						<input type="text" name="answ_pollPnt" id="answ_pollPnt" style="width:100px" maxlength="6" value="<c:out value="${bltnPollVO.pollPnt}"/>">
					</td>					
				</tr>
				<tr id='answ_pollCnttTr' <%--c:if test="${bltnPollVO.pollKind == 'B'}">style='display:none'</c:if--%>>
					<th class="L">답변항목</th>
					<td class="L" colspan="3">
						<textarea name="answ_pollCntt" id="answ_pollCntt" style="height:60;width:99%"><c:out value="${bltnPollVO.pollCntt}"/></textarea>
				  	</td>
				</tr>
			</form>
			<tr id='answ_pollCnttTrLine' <%--c:if test="${bltnPollVO.pollKind == 'B'}">style='display:none'</c:if--%>><td colspan="4"></td></tr>
			<c:if test="${boardVO.pollImgYn == 'Y'}"><%--답변항목 아이콘을 사용할 때만--%>
				<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || (sessionScope._enview_user_info_.hasDomainManagerRole && sessionScope._user_domain_.domainId == boardVO.domainId)}">
					<form name="setPollA" method="post" enctype="multipart/form-data" target="download" action="<%=evcp%>/board/fileMngr?cmd=upload&boardId=<c:out value="${apForm.boardId}"/>">
					    <tr>
					    	<th class="L">답변이미지</th>
						  	<td class="L" colspan="3">
						    	<table>
									<tr><%--이미지 업로드 파일콘트롤.--%>
										<td>
											<img id="answ_imgPoll" src="${requestContext.contextPath}/upload/poll/${apForm.boardId}/${bltnPollVO.fileMask}" align='absmiddle' style='border:1px #dddddd solid; max-width:600px'  onerror="this.src='${requestContext.contextPath}/images/no.gif'"/><br>
											<input type="file" id="pollFile" name="pollFile">
											<span class="btn_pack medium"><a href="javascript:aPM.getQstnMngr().uploadPollImgA(event)">이미지올리기</a></span>
											<span class="btn_pack medium"><a href="javascript:aPM.getQstnMngr().deletePollImgA(event)">이미지내리기</a></span>
							  			<br/>
						 				* 이미지를 올린 뒤 저장해야 이미지가 변경 됩니다.
										</td>
						  			</tr>
								</table>
						        <input type="hidden" name="subId"   value="sub11">
						        <input type="hidden" name="mode"    value="pollA">
							  	<input type="hidden" name="seq"      value="<c:out value="${bltnPollVO.pollSeq}"/>">
								<input type="hidden" name="fileMask" value="<c:out value="${bltnPollVO.fileMask}"/>">
						  	</td>
					    </tr>					
					</form>
				</c:if>
			</c:if>							
		</table>				
		<!-- btnArea-->
		<div class="btnArea">
			<div class="rightArea">
		  		<a href="javascript:aPM.getQstnMngr().pollRequest('aList')" class="btn_B"><span>목록</span></a>
		  		<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || (sessionScope._enview_user_info_.hasDomainManagerRole && sessionScope._user_domain_.domainId == boardVO.domainId)}">
					<a href="javascript:aPM.getQstnMngr().pollRequest('aSave')" class="btn_B"><span>저장</span></a>
					<a href="javascript:aPM.getQstnMngr().pollRequest('aDel')" class="btn_B"><span>삭제</span></a>
				</c:if>							
			</div>
		</div>
		<!-- btnArea//-->
	</div>
</c:if>
<%--END::답변항목내역--%>