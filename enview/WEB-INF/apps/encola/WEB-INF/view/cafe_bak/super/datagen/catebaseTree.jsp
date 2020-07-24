<%@ page contentType="text/xml;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${acForm.act == 'root'}">
<tree id="0">
	<%--'item' �±��� 'call' �Ӽ��� ������ �Ǹ� �� ��尡 �ε�Ǿ��� �� onClickHandler�� ȣ�����ش�.--%>
	<item id="<c:out value="${catebaseVO.cateId}"/>" im0="_folder.gif" im1="_folder_open.gif" im2="folder.gif" open="1" call="1" select="1"><![CDATA[ <c:out value="${catebaseVO.cateNm}"/> ]]>
</c:if>
<c:if test="${acForm.act != 'root'}">
<tree id="<c:out value="${acForm.cateId}"/>">
</c:if>
<c:forEach items="${cateList}" var="cate">
	<c:if test="${cate.childCnt > 0}">
		<item child="1" id="<c:out value="${cate.cateId}"/>" hint="<c:out value="${cate.cateNm}"/>" im0="folder.gif" im1="folder_open.gif" im2="folder.gif"><![CDATA[ <c:out value="${cate.cateNm}"/> ]]></item>
	</c:if>
	<c:if test="${cate.childCnt == 0}">
		<item child="0" id="<c:out value="${cate.cateId}"/>" hint="<c:out value="${cate.cateNm}"/>" im0="page.gif" im1="page.gif" im2="page.gif"><![CDATA[ <c:out value="${cate.cateNm}"/> ]]></item>
	</c:if>
</c:forEach>
<c:if test="${acForm.act == 'root'}">
	</item>
</c:if>
</tree>