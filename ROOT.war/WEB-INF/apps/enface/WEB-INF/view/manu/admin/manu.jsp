<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@page import="com.saltware.enview.Enview"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%-- <%@ taglib prefix="manu" uri="/WEB-INF/tld/manu.tld" %> --%>
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
	<%@include file="/common/common/commonScriptInclude.jsp" %>	
		
	<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery.serializeObject.js"></script>
	
	<%-- 자원예약용 --%>
	<script type="text/javascript" src="${cPath }/common/js/resource.js"></script>
	

	<script type="text/javascript" src="${cPath}/javascript/jstree/jstree.js"></script>
	<link rel="stylesheet" href="${cPath}/javascript/jstree/themes/default/style.min.css" />

	<script type="text/javascript" >

	$(document).ready(function(){
		fn_searchTocTree();
		
		$("#manuList_manuId").change( function() {
			fn_search();
		});
		
		$("#nmList_searchKey").keydown( function( key) {
            if(key.keyCode == '13') fn_search();
		});
		
		$("#manuList_searchButton").click( function() {
			fn_search();
		});
		
		//2016.05.20 김승식 : DOM Ready 시, 스크롤 top 
		try
		{
			parent.document.documentElement.scrollTop = 0;
		}
		catch(e)
		{}
		
		//2016.05.20 김승식 : iframe Road 시, resize 
// 		$("#tocFrame").load(function() 
// 		{
// 			this.style.height = parseInt(this.contentWindow.document.body.scrollHeight) + 250 + 'px';
// 			var doc = this.style.height;
// 			if(parseInt(doc) < parseInt("640"))
// 			{
// 				doc = 640;
// 			}
// 			alert("doc = " + doc );
// 		    parent.document.getElementById(window.name).style.height = parseInt(doc)+"px";
			
// 		});
	});
	 
	function fn_search() {
		fn_searchTocList();
		fn_searchTocTree();
	}
	
	function fn_mdList() {
		location.href="${cPath}/manu/admin/selectMdList.face";
	}
	
	function fn_mdDelete(mdId) {
		if (confirm("정말 삭제하시겠습니까?") == true){    //확인
			location.href="${cPath}/manu/admin/deleteMd.face?mdId="+mdId;
		}else{   //취소
		    return;
		}
	}
	
	function fn_searchTocTree() {
		var formData = { mdId : '${md.mdId}'};
		 
		var url = '/manu/selectTocTree.face';
		$.ajax( {
			url : url,
			type : "post",
			data : formData,
			success : function( data) {
//				alert( JSON.stringify( data));
			    $("#tocTree").jstree('destroy');				
				$("#tocTree").jstree({ 
					'core' : {
				    	'data' : data
					}
				});
				
				$("#tocTree").on('loaded.jstree', function (event, data) {
//					$("#tocTree").jstree('open_all');
					$("#tocTree").jstree('open_node', '#${md.mdId}');
				}); 
				
				$('#tocTree').on("select_node.jstree", function (e, data) { 
					if(data.node.original.lev == 0) {
						window.open( "/manu/admin/selectTocList.face?mdId=" + data.node.id, "tocFrame")
					} else {
						window.open( "/manu/admin/selectTocList.face?upTocId=" + data.node.id, "tocFrame")
					} 
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
	
	
// 	function iframe_autoresize(arg) {
// 		try {
// 			var frameDocument = (arg.contentWindow || arg.contentDocument).document == undefined ? (arg.contentWindow || arg.contentDocument).documentElement : (arg.contentWindow || arg.contentDocument).document; 
// 			var ht = $(frameDocument.body).height(); 
// 			var minHeight = 1024;
// 			if (ht < minHeight) {
// 				ht = minHeight;
// 			}
// 			arg.height = 0;
// 			arg.height = ht;
// 		} catch(e) {
// 		}
// 	}
	
// 	function autoresize_iframe_portlets() {
// 		var iframes = document.getElementsByTagName("iframe");
// 		for( var i =0; i < iframes.length;i++ ) {
// 			iframe_autoresize( iframes[i]);
// 		}
// 		try {
// 			if( parent != null && parent.autoresize_iframe_portlets != null) {
// 				parent.autoresize_iframe_portlets(); 
// 			}
// 		}catch(e) {}
// 	}
	
	
// 	function fn_autoresize_iframe_portlets(i) 
// 	{
// 		var iframeHeight= (i).contentWindow.document.body.scrollHeight;
// 	    (i).height=iframeHeight+20;
// 	}
</script>

<script>
/*
$(function(){
	var ht = $(window).height() - 370;
	if( ht < 550) ht = 550;
	$("#tocTree").css("height", ht);
	$("#tocFrame").css("height", ht+50);

});
$(window).resize(function() {
	var ht = $(window).height() - 370;
	if( ht < 550) ht = 550;
	$("#tocTree").css("height", ht);
	$("#tocFrame").css("height", ht+50);
});
*/
</script>
	
</head>

<body class="">

	<div class="sub_container" id="print">
		<!-- content start -->
		<div id="content">
			<table class="basic_table_write " summary="매뉴얼관리 제목,">
				<caption>매뉴얼관리</caption>
				<colgroup>
					<col style="width:120px" />
					<col style="width:auto" />
				</colgroup>
				
				<tbody>
					<form id="editForm" name="editForm" method="post" action="" >
					<tr>
						<th class="">
							<label for="mdDetail_mdId"><span class="essentia">*</span> 모듈ID</label>
						</th>
						<td>
							<c:out value="${md.mdId}" />
						</td>
					</tr>
					<tr>
						<th class="">
							<label for="mdDetail_mdId"><span class="essentia">*</span> 모듈명칭</label>
						</th>
						<td>
							<c:out value="${md.mdNm}" />
						</td>
					</tr>
				</tbody>
			</table>
			<div class="tm20"></div>
			<div class="board_search">
				<div class="board_btn_R">
					<a href="javascript:fn_mdList()" class="btn_white">모듈목록</a>
				</div>
				<div class="board_btn_R">
					<a href="${pageContext.request.contextPath}/manu/selectManuList.face" class="btn_black">수사분야/유형별 샘플 화면 가기</a>
					<a href="javascript:fn_mdDelete('${md.mdId}')" class="btn_white">모듈삭제</a>
				</div>
			</div>
			
			
			<div class="work_wrap">
				<div class="w_p25 fl work_left">
					<div class="fr tm10 bm10">
						<a href="#" class="btn_white" onclick="$('#tocTree').jstree('open_all');" > 모두 펼치기  </a>
						<a href="#" class="btn_white" onclick="$('#tocTree').jstree('close_all');" > 모두 닫기 </a>
					</div>
					<div class="helper_search_wrap tm40" >
						<div id="tocTree">
						</div>
					</div>
				</div>

				<div class="w_p73 fr">
<%-- 				<iframe id="tocFrame" name="tocFrame" src="/manu/admin/selectTocList.face?mdId=${md.mdId}" width="100%" height="100%" frameborder="0" scrolling="no" onload="autoresize_iframe_portlets();"></iframe> --%>
				<iframe id="tocFrame" name="tocFrame" src="/manu/admin/selectTocList.face?mdId=${md.mdId}" width="100%" frameborder="0" scrolling="no"></iframe>
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
