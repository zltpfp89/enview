<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>
		<!-- bojoAccordion -->
		<div id="bojoAccordion">
			<h3><a href="#"><util:message key="eb.title.bojo.prop"/></a></h3>
			<div class="board">
				<c:if test="${empty boardVO || boardVO.boardId == boardVO.boardRid}">
					<table cellpadding="0" cellspacing="0" summary="게시판 상세" class="table_board">
		            <caption>게시판 상세</caption>
		                <colgroup>
							<col width="200px" />
							<col width="*" />
							<col width="*" />					
		                </colgroup>
		                <tbody>
							<c:if test="${boardPropVO.boardId == 'ENBOARD.BASE'}">
								<tr>
								  <td colspan="3"><font color="red"><b>!!<util:message key="eb.info.edit.default"/>!!</b></font></td>
								</tr>
							</c:if>
		               		<%--BEGIN::통합형인 경우에는 게시물에 영향을 미치는 설정은 못하도록 막는다.--%>
		               		<c:if test="${empty boardVO || boardVO.mergeType == 'A'}">
			                	<tr>
			                		<th class="L"><util:message key="eb.title.evaluationLevel"/></th>
			                		<td class="C"><textarea id="bojo_evalLevel" rows="2" class="txtbox"><c:out value="${boardPropVO.evalLevel}"/></textarea></td>
		                       		<td class="L"><util:message key="eb.info.input.evaluationLevel"/>l<br><util:message key="eb.info.evaluationLevel"/></td>
		                       	</tr>
							    <tr>
									<th class="L"><util:message key="eb.title.timesLimit.best"/></th>
									<td class="C"><textarea id="bojo_bestLimit" rows="2" class="txtbox"><c:out value="${boardPropVO.bestLimit}"/></textarea></td>
									<td class="L"><util:message key="eb.info.input.timesLimit.best"/></td>
								</tr>
								<tr>
									<th class="L"><util:message key="eb.title.AttachmentfileExtension"/></th>
									<td class="C"><textarea id="bojo_extMask" rows="2" class="txtbox"><c:out value="${boardPropVO.extMask}"/></textarea></td>
									<td class="L"><util:message key="eb.info.input.AttachmentfileExtension"/></td>
								</tr>
								<tr>
									<th class="L"><util:message key="eb.title.NoAttachmentfileExtension"/></th>
									<td class="C"><textarea id="bojo_badExtMask" rows="2" class="txtbox"><c:out value="${boardPropVO.badExtMask}"/></textarea></td>
									<td class="L"><util:message key="eb.info.input.NoAttachmentfileExtension"/></td>
								</tr>							
		               		</c:if>
		               		<%--END::통합형인 경우에는 게시물에 영향을 미치는 설정은 못하도록 막는다.--%>
							<tr>
								<th class="L"><util:message key="eb.title.accessible.IP"/></th>
								<td class="C"><textarea id="bojo_acceptIp" rows="2" class="txtbox"><c:out value="${boardPropVO.acceptIp}"/></textarea></td>
								<td class="L"><util:message key="eb.info.input.accessible.IP"/></td>
							</tr>
							<tr>
								<th class="L"><util:message key="eb.title.accessible.ID"/></th>
								<td class="C"><textarea id="bojo_acceptId" rows="2" class="txtbox"><c:out value="${boardPropVO.acceptId}"/></textarea></td>
								<td class="L"><util:message key="eb.info.input.accessible.ID"/></td>
							</tr>
							<tr>
								<th class="L"><util:message key="eb.title.interruptAccess.IP"/></th>
								<td class="C"><textarea id="bojo_badIp" rows="2" class="txtbox"><c:out value="${boardPropVO.badIp}"/></textarea></td>
								<td class="L"><util:message key="eb.info.input.interruptAccess.IP"/></td>
							</tr>
							<tr>
								<th class="L"><util:message key="eb.title.interruptAccess.ID"/></th>
								<td class="C"><textarea id="bojo_badId" rows="2" class="txtbox"><c:out value="${boardPropVO.badId}"/></textarea></td>
								<td class="L"><util:message key="eb.info.input.interruptAccess.ID"/></td>
							</tr>
							<%--BEGIN::통합형인 경우에는 게시물에 영향을 미치는 설정은 못하도록 막는다.--%>
							<c:if test="${empty boardVO || boardVO.mergeType == 'A'}">
								<tr>
									<th class="L"><util:message key="eb.prop.forbidden.inputWord.nickname"/></th>
									<td class="C"><textarea id="bojo_badNick" rows="3" class="txtbox"><c:out value="${boardPropVO.badNickDflt}"/></textarea></td>
									<td class="L"><util:message key="eb.info.input.forbidden.inputWord"/><br>>util:message key=""/>eb.info.input.forbidden.inputWord.example</td>
								</tr>
								<tr>
									<th class="L"><util:message key="eb.prop.forbidden.inputWord.title"/></th>
									<td class="C"><textarea id="bojo_badCntt" rows="3" class="txtbox"><c:out value="${boardPropVO.badCnttDflt}"/></textarea></td>
									<td class="L"><util:message key="eb.info.input.forbidden.inputWord.title"/><br><util:message key="eb.info.input.forbidden.inputWord.title.exmpale"/></td>
								</tr>
								<tr>
									<th class="L"><util:message key="eb.prop.limit.repeatInput"/></th>
									<td class="C"><input type="text" id="bojo_inputTerm" value="<c:out value="${boardPropVO.inputTerm}"/>" maxlength="4" class="txt_100">&nbsp;<span class="sel_txt"><util:message key="ev.prop.second"/></span></td>
									<td class="L"><util:message key="eb.prop.limit.repeatInput.example"/></td>
								</tr>
								<tr>
									<th class="L"><util:message key="eb.prop.forbidden.inputWord.NicknameYN"/></th>
									<td class="C" colspan=2>
										<c:forEach items="${radioList}" var="list">
											<input type=radio name="bojo_badNickYn" value="<c:out value="${list.code}"/>" <c:if test="${boardPropVO.badNickYn == list.code}">checked</c:if>>
											<label>&nbsp;<c:out value="${list.codeName}"/></label>&nbsp;&nbsp;
										</c:forEach>
									</td>
								</tr>
								<tr>
									<th class="L"><util:message key="eb.prop.forbidden.inputWordYN"/></th>
									<td class="C" colspan=2>
										<c:forEach items="${radioList}" var="list">
											<input type=radio name="bojo_badCnttYn" value="<c:out value="${list.code}"/>" <c:if test="${boardPropVO.badCnttYn == list.code}">checked</c:if>>
											<label>&nbsp;<c:out value="${list.codeName}"/></label>&nbsp;&nbsp;
										</c:forEach>
									</td>
								</tr>
							</c:if>						
							<%--END::통합형인 경우에는 게시물에 영향을 미치는 설정은 못하도록 막는다.--%>				
		                </tbody>
					</table>
		    	</c:if>
				<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || sessionScope._user_domain_.domainId == boardVO.domainId}">
					<!-- btnArea-->
					<div class="btnArea">
						<div id="bojo_restore" class="fl"><a href="javascript:aBM.getBojoMngr().doRestore()" class="btn_B"><span><util:message key="eb.info.restorationDefault"/></span></a></div>
						<div class="rightArea">
							<a href="javascript:aBM.getBojoMngr().doUpdateDef()" class="btn_B"><span><util:message key="eb.info.editDefault"/></span></a>
							<a href="javascript:aBM.getBojoMngr().doSave('prop')" class="btn_O"><span><util:message key="ev.title.save"/></span></a>
						</div>
					</div>
					<!-- btnArea//-->				
				</c:if>
			</div>    	
	        <h3><a href="#"><util:message key="eb.info.set.forbidden.inputWord"/></a></h3>
	        	<div class="board">
				<table cellpadding="0" cellspacing="0" summary="게시판 상세" class="table_board">
	            <caption>게시판 상세</caption>
	                <colgroup>
						<col width="*" />					
	                </colgroup>
	                <tbody>
						<tr>
							<td><util:message key="eb.info.input.set.forbidden.inputWord"/></td>
						</tr>
						<tr>
			   				<td><textarea id="bojo_badCnttCommon" rows="10" style="width:97%" class="txtbox"><c:out value="${boardPropVO.badCnttCommonDflt}"/></textarea></td>			
						</tr>
	                </tbody>
				</table>
				<!-- btnArea-->
				<div class="btnArea">
					<div class="rightArea">
						<a href="javascript:aBM.getBojoMngr().doSave('cntt')" class="btn_B"><span><util:message key="ev.title.save"/></span></a>
					</div>
				</div>
				<!-- btnArea//-->
			</div>
		</div>
		<!-- bojoAccordion// -->