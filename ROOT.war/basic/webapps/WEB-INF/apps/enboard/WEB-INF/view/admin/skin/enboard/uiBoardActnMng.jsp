<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String evcp = request.getContextPath();
%>
		<!-- actnAccordion -->
		<div id="actnAccordion">
			<h3><a href="#">게시판 유형</a></h3>
			<div class="board">
				<c:if test="${boardVO.boardId == boardVO.boardRid}">
                    <table cellpadding="0" cellspacing="0" summary="게시판 상세" class="table_board">  
                    <caption>게시판 상세</caption>
                        <colgroup>
							<col width="20%" />
							<col width="80%" />
                        </colgroup>
                        <tbody>   
                            <tr>
                                <th class="L" rowspan="2">게시판 유형</th>
                                <td class="L">
                                    <fieldset>
										<c:forEach items="${typeList}" var="list" varStatus="status">
											<input type=radio id="actn_boardType_${status.index }" name="actn_boardType" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.boardType==list.code}">checked</c:if> />
											<label for="actn_boardType_${status.index }"><c:out value="${list.codeName}"/></label>
										</c:forEach>
                                    </fieldset>
                                </td>
                           </tr>
                            <tr>
                                <td class="L"><em>설문형</em> : 설문기능을 지원합니다  /  <em>지식형</em> : Naver 지식in과 같은 기능을 지원합니다</td>
                           </tr>
                            <tr>
                                <th class="L" rowspan="2">통합게시판 유형</th>
                                <td class="L">
                                    <fieldset>
										<c:forEach items="${mergeList}" var="list">
											<input type=radio id="actn_mergeType_${status.index }" name="actn_mergeType" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.mergeType==list.code}">checked</c:if> />
											<label for="actn_mergeType_${status.index }"><c:out value="${list.codeName}"/></label>
										</c:forEach>
                                    </fieldset>
                                </td>
                           </tr>
                            <tr>
                                <td class="L">
                                	<em>통합형</em> : 동일 카테고리에 속한 모든 게시판의 통합목록을 제공합니다<br/>
                                	<em>최신글형</em> : 통합형이며 최신 게시물의 목록을 제공합니다<br/>
                                	<em>인기글형</em> : 통합형이며 조회수가 높은 게시물의 목록을 제공합니다<br/>
                                	<em>이미지형</em> : 통합형이며 이미지가 첨부된 게시물만의 목록을 제공합니다<br/>
                                	<em>동영상형</em>: 통합형이며 동영상이 첨부된 게시물만의 목록을 제공합니다<br/>
                                	<em>나만의 자료실형</em> : 통합형이며 자신이 작성한 모든 게시물의 목록을 제공합니다<br/>
                                	<em>내게 온 글형</em> : 통합형이며 답글 쓰기 권한을 가진 지식형 게시판의 모든 게시물(답변글제외) 목록을 제공합니다
                                </td>
                           </tr>
                        </tbody>
                    </table>
                </c:if>
				<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || sessionScope._user_domain_.domainId == boardVO.domainId}">		
					<!-- btnArea-->
					<div class="btnArea">
						<div class="rightArea">
							<a href="javascript:aBM.getActnMngr().doSave('type')" class="btn_O"><span>저장</span></a>
							<a href="javascript:aBM.getActnMngr().doSave('tmpl')" class="btn_O"><span>템플릿 적용</span></a>
						</div>
					</div>
					<!-- btnArea//-->
				</c:if>	                    
               </div>	                
	            <h3><a href="#">기본 기능</a></h3>
				<div class="board">
					<c:if test="${boardVO.boardId == boardVO.boardRid}">
	                    <table cellpadding="0" cellspacing="0" summary="게시판 상세" class="table_board">  
	                    <caption>게시판 상세</caption>
	                        <colgroup>
								<col width="28%"/>
								<col width="*"/>
								<col width="28%"/>
								<col width="*"/>
	                        </colgroup>
	                        <tbody>   
								<%--BEGIN::통합형인 경우에는 게시물에 영향을 미치는 속성의 설정기능을 막는다.--%>
								<c:if test="${boardVO.mergeType == 'A'}">
									<tr>
										<th class="L">첨부파일 최대 갯수</th>
									  	<td class="L" colspan="3"><input type=text id="actn_maxFileCnt" maxlength=2 value="<c:out value="${boardVO.maxFileCnt}"/>" class="txt_100">&nbsp;0: 첨부 기능 사용 안함.</td>
									</tr>
									<tr>
									 	<th class="L">첨부파일 최대 크기</th>
									  	<td class="L" colspan="3"><input type=text id="actn_maxFileSize" maxlength=10 value="<c:out value="${boardVO.maxFileSize}"/>" class="txt_100">&nbsp;단위: Byte.</td>
									</tr>
									<tr>
									  	<th class="L">첨부파일 다운로드 횟수 제한</th>
									  	<td class="L" colspan="3"><input type=text id="actn_maxFileDown" maxlength=3 value="<c:out value="${boardVO.maxFileDown}"/>" class="txt_100">&nbsp;0: 제한 없음.</td>
									</tr>
								</c:if>
								<%--END::통합형인 경우에는 게시물에 영향을 미치는 속성의 설정기능을 막는다.--%>
								<tr>
									<th class="L">자동 악플 처리 기준 신고 수</th>
									<td class="L"><input type=text id="actn_badStdCnt" maxlength=4 value="<c:out value="${boardVO.badStdCnt}"/>" class="txt_100"></td>
									<th class="L">답글 기능</th>
									<td class="L">
									     <c:forEach items="${radioList}" var="list">
											<input type=radio name="actn_replyYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.replyYn==list.code}">checked</c:if>>
											<c:out value="${list.codeName}"/>&nbsp;&nbsp;
									     </c:forEach>
									</td>
								</tr>
								<tr>
									<th class="L">댓글 기능</th>
									<td class="L">
										<c:forEach  items="${radioList}" var="list">
											<input type=radio name="actn_memoYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.memoYn==list.code}">checked</c:if>>
											<c:out value="${list.codeName}"/>&nbsp;&nbsp;
										</c:forEach>
									</td>
									<th class="L">댓답글 기능</th>
									<td class="L">
								    	<c:forEach  items="${radioList}" var="list">
											<input type=radio name="actn_memoReplyYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.memoReplyYn==list.code}">checked</c:if>>
											<c:out value="${list.codeName}"/>&nbsp;&nbsp;
										</c:forEach>
									</td>
								</tr>
								<%--BEGIN::통합형인 경우에는 게시물에 영향을 미치는 속성의 설정기능을 막는다.--%>
								<c:if test="${boardVO.mergeType == 'A'}">
									<tr>
										<th class="L">비밀글 기능</th>
										<td class="L">
											<c:forEach  items="${radioList}" var="list">
										  		<input type=radio name="actn_secretYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.secretYn==list.code}">checked</c:if>>
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;
											</c:forEach>
										</td>
										<th class="L">익명 글쓰기 기능</th>
										<td class="L">
											<c:forEach  items="${radioList}" var="list">
										  		<input type=radio name="actn_ableAnonYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.ableAnonYn==list.code}">checked</c:if>>
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;
											</c:forEach>
										</td>
									</tr>
									<tr>
										<th class="L">익명 게시판 기능</th>
										<td class="L" colspan="3">
											<c:forEach  items="${anonList}" var="list">
												<input type=radio name="actn_anonYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.anonYn==list.code}">checked</c:if>
										   		onclick="aBM.getActnMngr().checkAnonGrade(this)">
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;
											</c:forEach>
											<input type="hidden" id="actn_anonYn_temp" name="actn_anonYn_temp" value="<c:out value="${boardVO.anonYn}"/>"/>
											<input type="hidden" id="gradeAActionMask" name="gradeAActionMask" value="<c:out value="${gradeA.codeTag2}"/>"/>
										</td>
									</tr>
									<tr>
										<th class="L">게시 기간 설정 기능</th>
										<td class="L">
											<c:forEach  items="${radioList}" var="list">
												<input type=radio name="actn_termYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.termYn==list.code}">checked</c:if>
									       		onclick="aBM.getActnMngr().doSelectTermYn(this)">
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;
									       	</c:forEach>
									  	</td>
									  	<th class="L">카테고리 기능</th>
									  	<td class="L">
									       	<c:forEach  items="${radioList}" var="list">
												<input type=radio name="actn_cateYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.cateYn==list.code}">checked</c:if>>
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;
									       	</c:forEach>
									  	</td>
									</tr>
									<tr>
									  	<th class="L">확장 필드 기능</th>
									  	<td class="L">
									       	<c:forEach  items="${radioList}" var="list">
										    	<input type=radio name="actn_extUseYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.extUseYn==list.code}">checked</c:if>
										       onclick="aBM.getActnMngr().doSelectExtUseYn(this)">
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;
									       	</c:forEach>
									  	</td>
									  	<th class="L">접근 권한 설정 기능</th>
									  	<td class="L">
										    <c:forEach  items="${radioList}" var="list">
										    	<input type=radio name="actn_accSetYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.accSetYn==list.code}">checked</c:if>>
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;
										    </c:forEach>
									  	</td>
									</tr>
								</c:if>
								<%--END::통합형인 경우에는 게시물에 영향을 미치는 속성의 설정기능을 막는다.--%>
								<tr id="termFlagTr" name="termFlagTr" <c:if test="${boardVO.termYn=='N'}">style="display:none"</c:if>>
									<td class="L">게시 기간 지정 유형</td>
								  	<td class="L" colspan="3">
										<c:forEach  items="${termList}" var="list">
											<input type=radio name="actn_termFlag" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.termFlag==list.code}">checked</c:if>>
											<c:out value="${list.codeName}"/>&nbsp;&nbsp;
										</c:forEach>
								  	</td>
								</tr>
								<tr id="extUseTr" name="extUseTr" <c:if test="${boardVO.extUseYn=='N'}">style="display:none"</c:if>>
								  	<th class="L">확장필드 테이블 클래스</th>
								  	<td class="L" colspan="3">
								    	<input type=text id="actn_extnClassNm" maxlength=60 style="width:100%;"
								        <c:if test="${!empty boardVO.extnClassNm}">value="<c:out value="${boardVO.extnClassNm}"/>"</c:if>
								        <c:if test="${empty boardVO.extnClassNm}">value="com.saltware.enboard.integrate.DefaultBltnExtnMapper"</c:if>
								 		/>
								  	</td>
								</tr>
	                        </tbody>
	                    </table>
	                </c:if>
					<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || sessionScope._user_domain_.domainId == boardVO.domainId}">		
						<!-- btnArea-->
						<div class="btnArea">
							<div class="rightArea"><a href="javascript:aBM.getActnMngr().doSave('func')" class="btn_O"><span>저장</span></a></div>
						</div>
						<!-- btnArea//-->
					</c:if>	                    
                </div>	                
	            <h3><a href="#">부가 기능</a></h3>
				<div class="board">
					<c:if test="${boardVO.boardId == boardVO.boardRid}">
					    <table cellpadding="0" cellspacing="0" summary="게시판 상세" class="table_board">  
	                    <caption>게시판 상세</caption>
	                        <colgroup>
								<col width="28%"/>
								<col width="*"/>
								<col width="28%"/>
								<col width="*"/>
	                        </colgroup>
	                        <tbody>   
								<%--BEGIN::통합형인 경우에는 게시물에 영향을 미치는 속성의 설정기능을 막는다.--%>
								<c:if test="${boardVO.mergeType == 'A'}">
									<tr>
										<th class="L">삭제 표시 기능</th>
									  	<td class="L" colspan="3">
											<c:forEach items="${radioList}" var="list">
												<input type=radio name="actn_delFlagYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.delFlagYn==list.code}">checked</c:if>>
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;(사용: 게시물 삭제 시 실제로 DB에서 삭제되지 않고 '삭제' 표시만 함.)
											</c:forEach>	  		
									  	</td>
									</tr>
									<tr>
									 	<th class="L">답글있는 글 삭제 정책</th>
									  	<td class="L" colspan="3">
											<c:forEach items="${orgDelList}" var="list">
												<input type=radio name="actn_orgDelYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.orgDelYn==list.code}">checked</c:if>>
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;
											</c:forEach>
											<input type=hidden id="reserve_orgDelYn" value="<c:out value="${boardVO.orgDelYn}"/>"/>										  		
									  	</td>
									</tr>
									<tr>
									  	<th class="L">공지글 기능</th>
									  	<td class="L">
											<c:forEach  items="${radioList}" var="list">
												<input type=radio name="actn_noticeYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.noticeYn==list.code}">checked</c:if>>
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;
											</c:forEach>										  	
									  	</td>
									  	<th class="L">승인 기능</th>
									  	<td class="L">
											<c:forEach  items="${radioList}" var="list">
												<input type=radio name="actn_permitYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.permitYn==list.code}">checked</c:if>>
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;
											</c:forEach>									  	
									  	</td>										  	
									</tr>
								</c:if>
								<c:if test="${boardVO.mergeType != 'A'}">
									<tr>
									 	<th class="L">공지글 기능</th>
									  	<td class="L">
											<c:forEach  items="${radioList}" var="list">
												<input type=radio name="actn_noticeYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.noticeYn==list.code}">checked</c:if>>
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;
											</c:forEach>										  		
									  	</td>
									</tr>									
								</c:if>
								<c:if test="${boardVO.mergeType == 'A'}">
									<tr>
									 	<th class="L">추천 기능</th>
									  	<td class="L">
											<c:forEach  items="${radioList}" var="list">
												<input type=radio name="actn_rcmdYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.rcmdYn==list.code}">checked</c:if>>
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;
											</c:forEach>										  		
									  	</td>
									 	<th class="L">평가 기능</th>
									  	<td class="L">
											<c:forEach  items="${radioList}" var="list">
												<input type=radio name="actn_evalYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.evalYn==list.code}">checked</c:if>>
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;
											</c:forEach>										  		
									  	</td>										  	
									</tr>
								</c:if>
								<tr>
								 	<th class="L">출석부 기능</th>
								  	<td class="L">
										<c:forEach  items="${radioList}" var="list">
											<input type=radio name="actn_attnYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.attnYn==list.code}">checked</c:if>>
											<c:out value="${list.codeName}"/>&nbsp;&nbsp;
										</c:forEach>										  		
								  	</td>
								 	<th class="L">답변알림 기능</th>
								  	<td class="L">
										<c:forEach  items="${radioList}" var="list">
											<input type=radio name="actn_snntYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.snntYn==list.code}">checked</c:if>>
											<c:out value="${list.codeName}"/>&nbsp;&nbsp;
										</c:forEach>									  		
								  	</td>										  	
								</tr>
								<tr>
								 	<th class="L">게시판 연결 기능</th>
								  	<td class="L">
										<c:forEach  items="${radioList}" var="list">
											<input type=radio name="actn_subBrdYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.subBrdYn==list.code}">checked</c:if>>
											<c:out value="${list.codeName}"/>&nbsp;&nbsp;
										</c:forEach>						  		
								  	</td>
								 	<th class="L">악플 신고 기능</th>
								  	<td class="L">
										<c:forEach  items="${radioList}" var="list">
											<input type=radio name="actn_memoBadYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.memoBadYn==list.code}">checked</c:if>>
											<c:out value="${list.codeName}"/>&nbsp;&nbsp;
										</c:forEach>									  		
								  	</td>										  	
								</tr>
								<tr>
								 	<th class="L">등급별 권한체계 사용 여부</th>
								  	<td class="L">
										<c:forEach  items="${radioList}" var="list">
											<input type=radio name="actn_grdAuthYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.grdAuthYn==list.code}">checked</c:if>>
											<c:out value="${list.codeName}"/>&nbsp;&nbsp;
										</c:forEach>	
								  	</td>
								 	<th class="L">자체 사용자등급 사용 여부</th>
								  	<td class="L">
										<c:if test="${boardVO.grdAuthYn == 'Y'}">
											<c:forEach  items="${radioList}" var="list">
												<input type=radio name="actn_ownGrdYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.ownGrdYn==list.code}">checked</c:if>>
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;
											</c:forEach>
										</c:if>
										<c:if test="${boardVO.grdAuthYn == 'N'}">
											<c:forEach  items="${radioList}" var="list" end="0">
												<input type=radio name="actn_ownGrdYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.ownGrdYn==list.code}">checked</c:if>>
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;
											</c:forEach>
										</c:if>
								  	</td>									  										
								</tr>
								<tr>
								 	<th class="L">불량 게시물 신고 기능</th>
								  	<td class="L">
										<c:forEach items="${radioList}" var="list">
											<input type=radio name="actn_bltnBadYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.bltnBadYn==list.code}">checked</c:if>>
											<c:out value="${list.codeName}"/>&nbsp;&nbsp;
										</c:forEach>	
								  	</td>									  										
								</tr>									
								<%--END::통합형인 경우에는 게시물에 영향을 미치는 속성의 설정기능을 막는다.--%>
	                        </tbody>
	                    </table>
	                </c:if>
					<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || sessionScope._user_domain_.domainId == boardVO.domainId}">		
						<!-- btnArea-->
						<div class="btnArea">
							<div class="rightArea"><a href="javascript:aBM.getActnMngr().doSave('buga')" class="btn_O"><span>저장</span></a></div>
						</div>
						<!-- btnArea//-->
					</c:if>	                    
                </div>	                
	           	<h3><a href="#">검색 필드</a></h3>
				<div class="board">
                    <table cellpadding="0" cellspacing="0" summary="게시판 상세" class="table_board">  
                    <caption>게시판 상세</caption>
                        <colgroup>
							<col width="20%"/>
							<col width="*"/>
							<col width="20%"/>
							<col width="*"/>
                        </colgroup>
                        <tbody>   
							<tr>
								<th class="L">작성자 검색</th>
							  	<td class="L">
									<c:forEach  items="${radioList}" var="list">
										<input type=radio name="actn_srchNickYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.srchNickYn==list.code}">checked</c:if>>
										<c:out value="${list.codeName}"/>&nbsp;&nbsp;
									</c:forEach>
							  	</td>
								<th class="L">제목 검색</th>
							  	<td class="L">
									<c:forEach  items="${radioList}" var="list">
										<input type=radio name="actn_srchSubjYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.srchSubjYn==list.code}">checked</c:if>>
										<c:out value="${list.codeName}"/>&nbsp;&nbsp;
									</c:forEach>											
							  	</td>					  	
							</tr>
							<tr>
								<th class="L">본문 검색</th>
							  	<td class="L">
									<c:forEach  items="${radioList}" var="list">
										<input type=radio name="actn_srchCnttYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.srchCnttYn==list.code}">checked</c:if>>
										<c:out value="${list.codeName}"/>&nbsp;&nbsp;
									</c:forEach>											
							  	</td>
								<th class="L">첨부파일명 검색</th>
							  	<td class="L">
									<c:forEach  items="${radioList}" var="list">
										<input type=radio name="actn_srchAtchYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.srchAtchYn==list.code}">checked</c:if>>
										<c:out value="${list.codeName}"/>&nbsp;&nbsp;
									</c:forEach>																						
							  	</td>					  	
							</tr>
							<tr>
								<th class="L">작성일 검색</th>
							  	<td class="L">
									<c:forEach  items="${radioList}" var="list">
										<input type=radio name="actn_srchRegYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.srchRegYn==list.code}">checked</c:if>>
										<c:out value="${list.codeName}"/>&nbsp;&nbsp;
									</c:forEach>											
							  	</td>
								<th class="L">답글 유무 검색</th>
							  	<td class="L">
									<c:forEach  items="${radioList}" var="list">
										<input type=radio name="actn_srchReplyYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.srchReplyYn==list.code}">checked</c:if>>
										<c:out value="${list.codeName}"/>&nbsp;&nbsp;
									</c:forEach>														
							  	</td>
							</tr>
							<tr>
								<th class="L">댓글 유무 검색</th>
							  	<td class="L" colspan="3">
									<c:forEach  items="${radioList}" var="list">
										<input type=radio name="actn_srchMemoYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.srchMemoYn==list.code}">checked</c:if>>
										<c:out value="${list.codeName}"/>&nbsp;&nbsp;
									</c:forEach>																						
							  	</td>
							</tr>
                        </tbody>
                    </table>
					<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || sessionScope._user_domain_.domainId == boardVO.domainId}">
						<!-- btnArea-->
						<div class="btnArea">
							<div class="rightArea"><a href="javascript:aBM.getActnMngr().doSave('srch')" class="btn_O"><span>저장</span></a></div>
						</div>
						<!-- btnArea//-->
					</c:if>
                </div>	                
	            <h3><a href="#">독립형 여부</a></h3>
				<div class="board">
					<c:if test="${boardVO.mergeType == 'A' && boardVO.boardId == boardVO.boardRid}">
	                    <table cellpadding="0" cellspacing="0" summary="게시판 상세" class="table_board">  
	                    <caption>게시판 상세</caption>
	                        <colgroup>
								<col width="20%"/>
								<col width="80%"/>
	                        </colgroup>
	                        <tbody>   
								<tr>
									<th class="L">독립형 여부</th>
								  	<td class="L">
									    <c:if test="${boardVO.owntblYn == 'N'}">
									      <c:if test="${boardVO.bltnCnt >= 1}">
								            <input type=radio name="actn_owntblYn" value="N" checked>통합형&nbsp;&nbsp;
										  </c:if>
									      <c:if test="${boardVO.bltnCnt < 1}">    
								            <c:forEach items="${indeList}" var="list">
								              <input type=radio name="actn_owntblYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.owntblYn == list.code}">checked</c:if>
											         onclick="aBM.getActnMngr().doSelectOwntblYn(this)">
											  <c:out value="${list.codeName}"/>&nbsp;&nbsp;
								            </c:forEach>
								          </c:if>
								          <select id="actn_owntblFix" style="width:280;display:none"> 
								            <c:forEach items="${tableList}" var="list">
											  <option value="<c:out value="${list.tblFix}"/>" <c:if test="${boardVO.owntblFix == list.tblFix}">selected</c:if>><c:out value="${list.tblDesc}"/>
											</c:forEach>
								          </select>
								        </c:if>	
								        <c:if test="${boardVO.owntblYn == 'Y'}">
									      <c:if test="${boardVO.bltnCnt >= 1}">
								            <input type="radio" name="owntblYn" value="Y" checked>독립형&nbsp;&nbsp;
										  </c:if>
									      <c:if test="${boardVO.bltnCnt < 1}">
								            <c:forEach items="${indeList}" var="list">
								              <input type=radio name="actn_owntblYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.owntblYn == list.code}">checked</c:if>
								         			 onclick="aBM.getActnMngr().doSelectOwntblYn(this)">
											  <c:out value="${list.codeName}"/>&nbsp;&nbsp;
								            </c:forEach>
								          </c:if>
								          <select id="actn_owntblFix" style="width:280" <c:if test="${boardVO.bltnCnt >= 1}">readonly=true</c:if>>
											<c:forEach items="${tableList}" var="list">
											  <option value="<c:out value="${list.tblFix}"/>" <c:if test="${boardVO.owntblFix == list.tblFix}">selected</c:if>><c:out value="${list.tblDesc}"/>
											</c:forEach>
								          </select>
								        </c:if>									        								
								  	</td>					  	
								</tr>
								<tr>
									<td class="L" colspan="2">
										<em>통합형</em> : 게시물이 게시물 통합테이블에 저장됩니다.<br>
										<em>독립형</em> : 게시물이 게시판 전용의 테이블에 저장됩니다.										
									</td>
								</tr>
	                        </tbody>
	                    </table>
	                </c:if>
					<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || sessionScope._user_domain_.domainId == boardVO.domainId}">
						<!-- btnArea-->
						<div class="btnArea">
							<div class="rightArea"><a href="javascript:aBM.getActnMngr().doSave('srch')" class="btn_O"><span>저장</span></a></div>
						</div>
						<!-- btnArea//-->
					</c:if>	                    
                </div>
		   </div>
		<!-- actnAccordion// -->	      