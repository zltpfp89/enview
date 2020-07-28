<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/cola/cafe/css/styles.css">
  <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/board/calendar/css/calendar.css">

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" height="100%" border="1" cellpadding="0" cellspacing="0">
  <tr colspan="2">
	<td valign="top">[HEADER]</td>
  </tr>
  <tr colspan="2">
    <td>
	  <span style="cursor:hand" onclick="cfOp.goJigi()">카페관리</span>
	  |
	  <span style="cursor:hand" onclick="cfOp.goEachHome()"><c:out value="${cmntVO.cmntNm}"/></span>
	</td>
  </tr>
  <tr> 
	<td width="100%" height="100%" valign="top">
	  <table width="100%" height="100%" border="1" cellpadding="0" cellspacing="0">
		<tr> 
		  <!-- left menu begin -->
		  <td width="182" valign="top" class="leftmenu_bg">
		    <div style="border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px;">
			  <li><h3 title="카페 정보 관리">카페 정보 관리</h3>
			    <ul>
				  <li><a href="javascript:cfOp.chgOpArea('baseInfo')">기본 정보</a></li>
				  <li><a href="javascript:cfOp.chgOpArea('regInfo')">가입 정보</a></li>
				  <%--li><a href="javascript:cfOp.chgOpArea('statistics')">통계 보기</a></li--%>
			    </ul>
			  </li>
			  <li><h3 title="메뉴/게시물 관리">메뉴/게시물 관리</h3>
			    <ul>
				  <li><a href="javascript:cfOp.chgOpArea('menuMng')">메뉴 관리</a></li>
				  <li><a href="javascript:cfOp.chgOpArea('bltnMng')">게시글 관리</a></li>
				  <%--li><a href="javascript:cfOp.chgOpArea('somoMng')">소모임 관리</a></li--%>
			    </ul>
			  </li>
			  <li><h3 title="회원 정보 관리">회원 정보 관리</h3>
			    <ul>
				  <li><a href="javascript:cfOp.chgOpArea('regMmbr')">가입 회원</a></li>
				  <li><a href="javascript:cfOp.chgOpArea('brdSysop')">게시판지기</a></li>
				  <li><a href="javascript:cfOp.chgOpArea('rsgnMmbr')">탈퇴 회원</a></li>
				  <li><a href="javascript:cfOp.chgOpArea('mmbrGrd')">회원 등급</a></li>
				  <%--li><a href="javascript:cfOp.chgOpArea('mailSms')">메일/쪽지</a></li--%>
			    </ul>
			  </li>
			  <%--li class="end"><h3 title="화면 관리">화면 관리</h3--%>
			    <%--ul--%>
				  <%--li><a href="javascript:cfOp.chgOpArea('homeDeco')">홈 꾸미기</a></li--%>
				  <%--li><a href="javascript:cfOp.chgOpArea('ttlDeco')">타이틀</a></li--%>
				  <%--li><a href="javascript:cfOp.chgOpArea('gateDeco')">대문</a></li--%>
				  <%--li><a href="javascript:cfOp.chgOpArea('decoArch')">보관함</a></li--%>
				  <%--li><a href="javascript:cfOp.chgOpArea('rcmdDeco')">추천세트</a></li--%>
			    <%--/ul--%>
			  <%--/li--%>
		    </div>
		  </td>
		  <%--left menu end--%>
		  <td valign="top" class="padd_cons">
		    <div id="opArea" width=100% height=100% valign="top" style="border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px;">
			  <div>
			    오늘의 방문자수: <c:out value="${opForm.todayVisitCntCF}"/>
				<br>오늘의 가입자: <c:out value="${opForm.todayRegCntCF}"/>
				<br>오늘의 게시글: <c:out value="${opForm.todayBltnCntCF}"/>
			  </div>
			  <div>
			    <h3 title="카페 기본 정보">카페 기본 정보</h3>
			    <ul>
				  <li><span><label>카페 이름</label><span style="margin-left:10px"><c:out value="${cmntVO.cmntNm}"/></span></span></li>
				  <li><span><label><util:message key="mm.title.category"/><%--카테고리--%></label><span style="margin-left:10px"><c:out value="${cmntVO.cateIdNm}"/></span></span></li>
				  <li><span><label>검색어</label><span style="margin-left:10px">
				                                       <c:forEach items="${tagList}" var="tag" varStatus="status">
													     <c:if test="${!status.first}">|</c:if>
														 <c:out value="${tag.tag}"/>
													   </c:forEach>
											      </span>
			          </span>
				  </li>
			    </ul>
			  </div>
			</div>
		  </td>
	    </tr>
	  </table>
	</td>
  </tr>
  <tr>
	<td valign="top">[FOOTER]</td>
  </tr>
</table>
<div id="brdUserChooser" title="<util:message key="eb.title.userChooser"/>"></div>
<%--가입상태 변경 사유 관리 화면을 띄울 DIV--%>
<div id="stateCodeGetter" title="회원 상태 변경 관리"></div>
<form name=transferForm id=transferForm method=POST action= onsubmit="return false;">
  <input type=hidden id=m  name="m" />
  <input type=hidden id=cmntId  name=cmntId  value=<c:out value="${cmntVO.cmntId}"/>>
  <input type=hidden id=cmntUrl name=cmntUrl value=<c:out value="${cmntVO.cmntUrl}"/>>
  <input type=hidden id=langKnd name=langKnd value=<c:out value="${opForm.langKnd}"/>>
</form>
</body>

  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common_new.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portlet.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portal_new.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/utility.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validator.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/messageResource_<c:out value="${cmntVO.langKnd}"/>.js"></script>

  <link type="text/css" href="<%=request.getContextPath()%>/decorations/layout/css/jquery/base/jquery.ui.all.css" rel="stylesheet" />
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
  <!--script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/ui/i18n/jquery.ui.datepicker-<c:out value="${cmntVO.langKnd}"/>.js"></script-->
  <!--script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/ui/i18n/jquery.ui.datepicker-ko.js"></script-->
  
  <script type="text/javascript" src="<%=request.getContextPath()%>/board/calendar/calendar.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/board/calendar/ko-kr/generatecalendar.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_util.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/cafe_home.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/cafe_op.js"></script>
  
  <script type="text/javascript" src="<%=request.getContextPath()%>/board/fckeditor/fckeditor.js"></script>

  <script type="text/javascript">
	if (!portalPage) portalPage = new enview.portal.Page();
	portalPage.m_contextPath = ebUtil.getContextPath();
  </script>

</html>