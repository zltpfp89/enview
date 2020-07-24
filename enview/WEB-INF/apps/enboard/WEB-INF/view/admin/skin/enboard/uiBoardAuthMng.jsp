<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ page import="com.saltware.enview.codebase.Codebase,com.saltware.enboard.vo.CodebaseVO"%>
<%
	String evcp = request.getContextPath();
%>
<input type="hidden" id="auth_anonYn" name="auth_anonYn" value="<c:out value="${boardVO.anonYn}"/>"/>
<%--BEGIN::초기화면--%>
<c:if test="${empty aaForm.view}">
	<%--BEGIN::등급별권한체계를 사용하지 않는 게시판인 경우--%>
	<c:if test="${boardVO.grdAuthYn == 'N'}">
		<div id="authAccordion">
			<h3><a href="#"><util:message key="eb.info.authority.Anyone"/></a></h3> <%--누구나 권한 설정 --%>
			<div class="board">
				<c:if test="${boardVO.boardId != boardVO.boardRid}">
					<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
					<util:message key="eb.info.pseudoBoardAuth"/> (<c:out value="${boardVO.boardRid}"/>) <%--가상게시판의 권한은 원본게시판 설정에 따릅니다. --%>
				</c:if>
				<c:if test="${boardVO.boardId == boardVO.boardRid}">
					<form id="everyAuthForm" name="everyAuthForm" onsubmit="return false;">
			            <table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			            	<caption>게시판</caption>
			                <colgroup>
								<col width="200px" />
								<col width="*" />						
			                </colgroup>
			                <tbody>
			                	<tr>
			                		<th class="L" rowspan="2" prinId="everyBefore">
										<input type="radio" id="auth_every_checkRow_0" name="auth_every_checkRow" value="everyBefore" onclick="aBM.getAuthMngr().doSelect('every',0,this.parentNode)"/>
										<label for="auth_every_checkRow_0" onclick="aBM.getAuthMngr().doSelect('every',0,this.parentNode)"><util:message key="eb.info.anyone.notlogin"/></label>					                		
			                		</th>
			                		<td class="L">
			                			<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
			                			<util:message key="eb.info.assignedAuthority"/> <%--현재 선택된 사용자유형에 부여된 권한입니다. --%>
			                		</td>
		                       	</tr>
								<tr>
									<td id="everyCurAuth"></td>
								</tr>
								<tr>
									<th class="L" rowspan="2" prinId="everyAfter">
										<input type="radio" id="auth_every_checkRow_1" name="auth_every_checkRow" value="everyAfter" onclick="aBM.getAuthMngr().doSelect('every',1,this.parentNode)"/>
										<label for="auth_every_checkRow_1" onclick="aBM.getAuthMngr().doSelect('every',1,this.parentNode)"><util:message key="eb.info.anyone.login"/></label> <%--누구나 로그인 후 --%>
									</th>
									<td class="L">
										<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
										<util:message key="eb.info.assignedAuthority.Checkbox"/> <%--Checkbox로 선택한 사용자유형에 부여할 권한을 설정하십시오. --%>
									</td>
								</tr>
								<tr>
									<td>
										<div>
											<c:forEach items="${actionRepList}" var="actionRep" varStatus="status">
												<input type=checkbox name="authRepGrcdE_<c:out value="${status.index}"/>" value="<c:out value="${actionRep.code}"/>" onclick="aBM.getAuthMngr().checkAuthRepGrcd(this,document.everyAuthForm)">
												<label>&nbsp;<c:out value="${actionRep.codeName}"/></label>&nbsp;&nbsp;
											</c:forEach>
												<a id="authShowButtonE" href="javascript:aBM.getAuthMngr().showDetailAction('E')" class="btn_B"><span><util:message key="eb.prop.set.Authority.down"/></span></a> <%--<util:message key="eb.prop.set.Authority.down"/> --%>
												<a id="authHideButtonE" href="javascript:aBM.getAuthMngr().hideDetailAction('E')" class="btn_B" style="display:none"><span><util:message key="eb.prop.set.Authority.up"/></span></a>
											</div>
											<div id="authDetailE" style="display:none; padding: 10px 0;">
											<c:forEach items="${actionList}" var="action" varStatus="status">
												<input type=checkbox name="authGrcdE_<c:out value="${status.index}"/>" value="<c:out value="${action.code}"/>" onclick="aBM.getAuthMngr().checkAuthGrcd(this,document.everyAuthForm)">
												<label>&nbsp;<c:out value="${action.codeName}"/></label>&nbsp;&nbsp;
											</c:forEach>
										</div>
									</td>
								</tr>																					                    	
			                </tbody>
			            </table>
						<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || sessionScope._user_domain_.domainId == boardVO.domainId}">				
							<!-- btnArea-->
							<div class="btnArea">
								<div class="rightArea"><a href="javascript:aBM.getAuthMngr().doSave('everyAuth',document.everyAuthForm)" class="btn_O"><span><util:message key="ev.title.save"/></span></a></div>
							</div>
							<!-- btnArea//-->
						</c:if>	            							
					</form>
				</c:if>
			</div>
			<%--역할별 권한설정 --%>
			<h3><a href="#"><util:message key="eb.info.authority.Role" /></a></h3>
			<div class="board">
				<c:if test="${boardVO.boardId != boardVO.boardRid}">
					<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
					<util:message key="eb.info.pseudoBoardAuth"/> (<c:out value="${boardVO.boardRid}"/>) <%--가상게시판의 권한은 원본게시판 설정에 따릅니다. --%>
				</c:if>			
				<c:if test="${boardVO.boardId == boardVO.boardRid}">
					<div id="roleAuthDiv"></div>
					<form id="roleAuthForm" name="roleAuthForm">
						<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
							<caption>게시판</caption>
							<colgroup>
								<col width="*" />
							</colgroup>
							<tbody>
			                	<tr>
			                		<td class="L">
			                			<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
			                			<util:message key="eb.info.assignedAuthority.Role"/>
			                		</td>
		                       	</tr>
								<tr>
									<td id="roleCurAuth" class="L"></td>
								</tr>
								<tr>
									<td class="L">
										<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
										<util:message key="eb.info.assignedAuthority.Checkbox.R"/> <%--Checkbox로 선택한 역할들에 부여할 권한을 설정하십시오. --%>
									</td>
								</tr>
								<tr>
									<td class="L">
										<div>
											<c:forEach items="${actionRepList}" var="actionRep" varStatus="status">
												<input type=checkbox id="authRepGrcdR_<c:out value="${status.index}"/>" name="authRepGrcdR_<c:out value="${status.index}"/>" value="<c:out value="${actionRep.code}"/>" onclick="aBM.getAuthMngr().checkAuthRepGrcd(this,document.roleAuthForm)">
												<label for="authRepGrcdR_<c:out value="${status.index}"/>">&nbsp;<c:out value="${actionRep.codeName}"/></label>&nbsp;&nbsp;
											</c:forEach>
											<a id="authShowButtonR" href="javascript:aBM.getAuthMngr().showDetailAction('R')" class="btn_B"><span><util:message key="eb.prop.set.Authority.down"/></span></a>
											<a id="authHideButtonR" href="javascript:aBM.getAuthMngr().hideDetailAction('R')" class="btn_B" style="display:none"><span><util:message key="eb.prop.set.Authority.up"/></span></a>
										</div>
										<div id="authDetailR" style="display:none; padding: 10px 0;">
											<c:forEach items="${actionList}" var="action" varStatus="status">
												<input type=checkbox  id="authGrcdR_<c:out value="${status.index}"/>"  name="authGrcdR_<c:out value="${status.index}"/>" value="<c:out value="${action.code}"/>" onclick="aBM.getAuthMngr().checkAuthGrcd(this,document.roleAuthForm)">
												<label for="authGrcdR_<c:out value="${status.index}"/>"  >&nbsp;<c:out value="${action.codeName}"/></label>&nbsp;&nbsp;
											</c:forEach>
											<input type=checkbox id="authGrcdR_11"  name="authGrcdR_11" value="2048" onclick="aBM.getAuthMngr().checkAuthGrcd(this,document.roleAuthForm)">
											<label for="authGrcdR_11" >&nbsp;<util:message key="eb.prop.delete.text"/></label>&nbsp;&nbsp;
										</div>
									</td>
								</tr>										
							</tbody>				
						</table>
						<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || sessionScope._user_domain_.domainId == boardVO.domainId}">				
							<!-- btnArea-->
							<div class="btnArea">
								<div class="rightArea"><a href="javascript:aBM.getAuthMngr().doSave('roleAuth',document.roleAuthForm)" class="btn_O"><span><util:message key="eb.prop.apply"/></span></a></div>
							</div>
							<!-- btnArea//-->
						</c:if>									
					</form>
				</c:if>
			</div>
			<%-- --%>
			<h3><a href="#"><util:message key="eb.info.authority.Group"/></a></h3>
			<div class="board">
				<c:if test="${boardVO.boardId != boardVO.boardRid}">
					<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
					<util:message key="eb.info.pseudoBoardAuth"/> (<c:out value="${boardVO.boardRid}"/>) <%--가상게시판의 권한은 원본게시판 설정에 따릅니다. --%>
				</c:if>			
				<c:if test="${boardVO.boardId == boardVO.boardRid}">
					<form id="groupAuthForm" name="groupAuthForm" onsubmit="return false;">
						<table width=100% cellpadding=0 cellspacing=0 border=0>
							<tr>
								<td width=20% valign=top>
									<table width=100% cellpadding=0 cellspacing=0 border=0>
										<tr><td height="28px" id="abmLeftTitle" align="center" class="adpanel"><div>&nbsp;<b><util:message key="eb.prop.group"/></b>&nbsp;</div></td></tr>
										<tr><td><div id="groupTree" class="tree" style="height:200px; overflow:hidden; border-right: 0px #ffffff;"></div></td></tr>
									</table>
								</td>
								<td width=80% valign=top style="padding-left:50px">
							  		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
										<tr height=30>
											<td class="L">
												<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
												<util:message key="eb.info.assignedAuthority.Group" /> <%--현재 선택된 그룹에 부여된 권한입니다. --%>
											</td>
										</tr>
										<tr>
											<td id="groupCurAuth"></td>
										</tr>
										<tr height=30>
											<td ckass="L">
												<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
												<util:message key="eb.info.assignedAuthority.Checkbox.G"/> <%--Checkbox로 선택한 그룹들에 부여할 권한을 설정하십시오. --%>
											</td>
										</tr>
										<tr height=30>
											<td class="L">
												<div>
													<c:forEach items="${actionRepList}" var="actionRep" varStatus="status">
														<input type=checkbox id="authRepGrcdG_<c:out value="${status.index}"/>"  name="authRepGrcdG_<c:out value="${status.index}"/>" value="<c:out value="${actionRep.code}"/>" onclick="aBM.getAuthMngr().checkAuthRepGrcd(this,document.groupAuthForm)">
														<label for="authRepGrcdG_<c:out value="${status.index}"/>" >&nbsp;<c:out value="${actionRep.codeName}"/></label>&nbsp;&nbsp;
													</c:forEach>
													<a id="authShowButtonG" href="javascript:aBM.getAuthMngr().showDetailAction('G')" class="btn_B"><span><util:message key="eb.prop.set.Authority.down"/></span></a>
													<a id="authHideButtonG" href="javascript:aBM.getAuthMngr().hideDetailAction('G')" class="btn_B" style="display:none"><span><util:message key="eb.prop.set.Authority.up"/></span></a>
												</div>
												<div id="authDetailG" style="display:none; padding: 10px 0;">
													<c:forEach items="${actionList}" var="action" varStatus="status">
														<input type=checkbox id="authGrcdG_<c:out value="${status.index}"/>" name="authGrcdG_<c:out value="${status.index}"/>" value="<c:out value="${action.code}"/>" onclick="aBM.getAuthMngr().checkAuthGrcd(this,document.groupAuthForm)">
														<label for="authGrcdG_<c:out value="${status.index}"/>" >&nbsp;<c:out value="${action.codeName}"/></label>&nbsp;&nbsp;
													</c:forEach>
													<!-- <input type=checkbox name="authGrcdR_11" value="2048" onclick="aBM.getAuthMngr().checkAuthGrcd(this,document.roleAuthForm)">
													<label>&nbsp;<util:message key="eb.prop.delete.text"/></label>&nbsp;&nbsp; -->
												</div>
											</td>	
										</tr>
							  		</table>
								</td>
							</tr>
						</table>							
					</form>
					<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || sessionScope._user_domain_.domainId == boardVO.domainId}">				
						<!-- btnArea-->
						<div class="btnArea">
							<div class="rightArea"><a href="javascript:aBM.getAuthMngr().doSave('groupAuth',document.groupAuthForm)" class="btn_O"><span><util:message key="eb.prop.apply"/></span></a></div>
						</div>
						<!-- btnArea//-->
					</c:if>							
				</c:if>
			</div>
			<%-- --%>
			<h3><a href="#"><util:message key="eb.info.authority.User"/></a></h3>
			<div class="bottom">
				<c:if test="${boardVO.boardId != boardVO.boardRid}">
					<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
					<util:message key="eb.info.pseudoBoardAuth"/> (<c:out value="${boardVO.boardRid}"/>) <%--가상게시판의 권한은 원본게시판 설정에 따릅니다. --%>
				</c:if>			
				<c:if test="${boardVO.boardId == boardVO.boardRid}">
					<div id="userAuthDiv"></div>
					<form id="userAuthForm" name="userAuthForm" onsubmit="return false;">
						<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
							<caption>게시판</caption>
							<colgroup>
								<col width="*" />
							</colgroup>
							<tbody>
			                	<tr>
			                		<td class="L">
			                			<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
			                			<util:message key="eb.info.assignedAuthority.User"/> <%--현재 선택된 사용자에 부여된 권한입니다. --%>
			                		</td>
		                       	</tr>
								<tr>
									<td id="userCurAuth" class="L"></td>
								</tr>
								<tr>
									<td class="L">
										<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
										<util:message key="eb.info.assignedAuthority.Checkbox.U"/><%--Checkbox로 선택한 사용자들에 부여할 권한을 설정하십시오. --%>
									</td>
								</tr>
								<tr>
									<td class="L">
										<div>
											<c:forEach items="${actionRepList}" var="actionRep" varStatus="status">
												<input type=checkbox id="authRepGrcdU_<c:out value="${status.index}"/>" name="authRepGrcdU_<c:out value="${status.index}"/>" value="<c:out value="${actionRep.code}"/>" onclick="aBM.getAuthMngr().checkAuthRepGrcd(this,document.userAuthForm)">
												<label for="authRepGrcdU_<c:out value="${status.index}"/>" >&nbsp;<c:out value="${actionRep.codeName}"/></label>&nbsp;&nbsp;
											</c:forEach>
											<a id="authShowButtonU" href="javascript:aBM.getAuthMngr().showDetailAction('U')" class="btn_B"><span><util:message key="eb.prop.set.Authority.down"/></span></a>
											<a id="authHideButtonU" href="javascript:aBM.getAuthMngr().hideDetailAction('U')" class="btn_B" style="display:none"><span><util:message key="eb.prop.set.Authority.up"/></span></a>
										</div>
										<div id="authDetailU" style="display:none; padding: 10px 0;">
											<c:forEach items="${actionList}" var="action" varStatus="status">
												<input type=checkbox id="authGrcdU_<c:out value="${status.index}"/>" name="authGrcdU_<c:out value="${status.index}"/>" value="<c:out value="${action.code}"/>" onclick="aBM.getAuthMngr().checkAuthGrcd(this,document.userAuthForm)">
												<label for="authGrcdU_<c:out value="${status.index}"/>" >&nbsp;<c:out value="${action.codeName}"/></label>&nbsp;&nbsp;
											</c:forEach>
											<input type=checkbox id="authGrcdU_11" name="authGrcdU_11" value="2048" onclick="aBM.getAuthMngr().checkAuthGrcd(this,document.userAuthForm)">
											<label for="authGrcdU_11" >&nbsp;<util:message key="eb.prop.delete.text"/></label>&nbsp;&nbsp;
										</div>
									</td>
								</tr>																		
							</tbody>				
						</table>
						<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || sessionScope._user_domain_.domainId == boardVO.domainId}">				
							<!-- btnArea-->
							<div class="btnArea">
								<div class="rightArea"><a href="javascript:aBM.getAuthMngr().doSave('userAuth',document.userAuthForm)" class="btn_O"><span><util:message key="eb.prop.apply"/></span></a></div>
							</div>
							<!-- btnArea//-->
						</c:if>									
					</form>
				</c:if>					
			</div>
		</div>
	</c:if>
	<%--BEGIN::등급별권한체계를 사용하지 않는 게시판인 경우--%>
	<%--BEGIN::등급별권한체계를 사용하는 게시판인 경우--%>
<c:if test="${boardVO.grdAuthYn == 'Y'}">
<div id="authAccordion">
  <h3><a href="#">등급별 권한 설정</a></h3>
  <div class="adformpanel">
	<c:if test="${boardVO.boardId != boardVO.boardRid}">
		<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
		<util:message key="eb.info.pseudoBoardAuth"/> (<c:out value="${boardVO.boardRid}"/>) <%--가상게시판의 권한은 원본게시판 설정에 따릅니다. --%>
	</c:if>
	<c:if test="${boardVO.boardId == boardVO.boardRid}">
    <form id="authGradeForm" name="authGradeForm" onsubmit="return false;">
					<form id="authGradeForm" name="authGradeForm" onsubmit="return false;">
						<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
							<caption>게시판</caption>
							<colgroup>
								<col width="25%" />
								<col width="*" />
							</colgroup>
							<c:forEach items="${gradeList}" var="grade">
								<tr>
									<th class="R">
										<c:out value="${grade.codeName}"/>
										<input type="hidden" id="authGrcd<c:out value="${grade.code}"/>">
									</th>
									<td class="L">
										<div>
											<c:forEach items="${actionRepList}" var="actionRep" varStatus="status">
												<input type=checkbox name="authRepGrcd<c:out value="${grade.code}"/>_<c:out value="${status.index}"/>" id="authRepGrcd<c:out value="${grade.code}"/>_<c:out value="${status.index}"/>" value="<c:out value="${actionRep.code}"/>"
														 <%
														 CodebaseVO gcdVO	= (CodebaseVO)pageContext.getAttribute("grade");
														 Codebase	 codeVO = (Codebase)pageContext.getAttribute("actionRep");
														 if( gcdVO.hasAction( codeVO.getCode())) {
														 %>
															 checked=true
														 <%
														 }
														 %>
														 onclick="aBM.getAuthMngr().checkAuthRepGrcd(this,document.authGradeForm)"
												><label for="authRepGrcd<c:out value="${grade.code}"/>_<c:out value="${status.index}"/>">&nbsp;<c:out value="${actionRep.codeName}"/></label>&nbsp;&nbsp;
											</c:forEach>
											<a id="authShowButton<c:out value="${grade.code}"/>" href="javascript:aBM.getAuthMngr().showDetailAction('<c:out value="${grade.code}"/>')" class="btn_B"><span><util:message key="eb.prop.set.Authority.down"/></span></a>
											<a id="authHideButton<c:out value="${grade.code}"/>" href="javascript:aBM.getAuthMngr().hideDetailAction('<c:out value="${grade.code}"/>')" class="btn_B" style="display:none"><span><util:message key="eb.prop.set.Authority.up"/></span></a>
										</div>
										<div id="authDetail<c:out value="${grade.code}"/>" style="display:none;border-top: 1px solid lightgray;padding: 5px">
											<c:forEach items="${actionList}" var="action" varStatus="status">
												<div style="display:inline-block;">
												<input type=checkbox name="authGrcd<c:out value="${grade.code}"/>_<c:out value="${status.index}"/>" id="authGrcd<c:out value="${grade.code}"/>_<c:out value="${status.index}"/>" value="<c:out value="${action.code}"/>"
													 <%
													 CodebaseVO gcdVO	= (CodebaseVO)pageContext.getAttribute("grade");
													 Codebase	 codeVO = (Codebase)pageContext.getAttribute("action");
													 if (gcdVO.hasAction (codeVO.getCode())) {
													 %>
														 checked=true
													 <%
													 }
													 %>
													 onclick="aBM.getAuthMngr().checkAuthGrcd(this,document.authGradeForm)"
												><label for="authGrcd<c:out value="${grade.code}"/>_<c:out value="${status.index}"/>">&nbsp;<c:out value="${action.codeName}"/></label>&nbsp;&nbsp;
												</div>
											</c:forEach>
											<c:if test="${grade.code == 'X'}">
												<div style="display:inline-block;">
												<input type=checkbox name="authGrcdX_11" id="authGrcdX_11" value="2048" 
													 <%
													 CodebaseVO gcdVO = (CodebaseVO)pageContext.getAttribute("grade");
													 if (gcdVO.hasAction ("2048")) {
													 %>
														 checked=true
													 <%
													 }
													 %>
													 onclick="aBM.getAuthMngr().checkAuthGrcd(this,document.authGradeForm)"
												><label for="authGrcdX_11">&nbsp;<util:message key="eb.prop.delete.text"/></label>
												</div>
											</c:if>
										</div>
									</td>																		
								</tr>
							</c:forEach>						
						</table>
	</form>
					<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || sessionScope._user_domain_.domainId == boardVO.domainId}">
						<!-- btnArea-->
						<div class="btnArea">
							<div class="rightArea">
								<a href="javascript:aBM.getAuthMngr().doSave('gradeAuth',document.authGradeForm)" class="btn_O"><span><util:message key="eb.prop.apply"/></span></a>
							</div>
						</div>
						<!-- btnArea//-->
					</c:if>					
	
	
	</c:if>
  </div>
  <h3><a href="#"><util:message key="eb.info.assignRole.grade"/></a></h3> <!-- 등급별 역할 배속 -->
  <div class="adformpanel">
	<c:if test="${boardVO.boardId != boardVO.boardRid}">
	  <img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
	  <util:message key="eb.info.pseudoBoardAuth"/> (<c:out value="${boardVO.boardRid}"/>) <%--가상게시판의 권한은 원본게시판 설정에 따릅니다. --%>
	</c:if>
	<c:if test="${boardVO.ownGrdYn == 'N'}">
	  <img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
	  <util:message key="eb.info.dependRole"/> <%--자체등급이 없는 게시판이므로 공통등급의 역할정보에 의존합니다. --%>
	</c:if>
	<c:if test="${boardVO.boardId == boardVO.boardRid && boardVO.ownGrdYn == 'Y'}">
	<div class="tsearchArea">
		<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
		<util:message key="eb.info.chooseGrade.R"/>
		<select class="sel_100" id="auth_role_grade" name="auth_role_grade" onchange="aBM.getAuthMngr().doSelectGrade('role',ebUtil.getSelectedValue(this))" size="1" style="width:400;">
			<c:forEach items="${selGradeList}" var="grade">
			<option value="<c:out value="${grade.codeId}"/>" <c:if test="${grade.codeId == aaForm.selGradeId}">selected</c:if>><c:out value="${grade.codeName}"/>
			</c:forEach>
		</select>
		</div>
		<div id="gradeRoleDiv"></div>
	</c:if>
  </div>
  <h3><a href="#"><util:message key="eb.info.assignGroup.grade"/></a></h3> <!-- 등급별 그룹 배속 -->
  <div class="adformpanel">
	<c:if test="${boardVO.boardId != boardVO.boardRid}">
	  <img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
	  <util:message key="eb.info.pseudoBoardAuth"/> (<c:out value="${boardVO.boardRid}"/>) <%--가상게시판의 권한은 원본게시판 설정에 따릅니다. --%>
	</c:if>
	<br>
	<c:if test="${boardVO.ownGrdYn == 'N'}">
	  <img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
	  <util:message key="eb.info.dependGroup"/> <%--자체등급이 없는 게시판이므로 공통등급의 그룹정보에 의존합니다. --%>
	</c:if>
	<c:if test="${boardVO.boardId == boardVO.boardRid && boardVO.ownGrdYn == 'Y'}">
		<div class="tsearchArea">
			<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
			<util:message key="eb.info.chooseGrade.G"/><%-- 그룹을 배속시킬 등급을 선택하십시오.--%>
			<select class="sel_100" id="auth_group_grade" name="auth_group_grade" onchange="aBM.getAuthMngr().doSelectGrade('group',ebUtil.getSelectedValue(this))" size="1" style="width:400;">
				<c:forEach items="${selGradeList}" var="grade">
				<option value="<c:out value="${grade.codeId}"/>" <c:if test="${grade.codeId == aaForm.selGradeId}">selected</c:if>><c:out value="${grade.codeName}"/>
				</c:forEach>
			</select>
		</div>
	  <div id="gradeGroupDiv"></div>
	</c:if>
  </div>
  <h3><a href="#"><util:message key="eb.info.assignUser.grade"/></a></h3> <!-- 등급별 사용자 배속 -->
  <div class="adformpanel">
	<c:if test="${boardVO.boardId != boardVO.boardRid}">
	  <img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
	  <util:message key="eb.info.pseudoBoardAuth"/> (<c:out value="${boardVO.boardRid}"/>) <%--가상게시판의 권한은 원본게시판 설정에 따릅니다. --%>
	</c:if>
	<br>
	<c:if test="${boardVO.ownGrdYn == 'N'}">
	  <img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
	  <util:message key="eb.info.dependUser"/> <%--자체등급이 없는 게시판이므로 공통등급의 사용자정보에 의존합니다. --%>
	</c:if>
	<c:if test="${boardVO.boardId == boardVO.boardRid && boardVO.ownGrdYn == 'Y'}">
	<div class="tsearchArea">
			<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
			<util:message key="eb.info.chooseGrade.U"/><%-- 사용자를 배속시킬 등급을 선택하십시오.--%>
			<select class="sel_100" id="auth_user_grade" name="auth_user_grade" onchange="aBM.getAuthMngr().doSelectGrade('user',ebUtil.getSelectedValue(this))" size="1" style="width:400;">
				<c:forEach items="${selGradeList}" var="grade">
				<option value="<c:out value="${grade.codeId}"/>" <c:if test="${grade.codeId == aaForm.selGradeId}">selected</c:if>><c:out value="${grade.codeName}"/>
				</c:forEach>
			</select>
	</div>	
	  <div id="gradeUserDiv"></div>
	</c:if>
  </div>
</div>
</c:if>
	<%--END::등급별권한체계를 사용하는 게시판인 경우--%>
</c:if>
<%--END::초기화면--%>
<%--BEGIN::메인화면에 현재 배속된 사용자/그룹/롤 목록 부분--%>
<c:if test="${aaForm.view == 'existList'}">
	<c:if test="${aaForm.act == 'role'}">
		<form id="gradeRoleMngForm" name="gradeRoleMngForm" onsubmit="return false">
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<caption>게시판</caption>			
				<colgroup>
					<col width="10%">
					<col width="20%">
					<col width="30%">
					<col width="40%">
				</colgroup>
				<thead>
					<tr>
						<th class="first">선택</th>
						<th class="C"><span class="table_title"><util:message key="ev.prop.securityGroupRole.roleId"/></span></th>
						<th class="C"><span class="table_title"><util:message key="ev.prop.roleName"/></span></th>
						<th class="C"><span class="table_title"><util:message key="eb.title.explain"/></span></th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty roleList  }">
						<tr>
							<td class="C" colspan="4"><util:message key="ev.info.empty"/></td>
						</tr>
					</c:if>
					<c:forEach items="${roleList}" var="role" varStatus="status">
						<tr prinId="<c:out value="${role.codeId}"/>">
							<td class="first">
								<input type="checkbox" id="auth_role_checkRow_<c:out value="${status.index}"/>" name="auth_role_checkRow" value="<c:out value="${role.codeId}"/>">
							</td>
							<td class="L" onclick="aBM.getAuthMngr().doSelect('role',<c:out value="${status.index}"/>, this.parentNode)"><c:out value="${role.code}"/></td>
							<td class="L" onclick="aBM.getAuthMngr().doSelect('role',<c:out value="${status.index}"/>, this.parentNode)"><c:out value="${role.codeName}"/></td>
							<td class='L' onclick="aBM.getAuthMngr().doSelect('role',<c:out value="${status.index}"/>, this.parentNode)"><c:out value="${role.codeName2}"/></td>
						</tr>
					</c:forEach>
				</tbody>				
			</table>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div class="paging" id="auth_role_page_iterator">
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->
			<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || sessionScope._user_domain_.domainId == boardVO.domainId}">
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
					<a href="javascript:aBM.getAuthMngr().doChooseRGU('role')" class="btn_O"><span><util:message key="ev.title.new"/></span></a>
					<a href="javascript:aBM.getAuthMngr().doRemRGU('role')" class="btn_O"><span><util:message key="ev.title.remove"/></span></a>
				</div>
			</div>
			<!-- btnArea//-->
			</c:if>
			<input type="hidden" name="pageNo" value="<c:out value="${aaForm.pageNo}"/>">
			<input type="hidden" name="totalSize" value="<c:out value="${aaForm.totalSize}"/>">					
		</form>		
	</c:if>
<c:if test="${aaForm.act == 'group'}">
  <form id="gradeGroupMngForm" name="gradeGroupMngForm" onsubmit="return false">
	<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
		<caption>게시판</caption>			
		<colgroup>
			<col width="10%">
			<col width="20%">
			<col width="30%">
			<col width="40%">
				</colgroup>
				<thead>
					<tr>
						<th class="first">선택</th>
						<th class="C"><span class="table_title"><util:message key="ev.title.statistics.groupId"/></span></th>
						<th class="C"><span class="table_title"><util:message key="ev.title.statistics.groupName"/></span></th>
						<th class="C"><span class="table_title"><util:message key="eb.title.explain"/></span></th>
					</tr>
				</thead>
	<tbody>
					<c:if test="${empty groupList  }">
						<tr>
							<td class="C" colspan="4"><util:message key="ev.info.empty"/></td>
						</tr>
					</c:if>
					<c:forEach items="${groupList}" var="group" varStatus="status">
						<tr prinId="<c:out value="${group.codeId}"/>">
							<td class="first">
								<input type="checkbox" id="auth_group_checkRow_<c:out value="${status.index}"/>" name="auth_role_checkRow" value="<c:out value="${group.codeId}"/>">
							</td>
							<td class="L" onclick="aBM.getAuthMngr().doSelect('group',<c:out value="${status.index}"/>, this.parentNode)"><c:out value="${group.code}"/></td>
							<td class="L" onclick="aBM.getAuthMngr().doSelect('group',<c:out value="${status.index}"/>, this.parentNode)"><c:out value="${group.codeName}"/></td>
							<td class='L' onclick="aBM.getAuthMngr().doSelect('group',<c:out value="${status.index}"/>, this.parentNode)"><c:out value="${group.codeName2}"/></td>
						</tr>
					</c:forEach>
  </tbody>
  </table>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div class="paging" id="auth_role_page_iterator">
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->
			<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || sessionScope._user_domain_.domainId == boardVO.domainId}">
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
					<a href="javascript:aBM.getAuthMngr().doChooseRGU('group')" class="btn_O"><span></span></a>
					<a href="javascript:aBM.getAuthMngr().doRemRGU('group')" class="btn_O"><span><util:message key="ev.title.remove"/></span></a>
				</div>
			</div>
			<!-- btnArea//-->
			</c:if>
			<input type="hidden" name="pageNo" value="<c:out value="${aaForm.pageNo}"/>">
			<input type="hidden" name="totalSize" value="<c:out value="${aaForm.totalSize}"/>">					
		</form>		
  </form>
</c:if>
	<c:if test="${aaForm.act == 'user'}">
		<form id="gradeUserMngForm" name="gradeUserMngForm" onsubmit="return false">
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<caption>게시판</caption>
				<colgroup>
					<col width="10%">
					<col width="40%">
					<col width="*">
				</colgroup>
				<thead>
					<tr>
						<th class="first">선택</th>
						<th class="C"><span class="table_title"><util:message key="ev.prop.calendarUser.userId"/></span></th>
						<th class="C"><span class="table_title"><util:message key="ev.prop.userName"/></span></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${userList}" var="user" varStatus="status">
						<tr prinId="<c:out value="${user.codeId}"/>">
							<td class="first">
								<input type="checkbox" id="auth_user_checkRow_<c:out value="${status.index}"/>" name="auth_user_checkRow" value="<c:out value="${user.codeId}"/>">
							</td>
							<td class="C" onclick="aBM.getAuthMngr().doSelect('user',<c:out value="${status.index}"/>,this.parentNode)"><c:out value="${user.code}"/></td>
							<td class='C' onclick="aBM.getAuthMngr().doSelect('user',<c:out value="${status.index}"/>,this.parentNode)"><c:out value="${user.codeName}"/></td>
						</tr>
					</c:forEach>
				</tbody>				
			</table>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div class="paging" id="auth_user_page_iterator">
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->
			<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || sessionScope._user_domain_.domainId == boardVO.domainId}">
				<!-- btnArea-->
				<div class="btnArea">
					<div class="rightArea">
						<a href="javascript:aBM.getAuthMngr().doChooseRGU('user')" class="btn_B"><span><util:message key="ev.title.new"/></span></a>
						<a href="javascript:aBM.getAuthMngr().doRemRGU('user')" class="btn_B"><span><util:message key="ev.title.remove"/></span></a>
					</div>
				</div>
				<!-- btnArea//-->
			</c:if>
			<input type="hidden" name="pageNo" value="<c:out value="${aaForm.pageNo}"/>">
			<input type="hidden" name="totalSize" value="<c:out value="${aaForm.totalSize}"/>">				
		</form>
	</c:if>
</c:if>
<%--END::메인화면에 현재 배속된 사용자/그룹/롤 목록 부분--%>
<%--BEGIN::사용자/그룹/롤 선택 팝업 화면 부분--%>
<c:if test="${aaForm.view == 'chooseList'}">
	<c:if test="${aaForm.act == 'role'}">
		<form id="abmRoleChooserForm" style="display:inline" name="abmRoleChooserForm" action="" method="post" onsubmit="return false;">
			<div class="tsearchArea">
				<p style="background: none"></p>
				<fieldset>
					<input type="text" name="srchShortPath" class="txt_100" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.roleId"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.roleId"/>');" onkeydown="if( event.keyCode==13) aBM.getRoleChooser().doSearch(1);"
						<c:if test="${empty aaForm.srchShortPath}">value="<util:message key="eb.info.ttl.l.roleId"/>"</c:if><c:if test="${!empty aaForm.srchShortPath}">value="<c:out value="${aaForm.srchShortPath}"/>"</c:if>>
					<input type="text" name="srchPrincipalName" class="txt_100" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.roleNm"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.roleNm"/>');" onkeydown="if( event.keyCode==13) aBM.getRoleChooser().doSearch(1);"
						<c:if test="${empty aaForm.srchPrincipalName}">value="<util:message key="eb.info.ttl.l.roleNm"/>"</c:if><c:if test="${!empty aaForm.srchPrincipalName}">value="<c:out value="${aaForm.srchPrincipalName}"/>"</c:if>>
					<a href="javascript:aBM.getRoleChooser().doSearch(1)" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
				</fieldset>
			</div>
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<caption>게시판</caption>
				<colgroup>
					<col width="10%">
					<col width="40%">
					<col width="*">
				</colgroup>
				<thead>
					<tr style="cursor:pointer;">
						<th class="first"><input type="checkbox" id="delCheck" onclick="aBM.getRoleChooser().m_checkBox.chkAll(this)"/></th>
						<th class="C" ch="0" ><span class="table_title"><util:message key="ev.prop.securityUserRole.roleId"/></span></th>
						<th class="C" ch="0" ><span class="table_title"><util:message key="ev.prop.roleName"/></span></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${roleList}" var="role" varStatus="status">
					<tr>
						<td class="C fixed">
							<input type="checkbox" id="roleChooser_checkRow_<c:out value="${status.index}"/>" name="roleChooser_checkRow" value="<c:out value="${role.codeId}"/>">
						</td>
						<td class="L" onclick="aBM.getRoleChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${role.code}"/></td>
						<td class="L" onclick="aBM.getRoleChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${role.codeName}"/></td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div class="paging" id="abmRoleChooserPageIterator">
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->
			<input type='hidden' name='totalSize' value="<c:out value="${aaForm.totalSize}"/>"/>
		</form>
	</c:if>
	<c:if test="${aaForm.act == 'group'}">
		<form id="abmGroupChooserForm" style="display:inline" name="abmGroupChooserForm" action="" method="post" onsubmit="return false;">
			<div class="tsearchArea">
				<p style="background: none"></p>
				<fieldset>
					<input type="text" name="srchShortPath" class="txt_100" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.groupId"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.groupId"/>');"
							 <c:if test="${empty aaForm.srchShortPath}">value="<util:message key="eb.info.ttl.l.groupId"/>"</c:if><c:if test="${!empty aaForm.srchShortPath}">value="<c:out value="${aaForm.srchShortPath}"/>"</c:if>>
					<input type="text" name="srchPrincipalName" class="txt_100" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.groupNm"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.groupNm"/>');"
							 <c:if test="${empty aaForm.srchPrincipalName}">value="<util:message key="eb.info.ttl.l.groupNm"/>"</c:if><c:if test="${!empty aaForm.srchPrincipalName}">value="<c:out value="${aaForm.srchPrincipalName}"/>"</c:if>>
					<a href="javascript:aBM.getGroupChooser().doSearch(1)" class="btn_search">
						<span><util:message key='ev.title.search'/></span>
					</a>
				</fieldset>
			</div>
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<caption>게시판</caption>
				<colgroup>
					<col width="10%">
					<col width="40%">
					<col width="*">
				</colgroup>
				<thead>
					<tr style="cursor:pointer;">
						<th class="first"><input type="checkbox" id="delCheck" onclick="aBM.getGroupChooser().m_checkBox.chkAll(this)"/></th>
						<th class="C" ch="0" ><span class="table_title"><util:message key="ev.title.statistics.groupId"/></span></th>
						<th class="C" ch="0" ><span class="table_title"><util:message key="ev.title.statistics.groupName"/></span></th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${groupList}" var="group" varStatus="status">
					<tr>
						<td class="C">
							<input type="checkbox" id="groupChooser_checkRow_<c:out value="${status.index}"/>" name="groupChooser_checkRow" value="<c:out value="${group.codeId}"/>">
						</td>
						<td class="L" onclick="aBM.getGroupChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${group.code}"/></td>
						<td class="L" onclick="aBM.getGroupChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${group.codeName}"/></td>
					</tr>
				
				</c:forEach>
				
				<tr><td align="center" colspan="3"><div id="abmGroupChooserPageIterator"></div></td></tr>
				</tbody>
			</table>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div class="paging" id="abmGroupChooserPageIterator">
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->
			<input type='hidden' name='totalSize' value="<c:out value="${aaForm.totalSize}"/>"/>							
		</form>
	</c:if>
	<c:if test="${aaForm.act == 'user'}">
		<form id="abmUserChooserForm" style="display:inline" name="abmUserChooserForm" action="" method="post" onsubmit="return false;">
			<div class="tsearchArea">
				<p style="background: none"></p>
				<fieldset>
					<input type="text" name="srchUserId" class="txt_100" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.id"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.id"/>');"
							 <c:if test="${empty aaForm.srchUserId}">value="<util:message key="eb.info.ttl.l.id"/>"</c:if><c:if test="${!empty aaForm.srchUserId}">value="<c:out value="${aaForm.srchUserId}"/>"</c:if>>
					<input type="text" name="srchNmKor" class="txt_100" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.name"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.name"/>');"
							 <c:if test="${empty aaForm.srchNmKor}">value="<util:message key="eb.info.ttl.l.name"/>"</c:if><c:if test="${!empty aaForm.srchNmKor}">value="<c:out value="${aaForm.srchNmKor}"/>"</c:if>>
					<a href="javascript:aBM.getUserChooser().doSearch(1)" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
				</fieldset>
			</div>
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<caption>게시판</caption>
				<colgroup>
					<col width="10%">
					<col width="40%">
					<col width="*">
				</colgroup>
				<thead>
					<tr style="cursor:pointer;">
						<th class="first"><input type="checkbox" id="delCheck" onclick="aBM.getUserChooser().m_checkBox.chkAll(this)"/></th>
						<th class="C" ch="0"><span class="table_title"><util:message key="ev.title.statistics.userId"/></span></th>
						<th class="C" ch="0"><span class="table_title"><util:message key="ev.prop.userName"/></span></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${userList}" var="user" varStatus="status">
					<tr >
						<td class="C first">
							<input type="checkbox" id="userChooser_checkRow_<c:out value="${status.index}"/>" name="userChooser_checkRow" value="<c:out value="${user.codeId}"/>">
						</td>
						<td class="L" onclick="aBM.getUserChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${user.code}"/></td>
						<td class="L" onclick="aBM.getUserChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${user.codeName}"/></td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div class="paging" id="abmUserChooserPageIterator">
				</div>
				<!-- paging//-->
			</div>
			<input type='hidden' name='totalSize' value="<c:out value="${aaForm.totalSize}"/>"/>
			<!-- tcontrol//-->					
		</form>
	</c:if>
</c:if>
<%--END::사용자/그룹/롤 선택 팝업 화면 부분--%>
<%--BEGIN::현재 선택된 그룹/롤/사용자의 설정된 권한 보여주는 부분--%>
<c:if test="${aaForm.view == 'curAuth'}">
	<c:forEach items="${actionList}" var="action" varStatus="status">
	<input type="checkbox" id="am<c:out value="${status.index}"/>" name="am<c:out value="${status.index}"/>" value="<c:out value="${action.code}"/>" disabled
		<%
			CodebaseVO authVO	= (CodebaseVO)request.getAttribute("authVO");
			Codebase	 codeVO = (Codebase)pageContext.getAttribute("action");
			if (authVO.hasAction (codeVO.getCode())) {
		%>
		 	checked=true
		<%
			}
		%>
	><label for="am<c:out value="${status.index}"/>">&nbsp;<c:out value="${action.codeName}"/></label>&nbsp;&nbsp;
	</c:forEach>
	<c:if test="${aaForm.act == 'user'}">
	<input type=checkbox name="am<c:out value="${status.index}"/>" value="<c:out value="${action.code}"/>" disabled
		<%
			CodebaseVO authVO	= (CodebaseVO)request.getAttribute("authVO");
			if (authVO.hasAction ("2048")) {
		%>
		 	checked=true
		<%
			}
		%>
	><label for="am<c:out value="${status.index}"/>">&nbsp;<util:message key="eb.prop.delete.text"/></label>&nbsp;&nbsp;
	</c:if>
</c:if>
<%--END::현재 선택된 그룹/롤/사용자의 설정된 권한 보여주는 부분--%>


