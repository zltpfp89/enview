<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.saltware.encola.common.vo.CommunityVO" %>
<c:if test="${mmbrVO.stateFlag == '10'}"><%--요 화면에 요청이 왔는데 '가입신청' 상태이면, 즉 이미 가입을 한 상태.--%>
  <div style="border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px;">
    <dl>
	  <dt>회원가입을 위해서는 카페지기의 승인이 필요한 카페입니다.</dt>
	  <br/><br/>
	  <dd>카페지기로부터 가입승인 메일을 받으신 후 카페에 접속하시기 바랍니다.</dd>
    </dl>
    <c:if test="${cmntVO.openYn == 'N'}"><%--비공개카페의 경우 사용자의 편의를 위한 링크--%>
	<a href="javascript:history.back()" title="되돌아가기">되돌아가기</a>
	<a href="<%=request.getContextPath()%>/cafe" title="카페홈 바로가기">카페홈 바로가기</a>
    </c:if>
  </div>
</c:if>
<c:if test="${mmbrVO.stateFlag == '21'}"><%--요 화면에 요청이 왔는데 '가입거부' 상태이면--%>
  <div style="border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px;">
    <dl>
	  <dt>다음과 같은 사유로 가입이 거부되었습니다.</dt>
	  <br/><br/>
	  <dd>
	    <c:if test="${mmbrVO.stateCode == '99'}"><c:out value="${mmbrVO.stateDesc}"/></c:if>
	    <c:if test="${mmbrVO.stateCode != '99'}"><c:out value="${mmbrVO.stateCodeNm}"/></c:if>
	  </dd>
    </dl>
    <c:if test="${cmntVO.openYn == 'N'}"><%--비공개카페의 경우 사용자의 편의를 위한 링크--%>
	<a href="javascript:history.back()" title="되돌아가기">되돌아가기</a>
	<a href="<%=request.getContextPath()%>/cafe" title="카페홈 바로가기">카페홈 바로가기</a>
    </c:if>
  </div>
</c:if>
<c:if test="${mmbrVO.stateFlag != '10' && mmbrVO.stateFlag != '21'}"><%--요 화면에 요청이 왔는데 아직 가입승인도 아니고 가입거부도 아닌 상태.--%>
	<c:if test="${!empty homeForm.reasonCd || !empty eachForm.reasonCd}"><%--가입하기전에 가입조건에 걸린 경우--%>
	  <div style="border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px;">
	    <dl>
		  <dt>회원 가입에 제한이 있는 카페입니다.</dt>
		  <br/><br/>
		  <dd><c:out value="${homeForm.reason}"/><c:out value="${eachForm.reason}"/></dd>
	    </dl>
	    <c:if test="${cmntVO.openYn == 'N'}"><%--비공개카페의 경우 사용자의 편의를 위한 링크--%>
	    <a href="javascript:history.back()" title="되돌아가기">되돌아가기</a>
	    <a href="<%=request.getContextPath()%>/cafe" title="카페홈 바로가기">카페홈 바로가기</a>
	    </c:if>
	  </div>
	</c:if>
<%--BEGIN::가입화면--%>
<c:if test="${empty homeForm.reasonCd && empty eachForm.reasonCd}">
<c:if test="${mmbrVO.isLogin == 'true'}">
<c:if test="${mmbrVO.stateFlag == '20'}"><%--자동가입 카페에 재가입을 해서 가입승인 상태로 바뀌면 이곳으로 온다--%>
  <%
	CommunityVO cmntVO = (CommunityVO)request.getAttribute("cmntVO");
	response.setHeader ("enview.ajax.control", request.getContextPath() + "/cafe/" + cmntVO.getCmntUrl());
  %>
</c:if>
<c:if test="${mmbrVO.stateFlag != '20'}">
<div class="cntt_extraInfo_wrap CF0501_nmBrdrColor">
	<!-- content start -->  
	<div class="cntt_extraInfo_title CF0501_nmBrdrColor">
		<span class="CF0501_nmFontColor">카페 가입</span>
	</div>
	<div class="cntt_updMyInfo_box">
		<div class="myinfo_wrap">
			<fieldset class="myinfo_field">
				<legend>기본정보</legend>
				<dl class="reg_form">
					<dt>ㆍ 닉네임</dt>
					<dd>
						<input id="userNick" name="userNick" maxlength="30" style="width:200px" value="<c:out value="${mmbrVO.loginInfo.nm_kor }"/>"
							onfocus="cfCntt.dupCheckUserNickReset()" onblur="cfCntt.dupCheckUserNick(this)"
						/>
						<input type="hidden" id="cafeUrl" name="cafeUrl" value="<c:out value="${cmntVO.cmntUrl}"/>"/>
						<input type="hidden" id="userId" name="userId" value="<c:out value="${mmbrVO.loginInfo.user_id}"/>" />
						<input type="hidden" id="cmntUrl" name="cmntUrl" value="<c:out value="${cmntVO.cmntUrl}"/>"/>
						<input type="hidden" id="retry" name="retry"/>
						<input type="hidden" id="userNickValidted" name="userNickValidted" value="false" />
						<span id="userNickRslt" class="userNickRslt"></span>
					</dd>
				</dl>
			</fieldset>
			<div class="cl">&nbsp;</div>
		</div>  <!-- end myinfo_wrap -->
	</div>
	<!-- content end -->     
	<div class="btn_center">
		<a onclick="cfHome.getRegMngr().regCmntMmbr('10')"><img alt="저정" src="/enview/cola/cafe/images/each/encafe/cntt/btn_save.gif"></a>
		<!-- <a onclick="cfCntt.m_updMyInfo.cancel()"><img alt="취소" src="/enview/cola/cafe/images/each/encafe/cntt/btn_cancel.gif"></a> -->
	</div>
</div>
<c:if test="${limitVO.limitQuiz != 'N'}">
	<dt><h2>가입 퀴즈</h2></dt>
  <dd>
    <table cellpadding=0 cellspacing=0 border=0 width='100%'>
	  <tr><td colspan="2" width="100%" class="cafeformheaderline"></td></tr>
	  <tr>
	    <td width="20%" class="cafeformlabel"><img src="<%=request.getContextPath()%>/cola/cafe/images/tb_icon.gif" width="5" height="5" align="absmiddle">가입 퀴즈</td>
	    <td class="cafeformfield" align="left">
		  <img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/qstn.gif" width="17" height="17" align="absmiddle">
          <c:out value="${limitVO.regQuizQstn}"/>
		  <br>
		  <span style="margin-left:20px"><img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/answ.gif" width="17" height="17" align="absmiddle"></span>
          <input type="text" id="regQuizAnsw" name="regQuizAnsw" maxLength="20" class="full_cafetextfield"/>
	    </td>
	  </tr>
	</table>
  </dd>
  </c:if>
  <c:if test="${limitVO.limitQstn != 'N'}">  
  <dt><h2>가입 설문</h2></dt>
  <dd>
    <table cellpadding=0 cellspacing=0 border=0 width='100%'>
	  <tr><td colspan="2" width="100%" class="cafeformheaderline"></td></tr>
	  <tr>
	    <td width="20%" class="cafeformlabel"><img src="<%=request.getContextPath()%>/cola/cafe/images/tb_icon.gif" width="5" height="5" align="absmiddle">가입 설문</td>
	    <td class="cafeformfield" align="left">
		  <c:forEach items="${qstnList}" var="qstn" varStatus="status">
			<li id="regQstnLi" name="regQstnLi" qstnSeq="<c:out value="${qstn.qstnSeq}"/>" qstnType="<c:out value="${qstn.qstnType}"/>">
			  <span>
			    <img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/qstn.gif" width="17" height="17" align="absmiddle">
				<b><c:out value="${qstn.qstnSeq}"/>.</b>&nbsp;<c:out value="${qstn.contents}"/>
			  </span>
			  <c:if test="${qstn.qstnType=='A'}">
				<c:set var="answList" value="${qstn.answList}"/>
				<jsp:useBean id="answList" type="java.util.List"/>
				<c:forEach items="${answList}" var="answ">
				  <br>
				  <span style="margin-left:20px">
					<img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/answ.gif" width="17" height="17" align="absmiddle">
					<input type="radio" id="answSeq<c:out value="${status.count}"/>" name="answSeq<c:out value="${status.count}"/>" value="<c:out value="${answ.answSeq}"/>"/>
					<c:out value="${answ.contents}"/>
				  </span>
				</c:forEach>
			  </c:if>
			  <c:if test="${qstn.qstnType=='B'}">
			    <br>
				<span style="margin-left:20px">
				  <img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/answ.gif" width="17" height="17" align="absmiddle">
			      <input type="text" id="contents<c:out value="${status.count}"/>" name="contents<c:out value="${status.count}"/>" maxlength="512"/>
				</span>
			  </c:if>
			</li>
		  </c:forEach>
		</td>
	  </tr>
	</table>
  </dd>
  </c:if>
  <table style="width:100%;" class="cafebuttonpanel">
	<!--tr>
	  <td align="center">  
	    <input type="button" value="가입" onclick="cfHome.getRegMngr().regCmntMmbr('10')"/>
	  </td>
	</tr-->
  </table>
</div>
<div>
  <c:if test="${cmntVO.regType != 'A'}"><%--'가입유형'이 자동가입이 아닌 경우--%>
	<dl>
	  <dt>회원가입을 위해서는 카페지기의 승인이 필요한 카페입니다.</dt>
	  <br><br>
	  <dd>카페지기로부터 가입승인 메일을 받으신 후 카페에 접속하시기 바랍니다.</dd>
	</dl>
	<c:if test="${cmntVO.openYn == 'N'}"><%--비공개카페의 경우 사용자의 편의를 위한 링크--%>
	  <a href="javascript:history.back()" title="되돌아가기">되돌아가기</a>
	  <a href="<%=request.getContextPath()%>/cafe" title="카페홈 바로가기">카페홈 바로가기</a>
	</c:if>
  </c:if>
</div>
</c:if>
</c:if>
<c:if test="${mmbrVO.isLogin == 'false'}">
<div>
  <span>로그인을 하셔야 합니다.</span>    
</div>
</c:if>
</c:if>
<%--END::가입화면--%>
</c:if>