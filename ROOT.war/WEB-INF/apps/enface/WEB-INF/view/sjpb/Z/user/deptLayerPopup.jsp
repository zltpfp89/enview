<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	request.setAttribute("cPath", request.getContextPath());
%>

<script type="text/javascript" src="${cPath}/sjpb/js/Z/jquery.js" ></script>
<script type="text/javascript" src="${cPath}/sjpb/js/Z/jquery-ui-1.10.3.js" ></script>
<script type="text/javascript" src="${cPath}/sjpb/js/Z/common.js" ></script>
<script type="text/javascript" src="${cPath}/sjpb/js/Z/main.js" ></script>
<script type="text/javascript" src="${cPath }/javascript/jstree/jstree.min.js" ></script>		
		
<link rel="stylesheet" type="text/css" href="${cPath}/sjpb//css/popup.css" />
<link rel="stylesheet" type="text/css" href="${cPath}/sjpb//css/contents.css" />
<link rel="stylesheet" type="text/css" href="${cPath}/sjpb//css/sjpb_custom.css" />
<link rel="stylesheet" href="${cPath }/javascript/jstree/themes/default/style.min.css" />
		
	</head>
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
		
		
			<c:if test="${empty param.chkType || param.chkType eq 'checkbox' }">
			function fn_drawTree(text) {
				var param = !isDefined(text) ? {} : { text : text};
				
				$("#deptTree").jstree('destroy');
				$('#deptTree').jstree({
					'core' : {
						'data' : {
							"url" : "${cPath }/sjpb/Z/selectDeptTree.face",
							"dataType" : "json",
							"type" : "post",
							"data" : param
						},
						"multiple" : false,
						"animation" : 0,
						"check_callback" : true
					},
					"checkbox" : {
						"keep_selected_style" : true,
						"three_state" : $("#setThree_state").prop("checked")
				    },
				    "search": {

			            "case_insensitive": true,
			            "show_only_matches" : true
			        },
				    "plugins": ["search","checkbox"]
				}).on('loaded.jstree', function (event, data) {
					$("#deptTree").jstree('open_all');
				});
			}
			</c:if>
			<c:if test="${param.chkType eq 'radio' }">
			function fn_drawTree(text) {
				var param = !isDefined(text) ? {} : { text : text};
				
				$("#deptTree").jstree('destroy');
				$('#deptTree').jstree({
					'core' : {
						'data' : {
							"url" : "${cPath }/sjpb/Z/selectDeptTree.face",
							"dataType" : "json",
							"type" : "post",
							"data" : param
						},
						"multiple" : false,
						"animation" : 0,
						"check_callback" : true
					},"radio" : {
						"keep_selected_style" : false,
						"three_state" : $("#setThree_state").prop("checked")
				    },
					"plugins" : [ "radio" ]
				}).on('loaded.jstree', function (event, data) {
					$("#deptTree").jstree('open_all');
				});
			}
			</c:if>
			function fn_searchTree() {
				if ($("#text").val() == null || $("#text").val() == "") {
					alert("부서명을 입력하십시오.");
					return;
				}
				 $('#deptTree').jstree('search', $("#text").val());
			}
		   	$(document).ready(function () {
		   		fn_drawTree();
		   	  	$("#text").keyup(function() {
		   	  		var searchString = $(this).val();
		            $('#deptTree').jstree('search', searchString);
		     	 });
		   	});

		   </script>
	<div class="popup">
	    <h2><span>부서 지정</span></h2>
	    <div class="content_wrap">
	    <!-- pop content-->
	        <p class="subtitle">조직도</p>
	        <form method="post" id="deptSearchForm">
	        <p class="searchinput">
				<input type="text" name="dummy" value="" style="display: none;" /> 
	           	<label for="text "></label>
	           	<input type="text" class="popup_w100per" id="text" name="text" placeholder="부서검색" value="${param.searchValue }" onkeydown="if(event.keyCode==13){fn_searchTree();}" />
	           	<a class="popup_btn_search" href="javascript:fn_searchTree();" ><img src="${pageContext.request.contextPath}/sjpb/images/btn_search.png" alt="search" /></a>
	        </p>
	        </form>
	        <div id="deptTree" class="part scroll"> 
	        </div>
	        <div class="btnArea pop_back">
	            <div class="r_btn"><a href="#" class="btn_light_blue save"><span>확 인</span></a><a href="#" class="btn_light_blue_line appointed"><span>닫 기</span></a></div>
	        </div>        
	    </div>
	    <!-- //pop content-->
	    <a href="#"><img class="btn_close" src="${pageContext.request.contextPath}/sjpb/images/popup_close.png" alt="닫기" /></a>
	</div>
