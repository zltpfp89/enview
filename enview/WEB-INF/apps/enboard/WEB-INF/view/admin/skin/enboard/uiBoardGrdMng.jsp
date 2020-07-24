<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ page import="com.saltware.enview.codebase.Codebase,com.saltware.enboard.vo.CodebaseVO"%>
<%
	String evcp = request.getContextPath();
%>

<c:if test="${empty aaForm.view}" >
<div class="sub_contents">
	<div class="detail">
		<div class="board first">
			<form id="grdMngForm" name="grdMngForm" onsubmit="return false">
	  			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
	  				<thead>
						<tr>
							<th class="first"><span class="table_title"><util:message key="ev.hnevent.label.select"/></span></th>
							<th><span class="table_title"><util:message key="cf.title.grade"/></span></th>
							<th><span class="table_title"><util:message key="eb.prop.gradeNm"/></span></th>
							<th><span class="table_title"><util:message key="cf.title.order"/></span></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${grdList}" var="grd" varStatus="status">
							<tr>
								<td class="C">
									<input type="checkbox" id="checkRow_<c:out value="${status.index}"/>" name="checkRow" value="<c:out value="${grd.code}"/>"
											gradeNm="<c:out value="${grd.codeName}"/>" gradeDesc="<c:out value="${grd.remark}"/>"
									>
								</td>
								<td class="C" onclick="admGradeMngr.doGrdSelect('<c:out value="${status.index}"/>')"><c:out value="${grd.code}"/></td>
								<td class="C" onclick="admGradeMngr.doGrdSelect('<c:out value="${status.index}"/>')"><c:out value="${grd.codeName}"/></td>
								<td class="C" onclick="admGradeMngr.doGrdSelect('<c:out value="${status.index}"/>')">
								<c:if test="${!status.last}">
									<a href="javascript:admGradeMngr.doGrdUp('<c:out value="${status.index}"/>')" class="btn_W">
										<span><util:message key="eb.prop.grade.Up"/></span>
									</a>
								</c:if>
								<c:if test="${!status.first}">
									<a href="javascript:admGradeMngr.doGrdDown('<c:out value="${status.index}"/>')" class="btn_W">
										<span class="btn_pack small"><util:message key="eb.prop.grade.Down"/></span>
									</a>
								</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
	  			</table>
				<input type=hidden id="grd_selected">
				<input type=hidden id="grd_act">
				<!-- btnArea-->
				<div class="btnArea"> 
					<div class="rightArea">
						<a href="javascript:admGradeMngr.doGrdCreate()" class="btn_B"><span><util:message key="mm.title.new"/></span></a>
						<a href="javascript:admGradeMngr.doGrdDelete()" class="btn_B"><span><util:message key="mm.title.remove"/></span></a>
					</div>
				</div>
				<!-- btnArea//-->
  			</form>
		</div>
		
		<div id="grdEditDiv" class="board" style="display:none;">
			<form id="grdEditForm" name="grdEditForm" style="display:inline" action="" method="post" onsubmit="return false;">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<colgroup>
						<col width="140px" />
						<col width="*"/>
					</colgroup>
					<tr>
						<th class='L'><util:message key="cf.title.grade"/></th>
						<td class='L'><input type='text' id='grade' size="3" disabled='true' class="txt_100"></td>
					</tr>
					<tr>
						<th class='L'><util:message key="eb.prop.gradeNm"/></th>
						<td class='L'><input type='text' id="gradeNm" maxlength='20' class="txt_100per"></td>
					</tr>
					<tr>
						<th class='L'><util:message key="eb.prop.gradeEx"/></th>
						<td class='L'><input type='text' id="gradeDesc" maxlength='120' class="txt_100per"></td>
					</tr>
				</table>
				<!-- btnArea-->
				<div class="btnArea"> 
					<div class="rightArea">
						<a href="javascript:admGradeMngr.doGrdSave()" class="btn_O"><span><util:message key="mm.title.save"/></span></a>
					</div>
				</div>
				<!-- btnArea//-->
			</form>
		</div>
		
		<div id="authAccordion" class="board">
			<h3><a href="#"><util:message key="eb.info.assignRole.grade"/></a></h3>
			<div>
				<span><img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle><util:message key="eb.info.chooseGrade.R"/></span>
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<colgroup>
						<col width="140px" />
						<col width="*" />
					</colgroup>
					<tr>
						<th><util:message key="eb.title.selGrd"/></th>
						<td>
							<div class="sel_100">
								<select id="role_grade" name="role_grade" onchange="admGradeMngr.doSelectGrade('role',ebUtil.getSelectedValue(this))" size="1" class="txt_100">
									<c:forEach items="${selGradeList}" var="grade">
										<option value="<c:out value="${grade.codeId}"/>" <c:if test="${grade.codeId == aaForm.selGradeId}">selected</c:if>><c:out value="${grade.codeName}"/>
									</c:forEach>
								</select>
							</div>
						</td>
					</tr>
				</table>
				<div id="gradeRoleDiv"></div>
			</div>
			<h3><a href="#"><util:message key="eb.info.assignGroup.grade"/></a></h3>
			<div>
				<span><img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle><util:message key="eb.info.chooseGrade.G"/></span>
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<colgroup>
						<col width="140px" />
						<col width="*" />
					</colgroup>
					<tr>
						<th><util:message key="eb.title.selGrd"/></th>
						<td>
							<div class="sel_100">
								<select id="group_grade" name="group_grade" onchange="admGradeMngr.doSelectGrade('group',ebUtil.getSelectedValue(this))" size="1" class="txt_100">
									<c:forEach items="${selGradeList}" var="grade">
										<option value="<c:out value="${grade.codeId}"/>" <c:if test="${grade.codeId == aaForm.selGradeId}">selected</c:if>><c:out value="${grade.codeName}"/>
									</c:forEach>
								</select>
							</div>
						</td>
					</tr>
				</table>
				<div id="gradeGroupDiv"></div>
			</div>
			<h3><a href="#"><util:message key="eb.info.assignUser.grade"/></a></h3>
			<div>
				<span><img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle> <util:message key="eb.info.chooseGrade.U"/></span>
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<colgroup>
						<col width="140px" />
						<col width="*" />
					</colgroup>
					<tr>
						<th><util:message key="eb.title.selGrd"/></th>
						<td>
							<div class="sel_100">
								<select id="user_grade" name="user_grade" onchange="admGradeMngr.doSelectGrade('user',ebUtil.getSelectedValue(this))" size="1" class="txt_100">
									<c:forEach items="${selGradeList}" var="grade">
										<option value="<c:out value="${grade.codeId}"/>" <c:if test="${grade.codeId == aaForm.selGradeId}">selected</c:if>><c:out value="${grade.codeName}"/>
									</c:forEach>
								</select>
							</div>
						</td>
					</tr>
				</table>
				<div id="gradeUserDiv"></div>
			</div>
		</div>
	</div>
</div>
</c:if>
<%--BEGIN::메인화면에 현재 배속된 사용자/그룹/롤 목록 부분--%>
<c:if test="${aaForm.view == 'existList'}">
	<c:if test="${aaForm.act == 'role'}">
		<form id="gradeRoleMngForm" name="gradeRoleMngForm" onsubmit="return false">
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<colgroup>
					<col width="30px"/>
					<col width="40%"/>
					<col width="*"/>
				</colgroup>
				<thead>
					<th class="first"><span class="table_title"><util:message key="ev.hnevent.label.select"/></span></th>
					<th><span class="table_title"><util:message key="ev.prop.securityGroupRole.roleId"/></span></th>
					<th><span class="table_title"><util:message key="ev.prop.roleName"/></span></th>
				</thead>
				<tbody>
					<c:forEach items="${roleList}" var="role" varStatus="status">
						<tr>
							<td class="C fixed">
								<input type="checkbox" id="role_checkRow_<c:out value="${status.index}"/>" name="role_checkRow" value="<c:out value="${role.codeId}"/>">
							</td>
							<td class="C" onclick="admGradeMngr.doSelect('role',<c:out value="${status.index}"/>)"><c:out value="${role.code}"/></td>
							<td class="C" onclick="admGradeMngr.doSelect('role',<c:out value="${status.index}"/>)"><c:out value="${role.codeName}"/></td></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div class="paging" id="role_page_iterator">				
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->		
			<!-- btnArea-->
			<div class="btnArea"> 
				<div class="rightArea">
					<a href="javascript:admGradeMngr.doChooseRGU('role')" class="btn_O"><span><util:message key="mm.title.new"/></span></a>
					<a href="javascript:admGradeMngr.doRemRGU('role')" class="btn_O"><span><util:message key="mm.title.remove"/></span></a>
				</div>
			</div>
			<!-- btnArea//-->
			<input type="hidden" name="pageNo" value="<c:out value="${aaForm.pageNo}"/>">
	  		<input type="hidden" name="totalSize" value="<c:out value="${aaForm.totalSize}"/>">
		</form>
	</c:if>
	<c:if test="${aaForm.act == 'group'}">
	<form id="gradeGroupMngForm" name="gradeGroupMngForm" onsubmit="return false">
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<colgroup>
				<col width="30px"/>
				<col width="40%"/>
				<col width="*"/>
			</colgroup>
			<thead>
				<th class="first"><span class="table_title"><util:message key="ev.hnevent.label.select"/></span></th>
				<th><span class="table_title"><util:message key="ev.title.statistics.groupId"/></span></th>
				<th><span class="table_title"><util:message key="cf.title.groupName"/></span></th>
			</thead>
			<tbody>
				<c:forEach items="${groupList}" var="group" varStatus="status">
					<tr>
						<td class="C">
							<input type="checkbox" id="group_checkRow_<c:out value="${status.index}"/>" name="group_checkRow" value="<c:out value="${group.codeId}"/>">
						</td>
						<td class="C" onclick="admGradeMngr.doSelect('group',<c:out value="${status.index}"/>)"><c:out value="${group.code}"/></td>
						<td class="C" onclick="admGradeMngr.doSelect('group',<c:out value="${status.index}"/>)"><c:out value="${group.codeName}"/></td>></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div class="paging" id="group_page_iterator">				
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->		
		<!-- btnArea-->
		<div class="btnArea"> 
			<div class="rightArea">
				<a href="javascript:admGradeMngr.doChooseRGU('group')" class="btn_O"><span><util:message key="mm.title.new"/></span></a>
				<a href="javascript:admGradeMngr.doRemRGU('group')" class="btn_O"><span><util:message key="mm.title.remove"/></span></a>
			</div>
		</div>
		<!-- btnArea//-->
		<input type="hidden" name="pageNo" value="<c:out value="${aaForm.pageNo}"/>">
		<input type="hidden" name="totalSize" value="<c:out value="${aaForm.totalSize}"/>">
	</form>
	</c:if>
	<c:if test="${aaForm.act == 'user'}">
		<form id="gradeUserMngForm" name="gradeUserMngForm" onsubmit="return false">
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<colgroup>
					<col width="30px"/>
					<col width="40%"/>
					<col width="*"/>
				</colgroup>
				<thead>
					<th class="first"><span class="table_title"><util:message key="ev.hnevent.label.select"/></span></th>
					<th><span class="table_title"><util:message key="ev.prop.calendarUser.userId"/></span></th>
					<th><span class="table_title"><util:message key="ev.title.user.Username"/></span></th>
				</thead>
				<tbody>
					<c:forEach items="${userList}" var="user" varStatus="status">
						<tr>
							<td class="C">
								<input type="checkbox" id="user_checkRow_<c:out value="${status.index}"/>" name="user_checkRow" value="<c:out value="${user.codeId}"/>">
							</td>
							<td class="C" onclick="admGradeMngr.doSelect('user',<c:out value="${status.index}"/>)"><c:out value="${user.code}"/></td>
							<td class="C" onclick="admGradeMngr.doSelect('user',<c:out value="${status.index}"/>)"><c:out value="${user.codeName}"/></td>></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div class="paging" id="user_page_iterator">				
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->		
			<!-- btnArea-->
			<div class="btnArea"> 
				<div class="rightArea">
					<a href="javascript:admGradeMngr.doChooseRGU('user')" class="btn_O"><span><util:message key="mm.title.new"/></span></a>
					<a href="javascript:admGradeMngr.doRemRGU('user')" class="btn_O"><span><util:message key="mm.title.remove"/></span></a>
				</div>
			</div>
			<!-- btnArea//-->
			<input type="hidden" name="pageNo" value="<c:out value="${aaForm.pageNo}"/>">
			<input type="hidden" name="totalSize" value="<c:out value="${aaForm.totalSize}"/>">
		</form>
	</c:if>
</c:if>
<%--BEGIN::사용자/그룹/롤 <util:message key="ev.hnevent.label.select"/> 팝업 화면 부분--%>
<c:if test="${aaForm.view == 'chooseList'}">
	<c:if test="${aaForm.act == 'role'}">
		<div class="tsearchArea">
			<p style="background: none;"><img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle> 현재 등급에 배속된 역할</p>
			<fieldset>
				<form id="abmRoleChooserForm" style="display:inline" name="abmRoleChooserForm" action="" method="post" onsubmit="return false;">
					<input type='hidden' name='totalSize' value="<c:out value="${aaForm.totalSize}"/>"/>
					<input type="text" name="srchShortPath" class="txt_100" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.roleId"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.roleId"/>');"
				       <c:if test="${empty aaForm.srchShortPath}">value="<util:message key="eb.info.ttl.l.roleId"/>"</c:if><c:if test="${!empty aaForm.srchShortPath}">value="<c:out value="${aaForm.srchShortPath}"/>"</c:if>>
					<input type="text" name="srchPrincipalName" class="txt_100" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.roleNm"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.roleNm"/>');"
					       <c:if test="${empty aaForm.srchPrincipalName}">value="<util:message key="eb.info.ttl.l.roleNm"/>"</c:if><c:if test="${!empty aaForm.srchPrincipalName}">value="<c:out value="${aaForm.srchPrincipalName}"/>"</c:if>>
					<a href="javascript:admGradeMngr.getRoleChooser().doSearch()" class="btn_search">
						<span><util:message key='ev.title.search'/></span>
					</a>
				</form>
			</fieldset>
		</div>
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<colgroup>
				<col width="30px"/>
				<col width="40%"/>
				<col width="*"/>
			</colgroup>
			<thead>
				<tr>
					<th class="first"><input type="checkbox" id="delCheck" onclick="admGradeMngr.getRoleChooser().m_checkBox.chkAll(this)"/></th>
					<th ch="0"><span class="table_title"><util:message key="ev.prop.securityUserRole.roleId"/></span></th>
					<th ch="0"><span class="table_title"><util:message key="ev.prop.roleName"/></span></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${roleList}" var="role" varStatus="status">
				<tr>
					<td class="C fixed"><input type="checkbox" id="roleChooser_checkRow_<c:out value="${status.index}"/>" name="roleChooser_checkRow" value="<c:out value="${role.codeId}"/>"></td>
					<td class="L" onclick="admGradeMngr.getRoleChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${role.code}"/></td>
					<td class="L" onclick="admGradeMngr.getRoleChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${role.codeName}"/></td>
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
	</c:if>
	<c:if test="${aaForm.act == 'group'}">
		<div class="tsearchArea">
			<p style="background: none;"><img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle> 현재 등급에 배속된 그룹</p>
			<fieldset>
				<form id="abmGroupChooserForm" name="abmGroupChooserForm" onsubmit="return false">
					<input type="text" name="srchShortPath" class="txt_100" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.groupId"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.groupId"/>');"
					       <c:if test="${empty aaForm.srchShortPath}">value="<util:message key="eb.info.ttl.l.groupId"/>"</c:if><c:if test="${!empty aaForm.srchShortPath}">value="<c:out value="${aaForm.srchShortPath}"/>"</c:if>>
					<input type="text" name="srchPrincipalName" class="txt_100" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.groupNm"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.groupNm"/>');"
					       <c:if test="${empty aaForm.srchPrincipalName}">value="<util:message key="eb.info.ttl.l.groupNm"/>"</c:if><c:if test="${!empty aaForm.srchPrincipalName}">value="<c:out value="${aaForm.srchPrincipalName}"/>"</c:if>>	       
					<a href="javascript:admGradeMngr.getGroupChooser().doSearch()" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
				</form>
			</fieldset>
		</div>
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<colgroup>
				<col width="30px"/>
				<col width="40%"/>
				<col width="*"/>
			</colgroup>
			<thead>
				<tr>
					<th class="first"><input type="checkbox" id="delCheck" onclick="admGradeMngr.getGroupChooser().m_checkBox.chkAll(this)"/></th>
					<th ch="0"><span class="table_title"><util:message key="ev.prop.securityGroupRole.groupId"/></span></th>
					<th ch="0"><span class="table_title"><util:message key="cf.title.groupName"/></span></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${groupList}" var="group" varStatus="status">
					<tr>
						<td class="C fixed"><input type="checkbox" id="groupChooser_checkRow_<c:out value="${status.index}"/>" name="groupChooser_checkRow" value="<c:out value="${group.codeId}"/>"></td>
						<td class="L" onclick="admGradeMngr.getGroupChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${group.code}"/></td>
						<td class="L" onclick="admGradeMngr.getGroupChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${group.codeName}"/></td>
					</tr>
				</c:forEach>
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
	</c:if>
	<c:if test="${aaForm.act == 'user'}">
		<div class="tsearchArea">
			<p style="background: none;"><img src='<%=evcp%>/board/images/admin/ic_triangle.gif' style='margin:0px 5px 0px 0px;' align=absmiddle> 현재 등급에 배속된 사용자</p>
			<fieldset>
				<form id="abmUserChooserForm" style="display:inline" name="abmUserChooserForm" action="" method="post" onsubmit="return false;">
					<input type='hidden' name='totalSize' value="<c:out value="${aaForm.totalSize}"/>"/>
					<input type="text" name="srchUserId" class="txt_100" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.id"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.id"/>');"
				       <c:if test="${empty aaForm.srchUserId}">value="<util:message key="eb.info.ttl.l.id"/>"</c:if><c:if test="${!empty aaForm.srchUserId}">value="<c:out value="${aaForm.srchUserId}"/>"</c:if>>
					<input type="text" name="srchNmKor" class="txt_100" onfocus="ebUtil.whenSrchFocus(this,'<util:message key="eb.info.ttl.l.name"/>');" onblur="ebUtil.whenSrchBlur(this,'<util:message key="eb.info.ttl.l.name"/>');"
				       <c:if test="${empty aaForm.srchNmKor}">value="<util:message key="eb.info.ttl.l.name"/>"</c:if><c:if test="${!empty aaForm.srchNmKor}">value="<c:out value="${aaForm.srchNmKor}"/>"</c:if>>
					<a href="javascript:admGradeMngr.getUserChooser().doSearch()" class="btn_search">
						<span><util:message key='ev.title.search'/></span>
					</a>
				</form>
			</fieldset>
		</div>
		<form>
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<colgroup>
				<col width="30px"/>
				<col width="40%"/>
				<col width="*"/>
			</colgroup>
			<thead>
				<tr>
					<th class="first"><input type="checkbox" id="delCheck" onclick="admGradeMngr.getUserChooser().m_checkBox.chkAll(this)"/></th>
					<th ch="0"><span class="table_title"><util:message key="ev.prop.calendarUser.userId"/></span></th>
					<th ch="0"><span class="table_title"><util:message key="ev.prop.userName"/></span></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${userList}" var="user" varStatus="status">
				<tr>
					<td class="C fixed"><input type="checkbox" id="userChooser_checkRow_<c:out value="${status.index}"/>" name="userChooser_checkRow" value="<c:out value="${user.codeId}"/>"></td>
					<td class="L" onclick="admGradeMngr.getUserChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${user.code}"/></td>
					<td class="L" onclick="admGradeMngr.getUserChooser().doSelect(<c:out value="${status.index}"/>)"><c:out value="${user.codeName}"/></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		</form>
		<!-- tcontrol-->
		<div class="tcontrol">
			<!-- paging -->
			<div class="paging" id="abmUserChooserPageIterator">				
			</div>
			<!-- paging//-->
		</div>
		<!-- tcontrol//-->
	</c:if>
</c:if>
<c:if test="${empty aaForm.view}">
<div id="abmRoleChooser" title="<util:message key="eb.title.roleChooser"/>"></div>
<div id="abmGroupChooser" title="<util:message key="eb.title.groupChooser"/>"></div>
<div id="abmUserChooser" title="<util:message key="eb.title.userChooser"/>"></div>
<link rel="stylesheet" type="text/css" href="<%=evcp%>/board/css/admin/admin-common.css">
<script type="text/javascript" src="<%=evcp%>/board/javascript/enboard_util.js"></script>
<script type="text/javascript">
AdmGradeMngr = function() {
	//var offset = location.href.indexOf (location.host) + location.host.length;
	//this.m_contextPath = location.href.substring (offset, location.href.indexOf('/', offset + 1));
	this.m_contextPath = portalPage.getContextPath();
	this.m_ajax = new enview.util.Ajax();
	this.m_ajax.setContextPath (this.m_contextPath);
	this.m_pageNavi = new enview.util.PageNavigationUtil();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	this.m_curAcco = 0;
	this.init();
}
AdmGradeMngr.prototype = {
	m_contextPath : null,
	m_ajax : null,
	m_pageNavi : null,
	m_checkBox : null,
	m_msgBox : null,

	m_curAcco : null,
	m_selGradeId : null,
	m_act : null,
	m_pageSize : 5,
	
	init : function() {
		$("#authAccordion").accordion({
			autoHeight: false,
			active: 1, // 'change' Event 를 발생시키기 위해 생성 시 두번째 아코디언을 <util:message key="ev.hnevent.label.select"/>.
			change: function(event,ui) { 
				admGradeMngr.m_curAcco = $("#authAccordion").accordion("option","active");
				switch (admGradeMngr.m_curAcco) {
					case 0:
						if (document.getElementById("role_grade"))  admGradeMngr.doSelectGrade("role", ebUtil.getSelectedValue(document.getElementById("role_grade")));
						break;
					case 1:
						if (document.getElementById("group_grade")) admGradeMngr.doSelectGrade("group", ebUtil.getSelectedValue(document.getElementById("group_grade")));
						break;
					case 2:
						if (document.getElementById("user_grade"))  admGradeMngr.doSelectGrade("user", ebUtil.getSelectedValue(document.getElementById("user_grade")));
						break;
				}
			}
		});
		$("#authAccordion").accordion("activate", this.m_curAcco); // 초기화후 첫번째 아코디언을 선택해줌.
	},
	doGrdSelect : function( idx ) {
		this.m_ownGrdCheckedRow = idx;
		var checkedRow = document.getElementById("checkRow_"+this.m_ownGrdCheckedRow);

		this.m_checkBox.unChkAll( document.getElementById("grdMngForm"));
		checkedRow.checked = true;
		
		document.getElementById("grd_act").value = "upd";
		document.getElementById("grade").value = checkedRow.value;
		document.getElementById("gradeNm").value = checkedRow.getAttribute("gradeNm");
		document.getElementById("gradeDesc").value = checkedRow.getAttribute("gradeDesc");
		document.getElementById("grdEditDiv").style.display = "";
	},
	doGrdCreate : function() {
		document.getElementById("grd_act").value = "ins";
		document.getElementById("grade").value = "";
		document.getElementById("gradeNm").value = "";
		document.getElementById("gradeDesc").value = "";
		document.getElementById("grdEditDiv").style.display = "";
		document.getElementById("gradeNm").focus();
	},
	doGrdSave : function() {
		var act = document.getElementById("grd_act").value;
		if(!ebUtil.chkValue( document.getElementById("gradeNm"), '<util:message key="eb.title.o.gradeNm"/>', true)) return;

		var param = "m=setBoardDefaultGrade";
		param += "&act=" + act;
		param += "&code="     + document.getElementById("grade").value;
		param += "&codeName=" + document.getElementById("gradeNm").value;
		param += "&remark="   + document.getElementById("gradeDesc").value;

		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(data) { admGradeMngr.doGrdSaveHandler( data ); }});
	},
	doGrdDelete : function() {
		if( !ebUtil.chkCheck( document.getElementsByName("checkRow"), '등급코드를', true )) return;

		if( confirm( ebUtil.getMessage("ev.info.remove"))) {
			document.getElementById("grd_act").value = "del";
			
			var param = "m=setBoardDefaultGrade";
			param += "&act=" + "del";
			param += "&boardId=" + this.m_curBoardId;
			param += "&code="    + ebUtil.getCheckedValues( document.getElementsByName("checkRow"));
			
			this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(data) { admGradeMngr.doGrdSaveHandler(data); }});
		}
	},
	doGrdUp : function( idx ) {
		document.getElementById("grd_act").value = "up";
		var checkedRow = document.getElementById("checkRow_"+idx);

		var param = "m=setBoardDefaultGrade";
		param += "&act=" + "up";
		param += "&boardId=" + this.m_curBoardId;
		param += "&code="   + checkedRow.value;
		
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(data) { admGradeMngr.doGrdSaveHandler(data); }});
	},
	doGrdDown : function( idx ) {
		document.getElementById("grd_act").value = "down";
		var checkedRow = document.getElementById("checkRow_"+idx);

		var param = "m=setBoardDefaultGrade";
		param += "&act=" + "down";
		param += "&boardId=" + this.m_curBoardId;
		param += "&code="   + checkedRow.value;
		
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(data) { admGradeMngr.doGrdSaveHandler(data); }});
	},
	doGrdSaveHandler : function( data ) {
		var act = document.getElementById("grd_act").value;
		if( act == "ins" ) {
			admGradeMngr.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.add"));
		} else if( act == "upd" || act == "up" || act == "down" ) {
			admGradeMngr.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.update"));
		} else if( act == "del" ) {
			admGradeMngr.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.delete"));
		}
		location.reload(); // 데이터 변경 후 화면 갱신.
	},
	doSelectGrade : function(act, selGradeId, pageNo) {
		if (selGradeId != null && selGradeId != "") this.m_selGradeId = selGradeId;
		if (this.m_selGradeId != null) {
			if (act != null && act != "") this.m_act = act;
			var param = "m=uiGradeRGUList";
			param += "&cmd="        + "common";
			param += "&act="        + this.m_act;
			param += "&view="       + "existList";
			param += "&pageNo="     + ((pageNo != null && pageNo != "") ? pageNo : 1);
			param += "&pageSize="   + this.m_pageSize;
			param += "&selGradeId=" + this.m_selGradeId;
			this.m_ajax.send("POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(data) { admGradeMngr.doSelectGradeHandler(data); }});
		}
	},
	doSelectGradeHandler : function (htmlData) {
		if( this.m_act == "role"  ) {
			document.getElementById("gradeRoleDiv").innerHTML  = htmlData;
			var pageNo    = document.gradeRoleMngForm.pageNo.value;
			var totalSize = document.gradeRoleMngForm.totalSize.value;
			document.getElementById("role_page_iterator").innerHTML 
			= this.m_pageNavi.getPageIteratorHtmlString( pageNo, this.m_pageSize, totalSize, "gradeRoleMngForm", "admGradeMngr.doRolePage");
		}
		if( this.m_act == "group" ) {
			document.getElementById("gradeGroupDiv").innerHTML = htmlData;
			var pageNo    = document.gradeGroupMngForm.pageNo.value;
			var totalSize = document.gradeGroupMngForm.totalSize.value;
			document.getElementById("group_page_iterator").innerHTML 
			= this.m_pageNavi.getPageIteratorHtmlString( pageNo, this.m_pageSize, totalSize, "gradeGroupMngForm", "admGradeMngr.doGroupPage");
		}
		if( this.m_act == "user"  ) {
			document.getElementById("gradeUserDiv").innerHTML  = htmlData;
			var pageNo    = document.gradeUserMngForm.pageNo.value;
			var totalSize = document.gradeUserMngForm.totalSize.value;
			document.getElementById("user_page_iterator").innerHTML 
			= this.m_pageNavi.getPageIteratorHtmlString( pageNo, this.m_pageSize, totalSize, "gradeUserMngForm", "admGradeMngr.doUserPage");
		}
	},
	doRolePage : function  (formName, pageNo) {
		admGradeMngr.doSelectGrade ("role", "", pageNo);
	},
	doGroupPage : function (formName, pageNo) {
		admGradeMngr.doSelectGrade ("group", "", pageNo);
	},
	doUserPage : function  (formName, pageNo) {
		admGradeMngr.doSelectGrade ("user", "", pageNo);
	},
	doChooseRGU : function (act) {
		if (act == "role" )	admGradeMngr.getRoleChooser().doShow (this.m_curBoardId, this.m_selGradeId);
		if (act == "group") admGradeMngr.getGroupChooser().doShow(this.m_curBoardId, this.m_selGradeId);
		if (act == "user" )	admGradeMngr.getUserChooser().doShow (this.m_curBoardId, this.m_selGradeId);
	},
	doSelect : function (act, idx) {
		var checkedRow;
		if (act == "role" ) checkedRow = document.getElementById ("role_checkRow_"+idx );
		if (act == "group") checkedRow = document.getElementById ("group_checkRow_"+idx);
		if (act == "user" ) checkedRow = document.getElementById ("user_checkRow_"+idx );
		if (checkedRow.checked) checkedRow.checked = false;
		else                    checkedRow.checked = true;
	},
	doAddRGU : function (act, rguIds) {
		this.m_act = act;
		var param = "m=setGradeRGUList";
		param += "&act=" + this.m_act;
		param += "&cmd=" + "add";
		param += "&selGradeId=" + this.m_selGradeId;
		param += "&rguIds="     + rguIds;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(data) { admGradeMngr.doSaveRGUHandler( data ); }});
	},
	doRemRGU : function (act) {
		this.m_act = act;
		var rguIds = "";
		if (this.m_act == "role") {
			if (!ebUtil.chkCheck (document.getElementsByName("role_checkRow"), '삭제하고자 하는 역할을', true)) return;
			rguIds = ebUtil.getCheckedValues(document.getElementsByName("role_checkRow"));
		}
		if (this.m_act == "group") {
			if (!ebUtil.chkCheck (document.getElementsByName("group_checkRow"), '삭제하고자 하는 그룹을', true)) return;
			rguIds = ebUtil.getCheckedValues(document.getElementsByName("group_checkRow"));
		}
		if (this.m_act == "user") {
			if( !ebUtil.chkCheck (document.getElementsByName("user_checkRow"), '삭제하고자 하는 사용자를', true)) return;
			rguIds = ebUtil.getCheckedValues(document.getElementsByName("user_checkRow"));
		}
		if (confirm (ebUtil.getMessage("ev.info.remove"))) {
			var param = "m=setGradeRGUList";
			param += "&act=" + this.m_act;
			param += "&cmd=" + "rem";
			param += "&selGradeId=" + this.m_selGradeId;
			param += "&rguIds="     + rguIds;
			this.m_ajax.send ("POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(data) { admGradeMngr.doSaveRGUHandler(data); }});
		}
	},
	doSaveRGUHandler : function(data) {
		admGradeMngr.getMsgBox().doShow( ebUtil.getMessage("mm.info.success"));
		admGradeMngr.doSelectGrade();		
	},
	getRoleChooser : function() {
		if (this.m_roleChooser) return this.m_roleChooser;
		this.m_roleChooser = new RoleChooser(this);
		return this.m_roleChooser;
	},
	getGroupChooser : function() {
		if (this.m_groupChooser) return this.m_groupChooser;
		this.m_groupChooser = new GroupChooser(this);
		return this.m_groupChooser;
	},
	getUserChooser : function() {
		if (this.m_userChooser) return this.m_userChooser;
		this.m_userChooser = new UserChooser(this);
		return this.m_userChooser;
	},
	getMsgBox : function() {
		if (this.m_msgBox == null) {
			if ( enviewMessageBox == null ) {
				enviewMessageBox = new enview.portal.MessageBox(300, 100, 1000);
			}
			this.m_msgBox = enviewMessageBox;
		}
		return this.m_msgBox
	}
}
RoleChooser = function( parent ) {
	this.m_elmArea = document.getElementById("abmRoleChooser");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_pageNavi = parent.m_pageNavi;
	this.m_checkBox = parent.m_checkBox;
	
	$("#abmRoleChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:600, 
		modal: true,
		buttons: {
			Cancel: function() {
				admGradeMngr.getRoleChooser().m_pageNo = 1;
				$(this).dialog('close');
			},
			Apply: function() {
				if( !ebUtil.chkCheck( document.getElementsByName("roleChooser_checkRow"), '추가하고자 하는 역할을', true )) return;
				admGradeMngr.getRoleChooser().m_pageNo = 1;
				admGradeMngr.doAddRGU('role',ebUtil.getCheckedValues( document.getElementsByName("roleChooser_checkRow")));
				$(this).dialog('close');
			}
		}
	});
}
RoleChooser.prototype = {
	m_elmArea : null,
	m_checkedRow : null,
	m_contextPath : null,
	m_ajax : null,
	m_pageNavi : null,
	m_checkBox : null,
	m_curBoardId : null,
	m_selGradeId : null,
	m_pageNo : 1,
	m_pageSize : 5,
	m_totalSize : null,
	
	doGet : function() {
		var param = "m=uiGradeRGUList";
		param += "&cmd="        + "common";
		param += "&act="        + "role";
		param += "&view="       + "chooseList";
		param += "&boardId="    + this.m_curBoardId;
		param += "&selGradeId=" + this.m_selGradeId;
		param += "&pageNo="     + this.m_pageNo;
		param += "&pageSize="   + this.m_pageSize;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(htmlData) { admGradeMngr.getRoleChooser().doGetHandler( htmlData ); }});		
	},
	doShow : function( boardId, selGradeId ) {
		this.m_curBoardId = boardId;
		this.m_selGradeId = selGradeId;
		admGradeMngr.getRoleChooser().doGet();
		$('#abmRoleChooser').dialog('open');
	},
	doGetHandler : function( htmlData ) {
		this.m_checkedRow = null; // 초기화
		this.m_elmArea.innerHTML = htmlData;
		this.m_totalSize = document.abmRoleChooserForm.totalSize.value;
		document.getElementById("abmRoleChooserPageIterator").innerHTML 
		= this.m_pageNavi.getPageIteratorHtmlString( this.m_pageNo, this.m_pageSize, this.m_totalSize, "abmRoleChooserForm", "admGradeMngr.getRoleChooser().doPage");
		
		var frm = document.abmRoleChooserForm;
		if( frm.srchShortPath.value     == "") frm.srchShortPath.value     = '<util:message key="eb.info.ttl.l.roleId"/>';
		if (frm.srchPrincipalName.value == "") frm.srchPrincipalName.value = '<util:message key="eb.info.ttl.l.roleNm"/>';

	},
	doPage : function( formName, pageNo ) {
		this.m_pageNo = pageNo;
		admGradeMngr.getRoleChooser().doGet();
	},
	doSelect : function( idx ) {
		var checkedRow = document.getElementById( "roleChooser_checkRow_"+idx );
		if(checkedRow.checked) checkedRow.checked = false;
		else                   checkedRow.checked = true;
	},
	doSearch : function() {
		var frm = document.abmRoleChooserForm;
		if (frm.srchShortPath.value     == '<util:message key="eb.info.ttl.l.roleId"/>') frm.srchShortPath.value     = "";
		if (frm.srchPrincipalName.value == '<util:message key="eb.info.ttl.l.roleNm"/>') frm.srchPrincipalName.value = "";
		var param = "m=uiGradeRGUList";
		param += "&cmd="        + "common";
		param += "&act="        + "role";
		param += "&view="       + "chooseList";
		param += "&boardId="    + this.m_curBoardId;
		param += "&selGradeId=" + this.m_selGradeId;
		param += "&pageNo="     + 1;
		param += "&pageSize="   + this.m_pageSize;
		param += "&srchShortPath=" + frm.srchShortPath.value;
		param += "&srchPrincipalName=" + encodeURIComponent(frm.srchPrincipalName.value);
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(htmlData) { admGradeMngr.getRoleChooser().doGetHandler( htmlData ); }});		
	}
}
GroupChooser = function( parent ) {
	this.m_elmArea = document.getElementById("abmGroupChooser");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_pageNavi = parent.m_pageNavi;
	this.m_checkBox = parent.m_checkBox;
	
	$("#abmGroupChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:600, 
		modal: true,
		buttons: {
			Cancel: function() {
				admGradeMngr.getGroupChooser().m_pageNo = 1;
				$(this).dialog('close');
			},
			Apply: function() {
				if( !ebUtil.chkCheck( document.getElementsByName("groupChooser_checkRow"), '추가하고자 하는 그룹을', true )) return;
				admGradeMngr.getGroupChooser().m_pageNo = 1;
				admGradeMngr.doAddRGU('group',ebUtil.getCheckedValues( document.getElementsByName("groupChooser_checkRow")));
				$(this).dialog('close');
			}
		}
	});
}
GroupChooser.prototype = {
	m_elmArea : null,
	m_checkedRow : null,
	m_ajax : null,
	m_pageNavi : null,
	m_contextPath : null,
	m_checkBox : null,
	m_curBoardId : null,
	m_selGradeId : null,
	m_pageNo : 1,
	m_pageSize : 5,
	m_totalSize : null,
	
	doGet : function() {
		var param = "m=uiGradeRGUList";
		param += "&cmd="        + "common";
		param += "&act="        + "group";
		param += "&view="       + "chooseList";
		param += "&boardId="    + this.m_curBoardId;
		param += "&selGradeId=" + this.m_selGradeId;
		param += "&pageNo="     + this.m_pageNo;
		param += "&pageSize="   + this.m_pageSize;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(htmlData) { admGradeMngr.getGroupChooser().doGetHandler( htmlData ); }});		
	},
	doShow : function( boardId, selGradeId ) {
		this.m_curBoardId = boardId;
		this.m_selGradeId = selGradeId;
		admGradeMngr.getGroupChooser().doGet();
		$('#abmGroupChooser').dialog('open');
	},
	doGetHandler : function( htmlData ) {
		this.m_checkedRow = null; // 초기화
		this.m_elmArea.innerHTML = htmlData;
		this.m_totalSize = document.abmGroupChooserForm.totalSize.value;
		document.getElementById("abmGroupChooserPageIterator").innerHTML 
		= this.m_pageNavi.getPageIteratorHtmlString( this.m_pageNo, this.m_pageSize, this.m_totalSize, "abmGroupChooserForm", "admGradeMngr.getGroupChooser().doPage");
		
		var frm = document.abmGroupChooserForm;
		if( frm.srchShortPath.value     == "") frm.srchShortPath.value     = '<util:message key="eb.info.ttl.l.groupId"/>';
		if (frm.srchPrincipalName.value == "") frm.srchPrincipalName.value = '<util:message key="eb.info.ttl.l.groupNm"/>';

	},
	doPage : function( formName, pageNo ) {
		this.m_pageNo = pageNo;
		admGradeMngr.getGroupChooser().doGet();
	},
	doSelect : function( idx ) {
		var checkedRow = document.getElementById( "groupChooser_checkRow_"+idx );
		if(checkedRow.checked) checkedRow.checked = false;
		else                   checkedRow.checked = true;
	},
	doSearch : function() {
		var frm = document.abmGroupChooserForm;
		if (frm.srchShortPath.value     == '<util:message key="eb.info.ttl.l.groupId"/>') frm.srchShortPath.value     = "";
		if (frm.srchPrincipalName.value == '<util:message key="eb.info.ttl.l.groupNm"/>') frm.srchPrincipalName.value = "";
		var param = "m=uiGradeRGUList";
		param += "&cmd="        + "common";
		param += "&act="        + "group";
		param += "&view="       + "chooseList";
		param += "&boardId="    + this.m_curBoardId;
		param += "&selGradeId=" + this.m_selGradeId;
		param += "&pageNo="     + 1;
		param += "&pageSize="   + this.m_pageSize;
		param += "&srchShortPath=" + frm.srchShortPath.value;
		param += "&srchPrincipalName=" + encodeURIComponent(frm.srchPrincipalName.value);
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(htmlData) { admGradeMngr.getGroupChooser().doGetHandler( htmlData ); }});		
	}
}
UserChooser = function( parent ) {
	this.m_elmArea = document.getElementById("abmUserChooser");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_pageNavi = parent.m_pageNavi;
	this.m_checkBox = parent.m_checkBox;
	
	$("#abmUserChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:600, 
		modal: true,
		buttons: {
			Cancel: function() {
				admGradeMngr.getUserChooser().m_pageNo = 1;
				$(this).dialog('close');
			},
			Apply: function() {
				if( !ebUtil.chkCheck( document.getElementsByName("userChooser_checkRow"), '추가하고자 하는 사용자를', true )) return;
				admGradeMngr.getUserChooser().m_pageNo = 1;
				admGradeMngr.doAddRGU('user',ebUtil.getCheckedValues( document.getElementsByName("userChooser_checkRow")));
				$(this).dialog('close');
			}
		}
	});
}
UserChooser.prototype = {
	m_elmArea : null,
	m_checkedRow : null,
	m_contextPath : null,
	m_ajax : null,
	m_pageNavi : null,
	m_checkBox : null,
	m_curBoardId : null,
	m_selGradeId : null,
	m_pageNo : 1,
	m_pageSize : 5,
	m_totalSize : null,
	
	doGet : function() {
		var param = "m=uiGradeRGUList";
		param += "&cmd="        + "common";
		param += "&act="        + "user";
		param += "&view="       + "chooseList";
		param += "&boardId="    + this.m_curBoardId;
		param += "&selGradeId=" + this.m_selGradeId;
		param += "&pageNo="     + this.m_pageNo;
		param += "&pageSize="   + this.m_pageSize;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(htmlData) { admGradeMngr.getUserChooser().doGetHandler( htmlData ); }});		
	},
	doShow : function( boardId, selGradeId ) {
		this.m_curBoardId = boardId;
		this.m_selGradeId = selGradeId;
		admGradeMngr.getUserChooser().doGet();
		$('#abmUserChooser').dialog('open');
	},
	doGetHandler : function( htmlData ) {
		this.m_checkedRow = null; // 초기화
		this.m_elmArea.innerHTML = htmlData;
		this.m_totalSize = document.abmUserChooserForm.totalSize.value;
		document.getElementById("abmUserChooserPageIterator").innerHTML 
		= this.m_pageNavi.getPageIteratorHtmlString( this.m_pageNo, this.m_pageSize, this.m_totalSize, "abmUserChooserForm", "admGradeMngr.getUserChooser().doPage");
		
		var frm = document.abmUserChooserForm;
		if( frm.srchUserId.value == "") frm.srchUserId.value = '<util:message key="eb.info.ttl.l.id"/>';
		if (frm.srchNmKor.value  == "") frm.srchNmKor.value  = '<util:message key="eb.info.ttl.l.name"/>';

	},
	doPage : function( formName, pageNo ) {
		this.m_pageNo = pageNo;
		admGradeMngr.getUserChooser().doGet();
	},
	doSelect : function( idx ) {
		var checkedRow = document.getElementById( "userChooser_checkRow_"+idx );
		if(checkedRow.checked) checkedRow.checked = false;
		else                   checkedRow.checked = true;
	},
	doSearch : function() {
		var frm = document.abmUserChooserForm;
		if (frm.srchUserId.value == '<util:message key="eb.info.ttl.l.id"/>')   frm.srchUserId.value = "";
		if (frm.srchNmKor.value  == '<util:message key="eb.info.ttl.l.name"/>') frm.srchNmKor.value  = "";
		var param = "m=uiGradeRGUList";
		param += "&cmd="        + "common";
		param += "&act="        + "user";
		param += "&view="       + "chooseList";
		param += "&boardId="    + this.m_curBoardId;
		param += "&selGradeId=" + this.m_selGradeId;
		param += "&pageNo="     + 1;
		param += "&pageSize="   + this.m_pageSize;
		param += "&srchUserId=" + frm.srchUserId.value;
		param += "&srchNmKor="  + encodeURIComponent(frm.srchNmKor.value);
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(htmlData) { admGradeMngr.getUserChooser().doGetHandler( htmlData ); }});		
	}
}

function initAdmGradeMngr() {
	admGradeMngr = new AdmGradeMngr();
}
function finishAdmGradeMngr() {
}
// Attach to the onload event
if (window.attachEvent) {
    window.attachEvent ("onload", initAdmGradeMngr);
	window.attachEvent ("onunload", finishAdmGradeMngr);
} else if (window.addEventListener ) {
    window.addEventListener ("load", initAdmGradeMngr, false);
	window.addEventListener ("unload", finishAdmGradeMngr, false);
} else {
    window.onload = initAdmGradeMngr;
	window.onunload = finishAdmGradeMngr;
}
</script>
</c:if>