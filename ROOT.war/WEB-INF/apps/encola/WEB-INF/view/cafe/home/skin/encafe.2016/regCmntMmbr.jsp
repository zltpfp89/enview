<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--이 화면이 실행되는 상황은 이미 사용자는 로그인이 된 상태다.--%>
<%--BEGIN::비공개카페--%>
<c:if test="${cmntVO.openYn == 'N'}">
  <%--BEGIN::아직초대요청조차도 안해서 아직 회원내역이 없는 상태--%>
  <c:if test="${mmbrVO.isMmbr == 'false'}">
    <c:if test="${cmntVO.regType == 'V'}"><%--운영자 초대/승인 방식--%>
	  <div style="border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px;">
	    <div><h2>비공개 카페입니다.</h2></div>
	    <dl>
		  <dt>
		    가입을 원하시면 카페지기에게 초대요청을 보내시기 바랍니다.
		    <br><br>카페지기의 초대메일은 회원정보에 등록하신 메일주소로 발송됩니다.
		    <input type="hidden" id="cmntUrl" name="cmntUrl" value="<c:out value="${cmntVO.cmntUrl}"/>"/>
		    <input type="hidden" id="retry" name="retry"/>
		    <br><br>
		    <font onclick="cfHome.getRegMngr().regCmntMmbr('12')" style="cursor:pointer" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'">
		      초대 요청 보내기
		    </font>
		  </dt>
		  <dd>
		    카페지기로부터 초대 메일을 받으신 후에 해당 카페에 접속하시면 카페에 가입하실 수 있습니다.
		  </dd>
	    </dl>
	  </div>
	  <div>			
	    <a href="javascript:history.back();">되돌아가기</a>
	    <a href="<%=request.getContextPath()%>/cafe" title="카페홈 바로가기">카페홈 바로가기</a>
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
	  <div style="border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px;">
	    <dl>
		  <dt>
		    가입을 위해 해당 카페의 카페지기에게 초대요청메일을 발송한 상태입니다.
		    <input type="hidden" id="cmntUrl" name="cmntUrl" value="<c:out value="${cmntVO.cmntUrl}"/>"/>
		    <input type="hidden" id="retry" name="retry"/>
		    <br><br>
			<font onclick="cfHome.getRegMngr().regCmntMmbr('13')" style="cursor:pointer" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'">
			  초대 요청 취소
			</font>
		  </dt>
		  <dd>
		    카페지기로부터 초대 메일을 받으신 후에 해당 카페에 접속하시면 카페에 가입하실 수 있습니다.
		  </dd>
	    </dl>
	  </div>
	  <div>			
	    <a href="javascript:history.back();">되돌아가기</a>
	    <a href="<%=request.getContextPath()%>/cafe" title="카페홈 바로가기">카페홈 바로가기</a>
	  </div>
	</c:if>
	<c:if test="${mmbrVO.stateFlag == '22'}"><%--'초대승인'(22) 상태임--%>
	  <c:if test="${homeForm.view == 'regView'}"><%--회원가입화면--%>
		<jsp:include page="./regCmntMmbrRegView.jsp"/>
	  </c:if>
	  <c:if test="${homeForm.view != 'regView'}"><%--회원가입안내화면--%>
	    <div style="border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px;">
	      <form name="regForm" method="POST" onsubmit="return false;">
	      <dl>
		    <dt>
		      <c:out value="${loginInfo.nm_kor}"/>님은 카페 '<c:out value="${cmntVO.cmntNm}"/>'의 카페지기로부터 초대를 받으셨습니다.
		      <br><br>아래 링크를 통해 해당 카페에 가입하실 수 있습니다.
		      <input type="hidden" id="view" name="view" value="regView"/>
		      <input type="hidden" id="cmntUrl" name="cmntUrl" value="<c:out value="${cmntVO.cmntUrl}"/>"/>
			  <br><br>
			  <font onclick="cfHome.getRegMngr().regCmntMmbr('regView')" style="cursor:pointer" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'">
			    카페 가입 하기
			  </font>
		    </dt>
	      </dl>
		  </form>
	    </div>
	    <div>			
	      <a href="javascript:history.back()" title="되돌아가기">되돌아가기</a>
	      <a href="<%=request.getContextPath()%>/cafe" title="카페홈 바로가기">카페홈 바로가기</a>
	    </div>
	  </c:if>
	</c:if>
	<c:if test="${mmbrVO.stateFlag == '23'}"><%--'초대거부'(23) 상태임--%>
	  <div style="border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px;">
	    <dl>
		  <dt>
		    다음과 같은 사유로 카페 초대가 거부되었습니다.
		  </dt>
		  <dd>
		    <br><br>
			<c:if test="${mmbrVO.stateCode == '99'}"><c:out value="${mmbrVO.stateDesc}"/></c:if>
			<c:if test="${mmbrVO.stateCode != '99'}"><c:out value="${mmbrVO.stateCodeNm}"/></c:if>
		  </dd>
	    </dl>
	  </div>
	  <div>			
	    <a href="javascript:history.back();">되돌아가기</a>
	    <a href="<%=request.getContextPath()%>/cafe" title="카페홈 바로가기">카페홈 바로가기</a>
	  </div>
	</c:if>
	<c:if test="${mmbrVO.stateFlag == '10' || mmbrVO.stateFlag == '21'}"><%--'가입신청'/'가입거부' 상태임--%>
	  <%--regCmntMmbrRegView.jsp 화면을 공개카페인 경우에 같이 사용하기 위하여 위와 같은 상태에서 다음 파일로 분기--%>
	  <jsp:include page="./regCmntMmbrRegView.jsp"/>
	</c:if>
	<c:if test="${mmbrVO.stateFlag == '40' || mmbrVO.stateFlag == '51'}"><%--활동중지/강제탈퇴 상태임--%>
	  <div style="border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px;">
	    <dl>
		  <dt>
		    다음과 같은 사유로 카페에서
			&nbsp;
			<c:if test="${mmbrVO.stateFlag == '40'}">활동중지</c:if>
			<c:if test="${mmbrVO.stateFlag == '51'}">강제탈퇴</c:if>
			&nbsp;
			되었습니다.<br>
			<a href="mailto:<c:out value="${cafejigiEMailAddr}"/>">카페지기</a>에게 문의하십시오.
		  </dt>
		  <dd>
		    <br><br>
			<c:if test="${mmbrVO.stateCode == '99'}"><c:out value="${mmbrVO.stateDesc}"/></c:if>
			<c:if test="${mmbrVO.stateCode != '99'}"><c:out value="${mmbrVO.stateCodeNm}"/></c:if>
		  </dd>
	    </dl>
	  </div>
	  <div>			
	    <a href="javascript:history.back();">되돌아가기</a>
	    <a href="<%=request.getContextPath()%>/cafe" title="카페홈 바로가기">카페홈 바로가기</a>
	  </div>
	</c:if>
	<c:if test="${mmbrVO.stateFlag == '50'}"><%--자진탈퇴 상태임--%>
	  <div style="border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px;">
	    <dl>
		  <dt>
		    <c:out value="${mmbrVO.stateDatimPF}"/>&nbsp;에 자진탈퇴하신 카페입니다.
		  </dt>
		  <dd>
		    <br><br>
		    <input type="hidden" id="cmntUrl" name="cmntUrl" value="<c:out value="${cmntVO.cmntUrl}"/>"/>
		    <input type="hidden" id="retry" name="retry"/>
		    <br><br>
		    <font onclick="cfHome.getRegMngr().regCmntMmbr('rereg')" style="cursor:pointer" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'">
		      카페 다시 가입하기
		    </font>
		  </dd>
	    </dl>
	  </div>
	  <div>			
	    <a href="javascript:history.back();">되돌아가기</a>
	    <a href="<%=request.getContextPath()%>/cafe" title="카페홈 바로가기">카페홈 바로가기</a>
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

