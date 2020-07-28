<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String evcp_do_not_confilct = request.getContextPath();
%>

	  <form id="ownGrdMngForm" name="ownGrdMngForm" onsubmit="return false">
	  <table width=100% cellpadding=0 cellspacing=0 border=0>
		<tr height=30>
		  <td>
			<img src='<%=evcp_do_not_confilct%>/board/images/admin/ic_triangle.gif' style='margin:0 5 0 0;' align=absmiddle>
			현재 선택된 게시판의 독자등급코드
		  </td>
		</tr>
	  </table>
	  <table width=100% cellpadding=0 cellspacing=0 border=0>
	  <thead>
	    <tr><td colspan=4 height=2 class='adgridlimit'></td></tr>
	    <tr align=center height=24>
	      <td class='adgridheader'>선택</td>
	      <td class='adgridheader'>등급</td>
	      <td class='adgridheader'>등급명</td>
	      <td class='adgridheaderlast'>순서</td>
	    </tr>
	  </thead>
	  <tbody>
	    <tr><td height=1 colspan=4></td></tr>
        <c:forEach items="${ownGrdList}" var="ownGrd" varStatus="status">
	    <tr height=22 <c:if test="${status.index % 2 == 1 }">class='adgridline'</c:if> onmouseover="ebUtil.activeLine(this,true)"  onmouseout="ebUtil.activeLine(this,false)">
		  <td align='center' class='adgrid'>
			<input type="checkbox" id="actn_checkRow_<c:out value="${status.index}"/>" name="actn_checkRow" value="<c:out value="${ownGrd.code}"/>"
				   gradeNm="<c:out value="${ownGrd.codeName}"/>" gradeDesc="<c:out value="${ownGrd.remark}"/>"
			>
		  </td>
	      <td align='center' class='adgrid' onclick="aBM.getActnMngr().doOwnGrdSelect('<c:out value="${status.index}"/>')"><c:out value="${ownGrd.code}"/></td>
	      <td align='center' class='adgrid' onclick="aBM.getActnMngr().doOwnGrdSelect('<c:out value="${status.index}"/>')"><c:out value="${ownGrd.codeName}"/></td>
	      <td align='center' class='adgridlast'>
		    <c:if test="${!status.last}">
			  <span class="btn_pack small" name="auth_ownGrdUp<c:out value="${status.index}"/>"><a href="javascript:aBM.getActnMngr().doOwnGrdUp('<c:out value="${status.index}"/>')">높은 등급으로</a></span>&nbsp;
			</c:if>
			<c:if test="${!status.first}">
			  <span class="btn_pack small" name="auth_ownGrdDown<c:out value="${status.index}"/>"><a href="javascript:aBM.getActnMngr().doOwnGrdDown('<c:out value="${status.index}"/>')">낮은 등급으로</a></span>
	        </c:if>
		  </td>
	    </tr>
	    <tr><td height=1 colspan=4></td></tr>
	    </c:forEach>
	    <tr><td height=2 colspan=4 class='adgridlimit'></td></tr>
	    <tr><td height=10 colspan=4></td></tr>
	      <td align=right colspan=4>
			<span class="btn_pack medium"><a href="javascript:aBM.getActnMngr().doOwnGrdCreate()">신규</a></span>
			<span class="btn_pack medium"><a href="javascript:aBM.getActnMngr().doOwnGrdDelete()">삭제</a></span>
	      </td>
	    </tr>
	  </tbody>
	  <input type=hidden id="actn_ownGrd_selected">
	  <input type=hidden id="actn_ownGrd_act">
	  </table>
      </form>
      <div id="ownGrdEditDiv" style="width:100%;display:none;">
        <form id="ownGrdEditForm" style="display:inline" name="ownGrdEditForm" action="" method="post" onsubmit="return false;">
        <table width=100% cellpadding=0 cellspacing=0 border=0>
	      <colgroup width='25%'/>
	      <colgroup width='75%'/>
	      <tr><td height=2 colspan=2 class='adgridlimit'></td></tr>
	      <tr height=30>
	        <td class='adformlabel' align='right' style="padding:0px 10px 0px 10px">등급</td>
	        <td class='adformfieldlast'><input type='text' id='actn_grade' size="3" disabled='true'></td>
	      </tr>
	      <tr><td height=1 colspan=2></td></tr>
	      <tr height=30>
	        <td class='adformlabeldark' align='right' style="padding:0px 10px 0px 10px">등급명</td>
	        <td class='adformfielddarklast'><input type='text' id="actn_gradeNm" style='width:98%' maxlength='20'></td>
	      </tr>
	      <tr><td height=1 colspan=2></td></tr>
	      <tr height=30>
	        <td class='adformlabel' align='right' style="padding:0px 10px 0px 10px">등급설명</td>
	        <td class='adformfieldlast'><input type='text' id="actn_gradeDesc" style='width:98%' maxlength='120'></td>
	      </tr>
	      <tr><td height=1 colspan=2></td></tr>
	      <tr><td height=2 colspan=2 class='adgridlimit'></td></tr>
	      <tr><td height=10 colspan=2></td></tr>
	      <tr>
	        <td align=right colspan=2>
			  <span class="btn_pack medium"><a href="javascript:aBM.getActnMngr().doOwnGrdSave()">저장</a></span>
	         </td>
	      </tr>
        </table>
		</form>
      </div>
