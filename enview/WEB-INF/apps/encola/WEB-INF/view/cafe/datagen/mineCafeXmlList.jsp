<%@ page contentType="text/xml;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--BEGIN::내가 가입한 카페--%>
<c:if test="${homeForm.initView == 'mine.all'}">
  <c:if test="${empty myAllList}">
    <cafeList></cafeList>
  </c:if>
  <c:if test="${!empty myAllList}">
    <cafeList>
      <c:forEach items="${myAllList}" var="myAll">
        <cafe cmntId="<c:out value="${myAll.cmntVO.cmntId}"/>" cmntUrl="<c:out value="${myAll.cmntVO.cmntUrl}"/>" openYn="<c:out value="${myAll.cmntVO.openYn}"/>" regType="<c:out value="${myAll.cmntVO.regType}"/>" cmntLevel="<c:out value="${myAll.cmntVO.cmntLevel}"/>">
	      <cmntNm><c:out value="${myAll.cmntVO.cmntNm}" escapeXml="false"/></cmntNm>
	      <cmntIntro><c:out value="${myAll.cmntVO.cmntIntro}" escapeXml="false"/></cmntIntro>
	      <cmntWelcome><c:out value="${myAll.cmntVO.cmntWelcome}" escapeXml="false"/></cmntWelcome>
	    </cafe>
      </c:forEach>
    </cafeList>
  </c:if>
</c:if>
<%--END::내가 가입한 카페--%>
<%--BEGIN::내가 가입 신청한 카페--%>
<c:if test="${homeForm.initView == 'mine.wait'}">
  <c:if test="${empty myAllWaitList}">
    <cafeList></cafeList>
  </c:if>
  <c:if test="${!empty myAllWaitList}">
    <cafeList>
      <c:forEach items="${myAllWaitList}" var="myAll">
        <cafe cmntId="<c:out value="${myAll.cmntVO.cmntId}"/>" cmntUrl="<c:out value="${myAll.cmntVO.cmntUrl}"/>" openYn="<c:out value="${myAll.cmntVO.openYn}"/>" regType="<c:out value="${myAll.cmntVO.regType}"/>" cmntLevel="<c:out value="${myAll.cmntVO.cmntLevel}"/>">
	      <cmntNm><c:out value="${myAll.cmntVO.cmntNm}" escapeXml="false"/></cmntNm>
	      <cmntIntro><c:out value="${myAll.cmntVO.cmntIntro}" escapeXml="false"/></cmntIntro>
	      <cmntWelcome><c:out value="${myAll.cmntVO.cmntWelcome}" escapeXml="false"/></cmntWelcome>
	    </cafe>
      </c:forEach>
    </cafeList>
  </c:if>
</c:if>
<%--END::내가 가입 신청한 카페--%>
<%--BEGIN::자주가는 카페--%>
<c:if test="${homeForm.initView == 'mine.favor'}">
  <c:if test="${empty favorList}">
    <cafeList></cafeList>
  </c:if>
  <c:if test="${!empty favorList}">
    <cafeList>
      <c:forEach items="${favorList}" var="favor">
        <cafe cmntId="<c:out value="${favor.cmntVO.cmntId}"/>" cmntUrl="<c:out value="${favor.cmntVO.cmntUrl}"/>" openYn="<c:out value="${favor.cmntVO.openYn}"/>" regType="<c:out value="${favor.cmntVO.regType}"/>" cmntLevel="<c:out value="${favor.cmntVO.cmntLevel}"/>">
	      <cmntNm><c:out value="${favor.cmntVO.cmntNm}" escapeXml="false"/></cmntNm>
	      <cmntIntro><c:out value="${favor.cmntVO.cmntIntro}" escapeXml="false"/></cmntIntro>
	      <cmntWelcome><c:out value="${favor.cmntVO.cmntWelcome}" escapeXml="false"/></cmntWelcome>
	    </cafe>
      </c:forEach>
	</cafeList>
  </c:if>
</c:if>
<%--END::자주가는 카페--%>