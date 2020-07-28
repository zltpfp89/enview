<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Iterator" %>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%
	request.setAttribute("cPath", request.getContextPath());
%>

<html>
	<head>
		<title>조직관리</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />		
		<meta http-equiv="Content-style-type" content="text/css" />	
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb//css/sjpb_custom.css" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/javascript/jstree/themes/default/style.min.css" />			
		<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/Z/jquery.base64.js"></script>			
        <script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/L/L0104.js?r=<%=Math.random()%>"></script>   
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
					},"search": {
			            "case_insensitive": true,
			            "show_only_matches" : true
			        },
				    "plugins": ["search"]
				}).on("select_node.jstree", function (e, data) {	
					
					if ($('#deptTree').jstree().get_selected(true)[0].children == 0) {
				   		//l0104SCMap.pareTmIdSC = $('#deptTree').jstree().get_selected(true)[0].parent
				   		l0104SCMap.pareTmIdSC = ""	
				   		l0104SCMap.criTmIdSC = $('#deptTree').jstree(true).get_selected()[0];
					} else {				
				   		l0104SCMap.pareTmIdSC = $('#deptTree').jstree(true).get_selected()[0];	
				   		l0104SCMap.criTmIdSC = "";
					}					
					if (searchFlag) {
						selectCriTmMngList();	
					}
					
				}).on('loaded.jstree', function (event, data) {
					$("#deptTree").jstree('open_all');
				});
			}
			
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
			             
	</head>
	<body class="iframe">
	
	<form name="contentsFormData" id="contentsFormData">
		<input type="hidden" id="userId" name="userId" value="${userInfo.userId}" />   <!-- 사용자계정 -->
		<input type="hidden" id="userName" name="userName" value="${userInfo.userName}" />  <!-- 사용자이름 -->
		<input type="hidden" id="orgCd" name="orgCd" value="${userInfo.orgCd}" />   <!-- 수사팀코드 -->	
		<input type="hidden" id="today" name="today" value="${stsGrapFillDtToSC}" />  <!-- 오늘날짜 -->	
		
        <div class="formatArea">
            <!-- leftArea -->
            <div class="leftArea w25per">
                <div class="left_box mar_0">
			        <p class="subtitle">조직도</p>
			        <form method="post" id="deptSearchForm">
			        <p class="searchinput">
						<input type="text" name="dummy" value="" style="display: none;" /> 
			           	<label for="text "></label>
			           	<input type="text" class="popup_w100per" id="text" name="text" placeholder="부서검색" value="<c:out value="${param.searchValue}" />" onkeydown="if(event.keyCode==13){fn_searchTree();}" />
			           	<a class="popup_btn_search" href="javascript:fn_searchTree();" ><img src="${pageContext.request.contextPath}/sjpb/images/btn_search.png" alt="search" /></a>
			        </p>
			        </form>
			        <div id="deptTree" class="part"> 
			        </div>
                </div>
            </div>
            <!-- leftArea //-->
            
            <div class="rightArea w75per">
                            
                <div class="sub_listArea searchArea">
				   <ul>
						<li><span class="title">부서이름</span>
						   <label for="criTmNmSC"></label><input type="text" class="w100per" id="criTmNmSC" name="criTmNmSC" />
					   </li>				   
					   <li><span class="title">사건분야</span>
						   <div class="inputbox w65per">
							   <p class="txt"></p>
							       <select id="fdCdSC" name="fdCdSC">
										<option value="">전체</option>
										<c:forEach items="${fdKndList}" var="fd" varStatus="status">
											<option value="${fd.code}">${fd.codeName}</option>
										</c:forEach>
								   </select> 
						   </div>
					   </li>
					   
						<li><span class="title">상태</span>
						   <div class="inputbox w65per">
							   <p class="txt"></p>
							   <select id="criMbStatSC" name="criMbStatSC">
								   <option value="">전체</option>	
									<c:forEach items="${criMbStatList}" var="item">
									   <option value="${item.code}">${item.codeName}</option>
									</c:forEach>                                                   		
							   </select>
						   </div>
					   </li>
				   </ul>
					<div class="searchbtn">
						<a href="#" class="btn_white" id="srchBtn"><span>검색</span></a>
						<a href="#" class="btn_blue" id="initBtn"><span>초기화</span></a>
					</div>                
                </div>
                <div class="list" id="sheet" style="height: 280px; width: 100%">                
                </div>
                <!-- btnArea -->
                <div class="btnArea">
                    <div class="r_btn"></a><a href="#" class="btn_blue" id="addBtn"><span>신규</span></a></div>
                </div>
        	    <!-- btnArea //-->
                <div class="tab_mini_wrap m1">
                    <ul>
                        <li class="m1"><a href="#" class="tabtitle" id="criTmDtsTab"><span>상세정보</span></a>
                            <div class="tab_mini_contents">
                            	<div class="list">
                                    <table class="list" cellpadding="0" cellspacing="0">
                                        <caption>게시판쓰기</caption>
                                        <colgroup>
                                            <col width="10%" />
                                            <col width="35%" />
                                            <col width="10%" />
                                            <col width="18%" />
											<col width="10%" />
                                            <col width="*%" />
                                        </colgroup>
                                        <tr>
                                        	<th class="C th_line">부서코드</th>
                                            <td class="L td_line" colspan="2">
                                               <input type="text" class="w100per" name="criTmId" id="criTmId" data-type="number" title="부서코드" readonly=true /> <label for="criTmId"></label>
                                            </td>
											<th class="C th_line">이름  <em class="red">*</em></th>
                                            <td class="L td_line" colspan="2">
                                               <input type="text" class="w100per" name="criTmNm" id="criTmNm" data-type="name"  title="이름" /> <label for="criTmNm"></label>
                                            </td>
										</tr>
										<tr>
											<th class="C th_line">상위부서  <em class="red">*</em></th>
                                            <td class="L td_line">
                                               <div class="inputbox w100per">
													<p class="txt"></p>
												   <select id="pareTmId" name="pareTmId" data-type="select"  title="상위부서">
												   		<option value="">선택</option>																		
				                                   </select>
												</div>
                                            </td>
											<th class="C th_line">사용여부</th>
                                            <td class="L td_line">
                                               <div class="inputbox w100per">
													<p class="txt"></p>
												   <select id="criTmStat" name="criTmStat" data-type="select" title="사용여부">
												   		<option value="1">활성화</option>
														<option value="0">비활성화</option>  
				                                   </select>
												</div>
                                            </td>
											<th class="C th_line">정렬순서</th>
                                            <td class="L td_line">
                                               <input type="text" class="w100per" name="sortOrd" id="sortOrd" data-type="number" maxlength="5" title="정렬순서" /> <label for="order"></label>
                                            </td>
                                        </tr>
                                        <tr>
                                        	<th class="C th_line">시용기간</th>
                                            <td class="L td_line">
                                               <input type="text" id="beDt" name="beDt" class="w45per calendar datepicker" readonly/> <label for="beDt"></label>~
                                               <input type="text" id="edDt" name="edDt" class="w45per calendar datepicker" readonly/> <label for="edDt"></label>
                                            </td>
                                            <th class="C th_line">부서구분</th>
                                            <td class="L td_line">
                                               <div class="inputbox w100per">
													<p class="txt"></p>
												   <select id="criTmDiv" name="criTmDiv" data-type="select" title="사용여부">
												   		<option value="G">과</option>
														<option value="T">팀</option>  
				                                   </select>
												</div>
                                            </td>
											<th class="C th_line">수사여부  <em class="red">*</em></th>
                                            <td class="L td_line" >
                                               <div class="inputbox w100per">
													<p class="txt"></p>
												   <select id="criYn" name="criYn" data-type="select" title="사용여부">
												   		<option value="1">활성화</option>
														<option value="0">비활성화</option>  
				                                   </select>
												</div>
                                            </td>
										</tr>                                        
                                    </table>
                                </div>
                                <!-- btnArea -->
                                <div class="btnArea">
                                    <div class="r_btn"><a href="#" class="btn_blue" id="saveDtsBtn"><span>저장</span></a></div>
                                </div>
                                <!-- btnArea //-->
                            </div>
                        </li>
                        <li class="m2"><a href="#" class="tabtitle" id="criFdCdTab"><span>분야</span></a>
                            <div class="tab_mini_contents">
                        		<div class="list">
                                    <table class="list" cellpadding="0" cellspacing="0">
                                        <caption>게시판쓰기</caption>
                                        <colgroup>
                                            <col width="12%" />
                                            <col width="10%" />
                                            <col width="10%" />
                                            <col width="10%" />
                                            <col width="10%" />
                                            <col width="10%" />
                                            <col width="10%" />
                                        </colgroup>
                                        
                                        <tr>
                                        	<th class="C th_line" rowspan="${rowSpanSize}">분야</th>
                                            <c:forEach items="${fdKndList}" var="fd" varStatus="status">
											  <td class="L td_line">
                                                <label for="fdCd_${fd.code}"></label><input type="checkbox" name="fdCd" id="fdCd_${fd.code}" value="${fd.code}" data-code-tag1="${fd.codeTag1}" data-code-name="${fd.codeName}" /><span class="l_margin">${fd.codeName}</span>
                                              </td>                                              
                                              <c:if test="${status.count % 6 == 0}">
                                                </tr>
                                        		<tr>
                                              </c:if>                                              
											<c:if test="${status.last}">
												<c:forEach var="j" begin="1" end="${otherTdSize}" step="1">			
	    										<td class="L td_line"></td>  
	   											</c:forEach>
                                        	</c:if>																			
										</c:forEach>                                                        			 
                                        </tr>
                                    </table>
                                </div>
                                <!-- btnArea -->
                                <div class="btnArea">
                                    <div class="r_btn"><a href="#" class="btn_blue" id="saveFdCdBtn"><span>저장</span></a></div>
                                </div>
                                <!-- btnArea //-->
                            </div>
                        </li>
                    </ul>
                </div>
            
            
        </div>
      

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

    	