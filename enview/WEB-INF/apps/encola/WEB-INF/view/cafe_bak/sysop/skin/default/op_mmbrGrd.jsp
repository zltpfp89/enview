<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<div class="cafegridpanel">
  <table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td height="2" class="cafegridlimit"></td></tr>
	<tr>
	  <th class="cafegridheaderlast">
	    <span style="margin:0px 30px 0px 10px">등급 사용 갯수</span>
		<c:forEach items="${gradeCntList}" var="gradeCnt">
		  <input type="radio" id="grd_gradeCnt" name="grd_gradeCnt" value="<c:out value="${gradeCnt.code}"/>" onclick="cfOp.mmbrGrd.selectGradeCnt(this)"
		         <c:if test="${gradeCnt.code == opForm.gradeCnt}">checked</c:if>/>
		  <c:out value="${gradeCnt.codeName}"/>
		</c:forEach>
	  </th>	
	</tr>
  </table>
</div>
<div>
  <div class="cafegridpanel" style="width:29%;float:left" align="center">
    <table cellpadding=0 cellspacing=0 border=0 width='98%'>
	  <thead>
	  <tr><td colspan="100" height="2" width="98%" class="cafegridlimit"></td></tr>
	  <tr>
	    <th width="20%" class="cafegridheader"><c:out value="${cmntVO.imgMmbrGrdIcon}" escapeXml="false"/></th>
	    <th class="cafegridheaderlast">등급명 설정</th>
	  </tr>
	  </thead>
	  <tbody>
	    <c:forEach items="${gradeList}" var="grade" varStatus="status">
	    <tr id="grd_gradeTr" name="grd_gradeTr" seq="<c:out value="${status.count}"/>" shortGrd="<c:out value="${grade.shortGrd}"/>" <c:if test="${status.count<=7 && status.count>opForm.gradeCnt-2}">style="display:none"</c:if>>
	      <td width="40" class="cafegrid" align="center"><c:out value="${grade.imgGradeIcon}" escapeXml="false"/></td>
	      <td class="cafegridlast" align="left">
		    <input type="text" id="grd_gradeNm<c:out value="${status.count}"/>" name="grd_gradeNm<c:out value="${status.count}"/>" value="<c:out value="${grade.gradeNm}"/>" style="width:98%" maxlength="20"/>
		  </td>
	    </td>
	    </tr>
	  </c:forEach>
	  </tbody>
    </table>
  </div>
  <div class="cafegridpanel" style="width:69%;float:right;border:0 0 0 0" align="center">
    <table cellpadding=0 cellspacing=0 border=0 width='98%'>
	  <thead>
	  <tr><td colspan="100" height="2" class="cafegridlimit"></td></tr>
	  <tr>
	    <th width="6%" class="cafegridheader"></th>
	    <th width="34%" class="cafegridheader">등업 설정</th>
	    <th width="15%" class="cafegridheader">게시글 수</th>
	    <th width="15%" class="cafegridheader">댓글 수</th>
	    <th width="15%" class="cafegridheader">방문 횟수</th>
	    <th width="15%" class="cafegridheaderlast">등업유형</th>
	  </tr>
	  </thead>
	  <tbody>
	  <c:forEach items="${grdupList}" var="grdup" varStatus="status">
	  <tr id="grd_grdupTr" name="grd_grdupTr" seq="<c:out value="${status.count}"/>" shortGrd="<c:out value="${grdup.shortGrd}"/>" <c:if test="${status.count>opForm.gradeCnt-4}">style="display:none"</c:if>>
	    <td class="cafegrid" align="center">
		  <input type="checkbox" id="grd_checkRow<c:out value="${grdup.shortGrd}"/>" name="grd_checkRow<c:out value="${grdup.shortGrd}"/>" value="<c:out value="${grdup.shortGrd}"/>"/>
		</td>
	    <td class="cafegrid" align="center">
		  <c:out value="${grdup.gradeNm}"/> ▶ <c:out value="${grdup.nextGradeNm}"/>
		</td>
	    <td class="cafegrid" align="right">
		  <input type="text" id="grd_bltnCnt<c:out value="${grdup.shortGrd}"/>" name="grd_bltnCnt<c:out value="${grdup.shortGrd}"/>" value="<c:out value="${grdup.bltnCnt}"/>" size="4" maxlength="4"/>
		</td>
	    <td class="cafegrid" align="right">
		  <input type="text" id="grd_memoCnt<c:out value="${grdup.shortGrd}"/>" name="grd_memoCnt<c:out value="${grdup.shortGrd}"/>" value="<c:out value="${grdup.memoCnt}"/>" size="4" maxlength="4"/>
		</td>
	    <td class="cafegrid" align="right">
		  <input type="text" id="grd_visitCnt<c:out value="${grdup.shortGrd}"/>" name="grd_visitCnt<c:out value="${grdup.shortGrd}"/>" value="<c:out value="${grdup.visitCnt}"/>" size="4" maxlength="4"/>
		</td>
	    <td class="cafegridlast" align="center">
		  <select id="grd_upKind<c:out value="${grdup.shortGrd}"/>" name="grd_upKind<c:out value="${grdup.shortGrd}"/>">
			<c:forEach items="${upKindList}" var="upKind">
			  <option value="<c:out value="${upKind.code}"/>" <c:if test="${upKind.code == grdup.upKind}">selected</c:if>><c:out value="${upKind.codeName}"/></option>
			</c:forEach>
		  </select>
		</td>
	  </tr>
	  </c:forEach>
	  <tr><td colspan="100" height="2" class="cafegridlimit"></td></tr>
	  </tbody>
    </table>
  </div>
</div>
<div>
  <table style="width:100%;">
	<tr>
	  <td align="center">
		<input type="button" value="확인" onclick="cfOp.mmbrGrd.setCmntGrdup()"/>
	  </td>    
	</tr>
  </table>
</div>
