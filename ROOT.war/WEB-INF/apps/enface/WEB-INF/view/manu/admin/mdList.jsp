<%@page import="com.saltware.enface.util.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ taglib prefix="manu" uri="/WEB-INF/tld/manu.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	
	<title>:: 전자매뉴얼 ::</title>
	
	<%@ include file="/common/common/commonScriptInclude.jsp"  %>
	
	<script type="text/javascript">
		$(document).ready(function () {
			//2016.05.20 김승식 : DOM Ready 시, 스크롤 top 
			try
			{
				parent.document.documentElement.scrollTop = 0;
			}
			catch(e)
			{}
			//2016.05.20 김승식 : DOM ready 시 iframe resize
			try
			{
				var doc = parseInt($("#sub_container").height()) + 50;
				parent.document.getElementById(window.name).style.height = parseInt(doc)+"px";	
			}
			catch(e)
			{}
		});
		
		function fn_search() {
			$("#searchForm").submit();	
		}
		

		function fn_add() {
			$("#searchForm").attr("action", "${cPath }/manu/admin/selectMd.face")
			$("#searchForm").submit();
			$("#searchForm").attr("action", "${cPath }/manu/admin/selectMdList.face")
		}
		
		function fn_detail(id) {
			$("#mdList_mdId").val(id);
			$("#searchForm").attr("action", "${cPath }/manu/admin/selectMd.face")
			$("#searchForm").submit();
			$("#searchForm").attr("action", "${cPath }/manu/admin/selectMdList.face")
		}
		
		function fn_manu(id) {
			$("#mdList_mdId").val(id);
			$("#searchForm").attr("action", "${cPath }/manu/admin/selectManu.face")
			$("#searchForm").submit();
			$("#searchForm").attr("action", "${cPath }/manu/admin/selectMdList.face")
		}
		
	</script>
</head>

<body>
	<div class="sub_container" id="sub_container">
		<!-- content start -->
		<div id="content">
			<h4>도움말 모듈관리</h4>
			
<!-- 			<div class="board_search"> -->
				<form id="searchForm" name="searchForm"  action="${cPath }/md/selectMdList.face" method="post" >
				<input type="hidden" id= "mdList_mdId" name="mdId" />
				</form>
<!-- 			</div> -->

			<div class="board_top ">
				<div class="board_total board_btn_L">
				</div>

				<div class="board_btn_R">
					<a href="javascript:fn_add();" class="btn_black" title="등록">등록</a>
				</div>
			</div>
			<table class="basic_table " summary="">
				<caption>목록테이블</caption>
				<colgroup>
					<col style="width:150px" />
					<col style="width:auto" />
					<col style="width:120px" />
					<col style="width:110px" />
				</colgroup>
				<thead>
					<tr>
						<th>모듈ID(모듈관리)</th>
						<th>모듈명칭(매뉴얼목차관리)</th>
						<th>수정자</th>
						<th class="last">수정일자</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty list }">
					<tr>
						<td colspan="4">조회된 모듈이 없습니다.</td>
					</tr>
					</c:if>
					<c:if test="${!empty list }">
					<c:forEach items="${list }" var="md" varStatus="status">
					<tr class="">
						<td class=""><a href="javascript:fn_detail('${md.mdId}')"><c:out value="${md.mdId}" /></a></td>
						<td class="left"><a href="javascript:fn_manu('${md.mdId}')"><c:out value="${md.mdNm}" /></a></td>
						<td class="">
							<span class="icon_user"></span>
							<c:out value="${md.udtUsrNm}" />										
						</td>
						<td class="">
							<manu:formatDate value="${md.udtDt}" format="auto"/>
						</td>
					</tr>
					</c:forEach>
					</c:if>
				</tbody>
			</table>
			<div class="board_bottom">
				<div class="board_total board_btn_L">
				</div>

				<div class="board_btn_R">
					<a href="javascript:fn_add();" class="btn_black" title="등록">등록</a>
				</div>
			</div>
		</div>
		<!-- //content end -->
	</div>
</body>
</html>