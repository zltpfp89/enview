<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.saltware.enview.multiresource.EnviewMultiResourceManager" %>
<%@ page import="com.saltware.enview.multiresource.MultiResourceBundle" %>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager" %> 
<%@ page import="java.util.*" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>배너 리스트</title>
	<link href="<%=request.getContextPath()%>/hancer/css/banner/core_banner_bg.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/hancer/css/banner/core_popup.css" rel="stylesheet" type="text/css" />
<%
	String contextname = request.getContextPath();
%>
</head>
<div class="popup_wrap">
	<div class="header">
		<h1>Banner</h1>
		<span class="btn_close"><a href="javascript: window.close()"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/popup/btn_close.gif" alt="닫기" /></a></span>
	</div>
	<div class="content">
   <!-- <p class="h1dis"><span class="hitcol">등록된 <a href="#" >Banner 입니다.</a></span></p> -->
		<table class="tabletype3" id="table" border="0" cellspacing="0" summary="등록된 배너 입니다.">
		<caption>Banner</caption>
		<colgroup>
		<col width="33%" />
		<col width="33%" />
		<col width="*" />
		</colgroup>
		<tbody>
			<c:forEach items="${bannerList}" var="item" varStatus="status">
			<c:if test="${status.index%3==0}">
			<tr>
			</c:if>
				<td>
					<c:if test = "${item.bannerImagePath != null}">
					<a href="<c:out value ="${item.bannerLink}" escapeXml="false"/>" target="_blank" title="<c:out value ="${item.bannerTitle}" escapeXml="false"/>" style=" text-decoration:none;cursor:pointer;">
					<!--div style="width:250px; height:105px;padding:0;margin:0;background:url('<%=request.getContextPath()%><c:out value ="${item.bannerImagePath}" escapeXml="false"/>') no-repeat;" ></div-->
					<img src='<%=request.getContextPath()%><c:out value ="${item.bannerImagePath}" escapeXml="false"/>' class="type00"/>
					</a>
					</c:if>
					<c:if test = "${item.bannerImagePath == null}">
					<a href="<c:out value ="${item.bannerLink}" escapeXml="false"/>" target="_blank" title="<c:out value ="${item.bannerTitle}" escapeXml="false"/>" style=" text-decoration:none;cursor:pointer;"><c:out value ="${item.bannerSrc}" escapeXml="false"/></a>
					</c:if>
				</td>
			<c:if test="${status.index%3==2}">
			</tr>
			</c:if>                            
			</c:forEach>
			<c:if test="${empty bannerList}">
			<tr>
				<td>
					등록된 배너목록이 없습니다.
				</td>
			</tr>
			</c:if>
			</tbody>
			</table>
		</div>				
	</div>
</div>
<!-- contentsIn 끝 --> 
<!-- body_s_full 끝 -->
</body>
</html>