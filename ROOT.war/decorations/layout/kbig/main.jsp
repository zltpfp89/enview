<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.saltware.enview.util.EnviewMap"%>
<%@page import="kbig.edureg.service.EduRegService"%>
<%@page import="kbig.main.service.MainService"%>
<%@page import="com.saltware.enview.Enview"%>
<%@page import="com.saltware.enface.portlet.board.service.MiniBoardService"%>
<%@ page language="java" contentType="text/html; charset=utf-8"   pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
MiniBoardService miniBoardService = (MiniBoardService) Enview.getComponentManager().getComponent("com.saltware.enface.portlet.board.service.MiniBoardService");
request.setAttribute("noticeList", miniBoardService.findBltn("knowledge_notice"));
request.setAttribute("newsList", miniBoardService.findBltn("news_news"));
request.setAttribute("filesList", miniBoardService.findBltn("files_bigdata_report"));


MainService mainService = (MainService)Enview.getComponentManager().getComponent("mainService");
request.setAttribute("popupZoneList", mainService.list("main.listPopupZone", null));
Map<String, Object > bdmMap = new HashMap<String, Object>();

bdmMap.put("bdmView", mainService.list("main.listBdm", null));
bdmMap.put("bdmView_2", mainService.list("main.listBdm_2", null));

//request.setAttribute("bdmList", mainService.list("main.listBdm", null));
request.setAttribute("bdmMap", bdmMap);

EduRegService eduRegService = (EduRegService)Enview.getComponentManager().getComponent("eduRegService");
Map paramMap = new EnviewMap();
paramMap.put("status", 1);
paramMap.put("offset", 0);
paramMap.put("limit", 4);
request.setAttribute("eduList", eduRegService.listEdu( paramMap));
%>
<script type="text/javascript">
     
$( function() {
	 var uAgent = navigator.userAgent.toLowerCase();
	 
	    //< 모바일 기기 추가시 등록
	    var mobilePhones = new Array('iphone', 'ipod', 'android', 'blackberry', 'windows ce', 'nokia', 'webos', 'opera mini', 'sonyericsson', 'opera mobi', 'iemobile', 'windows phone');
	     
	    var isMobile = false;
	     
	    for( var i = 0 ; i < mobilePhones.length ; ++i )
	    {
	        if( uAgent.indexOf(mobilePhones[i]) > -1)
	        {
	            isMobile = true;
	             
	            break;
	        }
	    }
	    //< 모바일인 경우
	    if( isMobile )
	    {
	    	var html = "";
	    	html +="<ul>";
	    	html +="<li class='no_1'><a href='/portal/kbig/datacube/education.page'>교육실습컨텐츠</a></li>";
	    	html +="<li class='no_2'><a href='/portal/kbig/analysis/openlab/reserve'>오픈랩신청</a></li>";
	    	html +="<li class='no_3'><a href='/portal/kbig/analysis/infra/reserve'>인프라신청</a></li>";
	    	html +="<li class='no_4'><a href='/portal/kbig/datacube/dataset/dataset'>데이터셋</a></li>";
	    	html +="<li class='no_5'><a href='/portal/kbig/noid'>비식별조치</a></li>";
	    	html +="<li class='no_6'><a href='http://search.kbig.kr:8080/experience/home.do' target='_blank'>소셜분석체험</a></li>";
	    	html +="<li class='no_7'><a href='/portal/kbig/info/partner'>협력파트너</a></li>";
	    	html +="</ul>";
	       $('#quickMenu').empty();
	       $('#quickMenu').append(html);
	    }
});

   
</script>

			<div class="main_top">
				<ul class="main_slider">
					<li class="no_01 cf">
						<p class="text">
							<span>함께 만드는 빅데이터<br />함께 누리는 가치</span>
							<span class="tit">data ㆍ insight ㆍ value</span>
						</p>
					</li> <!-- //no_01 -->
					<li class="no_02 cf">
						<p class="text">
							<span>함께 만드는 빅데이터<br />함께 누리는 가치</span>
							<span class="tit">data ㆍ insight ㆍ value</span>
						</p>
					</li> <!-- //no_02 -->
					<li class="no_03 cf">
						<p class="text">
							<span>함께 만드는 빅데이터<br />함께 누리는 가치</span>
							<span class="tit">data ㆍ insight ㆍ value</span>
						</p>		
					</li> <!-- //no_03 -->
				</ul> <!-- //main_slider -->
				<div class="quick_menu" id="quickMenu">
					<ul>
						<li class="no_1"><a href="/portal/kbig/datacube/education.page">교육실습컨텐츠</a></li>
						<li class="no_2"><a href="/portal/kbig/analysis/openlab/reserve">오픈랩신청</a></li>
						<li class="no_8"><a href="/portal/kbig/datacube/dataset/cloud">LOD클라우드</a></li>
						<li class="no_3"><a href="/portal/kbig/analysis/infra/reserve">인프라신청</a></li>
						<li class="no_4"><a href="/portal/kbig/datacube/dataset/dataset">데이터셋</a></li>
						<li class="no_5"><a href="/portal/kbig/noid">비식별조치</a></li>
						<!-- <li class="no_6"><a href="http://search.kbig.kr:8080" target="_blank">소셜분석체험</a></li> -->
						<li class="no_6"><a href="http://search.kbig.kr:8080/experience/home.do" target="_blank">소셜분석체험</a></li>
						<li class="no_7"><a href="/portal/kbig/info/partner">협력파트너</a></li>
					</ul>				
				</div> <!-- //quick_menu -->
			</div> <!-- //main_top -->

			<div class="content">
				<div class="section">
					<div class="box">
						<div class="top">
							<p class="title">공지사항</p>
							<a href="/portal/kbig/knowledge/notice" class="add">더보기</a>
						</div>
						<div class="list">
							<ul>
								<c:forEach items="${noticeList}" var="bltn" end="5">
								<li><a href="/portal/kbig/knowledge/notice?bltnNo=${bltn.bltnNo}">${bltn.bltnSubj}</a><span><fmt:formatDate value="${bltn.regDatim}" pattern="yyyy-MM-dd"></fmt:formatDate></span></li>
								</c:forEach>
							</ul>
						</div>
					</div> <!-- //box -->
					<div class="box">
						<div class="top">
							<p class="title">교육 및 세미나</p>
							<a href="/portal/kbig/knowledge/edu_seminar" class="add">더보기</a>
						</div>
						<div class="list education">
							<ul>
								<c:forEach items="${eduList}" var="edu" end="5">
								<li><a href="/portal/kbig/knowledge/edu_seminar?bltnNo=${edu.bltnNo}">${edu.bltnSubj}</a><span><c:out value="${edu.sdate}"/>~<c:out value="${edu.edate}"/></span></li>
								</c:forEach>
							</ul>
						</div>
					</div> <!-- //box -->
					<div class="box">
						<div class="top">
							<p class="title">소식지 및 보고서</p>
							<a href="/portal/kbig/knowledge/files/bigdata_monthly" class="add">더보기</a>
						</div>
						<div class="book_list">
							<ul>
							<%-- 
								<c:forEach items="${bdmList}" var="bltn" end="2">
								<li><a href="/portal/kbig/knowledge/files/bigdata_monthly?bltnNo=${bltn.bltnNo}" target="_top"><img src="/upload/board/attach/files_bigdata_monthly/${bltn.fileName}" alt="${bltn.bltnSubj}" width="120"/> </a> </li>
								</c:forEach>
							 --%>
							 	<li>
							 		<a href="/portal/kbig/knowledge/files/bigdata_monthly?bltnNo=${bdmMap.bdmView[0].bltnNo}" target="_top"><img src="/upload/board/attach/files_bigdata_monthly/${bdmMap.bdmView[0].fileName}" alt="${bdmMap.bdmView[0].bltnSubj}" width="120"/> </a> 
							 		<br/>Bigdata Monthly : 빅데이터 동향과 이슈
							 	</li>
							 	<li>
							 		<a href="/portal/kbig/knowledge/files/bigdata_report?bltnNo=${bdmMap.bdmView_2[0].bltnNo}" target="_top">
							 			<img src="/upload/board/attach/files_bigdata_report/${bdmMap.bdmView_2[0].fileName}" alt="${bdmMap.bdmView_2[0].bltnSubj}" onerror="this.src='/kbig/img/no_img.jpg'" width="120"/>
									</a> 
							 		<br/><c:out value="${bdmMap.bdmView_2[0].bltnSubj }"/>
							 	</li>
							</ul>
						</div>
					</div> <!-- //box -->
					<div class="box">
						<div class="top">
							<p class="title">뉴스</p>
							<a href="/portal/kbig/knowledge/news/news" class="add">더보기</a>
						</div>
						<div class="list">
							<ul>
								<c:forEach items="${newsList}" var="bltn" end="5">
								<li><a href="/portal/kbig/knowledge/news/news?bltnNo=${bltn.bltnNo}">${bltn.bltnSubj}</a><span><fmt:formatDate value="${bltn.regDatim}" pattern="yyyy-MM-dd"></fmt:formatDate></span></li>
								</c:forEach>
							</ul>
						</div>
					</div> <!-- //box -->
					<div class="box">
						<div class="top">
							<p class="title">자료실</p>
							<!-- <a href="/portal/kbig/knowledge/files/bigdata_report" class="add">더보기</a> -->
							<a href="/portal/kbig/knowledge/files.page" class="add">더보기</a>
						</div>
						<div class="list">
							<ul>
								<c:forEach items="${filesList}" var="bltn" end="5">
								<li><a href="/portal/kbig/knowledge/files/bigdata_report?bltnNo=${bltn.bltnNo}">${bltn.bltnSubj}</a><span><fmt:formatDate value="${bltn.regDatim}" pattern="yyyy-MM-dd"></fmt:formatDate></span></li>
								</c:forEach>
							</ul>
						</div>
					</div> <!-- //box -->
					<div class="box">
						<div class="top">
							<p class="title">팝업존</p>
						</div>
						<div class="popup">
							<ul class="popup_slider">
								<c:forEach items="${popupZoneList}" var="bltn" >
								<c:if test="${not empty bltn.fileName}">
								<c:if test="${fn:substring( bltn.fileName, 0, 1)=='T'}">
								<li><a href="${bltn.linkUrl}" target="${bltn.linkTarget}"><img src="/upload/board/editor/popup_zone/${bltn.fileName}" alt="${bltn.bltnSubj}" /></a></li>
								</c:if>
								<c:if test="${fn:substring( bltn.fileName, 0, 1)!='T'}">
								<li><a href="${bltn.linkUrl}" target="${bltn.linkTarget}"><img src="/upload/board/attach/popup_zone/T150${bltn.fileName}" alt="${bltn.bltnSubj}" /></a></li>
								</c:if>
								</c:if>
								</c:forEach>
							</ul>						
						</div> <!-- //pt_popup -->
					</div> <!-- //box -->
				</div> <!-- //section -->
				<div class="organi_wrap">
					<ul class="organi_slider">
						<li><a href="https://bigdata.seoul.go.kr" target="_blank"><img src="/kbig/img/organi_01.jpg" alt="서울특별시빅데이터캠퍼스" /></a></li>
						<li><a href="https://www.datastore.or.kr" target="_blank"><img src="/kbig/img/organi_02.jpg" alt="데이터스토어" /></a></li>
						<li><a href="https://www.data.go.kr" target="_blank"><img src="/kbig/img/organi_03.jpg" alt="공공데이터포털" /></a></li>
						<li><a href="https://data.gg.go.kr" target="_blank"><img src="/kbig/img/organi_04.jpg" alt="경기데이터포털" /></a></li>
						<li><a href="http://www.msip.go.kr" target="_blank"><img src="/kbig/img/organi_05.jpg" alt="과학기술정보통신부" /></a></li>
					</ul>
				</div> <!-- //organi_wrap -->
				<div class="university_wrap">
					<ul class="university_slider">
						<li><a href="http://www.khu.ac.kr" target="_blank"><img src="/kbig/img/university_01.jpg" alt="경희대학교" /></a></li>
						<li><a href="http://www.skku.edu" target="_blank"><img src="/kbig/img/university_02.jpg" alt="성균관대학교" /></a></li>
						<li><a href="https://www.kookmin.ac.kr" target="_blank"><img src="/kbig/img/university_03.jpg" alt="국민대학교" /></a></li>
						<li><a href="http://www.seoultech.ac.kr" target="_blank"><img src="/kbig/img/university_04.jpg" alt="서울과학기술대학교" /></a></li>
						<li><a href="https://korea.ac.kr" target="_blank"><img src="/kbig/img/university_05.jpg" alt="고려대학교" /></a></li>
					</ul>
				</div> <!-- //university_wrap -->
			</div> <!-- //content -->

<script type="text/javascript">
$(function(){
	//bxSlider 메인비주얼
	var main_slider = $('.main_slider').bxSlider({
		mode:'fade',
		speed:500,
		pause: 5000,
		auto:true,
		autoHover:true,
		autoStart:true,
		controls : false,
		pager : true
	});

	$(document).on('click','.bx-pager-item a',function() {
		main_slider.stopAuto();
		main_slider.startAuto();
	});

	//bxSlider 팝업창
	var popup_slider = $('.popup_slider').bxSlider({
		//mode:'fade',
		speed:500,
		pause: 3500,
		auto:true,
		autoHover:true,
		controls : false,
		pager : true,
	});

	$(document).on('click','.bx-pager-item a',function() {
		popup_slider.stopAuto();
		popup_slider.startAuto();
	});

	//bxSlider 유관기관
	var organi_slider = $('.organi_slider').bxSlider({
		speed:500,
		auto:false,
		controls : true,
		pager: false,
		minSlides: 2,
		maxSlides: 6,
		slideMargin: 0
	});

	$(document).on('click','.bx-controls-direction a',function() {
		organi_slider.stopAuto();
		organi_slider.startAuto();
	});

	//bxSlider 대학
	var university_slider = $('.university_slider').bxSlider({
		speed:500,
		auto:false,
		controls : true,
		pager: false,
		minSlides: 2,
		maxSlides: 6,
		slideMargin: 0
	});

	$(document).on('click','.bx-controls-direction a',function() {
		university_slider.stopAuto();
		university_slider.startAuto();
	});

})
</script>			

