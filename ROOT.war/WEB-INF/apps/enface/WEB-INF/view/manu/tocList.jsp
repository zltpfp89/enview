<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="manu" uri="/WEB-INF/tld/manu.tld" %>
<%
    request.setAttribute("cPath", request.getContextPath());
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>:: 전자매뉴얼 ::</title>
    
    <%-- 공통 스크립트 --%>
    <%@ include file="/common/common/commonScriptInclude.jsp"  %>
    <%-- 공통 스크립트 --%>
    
    <script type="text/javascript">
	    function fn_search(){
	        fn_page();
	    }
	    // 페이지 조회
        function fn_page(page) {
            if(page == undefined) page = 1;
            $('#frm').attr({action:'/manu/selectTocList.face?cPage='+page}).submit();
        }
	    
        $(document).ready(function(){
            // list count 변경 이벤트
            $('select[name*="listCnt"]').change(function(event){
                $('select[name*="listCnt"]').val(this.value);
                $('#listCnt').val(this.value);
                fn_search();
            });

    		//2016.05.20 김승식 : DOM ready 시 iframe resize
    		try
    		{
    			var doc = parseInt($("#bodyContents").height()) + 150;
    			if(parseInt(doc) < parseInt("700"))
    			{
    				doc = "700";
    			}
    			parent.document.getElementById(window.name).style.height = parseInt(doc)+"px";	
    			parent.parent.document.getElementById(parent.window.name).style.height = parseInt(doc)+"px";	
				$(parent.window).scrollTop(0);
    		}
    		catch(e)
    		{}
        });
    </script>
</head>
<body id="bodyContents">
    <div class="sub_container" style="min-width: 700px;">
        <!-- content start -->
        <form name="frm" id="frm" method="post" >
        <input type="hidden" name="searchKey" value="<c:out value="${param.searchKey}" escapeXml="false"/>"/>
        <div id="content">
            <h4>목차목록</h4>
            
            <div class="board_top">
                <div class="board_total board_btn_L">
                    총 <strong>${page.total }</strong>건 <strong>(${page.currentPage }/${page.pages })</strong>
                    <select  id="listCntTop" name="listCntTop">
                        <option value="10" <c:if test="${param.listCnt eq 10}"> selected="selected" </c:if>>10개</option>
                        <option value="20" <c:if test="${param.listCnt eq 20}"> selected="selected" </c:if>>20개</option>
                        <option value="50" <c:if test="${param.listCnt eq 50}"> selected="selected" </c:if>>50개</option>
                    </select>
                </div>
                <div class="board_btn_R">
                </div>
                </div>
                <!-- 목록 -->
                <table class="basic_table" summary="">
                    <caption>보고자</caption>
                    <colgroup>
                        <col width="100px;" />
                        <col width="150px" />
                        <col width="*" />
<%--                         <col width="100px" /> --%>
                    </colgroup>
                    <thead>
                        <tr>
                            <th>모듈ID</th>
                            <th>모듈명</th>
                            <th class="last">제목</th>
<!--                             <th class="last">조회수</th> -->
                        </tr>
                    </thead>
                    <tbody>
                    <c:if test="${empty list}">
                    	<tr class="" id="row_${status.index}" >
                    		<td class="" colspan="3" style="text-align: center;">조회 된 데이터가 없습니다.</td>
                    	</tr>
                    </c:if>
                    <c:forEach var="list" items="${list}" varStatus="status">
                     <tr class="" id="row_${status.index}" >
                        <td class=""><c:out value="${list.mdId}"/></td>
                        <td ><c:out value="${list.mdNm}"/></td>
                        <td class="left"><a href="/manu/selectToc.face?tocId=${list.tocId}"><c:out value="${list.subj}"/></a></td>
<!--                         <td class=""> -->
<%--                             <fmt:formatNumber value="${list.readCnt}" pattern="#,##0"/> --%>
<!--                         </td> -->
                    </tr>
                    </c:forEach>
                    </tbody>
                </table>
             <div class="board_bottom">
                <div class="board_total board_btn_L">
                    총 <strong>${page.total }</strong>건 <strong>(${page.currentPage }/${page.pages })</strong>
                   <select  id="listCntBot" name="listCntBot">
		                <option value="10" <c:if test="${param.listCnt eq 10}"> selected="selected" </c:if>>10개</option>
                        <option value="20" <c:if test="${param.listCnt eq 20}"> selected="selected" </c:if>>20개</option>
                        <option value="50" <c:if test="${param.listCnt eq 50}"> selected="selected" </c:if>>50개</option>
                    </select>
                </div>
                <div class="board_btn_R">
                </div>
            </div>
    
            <div class="board_page">
                <div class="paging_c">
                    <c:choose>
                        <c:when test="${page.currentPage == 1 }">
                            <a href="#allpre" class="page_first">처음</a>
                        </c:when>
                        <c:otherwise>
                            <a href="#allpre" class=page_first onclick="fn_page(1);">처음</a>
                        </c:otherwise>
                    </c:choose>
                    
                    <c:choose>
                        <c:when test="${page.currentBeforePage == 1 }">
                            <a href="#pre" class="page_prev">&lt;</a>
                        </c:when>
                        <c:otherwise>
                            <a href="#pre" class="page_prev" onclick="fn_page(${page.currentBeforePage});">&lt;</a>
                        </c:otherwise>
                    </c:choose>
                    
                    <c:if test="${empty list}">
                        <a href="#num">1</a>
                    </c:if>
            
                    <c:if test="${!empty list}">
                        <c:forEach begin="${page.currentStartPage }" end="${page.currentEndPage }" var="i">
                            <c:if test="${page.currentPage != i }"> <!-- 현재 페이지 x -->
                                <a href="#num" onclick="fn_page('<c:out value="${i}" escapeXml="true"/>');">${i }</a>
                            </c:if>
                            <c:if test="${page.currentPage == i }"> <!-- 현재 페이지 o -->
                                <!-- <a href="#num" class="pg_on">${i }</a> -->
                                <a href="#num" ><strong>${i}</strong></a>
                            </c:if>
                        </c:forEach>
                    </c:if>
                    <c:choose>
                        <c:when test="${(page.currentNextPage == page.pages && page.pages%page.pageCount != 1) || (page.pages == 1)}">
                            <a href="#next" class="page_next">&gt;</a>
                        </c:when>
                        <c:otherwise>
                            <a href="#next" class="page_next" onclick="fn_page(<c:out value="${page.currentNextPage}" escapeXml="true"/>);">&gt;</a>
                        </c:otherwise>
                    </c:choose>
            
                    <c:choose>
                        <c:when test="${page.currentPage == page.pages}">
                            <a href="#all_next" class="page_last">마지막</a>
                        </c:when>
                        <c:otherwise>
                            <a href="#all_next" class="page_last" onclick="fn_page(<c:out value="${page.pages}" escapeXml="true"/>);">마지막</a>
                        </c:otherwise>
                    </c:choose>
                </div>    
            </div>
        </div>
        </form>
        <!-- //content end -->
    </div>
</body>
</html>

        