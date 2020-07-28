<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<div class="cafeformpanel" style="width:100%;">
<dl>
<dt><h2>가입 제한 조건 설정</h2></dt>
<dd>
  <table cellpadding=0 cellspacing=0 border=0 width='100%'>
	<tr><td colspan="2" height="2" width="100%" class="cafeformlimit"></td></tr>
	<tr>
	  <td width="20%" class="cafeformlabel"><img src="<%=request.getContextPath()%>/cola/cafe/images/tb_icon.gif" width="5" height="5" align="absmiddle">성별</td>
	  <td class="cafeformfieldlast" align="left">
	    <c:forEach items="${sexList}" var="sex">
	      <input type="radio" id="reg_limitSex" name="reg_limitSex" class="lm10" value="<c:out value="${sex.code}"/>" <c:if test="${limitVO.limitSex==sex.code}">checked</c:if>
		         onclick="ebUtil.setCheckedValue(document.getElementsByName('reg_limitSex'),'<c:out value="${sex.code}"/>')"/>
		  <c:out value="${sex.codeName}"/>
		</c:forEach>
	  </td>
	</tr>
	<tr>
	  <td width="20%" class="cafeformlabel"><img src="<%=request.getContextPath()%>/cola/cafe/images/tb_icon.gif" width="5" height="5" align="absmiddle">나이</td>
	  <td class="cafeformfieldlast" align="left">
	    <c:forEach items="${ageList}" var="age">
	      <input type="radio" id="reg_limitAge" name="reg_limitAge"  value="<c:out value="${age.code}"/>" <c:if test="${limitVO.limitAge==age.code}">checked</c:if>
		         onclick="ebUtil.setCheckedValue(document.getElementsByName('reg_limitAge'),'<c:out value="${age.code}"/>')"/>
		  <c:if test="${age.code=='B'}">
		    <select id="reg_ageBgnYyyyB" name="reg_ageBgnYyyyB" >
		      <c:forEach items="${yyyyList}" var="yyyy">
			    <option value="<c:out value="${yyyy.code}"/>" <c:if test="${limitVO.ageBgnYyyy==yyyy.code}">selected</c:if>><c:out value="${yyyy.codeName}"/></option>
		      </c:forEach>
		    </select>
			&nbsp년&nbsp
		  </c:if>
		  <c:if test="${age.code=='A'}">
		    <select id="reg_ageBgnYyyyA" name="reg_ageBgnYyyyA" >
		      <c:forEach items="${yyyyList}" var="yyyy">
			    <option value="<c:out value="${yyyy.code}"/>" <c:if test="${limitVO.ageBgnYyyy==yyyy.code}">selected</c:if>><c:out value="${yyyy.codeName}"/></option>
		      </c:forEach>
		    </select>
			&nbsp년&nbsp
		  </c:if>
		  <c:if test="${age.code=='Y'}">
		    <select id="reg_ageBgnYyyy" name="reg_ageBgnYyyy" >
		      <c:forEach items="${yyyyList}" var="yyyy">
			    <option value="<c:out value="${yyyy.code}"/>" <c:if test="${limitVO.ageBgnYyyy==yyyy.code}">selected</c:if>><c:out value="${yyyy.codeName}"/></option>
		      </c:forEach>
		    </select>
			&nbsp부터&nbsp
		    <select id="reg_ageEndYyyy" name="reg_ageEndYyyy" >
		      <c:forEach items="${yyyyList}" var="yyyy">
			    <option value="<c:out value="${yyyy.code}"/>" <c:if test="${limitVO.ageEndYyyy==yyyy.code}">selected</c:if>><c:out value="${yyyy.codeName}"/></option>
		      </c:forEach>
		    </select>
			&nbsp까지&nbsp
		  </c:if>
		  <c:out value="${age.codeName}"/>&nbsp;&nbsp;&nbsp;&nbsp;
		</c:forEach>
	  </td>
	</tr>
	<tr>
	  <td width="20%" class="cafeformlabel"><img src="<%=request.getContextPath()%>/cola/cafe/images/tb_icon.gif" width="5" height="5" align="absmiddle">지역</td>
	  <td class="cafeformfieldlast" align="left">
		<select id="reg_locCode" name="reg_locCode" >
		  <c:forEach items="${locList}" var="loc">
			<option value="<c:out value="${loc.code}"/>" <c:if test="${limitVO.locCode==loc.code}">selected</c:if>><c:out value="${loc.codeName}"/></option>
		  </c:forEach>
		</select>
	  </td>
	</tr>
	<tr>
	  <td width="20%" class="cafeformlabel"><img src="<%=request.getContextPath()%>/cola/cafe/images/tb_icon.gif" width="5" height="5" align="absmiddle">학과/전공</td>
	  <td class="cafeformfieldlast" align="left">
		<select id="reg_majorCode" name="reg_majorCode" >
		  <c:forEach items="${majorList}" var="major">
			<option value="<c:out value="${major.code}"/>" <c:if test="${limitVO.majorCode==major.code}">selected</c:if>><c:out value="${major.codeName}"/></option>
		  </c:forEach>
		</select>
	  </td>
	</tr>
	<tr>
	  <td width="20%" class="cafeformlabel"><img src="<%=request.getContextPath()%>/cola/cafe/images/tb_icon.gif" width="5" height="5" align="absmiddle">학부</td>
	  <td class="cafeformfieldlast" align="left">
		<select id="reg_cllgCode" name="reg_cllgCode" >
		  <c:forEach items="${cllgList}" var="cllg">
			<option value="<c:out value="${cllg.code}"/>" <c:if test="${limitVO.cllgCode==cllg.code}">selected</c:if>><c:out value="${cllg.codeName}"/></option>
		  </c:forEach>
		</select>
	  </td>
	</tr>
	<tr>
	  <td width="20%" class="cafeformlabel"><img src="<%=request.getContextPath()%>/cola/cafe/images/tb_icon.gif" width="5" height="5" align="absmiddle">조직</td>
	  <td class="cafeformfieldlast" align="left">
		<select id="reg_orgCode" name="reg_orgCode" >
		  <c:forEach items="${orgList}" var="org">
			<option value="<c:out value="${org.code}"/>" <c:if test="${limitVO.orgCode==org.code}">selected</c:if>><c:out value="${org.codeName}"/></option>
		  </c:forEach>
		</select>
	  </td>
	</tr>
	<tr><td colspan="2" height="2" width="100%" class="cafeformlimit"></td></tr>
  </table>
</dd>
<dt><h2>가입 퀴즈/설문 설정</h2></dt>
<dd>
  <table cellpadding=0 cellspacing=0 border=0 width='100%'>
	<tr><td colspan="2" height="2" width="100%" class="cafeformlimit"></td></tr>
	<tr>
	  <td width="20%" class="cafeformlabel"><img src="<%=request.getContextPath()%>/cola/cafe/images/tb_icon.gif" width="5" height="5" align="absmiddle">가입 퀴즈</td>
	  <td class="cafeformfieldlast" align="left">
	    <c:forEach items="${useList}" var="use">
	      <input type="radio" id="reg_limitQuiz" name="reg_limitQuiz"  value="<c:out value="${use.code}"/>" <c:if test="${limitVO.limitQuiz==use.code}">checked</c:if>
		         onclick="cfOp.regInfo.checkLimitQuiz(this)"/>
		  <c:out value="${use.codeName}"/>&nbsp;&nbsp;&nbsp;&nbsp;
		</c:forEach>
		<div id="reg_quizDiv" <c:if test="${limitVO.limitQuiz=='N'}">style="display:none"</c:if>>
		  <img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/qstn.gif" width="17" height="17" align="absmiddle">
          <input type="text" id="reg_regQuizQstn" name="reg_regQuizQstn" value="<c:out value="${limitVO.regQuizQstn}"/>" maxLength="60" />
		  <br>
		  <span style="margin-left:20px"><img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/answ.gif" width="17" height="17" align="absmiddle"></span>
          <input type="text" id="reg_regQuizAnsw" name="reg_regQuizAnsw" value="<c:out value="${limitVO.regQuizAnsw}"/>" maxLength="20" />
		</div>
	  </td>
	</tr>
	<tr style="display:none;">
	  <td width="20%" class="cafeformlabel"><img src="<%=request.getContextPath()%>/cola/cafe/images/tb_icon.gif" width="5" height="5" align="absmiddle">가입 설문</td>
	  <td class="cafeformfieldlast" align="left">
	    <c:forEach items="${useList}" var="use">
	      <input type="radio" id="reg_limitQstn" name="reg_limitQstn"  value="<c:out value="${use.code}"/>" <c:if test="${limitVO.limitQstn==use.code}">checked</c:if>
		         onclick="cfOp.regInfo.checkLimitQstn(this)"/>
		  <c:out value="${use.codeName}"/>&nbsp;&nbsp;&nbsp;&nbsp;
		</c:forEach>
		<div id="reg_qstnDiv" <c:if test="${limitVO.limitQstn=='N'}">style="display:none"</c:if>>
		  <img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/qstn.gif" width="17" height="17" align="absmiddle"/>
		  <select id="reg_qstnType" name="reg_qstnType"  onchange="cfOp.regInfo.changeQstnType(this)">
		    <c:forEach items="${qstnTypeList}" var="qstnType">
			  <option value="<c:out value="${qstnType.code}"/>"><c:out value="${qstnType.codeName}"/></option>
		    </c:forEach>
		  </select>
		  <input type="text" id="reg_newQstn" name="reg_newQstn" maxLength="512" />
		  <b><font style="cursor:hand" onclick="cfOp.regInfo.registRegQstn()">등록</font></b>
		  <div id="reg_newAnswDiv">
		    <input type="hidden" id="reg_maxQstnCnt" name="reg_maxQstnCnt" value="<c:out value="${opForm.maxQstnCnt}"/>"/>
		    <input type="hidden" id="reg_maxAnswCnt" name="reg_maxAnswCnt" value="<c:out value="${opForm.maxAnswCnt}"/>"/>
		    <c:forEach begin="1" end="${opForm.maxAnswCnt}" varStatus="status">
		      <br><span style="margin-left:20px">
		        <img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/answ.gif" width="17" height="17" align="absmiddle"/>
			    <input type="text" id="reg_newAnsw<c:out value="${status.count}"/>" name="reg_newAnsw<c:out value="${status.count}"/>" maxLength="512" />
		      </span>
			</c:forEach>
		  </div>
		  <ul id="reg_regQstnUl">
			<jsp:include page="./op_regInfoQstn.jsp"/>
		  </ul>
		</div>
	  </td>
	</tr>
	<tr><td colspan="2" height="2" width="100%" class="cafeformlimit"></td></tr>
  </table>
</dd>
<dt><h2>신규 가입 제한 기간 설정</h2></dt>
<dd>
  <table cellpadding=0 cellspacing=0 border=0 width='100%'>
	<tr><td colspan="2" height="2" width="100%" class="cafeformlimit"></td></tr>
	<tr height="30px">
	  <td width="20%" class="cafeformlabel"><img src="<%=request.getContextPath()%>/cola/cafe/images/tb_icon.gif" width="5" height="5" align="absmiddle">가입 제한 기간</td>
	  <td class="cafeformfieldlast" align="left">
	    <c:forEach items="${termList}" var="term">
	      <input type="radio" id="reg_limitTerm" name="reg_limitTerm"  value="<c:out value="${term.code}"/>" <c:if test="${limitVO.limitTerm==term.code}">checked</c:if>
		         onclick="ebUtil.setCheckedValue(document.getElementsByName('reg_limitTerm'),'<c:out value="${term.code}"/>')"/>
		  <c:out value="${term.codeName}"/>&nbsp;&nbsp;&nbsp;&nbsp;
		  <c:if test="${term.code=='Y'}"><%--가입신청을 안 받는 경우--%>
		    <input type="text" id="reg_denyBgnYmd" name="reg_denyBgnYmd" value="<c:out value="${limitVO.denyBgnYmdF}"/>"  style="width:70" readonly="true">
            <img align="absmiddle" src="<%=request.getContextPath()%>/board/images/board/skin/enboard/calendar.gif" onclick="displayCalendar(new Date(), 'reg_denyBgnYmd', event)"/>
			&nbsp;~&nbsp;
            <input type="text" id="reg_denyEndYmd" name="reg_denyEndYmd" value="<c:out value="${limitVO.denyEndYmdF}"/>"  style="width:70" readonly="true">
            <img align="absmiddle" src="<%=request.getContextPath()%>/board/images/board/skin/enboard/calendar.gif" onclick="displayCalendar(new Date(), 'reg_denyEndYmd', event)"/>
		  </c:if>
		</c:forEach>
	  </td>
	</tr>
	<tr><td colspan="2" height="2" width="100%" class="cafeformlimit"></td></tr>
  </table>
</dd>
</dl>
  <table style="width:100%;">
	<tr>
	  <td align="right">  
		<input type=button value="저장" style="cursor:hand" onclick="cfOp.regInfo.setCmntLimit()">
	  </td>
	</tr>
  </table>
</div>
