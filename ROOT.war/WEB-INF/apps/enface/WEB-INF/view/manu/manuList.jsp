<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@page import="com.saltware.enview.Enview"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ taglib prefix="manu" uri="/WEB-INF/tld/manu.tld" %>
<%
request.setAttribute( "isManuManager", (EnviewSSOManager.getUserInfo(request)).getHasRole("ROLE_MNG_MD"));
%>
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
		
		/*
		$("#nmList_searchKey").keydown( function( key) {
            if(key.keyCode == '13') fn_search();
		});
		*/
		
		$("#manuList_searchButton").click( function() {
			var searchString = $("#nmList_searchKey").val();
            $('#jstree').jstree('search', searchString);
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
						if(data.node.original.ctgy_yn != 'Y') {
							window.open( "/manu/selectToc.face?tocId=" + data.node.id, "tocFrame")
						}else window.open( "/manu/newSelectTocList.face?upTocId=" + data.node.id, "tocFrame") 
					}else   window.open( "/manu/newSelectTocList.face?mdId="+ data.node.original.md_id, "tocFrame")  
				}).on('loaded.jstree', function (event, data) {
					$("#jstree").jstree('open_all');
				});			
				
			},
			error : function ( xhr, status, error) {
				alert('데이터 전송오류 ' + status + ", " + error );
			}
			
		});	
	}
	
var prevMode = '';
	
	function fn_selectTocPopup( mode, callback	)  {
		var title='목차 선택';
		if( mode=='bf') {
			title = '선행업무 선택';
		} else if( mode=='af') {
			title = '선행업무 선택';
		} else if( mode=='move') {
			title = '이동할 위치 선택';
		}
		if( mode=="move") {
			$("#selectTocPopup_mdId").hide();
			$("#selectTocPopup_moveTypeDiv").show();
		} else {
			$("#selectTocPopup_mdId").show();
			$("#selectTocPopup_moveTypeDiv").hide();
		}
		
		$("#selectTocPopup").dialog( {
			title : title,
			width:470,
			height:470,
			modal : true,
			buttons : [
				{ 	text : "확인", 
					class:"btn_black"  ,
					click: function() {
						var data = $('#tocSelectTree').jstree("get_selected", true);
						var ret = true;
						var moveType = $(':radio[name="moveType"]:checked').val();
						if( callback != null) {
							try {
								ret = callback( data, moveType);
							} catch(e) {
							}
						}
						if( ret==true) {
							$("#selectTocPopup").dialog("close");
						}
					}
				},
				{ 	text : "취소", 
					class:"btn_orange",  
					click: function() { $("#selectTocPopup").dialog("close");}
				}
			]	
	    }); // dialog
	    if( mode != prevMode || mode=='move') {
	    	prevMode = mode;
	    	fn_selectTocSelectTree( mode);
	    }
	}
	
	function fn_selectTocSelectTree( mode) {
		var formData = {};
		if( mode != 'move') {
			var mdId = $("#selectTocPopup_mdId").val();
			formData = { mdId : mdId};
		}
		
	    $("#tocSelectTree").jstree('destroy');
	    $("#tocSelectTree").text("조회중입니다...");
	    
		var url = '/manu/selectTocTree.face';
		$.ajax( {
			url : url,
			type : "post",
			data : formData,
			success : function( data) {
				$("#tocSelectTree").jstree({ 
					'core' : {
				    	'data' : data
					}
				});
				
				$("#tocSelectTree").on('loaded.jstree', function (event, data) {
//					$("#tocTree").jstree('open_all');
					$("#tocSelectTree").jstree('open_node', '#' + mdId);
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
			/* var ht =  arg.contentWindow.document.body.scrollHeight; */
			var minHeight = 600;
			if (ht < minHeight) {
				ht = minHeight;
			}
			arg.height = 0;
			ht =  ht+50;
			//arg.style.height =ht;
			//parent.iframe_setHeightResize(this,ht);
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
					<c:if test="${isManuManager}">
					<a href="${pageContext.request.contextPath}/manu/admin/selectMdList.face" class="btn_black">샘플 관리</a>
					</c:if>
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
				<iframe id="tocFrame" name="tocFrame" src="/manu/newSelectTocList.face" width="100%" height="100%" frameborder="0" onload="iframe_autoresize(this)"></iframe>
				</c:if>
				<c:if test="${not empty param.tocId}">
				<iframe id="tocFrame" name="tocFrame" src="/manu/selectToc.face?tocId=<c:out value="${param.tocId}" />" width="100%" height="100%" frameborder="0" onload="iframe_autoresize(this)"></iframe>
				</c:if>
				</div>
			</div>
		</div>
	</div>
	
	<style>
	.tree_box{background:#fff; border:1px solid #b6b6b6; box-sizing:border-box; width:100%; height:300px;  overflow-y:auto; margin-bottom:10px;}
	</style>
	<div id="selectTocPopup" class="layerpopup_gray none">
		<div class="layerpopup_top">
			<div class="layerpopup_search" style="vertical-align: middle;">
				<label for="selectTocPopup_mdId" class="hide">검색</label>
				<select name="mdId"  id="selectTocPopup_mdId"  onchange="fn_selectTocSelectTree();">
				<c:forEach items="${mdList}" var="md">
				<option value="${md.mdId}" ${md.mdId==param.mdId ? 'checked' : ''}><c:out value="${md.mdNm}"/></option>  
				</c:forEach>
				</select>
				<span id="selectTocPopup_moveTypeDiv" class="none">
				<input type="radio" style="width:auto" id="selectTocPopup_moveType1" name="moveType" value="E" checked="checked"/><label for="selectTocPopup_moveType1"> 동일레벨</label>	
				<input type="radio" style="width:auto" id="selectTocPopup_moveType2" name="moveType" value="S"/><label for="selectTocPopup_moveType2"> 하위레벨</label>
				</span>	
			</div>
		</div>
		<div class="layerpopup_white">      
			<div class="tree_box">
				<div id="tocSelectTree" ></div>
			</div>
		</div>	
	</div>
		
</body>
</html>

