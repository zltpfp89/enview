<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- <%@ taglib prefix="manu" uri="/WEB-INF/tld/manu.tld" %> --%>
<%-- <% 
     request.setAttribute("cPath", request.getContextPath());
 %> --%>

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
        $(document).ready(function(){
        	//2016.05.20 김승식 : DOM ready 시 iframe resize
			try
			{
				var doc = parseInt($("#content").height()) + 250;
	 			if(parseInt(doc) < parseInt("640"))
	 			{
	 				doc = 640;
	 			}
				parent.document.getElementById(window.name).style.height = parseInt(doc)+"px";	
				parent.parent.document.getElementById(parent.window.name).style.height = parseInt(doc)+"px";
				$(parent.parent.window).scrollTop(0);
			}
			catch(e)
			{}
        });
        
		function fn_add() {
			location.href ="${cPath}/manu/admin/selectToc.face?mdId=<c:out value="${param.mdId}" />&upTocId=<c:out value="${param.upTocId}" />"
		}
		
		
        
    </script>
</head>
<body>
        <!-- content start -->
        <form name="frm" id="frm" method="post" >
        <input type="hidden" name="upTocId" value="<c:out value="${param.upTocId}" />"/>
        
        <div id="content">
            <h4>목차목록</h4>
            
            <div class="board_top">
                <div class="board_total board_btn_L">
                </div>
                <div class="board_btn_R">
					<a href="javascript:fn_add();" class="btn_black" title="등록">등록</a>
                </div>
                </div>
                <!-- 목록 -->
                <table class="basic_table" summary="">
                    <caption>보고자</caption>
                    <colgroup>
                        <col width="*" />
                    </colgroup>
                    <thead>
                        <tr>
                            <th class="last">목차</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:if test="${empty list}">
                    	<tr class="" id="row_${status.index}" >
                    		<td class="" style="text-align: center;">조회 된 데이터가 없습니다.</td>
                    	</tr>
                    </c:if>
                    <c:forEach var="list" items="${list}" varStatus="status">
                     <tr class="" id="row_${status.index}" >
                        <td class="left"><a href="${cPath}/manu/admin/selectToc.face?tocId=${list.tocId}"><c:out value="${list.subj}"/></a></td>
                    </tr>
                    </c:forEach>
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
        </form>
        <!-- //content end -->
</body>
</html>

        