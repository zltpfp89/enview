<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>
<c:if test="${empty aaForm.view}">
<div id="partAccordion">
	<h3><a href="#">대상자 부여 유형 설정</a></h3>
  	<div class="board">
 		<form name="apmPartEditForm" onsubmit="return false">
		    <table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">  
				<tr height=30>
					<td>
						<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
				    	설문 참여 대상자를 전체사용자에 대해서 또는 사용자별/그룹별/역할별로 부여하실 수 있습니다.
				  	</td>
				</tr>
		    </table>
		    <table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<colgroup>
					<col width="160px" />
					<col width="200px" />
					<col width="80px" />						
				</colgroup>
				<tr height=30>
					<td colspan=3>
						<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
						설문 참여 대상자 부여 유형을 선택하십시오.
					</td>
				</tr>
				<tr height=30>
					<th class='C'>대상자 부여 유형</th>
					<td class='C'>
						<div class="sel_200">
							<select id="part_authGrade" name="part_authGrade" size="1" class="txt_200">
								<c:forEach items="${grdList}" var="grd">
									<option value="<c:out value="${grd.codeId}"/>" <c:if test="${grd.code == boardVO.pollPartType}">selected</c:if>><c:out value="${grd.codeName}"/>
								</c:forEach>
							</select>
						</div>
					</td>
				 	<td class='R'>
						<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || (sessionScope._enview_user_info_.hasDomainManagerRole && sessionScope._user_domain_.domainId == boardVO.domainId)}">
							<a href="javascript:aPM.getPartMngr().doSave()" class="btn_B"><span>적용</span></a>
						</c:if>
					</td>
				</tr>
		    </table>
 		</form>
  	</div>
	<h3><a href="#">역할별 부여</a></h3>
	<div id="gradeRoleDiv" class="board"></div>
	<h3><a href="#">그룹별 부여</a></h3>
	<div id="gradeGroupDiv" class="board"></div>
	<h3><a href="#">사용자별 부여</a></h3>
	<div id="gradeUserDiv" class="board"></div>
</div>
</c:if>
<%--BEGIN::메인화면에 현재 배속된 사용자/그룹/역할 목록 부분--%>
<c:if test="${aaForm.view == 'existList'}">
	<c:if test="${boardVO.pollPartType != 'D'}">
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<tr height=30>
				<td colspan=2>
					<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
					대상자 부여 유형이 사용자/그룹/역할 별이 아닙니다.
				</td>
			</tr>
		</table>
	</c:if>
	<c:if test="${boardVO.pollPartType == 'D'}">
		<c:if test="${aaForm.act == 'role'}">
			<form id="gradeRoleMngForm" name="gradeRoleMngForm" onsubmit="return false">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<tr height=30>
						<td colspan=2>
							<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
							현재 대상자에 속한 역할
					  	</td>
					</tr>
				</table>
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<thead>
						<tr height=24>
							<th width=10% class='C'>선택</th>
						  	<th width=40% class='C'><span class="table_title">역할ID</span></th>
						  	<th width=50% class='C'><span class="table_title">역할명</span></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${roleList}" var="role" varStatus="status">
							<tr height=22>
								<td width=10% class='C'>
									<input type="checkbox" id="part_role_checkRow_<c:out value="${status.index}"/>" name="part_role_checkRow" value="<c:out value="${role.codeId}"/>">
								</td>
								<td width=40% class='C' onclick="aPM.getPartMngr().doSelect('role',<c:out value="${status.index}"/>)"><c:out value="${role.code}"/></td>
								<td width=50% class='C' onclick="aPM.getPartMngr().doSelect('role',<c:out value="${status.index}"/>)"><c:out value="${role.codeName}"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- tcontrol-->
				<div class="tcontrol">
					<!-- paging -->
					<div class="paging" id="part_role_page_iterator">
					</div>
					<!-- paging//-->
				</div>
				<!-- tcontrol//-->
				<!-- btnArea-->
				<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || (sessionScope._enview_user_info_.hasDomainManagerRole && sessionScope._user_domain_.domainId == boardVO.domainId)}">
					<div class="btnArea">
						<div class="rightArea">
							<!-- <a href="javascript:aPM.getPartMngr().doChooseRGU('role')" class="btn_B"><span>신규</span></a> -->
							<a href="javascript:aPM.getPartMngr().getRoleChooser().doShow(aPM.getPartMngr().setRoleChooserCallback)" class="btn_B"><span>신규</span></a>
							<a href="javascript:aPM.getPartMngr().doRemRGU('role')" class="btn_B"><span>삭제</span></a>
						</div>
					</div>
				</c:if>
				<!-- btnArea//-->		
				<input type="hidden" name="pageNo" value="<c:out value="${aaForm.pageNo}"/>">
				<input type="hidden" name="totalSize" value="<c:out value="${aaForm.totalSize}"/>">
			</form>
		</c:if>
		<c:if test="${aaForm.act == 'group'}">
			<form id="gradeGroupMngForm" name="gradeGroupMngForm" onsubmit="return false">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<tr height=30>
						<td colspan=2>
							<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
							현재 대상자에 속한 그룹
						</td>
					</tr>
				</table>
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<thead>
						<tr height=24>
							<th width=10% class='first'>선택</th>
							<th width=40% class='C'><span class="table_title">그룹ID</span></th>
							<th width=50% class='C'><span class="table_title">그룹명</span></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${groupList}" var="group" varStatus="status">
							<tr height=22>
								<td width=10% class='C'>
									<input type="checkbox" id="part_group_checkRow_<c:out value="${status.index}"/>" name="part_group_checkRow" value="<c:out value="${group.codeId}"/>">
							 	</td>
							 	<td width=40% class='C' onclick="aPM.getPartMngr().doSelect('group',<c:out value="${status.index}"/>)"><c:out value="${group.code}"/></td>
							 	<td width=50% class='C' onclick="aPM.getPartMngr().doSelect('group',<c:out value="${status.index}"/>)"><c:out value="${group.codeName}"/></td>
							 </tr>
						</c:forEach>
					</tbody>
	  			</table>
				<!-- tcontrol-->
				<div class="tcontrol">
					<!-- paging -->
					<div class="paging" id="part_group_page_iterator">
					</div>
					<!-- paging//-->
				</div>
				<!-- tcontrol//-->
				<!-- btnArea-->
				<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || (sessionScope._enview_user_info_.hasDomainManagerRole && sessionScope._user_domain_.domainId == boardVO.domainId)}">
				<div class="btnArea">
					<div class="rightArea">
						<!-- <a href="javascript:aPM.getPartMngr().doChooseRGU('group')" class="btn_B"><span>신규</span></a> -->
						<a href="javascript:aPM.getPartMngr().getGroupChooser().doShow(aPM.getPartMngr().setGroupChooserCallback)" class="btn_B"><span>신규</span></a>
						<a href="javascript:aPM.getPartMngr().doRemRGU('group')" class="btn_B"><span>삭제</span></a>
					</div>
				</div>
				</c:if>
				<!-- btnArea//-->		
				<input type="hidden" name="pageNo" value="<c:out value="${aaForm.pageNo}"/>">
				<input type="hidden" name="totalSize" value="<c:out value="${aaForm.totalSize}"/>">
			</form>
		</c:if>
		<c:if test="${aaForm.act == 'user'}">
			<form id="gradeUserMngForm" name="gradeUserMngForm" onsubmit="return false">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<tr height=30>
						<td colspan=2>
							<img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle>
							현재 대상자에 속한 사용자
						</td>
					</tr>
				</table>
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<thead>
						<tr height=24>
							<th width=10% class='first'>선택</th>
							<th width=40% class='C'><span class="table_title">사용자ID</span></th>
							<th width=50% class='C'><span class="table_title">사용자명</span></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${userList}" var="user" varStatus="status">
							<tr height=22>
								<td width=10% class='C'>
									<input type="checkbox" id="part_user_checkRow_<c:out value="${status.index}"/>" name="part_user_checkRow" value="<c:out value="${user.codeId}"/>">
								</td>
								<td width=40% class='C' onclick="aPM.getPartMngr().doSelect('user',<c:out value="${status.index}"/>)"><c:out value="${user.code}"/></td>
								<td width=50% class='C' onclick="aPM.getPartMngr().doSelect('user',<c:out value="${status.index}"/>)"><c:out value="${user.codeName}"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- tcontrol-->
				<div class="tcontrol">
					<!-- paging -->
					<div class="paging" id="part_user_page_iterator">
					</div>
					<!-- paging//-->
				</div>
				<!-- tcontrol//-->
					<c:if test="${sessionScope._enview_user_info_.hasAdminRole || sessionScope._enview_user_info_.hasManagerRole || (sessionScope._enview_user_info_.hasDomainManagerRole && sessionScope._user_domain_.domainId == boardVO.domainId)}">
					<!-- btnArea-->
					<div class="btnArea">
						<div class="rightArea">
							<a href="javascript:aPM.getPartMngr().doChooseRGU('user')" class="btn_B"><span>신규</span></a>
							<a href="javascript:aPM.getPartMngr().doRemRGU('user')')" class="btn_B"><span>삭제</span></a>
						</div>
					</div>
					<!-- btnArea//-->
				</c:if>
				<input type="hidden" name="pageNo" value="<c:out value="${aaForm.pageNo}"/>">
				<input type="hidden" name="totalSize" value="<c:out value="${aaForm.totalSize}"/>">
			</form>
		</c:if>
	</c:if>
</c:if>
<%--END::메인화면에 현재 배속된 사용자/그룹/역할 목록 부분--%>
<%--BEGIN::사용자/그룹/역할 선택 팝업 화면 부분--%>
<c:if test="${aaForm.view == 'chooseList'}">
	<c:if test="${aaForm.act == 'role'}">
		<div class="board">
			<form id="apmRoleChooserForm" style="display:inline" name="apmRoleChooserForm" action="" method="post" onsubmit="return false;">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<tr height=30>
						<td class='R'>
							<input type="text" name="srchShortPath" style="width:120;" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.roleId"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.roleId"/>');"
						    	<c:if test="${empty aaForm.srchShortPath}">value="<util:message key="eb.info.ttl.l.roleId"/>"</c:if><c:if test="${!empty aaForm.srchShortPath}">value="<c:out value="${aaForm.srchShortPath}"/>"</c:if>>
						 	<input type="text" name="srchPrincipalName" style="width:160;" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.roleNm"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.roleNm"/>');"
						    	<c:if test="${empty aaForm.srchPrincipalName}">value="<util:message key="eb.info.ttl.l.roleNm"/>"</c:if><c:if test="${!empty aaForm.srchPrincipalName}">value="<c:out value="${aaForm.srchPrincipalName}"/>"</c:if>>
						 	<a href="javascript:aPM.getRoleChooser().doSearch()" class="btn_search"><span>검색</span></a>
						</td>
					</tr>
				</table>
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<thead>
						<tr style="cursor:pointer;width:10%">
							<th class="first">
								<input type="checkbox" id="delCheck" onclick="aPM.getRoleChooser().m_checkBox.chkAll(this)"/>
						  	</th>
						  	<th class="C" ch="0" width=40%><span class="table_title">역할 ID</span></th>
						  	<th class="C" ch="0" width=50%><span class="table_title">역할 명</span></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${roleList}" var="role" varStatus="status">
							<tr height=22>
								<td class='C'>
									<input type="checkbox" id="roleChooser_checkRow_<c:out value="${status.index}"/>" name="roleChooser_checkRow" value="<c:out value="${role.codeId}"/>">
								</td>
								<td class='L' onclick="aPM.getRoleChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${role.code}"/></td>
								<td class='L' onclick="aPM.getRoleChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${role.codeName}"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- tcontrol-->
				<div class="tcontrol">
					<!-- paging -->
					<div class="paging" id="apmRoleChooserPageIterator">
					</div>
					<!-- paging//-->
				</div>
				<!-- tcontrol//-->
				<input type='hidden' name='totalSize' value="<c:out value="${aaForm.totalSize}"/>"/>
			</form>
		</div>
	</c:if>
	<c:if test="${aaForm.act == 'group'}">
		<div class="board">
			<form id="apmGroupChooserForm" style="display:inline" name="apmGroupChooserForm" action="" method="post" onsubmit="return false;">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<tr height=30>
						<td class='R'>
							<input type="text" name="srchShortPath" style="width:120;" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.groupId"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.groupId"/>');"
						    	<c:if test="${empty aaForm.srchShortPath}">value="<util:message key="eb.info.ttl.l.groupId"/>"</c:if><c:if test="${!empty aaForm.srchShortPath}">value="<c:out value="${aaForm.srchShortPath}"/>"</c:if>>
							<input type="text" name="srchPrincipalName" style="width:160;" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.groupNm"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.groupNm"/>');"
						    	<c:if test="${empty aaForm.srchPrincipalName}">value="<util:message key="eb.info.ttl.l.groupNm"/>"</c:if><c:if test="${!empty aaForm.srchPrincipalName}">value="<c:out value="${aaForm.srchPrincipalName}"/>"</c:if>>
						  <a href="javascript:aPM.getGroupChooser().doSearch()" class="btn_search"><span>검색</span></a>
						</td>
					</tr>
				</table>
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">			
					<thead>
						<tr style="cursor:pointer;width:10%">
							<th class="first">
								<input type="checkbox" id="delCheck" onclick="aPM.getGroupChooser().m_checkBox.chkAll(this)"/>
							</th>
							<th class="C" ch="0" width=40%><span class="table_title">그룹 ID</span></th>
							<th class="C" ch="0" width=50%><span class="table_title">그룹 명</span></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${groupList}" var="group" varStatus="status">
							<tr height=22>
								<td class='C'>
									<input type="checkbox" id="groupChooser_checkRow_<c:out value="${status.index}"/>" name="groupChooser_checkRow" value="<c:out value="${group.codeId}"/>">
								</td>
								<td class='L' onclick="aPM.getGroupChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${group.code}"/></td>
								<td class='L' onclick="aPM.getGroupChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${group.codeName}"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- tcontrol-->
				<div class="tcontrol">
					<!-- paging -->
					<div class="paging" id="apmGroupChooserPageIterator">
					</div>
					<!-- paging//-->
				</div>
				<!-- tcontrol//-->					
				<input type='hidden' name='totalSize' value="<c:out value="${aaForm.totalSize}"/>"/>
			</form>
		</div>
	</c:if>
	<c:if test="${aaForm.act == 'user'}">
		<div class="board">	
			<form id="apmUserChooserForm" style="display:inline" name="apmUserChooserForm" action="" method="post" onsubmit="return false;">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<tr height=30>
						<td class='R'>
						  <input type="text" name="srchUserId" style="width:120;" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.id"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.id"/>');"
							     <c:if test="${empty aaForm.srchUserId}">value="<util:message key="eb.info.ttl.l.id"/>"</c:if><c:if test="${!empty aaForm.srchUserId}">value="<c:out value="${aaForm.srchUserId}"/>"</c:if>>
						  <input type="text" name="srchNmKor" style="width:160;" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.name"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.name"/>');"
							     <c:if test="${empty aaForm.srchNmKor}">value="<util:message key="eb.info.ttl.l.name"/>"</c:if><c:if test="${!empty aaForm.srchNmKor}">value="<c:out value="${aaForm.srchNmKor}"/>"</c:if>>
						  <a href="javascript:aPM.getUserChooser().doSearch()" class="btn_search"><span>검색</span></a>
						</td>
					</tr>
				</table>
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<thead>
						<tr style="cursor:pointer;width:10%">
							<th class="first">
								<input type="checkbox" id="delCheck" onclick="aPM.getUserChooser().m_checkBox.chkAll(this)"/>
							</th>
							<th class="C" ch="0" width=40%><span class="table_title">사용자 ID</span></th>
							<th class="C" ch="0" width=50%><span class="table_title">사용자 명</span></th>
						</tr>
					</thead>
				  	<tbody>
						<c:forEach items="${userList}" var="user" varStatus="status">
							<tr height=22>
								<td class='C'>
									<input type="checkbox" id="userChooser_checkRow_<c:out value="${status.index}"/>" name="userChooser_checkRow" value="<c:out value="${user.codeId}"/>">
								</td>
								<td class='L' onclick="aPM.getUserChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${user.code}"/></td>
								<td class='L' onclick="aPM.getUserChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${user.codeName}"/></td>
							</tr>
						</c:forEach>
				  	</tbody>
				</table>
				<!-- tcontrol-->
				<div class="tcontrol">
					<!-- paging -->
					<div class="paging" id="apmUserChooserPageIterator">
					</div>
					<!-- paging//-->
				</div>
				<!-- tcontrol//-->					
				<input type='hidden' name='totalSize' value="<c:out value="${aaForm.totalSize}"/>"/>
			</form>
		</div>
	</c:if>
</c:if>
<%--END::사용자/그룹/역할 선택 팝업 화면 부분--%>