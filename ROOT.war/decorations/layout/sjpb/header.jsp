<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.saltware.enview.security.UserInfo"%>
<%@page import="org.apache.commons.logging.LogFactory"%>
<%@page import="org.apache.commons.logging.Log"%>
<%@page import="com.saltware.enview.om.page.Page"%>
<%@page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.saltware.enview.security.spi.impl.IsMemberOfPrincipalAssociationHandler"%>
<%@page import="com.saltware.enview.security.EnviewMenu"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../initLayoutDecorators.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%
	request.setAttribute("topMenuList", site.getTopMenu( request, rootSite ));
	request.setAttribute("leftMenuList", site.getSubMenu( request, rootSite , 2));
	
	request.setAttribute("isMyPage", currentPage.getPath().contains("/user/"));
	request.setAttribute("isEditPage", "/contentonly".equals( request.getServletPath()));
	
	request.setAttribute("userInfo", EnviewSSOManager.getUserInfo(request));
	
	String theme = request.getParameter("theme");
	if( theme == null || theme.length() == 0 ) theme = "";
	
	String pageIds = site.getCurrentPageIds(request, 2);
	
	String breadcrumbs = includeLinksNavigation( site.getNavigation(request, "/sjpb"), langKnd );
	String subtitle = "";

	if( currentPage.getParent() != null ) 
	{
		subtitle = currentPage.getParent().getShortTitle(locale);
	}
	else 
	{
		subtitle = currentPage.getShortTitle(locale);
	}
	int tabordercnt = 0;   
	
	String currentPath = currentPage.getPath();
	request.setAttribute("currentPath", currentPath);
	
	
	if( currentPath.indexOf("/sjpb/") != -1) { 
		pageContext.setAttribute("PageTitle", pageContext.getAttribute("PageTitle") + " | 수사정보포털시스템");
	}

	try{
		
		request.setAttribute("parentPageTitle",currentPage.getParent().getShortTitle(locale));
		request.setAttribute("parentParentPageTitle",currentPage.getParent().getParent().getShortTitle(locale));
		request.setAttribute("currentPageTitle",currentPage.getShortTitle(locale));
	}catch(Exception e){
		
	}


	String nmkor = "";
	String orgName = "";
	String criMbPosi ="";
	String criMbPosiNm = "";
	
	nmkor = (String)(userInfo.get("nmKor") == null ? "" : userInfo.get("nmKor"));
	orgName = (String)(userInfo.get("orgName") == null ? "" : userInfo.get("orgName"));
	criMbPosi = (String)(userInfo.get("criMbPosi") == null ? "" : userInfo.get("criMbPosi"));
	criMbPosiNm = (String)(userInfo.get("criMbPosiNm") == null ? "" : userInfo.get("criMbPosiNm"));
	
	if(criMbPosiNm == null){
		criMbPosiNm ="수사관";
	}else{
		if("04".equals(criMbPosi) || "05".equals(criMbPosi)){
			criMbPosiNm ="수사관";
		}
	}
	
	request.setAttribute("nmkor", nmkor);
	request.setAttribute("orgName", orgName);
	request.setAttribute("criMbPosiNm", criMbPosiNm);
	request.setAttribute("lastLogon", userInfo.get("lastLogon") == null ? "" : userInfo.get("lastLogon"));
	
	
	
	 
	 
	//------------------------------------------------------	
	try{
%>
<html lang="ko-KR">
	<head>
		<meta charset="UTF-8">
		<title>수사정보포털시스템</title>
		<meta http-equiv="Content-type" content="text/html; charset=UTF-8"/>
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<meta http-equiv="Content-style-type" content="text/css"/>   
		<meta name="version" content="3.2.5"/>
		<meta name="keywords" content="" />
		<meta name="description" content="${PageTitle}"/>
		<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
		<script type="text/javascript" src="${cPath}/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/jquery/ui/i18n/jquery.ui.datepicker-${langKnd}.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/jquery/jquery.blockUI.js"></script>
		
		<script type="text/javascript" src="${cPath}/javascript/message/mrbun_${langKnd}_mm.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/message/mrbun_${langKnd}_ev.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/message/mrbun_${langKnd}_eb.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/common_new.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/portal_new.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/utility.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/validator.js"></script>
		
		<script type="text/javascript" src="${cPath}/admin/javascript/portlet.js"></script>
		
		<link id="sjpbMainCss" rel="stylesheet" type="text/css" href="${cPath}/sjpb/css/main.css" />
		<link rel="stylesheet" type="text/css" href="${cPath}/sjpb/js/Z/dhtmlx/suite/dhtmlx.css" />
				
		<script src="${cPath}/Highcharts/highcharts.js"></script>
		<script src="${cPath}/Highcharts/highcharts-more.js"></script>
		<script src="${cPath}/Highcharts/modules/series-label.js"></script>
		<script src="${cPath}/Highcharts/modules/exporting.js"></script>
		<script src="${cPath}/Highcharts/modules/export-data.js"></script>
		<script src="${cPath}/Highcharts/modules/variable-pie.js"></script>
		<script src="${cPath}/Highcharts/modules/exporting.js"></script>
		<script src="${cPath}/Highcharts/modules/export-data.js"></script>
				
		<script type="text/javascript" src="${cPath}/sjpb/js/Z/jquery.js"></script>
		<script type="text/javascript" src="${cPath}/sjpb/js/Z/main.js"></script>
		<script type="text/javascript" src="${cPath}/sjpb/js/Z/dhtmlx/suite/dhtmlx.js"></script>
		<script type="text/javascript" src="${cPath}/sjpb/js/Z/dhtmlx/suite/thirdparty/excanvas/excanvas.js"></script>
		
		<script type="text/javascript" src="${cPath}/sjpb/js/rulemng.js"></script>
		<script type="text/javascript" src="/javascript/jquery/jquery.blockUI.js"></script> 
		
		<style>
		.highcharts-pie-series .highcharts-point {
			stroke: #EDE;
			stroke-width: 2px;
		}
		.highcharts-pie-series .highcharts-data-label-connector {
			stroke: silver;
			stroke-dasharray: 2, 2;
			stroke-width: 2px;
		}
		</style>
		<script type="text/javascript">
		
		$( document ).ready(function(){
			
			$(document).on("click", ".ocrt_sub_tab", function(){
				var id = $(this).attr("id");
				//선택된 탭 활성화
				fn_activeTab(id);
			
			});

			//탭 제거
			$(document).on("click", "#sub_tab .tab_close", function(event){
				//이벤트 버블링 제거 
				event.stopPropagation();
				
				//li 개수체크, 마지막하나는 지워지지 않음.
				var liCount = $( this ).closest( "li" ).siblings().length;
				if(liCount >= 1){
					//이전 탭 li id 찾기
					var prevPanelId=$( this ).closest( "li" ).prev("li").attr("id");
					if(prevPanelId == null){ //이전 탭없을시 다음탭으로 대체
						prevPanelId = $( this ).closest( "li" ).next("li").attr("id");
					}
					//선택된 li 제거
					var panelId = $( this ).closest( "li" ).attr("id");
					$("#"+panelId).remove();

					//선택된 div 제거
					$("."+panelId).remove();
					
					//이전 탭 활성화
					fn_activeTab(prevPanelId);
				}
			});
			
			$("#systemmenu a:not(.off_arr)").click(function() {	
	            // 현재 눌린 a 태그 가져오기
	            var link = $(this);
	            // tabs_id 선언
	            var tabs_id = "ocrt_list_tab" + $(link).attr("id");
	            // find_id 선언
	            var find_id = $("[id= " + tabs_id + "]").attr("id");

	            // a태그에 해당하는 탭이 열려 있을 경우
	            if(find_id == tabs_id){
	                // 열려있는 탭으로 이동
	               fn_activeTab(tabs_id);
	            // 아닐경우
	            }else{
	                // 탭을 추가
	                fn_tabAction(link);
	            }
	        }); 
			
			
			var contentHtml = "<div id='sjpbMain' class='contentsArea' style='display:block;'><div class='wrap'><div class='contents'> <div id='sub_tab' style='display:none'><ul class='sub_tab ocrt_tab clearfix' id='tabs'> </ul><div class='ocrt_wrap clearfix' id='ocrt_wrap'></div></div>";
			$(document).on("click",".lmenuOpen",function(event){
				var link = $(this);
                // 탭을 추가
                var label = $(link).attr("data-title");
                var rel = $(link).attr("rel");
                var id =  "ocrt_list_tab" + $(link).attr("id"); // 맨하위이름
                var data_root = $(link).attr("data-root"); // 메뉴 비교값
                var data_tab = $(link).attr("data-tab"); // 탭 비교값
                var tab_id = "iframe"+$(link).attr("id");
                var li="<li class='ocrt_sub_tab' id='"+id+"' data-root='"+data_root+"'><span class='on'><a href='javascript:void(0);'>"+label+"</a><a href='javascript:void(0);' class='tab_close'><img src='${cPath}/sjpb/images/close_icon.png' alt='닫기' /></a></span></li>";
                var tabContentHtml = "";
                tabContentHtml = '<iframe name="sjpbIframe" frameborder="0" src="'+rel+'" id="'+tab_id+'" width="100%" height="100%" title="'+label+'" scrolling="no" onLoad="autoresize_iframe_portlet();"></iframe>';
                if($("#sub_tab").css("display") != 'block' ){
                	$("#sjpbContentMain").append(contentHtml);
                }
                if($("#sub_tab").is("."+data_tab) == false){//처음 메뉴 들어갈때
                	$("head link#sjpbMainCss").attr("href", '/sjpb/css/contents.css');
                	$("#main").remove(); // 메인페이지 지우기
                	$("#sjpbMain").css("display","block"); //tab 영역 나오기
                	$("#sub_tab").css("display","block"); //tab 영역 나오기
                	$("#leftmenu").css("display","block"); //왼쪽메뉴 나오게
                	$("#sub_tab").addClass(data_tab); // 다시 클래스 추가
                }
                if($("#sub_tab").is("."+data_root) == false){
                	$("#root_left").css("display","block"); //닫기메뉴 나오게                	
                	$("#systemmenu ul").css("display","none"); //이미 있는 왼쪽메뉴 안나오게
	        		$("#sub_tab").removeClass(); // 클래스 삭제
	        		$("#sub_tab").addClass(data_root); // 다시 클래스 추가
	        		$("#"+data_root).css("display","block");
        		}
                
                var find_id = $("[id= " + id + "]").attr("id");
                if(find_id == id){//이미 있을 경우
                	fn_activeTab(id); // 탭 활성화
                	
    	        }else{// 탭추가
        			$("#tabs").append(li);
                	// 추가된 탭의 내용을 삽입
                	$("#ocrt_wrap").append( "<div class='" + id + " list'><p>" + tabContentHtml + "</p></div>" );
                	//탭 활성화
                	fn_activeTab(id);
    	        }
			});
			 
		});

        // 선택한 tabs li 태그의 해당하는 tab id 찾아서 보여줌
		function fn_activeTab(tab_id){  
			$("#tabs li").each(function(index) {
				var n = $(this).attr("id");
				$(this).removeClass("sub_tab_on");
				$("." + n).hide();
			});
			$("#"+tab_id).addClass("sub_tab_on");
			$("." + tab_id ).show();
			
			autoresize_iframe_portlet();
        }
        
        //탭 추가
		function fn_tabAction(link){
			// 탭 라벨 선언
            var label = $(link).text();
            // id 값을 ocrt_list_tab + 번호 로 선언
            var id = "ocrt_list_tab" + $(link).attr("id");
            var tab_id = "iframe"+$(link).attr("id");
            // rel : link의 속성 중 rel을 찾는다.
            var rel = $(link).attr("rel");
            var li="<li class='ocrt_sub_tab' id='"+id+"'><span class='on'><a href='javascript:void(0);'>"+label+"</a><a href='javascript:void(0);' class='tab_close'><img src='${cPath}/sjpb/images/close_icon.png' alt='닫기' /></a></span></li>";
            var tabContentHtml = "";
            tabContentHtml = '<iframe name="sjpbIframe"  frameborder="0" src="'+rel+'" id="'+tab_id+'" width="100%" height="100%;" scrolling="no" onLoad="autoresize_iframe_portlet();"></iframe>';
            
            $("#tabs").append(li);
            // 추가된 탭의 내용을 삽입
            $("#ocrt_wrap").append( "<div class='" + id + " list'><p>" + tabContentHtml + "</p></div>" );
            //탭 활성화
            fn_activeTab(id);
            
		}

		function autoresize_iframe_portlet() {
			var iframes = document.getElementsByTagName("iframe");
			for( var i =0; i < iframes.length;i++ ) {
				if( iframes[i].name.indexOf("sjpbIframe") > -1) {
					iframe_heightResize( iframes[i]);
				}
			}
		}

		function autoresize_iframe_etc_portlet() {
			var iframes = document.getElementsByTagName("iframe");
			for( var i =0; i < iframes.length;i++ ) {
				if( iframes[i].name.indexOf("sjpbIframe") > -1) {
					iframe_etcHeightResize( iframes[i]);
				}
			}
		}
		
		
		function iframe_heightResize(arg) {
		
			 var contentHeight = arg.contentWindow.document.body.scrollHeight;
			 if(contentHeight <= 685) contentHeight = 750;
			 arg.style.height = contentHeight  + "px";
			
		}
		

		
		

		function iframe_setHeightResize(arg,argHight) {
			var iframes = document.getElementsByTagName("iframe");
			for( var i =0; i < iframes.length;i++ ) {
				if( iframes[i].name.indexOf("sjpbIframe") > -1) {
					iframe_etcSetHeightResize( iframes[i], argHight);
				}
			}
			
		}

        
		function iframe_etcSetHeightResize(arg,argHight) {
			 arg.style.height = argHight  + "px";
		}	
		
		
		function iframe_etcHeightResize(arg) {
			 var contentHeight = arg.contentWindow.document.documentElement.scrollHeight;
			 if(contentHeight <= 685) contentHeight = 750;
			 arg.style.height = contentHeight  + "px";
		}		
		
		function fn_passwordChange(){
			var url  = "/statics/sjpbProcess/passwordChange.jsp";
			$.blockUI({ 
				message:"<iframe src='"+url+"' frameborder='0' scrolling='no' style='width:850px;height:580px;'>"
			   ,css:{width:'850px', height:'580px', top:($(window).height()-499) /2 + 'px', left:($(window).width()-700) /2 + 'px'}
		   });
		}
		
		function blockClose(){
			$.unblockUI(); 
		}
		
		function fn_scrollTop(){
			$(window).scrollTop(0);
		}
		function initEnview() {
			<%=initEnviewScript%>
			//initNavigation("<%=userId%>", "<%=pageIds%>");
			//checkPrivateUserInfoRutin();
			// 비밀번호 변경 주기 확인
// 			checkChangeRutin();
		}	
		
		function checkModified() {
			portalPage.checkModified();
		}
		
		// Attach to the onload event
		if (window.attachEvent)
		{
			//window.attachEvent ( "onload", initEnview );
			window.attachEvent ( "onunload", checkModified );
		}
		else if (window.addEventListener )
		{
			//window.addEventListener ( "load", initEnview, false );
			window.addEventListener ( "unload", checkModified, false );
		}
		else
		{
			//window.onload = initEnview;
			window.onunload = checkModified;
		}
	</script>
	</head>
<!-- header -->
<div id="header">
		<!-- top -->
		<div class="top">
			<div class="wrap">
				<p class="user"><span><em>${orgName} ${nmkor}</em>${criMbPosiNm}님이 로그인이 되어있습니다.</span></p> 
				<p class="lastlogin"><span>최종접속일시<em><fmt:formatDate value="${lastLogon}" pattern="yyyy.MM.dd HH:mm"/></em></span></p> 
			</div>
		</div>
		<!-- GNB 영역 -->
		<div class="gnb">
			<div class="wrap">
				<h1><a href="${cPath}/portal" title="민생사법경찰단 수사정보 포털시스템"><img src="${cPath}/sjpb/images/logo.png" alt="민생사법경찰단로고" /></a></h1>
			<ul>
			<c:forEach items="${topMenuList}" var="menu" varStatus="status">
				<c:if test="${!menu.hidden && menu.name != menu2hide1 && menu.name != menu2hide2}">
				<c:if test="${status.index != 0}">
					<li class="gnb_title"><a href="javascript:void(0);">${menu.shortTitle}</a>
						<c:if test="${not empty menu.elements }">
					        <div class="depth_2">
					            <div class="gnb_wrap">
					            	<c:if test="${menu.name == 'tm001'}">
					            		<div class="title_01"/>
					            			<h5>${menu.shortTitle}<br/><!--<span class="sub_txt">사건관리 정보를 도와드립니다.</span> --></h5>
					            		</div>
					            	</c:if>
					            	<c:if test="${menu.name == 'tm002'}">
					            		<div class="title_01"/>
					            			<h5>${menu.shortTitle}<br/><!--<span class="sub_txt">송치관리 정보를 도와드립니다.</span> --></h5>
					            		</div>
					            	</c:if>
					            	<c:if test="${menu.name == 'tm003'}">
					            		<div class="title_02"/>
					            			<h5>${menu.shortTitle}<br/><!--<span class="sub_txt">수사업무를 지원해드립니다.</span> --></h5>
					            		</div>
					            	</c:if>
					            	<c:if test="${menu.name == 'tm004'}">
					            		<div class="title_03"/>
					            			<h5>${menu.shortTitle}<br/><!--<span class="sub_txt">통계현황을 알려드립니다.</span> --></h5>
					            		</div>
					            	</c:if>
					            	<c:if test="${menu.name == 'tm005'}">
					            		<div class="title_04"/>
					            			<h5>${menu.shortTitle}<br/><!--<span class="sub_txt">공지/일정을 알려드립니다.</span> --></h5>
					            		</div>
					            	</c:if>
					            	 
					                <ul>
										<c:forEach items="${menu.elements}" var="lmenu" varStatus="lstatus">
											<c:if test="${lmenu.hidden=='false'}">		
												<c:if test="${not empty lmenu.elements}">
													<li class="depth_1"><a href="javascript:void(0);" target="<c:out value="${lmenu.target}"/>"> <c:out value="${lmenu.shortTitle}"/></a> 
														<ul class="depth_03">
														<c:forEach items="${lmenu.elements}" var="subMenu" varStatus="lstatus">
														<c:if test="${subMenu.hidden=='false'}">
															<li><a href="javascript:void(0);" class="lmenuOpen" id="${lmenu.name}_${subMenu.name }" data-root="${menu.name }" data-title="${subMenu.shortTitle}" rel="${subMenu.menuUrl}" rel2="${subMenu.menuType}" target="${subMenu.target}">&nbsp;<c:out value="${subMenu.shortTitle}"/></a></li>
														</c:if>
														</c:forEach>
														</ul>
													</li>
												</c:if>
												<c:if test="${empty lmenu.elements}">
													<li class="depth_1"><a href="javascript:void(0);" class="lmenuOpen" id="${menu.name }_${lmenu.name }" data-root="${menu.name }" data-title="${lmenu.shortTitle}" rel="${lmenu.menuUrl}" rel2="${lmenu.menuType}"  target="<c:out value="${lmenu.target}"/>"> <c:out value="${lmenu.shortTitle}"/></a></li>  
												</c:if>
											</c:if>
										</c:forEach>
									</ul>
					 			</div>
					        
					        </div>
					      </c:if>
					</li>
				</c:if>

				</c:if>
			</c:forEach>
			</ul>
			<div class="gnb_btnArea">
				<a href="${cPath}/portal" class="home"><span>HOME</span></a>
				<a href="#." onclick="fn_passwordChange();"class="change"><span>비밀번호 변경</span></a>
				<a href="/user/logout.face" class="logout"><span>로그아웃</span></a>
			</div>
		</div>
		</div>
		</div>

		<!-- GNB 영역 //-->
		<div id="body" >
		    <div id="container">
		        <!-- leftmenu -->
		        <div id="leftmenu" class="open" style="display:none">
		        <div id="systemmenu" class="cssmenu">
		        <c:forEach items="${topMenuList}" var="menu" varStatus="status">
					<c:if test="${!menu.hidden && menu.name != menu2hide1 && menu.name != menu2hide2}">
						<c:if test="${status.index != 0}">

			                <ul id="${menu.name }" style="display:none">
			                <c:forEach items="${menu.elements}" var="lmenu" varStatus="lstatus">
								<c:if test="${lmenu.hidden=='false'}">		
									<c:if test="${not empty lmenu.elements}">
										<li class="has-sub"><a href="<c:out value="${lmenu.fullUrl}"/>" class="click off_arr on_arr" target="<c:out value="${lmenu.target}"/>"> <c:out value="${lmenu.shortTitle}"/></a>  <%-- 입건실적 --%>
											<ul id="documents">
												<c:forEach items="${lmenu.elements}" var="subMenu" varStatus="Substatus">
												<c:if test="${subMenu.hidden=='false'}">
													<li class="has-sub"><a href="javascript:void(0);" id="${lmenu.name}_${subMenu.name}" data-root="${menu.name }" data-title="${subMenu.shortTitle}" data-tab="tab" rel="${subMenu.menuUrl}"  class="click lmenuOpen"  target="${subMenu.target}">&nbsp;<c:out value="${subMenu.shortTitle}"/></a></li>
												</c:if>
												</c:forEach>
											</ul>
										</li>
									</c:if>
									<c:if test="${empty lmenu.elements}">
										<li class="has-sub"><a href="javascript:void(0);" id="${menu.name }_${lmenu.name}" data-root="${menu.name }" data-title="${subMenu.shortTitle}" rel="${lmenu.menuUrl}" data-tab="tab" class="click lmenuOpen" target="<c:out value="${lmenu.target}"/>"> <c:out value="${lmenu.shortTitle}"/></a></li>  <%-- 입건실적 --%>
									</c:if>
								</c:if>
								</c:forEach>
							</ul>
						 			
						        	
		        				
		        			
		        		</c:if>
		        		
		        	</c:if>
		        </c:forEach>
		        </div>
		        </div>
		        <a href="javascript:void(0);" class="btn_menu" id="root_left" style="display:none"><img src="${cPath}/sjpb/images/btn_close.png" alt="닫기" /></a>       						       						
				<div id="sjpbContentMain"></div>
				<div id="main" class="contents">
					<!-- contents_warp -->
					<div class="wrap all_contente">
											
										
                        
<% } catch(Exception e) {
	Log log = LogFactory.getLog(getClass());
	log.error( e, e);
} %>
