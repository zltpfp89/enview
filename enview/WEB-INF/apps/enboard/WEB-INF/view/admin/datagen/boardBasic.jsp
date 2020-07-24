<%@ page contentType="text/json;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
{
"Status": "<util:json value="${abForm.status}"/>",
"Reason": "<util:json value="${abForm.reason}"/>",
"Data": 
  { 
	"boardId": "<util:json value="${boardVO.boardId}"/>",
	"domainId": "<util:json value="${boardVO.domainId}"/>",
	"boardActive": "<util:json value="${boardVO.boardActive}"/>",
	"boardNm": "<util:json value="${boardVO.boardNm}"/>",
	"boardTtl": "<util:json value="${boardVO.boardTtl}"/>",
	"updUserId": "<util:json value="${boardVO.updUserId}"/>",
	"updDatim": "<util:json value="${boardVO.updDatimSF}"/>"
  }
}
