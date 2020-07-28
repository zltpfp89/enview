<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Iterator" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%
	request.setAttribute("cPath", request.getContextPath());
%>

<html>
	<head>
		<title>서식관리</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />		
		<meta http-equiv="Content-style-type" content="text/css" />	
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb//css/sjpb_custom.css" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/javascript/jstree/themes/default/style.min.css" />           
		<script type="text/javascript" src="${pageContext.request.contextPath}/javascript/jstree/jstree.min.js" ></script>
		
		<script type="text/javascript">
		

			function isDefined(str)	{				
			    var isResult = false;
			    var str_temp = str + "";
			    str_temp = str_temp.replace(" ", "");
			    
			    if(str_temp != "undefined" && str_temp != "" && str_temp != "null")
			    {
			        isResult = true;
			    }
			     
			    return isResult;
			}
	
			function fn_drawTree(text) {
				var param = !isDefined(text) ? {} : { text : text};
				
				$("#docManagerTree").jstree('destroy');
				$('#docManagerTree').jstree({
					'core' : {
						'data' : {
							"url" : "${cPath }/sjpb/Z/selectDocManagerTree.face?viewType="+viewType,
							"dataType" : "json",
							"type" : "post",
							"data" : param
						},
						"multiple" : false,
						"animation" : 0,
						"check_callback" : true
					},"search": {
			            "case_insensitive": true,
			            "show_only_matches" : true
			        },
				    "plugins": ["search"]
			        
				}).on("select_node.jstree", function (e, data) {	
					
					if ($('#docManagerTree').jstree().get_selected(true)[0].children == 0) {
						$("#docIframe").attr("src", $('#docManagerTree').jstree().get_selected(true)[0].original.url);
						$(".treebtnArea .tree").hide();
					} 
										
				}).on('loaded.jstree', function (event, data) {
					$("#docManagerTree").jstree('open_all');
				});
			}
			
			function fn_searchTree() {				
				if ($("#text").val() == null || $("#text").val() == "") {
					alert("서식명을 입력하십시오.");
					return;
				}
				 $('#docManagerTree').jstree('search', $("#text").val());
			}
		   	$(document).ready(function () {
		   		fn_drawTree();
		   	  	$("#text").keyup(function() {
		   	  		var searchString = $(this).val();
		           $('#docManagerTree').jstree('search', searchString);
		     	 });
		   	  	
		   	 $(".treebtnArea .tree").show();
		  
		   	});

		   	//사건에서 호출하는지 여부, 
		   	// 'inc': 사건에서 호출, 
		   	//	1) 신규, 삭제버튼 활성화, 
		   	//	2) 본인 해당만 리스트
		   	//	3) 검색조건 숨김
		   	//
		   	// 'mng' : 수사지원업무에서 호출, 신규, 삭제버튼 비활성화, 전체 리스트, 검색조건 노출
		   	//	1) 신규, 삭제버튼 숨김, 
		   	//	2) 전체 리스트
		   	//	3) 검색조건 노출
		   	var viewType = 'mng';
		   	
		   	function autoParentResize(arg) {	
			   	arg.style.height =0;
			   	var contentHeight = arg.contentWindow.document.documentElement.scrollHeight;
			   	contentHeight = (contentHeight +100);
				arg.style.height = contentHeight+ "px";
			    //사건에서 호출할경우
			    if(parent.location.pathname == '/sjpb/B/B0101.face'){
			    	parent.setDocHeight(contentHeight);
			    	viewType = 'inc';
			    }else{
			    	parent.iframe_setHeightResize(this,contentHeight);
			    	viewType = 'mng';
			    }
		   	}

		   </script>		
			             
	</head>
	<body class="iframe">
	
	<form name="contentsFormData" id="contentsFormData">
		<input type="hidden" id="userId" name="userId" value="${userInfo.userId}" />   <!-- 사용자계정 -->
		<input type="hidden" id="userName" name="userName" value="${userInfo.userName}" />  <!-- 사용자이름 -->
		<input type="hidden" id="orgCd" name="orgCd" value="${userInfo.orgCd}" />   <!-- 수사팀코드 -->	
		<input type="hidden" id="today" name="today" value="${stsGrapFillDtToSC}" />  <!-- 오늘날짜 -->	
		
        <div class="formatArea">
        
        	<div class="treebtnArea" id="treebtnArea">
				<a href="#" class="treebtn"><span id="docTreeBtnSapn">문서서식 열기/닫기</span></a>
				<div class="tree">
				
					<%-- <p class="subtitle">문서서식</p> --%>
			        <form method="post" id="deptSearchForm">
			        <p class="searchinput">
						<input type="text" name="dummy" value="" style="display: none;" /> 
			           	<label for="text "></label>
			           	<input type="text" class="popup_w100per" id="text" name="text" placeholder="서식검색" value="<c:out value="${param.searchValue}" />" onkeydown="if(event.keyCode==13){fn_searchTree();}" />
			           	<a class="popup_btn_search" href="javascript:fn_searchTree();" ><img src="${pageContext.request.contextPath}/sjpb/images/btn_search.png" alt="search" /></a>
			        </p>
			        </form>
			        <div id="docManagerTree" class="part"> 
			        </div>
				
				</div>
			</div>
        
            <iframe id="docIframe" src="" frameborder="0" width="100%" scrolling="no" onload="javascript:autoParentResize(this);">
            </iframe>

		</div>

</form>
</body>

<script type="text/javascript">
//전체수사팀 맵
var tmMap = new Map();
<c:forEach items="${criTmList}" var="item" varStatus="status">
	tmMap.put('${item.criTmId}', '${item.criTmNm}');
</c:forEach>

</script>	

</html>

    	