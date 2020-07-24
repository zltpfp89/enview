<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<div class="cafeadm_top">
	<h3><util:message key="cf.title.mng.cafeMember"/></h3>
	<ul class="location">
		<li>HOME<span class="nextbar"></span></li>
		<li><util:message key="cf.title.mng.memberInfo"/><span class="nextbar"></span></li>
		<li class="last"><util:message key="cf.title.mng.cafeMember"/></li>
	</ul>
</div>
									
<div class="cafeadm_tabmenu">
	<ul>
		<li class="on" id="reg_tab0" onclick="cfOp.regMmbr.selectTab(0);">
			<a href="javascript:cfOp.regMmbr.selectTab(0);" onclick="regMmbrAllTab"><util:message key="cf.prop.wholeMembers"/></a>
		</li>
		<li class="" id="reg_tab1" onclick="cfOp.regMmbr.selectTab(1);">
			<a href="javascript:cfOp.regMmbr.selectTab(1);" onclick="regMmbrGupTab"><util:message key="cf.title.levelUp.waiting"/></a>
		</li>
		<c:if test="${cmntVO.openYn != 'Y' || cmntVO.regType != 'A'}">
      		<li class="" id="reg_tab2" onclick="cfOp.regMmbr.selectTab(2)">
      			<a href="javascript:cfOp.regMmbr.selectTab(2);" onclick="regMmbrInvTab">
      				<util:message key="cf.title.invitation.join"/>
      			</a>
      		</li>
    	</c:if>
	</ul>
</div>

  <div id="regMmbrAllTab" class="tabcontent"></div>
  <div id="regMmbrGupTab" class="tabcontent"></div>
  <c:if test="${cmntVO.openYn != 'Y' || cmntVO.regType != 'A'}">	
  	<div id="regMmbrInvTab" class="tabcontent"></div>
  </c:if>
