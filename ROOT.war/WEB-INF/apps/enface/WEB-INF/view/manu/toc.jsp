<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ taglib prefix="manu" uri="/WEB-INF/tld/manu.tld" %>

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<title>:: 수사 분야/유형별 샘플 ::</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<%--@include file="/common/common/commonScriptInclude.jsp"  --%>	
<link rel="stylesheet" type="text/css" href="${cPath }/common/css/reset.css" />
<link rel="stylesheet" type="text/css" href="${cPath }/common/css/common.css" />
<link rel="stylesheet" type="text/css" href="${cPath }/common/css/layout.css" />
<link rel="stylesheet" type="text/css" href="${cPath }/common/css/main.css" />
<link rel="stylesheet" type="text/css" href="${cPath }/common/css/sub.css" />
<link rel="stylesheet" type="text/css" href="${cPath }/common/css/calendar.css" />
<link rel="stylesheet" type="text/css" href="${cPath }/common/css/jquery.gridster.css" />
<link rel="stylesheet" type="text/css" href="${cPath }/common/css/manu_custom.css" />
<link rel='stylesheet' type='text/css' href="${cPath }/common/css/jquery-ui-custom.css"/>

<script type="text/javascript" src="${cPath }/common/js/jquery.js" ></script>
<script type="text/javascript" src="${cPath }/common/js/slider.js"></script>
<script type="text/javascript" src="${cPath }/common/js/calendar.js"></script>
<script type="text/javascript" src="${cPath }/common/js/jquery.PrintArea.js" ></script>
<script type="text/javascript" src="${cPath }/common/js/MessengerControl.js" ></script>
	
	
	<link rel='stylesheet' type='text/css' href="${pageContext.request.contextPath}/common/css/manucalendar.css"/>
	<link rel='stylesheet' type='text/css' href="${pageContext.request.contextPath}/common/css/manucalendar.print.css" media='print'/>
	<link rel='stylesheet' type='text/css' href="${pageContext.request.contextPath}/common/css/jquery-ui-custom.css"/>
		
	<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery.serializeObject.js"></script>
	
	<%-- 자원예약용 --%>
	<script type="text/javascript" src="${cPath }/common/js/resource.js"></script>
	

	<script type="text/javascript" src="${cPath}/javascript/jstree/jstree.js"></script>
	<link rel="stylesheet" href="${cPath}/javascript/jstree/themes/default/style.min.css" />

	<script type="text/javascript" >

	$(document).ready(function(){
		searchTocTree();
		//2016.05.20 김승식 : DOM Ready 시, 스크롤 top 
		try
		{
			parent.parent.document.documentElement.scrollTop = 0;
		}
		catch(e)
		{}
		//2016.05.20 김승식 : DOM ready 시 iframe resize
		try
		{
			var doc = parseInt($("#bodyContents").height()) + 150;
			if(parseInt(doc) < parseInt("700"))
			{
				doc = "700";
			}
			doc = "610";
			/*
			parent.document.getElementById(window.name).style.height = parseInt(doc)+"px";	
			parent.parent.document.getElementById(parent.window.name).style.height = parseInt(doc)+"px";	
			*/
			parent.document.getElementById(window.name).style.height = parseInt(doc)+"px";
			parent.parent.iframe_setHeightResize(parent.window.name,parseInt(doc));
			
			
		}
		catch(e)
		{}
	});
	
	function searchTocTree() {
		var formData = {};
		var url = '/manu/selectTocTree.face';
		$.ajax( {
			url : url,
			type : "post",
			data : formData,
			success : function( data) {
				//alert( JSON.stringify( data));
				$("#jstree").jstree({ 
					'core' : {
				    	'data' : data
					}
				});
				$('#jstree').on("select_node.jstree", function (e, data) { 
					alert(JSON.stringify( data.node)); 
					alert(data.node.original.lev); 
				});				
				
			},
			error : function ( xhr, status, error) {
				alert('데이터 전송오류 ' + status + ", " + error );
			}
			
		});	
	}
 	</script>
</head>

<body class="" id="bodyContents">
	<div class="">
		<table class="work_step">
			<colgroup>
				<col style="width:100%;" />
			</colgroup>
			
			<thead>
<!-- 				<tr>
					<th class="step2"><a href="#"><span class="icon_work_step2"></span>샘플 제목</a></th>
				</tr> -->
			</thead>
			<tbody>
				<tr>
<%-- 					<td class="left">
						<c:if test="${empty toc.bfList}">
							<p>조회된 업무가 없습니다.</p>  
						</c:if>
						
						<c:forEach items="${toc.bfList}" var="bf">
						<p><a href="/manu/selectToc.face?tocId=${bf.tocId}">[<c:out value="${bf.mdNm}"/>] <c:out value="${bf.SUBJ}"/></a></p>  
						</c:forEach>
					</td> --%>
					<td>
						<p style='text-align:left;font-size:16pt;vertical-align:middle;margin-top:5px  '><strong><c:out value="${toc.subj}"/></strong></p>
					</td>
<%-- 					<td class="left">
						<c:if test="${empty toc.afList}">
							<p>조회된 업무가 없습니다.</p>  
						</c:if>
						<c:forEach items="${toc.afList}" var="af">
						<p><a href="/manu/selectToc.face?tocId=${af.tocId}">[<c:out value="${af.mdNm}"/>] <c:out value="${af.SUBJ}"/></a></p>  
						</c:forEach>
					</td> --%>
				</tr>
			</tbody>
		</table>

		<table class="basic_table_view" summary="도움말 상세페이지">
			<caption>도움말 상세페이지</caption>
			<colgroup>
				<col style="width:120px" />
				<col style="width:auto" />
			</colgroup>
			<tbody>
				<c:if test="${not empty toc.cmdList }">
				<tr>
					<th class="first">관련명령</th>
					<td >
						<c:forEach items="${toc.cmdList}" var="cmd" varStatus="index">
						${index.first ? '' : ','}
						<c:out value="${cmd.tCd}"/>  
						</c:forEach>
					</td>
				</tr>
				</c:if>
				<c:if test="${not empty toc.fileList }">
				<tr>
					<th class="first">첨부파일</th>
					<td >
					<c:forEach items="${toc.fileList}" var="file" varStatus="fileStatus">
					<c:if test="${not fileStatus.first}"><br/></c:if>
					<a href="${pageContext.request.contextPath}/sjpb/Z/AddOnDownload.face?fileId=${file.fileId}" target="invisible"><img src="${pageContext.request.contextPath}/common/images/icon_file.png" alt="첨부파일" />
					<c:out value="${file.fileNm}"/> ( <c:out value="${file.sizeSF}"/> ) 
					</a>
					</c:forEach>
					</td>
				</tr>
				</c:if>
				<tr>
					<td colspan="2">
						${toc.contents}
					</td>
				</tr>
			</tbody>
		</table>
	</div>		
	<iframe name='invisible' frameborder="0" width="0" height="0"></iframe>
</body>
</html>
