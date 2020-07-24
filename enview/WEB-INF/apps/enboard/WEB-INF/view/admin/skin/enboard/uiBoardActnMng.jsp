<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>
		<!-- actnAccordion -->
		<div id="actnAccordion">
			<h3><a href="#"><util:message key="eb.prop.boardType"/></a></h3>
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
                                <th class="L" rowspan="2"><util:message key="eb.prop.boardType"/></th>
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
                                <td class="L">
										<c:forEach items="${typeList}" var="list" varStatus="status">
										<c:if test="${not empty list.remark }">
										- <em><c:out value="${list.codeName}"/></em> : <c:out value="${list.remark}"/>${status.last ? '' : '<br/>'}
										</c:if>
										</c:forEach>
								</td>
                           </tr>
                            <tr>
                                <th class="L" rowspan="2"><util:message key="ev.title.integrated.board"/> <util:message key="ev.title.type"/></th>
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
										<c:forEach items="${mergeList}" var="list" varStatus="status">
										<c:if test="${not empty list.remark }">
										- <em>  <c:out value="${list.codeName}"/></em> : <c:out value="${list.remark}"/>${status.last ? '' : '<br/>'}
										</c:if>
										</c:forEach>
                                </td>
                           </tr>
                        </tbody>
                    </table>
                </c:if>
				<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || sessionScope._user_domain_.domainId == boardVO.domainId}">		
					<!-- btnArea-->
					<div class="btnArea">
						<div class="rightArea">
							<a href="javascript:aBM.getActnMngr().doSave('type')" class="btn_O"><span><util:message key="cf.title.save"/></span></a>
							<a href="javascript:aBM.getActnMngr().doSave('tmpl')" class="btn_O"><span><util:message key="cf.prop.template.apply"/></span></a>
						</div>
					</div>
					<!-- btnArea//-->
				</c:if>	                    
               </div>	                
	            <h3><a href="#"><util:message key="ev.title.basicFunction"/></a></h3>
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
									<c:if test="${not useMemoFile}">
										<tr>
											<th class="L"><util:message key="eb.title.attachment.MaxNumber"/></th>
										  	<td class="L" colspan="3"><input type=text id="actn_maxFileCnt" maxlength=2 value="<c:out value="${boardVO.maxFileCnt}"/>" class="txt_100">&nbsp;0: <util:message key="eb.info.unused.attachment"/></td>
										</tr>
										<tr>
										 	<th class="L"><util:message key="eb.title.attachment.MaxSize"/></th>
										  	<td class="L" colspan="3"><input type=text id="actn_maxFileSize" maxlength=10 value="<c:out value="${boardVO.maxFileSize}"/>" class="txt_100">&nbsp;<util:message key="eb.info.unit"/> : Byte</td>
										</tr>
									</c:if>
									<c:if test="${useMemoFile}">
										<tr>
											<th class="L"><util:message key="eb.title.attachment.MaxNumber"/></th>
										  	<td class="L"><input type=text id="actn_maxFileCnt" maxlength=2 value="<c:out value="${boardVO.maxFileCnt}"/>" class="txt_100">&nbsp;0: <util:message key="eb.info.unused.attachment"/></td>
											<th class="L"><util:message key="eb.title.memo.attachment.MaxNumber"/></th>
										  	<td class="L"><input type=text id="actn_maxMemoFileCnt" maxlength=2 value="<c:out value="${boardVO.maxMemoFileCnt}"/>" class="txt_100">&nbsp;0: <util:message key="eb.info.unused.attachment"/></td>
										</tr>
										<tr>
										 	<th class="L"><util:message key="eb.title.attachment.MaxSize"/></th>
										  	<td class="L"><input type=text id="actn_maxFileSize" maxlength=10 value="<c:out value="${boardVO.maxFileSize}"/>" class="txt_100">&nbsp;<util:message key="eb.info.unit"/> : Byte</td>
										 	<th class="L"><util:message key="eb.title.memo.attachment.MaxSize"/></th>
										  	<td class="L"><input type=text id="actn_maxMemoFileSize" maxlength=10 value="<c:out value="${boardVO.maxMemoFileSize}"/>" class="txt_100">&nbsp;<util:message key="eb.info.unit"/> : Byte</td>
										</tr>
									</c:if>
									<tr>
									  	<th class="L"><util:message key="eb.title.attachment.downloadLimit"/></th>
									  	<td class="L" colspan="3"><input type=text id="actn_maxFileDown" maxlength=3 value="<c:out value="${boardVO.maxFileDown}"/>" class="txt_100">&nbsp;0: <util:message key="ev.prop.unlimited"/></td>
									</tr>
								</c:if>
								<%--END::통합형인 경우에는 게시물에 영향을 미치는 속성의 설정기능을 막는다.--%>
								<tr>
									<th class="L"><util:message key="cf.prop.badStdCnt"/></th>
									<td class="L"><input type=text id="actn_badStdCnt" maxlength=4 value="<c:out value="${boardVO.badStdCnt}"/>" class="txt_100"></td>
									<th class="L"><util:message key="eb.title.Function.reply"/></th>
									<td class="L">
									     <c:forEach items="${radioList}" var="list">
											<input type=radio name="actn_replyYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.replyYn==list.code}">checked</c:if>>
											<c:out value="${list.codeName}"/>&nbsp;&nbsp;
									     </c:forEach>
									</td>
								</tr>
								<tr>
									<th class="L"><util:message key="eb.title.Function.comment"/></th>
									<td class="L">
										<c:forEach  items="${radioList}" var="list">
											<input type=radio name="actn_memoYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.memoYn==list.code}">checked</c:if>>
											<c:out value="${list.codeName}"/>&nbsp;&nbsp;
										</c:forEach>
									</td>
									<th class="L"><util:message key="eb.title.Function.comment.reply"/></th>
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
										<th class="L"><util:message key="eb.title.Function.secret"/></th>
										<td class="L">
											<c:forEach  items="${radioList}" var="list">
										  		<input type=radio name="actn_secretYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.secretYn==list.code}">checked</c:if>>
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;
											</c:forEach>
										</td>
										<th class="L"><util:message key="eb.title.Function.anonym"/></th>
										<td class="L">
											<c:forEach  items="${radioList}" var="list">
										  		<input type=radio name="actn_ableAnonYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.ableAnonYn==list.code}">checked</c:if>>
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;
											</c:forEach>
										</td>
									</tr>
									<tr>
										<th class="L"><util:message key="eb.title.Function.anonym.board"/></th>
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
										<th class="L"><util:message key="eb.title.Fuction.set.Openperiod"/></th>
										<td class="L">
											<c:forEach  items="${radioList}" var="list">
												<input type=radio name="actn_termYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.termYn==list.code}">checked</c:if>
									       		onclick="aBM.getActnMngr().doSelectTermYn(this)">
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;
									       	</c:forEach>
									  	</td>
									  	<th class="L"><util:message key="eb.title.Fuction.category"/></th>
									  	<td class="L">
									       	<c:forEach  items="${radioList}" var="list">
												<input type=radio name="actn_cateYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.cateYn==list.code}">checked</c:if>>
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;
									       	</c:forEach>
									  	</td>
									</tr>
									<tr>
									  	<th class="L"><util:message key="eb.title.Fuction.ExtendedField"/></th>
									  	<td class="L">
									       	<c:forEach  items="${radioList}" var="list">
										    	<input type=radio name="actn_extUseYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.extUseYn==list.code}">checked</c:if>
										       onclick="aBM.getActnMngr().doSelectExtUseYn(this)">
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;
									       	</c:forEach>
									  	</td>
									  	<th class="L"><util:message key="eb.title.Function.Accessauthority"/></th>
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
									<td class="L"><util:message key="eb.title.Type.set.Openperiod"/></td>
								  	<td class="L" colspan="3">
										<c:forEach  items="${termList}" var="list">
											<input type=radio name="actn_termFlag" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.termFlag==list.code}">checked</c:if>>
											<c:out value="${list.codeName}"/>&nbsp;&nbsp;
										</c:forEach>
								  	</td>
								</tr>
								<tr id="extUseTr" name="extUseTr" <c:if test="${boardVO.extUseYn=='N'}">style="display:none"</c:if>>
								  	<th class="L"><util:message key="eb.info.Class.ExtendedField"/></th>
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
							<div class="rightArea"><a href="javascript:aBM.getActnMngr().doSave('func')" class="btn_O"><span><util:message key="cf.title.save"/></span></a></div>
						</div>
						<!-- btnArea//-->
					</c:if>	                    
                </div>	                
	            <h3><a href="#"><util:message key="ev.title.additionalFunction"/></a></h3>
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
										<th class="L"><util:message key="eb.title.Fuction.MarkDelete"/></th>
									  	<td class="L" colspan="3">
											<c:forEach items="${radioList}" var="list">
												<input type=radio name="actn_delFlagYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.delFlagYn==list.code}">checked</c:if>>
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;
											</c:forEach>	  		
											<c:if test="${langKnd=='ko' }">(사용: 게시물 삭제 시 실제로 DB에서 삭제되지 않고 '삭제' 표시만 함.)	</c:if>
											<c:if test="${langKnd!='ko' }">(Use: When deleting a post, it is not actually deleted from the DB, but marked as deleted.)	</c:if>
									  	</td>
									</tr>
									<tr>
									 	<th class="L"><util:message key="eb.title.policy.delete"/></th>
									  	<td class="L" colspan="3">
											<c:forEach items="${orgDelList}" var="list">
												<input type=radio name="actn_orgDelYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.orgDelYn==list.code}">checked</c:if>>
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;
											</c:forEach>
											<input type=hidden id="reserve_orgDelYn" value="<c:out value="${boardVO.orgDelYn}"/>"/>										  		
									  	</td>
									</tr>
									<tr>
									  	<th class="L"><util:message key="eb.title.Function.notice"/></th>
									  	<td class="L">
											<c:forEach  items="${radioList}" var="list">
												<input type=radio name="actn_noticeYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.noticeYn==list.code}">checked</c:if>>
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;
											</c:forEach>										  	
									  	</td>
									  	<th class="L"><util:message key="eb.title.Function.approval"/></th>
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
									 	<th class="L"><util:message key="eb.title.Function.notice"/></th>
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
									 	<th class="L"><util:message key="eb.title.Function.recommendation"/></th>
									  	<td class="L">
											<c:forEach  items="${radioList}" var="list">
												<input type=radio name="actn_rcmdYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.rcmdYn==list.code}">checked</c:if>>
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;
											</c:forEach>										  		
									  	</td>
									 	<th class="L"><util:message key="eb.title.Function.Test"/></th>
									  	<td class="L">
											<c:forEach  items="${radioList}" var="list">
												<input type=radio name="actn_evalYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.evalYn==list.code}">checked</c:if>>
												<c:out value="${list.codeName}"/>&nbsp;&nbsp;
											</c:forEach>										  		
									  	</td>										  	
									</tr>
								</c:if>
								<tr>
								 	<th class="L"><util:message key="eb.title.Function.attendance"/></th>
								  	<td class="L">
										<c:forEach  items="${radioList}" var="list">
											<input type=radio name="actn_attnYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.attnYn==list.code}">checked</c:if>>
											<c:out value="${list.codeName}"/>&nbsp;&nbsp;
										</c:forEach>										  		
								  	</td>
								 	<th class="L"><util:message key="eb.title.Function.inform.reply"/></th>
								  	<td class="L">
										<c:forEach  items="${radioList}" var="list">
											<input type=radio name="actn_snntYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.snntYn==list.code}">checked</c:if>>
											<c:out value="${list.codeName}"/>&nbsp;&nbsp;
										</c:forEach>									  		
								  	</td>										  	
								</tr>
								<tr>
								 	<th class="L"><util:message key="eb.title.Function.connectBoard"/></th>
								  	<td class="L">
										<c:forEach  items="${radioList}" var="list">
											<input type=radio name="actn_subBrdYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.subBrdYn==list.code}">checked</c:if>>
											<c:out value="${list.codeName}"/>&nbsp;&nbsp;
										</c:forEach>						  		
								  	</td>
								 	<th class="L"><util:message key="eb.title.Function.report.badComment"/></th>
								  	<td class="L">
										<c:forEach  items="${radioList}" var="list">
											<input type=radio name="actn_memoBadYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.memoBadYn==list.code}">checked</c:if>>
											<c:out value="${list.codeName}"/>&nbsp;&nbsp;
										</c:forEach>									  		
								  	</td>										  	
								</tr>
								<tr>
								 	<th class="L"><util:message key="eb.title.UseGrade.check"/></th>
								  	<td class="L">
										<c:forEach  items="${radioList}" var="list">
											<input type=radio name="actn_grdAuthYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.grdAuthYn==list.code}">checked</c:if>>
											<c:out value="${list.codeName}"/>&nbsp;&nbsp;
										</c:forEach>	
								  	</td>
								 	<th class="L"><util:message key="eb.title.UserGrade.check"/></th>
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
								 	<th class="L"><util:message key="eb.title.Function.report.badNotice"/></th>
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
							<div class="rightArea"><a href="javascript:aBM.getActnMngr().doSave('buga')" class="btn_O"><span><util:message key="cf.title.save"/></span></a></div>
						</div>
						<!-- btnArea//-->
					</c:if>	                    
                </div>	                
	           	<h3><a href="#"><util:message key="eb.title.SearchField"/></a></h3>
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
								<th class="L"><util:message key="cf.title.nick"/></th>
							  	<td class="L">
									<c:forEach  items="${radioList}" var="list">
										<input type=radio name="actn_srchNickYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.srchNickYn==list.code}">checked</c:if>>
										<c:out value="${list.codeName}"/>&nbsp;&nbsp;
									</c:forEach>
							  	</td>
								<th class="L"><util:message key="eb.info.ttl.bltnSubj"/></th>
							  	<td class="L">
									<c:forEach  items="${radioList}" var="list">
										<input type=radio name="actn_srchSubjYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.srchSubjYn==list.code}">checked</c:if>>
										<c:out value="${list.codeName}"/>&nbsp;&nbsp;
									</c:forEach>											
							  	</td>					  	
							</tr>
							<tr>
								<th class="L"><util:message key="eb.info.ttl.bltnCntt"/></th>
							  	<td class="L">
									<c:forEach  items="${radioList}" var="list">
										<input type=radio name="actn_srchCnttYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.srchCnttYn==list.code}">checked</c:if>>
										<c:out value="${list.codeName}"/>&nbsp;&nbsp;
									</c:forEach>											
							  	</td>
								<th class="L"><util:message key="eb.title.attachmentName"/></th>
							  	<td class="L">
									<c:forEach  items="${radioList}" var="list">
										<input type=radio name="actn_srchAtchYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.srchAtchYn==list.code}">checked</c:if>>
										<c:out value="${list.codeName}"/>&nbsp;&nbsp;
									</c:forEach>																						
							  	</td>					  	
							</tr>
							<tr>
								<th class="L"><util:message key="eb.title.dateOfpreparation"/></th>
							  	<td class="L">
									<c:forEach  items="${radioList}" var="list">
										<input type=radio name="actn_srchRegYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.srchRegYn==list.code}">checked</c:if>>
										<c:out value="${list.codeName}"/>&nbsp;&nbsp;
									</c:forEach>											
							  	</td>
								<th class="L"><util:message key="eb.title.replyYn"/></th>
							  	<td class="L">
									<c:forEach  items="${radioList}" var="list">
										<input type=radio name="actn_srchReplyYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.srchReplyYn==list.code}">checked</c:if>>
										<c:out value="${list.codeName}"/>&nbsp;&nbsp;
									</c:forEach>														
							  	</td>
							</tr>
							<tr>
								<th class="L"><util:message key="eb.title.commentYn"/></th>
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
							<div class="rightArea"><a href="javascript:aBM.getActnMngr().doSave('srch')" class="btn_O"><span><util:message key="cf.title.save"/></span></a></div>
						</div>
						<!-- btnArea//-->
					</c:if>
                </div>	                
	            <h3><a href="#"><util:message key="eb.title.aloneTypeYn"/></a></h3>
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
									<th class="L"><util:message key="eb.title.aloneTypeYn"/></th>
								  	<td class="L">
									    <c:if test="${boardVO.owntblYn == 'N'}">
									      <c:if test="${boardVO.bltnCnt >= 1}">
								            <input type=radio name="actn_owntblYn" value="N" checked><util:message key="eb.prop.integratedType"/>&nbsp;&nbsp;
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
								            <input type="radio" name="owntblYn" value="Y" checked><util:message key="eb.prop.aloneType"/>&nbsp;&nbsp;
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
										<c:forEach items="${indeList}" var="list" varStatus="status">
										<c:if test="${not empty list.remark }">
										- <em><c:out value="${list.codeName}"/></em> : <c:out value="${list.remark}"/>${status.last ? '' : '<br/>'}
										</c:if>
										</c:forEach>
									</td>
								</tr>
	                        </tbody>
	                    </table>
	                </c:if>
					<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || sessionScope._user_domain_.domainId == boardVO.domainId}">
						<!-- btnArea-->
						<div class="btnArea">
							<div class="rightArea"><a href="javascript:aBM.getActnMngr().doSave('srch')" class="btn_O"><span><util:message key="ev.title.save"/></span></a></div>
						</div>
						<!-- btnArea//-->
					</c:if>	                    
                </div>
		   </div>
		<!-- actnAccordion// -->	      