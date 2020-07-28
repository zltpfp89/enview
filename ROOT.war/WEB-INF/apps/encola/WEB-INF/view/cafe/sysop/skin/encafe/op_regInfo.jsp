<%@page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@page import="com.saltware.enview.Enview"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
request.setAttribute("userInfo", EnviewSSOManager.getUserInfoMap(request));
%>
<style>
span.warning {color: red;margin: 5px;vertical-align: middle}
</style>

<div class="cafeadm_top">
	<h3><util:message key="cf.title.joinInfo"/></h3>
	<ul class="location">
		<li>HOME<span class="nextbar"></span></li>
		<li><util:message key="cf.title.mng.cafeInfo"/><span class="nextbar"></span></li>
		<li class="last"><util:message key="cf.title.joinInfo"/></li>
	</ul>
</div>

<c:if test="${userInfo.userId=='admin' }">
<span style="float:right">
<a href="javascript:$('#limitHelp').dialog({ width:600})">관리자 도움말</a>
</span>
</c:if>

<c:if test="${cafeLimit.limitYns=='NNNNNNNNN' }">
</c:if>
<c:if test="${cafeLimit.limitYns!='NNNNNNNNN' }">
 
<!-- 가입제한조건설정 start -->
<div class="board_btn_wrap top tp20">
	<div class="board_btn_wrap_left">
		<h4 class="cafeadm_title"><util:message key="cf.title.joiningLimit.set"/></h4>
	</div>
</div>
<table class="table_type01 write" summary="게시판">
<caption>게시판</caption>
<colgroup>
<col width="150px;">
<col width="auto;">
</colgroup>			
	<tbody>
	<c:if test="${cafeLimit.limitSex=='Y'}">				
	<tr>
		<th><util:message key="cf.title.gender"/></th>
		<td>
			<c:forEach items="${sexList}" var="sex" varStatus="status">
	      		<input type="radio" id="reg_limitSex" name="reg_limitSex" <c:if test="${!status.first}">class="lm10"</c:if> value="<c:out value="${sex.code}"/>" <c:if test="${limitVO.limitSex==sex.code}">checked</c:if>
		         onclick="ebUtil.setCheckedValue(document.getElementsByName('reg_limitSex'),'<c:out value="${sex.code}"/>')"/>
		  		<label for="reg_limitSex" class="lm3"><c:out value="${sex.codeName}"/></label>
			</c:forEach>
		</td>
	</tr>
	</c:if>
	<c:if test="${cafeLimit.limitAge=='Y'}">				
	<tr>
		<th><util:message key="cf.title.age"/></th>
		<td>
				<c:forEach items="${ageList}" var="age" varStatus="status">
			      <input type="radio" id="reg_limitAge" name="reg_limitAge"  <c:if test="${!status.first}">class="lm10 rm3"</c:if> value="<c:out value="${age.code}"/>" <c:if test="${limitVO.limitAge==age.code}">checked</c:if>
				         onclick="ebUtil.setCheckedValue(document.getElementsByName('reg_limitAge'),'<c:out value="${age.code}"/>')"/>
				  <c:out value="${age.codeName}"/>
				  <c:if test="${age.code=='B'}">
				    <select id="reg_ageBgnYyyyB" name="reg_ageBgnYyyyB" class="rm3">
				      <c:forEach items="${yyyyList}" var="yyyy" >
					    <option value="<c:out value="${yyyy.code}"/>" <c:if test="${limitVO.ageBgnYyyy==yyyy.code}">selected</c:if>><c:out value="${yyyy.codeName}"/></option>
				      </c:forEach>
				    </select>
				    <c:if test="${langKnd eq 'ko' }">
						&nbsp년&nbsp
					</c:if>
				  </c:if>
				  <c:if test="${age.code=='A'}">
				    <select id="reg_ageBgnYyyyA" name="reg_ageBgnYyyyA" class="rm3">
				      <c:forEach items="${yyyyList}" var="yyyy">
					    <option value="<c:out value="${yyyy.code}"/>" <c:if test="${limitVO.ageBgnYyyy==yyyy.code}">selected</c:if>><c:out value="${yyyy.codeName}"/></option>
				      </c:forEach>
				    </select>
				    <c:if test="${langKnd eq 'ko' }">
						&nbsp년&nbsp
					</c:if>
				  </c:if>
				  <c:if test="${langKnd eq 'ko' }">
					  <c:if test="${age.code=='Y'}">
					    <select id="reg_ageBgnYyyy" name="reg_ageBgnYyyy" class="rm3">
					      <c:forEach items="${yyyyList}" var="yyyy">
						    <option value="<c:out value="${yyyy.code}"/>" <c:if test="${limitVO.ageBgnYyyy==yyyy.code}">selected</c:if>><c:out value="${yyyy.codeName}"/></option>
					      </c:forEach>
					    </select>
					  &nbsp부터&nbsp
					    <select id="reg_ageEndYyyy" name="reg_ageEndYyyy" class="rm3">
					      <c:forEach items="${yyyyList}" var="yyyy">
						    <option value="<c:out value="${yyyy.code}"/>" <c:if test="${limitVO.ageEndYyyy==yyyy.code}">selected</c:if>><c:out value="${yyyy.codeName}"/></option>
					      </c:forEach>
					    </select>
					  &nbsp까지&nbsp
					  </c:if>
				</c:if>
				  <c:if test="${langKnd eq 'en' }">
					  <c:if test="${age.code=='Y'}">
					  From
					    <select id="reg_ageBgnYyyy" name="reg_ageBgnYyyy" class="rm3">
					      <c:forEach items="${yyyyList}" var="yyyy">
						    <option value="<c:out value="${yyyy.code}"/>" <c:if test="${limitVO.ageBgnYyyy==yyyy.code}">selected</c:if>><c:out value="${yyyy.codeName}"/></option>
					      </c:forEach>
					    </select>
					  to
					    <select id="reg_ageEndYyyy" name="reg_ageEndYyyy" class="rm3">
					      <c:forEach items="${yyyyList}" var="yyyy">
						    <option value="<c:out value="${yyyy.code}"/>" <c:if test="${limitVO.ageEndYyyy==yyyy.code}">selected</c:if>><c:out value="${yyyy.codeName}"/></option>
					      </c:forEach>
					    </select>
					  </c:if>
					</c:if>
				</c:forEach>
		</td>
	</tr>
	</c:if>
	<c:if test="${cafeLimit.limitLoc=='Y'}">				
	<tr>
		<th><util:message key="cf.title.area"/></th>
		<td>
			<select id="reg_locCode" name="reg_locCode" >
			  <c:forEach items="${locList}" var="loc">
				<option value="<c:out value="${loc.code}"/>" <c:if test="${limitVO.locCode==loc.code}">selected</c:if>><c:out value="${loc.codeName}"/></option>
			  </c:forEach>
			</select>
		</td>
	</tr>
	</c:if>
	<c:if test="${cafeLimit.limitMajor=='Y'}">				
	<tr>
		<th><util:message key="cf.title.department.major"/></th>
		<td>
				<select id="reg_majorCode" name="reg_majorCode" >
				  <c:forEach items="${majorList}" var="major">
					<option value="<c:out value="${major.code}"/>" <c:if test="${limitVO.majorCode==major.code}">selected</c:if>><c:out value="${major.codeName}"/></option>
				  </c:forEach>
				</select>
		</td>
	</tr>
	</c:if>
	<c:if test="${cafeLimit.limitCllg=='Y'}">				
	<tr>
		<th><util:message key="cf.title.faculty"/></th>
		<td>
			<select id="reg_cllgCode" name="reg_cllgCode" >
		  		<c:forEach items="${cllgList}" var="cllg">
					<option value="<c:out value="${cllg.code}"/>" <c:if test="${limitVO.cllgCode==cllg.code}">selected</c:if>><c:out value="${cllg.codeName}"/></option>
		  		</c:forEach>
			</select>
		</td>
	</tr>
	</c:if>
	<c:if test="${cafeLimit.limitOrg=='Y'}">				
	<tr>
		<th><util:message key="cf.prop.organization"/></th>
		<td>
			<select id="reg_orgCode" name="reg_orgCode" >
		  		<c:forEach items="${orgList}" var="org">
					<option value="<c:out value="${org.code}"/>" <c:if test="${limitVO.orgCode==org.code}">selected</c:if>><c:out value="${org.codeName}"/></option>
		  		</c:forEach>
			</select>
		</td>
	</tr>	
	</c:if>
	</tbody>
</table>
</c:if>
<!-- 가입 퀴즈/설문 설정-->
<div class="board_btn_wrap tp20">
	<div class="board_btn_wrap_left">
		<h4 class="cafeadm_title"><util:message key="cf.title.joinQuiz.survey.set"/></h4>
	</div>
</div>
<table class="table_type01 write" summary="게시판">
	<caption>게시판</caption>
	<colgroup>
		<col width="150px;">
		<col width="auto;">
	</colgroup>			
	<tbody>				
	<tr>
		<th><util:message key="cf.title.joinQuiz"/></th>
		<td>
			<c:forEach items="${useList}" var="use" varStatus="status">
		      	<input type="radio" id="reg_limitQuiz" name="reg_limitQuiz" <c:if test="${!status.first}">class="lm10"</c:if> value="<c:out value="${use.code}"/>" <c:if test="${limitVO.limitQuiz==use.code}">checked</c:if>
			         onclick="cfOp.regInfo.checkLimitQuiz(this)"/>
			  	<label for="" class="lm3"><c:out value="${use.codeName}"/></label>
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
	<tr style="display:none">
		<th><util:message key="cf.title.joinSurvey"/></th>
		<td>
			<c:forEach items="${useList}" var="use" varStatus="status">
		      <input type="radio" id="reg_limitQstn" name="reg_limitQstn" <c:if test="${!status.first}">class="lm10"</c:if> value="<c:out value="${use.code}"/>" <c:if test="${limitVO.limitQstn==use.code}">checked</c:if>
			         onclick="cfOp.regInfo.checkLimitQstn(this)"/>
			  <label for="" class="lm3"><c:out value="${use.codeName}"/></label>
			</c:forEach>
			<div id="reg_qstnDiv" <c:if test="${limitVO.limitQstn=='N'}">style="display:none"</c:if>>
			  <img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/qstn.gif" width="17" height="17" align="absmiddle"/>
			  <select id="reg_qstnType" name="reg_qstnType"  onchange="cfOp.regInfo.changeQstnType(this)">
			    <c:forEach items="${qstnTypeList}" var="qstnType">
				  <option value="<c:out value="${qstnType.code}"/>"><c:out value="${qstnType.codeName}"/></option>
			    </c:forEach>
			  </select>
			  <input type="text" id="reg_newQstn" name="reg_newQstn" maxLength="512" />
			  <a href="#" class="btn white" onclick="cfOp.regInfo.registRegQstn()"><util:message key="ev.hnevent.label.reg"/></a> 
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
	</tbody>
</table>

<!-- 신규 가입 제한 기간 설정 -->
<div class="board_btn_wrap tp30">
	<div class="board_btn_wrap_left">
		<h4 class="cafeadm_title"><util:message key="cf.title.new.joining.set"/></h4>
	</div>
</div>
<table class="table_type01 write" summary="게시판">
	<caption>게시판</caption>
	<colgroup>
		<col width="150px;">
		<col width="auto;">
	</colgroup>			
	<tbody>				
	<tr>
		<th><util:message key="cf.title.joiningLimit.period"/></th>
		<td>
		 <c:forEach items="${termList}" var="term" varStatus="status">
	      <input type="radio" id="reg_limitTerm" name="reg_limitTerm" <c:if test="${!status.first}">class="lm10"</c:if> value="<c:out value="${term.code}"/>" <c:if test="${limitVO.limitTerm==term.code}">checked</c:if>
		         onclick="ebUtil.setCheckedValue(document.getElementsByName('reg_limitTerm'),'<c:out value="${term.code}"/>')"/>
		  <label for="" class="lm3"><c:out value="${term.codeName}"/></label>
		  <c:if test="${term.code=='Y'}"><%--가입신청을 안 받는 경우--%>
		    <label for="in_txt_01">
		    	<input type="text" id="reg_denyBgnYmd" name="reg_denyBgnYmd" value="<c:out value="${limitVO.denyBgnYmdF}"/>" class="w100 lm10 datepicker"/>
				<a href="#" onclick="$('#reg_denyBgnYmd').datepicker('show');"> <img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/calendar.png" ></a>
            </label>
			&nbsp;~&nbsp;
			<label for="in_txt_01">
		    	<input type="text" id="reg_denyEndYmd" name="reg_denyEndYmd" value="<c:out value="${limitVO.denyEndYmdF}"/>" class="w100 lm10 datepicker"/>
				<a href="#" onclick="$('#reg_denyEndYmd').datepicker('show');"> <img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/calendar.png" ></a>
            </label>
            
           </c:if>
		 </c:forEach>
		</td>
	</tr>
	</tbody>
</table>
<div class="board_btn_wrap">				
	<div class="board_btn_wrap_center">
		<a href="#" onclick="javascript:cfOp.regInfo.setCmntLimit()" class="btn black"><util:message key="cf.title.save.do"/></a>
	</div>
</div>

<div id="limitHelp" title="<util:message key="cf.title.new.joining.set"/>" style="display:none">
<h4>가입조건을 사용하려면  시스템 설정 관리에서  사용 설정하고 사용자 로그인 시 사용자정보(userInfoMap)에 해당 정보를 넣어야 합니다.</h4>
<table class="table_type01 write">
<tr><th>환경값</th><th>내용</th><th>사용자 정보</th><th>공통코드</th></tr>
<tr><td>cafe.reg.limitSex=Y</td><td>성별제한</td><td>sexFlag</td><td>0,M=남자, 1,F=여자</td></tr>
<tr><td>cafe.reg.limitAge=Y</td><td>나이제한(출생년도제한)</td><td>birthYyyy</td><td>-</td></tr>
<tr><td>cafe.reg.limitLoc=Y</td><td>지역제한</td><td>locCode</td><td>CO/919</td></tr>
<tr><td>cafe.reg.limitMajor=Y</td><td>전공제한</td><td>majorCode</td><td>CO/922</td></tr>
<tr><td>cafe.reg.limitCllg=Y</td><td>학부제한</td><td>cllgCode</td><td>CO/923</td></tr>
<tr><td>cafe.reg.limitOrg=Y</td><td>조직제한</td><td>orgCode</td><td>CO/924</td></tr>
</table> 
</ul>
</div>