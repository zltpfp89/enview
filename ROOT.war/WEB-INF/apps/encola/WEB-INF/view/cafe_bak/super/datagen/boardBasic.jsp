<%@ page contentType="text/json;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
{
"Status": "<c:out value="${abForm.status}"/>",
"Reason": "<c:out value="${abForm.reason}"/>",
"Data": 
  { 
	"boardId": "<c:out value="${boardVO.boardId}"/>",
	"boardActive": "<c:out value="${boardVO.boardActive}"/>",
	"boardNm": "<c:out value="${boardVO.boardNm}"/>",
	"boardDesc": "<c:out value="${boardVO.boardDesc}"/>",
	"updUserId": "<c:out value="${boardVO.updUserId}"/>",
	"updDatim": "<c:out value="${boardVO.updDatimSF}"/>"
  }
}
