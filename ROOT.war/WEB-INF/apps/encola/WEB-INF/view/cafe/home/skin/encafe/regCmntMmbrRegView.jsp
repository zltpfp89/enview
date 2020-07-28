<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ page import="com.saltware.encola.common.vo.CommunityVO" %>
<c:choose>
<c:when test="${mmbrVO.stateFlag == '10'}"><%--요 화면에 요청이 왔는데 '가입신청' 상태이면, 즉 이미 가입을 한 상태.--%>
  <div class="msg_box">
    <dl>
	  <dt><util:message key="cf.info.needApprove"/></dt>
	  <dd><util:message key="cf.info.accessCafe"/></dd>
    </dl>
  </div>
  <div>			
    <input type="button" value="<util:message key="cf.prop.back"/>" onclick="history.back()"/>
    <input type="button" value="<util:message key="cf.prop.goCafehome"/>" onclick="location.href='<%=request.getContextPath()%>/cafe';"/>
  </div>
  
</c:when>
<c:when test="${mmbrVO.stateFlag == '21'}"><%--요 화면에 요청이 왔는데 '가입거부' 상태이면--%>
	  <div style="border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px; padding:20px;text-align: center">
    <dl>
	  <dt>다음과 같은 사유로 가입이 거부되었습니다.<util:message key="cf.prop.goCafehome"/></dt>
	  <br/><br/>
	  <dd>
	    <c:if test="${mmbrVO.stateCode == '99'}"><c:out value="${mmbrVO.stateDesc}"/></c:if>
	    <c:if test="${mmbrVO.stateCode != '99'}"><c:out value="${mmbrVO.stateCodeNm}"/></c:if>
	  </dd>
    </dl>
    <c:if test="${cmntVO.openYn == 'N'}"><%--비공개카페의 경우 사용자의 편의를 위한 링크--%>
    <input type="button" value="<util:message key="cf.prop.back"/>" onclick="history.back()"/>
    <input type="button" value="<util:message key="cf.prop.goCafehome"/>" onclick="location.href='<%=request.getContextPath()%>/cafe';"/>
    </c:if>
  </div>
</c:when>
<%--요 화면에 요청이 왔는데 아직 가입승인도 아니고 가입거부도 아닌 상태.--%>
<c:otherwise>
	<c:choose>
	<%--가입하기전에 가입조건에 걸린 경우--%>
	<c:when test="${!empty homeForm.reasonCd || !empty eachForm.reasonCd}">
	  <div style="border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px; padding:20px;text-align: center">
	    <dl>
		  <dt>회원 가입에 제한이 있는 카페입니다.</dt>
		  <br/><br/>
		  <dd><c:out value="${homeForm.reason}"/><c:out value="${eachForm.reason}"/></dd>
	    </dl>
	    <c:if test="${cmntVO.openYn == 'N'}"><%--비공개카페의 경우 사용자의 편의를 위한 링크--%>
	    <a href="javascript:history.back()" title="<util:message key="cf.prop.back"/>"><util:message key="cf.prop.back"/></a>
	    <a href="<%=request.getContextPath()%>/cafe" title="<util:message key="cf.prop.goCafehome"/>"><util:message key="cf.prop.goCafehome"/></a>
	    </c:if>
	  </div>
	</c:when>
	<%--로그인 안한경우 경우--%>
<c:when test="${mmbrVO.isLogin == 'false'}">
<div>
  <span><util:message key="cf.info.needLogin"/></span>    
</div>
</c:when>
<c:when test="${mmbrVO.stateFlag == '20'}"><%--자동가입 카페에 재가입을 해서 가입승인 상태로 바뀌면 이곳으로 온다--%>
  <%
	CommunityVO cmntVO = (CommunityVO)request.getAttribute("cmntVO");
	response.setHeader ("enview.ajax.control", (request.getContextPath() + "/cafe/" + cmntVO.getCmntUrl()).replaceAll("\r", "").replaceAll("\n", ""));
  %>
</c:when>
<%--
<c:when test="${cmntVO.openYn=='N'  }">
  <div style="border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px; padding:20px;text-align: center">
    <dl>
	  <dt>비공개 카페입니다.</dt>
    </dl>
    <input type="button" value="<util:message key="cf.prop.back"/>" onclick="history.back()"/>
    <input type="button" value="<util:message key="cf.prop.goCafehome"/>" onclick="location.href='<%=request.getContextPath()%>/cafe';"/>
  </div>
</c:when>
 --%>
<c:otherwise>
<div class="cntt_extraInfo_wrap CF0501_nmBrdrColor" style="text-align:left;">
	<!-- content start -->  
	<div class="cntt_extraInfo_title CF0501_nmBrdrColor">
		<span class="CF0501_nmFontColor"><util:message key="cf.title.join.cafe"/></span>
	</div>
	<div class="cntt_updMyInfo_box">
		<div class="myinfo_wrap">
			<fieldset class="myinfo_field">
				<legend><util:message key="cf.title.basicInfo"/></legend>
				<dl class="reg_form">
					<dt>ㆍ <util:message key="cf.title.nickname"/></dt>
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
	<!-- content end -->
	     
<c:if test="${limitVO.limitQuiz != 'N'}">
	<dt>ㆍ <util:message key="cf.title.joinQuiz"/></dt>
	<dd>
		  <img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/qstn.gif" width="17" height="17" align="absmiddle">
          <c:out value="${limitVO.regQuizQstn}"/>
		  <br>
		  <span style="margin-left:20px"><img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/answ.gif" width="17" height="17" align="absmiddle"></span>
          <input type="text" id="regQuizAnsw" name="regQuizAnsw" maxLength="20" class="full_cafetextfield"/>
		</dd>
  </c:if>
  <c:if test="${limitVO.limitQstn != 'N'}">  
  <dt>ㆍ <util:message key="cf.title.joinSurvey"/></dt>
  <dd>
		  <c:forEach items="${qstnList}" var="qstn" varStatus="status">
			<li id="regQstnLi" name="regQstnLi" qstnSeq="<c:out value="${qstn.qstnSeq}"/>" qstnType="<c:out value="${qstn.qstnType}"/>" style="list-style:none;line-height:20px;">
			  <span>
			  	<!-- 
			    <img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/qstn.gif" width="17" height="17" align="absmiddle">
			     -->
				<b><c:out value="${qstn.qstnSeq}"/>.</b>&nbsp;<c:out value="${qstn.contents}"/>
			  </span>
			  <c:if test="${qstn.qstnType=='A'}">
				<c:set var="answList" value="${qstn.answList}"/>
				<jsp:useBean id="answList" type="java.util.List"/>
				<c:forEach items="${answList}" var="answ">
				  <br>
				  <span style="margin-left:20px">
				  	<!-- 
					<img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/answ.gif" width="17" height="17" align="absmiddle">
					 -->
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
  		</dd>
				</dl>
			</fieldset>
			<div class="cl">&nbsp;</div>
		</div>  <!-- end myinfo_wrap -->
	</div>
  </c:if>
	<%--
	<div class="btn_center">
		<a onclick="cfHome.getRegMngr().regCmntMmbr('10')"><img alt="저장" src="<%=request.getContextPath()%>/cola/cafe/images/each/encafe/cntt/btn_save.gif"></a>
		<!-- <a onclick="cfCntt.m_updMyInfo.cancel()"><img alt="취소" src="<%=request.getContextPath()%>/cola/cafe/images/each/encafe/cntt/btn_cancel.gif"></a> -->
	</div>
	 --%>
  <table style="width:100%;" class="cafebuttonpanel">
	<tr>
	  <td align="center">  
	    <input type="button" value="<util:message key="cf.prop.join"/>" onclick="cfHome.getRegMngr().regCmntMmbr('10')" class="CF0601_srchBtn srchBtn " >
	  </td>
	</tr>
  </table>
  <br/>
  <c:if test="${cmntVO.regType != 'A'}"><%--'가입유형'이 자동가입이 아닌 경우--%>
	<dl>
	  <dd><util:message key="cf.info.needApprove"/></dt>
	  <dd><util:message key="cf.info.accessCafe"/></dd>
	</dl>
  </c:if>
</div>
<div style="text-align: center">
    <input type="button" value="<util:message key="cf.prop.back"/>" onclick="history.back()"/>
    <input type="button" value="<util:message key="cf.prop.goCafehome"/>" onclick="location.href='<%=request.getContextPath()%>/cafe';"/>
</div>

</c:otherwise>
</c:choose>
<%--END::가입화면--%>
</c:otherwise>
</c:choose>


