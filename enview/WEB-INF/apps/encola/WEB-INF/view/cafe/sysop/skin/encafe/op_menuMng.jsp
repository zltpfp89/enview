<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.saltware.encola.common.vo.CmntMenuVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<script type="text/javascript">
<!--
function checkEmpty( e) {
	if( e.value=='') {
		alert( '반드시 입력해야 합니다');
		return false;
	}
}
//-->
</script>
<div class="cafeadm_top">
	<h3><util:message key="cf.title.management.menu"/></h3>
	<ul class="location">
		<li>HOME<span class="nextbar"></span></li>
		<li><util:message key="cf.title.mng.menuBoard"/><span class="nextbar"></span></li>
		<li class="last"><util:message key="cf.title.management.menu"/></li>
	</ul>
</div>
<!--
	<div class="board_btn_wrap top">
		<div class="board_btn_wrap_right">
			<a href="#" onclick="javascript:cfOp.menuMng.getTrash().doGet()" class="btn white">삭제 보관된 메뉴 목록 보기</a>
		</div>
	</div>
 -->
<div class="cafeadm_menu_wrap">
	<div class="cafeadm_menu_list">
		<div class="cafeadm_menu_list_top">
			<select id="menu_menuType" name="menu_menuType" class="menu_menuType">
				  <c:forEach items="${typeList}" var="type">
			  			<option value="<c:out value="${type.code}"/>" cnttType="<c:out value="${type.codeTag}"/>" cnttUrl="<c:out value="${type.remark}"/>"><c:out value="${type.codeName}"/></option>
			  	  </c:forEach>
			</select>
			<button class="add" onclick="javascript:cfOp.menuMng.affectMenuItem('add')"><util:message key="eb.info.note.label.add"/></button>
		</div>
		
		<ul id="menu_menuTree" class="cafeadm_menu_list_middle">
		  <c:forEach items="${menuList}" var="menu">
		  <li class="menuList" id="menu_menuLi" name="menu_menuLi" 
			  menuId="<c:out value="${menu.menuId}"/>" menuType="<c:out value="${menu.menuType}"/>" isSelected="F" isCollapsed="F"
			  cnttType="<c:out value="${menu.cnttType}"/>" menuLevel="<c:out value="${menu.menuLevel}"/>"
			  onmousedown="cfOp.menuMng.selectMenu(this)"
		  >
			<span class="menuLabel <c:if test="${menu.menuLevel != '1'}">indent_<c:out value="${menu.menuLevel}"/></c:if>">
			  <c:if test="${menu.menuType != 'S'}"><c:if test="${menu.menuLevel != '1'}">└</c:if><c:out value="${menu.menuNm}"/></c:if>
			  <c:if test="${menu.menuType == 'S'}">--------------------</c:if>
			</span>
			<img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/tiny_up_arrow.gif" menuId="<c:out value="${menu.menuId}"/>"
				 onclick="cfOp.menuMng.toggleMenuGroup(this)" style="cursor:pointer;vertical-align:middle;<c:if test="${menu.menuType != 'G'}">display:none</c:if>"
			>
			<ul id="menu_hiddenUl<c:out value="${menu.menuId}"/>" name="menu_hiddenUl<c:out value="${menu.menuId}"/>" style="display:none"></ul>
		  </c:forEach>
		</ul>
		<div class="cafeadm_menu_list_bottom">
			<div class="fl">
				<button onclick="cfOp.menuMng.affectMenuItem('first')" class="top"><util:message key="cf.prop.top"/></button>
				<button onclick="cfOp.menuMng.affectMenuItem('up')" class="up"><util:message key="cf.prop.up"/></button>
				<button onclick="cfOp.menuMng.affectMenuItem('down')" class="down"><util:message key="cf.prop.down"/></button>
				<button onclick="cfOp.menuMng.affectMenuItem('last')" class="bottom"><util:message key="cf.prop.bottom"/></button>
			</div>
			<div class="fr">
				<button onclick="cfOp.menuMng.affectMenuItem('indent')" class="indent"><util:message key="cf.prop.indent"/></button>
				<button class="del" onclick="javascript:cfOp.menuMng.affectMenuItem('remove')"><util:message key="cf.title.remove"/></button>
			</div>
		</div>
	</div>
    <div class="cafeadm_menu_right">
    	<c:forEach items="${menuList}" var="menu">
		  <%
			CmntMenuVO menuVO = (CmntMenuVO)pageContext.getAttribute("menu");
			String menuType = menuVO.getMenuType();
			String cnttType = menuVO.getCnttType();
		  %>
    	<div id="menu_form<c:out value="${menu.menuId}"/>" class="cafeadm_menu_contents" style="display:none">
			<table class="table_type01 write" summary="게시판">
				<caption><util:message key="cf.title.basicInfo"/><c:out value="${menu.menuType}"/></caption>
				<colgroup>
					<col width="150px;">
					<col width="600px;">
				</colgroup>
				<tbody>
				 <c:if test="${menu.menuType == 'S'}">
				  	<tr id="trCommentS" >
				  		<td colspan="100" width="100%" height="30" class="cafeformlabellast" align="center" style="text-align:center">
				  			<util:message key="cf.info.separator"/>
				  		</td>
				  	</tr>
				  </c:if>
				  <c:if test="${menu.menuType == 'E'}">
				  	<tr id="trCommentE" >
				  		<td colspan="100" width="100%" height="30" class="cafeformlabellast" align="center" style="text-align:center">
				  			<util:message key="cf.info.margin"/>
				  		</td>
				  	</tr>
				  </c:if>
				<tr id="trMenuNm" <c:if test="${menu.menuType == 'E' || menu.menuType == 'S'}">style="display:none"</c:if>>
				  <th><label for="in_txt_01"><util:message key="cf.title.menuName"/></label></th>
				  <td>
					<input type="text" id="menu_menuNm" name="menu_menuNm" value="<c:out value="${menu.menuNm}"/>" class="w_p100"
						   <c:if test="${menu.cnttType=='90'||menu.cnttType=='91'||menu.cnttType=='92'||menu.cnttType=='93'}">disabled</c:if>
						   onblue="checkEmpty(this)"
						   /> 
				  </td>
				</tr>
				
				<tr id="trMenuDesc"
				<% if (!"M".equals(menuType) || cnttType.startsWith("9")) { %>
					style="display:none"
				<% } %>
				>
					<th><label for="in_txt_02"><util:message key="cf.title.menuDesc"/></label></th>
					<td>
						<input type="text" id="menu_menuDesc" name="menu_menuDesc" class="w_p100" value="<c:out value="${menu.menuDesc}"/>" />
					</td>
				</tr>
    
    			<tr id="trCnttUrl"
				<% if (!("M".equals(menuType) && "20".equals(cnttType))) { %>
					style="display:none"
				<% } %>
				>
					<th><label for="in_txt_02"><util:message key="cf.title.connectionUrl"/></label></th>
					<td>
						<input type="text" id="menu_cnttUrl" name="menu_cnttUrl" class="w_p100" value="<c:out value="${menu.cnttUrl}"/>" />
					</td>
				</tr>
				
				<tr id="trInitMenuYn"
				<c:if test="${!(menu.menuKind=='M' && menu.menuType=='M')}">style="display:none"</c:if>>
					<th><label for="in_txt_02"><util:message key="cf.info.cafeHome.main"/></label></th>
					<td>
						<c:forEach items="${useList}" var="use">
						  <input type="radio" id="menu_initMenuYn<c:out value="${menu.menuId}"/>" name="menu_initMenuYn<c:out value="${menu.menuId}"/>"  class="lm3" value="<c:out value="${use.code}"/>"
								 <c:if test="${menu.initMenuYn==use.code}">checked</c:if> onclick="cfOp.menuMng.checkInitMenu(this)"
						  >
						  <label for="" class="lm3"><c:out value="${use.codeName}"/></label>
						</c:forEach>
					</td>
				</tr>
    
    			<tr id="trMenuHideYn"
				<c:if test="${!(menu.menuKind=='M' && menu.menuType=='M')}">style="display:none"</c:if>>
					<th><label for="in_txt_02"><util:message key="cf.title.hideMenu"/></label></th>
					<td>
						<c:forEach items="${useList}" var="use">
						  <input type="radio" id="menu_menuHideYn<c:out value="${menu.menuId}"/>" name="menu_menuHideYn<c:out value="${menu.menuId}"/>"  class="lm3" value="<c:out value="${use.code}"/>"
								 <c:if test="${menu.menuHideYn==use.code}">checked</c:if>
						  >
						<label for="" class="lm3"><c:out value="${use.codeName}"/></label>
						</c:forEach>
					</td>
				</tr>
				
				<tr id="trGroupFoldYn"
				<c:if test="${menu.menuType != 'G'}">style="display:none"</c:if>>
					<th><label for="in_txt_02"><util:message key="cf.title.groupFolding"/></label></th>
					<td>
						<c:forEach items="${useList}" var="use">
						  <input type="radio" id="menu_groupFoldYn<c:out value="${menu.menuId}"/>" name="menu_groupFoldYn<c:out value="${menu.menuId}"/>"  class="lm3" value="<c:out value="${use.code}"/>"
								 <c:if test="${menu.groupFoldYn==use.code}">checked</c:if>
						  >
						<label for="" class="lm3"><c:out value="${use.codeName}"/></label>
						</c:forEach>
					</td>
				</tr>
				
				<tr id="trAnonYn"
					<% if (!"M".equals(menuType) || cnttType.startsWith("2") || cnttType.startsWith("8") || cnttType.startsWith("9")) { %>
						style="display:none"
					<% } %>
				>
					<th><label for="in_txt_02"><util:message key="cf.title.anonymousWriting"/></label></th>
					<td>
						<c:forEach items="${useList}" var="use">
						  <input type="radio" id="menu_anonYn<c:out value="${menu.menuId}"/>" name="menu_anonYn<c:out value="${menu.menuId}"/>"  class="lm3" value="<c:out value="${use.code}"/>"
								 <c:if test="${menu.anonYn==use.code}">checked</c:if>
						  >
						<label for="" class="lm3"><c:out value="${use.codeName}"/></label>
						</c:forEach>
					</td>
				</tr>
				
				<tr id="trGrade"
					<% if (!"M".equals(menuType) || cnttType.startsWith("9")) { %>
						style="display:none"
					<% } %>
				>
					<th><label for="in_txt_02"><util:message key="cf.title.authority"/></label></th>
					<td>
						<ul>
						<% if (cnttType.startsWith("2") || cnttType.startsWith("8")) { %>
							<li><util:message key="cf.title.inquiry"/>
						  <% } else { %>
						  	<li><util:message key="cf.prop.read"/>
						  <% } %>
							   <select id="menu_readGrade" name="menu_readGrade" class="lm30">
								<c:forEach items="${gradeList}" var="grade">
								  <option value="<c:out value="${grade.shortGrd}"/>" <c:if test="${grade.shortGrd == menu.readGrade}">selected</c:if>><c:out value="${grade.gradeNm}"/></option>
								</c:forEach>
							  </select>
							</li>
						<% if (cnttType.startsWith("2") || cnttType.startsWith("8")) { %>
							<li><util:message key="cf.title.create"/>
						  <% } else { %>
						  	<li><util:message key="cf.prop.write"/>
						  <% } %>
							   <select id="menu_wrtGrade" name="menu_wrtGrade" class="lm30">
								<c:forEach items="${gradeList}" var="grade">
								  <option value="<c:out value="${grade.shortGrd}"/>" <c:if test="${grade.shortGrd == menu.wrtGrade}">selected</c:if>><c:out value="${grade.gradeNm}"/></option>
								</c:forEach>
							  </select>
							</li>
						<% if (cnttType.startsWith("2") || cnttType.startsWith("8")) { %>
							<li id="menu_replyGradeNm" name="menu_replyGradeNm"><util:message key="eb.info.btn.edit"/>
								<select id="menu_replyGrade" name="menu_replyGrade" class="lm30">
						  <% } else { %>
						  	<li id="menu_replyGradeNm" name="menu_replyGradeNm"><util:message key="cf.title.reply"/>
									<select id="menu_replyGrade" name="menu_replyGrade" <c:if test="${langKnd=='ko'}">class="lm8"</c:if><c:if test="${langKnd=='en'}">class="lm30"</c:if>>
						  <% } %>
						   		
								<c:forEach items="${gradeList}" var="grade">
								  <option value="<c:out value="${grade.shortGrd}"/>" <c:if test="${grade.shortGrd == menu.replyGrade}">selected</c:if>><c:out value="${grade.gradeNm}"/></option>
								</c:forEach>
							 	</select>
							</li>
						<% if (cnttType != "14"&&cnttType.startsWith("2") || cnttType != "14"&&cnttType.startsWith("8")) { %>
							<li id="menu_memoGradeNm" name="menu_memoGradeNm"><util:message key="ev.info.menu.delete"/>
							<select id="menu_memoGrade" name="menu_memoGrade" class="lm30">
						  <% } else { %>
						  	<li id="menu_memoGradeNm" name="menu_memoGradeNm"><util:message key="cf.title.comment"/>
						  	<select id="menu_memoGrade" name="menu_memoGrade" class="lm8">
						  <% } %>
								<c:forEach items="${gradeList}" var="grade">
								  <option value="<c:out value="${grade.shortGrd}"/>" <c:if test="${grade.shortGrd == menu.memoGrade}">selected</c:if>><c:out value="${grade.gradeNm}"/>  ${grade.shortGrd}:${menu.memoGrade} </option>
								</c:forEach>
							 	</select>
							</li>
						</ul>
					</td>
				</tr>
			</tbody>
		  </table>
		</div>
		</c:forEach>
		</div>
		<c:if test="${menu.menuType == 'S'}">
			<div class="cafeadm_menu_contents" id="gubun">
				<util:message key="cf.info.separator"/>
			</div>
		</c:if>
		<c:if test="${menu.menuType == 'E'}">
			<div class="cafeadm_menu_contents" id="gubun">
				<util:message key="cf.info.margin"/>
			</div>
		</c:if>
	</div>
	
	<div class="board_btn_wrap" style="border-top:1px lightgray solid; padding:5px;">				
		<div class="board_btn_wrap_center">
			<a href="#" onclick="javascript:cfOp.menuMng.setCmntMenu()" class="btn black"><util:message key="cf.title.save.do"/></a>
			<a href="#" onclick="javascript:cfOp.menuMng.cancel()" class="btn white"><util:message key="cf.title.cancel.do"/></a>
		</div>
	</div>			

