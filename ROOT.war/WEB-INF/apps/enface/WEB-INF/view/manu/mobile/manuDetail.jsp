<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="manu" uri="/WEB-INF/tld/manu.tld" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>:: 모바일 전자매뉴얼 ::</title>
    
    <link rel="stylesheet" href="${cPath}/common/mobile/css/reset.css" /> 
	<link rel="stylesheet" href="${cPath}/common/mobile/css/common.css" /> 
	<link rel="stylesheet" href="${cPath}/common/mobile/css/layout.css" /> 
	<link rel="stylesheet" href="${cPath}/common/mobile/css/main.css" />
   	<%-- 공통 스크립트 --%>
    <%@ include file="/common/common/commonScriptInclude.jsp"  %>
    <%-- 공통 스크립트 --%>
    
    <style type="text/css">
    	
    	/* Google 상세보기 CSS */
    	.common_a{
    		padding-top: 20px;
    		border-bottom:  1px solid rgba(0,0,0,0.12);
    	}
    	
    	.common_b{
    		background-color: white;
    	}
    	
    	.common_c{
    		position: relative;
    	}
    	
    	.common_d{
    		padding: 0px 0px 16px 0px;
    	}
    	
    	.common_subject{
    		border: 0;
		    color: #181818;
		    font-size: 17px;
		    font-weight: normal;
		    margin: 0;
		    padding: 0;
    	}
    	
    	.common_content{
    		color: #737373;
    		font-size: 15px;
    	}
    	
    	.common_content_none{
    		color: #737373;
    		font-size: 15px;
    		margin-top: 2.5px;
    	}
    	
    	.common_content_a{
    		overflow: hidden;
		    text-overflow: ellipsis;
		    white-space: nowrap;
		    word-wrap: normal;
    	}
    	
    	.common_cell{
    		display: table-cell;
    	}
    	
    	.common_text{
    		font-size: 15px;
    		color:#737373;
    		padding:0px !important;
    		height:22px !important;
    	}
    	
    	.common_textArea{
    		font-size: 15px;
    		color:#737373;
    		padding:0px !important;
    		width: 100%;
		    min-height: 100px;
		    resize: none;
    	}
    	
    	.common_img{
    		margin-top: 15px;
    	}
    	
    	.common_href{
    		width: 23%;
    	}
    </style>
    
    <script type="text/javascript" src="${cPath}/javascript/jquery/jquery.blockUI.js"></script>
    <script type="text/javascript" src="${cPath}/common/js/common_fileUpload.js"></script>
    <script type="text/javascript">
    <!--
    window.onload = commonFile.edit_init;
    //-->
    //DOM Ready 시
    $(document).ready(function()
    {
		 try
         {
        	$(parent.window).scrollTop(0);
         }
         catch(e){
        	 alert(e);
         }
         
    	//2016.05.20 김승식 : 본문영역에 있는 이미지 리사이즈 
    	$("#detailTdArea > p > img").css({width:"100%",height:"100%"});
    	
   		// 2016-05-16 ksyoo iframe auto resize
        setTimeout(function(){parent.iframe_autoresize(parent.document.getElementsByTagName('iframe')[0]);}, 1000)
    });
	
    //2016.05.19 김승식 : 모바일 전자매뉴얼 리스트로 이동 
    function fn_moveList()
    {
    	document.hiddenForm.submit();
    }
    </script>
</head>
<body>
	 <form action="<c:url value='/manu/selectManuList.manu'/>" method="post" name="hiddenForm" id="hiddenForm">
	 	<input type="hidden" name="srhMdId" value="<c:out value="${srhMdId}"/>"/>
	 	<input type="hidden" name="srhKey" value="<c:out value="${srhKey}"/>"/>
	 	<input type="hidden" name="srhPage" value="<c:out value="${srhPage}"/>"/>
	 </form>
	 
	 <div style="display: block;">
        <!-- Google 상세보기 시작 -->
        <div class="layer_popup_white" style="padding: 0px 20px 20px 20px">
           	<div class="common_a">
           		<div class="common_b">
           			<div class="common_c">
           				<div class="common_d">
           					<div>
           						<div>
           							<h5 class="common_subject"> 
           								현행업무
           							</h5>
           						</div>
								<div class="common_content_none">
           							<div class="common_content_a">
<%--            								<p style='text-align:left;font-size:12pt;vertical-align:middle;margin-top:5px'><strong><c:out value="${toc.subj}"/></strong></p> --%>
           								<p><c:out value="${toc.subj}"/></p>
           							</div>
           						</div>
           					</div>
           				</div>	
           			</div>
           		</div>
           	</div>
           	
           	<c:if test="${not empty toc.bfList}">
           		<div class="common_a">
	           		<div class="common_b">
	           			<div class="common_c">
	           				<div class="common_d">
	           					<div>
	           						<div>
	           							<h5 class="common_subject"> 
	           								선행업무
	           							</h5>
	           						</div>
									<div class="common_content">
	           							<div class="common_content_a">
	           								<c:forEach items="${toc.bfList}" var="bf">
												<p><a href="/manu/selectToc.manu?tocId=${bf.tocId}" style="color: #737373;">[<c:out value="${bf.mdNm}"/>] <c:out value="${bf.SUBJ}"/></a></p>  
											</c:forEach>
	           							</div>	
	           						</div>
	           					</div>
	           				</div>	
	           			</div>
	           		</div>
	           	</div>
           	</c:if>
           	
           	<c:if test="${not empty toc.afList}">
           		<div class="common_a">
	           		<div class="common_b">
	           			<div class="common_c">
	           				<div class="common_d">
	           					<div>
	           						<div>
	           							<h5 class="common_subject"> 
	           								후행업무
	           							</h5>
	           						</div>
									<div class="common_content">
	           							<div class="common_content_a">
	           								<c:forEach items="${toc.afList}" var="af">
												<p><a href="/manu/selectToc.manu?tocId=${af.tocId}" style="color: #737373;">[<c:out value="${af.mdNm}"/>] <c:out value="${af.SUBJ}"/></a></p>  
											</c:forEach>
	           							</div>
	           						</div>
	           					</div>
	           				</div>	
	           			</div>
	           		</div>
	           	</div>
           	</c:if>
           	
           	<c:if test="${not empty toc.cmdList}">
           		<div class="common_a">
	           		<div class="common_b">
	           			<div class="common_c">
	           				<div class="common_d">
	           					<div>
	           						<div>
	           							<h5 class="common_subject"> 
	           								관련명령
	           							</h5>
	           						</div>
									<div class="common_content">
	           							<div class="common_content_a">
	           								<c:forEach items="${toc.cmdList}" var="cmd" varStatus="index">
												<c:out value="${cmd.tCd}"/><br/>  
											</c:forEach>	
	           							</div>
	           						</div>
	           					</div>
	           				</div>	
	           			</div>
	           		</div>
	           	</div>
           	</c:if>
           	
           	<c:if test="${not empty toc.fileList}">
           		<div class="common_a">
	           		<div class="common_b">
	           			<div class="common_c">
	           				<div class="common_d">
	           					<div>
	           						<div>
	           							<h5 class="common_subject"> 
	           								첨부파일
	           							</h5>
	           						</div>
									<div class="common_content">
	           							<div class="common_content_a">
	           								<c:forEach items="${toc.fileList}" var="file" varStatus="fileStatus">
												<c:if test="${not fileStatus.first}"><br/></c:if>
												<a style="color: #737373;" href="${pageContext.request.contextPath}/common/file/download.common?fileId=${file.fileId}" target="invisible"><img src="${pageContext.request.contextPath}/common/images/icon_file.png" alt="첨부파일"/>
													<c:out value="${file.fileNm}"/> ( <c:out value="${file.sizeSF}"/> ) 
												</a>
											</c:forEach> 	
	           							</div>
	           						</div>
	           					</div>
	           				</div>	
	           			</div>
	           		</div>
	           	</div>
           	</c:if>
           	
           	<c:if test="${not empty toc.contents && toc.contents ne '' && toc.contents ne '<p>&nbsp;</p>' && toc.contents ne '<p></p>'}">
           		<div class="common_a">
	           		<div class="common_b">
	           			<div class="common_c">
	           				<div class="common_d">
	           					<div>
	           						<div>
	           							<h5 class="common_subject"> 
	           								업무설명
	           							</h5>
	           						</div>
									<div class="common_content_none">
	           							<div id="detailTdArea" class="common_content_a">
											${toc.contents}							
	           							</div>
	           						</div>
	           					</div>
	           				</div>	
	           			</div>
	           		</div>
	           	</div>
           	</c:if>
        </div>
        <!-- Google 상세보기 끝 -->
    </div>
	<section class="board_bottom">
		<div class="board_btn">
			<a href="javascript:fn_moveList();"  class="w_p100" name="btn_rsrc_list" style="color:white;">목록</a>
		</div>
	</section>
	<iframe name='invisible' frameborder="0" width="0" height="0"></iframe>  
</body>
</html>

        