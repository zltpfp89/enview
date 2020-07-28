<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<div class="cafeadm_top">
	<h3><util:message key="cf.title.mmbrLevel"/></h3>
	<ul class="location">
		<li>HOME<span class="nextbar"></span></li>
		<li><util:message key="cf.title.mng.memberInfo"/><span class="nextbar"></span></li>
		<li class="last"><util:message key="cf.title.mmbrLevel"/></li>
	</ul>
</div>

<div class="rankmember_type">
	<c:forEach items="${gradeCntList}" var="gradeCnt">
	  <input type="radio" id="grd_gradeCnt" name="grd_gradeCnt" value="<c:out value="${gradeCnt.code}"/>" onclick="cfOp.mmbrGrd.selectGradeCnt(this)"
	         <c:if test="${gradeCnt.code == opForm.gradeCnt}">checked</c:if>/>
	  <c:out value="${gradeCnt.codeName}"/>
	</c:forEach>
</div>

<div class="cafeadm_rankmember_wrap tm20">
	<div class="cafeadm_rankmember_list">
		<table class="table_type01">
			<caption>게시판</caption>
			<colgroup>
				<col width="50px;">
				<col width="auto">
			</colgroup>
			<thead>
				<tr>
					<th><img src="<%=request.getContextPath()%>/cola/cafe/encafe/images/a_level_B.gif" alt="" /></th>
					<th><util:message key="cf.title.ratingName.set"/></th>							
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${gradeList}" var="grade" varStatus="status">
			    <tr id="grd_gradeTr" name="grd_gradeTr" seq="<c:out value="${status.count}"/>" shortGrd="<c:out value="${grade.shortGrd}"/>" <c:if test="${status.count<=7 && status.count>opForm.gradeCnt-2}">style="display:none"</c:if>>
			      <td>
			      	<c:out value="${grade.imgGradeIcon}" escapeXml="false"/>
			      </td>
			      <td>
				    <input type="text" id="grd_gradeNm<c:out value="${status.count}"/>" name="grd_gradeNm<c:out value="${status.count}"/>" value="<c:out value="${grade.gradeNm}"/>" class="w_p100"/>
				  </td>
			    </tr>
		   	</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div class="cafeadm_rankmember_contents">
		<table class="table_type01" summary="게시판">
			<caption>게시판</caption>
			<colgroup>
				<col width="80px;">
				<col width="200px;">
				<col width="auto;">
				<col width="auto;">
				<col width="auto;">
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" name="board_check" onclick="cfOp.mmbrGrd.setCheckAll( this)"></th>
					<th><util:message key="cf.title.levelUp.set"/></th>
					<th><util:message key="cf.title.postCntt"/></th>
					<th><util:message key="cf.title.memo.cnt"/></th>
					<th><util:message key="cf.title.visits"/></th>
					<th><util:message key="cf.title.levelUp.type"/></th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${grdupList}" var="grdup" varStatus="status">
			 <tr id="grd_grdupTr" name="grd_grdupTr" seq="<c:out value="${status.count}"/>" shortGrd="<c:out value="${grdup.shortGrd}"/>" <c:if test="${status.count>opForm.gradeCnt-4}">style="display:none"</c:if>>
			    <td>
				  <input type="checkbox" id="grd_checkRow<c:out value="${grdup.shortGrd}"/>" name="grd_checkRow<c:out value="${grdup.shortGrd}"/>" value="<c:out value="${grdup.shortGrd}"/>"/>
				</td>
			    <td>
				  <c:out value="${grdup.gradeNm}"/> ▶ <c:out value="${grdup.nextGradeNm}"/>
				</td>
			    <td>
				  <input type="text" id="grd_bltnCnt<c:out value="${grdup.shortGrd}"/>" name="grd_bltnCnt<c:out value="${grdup.shortGrd}"/>" value="<c:out value="${grdup.bltnCnt}"/>" size="4" maxlength="4"/>
				</td>
			    <td>
				  <input type="text" id="grd_memoCnt<c:out value="${grdup.shortGrd}"/>" name="grd_memoCnt<c:out value="${grdup.shortGrd}"/>" value="<c:out value="${grdup.memoCnt}"/>" size="4" maxlength="4"/>
				</td>
			    <td>
				  <input type="text" id="grd_visitCnt<c:out value="${grdup.shortGrd}"/>" name="grd_visitCnt<c:out value="${grdup.shortGrd}"/>" value="<c:out value="${grdup.visitCnt}"/>" size="4" maxlength="4"/>
				</td>
			    <td>
				  <select id="grd_upKind<c:out value="${grdup.shortGrd}"/>" name="grd_upKind<c:out value="${grdup.shortGrd}"/>">
					<c:forEach items="${upKindList}" var="upKind">
					  <option value="<c:out value="${upKind.code}"/>" <c:if test="${upKind.code == grdup.upKind}">selected</c:if>><c:out value="${upKind.codeName}"/></option>
					</c:forEach>
				  </select>
				</td>
			  </tr>
			 </c:forEach>
			</tbody>
		</table>	
	</div>
	</div>
	<div class="board_btn_wrap">				
		<div class="board_btn_wrap_center">
			<a href="#" onclick="javascript:cfOp.mmbrGrd.setCmntGrdup()" class="btn white"><util:message key="cf.title.save.do"/></a>
		</div>
	</div>
			