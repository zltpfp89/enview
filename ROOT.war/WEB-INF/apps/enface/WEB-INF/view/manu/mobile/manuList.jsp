<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager" %>
<%@ page import="com.saltware.enview.Enview"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ taglib prefix="manu" uri="/WEB-INF/tld/manu.tld" %>
<%
	request.setAttribute("cPath", request.getContextPath());
	request.setAttribute( "isManuManager", (EnviewSSOManager.getUserInfo(request)).getHasRole("ROLE_MN_MANAGER"));
%>
<html lang="ko">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Content-Style-Type" content="text/css" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">
		<meta name="format-detection" content="telephone=no, address=no, email=no" />
		
		<title> 모바일 전자매뉴얼리스트 </title>
		
		<link rel="stylesheet" href="${cPath}/common/mobile/css/reset.css" /> 
		<link rel="stylesheet" href="${cPath}/common/mobile/css/common.css" /> 
		<link rel="stylesheet" href="${cPath}/common/mobile/css/layout.css" /> 
		<link rel="stylesheet" href="${cPath}/common/mobile/css/main.css" />
		<script type="text/javascript" src="${cPath }/common/js/jquery.js" ></script>
		<script type="text/javascript" src="${cPath}/common/mobile/js/main.js" ></script>
		
		<script type="text/javascript" src="${cPath}/common/js/common_new.js" ></script>
		
		<script type="text/javascript">
		cPageInfo = 1;
		
		function fn_search(){
	        fn_page();
	    }
	    // 페이지 조회
        function fn_page() {
           	$("#cPage").val("1");
            
            $("#manuList_searchForm").submit();
        }
		
	    // 상세 페이지 이동 
	    function fn_detailMove(tocId)
	    {
	    	var mdId = "${srhMdId}";
	    	$("#hiddenForm > #tocId").val(tocId);
	    	$("#hiddenForm > #mdId").val("${srhMdId}");
	    	$("#hiddenForm > #srhKey").val($("#nmList_searchKey").val());
	    	$("#hiddenForm > #page").val(cPageInfo);
	    	document.hiddenForm.submit();
	    }
	    
	    // 더 보기
		function fn_morePage(){
			cPageInfo = parseInt(cPageInfo)+parseInt(1);
			$("#cPage").val(cPageInfo);
			$.ajax({
				url : "${cPath}/manu/selectTocListAjax.manu",  
				data : $('#manuList_searchForm').serialize(), 
				dataType : "html",
				async: true,
				success: function(data, textStatus, jqXHR) {
					if(data.length == 0)
					{
						cPageInfo = parseInt(cPageInfo)-parseInt(1);
						alert("더 보기 할 데이터가 없습니다.");
					}
					else
					{
						$("#helpList").append(data);
					}
					parent.iframe_autoresize(parent.document.getElementsByTagName('iframe')[0]);
				}, 
				error: function(jqXHR, textStatus, errorThrows) {
					alert({"status":"ERROR", "msg":"처리중 오류가 발생하였습니다."});
				}
			});
	    }

		$(document).ready(function () {
			
			 try
	         {
	        	$(parent.window).scrollTop(0);
	         }
	         catch(e){
	        	 alert(e);
	         }
	         
			//2016.05.18 김승식 : 현재 페이지 정보 세팅
			if("${srhPage}" != null && "${srhPage}".length != 0 && "${srhPage}" != "undefined")
			{
				cPageInfo = "${srhPage}";	
			}
			//2016.05.18 김승식 : 조회조건 있을때 세팅 
			$("#manuList_manuId").val("${srhMdId}");
		
			$('fieldset input:text').keydown(function(key){ //검색 필드 엔터키 입력시 조회
                if(key.keyCode == '13') fn_search();
            });
			
			$("#searchBtn").click(function (e) {
				e.preventDefault();
			});
		});
		</script>
		<style type="text/css">
			.btn_darkorange{display:inline-block; height:; width:; background:#fa4f03; padding:0 10px; line-height:; color:#fff  !important; vertical-align:middle; cursor:pointer; font-size:12px;}
			.ui-state-active,
			.ui-widget-content .ui-state-active,
			.ui-widget-header .ui-state-active {
				border: 1px solid #aaaaaa;
				background:#C4DEFF;
				font-weight: 800;
				color: #212121;
			}
		</style>
 	</head>
	 <body>
	 	<form action="<c:url value='/manu/selectToc.manu'/>" method="post" name="hiddenForm" id="hiddenForm">
		 	<input type="hidden" name="tocId" id="tocId"/>
		 	<input type="hidden" name="mdId" id="mdId"/>
		 	<input type="hidden" name="srhKey" id="srhKey"/>
		 	<input type="hidden" name="page" id="page"/>
		 </form>
	 
	 	<form name="searchForm" id="manuList_searchForm" action="/manu/selectTocList.manu" method="post">
		<input type="hidden" id="cPage" name="cPage"/>  
		<div id="sub_container" style="padding-top: 0px;">
		
<!-- 			<h2 class="sub_title"> -->
<!-- 				전자매뉴얼 -->
<!-- 			</h2> -->
	
<!-- 			<section class="board_top tm10"> -->
			<section class="board_top" style="margin: 10px;">
				<div class="board_btn_L w_p30">
<!-- 				<div class="board_search_wrap"> -->
				
					<select name="mdId" id="manuList_manuId" class="w_p100" style="font-size: 1em;">
						<option value="">전체</option>
                        <c:forEach items="${mdList}" var="md"> 
							<option value="${md.mdId}"><c:out value="${md.mdNm}"/></option>  
						</c:forEach>
					</select>
				</div>
			 
				<fieldset class="board_search_form">
					<legend>게시물 검색</legend>
					<div>
						<label class="hide" for="nmList_searchKey">검색어</label><input type="text" name="searchKey" id="nmList_searchKey" placeholder="모듈명을 입력해주세요." value="<c:out value="${srhKey}"/>"/>
						<input type="submit" id="manuList_searchButton" onclick="fn_search();" value="검색" />
					</div>
				</fieldset>
			</section>
	
			<table class="board_basic_list" summary="전자매뉴얼 목록">
				<caption>전자매뉴얼</caption>
				<tbody id="helpList">
					<c:if test="${empty list}">
                    	<tr class="" id="row_${status.index}" >
                    		<td class="" style="text-align: center;">조회 된 데이터가 없습니다.</td>
                    	</tr>
                    </c:if>
					<c:forEach var="list" items="${list}" varStatus="status">
					<tr onclick="javascript:fn_detailMove('${list.tocId}');">
						<td style="width: 70px;text-align: left;">
							<span><c:out value="${list.mdNm}" /></span>
						</td>
						<td class="left">
							<div class="subject text-overflow" style="padding-right: 8px;padding-top: 9px;">
                                <strong><c:out value="${list.subj}"/></strong><br />
							</div>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			<section class="board_top" id="moreSection">
				<div class="board_btn">
					<a href="javascript:void(0);" id="moreBtn" class="w_p100" onclick="javascript: fn_morePage();">더 보기</a>
				</div>
			</section>
		</div>
		</form>
	</body>
</html>