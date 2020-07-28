<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>


<html>
	<head>
		<title><util:message key="cf.title.system"/></title>
		<meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-style-type" content="text/css" />
		<meta http-equiv="X-UA-Compatible" content="IE=10" />
		<meta name="version" content="3.2.6" />
		<meta name="keywords" content="" />

		<link type="text/css" href="<%=request.getContextPath()%>/decorations/layout/css/jquery/base/jquery.ui.all.css" rel="stylesheet" />
		
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/cola/cafe/css/each/<c:out value="${skin}"/>.css" />
		<link id = "themeCss" rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/cola/cafe/theme/${cmntVO.theme}.css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/ui/i18n/jquery.ui.datepicker-ko.js"></script>
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_ko_mm.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_ko_ev.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_ko_cf.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portal_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/utility.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validator.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_util.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/calendar/calendar.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/calendar/ko-kr/generatecalendar.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_list.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_read.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_edit.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/home/encafe.js"></script> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/each/encafe.js"></script>

		<style type="text/css">
		.content { text-align: center; width:640px;margin: auto;font-size: 13px;}
		.msg_box { border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px;text-align: center; width:600px; margin:20px;padding:20px; line-height: 30px;}
		input[type="button"] {margin: 4px;}
		</style>
	</head>
	<div id="title_cafeName" style="display: none"><c:out value="${cmntVO.cmntNm}"/></div>
	<div class="content">
	<%--
	cmntVO.openYn=${cmntVO.openYn},cmntVO.regType=${cmntVO.regType}
	<br> 
	mmbrVO.isMmbr=${mmbrVO.isMmbr},mmbrVO.stateFlag=${mmbrVO.stateFlag}
	<br/>
	homeForm.view=${homeForm.view}
	 --%>
<%--이 화면이 실행되는 상황은 이미 사용자는 로그인이 된 상태다.--%>
<%--BEGIN::비공개카페--%>
<c:if test="${cmntVO.openYn == 'N'}">
  <%--BEGIN::아직초대요청조차도 안해서 아직 회원내역이 없는 상태--%>
  <c:if test="${mmbrVO.isMmbr == 'false'}">
    <c:if test="${cmntVO.regType == 'V'}"><%--운영자 초대/승인 방식--%>
	  <div class="msg_box">
	    <div><h2><util:message key="cf.info.privateCafe"/></h2></div>
	    <dl>
		  <dt>
		    <util:message key="cf.info.wantJoin"/><br/>
		    <util:message key="cf.info.inviteMail"/><br/>
		    <input type="hidden" id="cmntUrl" name="cmntUrl" value="<c:out value="${cmntVO.cmntUrl}"/>"/>
		    <input type="hidden" id="retry" name="retry"/>
		    <input type='button' onclick="cfHome.getRegMngr().regCmntMmbr('12')" value="<util:message key="cf.prop.sendInvate.request"/>"/>
		  </dt>
		  <dd>
		  	<util:message key="cf.prop.aboutIoin"/>
		  </dd>
	    </dl>
	  </div>
	  <div>			
	      <input  type="button" onclick="history.back()" value="<util:message key="cf.prop.back"/>"/>
	      <input  type="button" onclick="document.location.href='<%=request.getContextPath()%>/cafe';" value="<util:message key="cf.prop.goCafehome"/>"/>
	  </div>
    </c:if>
    <c:if test="${cmntVO.regType != 'V'}"><%--'자동가입'이거나 '운영자승인' 방식--%>
	  <jsp:include page="./regCmntMmbrRegView.jsp"/>
    </c:if>
  </c:if>
  <%--END::아직초대요청조차도 안해서 아직 회원내역이 없는 상태--%>
  <%--BEGIN::회원 상태는 어쨌거나 회원내역은 존재하는 상태--%>
  <c:if test="${mmbrVO.isMmbr == 'true'}">
	<c:if test="${mmbrVO.stateFlag == '12'}"><%--'초대신청'(12) 상태임--%>
	    <div class="msg_box">
	    <dl>
		  <dt>
		  	<util:message key="cf.info.send.requestEmail"/>
		    <input type="hidden" id="cmntUrl" name="cmntUrl" value="<c:out value="${cmntVO.cmntUrl}"/>"/>
		    <input type="hidden" id="retry" name="retry"/>
			<input type="button" onclick="cfHome.getRegMngr().regCmntMmbr('13')" value="<util:message key="cf.prop.cancel.inviteRequest"/>"/>
		  </dt>
		  <dd>
		    <util:message key="cf.info.canJoin"/>
		  </dd>
	    </dl>
	  </div>
	  <div>			
	      <input  type="button" onclick="history.back()" value="<util:message key="cf.prop.back"/>"/>
	      <input  type="button" onclick="document.location.href='<%=request.getContextPath()%>/cafe';" value="<util:message key="cf.prop.goCafehome"/>"/>
	  </div>
	</c:if>
	<c:if test="${mmbrVO.stateFlag == '22'}"><%--'초대승인'(22) 상태임--%>
	  <c:if test="${homeForm.view == 'regView'}"><%--회원가입화면--%>
		<jsp:include page="./regCmntMmbrRegView.jsp"/>
	  </c:if>
	  <c:if test="${homeForm.view != 'regView'}"><%--회원가입안내화면--%>
	    <div class="msg_box">
	      <form name="regForm" method="post" onsubmit="return false;">
	      <dl>
		    <dt>
		    	<c:if test="${langKnd eq 'ko'}">
		      		<c:out value="${loginInfo.nm_kor}"/>님은 카페 '<c:out value="${cmntVO.cmntNm}"/>'의 카페지기로부터 초대를 받으셨습니다.
		      	</c:if>
		      	<c:if test="${langKnd eq 'en'}">
		      		<c:out value="${loginInfo.nm_kor}"/> was invited from the '<c:out value="${cmntVO.cmntNm}"/>'.
		      	</c:if>
		      <br><br><util:message key="cf.info.joinLink"/>
		      <input type="hidden" id="view" name="view" value="regView"/>
		      <input type="hidden" id="cmntUrl" name="cmntUrl" value="<c:out value="${cmntVO.cmntUrl}"/>"/>
			  <br><br>
			  <input  type="button" onclick="cfHome.getRegMngr().regCmntMmbr('regView')" value='<util:message key="cf.prop.do.joinCafe"/>'/>
		    </dt>
	      </dl>
		  </form>
	    </div>
	    <div>			
	      <input  type="button" onclick="history.back()" value="<util:message key="cf.prop.back"/>"/>
	      <input  type="button" onclick="document.location.href='<%=request.getContextPath()%>/cafe';" value="<util:message key="cf.prop.goCafehome"/>"/>
	    </div>
	  </c:if>
	</c:if>
	<c:if test="${mmbrVO.stateFlag == '23'}"><%--'초대거부'(23) 상태임--%>
	    <div class="msg_box">
	    <dl>
		  <dt>
		  	<util:message key="cf.info.rejectReason"/>
		  </dt>
		  <dd>
		    <br><br>
			<c:if test="${mmbrVO.stateCode == '99'}"><c:out value="${mmbrVO.stateDesc}"/></c:if>
			<c:if test="${mmbrVO.stateCode != '99'}"><c:out value="${mmbrVO.stateCodeNm}"/></c:if>
		  </dd>
	    </dl>
	  </div>
	  <div>			
	      <input  type="button" onclick="history.back()" value="<util:message key="cf.prop.back"/>"/>
	      <input  type="button" onclick="document.location.href='<%=request.getContextPath()%>/cafe';" value="<util:message key="cf.prop.goCafehome"/>"/>
	  </div>
	</c:if>
	<c:if test="${mmbrVO.stateFlag == '10' || mmbrVO.stateFlag == '21'}"><%--'가입신청'/'가입거부' 상태임--%>
	  <%--regCmntMmbrRegView.jsp 화면을 공개카페인 경우에 같이 사용하기 위하여 위와 같은 상태에서 다음 파일로 분기--%>
	  <jsp:include page="./regCmntMmbrRegView.jsp"/>
	</c:if>
	<c:if test="${mmbrVO.stateFlag == '40' || mmbrVO.stateFlag == '51'}"><%--활동중지/강제탈퇴 상태임--%>
	  <div class="msg_box">
	    <dl>
		  <dt>
		  	<c:if test="${langKnd eq 'ko'}">
			  	<dt>
			      	 다음과 같은 사유로 카페에서
					&nbsp;
					<c:if test="${mmbrVO.stateFlag == '40'}">활동중지</c:if>
					<c:if test="${mmbrVO.stateFlag == '51'}">강제탈퇴</c:if>
					&nbsp;		되었습니다.<br>
		  		</dt>
	      	</c:if>
	      	<c:if test="${langKnd eq 'en'}">
	      		<dt>You have been 
					&nbsp;
					<c:if test="${mmbrVO.stateFlag == '40'}">suspended</c:if>
					<c:if test="${mmbrVO.stateFlag == '51'}">left</c:if>
					&nbsp;
					from cafes for the following reasons<br>
					Please contact the <a href="mailto:<c:out value="${cafejigiEMailAddr}"/>">sysop</a>
		  		</dt>
	      	</c:if>
		  <dd>
		    <br>
			<c:if test="${mmbrVO.stateCode == '99'}"><c:out value="${mmbrVO.stateDesc}"/></c:if>
			<c:if test="${mmbrVO.stateCode != '99'}"><c:out value="${mmbrVO.stateCodeNm}"/></c:if>
		  </dd>
		<br/>  
		<a href="mailto:<c:out value="${cafejigiEMailAddr}"/>">카페지기</a>에게 문의하십시오.
	    </dl>
	  </div>
	  <div style="padding:10px;text-align: center">			
	    <input type="button" onclick="history.back();" value="<util:message key="cf.prop.back"/>" />
	    <input type="button" onclick="location.href='<%=request.getContextPath()%>/cafe';" value="<util:message key="cf.prop.goCafehome"/>"/>
	  </div>
	</c:if>
	<c:if test="${mmbrVO.stateFlag == '50'}"><%--자진탈퇴 상태임--%>
	  <div class="msg_box">
	    <dl>
		  <dt>
		  	<c:if test="${langKnd eq 'ko'}">
		  		<c:out value="${mmbrVO.stateDatimPF}"/>&nbsp;에 자진탈퇴하신 카페입니다.
	      	</c:if>
	      	<c:if test="${langKnd eq 'en'}">
	      		It is the cafe that voluntarily left in <c:out value="${mmbrVO.stateDatimPF}"/>.
	      	</c:if>
		  </dt>
		  <dd>
		    <input type="hidden" id="cmntUrl" name="cmntUrl" value="<c:out value="${cmntVO.cmntUrl}"/>"/>
		    <input type="hidden" id="retry" name="retry"/>
		    <%--
		    <font onclick="cfHome.getRegMngr().regCmntMmbr('rereg')" style="cursor:pointer" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'">
		   		<util:message key="cf.prop.rejoin"/>
		    </font>
		     --%>
	    <input type="button" onclick="cfHome.getRegMngr().regCmntMmbr('rereg');" value="<util:message key="cf.prop.rejoin"/>" />
		  </dd>
	    </dl>
	  </div>
	  <div style="padding:10px;text-align: center">			
	    <input type="button" onclick="history.back();" value="<util:message key="cf.prop.back"/>" />
	    <input type="button" onclick="location.href='<%=request.getContextPath()%>/cafe';" value="<util:message key="cf.prop.goCafehome"/>"/>
	  </div>
	</c:if>
	
  </c:if>
  <%--END::회원 상태는 어쨌거나 회원내역은 존재하는 상태--%>
</c:if>
<%--END::비공개카페--%>
<c:if test="${empty requestScope.windownId && param.__ajax_call_ != 'true'}">
  <%--포틀릿으로서 동작하고 있지 않고, AJAX를 통한 호출이 아닐 때에는 enView의 Javascript를 포함시켜준다--%>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common_new.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portal_new.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/utility.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validator.js"></script>
  <!--script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/messageResource_<c:out value="${secPmsnVO.locale}"/>.js"></script-->
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/messageResource_ko.js"></script>

  <link type="text/css" href="<%=request.getContextPath()%>/decorations/layout/css/jquery/base/jquery.ui.all.css" rel="stylesheet" />
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
  <!--script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/ui/i18n/jquery.ui.datepicker-<c:out value="${secPmsnVO.locale}"/>.js"></script-->
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/ui/i18n/jquery.ui.datepicker-ko.js"></script>
</c:if>
<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/cafe_home.js"></script>
</div>