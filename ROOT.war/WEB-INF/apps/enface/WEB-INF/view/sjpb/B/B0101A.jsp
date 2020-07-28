<%@page import="com.saltware.enface.sjpb.B.service.B0101VO"%>
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
	request.setAttribute("rcptNum", request.getParameter("rcptNum"));
	request.setAttribute("popup", request.getParameter("popup"));
%>

<html>
	<head>
		<title>사건관리</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-style-type" content="text/css" />
		<link rel="stylesheet" type="text/css" href="${cPath}/sjpb/css/sjpb_custom.css" />
		<link rel="stylesheet" type="text/css" href="${cPath}/javascript/jstree/themes/default/style.min.css" />
		
		<script type="text/javascript" src="${cPath}/sjpb/js/Z/jquery.base64.js"></script>		
        <script type="text/javascript" src="${cPath}/sjpb/js/B/B0101A.js?r=<%=Math.random()%>"></script>
        <script type="text/javascript" src="${cPath}/sjpb/js/B/B0102.js?r=<%=Math.random()%>"></script>
        <script type="text/javascript" src="${cPath}/sjpb/js/B/B0103.js?r=<%=Math.random()%>"></script>
        <script type="text/javascript" src="${cPath}/sjpb/js/B/incRecord.js?r=<%=Math.random()%>"></script>
        
		<script type="text/javascript" src="${pageContext.request.contextPath}/javascript/jstree/jstree.min.js" ></script>	
        
        <script type="text/javascript">
        
        const CRI_TRF_DTA_CATG_CD = "${criTrfDtaCatgCd}"; //송치자료
        const CRI_CMD_DTA_CATG_CD = "${criCmdDtaCatgCd}"; //수사지휘자료
        
        const IS_ALL_UPDATE_YN = "${isTrnsrAllUpdateYn}";	//송치관 모든 데이터 수정가능 여부 (Y, N)
		
        	var initRcptNumTmp = "${rcptNum}";	//진입시 선택할 rcptNum 정보 
        	
        	var initpopup = "${popup}";
        	
			var uploadInitFlag = false;  //vaultUploader 업로드 호출 여부 플래그
			function initEditActionManager() {
				
				//수사자료(작성서식 업로드) 초기화
				//$("#vault_upload").html("");
				
				
				if(uploadInitFlag == false){
					uploadInitFlag = sjpbFile.init(); //vaultUploader 업로드 호출이 안되어있을시에만 업로드 모듈 초기화
				}
				
				//탭 눌렀을때 그리기 
				//fn_drawTree();
				//$("#text").off("keyup").on("keyup",function(){
				//	var searchString = $(this).val();
		        //    $('#deptTree').jstree('search', searchString);
				//});
			}
			
			$(document).ready(function(){

	        	initEditActionManager();
	        	
	        	//달력이벤트
	        	$(".datepicker").datepicker({
	        		  dateFormat: "yy-mm-dd" ,
	        		  changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
	        		  changeYear: true,
	        		  showButtonPanel: true,
	        		  currentText: '오늘 날짜'
	        	});	
	        });
	
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
		   	
		   	function setDocHeight(contentHeight) {	

			   	var thisHeight =  document.body.scrollHeight;
			   	var iframes = document.getElementsByTagName("iframe");
				for( var i =0; i < iframes.length;i++ ) {
					if( iframes[i].id.indexOf("docMngframe") > -1) {
						B0101AutoResize( iframes[i], contentHeight,thisHeight );
					}
				}
			   	
		   	}
		   	
		   	function B0101AutoResize(arg,contentHeight,thisHeight ){
		   		if (contentHeight <700){
		   			contentHeight =700;
		   		}
				arg.style.height = contentHeight+ "px";
				
				//개발페이지를 위해서 try catch
				//안하면 개발페이지 문서관리에서 사건쪽에서 접근 여부 판단 불가 (ex.모든 사건 데이터노출)
				try{
					parent.autoresize_iframe_portlet();
				}catch(e){
				}
		   		
		   	}
		   	
		   	function iframe_heightResize(arg) {
				
				 var contentHeight = arg.contentWindow.document.body.scrollHeight;
				 if(contentHeight <= 685) contentHeight = 750;
				 arg.style.height = contentHeight  + "px";
				
			}
		   	
		   	/*
		   	function docIframeResize(obj){
		   		//개발페이지를 위해서 try catch
				try{
					parent.iframe_heightResize(obj);
				}catch(e){
				}
		   	}
		   	*/

		   </script>	
        
	</head>
	<body class="iframe" onbeforeunload="window.opener.selectList('', true);">
	
		<!-- report -->
		<form name="reportForm" method="post">
			<input type="hidden" id="reptNm" name="reptNm" value="" />
			<input type="hidden" id="xmlData" name="xmlData" value="" />
		</form>
	
		<form name="contentsFormData" id="contentsFormData">
			<input type="hidden" id="userId" name="userId" value="${userInfo.userId}" />   <!-- 사용자계정 -->
			<input type="hidden" id="userName" name="userName" value="${userInfo.userName}" />  <!-- 사용자이름 -->
			<input type="hidden" id="orgCd" name="orgCd" value="${userInfo.orgCd}" />   <!-- 수사팀코드 -->
			<input type="hidden" id="kindCd" name="kindCd" value="${userInfo.kindCd}" />  <!-- 수사단원구분 01:수사관 02:팀장 03:과장 -->	
			<input type="hidden" id="todayDateYmd" name="todayDateYmd" value="${todayDateYmd}" />  <!-- 오늘날짜 yyyymmdd -->
		</form>
		
		<!-- 피의자 이력 비교 팝업 -->
		<form id="spHistPopForm" name="spHistPopForm">
			<input type="hidden" id="incMfNum" name="incMfNum" value="" />	<!-- 사건수정번호 -->	   
			<input type="hidden" id="rcptNum" name="rcptNum" value="" />	<!-- 사건수정번호 -->	   
		</form>
	
   
	   </div>

	  
	  
	   <div class="tab_mini_wrap m1" id="contentsArea">
		   <ul>
			   <li class="m1"><a href="javascript:void(0);" class="tabtitle" data-always="y"><span id="incInfo">사건정보</span></a>
				   <!-- tab_contents -->
				   <div class="tab_mini_contents" id="tab_mini_m1_contents">
				   		<input type="hidden" id="criTmId" name="criTmId" />
					   <%-- 그리는영역 --%>
				   </div>
				   <!-- tab_contents //-->
			   </li>
				<li class="m2" style="display:none;"><a href="javascript:incMastHistTab();" id="incMastHistTab" class="tabtitle" data-always="y"><span>변경이력</span></a>
				<div class="tab_mini_contents" id="tab_mini_m2_contents">
                	
                	<!-- listArea -->
				   <div id="sheetHist" class="listArea area-mousewheel" style="height: 300px; width: 100%">
					   
					   
				   </div>
				   <!-- listArea //-->
                	
                	
                	<%-- 
                	<div class="listArea">
                        <table class="list" cellpadding="0" cellspacing="0">
                            <caption>게시판쓰기</caption>
                            <colgroup>
                                <col width="15%" />
                                <col width="*%" />
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th class="C first th_line" scope="col" ><span class="table_title">사건내용</span></th>
                                    <td class="L td_line">
                                        <textarea id="criCont" name="criCont" cols="" rows=""></textarea>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>    
					<div class="btnArea" id="criArea02_tab2">
						<div class="r_btn" id="btnArea_EditButtons_tab2"></div>
					</div>
					 --%>
				</div>
			</li>
			
			<%--
			<li class="m3" style="display:none;"><a href="javascript:initEditActionManager();" id="criIncDtaTab" class="tabtitle"><span>수사기록</span></a>
				<div class="tab_mini_contents" id="tab_mini_m3_contents">
	               
	               	<div class="formatArea">
	                       <!-- leftArea -->
	                       <div class="leftArea w25per">
	                       
	                           <h4>서식종류</h4>
	                           <form method="post" id="deptSearchForm">
	                           <div class="popup_searchArea">
	                            <input type="text" name="dummy" value="" style="display: none;" data-always="y" /> 
	       									<label for="text"></label>
	                               <label for="search_03"></label><input type="text" class="w100per" id="text" name="text" placeholder="서식검색" data-always="y" value="${param.searchValue}" onkeydown="if(event.keyCode==13){fn_searchTree();}" />
	                               <a class="btn_search" href="javascript:fn_searchTree();" data-always="y"><img src="${cPath}/sjpb/images/btn_search.png" alt="search" /></a>                	
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
	                                       <td class="L td_line" ><a href="javascript:void(0);" id="tpltFileLk1" data-always="y" download ><span id="tpltFileNm"></span></a></td>
	                                       <td class="L td_line" ><a href="javascript:void(0);" id="tpltFileLk2" data-always="y" class="btn_white" download><span>탬플릿 다운</span></a></td>
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
	                               <div class="r_btn"><a href="javascript:void(0);" id="fileBtn" class="btn_white"><span>저장</span></a></div>
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
	                                                    <select id="criDtaCatgSC" name="criDtaCatgSC" data-always="y">
	                                           								 	<option value="">전체</option>
														<c:forEach items="${criIncDtaCatgList}" var="item">
														    <option value="${item.code}">${item.codeName}</option> 
														</c:forEach>
													  </select> 	  
	                                               </div>    
	                                           </th>    
	                                       	<th class="C th_line p_search">파일명</th>
	                                       	<th class="L th_line p_search">
	                                           	<label for="txt_80"></label><input type="text" class="w100per" id="criDtaFileNmSC" name="criDtaFileNmSC" data-always="y"/>
	                                           </th>
	                                       	<th class="C th_line p_search">작성자</th>
	                                       	<th class="L th_line p_search">
	                                           	<label for="txt_81"></label><input type="text" class="w100per" id="criDtaUsrNmSC" name="criDtaUsrNmSC" data-always="y"/>
	                                           </th>
	                                       	<th class="L l_pd p_search">
	                                               <div class="l_btn"><a href="javascript:void(0);" class="btn_blue" id="srchDTBtn" name="srchDTBtn" data-always="y"><span>검색</span></a></div>
	                                               <div class="l_btn"><a href="javascript:void(0);" class="btn_white" id="initDTBtn" name="initDTBtn" data-always="y"><span>초기화</span></a></div>
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
			
			
			<li class="m4" style="display:none;"><a href="javascript:selectDocMngList();" id="docMngTab" class="tabtitle"><span>수사대장</span></a>
				<div class="tab_mini_contents" id="tab_mini_m4_contents">
	               
	               <iframe id="docMngframe" src="" frameborder="0" width="100%" scrolling="no"  onload="iframe_heightResize(this)">
              	
              
              		</iframe>
	                   
	            </div>
			</li>
			
			<li class="m5" style="display:none;"><a href="javascript:abc();" class="tabtitle" data-always="y"><span>통계원표</span></a>
				<div class="tab_mini_contents" id="tab_mini_m5_contents">
					<div class="listArea" id="tab_mini_m5_contents_listArea">
						<%-- 그리는영역 S --%>
						
						<%-- 그리는영역 E --%>
					</div>

					<div class="tab_small m1" id="tab_small_m1_contents" style="display:none;">
						<ul>
							<li class="m1" id="tab_small_m1_contents_li"><a href="javascript:void(0);" id="occrStsGrapLink" class="tab_small_title" data-always="y"><span>발생통계원표</span></a>
								<div class="tab_small_contents">
									
									<input type="hidden" id="occr_occrStsGrapNum" name="occr_occrStsGrapNum" value="" />
									<input type="hidden" id="occr_stsGrapPublYrmh" name="occr_stsGrapPublYrmh" value="" />
									<input type="hidden" id="occr_incSpNum" name="occr_incSpNum" value="" />
									<input type="hidden" id="occr_rcptNum" name="occr_rcptNum" value="" />
									<input type="hidden" id="occr_actVioNum" name="occr_actVioNum" value="" />
									<input type="hidden" id="occr_rltActCriNmCd" name="occr_rltActCriNmCd" value="" />
									
									<input type="hidden" id="occr_occrYrmhDtDotw" name="occr_occrYrmhDtDotw" value="" />
									<input type="hidden" id="occr_recgYrmhDtDotw" name="occr_recgYrmhDtDotw" value="" />
									
									<div class="listArea">
										<table class="list line_none" cellpadding="0" cellspacing="0">
											<colgroup>
												<col width="6%" />
												<col width="14%" />
												<col width="20%" />
												<col width="20%" />
												<col width="20%" />
											</colgroup>
											<thead>
												<tr>
													<th class="C" colspan="2">검거(최종처리)수사기관</th>
													<th class="C">본표번호</th>
													<th class="C">수사 사건부 번호</th>
													<th class="C">관계 검거사건표 번호</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td class="C r_line" colspan="2">금융감독원<br /> 자본시장특별사법경찰</td>
													<td class="C" rowspan="2">${todayDate } <br />제   호</td>
													<td class="C" rowspan="2">${todayDate } <br />제 <span id="StsIncrcptNum1"></span></td>
													<td class="C" rowspan="2">${todayDate } <br />제   호</td>
												</tr>
												<tr>
													<td class="C r_line">코드</td>
													<td class="C r_line">2190105</td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="listArea">
										<table class="list" cellpadding="0" cellspacing="0">
											<colgroup>
												<col width="10%" />
												<col width="23%" />
												<col width="10%" />
												<col width="23%" />
												<col width="10%" />
												<col width="*%" />
											</colgroup>
											<tbody>
												<tr>
													<th class="C" rowspan="2">작성년월</th>
													<td class="L" rowspan="2">${todayDate }</td>
													<th class="C" rowspan="2">죄명</th>
													<td class="L" colspan="3"><span id="occr_actVioClaNm"></span></td>
												</tr>
												<tr>
													<td class="L" colspan="3"><span id="occr_rltActCriNmCdDesc"></span></td>
												</tr>
												<tr>
													<th class="C">가정폭력</th>
													<td class="L">
														<input name="occr_famyVioYnCd" id="submit_5" type="radio" class="radio_pd radio_first" value="1" title="가정폭력" /><label for="submit_5">1. 유</label>
														<input name="occr_famyVioYnCd" id="submit_6" type="radio" class="radio_pd" value="2" title="가정폭력" /><label for="submit_6">2. 무</label>
													</td>
													<th class="C">학교폭력</th>
													<td class="L">
														<input name="occr_schlVioYnCd" id="submit_7" type="radio" class="radio_pd radio_first" value="1" title="학교폭력" /><label for="submit_7">1. 유</label>
														<input name="occr_schlVioYnCd" id="submit_8" type="radio" class="radio_pd" value="2" title="학교폭력" /><label for="submit_8">2. 무</label>
													</td>
													<th class="C">외국인 피의자 관련</th>
													<td class="L">
														<input name="occr_forgSpYnCd" id="submit_9" type="radio" class="radio_pd radio_first" value="1" title="외국인 피의자 관련" /><label for="submit_9">1. 유</label>
														<input name="occr_forgSpYnCd" id="submit_10" type="radio" class="radio_pd" value="2" title="외국인 피의자 관련" /><label for="submit_10">2. 무</label>
													</td>
												</tr>
												<tr>
													<th class="C">발생년월일시</th>
													<td class="L" colspan="5">
														<input name="occr_occrYrmhDtDivCd" id="submit_11" type="radio" class="radio_pd radio_first l_radio fl" value="1" /><label for="submit_11"></label>
														<div class="inputbox w15per">
															<p class="txt"></p>
															<select name="occr_occrYrmhDt_year" data-name="occr_occrYrmhDt"title="발생년도">
															</select>
														</div>
														<p class="l_sub_title">년</p>
														<div class="inputbox w15per">
															<p class="txt"></p>
															<select name="occr_occrYrmhDt_month" data-name="occr_occrYrmhDt" title="발생월">
															</select>
														</div>
														<p class="l_sub_title">월</p>
													  <div class="inputbox w15per">
															<p class="txt"></p>
															<select name="occr_occrYrmhDt_day" data-name="occr_occrYrmhDt" title="발생일">
															</select>
														</div>
														<p class="l_sub_title">일</p>
													  <div class="inputbox w15per">
															<p class="txt"></p>
															<select name="occr_occrYrmhDt_time" title="발생시">
															</select>
														</div>
														<p class="l_sub_title" id="occr_occrYrmhDt_sub" data-messageType="1">시경</p>
														
														<input name="occr_occrYrmhDtDivCd" id="submit_12" type="radio" class="radio_pd" value="2" /><label for="submit_12">미상</label>
													</td>
												</tr>
											</tbody>
										</table>   
									</div>          
	
									<div class="listArea">
										<table class="list" cellpadding="0" cellspacing="0">
											<colgroup>
												<col width="7%" />
												<col width="6%" />
												<col width="10%" />
												<col width="8%" />
												<col width="*%" />
												<col width="17%" />
												<col width="10%" />
											</colgroup>
											<tbody>
												<tr>
													<th class="C" colspan="2">인지년월일시</th>
													<td class="L" colspan="4">
														<div class="inputbox w20per">
															<p class="txt"></p>
															<select name="occr_recgYrmhDt_year" data-name="occr_recgYrmhDt">
															</select>
														</div>
														<p class="l_sub_title">년</p>
														<div class="inputbox w20per">
															<p class="txt"></p>
															<select name="occr_recgYrmhDt_month" data-name="occr_recgYrmhDt">
															</select>
														</div>
														<p class="l_sub_title">월</p>
													  <div class="inputbox w20per">
															<p class="txt"></p>
															<select name="occr_recgYrmhDt_day" data-name="occr_recgYrmhDt">
															</select>
														</div>
														<p class="l_sub_title">일</p>
													  <div class="inputbox w20per">
															<p class="txt"></p>
															<select name="occr_recgYrmhDt_time">
															</select>
														</div>
														<p class="l_sub_title" id="occr_recgYrmhDt_sub" data-messageType="2">시</p>
													</td>
													<th class="C">발생부터인지까지기간</th>
													<td class="L" colspan="2">
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="occr_occrToRecgPi">
																<option value="">선택</option>
																<option value="01">1. 1시간이내</option>
																<option value="02">2. 2시간이내</option>
																<option value="03">3. 5시간이내</option>
																<option value="04">4. 12시간이내</option>
																<option value="05">5. 24시간이내</option>
																<option value="06">6. 2일이내</option>
																<option value="07">7. 5일이내</option>
																<option value="08">8. 10일이내</option>
																<option value="09">9. 1개월이내</option>
																<option value="10">10. 3개월이내</option>
																<option value="11">11. 3개월초과</option>
															</select>
														</div>
													</td>    
												</tr>
												<tr>
													<th class="C" colspan="2">범죄수법</th>
													<td class="L" colspan="2">
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="occr_criMeth">
																<option value="">선택</option>
																<option value="01">01. 침입강도</option>
																<option value="02">02. 노상강도</option>
																<option value="03">03. 차내강도</option>
																<option value="04">04. 해상강도</option>
																<option value="05">05. 차량이용강도</option>
																<option value="06">06. 약취강도</option>
																<option value="07">07. 마취강도</option>
																<option value="08">08. 인질강도</option>
																<option value="09">09. 강간강도</option>
																<option value="10">10. 기타강도</option>
																<option value="11">11. 빈집절도</option>
																<option value="12">12. 사무실절도</option>
																<option value="13">13. 공장절도</option>
																<option value="14">14. 상점절도</option>
																<option value="15">15. 숙박업소절도</option>
																<option value="16">16. 기타절도</option>
																<option value="20">20. 소매치기</option>
																<option value="21">21. 날치기</option>
																<option value="22">22. 들치기</option>
																<option value="23">23. 차량이용절도</option>
																<option value="24">24. 속임수절도</option>
																<option value="25">25. 기타절도</option>
																<option value="31">31. 가짜속임사기</option>
																<option value="32">32. 매매가장사기</option>
																<option value="33">33. 알선사기</option>
																<option value="34">34. 부동산사기</option>
																<option value="35">35. 수표어음속임사기</option>
																<option value="36">36. 차용사기</option>
																<option value="37">37. 모집사기</option>
																<option value="38">38. 컴퓨터등사용사기</option>
																<option value="39">39. 기타사기</option>
															</select>
														</div>    
													</td>
													<th class="C">발생일특수사정</th>
													<td class="L">
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="occr_occrDtSpelSitu">
																<option value="">선택</option>
																<option value="1">1. 토요일</option>
																<option value="2">2. 공휴일</option>
																<option value="3">3. 행사일</option>
																<option value="4">4. 정전시</option>
																<option value="5">5. 재해시</option>
																<option value="6">6. 미상</option>
																<option value="7">7. 해당무</option>
															</select>
														</div>
													</td>
													<th class="C">범행시일기</th>
													<td class="L" colspan="2">
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="occr_criTimeWeth">
																<option value="">선택</option>
																<option value="01">01. 맑음</option>
																<option value="02">02. 흐림</option>
																<option value="03">03. 비</option>
																<option value="04">04. 폭풍우</option>
																<option value="05">05. 눈</option>
																<option value="06">06. 폭설</option>
																<option value="07">07. 안개</option>
																<option value="08">08. 바람</option>
																<option value="09">09. 만월</option>
																<option value="10">10. 암흑</option>
																<option value="11">11. 미상</option>
															</select>
														</div>
													</td>    
												</tr>
												<tr>
													<th class="C" colspan="2">수사단서</th>
													<td class="L" colspan="2">
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="occr_criClue">
																<option value="">선택</option>
																<option value="01">01. 현행범</option>
																<option value="11">11. 피해지신고</option>
																<option value="12">12. 고소</option>
																<option value="13">13. 고발</option>
																<option value="14">14. 자수</option>
																<option value="15">15. 진정투서</option>
																<option value="16">16. 타인신고</option>
																<option value="21">21. 불심검문</option>
																<option value="22">22. 피해품발견</option>
																<option value="23">23. 변사체</option>
																<option value="24">24. 탐문정보</option>
																<option value="25">25. 여죄</option>
																<option value="26">26. 기타</option>
															</select>
														</div>    
													</td>
													<th class="C">미신고이유</th>
													<td class="L" colspan="4">
														<div class="inputbox w60per">
															<p class="txt">선택</p>
															<select name="occr_undcRsn">
																<option value="">선택</option>
																<option value="01">01. 피해근소</option>
																<option value="02">02. 부정물자</option>
																<option value="03">03. 명예보호</option>
																<option value="04">04. 보복우려</option>
																<option value="05">05. 범인이친족친우</option>
																<option value="06">06. 피해품회수기대난</option>
																<option value="07">07. 범인검거기대난</option>
																<option value="08">08. 유실로착각</option>
																<option value="09">09. 절차복잡</option>
																<option value="10">10. 신고지원거리</option>
																<option value="11">11. 피해사실몰라서</option>
																<option value="12">12. 기타</option>
															</select>
														</div>
													</td>
												</tr>
												<tr>
													<th class="C r_line">피해자</th>
													<th class="C">성별</th>
													<td class="L" colspan="2">
														<input name="occr_vicm" id="submit_13" type="radio" class="radio_pd radio_first" value="1" /><label for="submit_13">1. 남</label>
														<input name="occr_vicm" id="submit_14" type="radio" class="radio_pd" value="2" /><label for="submit_14">2. 여</label>
														<input name="occr_vicm" id="submit_15" type="radio" class="radio_pd" value="3" /><label for="submit_15">3. 미상</label>
													</td>
													<th class="C">연령</th>
													<td class="L">
														<input name="occr_ageDivCd" id="submit_16" type="radio" class="fl sradio_pg radio_first l_radio" value="1" checked="checked"/><label for="submit_16">1. 연령1</label>
														<label for="occr_age"></label><input name="occr_age" id="occr_age" type="text" class="w30per" data-type="number" data-optional-value=true title="연령">
														<input name="occr_ageDivCd" id="submit_17" type="radio" class="radio_pg" value="2" /><label for="submit_17"> 2. 미상</label>
	
													</td>
													<th class="C">외국인코드</th>
													<td class="L" colspan="2">
														<span class="sub_title">1. 국적</span><label for="txt_24"></label><input type="text" class="w30per" id="txt_24" name="occr_forgCdNaty" />
														<span class="sub_title">2. 신분</span><label for="txt_25"></label><input type="text" class="w30per" id="txt_25" name="occr_forgCdPosi" />
													</td>
												</tr>    
												<tr>
													<th class="C" colspan="2">피해자 피해시 상황</th>
													<td class="L" colspan="2">
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="occr_vicmDamgTimeSitu">
																<option value="">선택</option>
																<option value="01">01. 취침중</option>
																<option value="02">02. 일하는중</option>
																<option value="03">03. 부재중</option>
																<option value="04">04. 담화중</option>
																<option value="05">05. 혼잡중</option>
																<option value="06">06. 보행중</option>
																<option value="07">07. 딴데정신잃어서</option>
																<option value="08">08. 속아서</option>
																<option value="09">09. 기타</option>
																<option value="10">10. 미상</option>
															</select>
														</div>
													</td>
													<th class="C">발생지</th>
													<td class="L">
	
														<div class="inputbox w40per">
															<p class="txt"></p>
															<select name="occr_occrAreaDiv">
																<option value="">선택</option>
																<option value="01">1. 서울</option>
																<option value="02">2. 부산</option>
																<option value="03">3. 대구</option>
																<option value="04">4. 인천</option>
																<option value="05">5. 광주</option>
																<option value="06">6. 대전</option>
																<option value="07">7. 울산</option>
																<option value="08">8. 경기</option>
																<option value="09">9. 강원</option>
																<option value="10">10. 충청</option>
																<option value="11">11. 전라</option>
																<option value="12">12. 경상</option>
																<option value="13">13. 제주</option>
																<option value="14">14. 기타</option>
															</select></div>
														<div class="inputbox w40per" data-name="occr_occrAreaDiv">
															<p class="txt"></p>
															<select name="occr_occrArea">
																<option>선택</option>
															</select>
														</div>    
													</td>
													<th class="C">발생장소</th>
													<td class="L" colspan="2">
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="occr_occrPla">
																<option value="">선택</option>
																<option value="01">01. 아파트연립다세대</option>
																<option value="02">02. 단독주택</option>
																<option value="03">03. 고속도로</option>
																<option value="04">04. 노상</option>
																<option value="05">05. 상점</option>
																<option value="06">06. 시장노점</option>
																<option value="07">07. 숙박업소목욕탕</option>
																<option value="08">08. 유흥접객업소</option>
																<option value="09">09. 사무실</option>
																<option value="10">10. 공장</option>
																<option value="11">11. 공사장광산</option>
																<option value="12">12. 창고</option>
																<option value="13">13. 역대합실</option>
																<option value="14">14. 지하철</option>
																<option value="15">15. 기타교통수단내</option>
																<option value="16">16. 흥행장</option>
																<option value="17">17. 유원지</option>
																<option value="18">18. 학교</option>
																<option value="19">19. 금융기관</option>
																<option value="20">20. 의료기관</option>
																<option value="21">21. 종교기관</option>
																<option value="22">22. 산야</option>
																<option value="23">23. 해상</option>
																<option value="24">24. 부대</option>
																<option value="25">25. 구금장소</option>
																<option value="26">26. 공지</option>
																<option value="27">27. 기타</option>
															</select>
														</div>
													</td>                                                        
												</tr>
											</tbody>                                                    
										</table>
									</div>      
	
									<div class="listArea">
									   <table class="list" cellpadding="0" cellspacing="0">
											<colgroup>
												<col width="6%" />
												<col width="6%" />
												<col width="*%" />
												<col width="*%" />
												<col width="*%" />
												<col width="*%" />
												<col width="*%" />
												<col width="*%" />
												<col width="*%" />
												<col width="*%" />
												<col width="*%" />
											</colgroup>
											<tbody>
												<tr>
													<th class="C r_line" rowspan="5">재산피해상황</th>
													<th class="C" colspan="2">피해정도</th>
													<td class="L" colspan="8">
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="occr_propDamgDegr">
																<option value="">선택</option>
																<option value="1">1. 피해무</option>
																<option value="2">2. 1만원이하</option>
																<option value="3">3. 10만원이하</option>
																<option value="4">4. 100만원이하</option>
																<option value="5">5. 1000만원이하</option>
																<option value="6">6. 1억원이하</option>
																<option value="7">7. 10억원이하</option>
																<option value="8">8. 10억원초과</option>
																<option value="9">9. 미상</option>
															</select>
														</div>
													</td>
												</tr>
												<tr>
													<th class="C r_line" rowspan="4">피해액</th>
													<th class="C">품명</th>
													<td class="L r_line">1. 화폐</td>
													<td class="L r_line">2. 자동차</td>
													<td class="L r_line">3. 유가증권</td>
													<td class="L r_line">4. 귀금속</td>
													<td class="L r_line">5. 전기 전자제품</td>
													<td class="L r_line">6. 오토바이자전거</td>
													<td class="L r_line">7. 가구류</td>
													<td class="L">피해액 합계</td>                                                            
												</tr>
												<tr>
													<th class="C">금액(시가)</th>
													<td class="L r_line"><label for="txt_26"></label><input type="text" class="w40per" id="txt_26" name="occr_damgAmtMony" data-type="number" title="1. 화폐" data-name="occr_damgAmt" data-optional-value="true" /><span class="sub_title">원</span></td>
													<td class="L r_line"><label for="txt_27"></label><input type="text" class="w40per" id="txt_27" name="occr_damgAmtCar" data-type="number" title="2. 자동차" data-name="occr_damgAmt" data-optional-value="true"/><span class="sub_title">원</span></td>
													<td class="L r_line"><label for="txt_28"></label><input type="text" class="w40per" id="txt_28" name="occr_damgAmtMarkSecu" data-type="number" title="3. 유가증권" data-name="occr_damgAmt" data-optional-value="true"/><span class="sub_title">원</span></td>
													<td class="L r_line"><label for="txt_29"></label><input type="text" class="w40per" id="txt_29" name="occr_damgAmtJewy" data-type="number" title="4. 귀금속" data-name="occr_damgAmt" data-optional-value="true"/><span class="sub_title">원</span></td>
													<td class="L r_line"><label for="txt_30"></label><input type="text" class="w40per" id="txt_30" name="occr_damgAmtElecElenProd" data-type="number" title="5. 전기 전자제품" data-name="occr_damgAmt" data-optional-value="true"/><span class="sub_title">원</span></td>
													<td class="L r_line"><label for="txt_31"></label><input type="text" class="w40per" id="txt_31" name="occr_damgAmtMocyBike" data-type="number" title="6. 오토바이자전거" data-name="occr_damgAmt" data-optional-value="true"/><span class="sub_title">원</span></td>
													<td class="L r_line"><label for="txt_32"></label><input type="text" class="w40per" id="txt_32" name="occr_damgAmtFurnArtc" data-type="number" title="7. 가구류" data-name="occr_damgAmt" data-optional-value="true"/><span class="sub_title">원</span></td>
													<td class="L" rowspan="3"><span id="occr_damgAmtTot"></span>원</td>
												</tr>
												<tr>
													<th class="C">품명</th>
													<td class="L r_line">8. 의류</td> 
													<td class="L r_line">9. 기계류</td> 
													<td class="L r_line">10. 농임산물</td> 
													<td class="L r_line">11. 축산물</td> 
													<td class="L r_line">12. 수산물</td> 
													<td class="L r_line">13. 잡화</td> 
													<td class="L r_line">14. 기타</td> 
												</tr>
												<tr>
													<th class="C">금액(시가)</th>
													<td class="L r_line"><label for="txt_33"></label><input type="text" class="w40per" id="txt_33"  name="occr_damgAmtClot" data-type="number" title="8. 의류" data-name="occr_damgAmt" data-optional-value="true"/><span class="sub_title">원</span></td>
													<td class="L r_line"><label for="txt_34"></label><input type="text" class="w40per" id="txt_34"  name="occr_damgAmtMach" data-type="number" title="9. 기계류" data-name="occr_damgAmt" data-optional-value="true"/><span class="sub_title">원</span></td>
													<td class="L r_line"><label for="txt_35"></label><input type="text" class="w40per" id="txt_35"  name="occr_damgAmtFarmFortProd" data-type="number" title="10. 농임산물" data-name="occr_damgAmt" data-optional-value="true"/><span class="sub_title">원</span></td>
													<td class="L r_line"><label for="txt_37"></label><input type="text" class="w40per" id="txt_37"  name="occr_damgAmtAmhbProd" data-type="number" title="11. 축산물" data-name="occr_damgAmt" data-optional-value="true"/><span class="sub_title">원</span></td>
													<td class="L r_line"><label for="txt_38"></label><input type="text" class="w40per" id="txt_38"  name="occr_damgAmtMarnProd" data-type="number" title="12. 수산물" data-name="occr_damgAmt" data-optional-value="true"/><span class="sub_title">원</span></td>
													<td class="L r_line"><label for="txt_39"></label><input type="text" class="w40per" id="txt_39"  name="occr_damgAmtMcgd" data-type="number" title="13. 잡화" data-name="occr_damgAmt" data-optional-value="true"/><span class="sub_title">원</span></td>
													<td class="L r_line"><label for="txt_40"></label><input type="text" class="w40per" id="txt_40"  name="occr_damgAmtEtc" data-type="number" title="14. 기타" data-name="occr_damgAmt" data-optional-value="true"/><span class="sub_title">원</span></td>
												</tr>
											</tbody>
										</table>      
									</div>                                                  
	
									<div class="listArea">
									   <table class="list" cellpadding="0" cellspacing="0">
											<colgroup>
												<col width="8%" />
												<col width="10%" />
												<col width="16%" />
												<col width="*%" />
												<col width="10%" />
												<col width="*%" />
											</colgroup>
											<tbody>
												<tr>
													<th class="C r_line" rowspan="2">신체피해상황</th>
													<th class="C">피해구분</th>                                                        
													<td class="L">
														<label for="checkbox_08"></label><input type="checkbox" id="checkbox_08" name="occr_bodyDamgZero" value="Y" />
														<span class="sub_title">1. 피해 무</span>
														<label for="checkbox_09"></label><input type="checkbox" id="checkbox_09" name="occr_bodyDamgInjy" value="Y" />
														<span class="sub_title">2. 상해</span>
													</td>
													<td class="L">    
														<span class="sub_title">남자</span><label for="txt_41"></label><input type="text" class="w30per" id="txt_41" name="occr_bodyDamgInjyMan" data-type="number" title="피해구분 상해 남자" data-optional-value="true" data-name="occr_bodyDamgInjy"/><span class="sub_title">명</span><br />
														<span class="sub_title">여자</span><label for="txt_42"></label><input type="text" class="w30per" id="txt_42" name="occr_bodyDamgInjyWomn" data-type="number" title="피해구분 상해 여자" data-optional-value="true" data-name="occr_bodyDamgInjy"/><span class="sub_title">명</span>
													</td>
													<td class="L">
														<label for="checkbox_10"></label><input type="checkbox" id="checkbox_10" name="occr_bodyDamgDeth" value="Y" />
														<span class="sub_title">3. 사망</span>
													</td>
													<td class="L">    
														<span class="sub_title">남자</span><label for="txt_43"></label><input type="text" class="w30per" id="txt_43" name="occr_bodyDamgDethMan" data-type="number" title="피해구분 사망 남자" data-optional-value="true" data-name="occr_bodyDamgDeth"/><span class="sub_title">명</span><br />
														<span class="sub_title">여자</span><label for="txt_44"></label><input type="text" class="w30per" id="txt_44" name="occr_bodyDamgDethWomn" data-type="number" title="피해구분 사망 여자" data-optional-value="true" data-name="occr_bodyDamgDeth"/><span class="sub_title">명</span>
													</td>
												</tr>
												<tr>
													<th class="C">상해정도</th>
													<td class="L" colspan="4">
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="occr_bodyDamgInjyDegr">
																<option value="">선택</option>
																<option value="1">1. 전치2주이하</option>
																<option value="2">2. 전치1개월이하</option>
																<option value="3">3. 전치2개월이하</option>
																<option value="4">4. 전치4개월이하</option>
																<option value="5">5. 전치6개월이하</option>
																<option value="6">6. 전치6개월초과</option>
																<option value="7">7. 미상</option>
															</select>
														</div>
													</td>
												</tr>
											</tbody>    
										</table>
									</div>
	
									<div class="btnArea" data-name="occrArea01">
										<div class="r_btn">
											<a href="javascript:insertOccrStsGrap();" class="btn_white"><span>저 장</span></a>
										</div>
									</div>
									
									<div class="btnArea" data-name="occrArea02" style="display:none">
										<div class="r_btn">
											<a href="javascript:updateOccrStsGrap();" class="btn_white"><span>저 장</span></a>
											<a href="javascript:void(0);" class="btn_blue" id="occrPrnBtn" data-always="y"><span>인쇄</span></a>
										</div>
									</div>
									
								</div>
							</li>
							<li class="m2"><a href="javascript:void(0);" id="arstStsGrapLink" class="tab_small_title" data-always="y"><span>검거통계원표</span></a>
								<div class="tab_small_contents">
								
									<input type="hidden" id="arst_arstStsGrapNum" name="arst_arstStsGrapNum" value="" />
									<input type="hidden" id="arst_stsGrapPublYrmh" name="arst_stsGrapPublYrmh" value="" />
									<input type="hidden" id="arst_incSpNum" name="arst_incSpNum" value="" />
									<input type="hidden" id="arst_rcptNum" name="arst_rcptNum" value="" />
									<input type="hidden" id="arst_actVioNum" name="arst_actVioNum" value="" />
									<input type="hidden" id="arst_rltActCriNmCd" name="arst_rltActCriNmCd" value="" />
									
									<div class="listArea">
										<table class="list line_none" cellpadding="0" cellspacing="0">
											<colgroup>
												<col width="6%" />
												<col width="14%" />
												<col width="20%" />
												<col width="20%" />
												<col width="20%" />
											</colgroup>
											<thead>
												<tr>
													<th class="C" colspan="2">검거(최종처리)수사기관</th>
													<th class="C">본표번호</th>
													<th class="C">수사 사건부 번호</th>
													<th class="C">관계 발생사건표 번호</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td class="C r_line" colspan="2">금융감독원<br /> 자본시장특별사법경찰</td>
													<td class="C" rowspan="2">미입력</td>
													<td class="C" rowspan="2">${todayDate } <br />제 <span id="StsIncrcptNum2"></span></td>
													<td class="C" rowspan="2">${todayDate } <br />제   호</td>
												</tr>
												<tr>
													<td class="C r_line">코드</td>
													<td class="C r_line">2190105</td>
												</tr>
											</tbody>
										</table>
									</div> 

                                    <div class="listArea">
                                        <table class="list" cellpadding="0" cellspacing="0">
                                            <colgroup>
                                                <col width="15%" />
                                                <col width="35%" />
                                                <col width="15%" />
                                                <col width="35%" />
    
                                            </colgroup>
                                            <tbody>
                                                <tr>
                                                    <th class="C" rowspan="2">작성년월</th>
                                                    <td class="L" rowspan="2">${todayDate }</td>
                                                    <th class="C" rowspan="2">죄명</th>
                                                    <td class="L"><span id="arst_actVioClaNm"></span></td>
                                                </tr>
                                                <tr>
                                                    <td class="L"><span id="arst_rltActCriNmCdDesc"></span></td>
                                                </tr>
                                                <tr>
                                                    <th class="C">가정폭력</th>
                                                    <td class="L">
                                                        <input name="arst_famyVioYn" id="submit_30" type="radio" class="radio_pd radio_first" value="1" /><label for="submit_30">1. 유</label>
                                                        <input name="arst_famyVioYn" id="submit_31" type="radio" class="radio_pd" value="2" /><label for="submit_31">2. 무</label>
                                                    </td>
                                                    <th class="C">학교폭력</th>
                                                    <td class="L">
                                                        <input name="arst_schlVioYn" id="submit_32" type="radio" class="radio_pd radio_first" value="1" /><label for="submit_32">1. 유</label>
                                                        <input name="arst_schlVioYn" id="submit_33" type="radio" class="radio_pd" value="2" /><label for="submit_33">2. 무</label>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>   
                                    </div>          

                                    <div class="listArea">                					
                                        <table class="list" cellpadding="0" cellspacing="0">
                                            <colgroup>
                                                <col width="*%" />
                                                <col width="14%" />
                                                <col width="14%" />
                                                <col width="14%" />
                                                <col width="15%" />
                                                <col width="15%" />
                                                <col width="15%" />
                                            </colgroup>
                                            <tbody>
                                                <tr>
                                                    <th class="C">검거년월일</th>
                                                    <td class="L" colspan="3">
                                                        <div class="inputbox w15per">
                                                            <p class="txt"></p>
                                                            <select name="arst_arstYearMontDt_year" data-name="arst_arstYearMontDt">
                                                            </select>
                                                        </div>
                                                        <p class="l_sub_title">년</p>
                                                        <div class="inputbox w15per">
                                                            <p class="txt"></p>
                                                            <select name="arst_arstYearMontDt_month" data-name="arst_arstYearMontDt">
                                                            </select>
                                                        </div>
                                                        <p class="l_sub_title">월</p>
                                                      <div class="inputbox w15per">
                                                            <p class="txt"></p>
                                                            <select name="arst_arstYearMontDt_day" data-name="arst_arstYearMontDt">
                                                            </select>
                                                        </div>
                                                        <p class="l_sub_title">일</p>
                                                    </td>
                                                    <th class="C">발생년월일</th>
                                                    <td class="L" colspan="2">
                                                        <div class="inputbox w23per">
                                                            <p class="txt"></p>
                                                            <select name="arst_occrYearMontDt_year" data-name="arst_occrYearMontDt">
                                                            </select>
                                                        </div>
                                                        <p class="l_sub_title">년</p>
                                                        <div class="inputbox w23per">
                                                            <p class="txt"></p>
                                                            <select name="arst_occrYearMontDt_month" data-name="arst_occrYearMontDt">
                                                            </select>
                                                        </div>
                                                        <p class="l_sub_title">월</p>
                                                      <div class="inputbox w23per">
                                                            <p class="txt"></p>
                                                            <select name="arst_occrYearMontDt_day" data-name="arst_occrYearMontDt">
                                                                <option>21</option>
                                                            </select>
                                                        </div>
                                                        <p class="l_sub_title">일</p>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th>발생부터 검거까지 기간</th>
                                                    <td class="L" colspan="6">
                                                        <div class="inputbox w100per">
                                                            <p class="txt">선택</p>
                                                            <select name="arst_occrToArstPi">
                                                                <option value="">선택</option>
																<option value="1">1. 1일이내</option>
																<option value="2">2. 2일이내</option>
																<option value="3">3. 3일이내</option>
																<option value="4">4. 10일이내</option>
																<option value="5">5. 1개월이내</option>
																<option value="6">6. 3개월이내</option>
																<option value="7">7. 6개월이내</option>
																<option value="8">8. 1년이내</option>
																<option value="9">9. 1년초과</option>
                                                            </select>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th class="C">범죄수법</th>
                                                    <td class="L">
                                                        <div class="inputbox w100per">
                                                            <p class="txt">선택</p>
                                                            <select name="arst_criMeth">
                                                                <option value="">선택</option>
																<option value="01">01. 침입강도</option>
																<option value="02">02. 노상강도</option>
																<option value="03">03. 차내강도</option>
																<option value="04">04. 해상강도</option>
																<option value="05">05. 차량이용강도</option>
																<option value="06">06. 약취강도</option>
																<option value="07">07. 마취강도</option>
																<option value="08">08. 인질강도</option>
																<option value="09">09. 강간강도</option>
																<option value="10">10. 기타강도</option>
																<option value="11">11. 빈집절도</option>
																<option value="12">12. 사무실절도</option>
																<option value="13">13. 공장절도</option>
																<option value="14">14. 상점절도</option>
																<option value="15">15. 숙박업소절도</option>
																<option value="16">16. 기타절도</option>
																<option value="20">20. 소매치기</option>
																<option value="21">21. 날치기</option>
																<option value="22">22. 들치기</option>
																<option value="23">23. 차량이용절도</option>
																<option value="24">24. 속임수절도</option>
																<option value="25">25. 기타절도</option>
																<option value="31">31. 가짜속임사기</option>
																<option value="32">32. 매매가장사기</option>
																<option value="33">33. 알선사기</option>
																<option value="34">34. 부동산사기</option>
																<option value="35">35. 수표어음속임사기</option>
																<option value="36">36. 차용사기</option>
																<option value="37">37. 모집사기</option>
																<option value="38">38. 컴퓨터등사용사기</option>
																<option value="39">39. 기타사기</option>
                                                            </select>
                                                        </div>
                                                    </td>
                                                    <th class="C">침입구</th>
                                                    <td class="L">
                                                        <div class="inputbox w100per">
                                                            <p class="txt">선택</p>
                                                            <select name="arst_trpsEnty">
                                                                <option value="">선택</option>
                                                                <option value="1">1. 출입문</option>
                                                                <option value="2">2. 창문</option>
                                                                <option value="3">3. 담</option>
                                                                <option value="4">4. 지붕</option>
                                                                <option value="5">5. 비상구</option>
                                                                <option value="6">6. 기타</option>
                                                            </select>
                                                        </div>
                                                    </td>
                                                    <th class="C">침입방법</th>
                                                    <td class="L" colspan="2">
                                                        <div class="inputbox w100per">
                                                            <p class="txt">선택</p>
                                                            <select name="arst_trpsWay"">
                                                            	<option value="">선택</option>
                                                                <option value="1">1. 문단속없음</option>
																<option value="2">2. 시정장치부수고</option>
																<option value="3">3. 문부수고</option>
																<option value="4">4. 시정장치열고</option>
																<option value="5">5. 유리깨고</option>
																<option value="6">6. 기타</option>
                                                            </select>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th class="C" rowspan="2">검거인원</th>
                                                    <td class="C r_line" colspan="3">1. 한국인</td>
                                                    <td class="C" colspan="3">2. 외국인</td>
                                                </tr>
                                                <tr>
                                                    <td class="L r_line">
                                                        <span class="sub_title">1. 남자:</span>
                                                        <label for="txt_18"></label><input type="text" name="arst_arstKornMan" class="w30per" id="txt_18" />
                                                        명
                
                                                    </td>
                                                    <td class="L r_line">
                                                        <span class="sub_title">2. 여자:</span>
                                                        <label for="txt_19"></label><input type="text" name="arst_arstKornWomn" class="w30per" id="txt_19" />
                                                        명
                
                                                    </td>
                                                    <td class="L r_line">
                                                        <span class="sub_title">3. 법인:</span>
                                                        <label for="checkbox_11"></label><input type="checkbox" name="arst_arstKornCorp" id="checkbox_11" value="Y"/>
                                                    </td>
                                                    <td class="L r_line">
                                                        <span class="sub_title">1. 남자: </span>
                                                        <label for="txt_21"></label><input type="text" name="arst_arstForgMan" class="w30per" id="txt_21" />
                                                        명
                
                                                    </td>
                                                    <td class="L r_line">
                                                        <span class="sub_title">2. 여자:</span>
                                                        <label for="txt_22"></label><input type="text" name="arst_arstForgWomn" class="w30per" id="txt_22" />
                                                        명
                
                                                    </td>
                                                    <td class="L r_line">
                                                        <span class="sub_title">3. 법인 </span>
                                                        <label for="checkbox_14"></label><input type="checkbox" name="arst_arstForgCorp" id="checkbox_14" value="Y"/>
                                                    </td>
                                                </tr>
                                                <tr>
                
                                                    <th class="C">기수ㆍ미수별</th>
                                                    <td class="L" colspan="3">
                                                        <div class="inputbox w100per">
                                                            <p class="txt">선택</p>
                                                            <select name="arst_cmtdUnctClsf">
                                                            	<option value="">선택</option>
                                                                <option value="1">1. 기수</option>
																<option value="2">2. 미수</option>
																<option value="3">3. 예비음모</option>
                                                            </select>
                                                        </div>
                                                    </td>
                                                    <th class="C">공범수</th>
                                                    <td class="L" colspan="2">
                                                        <div class="inputbox w100per">
                                                            <p class="txt">선택</p>
                                                            <select name="arst_acmpNum">
                                                            	<option value="">선택</option>
                                                                <option value="1">1. 단독</option>
																<option value="2">2. 2명</option>
																<option value="3">3. 3명</option>
																<option value="4">4. 4명</option>
																<option value="5">5. 5명</option>
																<option value="6">6. 10명이하</option>
																<option value="7">7. 20명이하</option>
																<option value="8">8. 기타</option>
                                                            </select>
                                                        </div>
                                                    </td>                                                                
                                                </tr>
                                                <tr>
                                                    <th class="C">범행도구 종류</th>
                                                    <td class="L" colspan="2">
                                                        <div class="inputbox w100per">
                                                            <p class="txt">선택</p>
                                                            <select name="arst_criToolType">
                                                            	<option value="">선택</option>
                                                            	<option value="01">01. 총기</option>
																<option value="02">02. 모의총기</option>
																<option value="03">03. 칼</option>
																<option value="04">04. 도끼</option>
																<option value="05">05. 낫</option>
																<option value="06">06. 유리병</option>
																<option value="07">07. 돌</option>
																<option value="08">08. 몽둥이</option>
																<option value="09">09. 공구</option>
																<option value="10">10. 줄(끈)</option>
																<option value="11">11. 마취제</option>
																<option value="12">12. 독극물</option>
																<option value="13">13. 컴퓨터</option>
																<option value="14">14. 기타</option>
																<option value="15">15. 소지무</option>
                                                            </select>
                                                        </div>
                                                    </td>
                                                    <th class="C">범행도구조치</th>
                                                    <td class="L">
                                                        <div class="inputbox w100per">
                                                            <p class="txt">선택</p>
                                                            <select name="arst_criToolActn">
                                                            	<option value="">선택</option>
                                                            	<option value="1">01. 압수</option>
																<option value="2">02. 미발견</option>
                                                            </select>
                                                        </div>
                                                    </td>                                                                
                                                    <th class="C">범행도구 입수방법</th>
                                                    <td class="L">
                                                        <div class="inputbox w100per">
                                                            <p class="txt">선택</p>
                                                            <select name="arst_criToolAcqrWay">
                                                            	<option value="">선택</option>
                                                            	<option value="1">1. 종전부터소지</option>
																<option value="2">2. 매입</option>
																<option value="3">3. 대여받음</option>
																<option value="4">4. 절취</option>
																<option value="5">5. 습득</option>
																<option value="6">6. 피해자것사용</option>
																<option value="7">7. 자기가만듬</option>
																<option value="8">8. 기타</option>
                                                            </select>
                                                        </div>
                                                    </td>                                                                
                                                </tr>                                                       
                                                <tr>
                                                    <th class="C">검거단서</th>
                                                    <td class="L" colspan="2">
                                                        <div class="inputbox w100per">
                                                            <p class="txt">선택</p>
                                                            <select name="arst_arstClue">
                                                            	<option value="">선택</option>
                                                            	<option value="01">01. 현행범</option>
																<option value="02">02. 피해자신고</option>
																<option value="03">03. 고소</option>
																<option value="04">04. 고발</option>
																<option value="05">05. 자수</option>
																<option value="06">06. 민간체포</option>
																<option value="07">07. 진정투서</option>
																<option value="08">08. 타인신고</option>
																<option value="09">09. 신문</option>
																<option value="10">10. 불심검문</option>
																<option value="11">11. 탐문정보</option>
																<option value="12">12. 안면식별</option>
																<option value="13">13. 감식자료</option>
																<option value="14">14. 변사체</option>
																<option value="15">15. 범죄수법</option>
																<option value="16">16. 발자국</option>
																<option value="17">17. 검사지휘</option>
																<option value="18">18. 타기관에서이송</option>
																<option value="19">19. 범행도구등발견</option>
																<option value="20">20. 장물</option>
																<option value="21">21. 전과조회</option>
																<option value="22">22. 기타</option>
                                                            </select>
                                                        </div>
                                                    </td>
                                                    <th class="C">장물 처분방법</th>
                                                    <td class="L">
                                                        <div class="inputbox w100per">
                                                            <p class="txt">선택</p>
                                                            <select name="arst_stgdDipWay">
                                                            	<option value="">선택</option>
                                                            	<option value="01">01. 전당포</option>
																<option value="02">02. 귀금속상</option>
																<option value="03">03. 고물상</option>
																<option value="04">04. 노점</option>
																<option value="05">05. 기타업자</option>
																<option value="06">06. 일반</option>
																<option value="07">07. 증여</option>
																<option value="08">08. 폐기</option>
																<option value="09">09. 피의자소비</option>
																<option value="10">10. 기타</option>
                                                            </select>
                                                        </div>
                                                    </td>                                                                
                                                    <th class="C">금전소비 용도</th>
                                                     <td class="L">
                                                        <div class="inputbox w100per">
                                                            <p class="txt">선택</p>
                                                            <select name="arst_stgdMonyCospUse">
                                                            	<option value="">선택</option>
                                                            	<option value="1">1. 유흥</option>
																<option value="2">2. 오락</option>
																<option value="3">3. 생활비</option>
																<option value="4">4. 도박</option>
																<option value="5">5. 학비</option>
																<option value="6">6. 증여</option>
																<option value="7">7. 소지중</option>
																<option value="8">8. 기타</option>
                                                            </select>
                                                        </div>
                                                    </td>                                                                
                                                </tr>                                                        
                                            </tbody>
                                        </table>
                                    </div>    
                
                                    <div class="listArea">
                                        <table class="list" cellpadding="0" cellspacing="0">
                                            <colgroup>
                                                <col width="6%" />
                                                <col width="6%" />
                                                <col width="*%" />
                                                <col width="*%" />
                                                <col width="*%" />
                                                <col width="*%" />
                                                <col width="*%" />
                                                <col width="*%" />
                                                <col width="*%" /> 
                                                <col width="*%" />
                                                <col width="*%" />
                                            </colgroup>
                                            <tbody>
                                                <tr>
                                                    <th class="C r_line" rowspan="5">회수상황</th>
                                                    <th class="C r_line" rowspan="4">회수액</th>
                                                    <th class="C">품명</th>
                                                    <td class="L r_line">1. 화폐</td>
                                                    <td class="L r_line">2. 자동차</td>
                                                    <td class="L r_line">3. 유가증권</td>
                                                    <td class="L r_line">4. 귀금속</td>
                                                    <td class="L r_line">5. 전기 전자제품</td>
                                                    <td class="L r_line">6. 오토바이자전거</td>
                                                    <td class="L r_line">7. 가구류</td>
                                                    <td class="L">회수액 합계</td>
                                                </tr>
                                                <tr>
                                                    <th class="C">금액(시가)</th>
                                                    <td class="L r_line"><label for="txt_70"></label><input type="text" class="w40per" id="txt_70" name="arst_collAmtMony" data-type="number" data-optional-value=true data-name="arst_collAmt" /><span class="sub_title">원</span></td>
                                                    <td class="L r_line"><label for="txt_71"></label><input type="text" class="w40per" id="txt_71" name="arst_collAmtCar" data-type="number" data-optional-value=true data-name="arst_collAmt" /><span class="sub_title">원</span></td>
                                                    <td class="L r_line"><label for="txt_72"></label><input type="text" class="w40per" id="txt_72" name="arst_collAmtMarkSecu" data-type="number" data-optional-value=true data-name="arst_collAmt" /><span class="sub_title">원</span></td>
                                                    <td class="L r_line"><label for="txt_73"></label><input type="text" class="w40per" id="txt_73" name="arst_collAmtJewy" data-type="number" data-optional-value=true data-name="arst_collAmt" /><span class="sub_title">원</span></td>
                                                    <td class="L r_line"><label for="txt_74"></label><input type="text" class="w40per" id="txt_74" name="arst_collAmtElecElenProd" data-type="number" data-optional-value=true data-name="arst_collAmt" /><span class="sub_title">원</span></td>
                                                    <td class="L r_line"><label for="txt_75"></label><input type="text" class="w40per" id="txt_75" name="arst_collAmtMocyBike" data-type="number" data-optional-value=true data-name="arst_collAmt" /><span class="sub_title">원</span></td>
                                                    <td class="L r_line"><label for="txt_76"></label><input type="text" class="w40per" id="txt_76" name="arst_collAmtFurnArtc" data-type="number" data-optional-value=true data-name="arst_collAmt" /><span class="sub_title">원</span></td>
                                                    <td class="L" rowspan="3"><span id="arst_collAmtTot"></span>원</td>
                                                </tr>
                                                <tr>
                                                    <th class="C">품명</th>
                                                    <td class="L r_line">8. 의류</td> 
                                                    <td class="L r_line">9. 기계류</td> 
                                                    <td class="L r_line">10. 농임산물</td> 
                                                    <td class="L r_line">11. 축산물</td> 
                                                    <td class="L r_line">12. 수산물</td> 
                                                    <td class="L r_line">13. 잡화</td> 
                                                    <td class="L r_line">14. 기타</td> 
                                                </tr>
                                                <tr>
                                                    <th class="C">금액(시가)</th>
                                                    <td class="L r_line"><label for="txt_80"></label><input type="text" class="w40per" id="txt_80" name="arst_collAmtClot" data-type="number" data-optional-value=true data-name="arst_collAmt" /><span class="sub_title">원</span></td>
                                                    <td class="L r_line"><label for="txt_81"></label><input type="text" class="w40per" id="txt_81" name="arst_collAmtMach" data-type="number" data-optional-value=true data-name="arst_collAmt" /><span class="sub_title">원</span></td>
                                                    <td class="L r_line"><label for="txt_82"></label><input type="text" class="w40per" id="txt_82" name="arst_collAmtFarmFortProd" data-type="number" data-optional-value=true data-name="arst_collAmt" /><span class="sub_title">원</span></td>
                                                    <td class="L r_line"><label for="txt_83"></label><input type="text" class="w40per" id="txt_83" name="arst_collAmtAmhbProd" data-type="number" data-optional-value=true data-name="arst_collAmt" /><span class="sub_title">원</span></td>
                                                    <td class="L r_line"><label for="txt_84"></label><input type="text" class="w40per" id="txt_84" name="arst_collAmtMarnProd" data-type="number" data-optional-value=true data-name="arst_collAmt" /><span class="sub_title">원</span></td>
                                                    <td class="L r_line"><label for="txt_85"></label><input type="text" class="w40per" id="txt_85" name="arst_collAmtMcgd" data-type="number" data-optional-value=true data-name="arst_collAmt" /><span class="sub_title">원</span></td>
                                                    <td class="L r_line"><label for="txt_86"></label><input type="text" class="w40per" id="txt_86" name="arst_collAmtEtc" data-type="number" data-optional-value=true data-name="arst_collAmt" /><span class="sub_title">원</span></td>
                                                </tr>
                                                <tr>
                                                    <th class="C" colspan="2">회수정도</th>
                                                    <td claas="L" colspan="8">
                                                        <div class="inputbox w100per">
                                                            <p class="txt">선택</p>
                                                            <select name="arst_collDegrCd">
                                                            	<option value="">선택</option>
                                                            	<option value="1">1. 전부</option>
																<option value="2">2. 1/2이상</option>
																<option value="3">3. 1/2미만</option>
																<option value="4">4. 미회수</option>
                                                            </select>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>      

									<div class="btnArea" data-name="occrArea01">
										<div class="r_btn">
											<a href="javascript:insertArstStsGrap();" class="btn_white"><span>저 장</span></a>
										</div>
									</div>
									
									<div class="btnArea" data-name="occrArea02" style="display:none">
										<div class="r_btn">
											<a href="javascript:updateArstStsGrap();" class="btn_white"><span>저 장</span></a>
											<a href="javascript:void(0);" class="btn_blue" id="arstPrnBtn" data-always="y"><span>인쇄</span></a>
										</div>
									</div>

								</div>
							</li>
							
							<li class="m3"><a href="javascript:void(0);" id="spStsGrapLink" class="tab_small_title" data-always="y"><span>피의자통계원표</span></a>
								<div class="tab_small_contents">
								
									<input type="hidden" id="sp_spStsGrapNum" name="sp_spStsGrapNum" value="" />
									<input type="hidden" id="sp_stsGrapPublYrmh" name="sp_stsGrapPublYrmh" value="" />
									<input type="hidden" id="sp_incSpNum" name="sp_incSpNum" value="" />
									<input type="hidden" id="sp_rcptNum" name="sp_rcptNum" value="" />
									<input type="hidden" id="sp_actVioNum" name="sp_actVioNum" value="" />
									<input type="hidden" id="sp_rcptNum" name="sp_rcptNum" value="" />
									<input type="hidden" id="sp_rltActCriNmCd" name="sp_rltActCriNmCd" value="" />

									<div class="listArea">
										<table class="list line_none" cellpadding="0" cellspacing="0">
											<colgroup>
												<col width="6%" />
												<col width="14%" />
												<col width="15%" />
												<col width="15%" />
												<col width="15%" />
												<col width="15%" />
											</colgroup>
											<thead>
												<tr>
													<th class="C" colspan="2">검거(최종처리)수사기관</th>
													<th class="C">본표번호</th>
													<th class="C">수사 사건부 번호</th>
													<th class="C">관계 발생사건표 번호</th>
													<th class="C">관계 검거사건표 번호</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td class="C r_line" colspan="2">금융감독원<br /> 자본시장특별사법경찰</td>
													<td class="C" rowspan="2">미입력</td>
													<td class="C" rowspan="2">${todayDate } <br />제 <span id="StsIncrcptNum3"></span></td>
													<td class="C" rowspan="2">${todayDate } <br />제   호</td>
													<td class="C" rowspan="2">${todayDate } <br />제   호</td>
												</tr>
												<tr>
													<td class="C r_line">코드</td>
													<td class="C r_line">2190105</td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="listArea">
										<table class="list" cellpadding="0" cellspacing="0">
											<colgroup>
												<col width="10%" />
												<col width="23%" />
												<col width="10%" />
												<col width="23%" />
												<col width="10%" />
												<col width="*%" />
											</colgroup>
											<tbody>
												<tr>
													<th class="C" rowspan="2">작성년월</th>
													<td class="L" rowspan="2">${todayDate }</td>
													<th class="C" rowspan="2">죄명</th>
													<td class="L" colspan="3"><span id="sp_actVioClaNm"></span></td>
												</tr>
												<tr>
													<td class="L" colspan="3">
														<div class="inputbox w40per">
															<p class="txt"></p>
															<select name="sp_rltActCriNmCdDesc">
															</select>                                                                                
														</div>
													</td>
												</tr>
												<tr>
													<th class="C">가정폭력</th>
													<td class="L">
														<input name="sp_famyVioYn" id="submit_18" type="radio" class="radio_pd radio_first" value="1" /><label for="submit_18">1. 유</label>
														<input name="sp_famyVioYn" id="submit_19" type="radio" class="radio_pd" value="2" /><label for="submit_19">2. 무</label>
													</td>
													<th class="C">학교폭력</th>
													<td class="L">
														<input name="sp_schlVioYn" id="submit_20" type="radio" class="radio_pd radio_first" value="1" /><label for="submit_20">1. 유</label>
														<input name="sp_schlVioYn" id="submit_21" type="radio" class="radio_pd" value="2" /><label for="submit_21">2. 무</label>
													</td>
													<th class="C">외국인코드</th>
													<td class="L">
														<span class="sub_title">1. 국적</span><label for="txt_59"></label><input type="text" name="sp_forgCdNaty" class="w30per" id="txt_59" />
														<span class="sub_title">2. 신분</span><label for="txt_60"></label><input type="text" name="sp_forgCdPosi" class="w30per" id="txt_60" />
													</td>
												</tr>
											</tbody>
										</table>   
									</div>          

									<div class="listArea">
										<table class="list" cellpadding="0" cellspacing="0">
											<colgroup>
												<col width="8%" />
												<col width="*%" />
												<col width="*%" />
												<col width="*%" />
												<col width="*%" />
												<col width="*%" />
												<col width="*%" />
												<col width="*%" />
												<col width="*%" />
											</colgroup>
											<tbody>
												<tr>
													<th class="C" colspan="2">성명</th>
													<td class="L"><span id="sp_spNm"></span></td>
													<th class="C">주민(여권)번호</th>
													<td class="L"><span id="sp_spIdNum"></span></td>
													<th class="C">범행시연령</th>
													<td class="L"><label for="sp_criTimeAge"></label><input type="text" name="sp_criTimeAge" class="w30per" id="sp_criTimeAge" /></td>
													<th class="C">성별</th>
													<td class="L"> 
														<input name="sp_gendDiv" id="submit_22" type="radio" class="radio_pg radio_first" value="M" data-always="y" disabled="disabled"/><label for="submit_22"></label>
														<span class="sub_title">1. 남</span>
														<input name="sp_gendDiv" id="submit_23" type="radio" class="radio_pg" value="W" data-always="y" disabled="disabled"/><label for="submit_23"></label>
														<span class="sub_title">2. 여</span>
													</td>
												</tr>
												<tr>
													<th class="C" colspan="2">직업</th>
													<td class="L" colspan="7">
														<div class="inputbox w20per">
															<p class="txt">선택</p>
															<select name="sp_jobCd">
																<option value="">선택</option>
																<option value="00">공무원</option>
																<option value="01">01. 농임수산업</option>
																<option value="02">02. 광업</option>
																<option value="03">03. 제조업</option>
																<option value="04">04. 건설업</option>
																<option value="05">05. 도소매업</option>
																<option value="06">06. 무역업</option>
																<option value="07">07. 요식업</option>
																<option value="08">08. 숙박업</option>
																<option value="09">09. 유흥업</option>
																<option value="10">10. 금융업</option>
																<option value="11">11. 부동산업</option>
																<option value="12">12. 의료보건업</option>
																<option value="13">13. 차량정비업</option>
																<option value="14">14. 노점</option>
																<option value="15">15. 행상</option>
																<option value="16">16. 기타사업</option>
																<option value="17">17. 교원(사립)</option>
																<option value="18">18. 사무원</option>
																<option value="19">19. 기술자</option>
																<option value="20">20. 점원</option>
																<option value="21">21. 공원</option>
																<option value="22">22. 운전사</option>
																<option value="23">23. 경비원</option>
																<option value="24">24. 외판원</option>
																<option value="25">25. 국공영기업체직원</option>
																<option value="26">26. 일반회사원</option>
																<option value="27">27. 금융기관직원</option>
																<option value="28">28. 유흥업종사자</option>
																<option value="29">29. 요식업종사자</option>
																<option value="30">30. 일용노동자</option>
																<option value="31">31. 기타피고용자</option>
																<option value="32">32. 의사</option>
																<option value="33">33. 변호사</option>
																<option value="34">34. 교수</option>
																<option value="35">35. 종교가</option>
																<option value="36">36. 언론인</option>
																<option value="37">37. 예술인</option>
																<option value="38">38. 기타전문직</option>
																<option value="41">41. 학생</option>
																<option value="42">42. 주부</option>
																<option value="43">43. 전경의경</option>
																<option value="44">44. 공익요원</option>
																<option value="97">97. 법인</option>
																<option value="98">98. 무직자</option>
																<option value="99">99. 미상</option>
															</select>
														</div>
														<div id="sp_jobCd_subDiv" style="display:none;">
															<span class="sub_title">소속코드</span>
															<label for="txt_61"></label><input type="text" class="w20per" name="sp_puofBelgCd" id="txt_61" />
															<span class="sub_title">계급코드</span>
															<label for="txt_62"></label><input type="text" class="w20per" name="sp_puofClasCd" id="txt_62" />
															<span class="sub_title">직무관련성</span>
															<input name="sp_puofDutyRelv" id="submit_24" type="radio" class="radio_pg radio_first l_margin" value="1" /><label for="submit_24"></label>
															<span class="sub_title">1. 유</span>
															<input name="sp_puofDutyRelv" id="submit_25" type="radio" class="radio_pg" value="2" /><label for="submit_25"></label>
															<span class="sub_title">2. 무</span>
														</div>
													</td>
												</tr>
												<tr>
													<th class="C" colspan="2">전과</th>
													<td class="L" colspan="7">
														<div class="inputbox w40per">
															<p class="txt">선택</p>
															<select name="sp_crrdCd">
																<option value="">선택</option>
																<option value="0">0. 없음</option>
																<option value="1">1. 1범</option>
																<option value="2">2. 2범</option>
																<option value="3">3. 3범</option>
																<option value="4">4. 4범</option>
																<option value="5">5. 5범</option>
																<option value="6">6. 6범</option>
																<option value="7">7. 7범</option>
																<option value="8">8. 8범</option>
																<option value="9">9. 9범이상</option>
															</select>                                                                                
														</div>
													</td>
												</tr>
												<tr>
													<th class="C r_line" rowspan="2">재범상황</th>
													<th class="C">전회처분 내용</th>
													<td class="L" colspan="3">
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="sp_secvSituLastDipCont">
																<option value="">선택</option>
																<option value="00">00. 없음</option>
																<option value="01">01. 즉결심판</option>
																<option value="02">02. 기소유예</option>
																<option value="03">03. 선고유예</option>
																<option value="04">04. 수배중</option>
																<option value="05">05. 보호처분</option>
																<option value="06">06. 선고유예</option>
																<option value="07">07. 집행유예중</option>
																<option value="08">08. 보석 형집행 정지중</option>
																<option value="09">09. 가석방</option>
																<option value="10">10. 형(재산형포함)집행종료</option>
																<option value="11">11. 감호소출소</option>
																<option value="12">12. 기타</option>
															</select>
														</div>
													</td>
													<th class="C">보호처분</th>
													<td class="L" colspan="3">
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="sp_secvSituProtDip">
																<option value="">선택</option>
																<option value="0">0. 없음</option>
																<option value="1">1. 1회</option>
																<option value="2">2. 2회</option>
																<option value="3">3. 3회이상</option>
															</select>
														</div>
													</td>
												</tr>
												<tr>    
													<th class="C">재범기간</th>
													<td class="L" colspan="3">
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="sp_secvSituSecvPi">
																<option value="">선택</option>
																<option value="1">1. 1개월이내</option>
																<option value="2">2. 3개월이내</option>
																<option value="3">3. 6개월이내</option>
																<option value="4">4. 1년이내</option>
																<option value="5">5. 2년이내</option>
																<option value="6">6. 3년이내</option>
																<option value="7">7. 3년초과</option>
															</select>
														</div>
													</td>
													<th class="C">재범종류</th>
													<td class="L" colspan="3">
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="sp_secvSituSecvType">
																<option value="">선택</option>
																<option value="1">1. 동종</option>
																<option value="2">2. 이종</option>
															</select>
														</div>
													</td>
												</tr>
												<tr>
													<th class="C" colspan="2">공범관계</th>
													<td class="L" colspan="2">
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="sp_acmpRelt">
																<option value="">선택</option>
																<option value="01">01. 단독범</option>
																<option value="02">02. 학교동창</option>
																<option value="03">03. 교도소소년원동료</option>
																<option value="04">04. 직장동료</option>
																<option value="05">05. 친인척</option>
																<option value="06">06. 군동료</option>
																<option value="07">07. 동네친구</option>
																<option value="08">08. 고향친구</option>
																<option value="09">09. 애인</option>
																<option value="10">10. 기타</option>
															</select>
														</div>
													</td>
													<th class="C">피해자와의관계</th>
													<td class="L">
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="sp_vicmRelt">
																<option value="">선택</option>
																<option value="01">01. 국가</option>
																<option value="02">02. 공무원</option>
																<option value="03">03. 고용자</option>
																<option value="04">04. 피고용자</option>
																<option value="05">05. 직장동료</option>
																<option value="06">06. 친구</option>
																<option value="07">07. 애인</option>
																<option value="08">08. 동거친족</option>
																<option value="09">09. 기타친족</option>
																<option value="10">10. 거래상대방</option>
																<option value="11">11. 이웃</option>
																<option value="12">12. 지인</option>
																<option value="13">13. 타인</option>
																<option value="14">14. 기타</option>
															</select>
														</div>
													</td>
													<th class="C">범행후 은신처</th>
													<td class="L" colspan="2">
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="sp_criAftrHdot">
																<option value="">선택</option>
																<option value="01">01. 자기집</option>
																<option value="02">02. 공범집</option>
																<option value="03">03. 애인집</option>
																<option value="04">04. 친족집</option>
																<option value="05">05. 지인집</option>
																<option value="06">06. 숙박업소</option>
																<option value="07">07. 야외</option>
																<option value="08">08. 현장검거</option>
																<option value="09">09. 외국</option>
																<option value="10">10. 기타</option>
															</select>
														</div>
													</td>
												</tr>
												<tr>
													<th class="C" colspan="2">마약류등 상용여부</th>
													<td class="L" colspan="2">
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="sp_drugCmusYn">
																<option value="">선택</option>
																<option value="1">1. 마약</option>
																<option value="2">2. 대마</option>
																<option value="3">3. 향정신성의약품</option>
																<option value="4">4. 본드신나등환각물질</option>
																<option value="5">5. 알콜</option>
																<option value="6">6. 해당무</option>
															</select>
														</div>
													</td>
													<th class="C">범행시 정신상태</th>
													<td class="L">
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="sp_criTimeMindStat">
																<option value="">선택</option>
																<option value="1">1. 정상</option>
																<option value="2">2. 정신이상</option>
																<option value="3">3. 정신박약</option>
																<option value="4">4. 기타정신장애</option>
																<option value="5">5. 주취</option>
																<option value="6">6. 월경시 이상</option>
															</select>
														</div>
													</td>
													<th class="C">범행동기</th>
													<td class="L" colspan="2">
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="sp_criMotv">
																<option value="">선택</option>
																<option value="01">01. 생활비마련</option>
																<option value="02">02. 유흥비마련</option>
																<option value="03">03. 도박비마련</option>
																<option value="04">04. 허영사치심</option>
																<option value="05">05. 치부이욕</option>
																<option value="06">06. 기타이욕</option>
																<option value="07">07. 사행심</option>
																<option value="08">08. 신고고소보복</option>
																<option value="09">09. 수사협조보복</option>
																<option value="10">10. 증언보복</option>
																<option value="11">11. 기타보복</option>
																<option value="12">12. 가정불화</option>
																<option value="13">13. 호기심</option>
																<option value="14">14. 유혹</option>
																<option value="15">15. 우발적</option>
																<option value="16">16. 현실불만</option>
																<option value="17">17. 부주의</option>
																<option value="18">18. 기타</option>
															</select>
														</div>
													</td>
												</tr>

												<tr>
													<th class="C" colspan="2">학력</th>
													<td class="L" colspan="2">
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="sp_acab">
																<option value="">선택</option>
																<option value="01">01. 불취학</option>
																<option value="02">02. 초등학교재중</option>
																<option value="03">03. 초등학교중퇴</option>
																<option value="04">04. 초등학교졸업</option>
																<option value="05">05. 중학교재중</option>
																<option value="06">06. 중학교중퇴</option>
																<option value="07">07. 중학교졸업</option>
																<option value="08">08. 고등학교재중</option>
																<option value="09">09. 고등학교중퇴</option>
																<option value="10">10. 고등학교졸업</option>
																<option value="11">11. 전문대학재중</option>
																<option value="12">12. 전문대학중퇴</option>
																<option value="13">13. 전문대학졸업</option>
																<option value="14">14. 일반대학재중</option>
																<option value="15">15. 일반대학중퇴</option>
																<option value="16">16. 일반대학졸업</option>
																<option value="17">17. 대학원</option>
																<option value="18">18. 기타</option>
																<option value="19">19. 미상</option>
															</select>
														</div>
													</td>
													<th class="C">생활정도</th>
													<td class="L">
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="sp_livgDegr">
																<option value="">선택</option>
																<option value="1">1. 하류</option>
																<option value="2">2. 중류</option>
																<option value="3">3. 상류</option>
															</select>
														</div>
													</td>
													<th class="C">종교</th>
													<td class="L">
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="sp_relg">
																<option value="">선택</option>
																<option value="1">1. 불교</option>
																<option value="2">2. 기독교</option>
																<option value="3">3. 천주교</option>
																<option value="4">4. 원불교</option>
																<option value="5">5. 천도교</option>
																<option value="6">6. 기타종교</option>
																<option value="7">7. 종교무</option>
															</select>
														</div>
													</td>
												</tr>
												<tr>
													<th class="C" colspan="2">혼인관계</th>
													<td class="L" colspan="2">
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="sp_margRelt">
																<option value="">선택</option>
																<option value="1">1. 유 배우자</option>
																<option value="2">2. 동거</option>
																<option value="3">3. 이혼</option>
																<option value="4">4. 사별</option>
																<option value="5">5. 미혼</option>
															</select>
														</div>
													</td>
													<th class="C" colspan="2">부모관계(미혼자에한함)</th>
													<td class="L" colspan="3">
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="sp_pareRelt">
																<option value="">선택</option>
																<option value="1">1. 실(양)부모</option>
																<option value="2">2. 계부모</option>
																<option value="3">3. 실부계모</option>
																<option value="4">4. 실부무모</option>
																<option value="5">5. 실모계부</option>
																<option value="6">6. 실모무부</option>
																<option value="7">7. 계부무모</option>
																<option value="8">8. 계모무부</option>
																<option value="9">9. 무부모</option>
															</select>
														</div>
													</td>
												</tr>
											</tbody>
										</table>
									</div>


									<div class="listArea">
										<table class="list" cellpadding="0" cellspacing="0">
											<colgroup>
												<col width="15%" />
												<col width="35%" />
												<col width="15%" />
												<col width="35%" />
											</colgroup>
											<tbody>
												<tr>                                                                    
													<th class="C">검거자(경찰)</th>
													<td class="L" colspan="3">
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="sp_arstPolf">
																<option value="">선택</option>
																<option value="01">01. 수사형사</option>
																<option value="02">02. 외근112차</option>
																<option value="03">03. 교통</option>
																<option value="04">04. 검문소</option>
																<option value="05">05. 기타경찰</option>
																<option value="06">06. 방법원</option>
																<option value="07">07. 경비원</option>
																<option value="08">08. 피해자</option>
																<option value="09">09. 기타민간인</option>
																<option value="10">10. 기타</option>
															</select>
														</div>
													</td>
												</tr>
												<tr>
													<th class="C">조치</th>
													<td class="L"> 
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="sp_actn">
																<option value="">선택</option>
																<option value="1">1. 검찰(군)구속(송치)</option>
																<option value="2">2. 검찰(군)불구속(송치)</option>
															</select>
														</div>
													</td>
													<th class="C">자백여부</th>
													<td class="L"> 
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="sp_confYn">
																<option value="">선택</option>
																<option value="1">1. 자백</option>
																<option value="2">2. 일부자맥</option>
																<option value="3">3. 부인</option>
																<option value="4">4. 묵비</option>
															</select>
														</div>
													</td>
												</tr>
												<tr>
													<th class="C">구속별</th>
													<td class="L"> 
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="sp_arrtClsf">
																<option value="">선택</option>
																<option value="1">1. 현행범체포</option>
																<option value="2">2. 긴급체포</option>
																<option value="3">3. 사전영장</option>
																<option value="4">4. 체포</option>
															</select>
														</div>
													</td>
													<th class="C">불구속별</th>
													<td class="L"> 
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="sp_nonArrtClsf">
																<option value="">선택</option>
																<option value="1">1. 불구속입건</option>
																<option value="2">2. 검사기각</option>
																<option value="3">3. 판사기각</option>
																<option value="4">4. 적부심석발</option>
																<option value="5">5. 검사구속취소</option>
															</select>
														</div>
													</td>
												</tr>
												<tr>
													<th class="C">송치의견</th>
													<td class="L"> 
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="sp_trfOp">
																<option value="">선택</option>
																<option value="01">01. 구속기소</option>
																<option value="02">02. 불구속기소</option>
																<option value="03">03. 소년보호송치</option>
																<option value="04">04. 기소유예</option>
																<option value="05">05. 기소중지</option>
																<option value="06">06. 혐의없음</option>
																<option value="07">07. 죄가안됨</option>
																<option value="08">08. 공소권없음</option>
																<option value="09">09. 공소보류</option>
																<option value="10">10. 이송</option>
																<option value="11">11. 참고인중지</option>
																<option value="12">12. 가정보호송치</option>
															</select>
														</div>
													</td>
													<th class="C">사건 처리 기간</th>
													<td class="L"> 
														<div class="inputbox w100per">
															<p class="txt">선택</p>
															<select name="sp_incHandPi">
																<option value="">선택</option>
																<option value="1">1. 10일이내</option>
																<option value="2">2. 20일이내</option>
																<option value="3">3. 1개월이내</option>
																<option value="4">4. 2개월이내</option>
																<option value="5">5. 3개월이내</option>
																<option value="6">6. 6개월이내</option>
																<option value="7">7. 6개월초과</option>
															</select>
														</div>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="btnArea" data-name="occrArea01">
										<div class="r_btn">
											<a href="javascript:insertSpStsGrap();" class="btn_white"><span>저 장</span></a>
										</div>
									</div>
									<div class="btnArea" data-name="occrArea02" style="display:none">
										<div class="r_btn">
											<a href="javascript:updateSpStsGrap();" class="btn_white"><span>저 장</span></a>
											<a href="javascript:void(0);" class="btn_blue" id="spPrnBtn" data-always="y"><span>인쇄</span></a>
										</div>
									</div>
								</div>
							</li>
						</ul>
					</div>    
				</div>
			</li>
			<li class="m6" style="display:none;"><a href="javascript:selectTrfInfo();" class="tabtitle" data-always="y"><span>송치정보</span></a>
            
				<div class="tab_mini_contents" id="tab_mini_m6_contents">
                    <br/><br/>
                    <div id="step_tab">
                        <ul class="step_tab ocrt_tab clearfix">
                            <li class="ocrt_sub_tab sub_tab_on" id="ocrt_list_tab0" data-href="selectIncCriCmdItemDetails()"><span class="on"><a href="javascript:void(0);" data-always="y">수사지휘 <br/><em id="ocrt_list_tab0_em" class="situation">완료</em></a></span><em class="step_txt">수사지휘</em></li>
                                                        
                            <li class="ocrt_sub_tab" id="ocrt_list_tab1" data-href="selectIncTrfItemDetails()"><span class="on"><a href="javascript:void(0);" data-always="y">송치 <br/><em id="ocrt_list_tab1_em" class="situation">완료</em></a></span><em class="step_txt">송치</em></li>
                            
                            <li class="ocrt_sub_tab" id="ocrt_list_tab2" data-href="selectIncDipRstDetails()"><span class="on"><a href="javascript:void(0);" data-always="y">검찰처분 <br/><em id="ocrt_list_tab2_em" class="situation">완료</em></a></span><em class="step_txt">처분</em></li>
                            
                            <li class="ocrt_sub_tab" id="ocrt_list_tab3" data-href="selectIncJdtRstDetails()"><span class="on"><a href="javascript:void(0);" data-always="y">법원판결 <br/><em id="ocrt_list_tab3_em" class="situation">완료</em></a></span><em class="step_txt">판결</em></li>
                        </ul>
                        <br/><br/>
                        <!--//ocrt_wrap-->
                        <div class="ocrt_wrap clearfix">
                            
                            <!--지휘부관리-->
                            <div class="ocrt_01 ocrt_list_tab0 list" id="ocrt_list_tab0_div">
                                <div id="ocrt_list_tab0_div_step1">
                            	
                            	</div>
                            	<div id="ocrt_list_tab0_div_step2" style="display: none;">
                            		<h4>지휘서류 업로드</h4>
									<div id="vault_upload" class="righr_box" style="height: 200px; width: 100%"></div>
									<ul id="vault_fileList" style="display: none;">
									</ul>
									<form name="setFileList" method="post" target="invisible" action="${cPath }/sjpb/fileMngr?cmd=delete">
										<input type=hidden name=semaphore value="<c:out value=""/>">
										<input type=hidden name=vaccum> 
										<input type=hidden name=delBoardId value="<c:out value=""/>">
										<input type=hidden name=unDelList> 
										<input type=hidden name=delList> 
										<input type=hidden name=subId value=sub01>
									</form>
									<div class="btnArea">
										<div class="r_btn">
											<a href="#" id="fileBtn" class="btn_white"><span>저장</span></a>
										</div>
									</div>
                            		<h4 >지휘서류 목록</h4>							
									<div id="sheetIncCmdDT" class="listArea area-mousewheel" style="height: 200px; width: 100%"></div>
                            	</div>
                            </div>
                            
                            <!--//지휘부관리-->
                            <!--사건송치부관리-->
                            <div class="ocrt_01 ocrt_list_tab1 list none" id="ocrt_list_tab1_div">
                            
                            	<div id="ocrt_list_tab1_div_step1">
                            		
                            	</div>
                            	
                            	<div id="ocrt_list_tab1_div_step2" style="display: none;">
                            		<h4>송치서류 업로드</h4>
		                            <div id = "vault_upload" class="righr_box" style="height: 200px; width: 100%"></div>
		                            <ul id="vault_fileList" style="display: none;"></ul>
									<form name="setFileList" method="post" target="invisible" action="${cPath }/sjpb/fileMngr?cmd=delete">
										<input type=hidden name=semaphore value="<c:out value=""/>">
										<input type=hidden name=vaccum>
										<input type=hidden name=delBoardId value="<c:out value=""/>">
										<input type=hidden name=unDelList>
										<input type=hidden name=delList>
										<input type=hidden name=subId value=sub01>
									</form>								
		                           	<div class="btnArea">
		                               <div class="r_btn"><a href="#" id="fileBtn" class="btn_white"><span>저장</span></a></div>
		                           	</div>
		                           	
                            		<h4 >송치서류 목록</h4>							
									<div id="sheetTrfDT" class="listArea area-mousewheel" style="height: 200px; width: 100%"></div>
                            	</div>
                            </div>
                            <!--//사건송치부관리-->
                            <!--사건처분관리-->
                            <div class="ocrt_01 ocrt_list_tab2 list none" id="ocrt_list_tab2_div">
                            </div>
                            <!--//사건처분관리-->
                            <!--사건판결관리-->
                            <div class="ocrt_01 ocrt_list_tab3 list none" id="ocrt_list_tab3_div">     	
                            </div>
                            <!--//사건판결관리-->
                        </div>
					</div>
				</li>
				<li class="m7" style="display:none;"><a href="javascript:incRecordsTab();" id="incRecordsTab" class="tabtitle" data-always="y"><span>수사기록철</span></a>
					<div class="tab_mini_contents" id="tab_mini_m7_contents">
				   		<div class="btnArea">
							<div class="r_btn">
								총 <span id="total"></span>페이지
							</div>
						</div>
				   		<div id="sheetRecords" class="listArea area-mousewheel" style="height: 400px; width: 100%; ">
				   		</div>
				   		<div class="btnArea">
							<div class="r_btn">
								<a href="javascript:addRecord();" class="btn_white" id="newRcdBtn"><span>신규</span></a>
								<a href="javascript:removeRecord();" class="btn_white" id="delRcdBtn"><span>삭제</span></a>
							</div>
						</div>
						<div id="tab_mini_m7_contents_sub"></div>
						<div class="btnArea">
							<div class="r_btn">
								<a href="javascript:saveRecord();" class="btn_white" id="saveRcdBtn"><span>저장</span></a>
							</div>
						</div>
			   		</div>
			   	</li>
		   </ul>
	   </div>
	</body>
</html>
