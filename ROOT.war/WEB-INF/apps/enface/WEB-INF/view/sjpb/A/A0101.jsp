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
		<title>사건관리</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-style-type" content="text/css" />
		<link rel="stylesheet" type="text/css" href="${cPath}/sjpb//css/sjpb_custom.css" />
		<link rel="stylesheet" type="text/css" href="${cPath}/javascript/jstree/themes/default/style.min.css" />
				
		<script type="text/javascript" src="${cPath}/sjpb/js/Z/jquery.base64.js"></script>		
		<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
        <script type="text/javascript" src="${cPath}/sjpb/js/A/A0101.js?r=<%=Math.random()%>"></script>
        
		<script type="text/javascript" src="${pageContext.request.contextPath}/javascript/jstree/jstree.min.js" ></script>		
		<script type="text/javascript">
		
			var initRcptNumTmp = "${rcptNum}";	//진입시 선택할 rcptNum 정보
		    
			var uploadInitFlag = false;  //vaultUploader 업로드 호출 여부 플래그
			function initEditActionManager() {
				if(uploadInitFlag == false){
					uploadInitFlag = sjpbFile.init(); //vaultUploader 업로드 호출이 안되어있을시에만 업로드 모듈 초기화
				}
			}
	
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
							"url" : "${cPath }/sjpb/Z/selectDocTree.face",
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
				   		
				   		$("#tpltFileTp").html($('#deptTree').jstree().get_selected(true)[0].original.text);
				   		$("#tpltFileNm").html($('#deptTree').jstree().get_selected(true)[0].original.title);
				   		$("#tpltFileLk1,#tpltFileLk2").attr("href", $('#deptTree').jstree().get_selected(true)[0].original.url);
				   		
				   		$("#tpltTD").show();				   		
					} else {
						$("#tpltTD").hide();
					}
										
				}).on('loaded.jstree', function (event, data) {
					$("#deptTree").jstree('open_all');
				});
			}
			
			function fn_searchTree() {				
				if ($("#text").val() == null || $("#text").val() == "") {
					alert("서식명을 입력하십시오.");
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
		<!-- wrap -->
			<!-- report -->
			<form name="reportForm" method="post">
				<input type="hidden" id="reptNm" name="reptNm" value="" />
				<input type="hidden" id="xmlData" name="xmlData" value="" />
			</form>
			
			<!-- 피의자 이력 비교 팝업 -->
			<form id="spHistPopForm" name="spHistPopForm">
				<input type="hidden" id="incMfNum" name="incMfNum" value="" />	<!-- 사건수정번호 -->	  
				<input type="hidden" id="rcptNum" name="rcptNum" value="" />	<!-- 사건접수번호 -->	 
			</form>
		
			<!-- contents -->
			<form name="contentsFormData" id="contentsFormData">
			<input type="hidden" id="userId" name="userId" value="${userInfo.userId}" />   <!-- 사용자계정 -->
			<input type="hidden" id="today" name="today" value="${beDtToSC}" />  <!-- 오늘날짜 -->
			<input type="hidden" id="rcptNum" name="rcptNum" value="" />  <!-- 선택된 내사번호 -->				
                           <div class="ocrt_01 ocrt_list_tab0 list">
                               <!-- searchArea -->
                               <div class="searchArea">
                                   <ul>
                                   		<li><span class="title">연도</span>
										   <div class="inputbox w65per">
											   <p class="txt"></p>
											   <select id="yearSc" name="yearSc">
											   		<option value="">전체</option>
											   		<c:forEach items="${yearScList}" var="year" varStatus="status">
											   			<c:choose>
											   				<c:when test="${year == yearSc && isSetCurYear}">
											   					<option value="${year}" selected="selected">${year} 년</option>
															</c:when>
															<c:otherwise>
																<option value="${year}">${year} 년</option>
															</c:otherwise> 
											   			</c:choose>
													</c:forEach>
											   </select>
										   </div>
									   </li>
									   <li><span class="title">내사번호</span>
										   <label for="intiNumSc"></label><input type="text" class="w65per" id="intiNumSc" name="intiNumSc" value="${IntiNumSc}" />
									   </li>
                                       <li><span class="title">담당팀</span>
                                           <div class="inputbox w65per">
                                               <p class="txt"></p>
                                               <select id="criTmIdSC" name="criTmIdSC">
                                                  <option value="">전체</option> 							
													<c:forEach items="${criTmList}" var="item">
													    <option value="${item.criTmId}">${item.criTmNm}</option> 
													</c:forEach>
                                               </select>
                                           </div>
                                       </li>
 									    <li><span class="title">내사상태</span>
                                           <div class="inputbox w65per">
                                               <p class="txt"></p>
                                               <select id="criStatSC" name="criStatSC">
                                                   <option value="">전체</option>
													<c:forEach items="${criStatKndList}" var="criStat" varStatus="status">
														<c:if test = "${criStat.code < 20}">
															<option value="${criStat.code}">${criStat.codeName}</option>
														</c:if>
													</c:forEach>
                                               </select>
                                           </div>
                                       </li>                                      
                                       <li><span class="title">등록일시</span>
                                           <label for="beDtFromSC"></label><input type="text" class="w30per calendar datepicker" id="beDtFromSC" name="beDtFromSC" value=""/> ~ <label for="txt_03"></label><input type="text" class="w30per calendar datepicker" id="beDtToSC" name="beDtToSC" value=""/>
                                       </li>                                      
                                       <li><span class="title">담당자</span>
                                           <label for="nmKorSC"></label><input type="text" class="w65per" id="nmKorSC" name="nmKorSC" />
                                       </li>
                                   </ul>
								<div class="searchbtn"><a href="#" class="btn_white" onclick="javascript:initSearchData();"><span>초기화</span></a><a href="#" onclick="javascript:selectIntiIncList();" class="btn_blue"><span>검색</span></a></div>
                               </div>
                               <!-- searchArea //-->
                               <!-- listArea -->
                               <div id="sheet" class="listArea area-mousewheel" style="height: 300px; width: 100%">
                               </div>
                               <!-- listArea //-->
                               <!-- btnArea -->
                               <div class="btnArea" id="criArea01" style="display:none" >
                                   <div class="r_btn"><a href="#" class="btn_white" id="newBtn"><span>신규</span></a><a href="#" class="btn_blue" onclick="javascript:prnIntiInc();"><span>출력</span></a></div>
                                   <div class="l_btn"><a href="#" class="btn_blue" id="toggleCriBtn"><span>리스트 접기</span></a></div>
                               </div>
                               <div class="btnArea" id="apprArea01" style="display:none" >
                                   <div class="r_btn"><a href="#" class="btn_blue" id="prnBtn"><span>출력</span></a></div>
                                   <div class="l_btn"><a href="#" class="btn_blue" id="toggleApprBtn"><span>리스트 접기</span></a></div>
                               </div>                               
                               <!-- btnArea //-->
                               <div class="tab_mini_wrap m1" id="contentsArea"  style="display:none;">
                               	
                                   <ul>
                                       <li class="m1"><a href="#" class="tabtitle" id="intiIncTab"><span>내사상세</span></a>
                                           <!-- tab_contents -->
                                           <div class="tab_mini_contents" id="tab_mini_m1_contents" >
                                               <div name="intiDetail">
	                                               <table class="list" cellpadding="0" cellspacing="0">
	                                                   <colgroup>
	                                                       <col width="15%" />
	                                                       <col width="35%" />
	                                                       <col width="15%" />
	                                                       <col width="35%" />
	                                                   </colgroup>
	                                                   <tbody>
	                                                       <tr>
	                                                           <th class="C">내사번호</th>
	                                                           <td class="L" id="intiNumTD"></td>
	                                                           <th class="C">등록일자</th>
	                                                           <td class="L" id="regDtTD"></td>
	                                                       </tr>
	                                                       <tr>
	                                                           <th class="C">유입구분<em class="red">*</em></th>
	                                                           <td class="L">
	                                                               <div class="inputbox w50per">
	                                                                   <p class="txt"></p>
																	   <select id="infwDiv" name="infwDiv" data-type="select" title="유입구분" data-error-message="유입구분을 선택해주세요.">
									                                       	<option value="" selected="selected">선택</option>
									                                       	<c:forEach items="${infwDivList}" var="infwDiv" varStatus="status">
																				<option value="${infwDiv.code}">${infwDiv.codeName}</option>
																			</c:forEach>
									                                   </select>
	                                                               </div>
	                                                           </td>
	                                                           <th class="C">내사분야 <em class="red">*</em></th>
	                                                           <td class="L">
	                                                               <div class="inputbox w50per">
	                                                                   <p class="txt"></p>
																	   <select id="fdCd" name="fdCd" data-type="select" title="내사분야" data-error-message="내사분야를 선택해주세요." onchange="changeFdCd()">
									                                       	<option value="" selected="selected">선택</option>
									                                       	<c:forEach items="${fdKndList}" var="fd">
																				<option value="${fd.code}" data-criTmId="${fd.criTmId}" data-criTmNm="${fd.criTmNm}">${fd.codeName}</option>
																			</c:forEach>
									                                   </select>
	                                                               </div>
	                                                           </td>                                                                                                                      
	                                                       </tr>
	                                                       <tr>
																<th class="C">수사팀 배정</th>
																<td class="L">
																	<p class="searchinput">
																		<label for="criTmNm"></label><input type="text" class="w100per" id="criTmNm" name="criTmNm" data-criTmId="" value="" disabled="true" data-always="y"/>
																	</p>
																</td>
																<th class="C">담당 수사관</th>
																<td class="L">
																	<p class="searchinput">
																		<label for="criMbNmKorMain"></label><input type="text" class="w100per" id="criMbNmKorMain" name="criMbNmKorMain" value="" data-name="criMb" data-criMbId="" disabled="true" data-always="y"/><a class="btn_search" id="criMbNmKorMainBtn" name="criMbNmKorMainBtn" href="javascript:setCriMbNmKorMain();" style="display:none;" data-always="y"><img src="/sjpb/images/btn_search.png" alt="search" /></a>
																	</p>
																</td>
														   </tr>
	      												   <tr>
	                                                           <th class="C">내사상태</th>
	                                                           <td class="L" id="criStatDesc"></td>      												   
	                                                           <th class="C">착수일자 <em class="red">*</em></th>
	                                                           <td class="L"><label for="beDt"></label><input type="text" class="w50per calendar datepicker" name="beDt" id="beDt" data-type="date" data-optional-value="false" data-error-message="착수일시를 입력해주세요." />
	                                                       </tr>
	                                                       <tr>
	                                                           <th class="C">사건번호</th>
	                                                           <td class="L" colspan="3" id="chaIncNumTD"></td>
	                                                       </tr> 
	                                                   </tbody>
	                                               </table>
                                        	   </div>
                                    		   <div id="incSpContents">   	 	 
                                               </div> 
	                                              	 
												<div name="criIncDtaDiv" style="display:none">              
                                                  <table class="list" name="criIncDtaTable" cellpadding="0" cellspacing="0" data-cri-dta-num="" data-cri-dta-catg-cd="04">
	                                                   <colgroup>
	                                                   <col width="10%" />
	                                                   <col width="15%" />
	                                                   <col width="30%" />
	                                                   <col width="15%" />
	                                                   <col width="30%" />
	                                                   </colgroup>
	                                                   <tbody>
	                                                       <tr>
	                                                           <th class="C line_right" rowspan="6">수사지휘</th>  
	                                                           <th class="C">일시</th>
	                                                           <td class="L" colspan="3">
	                                                               <label for="txt_05"></label><input type="text" data-type="date" data-optional-value="true" data-error-message="유효한 날짜를 입력해주세요."  class="w15per calendar datepicker" name="criCmdDt" id="criCmdDt" />
	                                                           </td>
	                                                       </tr>
 														   <tr>
	                                                           <th class="C">지휘내용</th>
	                                                           <td class="L" colspan="3">
	                                                               <label for="txt_05"></label><textarea name="criCmdCont" rows="3" cols="120"></textarea>
	                                                           </td>
	                                                       </tr>
	                                             	   </tbody>
	                                              	 </table> 
                                              	</div> 
	                                              	 
	                                              	 
												<div name="criIncDtaDiv" style="display:none">                                    			
	                                  	                                               
                                                   <table class="list" name="criIncDtaTable" cellpadding="0" cellspacing="0" data-cri-dta-num="" data-cri-dta-catg-cd="05">
	                                                   <colgroup>
	                                                   <col width="10%" />
	                                                   <col width="15%" />
	                                                   <col width="30%" />
	                                                   <col width="15%" />
	                                                   <col width="30%" />
	                                                   </colgroup>
	                                                   <tbody>		                                                      
 														   <tr>
	                                                           <th class="C line_right" rowspan="6">종결</th> 
	                                                           <th class="C">일시</th>
	                                                           <td class="L" colspan="3">
	                                                               <label for="txt_05"></label><input type="text" data-type="date" data-optional-value="true" data-error-message="종결일시를 입력해주세요."  class="w15per calendar datepicker" name="edDt" id="edDt" />
	                                                           </td>
	                                                       </tr>
 														   <tr>
	                                                           <th class="C">처리결과</th>
	                                                           <td class="L" colspan="3">
	                                                               <label for="txt_05"></label><textarea id="edHandRstCont" name="edHandRstCont" rows="3" cols="120" data-type="required" data-optional-value="true" data-error-message="종결처리결과를 입력해주세요."></textarea>
	                                                           </td>
	                                                       </tr>
	                                             	   </tbody>
	                                              	 </table> 
                                              	</div>
                                               
                                               <div class="btnArea" id="criArea02" style="display:none">
                                                   <div class="r_btn" id="btnArea_EditButtons"></div>
                                               </div>
                                               
                                               <div class="btnArea" id="apprArea02" style="display:none">
                                               
                                               		<div style="height:100px">
	                                                	<table class="list" name="apprAreaTable" cellpadding="0" cellspacing="0" data-cri-dta-num="" data-cri-dta-catg-cd="06">
			                                                   <colgroup>
			                                                   <col width="10%" />
			                                                   <col width="15%" />
			                                                   <col width="30%" />
			                                                   <col width="15%" />
			                                                   <col width="30%" />
			                                                   </colgroup>
			                                                   <tbody>
			                                                       <tr>
			                                                           <th class="C line_right" rowspan="2">등록</th>
			                                                           <th class="C">등록요청</th>
			                                                           <td class="L" colspan="3" id="taskNmTD">		                                                               
			                                                           </td>
			                                                       </tr>		                                                       	                                                      
		             											   <tr>
			                                                           <th class="C">등록의견</th>
			                                                           <td class="L" colspan="3">
			                                                               <label for="txt_05"></label><input type="text" class="w100per" id="taskComn" name="taskComn" />
			                                                           </td>
			                                                       </tr>	
			                                             	   </tbody>
			                                           	</table> 
		                                            </div>   
                                               
                                               
                                                   <div class="r_btn" id="apprArea_EditButtons"></div>
                                               </div> 
											<!-- 수현0102 -->
											 <div class="btnArea" id="apprArea03" style="display:none">
                                               <div class="r_btn" id="criMb_EditButtons"></div>
                                             </div>
                                           </div>
                                           <!-- tab_contents //-->
                                       </li>
                                       
                                       <%--
									   <li class="m2"><a href="javascript:initEditActionManager();" id="criIncDtaTab" class="tabtitle"><span>서식관리</span></a>
											<div class="tab_mini_contents">
							                
							                	<div class="formatArea">
							                        <!-- leftArea -->
							                        <div class="leftArea w25per">
							                        
							                            <h4>서식종류</h4>
							                            <form method="post" id="deptSearchForm">
							                            <div class="popup_searchArea">
								                            <input type="text" name="dummy" value="" style="display: none;" /> 
				           									<label for="text"></label>
							                                <label for="search_03"></label><input type="text" class="w100per" id="text" name="text" placeholder="서식검색" value="${param.searchValue}" onkeydown="if(event.keyCode==13){fn_searchTree();}" />
							                                <a class="btn_search" href="javascript:fn_searchTree();"><img src="${cPath}/sjpb/images/btn_search.png" alt="search" /></a>                	
							                            </div>
							                            </form>
							                            <div id="deptTree" class="left_box">							                            
							                            </div>
							                            
							                            
							                        </div>
							                        <!-- leftArea //-->
							                        
							                        <div class="rightArea w75per">
							                        
							                            <h4>서식 탬플릿</h4>
							                            <div class="list ">
							                                <table class="list mar_0" cellpadding="0" cellspacing="0">
							                                    <caption>게시판쓰기</caption>
							                                    <colgroup>
							                                        <col width="15%" />
							                                        <col width="*%" />
							                                        <col width="15%" />
							                                    </colgroup>
							                                    <tbody>
							                                    <tr id="tpltTD" style="display:none">
							                                        <th class="C first th_line" scope="col"  rowspan="2"><span class="table_title" id="tpltFileTp"></span></th>
							                                        <td class="L td_line" ><a href="#" id="tpltFileLk1" download ><span id="tpltFileNm"></span></a></td>
							                                        <td class="L td_line" ><a href="#" id="tpltFileLk2" class="btn_white" download><span>탬플릿 다운</span></a></td>
							                                    </tr>
							                                    </tbody>
							                                </table>
							                            </div>
							                            <h4>작성서식 업로드</h4>
							                            <div id = "vault_upload" class="righr_box"></div>
							                            <ul id="vault_fileList" style="display: none;">	
														</ul>
														<form name="setFileList" method="post" target="invisible" action="${cPath }/sjpb/fileMngr?cmd=delete">
															<input type=hidden name=semaphore value="<c:out value="${boardSttVO.semaphore}"/>">
															<input type=hidden name=vaccum>
															<input type=hidden name=delBoardId value="<c:out value="${boardVO.boardRid}"/>">
															<input type=hidden name=unDelList>
															<input type=hidden name=delList>
															<input type=hidden name=subId value=sub01>
														</form>
							                            <div class="btnArea">
							                                <div class="r_btn"><a href="#" id="fileBtn" class="btn_white"><span>저장</span></a></div>
							                            </div>
							                            
							                            <h4 >작성서식 목록</h4>
															<div class="sub_listArea" id="criIncDtaCatgDiv">
							                                <table class="list" cellpadding="0" cellspacing="0">
							                                    <caption>게시판쓰기</caption>
							                                    <colgroup>
							                                        <col width="10%" />
							                                        <col width="18%" />
							                                        <col width="10%" />
							                                        <col width="18%" />
							                                        <col width="10%" />
							                                        <col width="18%" />
							                                        <col width="*%" />
							                                    </colgroup>
							                                    <tbody>
							                                        <tr>
							                                        	<th class="C th_line p_search">서식</th>
							                                        	<th class="L th_line p_search">
							                                                <div class="inputbox w100per">
							                                                    <div class="txt"></div>
							                                                     <select id="criDtaCatgSC" name="criDtaCatgSC">
                                                   								 	<option value="">전체</option>
																					<c:forEach items="${criIncDtaCatgList}" var="item">
																					    <option value="${item.code}">${item.codeName}</option> 
																					</c:forEach>
																				  </select> 	  
							                                                </div>    
							                                            </th>    
							                                        	<th class="C th_line p_search">파일명</th>
							                                        	<th class="L th_line p_search">
							                                            	<label for="txt_80"></label><input type="text" class="w100per" id="criDtaFileNmSC" name="criDtaFileNmSC" />
							                                            </th>
							                                        	<th class="C th_line p_search">작성자</th>
							                                        	<th class="L th_line p_search">
							                                            	<label for="txt_81"></label><input type="text" class="w100per" id="criDtaUsrNmSC" name="criDtaUsrNmSC" />
							                                            </th>
							                                        	<th class="L l_pd p_search">
							                                                <div class="l_btn"><a href="#" class="btn_blue" id="srchDTBtn" name="srchDTBtn"><span>검색</span></a></div>
							                                                <div class="l_btn"><a href="#" class="btn_white" id="initDTBtn" name="initDTBtn"><span>초기화</span></a></div>
							                                            </th>
							                                        </tr>
							                                    </tbody>
							                                </table>
							                            </div>
														<div id="sheetDT" class="listArea area-mousewheel" style="height: 200px; width: 100%"></div>							                            
							                        </div>
							                    </div>
							                    
							                </div>
										</li>
										 --%>
										
										<li class="m2"><a href="#" class="tabtitle" id="taskHistTab"><span>승인이력</span></a>
                                       	<div class="tab_mini_contents">                                      
                                       		<div id="sheetH" style="height: 300px; width: 100%" class="area-mousewheel"></div>
                                       	
                                       	</div>
                                       </li>
                                       
                                       <li class="m3"><a id="incHistTab" class="tabtitle"><span>변경이력</span></a>
											<div class="tab_mini_contents" id="tab_mini_m2_contents">
							                	
							                	<!-- listArea -->
											   <div id="sheetIncHist" class="listArea area-mousewheel" style="height: 300px; width: 100%">
												   
												   
											   </div>
											   <!-- listArea //-->
							                	
											</div>
										</li>

                                   </ul>
                               </div>
                              
                           </div>
                           <!--//사건관리-->                         
			</form>
			<!-- contents //-->		
		
	</body>
<script>

</script>
</html>

