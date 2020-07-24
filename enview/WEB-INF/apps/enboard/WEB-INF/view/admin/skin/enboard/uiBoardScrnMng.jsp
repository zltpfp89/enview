<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>
		<!-- scrnAccordion -->
		<div id="scrnAccordion">
			<h3><a href="#"><util:message key="ev.title.basicSetting"/></a></h3>
			<div class="board">
	            <table cellpadding="0" cellspacing="0" summary="게시판 상세" class="table_board">  
	            <caption>게시판 상세</caption>
	                <colgroup>
						<col width="28%" />
						<col width="*" />
						<col width="28%" />
						<col width="*" />						
	                </colgroup>
	                <tbody>
	                	<tr>
	                		<th class="L"><util:message key="ev.title.selectSkin"/></th>
	                		<td class="L" colspan="3">
	                            <div class="sel_100">
	                                <select id="scrn_boardSkin" class="txt_100">
										<c:forEach items="${fileList}" var="list">
											<option value="<c:out value="${list.code}"/>" <c:if test="${boardVO.boardSkin == list.code}">selected</c:if>><c:out value="${list.codeName}"/>
										</c:forEach>
	                                </select>
	                            </div>
                       		</td>
                       	</tr>
	                	<tr>
	                		<th class="L"><util:message key="eb.title.listScren.listCount"/></th>
	                		<td class="L">
	                            <input type=text id="scrn_listSetCnt" maxlength=4 class="txt_100" value="<c:out value="${boardVO.listSetCnt}"/>">
                       		</td>
	                		<th class="L"><util:message key="eb.title.newTerm"/></th>
	                		<td class="L">
	                            <input type=text id="scrn_newTerm" maxlength=4 class="txt_100" value="<c:out value="${boardVO.newTerm}"/>">
		 						<input type=hidden id="scrn_mergeType" value="<c:out value="${boardVO.mergeType}"/>"/>
                       		</td>                       		
                       	</tr>
	                	<tr>
	                		<th class="L"><util:message key="eb.title.raiseCnt"/></th>
	                		<td class="L">
	                            <input type=text id="scrn_raiseCnt" maxlength=4 class="txt_100" value="<c:out value="${boardVO.raiseCnt}"/>">
                       		</td>
	                		<th class="L"><util:message key="eb.title.raiseCnt.Color"/></th>
	                		<td class="L">
	                            <input type=text id="scrn_raiseColor" maxlength=10 class="txt_100" value="<c:out value="${boardVO.raiseColor}"/>">
                       		</td>                       		
                       	</tr>
	                	<tr>
	                		<th class="L"><util:message key="eb.title.boardWidth"/></th>
	                		<td class="L">
	                            <input type=text id="scrn_boardWidth" maxlength=10 class="txt_100" value="<c:out value="${boardVO.boardWidth}"/>">
                       		</td>
	                		<th class="L"><util:message key="eb.title.board.BackgroundColor"/></th>
	                		<td class="L">
	                            <input type=text id="scrn_boardBgColor" maxlength=10 class="txt_100" value="<c:out value="${boardVO.boardBgColor}"/>">
                       		</td>                       		
                       	</tr>
	                	<tr>
	                		<th class="L"><util:message key="eb.title.board.BackgroundImg"/></th>
	                		<td class="L" colspan="3">
	                            <input type=text id="scrn_boardBgPic" class="txt_100" maxlength=100 value="<c:out value="${boardVO.boardBgPic}"/>">
		  						&nbsp;&nbsp;<util:message key="eb.info.input.ImgFileName"/>
                       		</td>                     		
                       	</tr>
	                	<tr>
	                		<th class="L"><util:message key="eb.title.top.HTML"/></th>
	                		<td class="L" colspan="3">
	                            <input type=text id="scrn_topHtml" style="width:100%" maxlength=100 value="<c:out value="${boardVO.topHtml}"/>">
                       		</td>                     		
                       	</tr>
	                	<tr>
	                		<th class="L"><util:message key="eb.title.bottom.HTML"/></th>
	                		<td class="L" colspan="3">
	                            <input type=text id="scrn_bottomHtml" style="width:100%" maxlength=100 value="<c:out value="${boardVO.bottomHtml}"/>">
                       		</td>                     		
                       	</tr>
						<tr>
	                		<th class="L"><util:message key="eb.title.miniBoard.target.window"/></th>
	                		<td class="L" colspan="3">
	                            <div class="sel_100">
	                                <select id="scrn_miniTrgtWin" style="width:120" onchange="aBM.getScrnMngr().doSelectMiniTrgtWin()" class="txt_100">
							            <c:if test="${boardVO.miniTrgtWin == 'popup' || boardVO.miniTrgtWin == '_top' 
								                   || boardVO.miniTrgtWin == '_parent' || boardVO.miniTrgtWin == '_self'}">
											<c:forEach items="${miniWinList}" var="win"> 
							                	<option value="<c:out value="${win.code}"/>" <c:if test="${win.code == boardVO.miniTrgtWin}">selected</c:if>><c:out value="${win.codeName}"/>
							              	</c:forEach>
							            </c:if>
							            <c:if test="${boardVO.miniTrgtWin != 'popup' && boardVO.miniTrgtWin != '_top' 
								                   && boardVO.miniTrgtWin != '_parent' && boardVO.miniTrgtWin != '_self'}">
								            <c:forEach items="${miniWinList}" var="win"> 
							                	<option value="<c:out value="${win.code}"/>" <c:if test="${win.code == 'xxxxx'}">selected</c:if>><c:out value="${win.codeName}"/>
							                </c:forEach>
							            </c:if>					            
	                                </select>                
	                            </div>
	                            <input type="text" id="scrn_miniWinInput" style="width:240" value="<c:out value="${boardVO.miniTrgtWin}"/>"
									<c:if test="${boardVO.miniTrgtWin == 'popup' || boardVO.miniTrgtWin == '_top' 
									           || boardVO.miniTrgtWin == '_parent' || boardVO.miniTrgtWin == '_self'}">disabled</c:if>
								>	
	                		</td>                     		
                       	</tr>
	                	<tr>
	                		<th class="L"><util:message key="eb.title.miniBoard.target.URL"/></th>
	                		<td class="L" colspan="3">
	                            <input type=text id="scrn_miniTrgtUrl" style="width:100%" maxlength=100 value="<c:out value="${boardVO.miniTrgtUrl}"/>">
                       		</td>                     		
                       	</tr>                       	
	                </tbody>
	            </table>
				<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || sessionScope._user_domain_.domainId == boardVO.domainId}">				
					<!-- btnArea-->
					<div class="btnArea">
						<div class="rightArea"><a href="javascript:aBM.getScrnMngr().doSave('base')" class="btn_O"><span><util:message key="ev.title.save"/></span></a></div>
					</div>
					<!-- btnArea//-->
				</c:if>	            
			</div>
			<h3><a href="#"><util:message key="eb.prop.listScreen.columYN"/></a></h3>
			<div class="board">
	            <table cellpadding="0" cellspacing="0" summary="게시판 상세" class="table_board">  
	            <caption>게시판 상세</caption>
	                <colgroup>
						<col width="200px" />
						<col width="*" />
						<col width="200px" />
						<col width="*" />						
	                </colgroup>
	                <tbody>
	                	<tr>
	                		<th class="L"><util:message key="eb.title.boardNum.colum"/></th>
	                		<td class="L">
								<c:forEach items="${radioList}" var="list" varStatus="status">
									<input type="radio" id="scrn_ttlNoYn_${ status.index}" name="scrn_ttlNoYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.ttlNoYn==list.code}">checked</c:if> />
									<label for="scrn_ttlNoYn_${ status.index}"><c:out value="${list.codeName}"/></label>
								</c:forEach>
                       		</td>
	                		<th class="L"><util:message key="eb.title.thumImg.colum"/></th>
	                		<td class="L">
								<c:forEach items="${radioList}" var="list" varStatus="status">
									<input type="radio" id="scrn_ttlThumbYn_${ status.index}" name="scrn_ttlThumbYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.ttlThumbYn==list.code}">checked</c:if> />
									<label for="scrn_ttlThumbYn_${ status.index}"><c:out value="${list.codeName}"/></label>
								</c:forEach>
                       		</td>                       		
                       	</tr>
	                	<tr>
	                		<th class="L"><util:message key="eb.title.category.colum"/></th>
	                		<td class="L">
								<c:forEach items="${radioList}" var="list" varStatus="status">
									<input type="radio" id="scrn_ttlCateYn_${ status.index}" name="scrn_ttlCateYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.ttlCateYn==list.code}">checked</c:if> />
									<label for="scrn_ttlCateYn_${ status.index}"><c:out value="${list.codeName}"/></label>
								</c:forEach>
                       		</td>
	                		<th class="L"><util:message key="eb.title.icon.colum"/></th>
	                		<td class="L">
								<c:forEach items="${radioList}" var="list" varStatus="status">
									<input type="radio" id="scrn_ttlIconYn_${ status.index}" name="scrn_ttlIconYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.ttlIconYn==list.code}">checked</c:if> />
									<label for="scrn_ttlIconYn_${ status.index}"><c:out value="${list.codeName}"/></label>
								</c:forEach>
                       		</td>                       		
                       	</tr>
	                	<tr>
	                		<th class="L"><util:message key="eb.title.express.icon"/></th>
	                		<td class="L">
								<c:forEach items="${radioList}" var="list" varStatus="status">
									<input type="radio" id="scrn_ttlNewYn_${ status.index}" name="scrn_ttlNewYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.ttlNewYn==list.code}">checked</c:if> />
									<label for="scrn_ttlNewYn_${ status.index}"><c:out value="${list.codeName}"/></label>
								</c:forEach>
                       		</td>
	                		<th class="L"><util:message key="eb.title.express.replyCount"/></th>
	                		<td class="L">
								<c:forEach items="${radioList}" var="list" varStatus="status">
									<input type="radio" id="scrn_ttlReplyYn_${ status.index}" name="scrn_ttlReplyYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.ttlReplyYn==list.code}">checked</c:if> />
									<label for="scrn_ttlReplyYn_${ status.index}"><c:out value="${list.codeName}"/></label>
								</c:forEach>
                       		</td>                       		
                       	</tr>
	                	<tr>
	                		<th class="L"><util:message key="eb.title.express.commentCount"/></th>
	                		<td class="L">
								<c:forEach items="${radioList}" var="list" varStatus="status">
									<input type="radio" id="scrn_ttlMemoYn_${ status.index}" name="scrn_ttlMemoYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.ttlMemoYn==list.code}">checked</c:if> />
									<label for="scrn_ttlMemoYn_${ status.index}"><c:out value="${list.codeName}"/></label>
								</c:forEach>
                       		</td>
	                		<th class="L"><util:message key="eb.title.express.point"/></th>
	                		<td class="L">
								<c:forEach items="${radioList}" var="list" varStatus="status">
									<input type="radio" id="scrn_ttlPntYn_${ status.index}" name="scrn_ttlPntYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.ttlPntYn==list.code}">checked</c:if> />
									<label for="scrn_ttlPntYn_${ status.index}"><c:out value="${list.codeName}"/></label>
								</c:forEach>
                       		</td>                       		
                       	</tr>
	                	<tr>
	                		<th class="L"><util:message key="eb.title.writerName.colum"/></th>
	                		<td class="L">
								<c:forEach items="${radioList}" var="list" varStatus="status">
									<input type="radio" id="scrn_ttlNickYn_${ status.index}" name="scrn_ttlNickYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.ttlNickYn==list.code}">checked</c:if> />
									<label for="scrn_ttlNickYn_${ status.index}"><c:out value="${list.codeName}"/></label>
								</c:forEach>
                       		</td>
	                		<th class="L"><util:message key="eb.title.reportingDate.colum"/></th>
	                		<td class="L">
								<c:forEach items="${radioList}" var="list" varStatus="status">
									<input type="radio" id="scrn_ttlRegYn_${ status.index}" name="scrn_ttlRegYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.ttlRegYn==list.code}">checked</c:if> />
									<label for="scrn_ttlRegYn_${ status.index}"><c:out value="${list.codeName}"/></label>
								</c:forEach>
                       		</td>
                       	</tr>
	                	<tr>
	                		<th class="L"><util:message key="ev.title.readCount.column"/></th>
	                		<td class="L" colspan="3">
								<c:forEach items="${radioList}" var="list" varStatus="status">
									<input type="radio" id="scrn_ttlReadYn_${ status.index}" name="scrn_ttlReadYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.ttlReadYn==list.code}">checked</c:if> />
									<label for="scrn_ttlReadYn_${ status.index}"><c:out value="${list.codeName}"/></label>
								</c:forEach>
                       		</td>                       		
                       	</tr>                         	                    	
	                </tbody>
	            </table>
				<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || sessionScope._user_domain_.domainId == boardVO.domainId}">
					<!-- btnArea-->
					<div class="btnArea">
						<div class="rightArea"><a href="javascript:aBM.getScrnMngr().doSave('ttl')" class="btn_O"><span><util:message key="ev.title.save"/></span></a></div>
					</div>
					<!-- btnArea//-->
				</c:if>	            
			</div>
			<h3><a href="#"><util:message key="eb.title.listScreen.columLength"/></a></h3>
			<div class="board">
	            <table cellpadding="0" cellspacing="0" summary="게시판 상세" class="table_board">  
	            <caption>게시판 상세</caption>
	                <colgroup>
						<col width="200px" />
						<col width="*" />
						<col width="200px" />
						<col width="*" />						
	                </colgroup>
	                <tbody>
	                	<tr>
	                		<th class="L"><util:message key="eb.title.title.columLength"/></th>
	                		<td class="L" colspan="3">
								<input type=text id="scrn_subjSize" value="<c:out value="${boardVO.subjSize}"/>" maxlength="4">
                       		</td>                      		
                       	</tr>
                       	<tr>
	                		<th class="L"><util:message key="eb.title.writerName.columLength"/></th>
	                		<td class="L" colspan="3">
								<input type=text id="scrn_nickSize" value="<c:out value="${boardVO.nickSize}"/>" maxlength="4">
                       		</td>                        	
                       	</tr>
                       	<tr>
	                		<th class="L"><util:message key="eb.title.thumLength"/></th>
	                		<td class="L" colspan="3">
								<input type=text id="scrn_thumbSize" value="<c:out value="${boardVO.thumbSize}"/>" maxlength="4">
                       		</td>                        	
                       	</tr>                       	                   	                    	
	                </tbody>
	            </table>
				<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || sessionScope._user_domain_.domainId == boardVO.domainId}">
					<!-- btnArea-->
					<div class="btnArea">
						<div class="rightArea"><a href="javascript:aBM.getScrnMngr().doSave('size')" class="btn_O"><span><util:message key="ev.title.save"/></span></a></div>
					</div>
					<!-- btnArea//-->
				</c:if>	            
			</div>
			<h3><a href="#"><util:message key="eb.title.list.readScreen"/></a></h3>
			<div class="board">
	            <table cellpadding="0" cellspacing="0" summary="게시판 상세" class="table_board">  
	            <caption>게시판 상세</caption>
	                <colgroup>
						<col width="28%" />
						<col width="*" />
						<col width="28%" />
						<col width="*" />						
	                </colgroup>
	                <tbody>
	                	<tr>
	                		<th class="L"><util:message key="eb.title.listScren.showAttachment"/></th>
	                		<td class="L">
								<c:forEach items="${radioList}" var="list">
									<input type=radio name="scrn_listAtchYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.listAtchYn==list.code}">checked</c:if>>
									<c:out value="${list.codeName}"/>&nbsp;&nbsp;
								</c:forEach>
                       		</td>
	                		<th class="L"><util:message key="eb.title.listScren.showText"/></th>
	                		<td class="L">
								<c:forEach  items="${radioList}" var="list">
									<input type=radio name="scrn_listCnttYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.listCnttYn==list.code}">checked</c:if>>
									<c:out value="${list.codeName}"/>&nbsp;&nbsp;
								</c:forEach>
                       		</td>                       		                      		
                       	</tr>
                       	<tr>
	                		<th class="L"><util:message key="eb.title.listScren.showOriginalText"/></th>
	                		<td class="L">
								<c:forEach  items="${radioList}" var="list">
									<input type=radio name="scrn_listOrgYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.listOrgYn==list.code}">checked</c:if>>
									<c:out value="${list.codeName}"/>&nbsp;&nbsp;
								</c:forEach>
                       		</td>
	                		<th class="L"><util:message key="eb.title.listScren.showImg"/></th>
	                		<td class="L">
								<c:forEach  items="${radioList}" var="list">
									<input type=radio name="scrn_listImageYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.listImageYn==list.code}">checked</c:if>>
									<c:out value="${list.codeName}"/>&nbsp;&nbsp;
								</c:forEach>
                       		</td>                        		                    	             		
                       	</tr>
                       	<%--BEGIN::통합형인 경우에는 글일기화면에 영향을 미치는 속성의 설정기능을 막는다.--%>
                       	<tr>
	                		<th class="L"><util:message key="eb.title.readScren.showList"/></th>
	                		<td class="L">
								<c:forEach  items="${radioList}" var="list">
            						<input type=radio name="scrn_readListYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.readListYn==list.code}">checked</c:if>>
									<c:out value="${list.codeName}"/>&nbsp;&nbsp;
								</c:forEach>
                       		</td>
	                		<th class="L"><util:message key="eb.title.readScren.showThreadList"/></th>
	                		<td class="L">
								<c:forEach  items="${radioList}" var="list">
            						<input type=radio name="scrn_readReplyYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.readReplyYn==list.code}">checked</c:if>>
									<c:out value="${list.codeName}"/>&nbsp;&nbsp;
          						</c:forEach>
                       		</td>                        		                    	             		
                       	</tr>
                       	<tr>
	                		<th class="L"><util:message key="eb.title.readScren.showThreadText"/></th>
	                		<td class="L">
								<c:forEach  items="${radioList}" var="list">
            						<input type=radio name="scrn_readReplyCnttYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.readReplyCnttYn==list.code}">checked</c:if>>
									<c:out value="${list.codeName}"/>&nbsp;&nbsp;
         	 					</c:forEach>
                       		</td>
	                		<th class="L"><util:message key="eb.title.multiRead"/></th>
	                		<td class="L">
								<c:forEach  items="${radioList}" var="list">
            						<input type=radio name="scrn_readMultiYn" value="<c:out value="${list.code}"/>" <c:if test="${boardVO.readMultiYn==list.code}">checked</c:if>>
									<c:out value="${list.codeName}"/>&nbsp;&nbsp;
         	 					</c:forEach>
                       		</td>                        		                    	             		
                       	</tr>                        	
                       	<%--END::통합형인 경우에는 글일기화면에 영향을 미치는 속성의 설정기능을 막는다.--%>
	                </tbody>
	            </table>
				<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || sessionScope._user_domain_.domainId == boardVO.domainId}">
					<!-- btnArea-->
					<div class="btnArea">
						<div class="rightArea"><a href="javascript:aBM.getScrnMngr().doSave('listread')" class="btn_O"><span><util:message key="ev.title.save"/></span></a></div>
					</div>
					<!-- btnArea//-->
				</c:if>	            
			</div>    
		</div>
		<!-- scrnAccordion// -->