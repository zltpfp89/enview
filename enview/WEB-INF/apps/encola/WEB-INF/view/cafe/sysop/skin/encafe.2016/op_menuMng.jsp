<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.saltware.encola.common.vo.CmntMenuVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<div class="cafegridpanel" style="width: 770px; float:left; margin-top: 5px; ">
  <table cellpadding=0 cellspacing=0 border=0 width='100%'>
    <tr>
	  <td colspan="2" align="right" style="padding-right:10px">
	    <span class="btn_pack small pdb05">
			<a href="#" onclick="javascript:cfOp.menuMng.getTrash().doGet()">삭제 보관된 메뉴 목록 보기</a>
		</span>
	  </td>
	</tr>
    <tr>
      <td class="menu_tree">
      	<div class="menu_menuTypes fl">
			<select id="menu_menuType" name="menu_menuType" class="menu_menuType">
			  <c:forEach items="${typeList}" var="type">
			  <option value="<c:out value="${type.code}"/>" cnttType="<c:out value="${type.codeTag}"/>" cnttUrl="<c:out value="${type.remark}"/>"><c:out value="${type.codeName}"/></option>
			  </c:forEach>
			</select>
			<span class="btn_pack small">
				<a id="menu_add" href="#" onclick="javascript:cfOp.menuMng.affectMenuItem('add')">+추가</a>
			</span>
		</div>
		<ul id="menu_menuTree" class="menu_menuTree fl">
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
				 onclick="cfOp.menuMng.toggleMenuGroup(this)" style="cursor:hand;<c:if test="${menu.menuType != 'G'}">display:none</c:if>"
			>
			<ul id="menu_hiddenUl<c:out value="${menu.menuId}"/>" name="menu_hiddenUl<c:out value="${menu.menuId}"/>" style="display:none"></ul>
		  </c:forEach>
		</ul>
		<div class="fl">
		  <img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/btn_up_first.gif" onclick="cfOp.menuMng.affectMenuItem('first')"/>
		  <img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/btn_up.gif" onclick="cfOp.menuMng.affectMenuItem('up')"/>
		  <img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/btn_down.gif" onclick="cfOp.menuMng.affectMenuItem('down')"/>
		  <img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/btn_down_last.gif" onclick="cfOp.menuMng.affectMenuItem('last')"/>
		</div>
		<div class="fr menu_right_btns">
		  <img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/btn_indent.gif" onclick="cfOp.menuMng.affectMenuItem('indent')"/>
		  <span class="btn_pack small">
			<a href="#" onclick="javascript:cfOp.menuMng.affectMenuItem('remove')">-삭제</a>
		</span>
		</div>
      </td>
      <td class="cafegridpanel menu_info" width="75%" valign="top">
		<c:forEach items="${menuList}" var="menu">
		  <%
			CmntMenuVO menuVO = (CmntMenuVO)pageContext.getAttribute("menu");
			String menuType = menuVO.getMenuType();
			String cnttType = menuVO.getCnttType();
		  %>
		<div id="menu_form<c:out value="${menu.menuId}"/>" class="cafeformpanel" style="display:none">
		  <table cellpadding=0 cellspacing=0 border=0 width='100%'>
			<tr id="trGridLimit"><td width="100%" height="2" colspan="100" class="cafegridlimit"></td></tr>
			<tr id="trMenuNm" <c:if test="${menu.menuType == 'E' || menu.menuType == 'S'}">style="display:none"</c:if>>
			  <td width="20%" class="cafeformlabel"><img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/tb_icon.gif" width="5" height="5" align="absmiddle">메뉴명</td>
			  <td class="cafeformfieldlast" align="left">
				<input type="text" id="menu_menuNm" name="menu_menuNm" value="<c:out value="${menu.menuNm}"/>" maxlength="50" size="30"
					   <c:if test="${menu.cnttType=='90'||menu.cnttType=='91'||menu.cnttType=='92'||menu.cnttType=='93'}">disabled</c:if>/> 
			  </td>
			</tr>
			<tr id="trMenuDesc"
				<% if (!"M".equals(menuType) || cnttType.startsWith("9")) { %>
					style="display:none"
				<% } %>
			>
			  <td width="20%" class="cafeformlabel"><img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/tb_icon.gif" width="5" height="5" align="absmiddle">메뉴설명(풍선글)</td>
			  <td class="cafeformfieldlast" align="left">
				<input type="text" id="menu_menuDesc" name="menu_menuDesc" value="<c:out value="${menu.menuDesc}"/>" maxlength="100" size="60"/> 
			  </td>
			</tr>
			<tr id="trCnttUrl"
				<% if (!("M".equals(menuType) && "20".equals(cnttType))) { %>
					style="display:none"
				<% } %>
			>
			  <td width="20%" class="cafeformlabel"><img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/tb_icon.gif" width="5" height="5" align="absmiddle">연결 URL</td>
			  <td class="cafeformfieldlast" align="left">
				<input type="text" id="menu_cnttUrl" name="menu_cnttUrl" value="<c:out value="${menu.cnttUrl}"/>" maxlength="100" size="60"/> 
			  </td>
			</tr>
			<tr id="trInitMenuYn" <c:if test="${!(menu.menuKind=='M' && menu.menuType=='M')}">style="display:none"</c:if>>
			  <td width="20%" class="cafeformlabel"><img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/tb_icon.gif" width="5" height="5" align="absmiddle">카페홈 초기 메뉴로</td>
			  <td class="cafeformfieldlast" align="left">
				<c:forEach items="${useList}" var="use">
				  <input type="radio" id="menu_initMenuYn<c:out value="${menu.menuId}"/>" name="menu_initMenuYn<c:out value="${menu.menuId}"/>" value="<c:out value="${use.code}"/>"
						 <c:if test="${menu.initMenuYn==use.code}">checked</c:if> onclick="cfOp.menuMng.checkInitMenu(this)"
				  >
				  <c:out value="${use.codeName}"/> 
				</c:forEach>
			  </td>
			</tr>
			<tr id="trMenuHideYn" <c:if test="${menu.menuType != 'M'}">style="display:none"</c:if>>
			  <td width="20%" class="cafeformlabel"><img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/tb_icon.gif" width="5" height="5" align="absmiddle">메뉴 숨김 기능</td>
			  <td class="cafeformfieldlast" align="left">
				<c:forEach items="${useList}" var="use">
				  <input type="radio" id="menu_menuHideYn<c:out value="${menu.menuId}"/>" name="menu_menuHideYn<c:out value="${menu.menuId}"/>" value="<c:out value="${use.code}"/>"
						 <c:if test="${menu.menuHideYn==use.code}">checked</c:if>
				  >
				  <c:out value="${use.codeName}"/> 
				</c:forEach>
			  </td>
			</tr>
			<tr id="trGroupFoldYn" <c:if test="${menu.menuType != 'G'}">style="display:none"</c:if>>
			  <td width="20%" class="cafeformlabel"><img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/tb_icon.gif" width="5" height="5" align="absmiddle">그룹 접기 기능</td>
			  <td class="cafeformfieldlast" align="left">
				<c:forEach items="${useList}" var="use">
				  <input type="radio" id="menu_groupFoldYn<c:out value="${menu.menuId}"/>" name="menu_groupFoldYn<c:out value="${menu.menuId}"/>" value="<c:out value="${use.code}"/>"
						 <c:if test="${menu.groupFoldYn==use.code}">checked</c:if>
				  >
				  <c:out value="${use.codeName}"/> 
				</c:forEach>
			  </td>
			</tr>
			<tr id="trAnonYn"
				<% if (!"M".equals(menuType) || cnttType.startsWith("2") || cnttType.startsWith("8") || cnttType.startsWith("9")) { %>
					style="display:none"
				<% } %>
			>
			  <td width="20%" class="cafeformlabel"><img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/tb_icon.gif" width="5" height="5" align="absmiddle">익명 글작성 기능</td>
			  <td class="cafeformfieldlast" align="left">
				<c:forEach items="${useList}" var="use">
				  <input type="radio" id="menu_anonYn<c:out value="${menu.menuId}"/>" name="menu_anonYn<c:out value="${menu.menuId}"/>" value="<c:out value="${use.code}"/>"
						 <c:if test="${menu.anonYn==use.code}">checked</c:if>
				  >
				  <c:out value="${use.codeName}"/> 
				</c:forEach>
			  </td>
			</tr>
			<tr id="trGrade"
				<% if (!"M".equals(menuType) || cnttType.startsWith("9")) { %>
					style="display:none"
				<% } %>
			>
			  <td width="20%" class="cafeformlabel"><img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/tb_icon.gif" width="5" height="5" align="absmiddle">권한</td>
			  <td class="cafeformfieldlast" align="left">
				<div id="divReadGrade">
				  <% if (cnttType.startsWith("2") || cnttType.startsWith("8")) { %>
				  <span id="menu_readGradeNm" name="menu_readGradeNm" style="margin-right:20px">조    회</span>
				  <% } else { %>
				  <span id="menu_readGradeNm" name="menu_readGradeNm" style="margin-right:20px">읽    기</span>
				  <% } %>
				  <select id="menu_readGrade" name="menu_readGrade">
					<c:forEach items="${gradeList}" var="grade">
					  <option value="<c:out value="${grade.shortGrd}"/>" <c:if test="${grade.shortGrd == menu.readGrade}">selected</c:if>><c:out value="${grade.gradeNm}"/></option>
					</c:forEach>
				  </select>
				  <br>
				</div>
				<div id="divWrtGrade">
				  <% if (cnttType.startsWith("2") || cnttType.startsWith("8")) { %>
				  <span id="menu_wrtGradeNm" name="menu_wrtGradeNm" style="margin-right:20px">생    성</span>
				  <% } else { %>
				  <span id="menu_wrtGradeNm" name="menu_wrtGradeNm" style="margin-right:20px">쓰    기</span>
				  <% } %>
				  <select id="menu_wrtGrade" name="menu_wrtGrade">
					<c:forEach items="${gradeList}" var="grade">
					  <option value="<c:out value="${grade.shortGrd}"/>" <c:if test="${grade.shortGrd == menu.wrtGrade}">selected</c:if>><c:out value="${grade.gradeNm}"/></option>
					</c:forEach>
				  </select>
				  <br>
				</div>
				<div id="divReplyGrade">
				  <% if (cnttType.startsWith("2") || cnttType.startsWith("8")) { %>
				  <span id="menu_replyGradeNm" name="menu_replyGradeNm" style="margin-right:20px">수    정</span>
				  <% } else { %>
				  <span id="menu_replyGradeNm" name="menu_replyGradeNm" style="margin-right:20px">답글쓰기</span>
				  <% } %>
				  <select id="menu_replyGrade" name="menu_replyGrade">
					<c:forEach items="${gradeList}" var="grade">
					  <option value="<c:out value="${grade.shortGrd}"/>" <c:if test="${grade.shortGrd == menu.replyGrade}">selected</c:if>><c:out value="${grade.gradeNm}"/></option>
					</c:forEach>
				  </select>
				  <br>
				</div>
				<div id="divMemoGrade" <c:if test="${menu.cnttType == '14'}">style="display:none"</c:if>>
				  <% if (cnttType.startsWith("2") || cnttType.startsWith("8")) { %>
				  <span id="menu_memoGradeNm" name="menu_memoGradeNm" style="margin-right:20px">삭    제</span>
				  <% } else { %>
				  <span id="menu_memoGradeNm" name="menu_memoGradeNm" style="margin-right:20px">댓글쓰기</span>
				  <% } %>
				  <select id="menu_memoGrade" name="menu_memoGrade">
					<c:forEach items="${gradeList}" var="grade">
					  <option value="<c:out value="${grade.shortGrd}"/>" <c:if test="${grade.shortGrd == menu.memoGrade}">selected</c:if>><c:out value="${grade.gradeNm}"/></option>
					</c:forEach>
				  </select>
				</div>
			  </td>
			</tr>
			<tr id="trCommentS" <c:if test="${menu.menuType != 'S'}">style="display:none"</c:if>><td colspan="100" width="100%" height="30" class="cafeformlabellast" align="center">분리자가 설정되었습니다.</td></tr>
			<tr id="trCommentE" <c:if test="${menu.menuType != 'E'}">style="display:none"</c:if>><td colspan="100" width="100%" height="30" class="cafeformlabellast" align="center">여백이 설정되었습니다.</td></tr>
			<tr id="trGridLimit"><td width="100%" height="2" colspan="100" class="cafegridlimit"></td></tr>
		  </table>
		</div>
		</c:forEach>
      </td>
    </tr>
  </table>
</div>
<div style="float: left; width: 780px; height: 18px; margin: 7px auto 0px auto;">
	<div align="center">
		<span class="btn_pack small">
			<a href="#" onclick="javascript:cfOp.menuMng.setCmntMenu()"><util:message key="ev.title.save"/></a>
		</span>
		<span class="btn_pack small">
			<a href="#" onclick="javascript:cfOp.menuMng.cancel()">취소</a>
		</span>
	</div>
</div>