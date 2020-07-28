<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.saltware.enview.Enview" %>
<%@ page import="com.saltware.enview.session.SessionManager" %>
<%@ page import="com.saltware.enview.notice.Notice" %>
<%@ page import="com.saltware.enview.notice.NoticeManagement" %>
<%@ page import="com.saltware.enview.notice.Notices" %>
<%@page import="org.apache.commons.logging.LogFactory"%>
<%@page import="org.apache.commons.logging.Log"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String notice_id = null;
	String content = null;
	try {
		notice_id = request.getParameter("notice_id");
		SessionManager sm = (SessionManager)Enview.getComponentManager().getComponent("com.saltware.enview.session.SessionManager");
		NoticeManagement noticeManager = (NoticeManagement)Enview.getComponentManager().getComponent("com.saltware.enview.notice.impl.NoticeManager");
		Notices notices = (Notices)Enview.getComponentManager().getComponent("com.saltware.enview.notice.Notices");
		String langKnd = sm.getUserLangKind(request);
		Notice notice = noticeManager.getNotice( notice_id );
		List attachFileList = null;
		
		if( notice == null ) {
			notice = noticeManager.getNoticeFormDB( notice_id );
		}
		
		if( notice != null ) {
			content = notice.getContent(new Locale("ko"));
			attachFileList = notice.getAttachFileList();
			request.setAttribute("content", content);
			request.setAttribute("attachFileList", attachFileList);
			
		}
		
		String userid = (String)session.getAttribute("_enpass_id_");
		
	}
	catch(Exception e) {
		Log log = LogFactory.getLog(getClass());
		log.error( e.getMessage(), e);;
	}
	
%>

<html>
<head>
<title>Enview 공지사항</title>
<link rel="stylesheet" type="text/css" href="./css/notice.css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/javascript/jquery/jquery-1.10.2.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<script type="text/javascript">
	function initTemplate() 
	{
		
	}
	
	function setCookie( name, value, expiredays ){ 
		var todayDate = new Date(); 
		todayDate.setDate( todayDate.getDate() + expiredays ); 
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
	} 

	function closeWin()
	{
		if (document.form1.today.checked == true){
			setCookie("ENVIEW_NOTICE_<%= notice_id %>", "no" , 1); 
		} 
		self.close();
	}

	function go()
	{
		opener.location.href=""
		self.close();
	}	

	if (window.attachEvent)
	{
		window.attachEvent ( "onload", initTemplate );
	}
	else if (window.addEventListener )
	{
		window.addEventListener ( "load", initTemplate, false );
	}
	else
	{
		window.onload = initTemplate;
	}
	
	$(document).ready(function(){
        $("#fListBtn").click(function(){
            $("#fListLayer").toggle();
        });
        $("#fListClose").click(function(){
            $("#fListLayer").hide();
        });
        
        var element = $(".tb_wrap");

        var thisX = parseInt(document.body.scrollWidth);
        var thisY = parseInt(document.body.scrollHeight);
        var maxThisX = screen.width - 50;
        var maxThisY = screen.height - 50;
        
        //alert("thisX = " + thisX + "\nthisY = " + thisY);
        //alert("maxThisX = " + maxThisX + "\nmaxThisY = " + maxThisY);
        
        var marginY = 0;
        //alert("임시 브라우저 확인 : \n" + navigator.userAgent);
        // 브라우저별 높이 조절. (표준 창 하에서 조절해 주십시오.)
        
       if (navigator.userAgent.indexOf("MSIE 8") > 0) {                                // IE 8.x
           marginY = 83;
        } else if(navigator.userAgent.indexOf("MSIE 9") > 0) {                       // IE 9.x
           marginY = 68;                       
        } else if(navigator.userAgent.indexOf("MSIE 10") > 0) {                      // IE 10.x
           marginY = 67;
           thisY += 15;
        } else if(navigator.userAgent.indexOf("Trident/7.0") > 0) {                  // IE 11.x
            marginY = 67;
            thisY += 15;
        } else if(navigator.userAgent.lastIndexOf("OPR") > 0){
            marginY = 40;     // Opera
            thisY += 50;
            thisX += 25;
        } else if(navigator.userAgent.indexOf("Chrome") > 0) {                       //Chorme
            marginY = 70;
            thisX += 10;
            thisY += 15;
        } else if(navigator.userAgent.indexOf("Safari") > 0) {                       // Safari
            marginY = 22;     // Safari
            thisY += 22;
            thisX += 15;
        } else if(navigator.userAgent.indexOf("Firefox") > 0){
            $('body').height(thisY+6);
            marginY = 50;   // FF 
            thisY += 37;
        }else {             
            marginY = 60;
       }                                                                   
        
        if (thisX > maxThisX) {
            window.document.body.scroll = "yes";
            thisX = maxThisX;
        }
        
        if (thisY > maxThisY - marginY) {
            //firefox 에서 scroll 안됨.
        	window.document.body.scroll = "yes";
            thisY = maxThisY - marginY;  
            thisY+=20;
            thisX += 20;
        }
        
        window.resizeTo(thisX+10, thisY+marginY);

    });
	
	
</script>

</head>
<!-- 600*460 size -->
<body class="popup" id="popup">
<form name="form1" id="form1" method="post">
	<!-- pop header -->
	<div id="pop_header">
		<p>Enview Appliance에 오신걸 환영합니다.</p>
        <h2>공지사항</h2>
	</div>
	<!-- //pop header -->
	<!-- pop content-->
	<div id="pop_content">
            <!-- pop Attach file-->
            <div class="attach_file">
                <c:if test="${empty attachFileList}">
                    <p class="t_file"><span>첨부파일이 없습니다.</span></p>
                </c:if>
                <c:if test="${not empty attachFileList}">
                    <p class="t_file"><a href="#" id="fListBtn"><span>첨부파일이 있습니다.</span><img src="./images/btn_dropdown.gif" alt="첨부파일 보기" /></a></p>
                </c:if>
                <!-- 첨부파일 목록 보기 -->
				<div id="fListLayer" class="t_filebox" style="display:none;">
					<ul class="t_file_list">
					    <c:forEach items="${attachFileList}" var="attachFile">
							<!-- 다운로드 링크 -->   
							<li><img src="./images/file.png" alt="첨부파일" /><a href="/attachFile/fileMngr?cmd=down&systemId=notice&fileId=${attachFile.fileId}&fileSeq=${attachFile.fileSeq}" target="download"><c:out value="${attachFile.fileName}"/> (<c:out value="${attachFile.fileSizeSF}"/>)</a></li>
						</c:forEach>
					</ul>
					<p class="t_file_close"><a href="#none;"  id="fListClose"><img src="./images/btn_close.png" alt=닫기" /></a></p>
				    <span class="t_file_shadow">&nbsp;</span>
				</div>
                <!-- //첨부파일 목록 보기 -->
            </div>
            <!-- //pop Attach file-->
        <!-- table wrap -->
        <div class="tb_wrap" id="Portal.Enview.NoticeArea">
            <c:out value="${content}" escapeXml="false"/>
        </div>
        <!-- //table wrap -->
    </div>
	<p class="pop_close" >
	   <input type="checkbox" name="today" onClick="closeWin()" id="chek_close" /> <label for="chek_close">오늘 하루 그만보기</label>
	</p>   
</form>
<!-- //pop content-->
</body>
</html>