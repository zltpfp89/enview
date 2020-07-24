<%@ page contentType="text/xml;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${acForm.act == 'root'}">
<tree id="0">
	<%--'item' �±��� 'call' �Ӽ��� ������ �Ǹ� �� ��尡 �ε�Ǿ��� �� onClickHandler�� ȣ�����ش�.--%>
	<item id="<c:out value="${catebaseVO.cateId}"/>" open="1" call="1" select="1" text="<c:out value="${catebaseVO.cateNm}"/>"><userdata name="domainId"><c:out value="${catebaseVO.domainId}"/></userdata>
</c:if>
<c:if test="${acForm.act != 'root'}">
<tree id="<c:out value="${acForm.cateId}"/>">
</c:if>
<c:forEach items="${cateList}" var="cate">
	<c:if test="${cate.childCnt > 0}">
		<item child="1" id="<c:out value="${cate.cateId}"/>" hint="<c:out value="${cate.cateNm}"/>" text="<c:out value="${cate.cateNm}"/>"><userdata name="domainId"><c:out value="${cate.domainId}"/></userdata></item>
	</c:if>
	<c:if test="${cate.childCnt == 0}">
		<item child="0" id="<c:out value="${cate.cateId}"/>" hint="<c:out value="${cate.cateNm}"/>" text="<c:out value="${cate.cateNm}"/>"><userdata name="domainId"><c:out value="${cate.domainId}"/></userdata></item>
	</c:if>
</c:forEach>
<c:if test="${acForm.act == 'root'}">
	</item>
</c:if>
</tree>
