<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ taglib prefix="manu" uri="/WEB-INF/tld/manu.tld" %>

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<title>:: 전자매뉴얼 ::</title>
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

	var initialTocId = '<c:out value="${param.tocId}" />';
	$(document).ready(function(){
		fn_searchTocTree();
		
		//2016.05.18 김승식 : 검색 버튼 클릭시만 조회되게 처리위해서 주석처리
// 		$("#manuList_manuId").change( function() {
// 			fn_search();
// 		});
		
		/* $("#nmList_searchKey").keydown( function( key) {
            if(key.keyCode == '13') fn_search();
		}); */
		
		$("#manuList_searchButton").click( function() {
			fn_search();
		});
		
		$("#nmList_searchKey").keyup(function() {
   	  		var searchString = $(this).val();
            $('#jstree').jstree('search', searchString);
     	 });
		
	});
	
	function fn_search() {
		fn_searchTocList();
		fn_searchTocTree();
	}
	
	function fn_searchTocList() {
		$("#manuList_searchForm").submit();
	}
	function fn_searchTocTree() {
		 var formData = {};
		 if( initialTocId=='') {
			 formData = { mdId : $("#manuList_manuId").val(), searchKey : $("#nmList_searchKey").val()}
		 } else {
			 formData = { tocId : initialTocId}
		 }
		 
		var url = '/manu/selectTocTree.face';
		$.ajax( {
			url : url,
			type : "post",
			data : formData,
			success : function( data) {
				//alert( JSON.stringify( data));
			    $("#jstree").jstree('destroy');				
				$("#jstree").jstree({ 
					'core' : {
				    	'data' : data,
						"multiple" : false,
						"animation" : 0,
						"check_callback" : true
					},"search": {
			            "case_insensitive": true,
			            "show_only_matches" : true
			        },
				    "plugins": ["search"]
				});
				
				if( initialTocId != '') {
					$("#jstree").on('loaded.jstree', function (event, data) {
						var id = initialTocId;
						$("#jstree").jstree('select_node', '#' + id);
						while( id != '' && id !='#') {
							id = $("#jstree").jstree('get_parent', '#' + id);
							$("#jstree").jstree('open_node', '#' + id);
						}
						initialTocId = '';
					}); 
				}
				
				$('#jstree').on("select_node.jstree", function (e, data) { 
					if(data.node.original.lev != 0) {
						window.open( "/manu/selectToc.face?tocId=" + data.node.id, "tocFrame")
					} 
				}).on('loaded.jstree', function (event, data) {
					$("#jstree").jstree('open_all');
				});				
				
			},
			error : function ( xhr, status, error) {
				alert('데이터 전송오류 ' + status + ", " + error );
			}
			
		});	
	}
	
	function iframe_autoresize(arg) {
		try {
			var frameDocument = (arg.contentWindow || arg.contentDocument).document == undefined ? (arg.contentWindow || arg.contentDocument).documentElement : (arg.contentWindow || arg.contentDocument).document; 
			var ht = $(frameDocument.body).height(); 
			var minHeight = 600;
			if (ht < minHeight) {
				ht = minHeight;
			}
			arg.height = 0;
			arg.height = ht+20;
		} catch(e) {
		}
	}
	
</script>

<script>
/*
$(function(){
	var ht = $(window).height() - 370;
	if( ht < 550) ht = 550;
	$("#jstree").css("height", ht);
	$("#tocFrame").css("height", ht+50);

});
$(window).resize(function() {
	var ht = $(window).height() - 370;
	if( ht < 550) ht = 550;
	$("#jstree").css("height", ht);
	$("#tocFrame").css("height", ht+50);
});
*/
</script>
	
</head>

<body class="">

	<div class="sub_container" id="print">
		<!-- content start -->
		<div id="content">
			<div class="board_search">
				<form id="manuList_searchForm" name="searchForm"  action="/manu/selectTocList.face" method="post"  target="tocFrame">
					<fieldset class="fl">
						<legend>게시물 검색</legend>
						<select name="mdId"  id="manuList_manuId" >
						<option value="" >전체</option>  
						<c:forEach items="${mdList}" var="md">
						<option value="${md.mdId}" ${md.mdId==param.mdId ? 'checked' : ''}><c:out value="${md.mdNm}"/></option>  
						</c:forEach>
						</select>									
						<label for="nmList_searchKey" class="hide">검색어입력</label><input class="w200" type="text" id="nmList_searchKey" name="searchKey"  placeholder="검색어입력" maxlength="" />
						<a href="javascript:void(0);" class="btn_white" id="manuList_searchButton"><span class="icon_search"></span>검색</a>
					</fieldset>
				</form>
				<div class="board_btn_R">
					<a href="#" class="btn_black">통합업무매뉴얼 사용법</a>
				</div>
			</div>
			<div class="work_wrap">
				<div class="w_p25 fl work_left">
					<div class="fr tm10 bm10">
						<a href="#" class="btn_white" onclick="$('#jstree').jstree('open_all');" > 모두 펼치기  </a>
						<a href="#" class="btn_white" onclick="$('#jstree').jstree('close_all');" > 모두 닫기 </a>
					</div>
					<div class="helper_search_wrap tm40" >
						<div id="jstree">
						</div>
					</div>
				</div>

				<div class="w_p73 fr">
				<c:if test="${empty param.tocId}">
				<iframe id="tocFrame" name="tocFrame" src="/manu/selectTocList.face" width="100%" height="100%" frameborder="0" onload="iframe_autoresize(this)"></iframe>
				</c:if>
				<c:if test="${not empty param.tocId}">
				<iframe id="tocFrame" name="tocFrame" src="/manu/selectToc.face?tocId=<c:out value="${param.tocId}" />" width="100%" height="100%" frameborder="0" onload="iframe_autoresize(this)"></iframe>
				</c:if>
				</div>
			</div>
		</div>
	</div>
		
</body>
</html>
