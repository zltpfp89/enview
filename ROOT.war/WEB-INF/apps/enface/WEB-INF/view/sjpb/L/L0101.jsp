<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Iterator" %>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<html>
	<head>
		<title>인사관리</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-style-type" content="text/css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/Z/jquery.base64.js"></script>			
        <script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/L/L0101.js?r=<%=Math.random()%>"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/L/L0102.js?r=<%=Math.random()%>"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/L/L0103.js?r=<%=Math.random()%>"></script>	
	</head>
	<body class="iframe">
		<!-- report -->
		<form name="reportForm" method="post">
			<input type="hidden" id="reptNm" name="reptNm" value="" />
			<input type="hidden" id="xmlData" name="xmlData" value="" />
		</form>		
		
		<form name="contentsFormData" id="contentsFormData">
		<input type="hidden" id="userId" name="userId" value="${userInfo.userId}" />   <!-- 사용자계정 -->
		<input type="hidden" id="userName" name="userName" value="${userInfo.userName}" />  <!-- 사용자이름 -->
		<input type="hidden" id="orgCd" name="orgCd" value="${userInfo.orgCd}" />   <!-- 수사팀코드 -->
		<input type="hidden" id="kindCdH" name="kindCdH" value="${userInfo.kindCd}" />  <!-- 수사단원구분 01:수사관 02:팀장 03:과장 -->	
		<input type="hidden" id="today" name="today" value="${stsGrapFillDtToSC}" />  <!-- 오늘날짜 -->
		<input type="hidden" id="isDupId" name="isDupId" value="" />  <!-- 계정중복여부 -->

	   <!-- searchArea -->
	   <div class="searchArea">
		   <ul>
			   <li><span class="title">수사팀</span>
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
			   <li><span class="title">수사관</span>
				   <label for="nmKorSC"></label><input type="text" class="w65per" id="nmKorSC" name="nmKorSC" />
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
				<a href="#" class="btn_white" id="initBtn"><span>초기화</span></a>
				<a href="#" class="btn_blue" id="srchBtn"><span>검색</span></a>
			</div>
	   </div>
	   <!-- searchArea //-->
	   <!-- listArea -->
	   <div id="sheet" class="listArea" style="height: 250px; width: 100%">
	   </div>
	   <!-- listArea //-->
	   <!-- btnArea -->
	   <div class="btnArea" >
		   <div class="r_btn">
			   <!-- <a href="#" class="btn_white" id="batBtn"><span>일괄배치</span></a> -->
			   <a href="#" class="btn_blue" id="addBtn"><span>신규</span></a>	                                   
		   </div>
	   </div> 
	   <!-- btnArea //-->
                                 
	   <div class="tab_mini_wrap m1" id="contentsArea">                               	
		   <ul>
			   <li class="m1"><a href="#" class="tabtitle" id="criMbDtsTab"><span>인사정보</span></a>                                                                              
				   <!-- tab_contents -->
				   <div class="tab_mini_contents">
					   <table class="list" cellpadding="0" cellspacing="0">
						   <colgroup>
							   <col width="15%" />
							   <col width="35%" />
							   <col width="15%" />
							   <col width="35%" />
						   </colgroup>
						   <tbody>
							   <tr>
								   <th class="C">계정<em class="red">*</em></th>
								   <td class="L"><label for="criMbId"></label><input type="text" class="w50per" name="criMbId" id="criMbId" title="계정" data-type="required" />
								   <div class="r_btn" style="display:none" id="dupDiv">
										<a href="#" class="btn_white" id="dupBtn"><span>계정중복확인</span></a>
									</div>                                                           
								   </td>
								   <th class="C">이름<em class="red">*</em></th>
								   <td class="L"><label for="nmKor"></label><input type="text" class="w100per" name="nmKor" id="nmKor" title="이름" data-type="required" /></td>                                                           
							   </tr>                                                   
							   <tr>

								   <th class="C">계정상태</th>
								   <td class="L">
									   <div class="inputbox w100per">
										   <p class="txt"></p>
										   <select id="isEnabled" name="isEnabled" data-type="select">
												<option value="">선택</option>
												<c:forEach items="${criMbStatList}" var="item">
												   <option value="${item.code}">${item.codeName}</option>
												</c:forEach>    
										   </select>
									   </div>
									</td>   
									<th class="C">로그인 실패회수</th>
									<td class="L"><span id="authFailures">0</span></td>
							   </tr>
							   <tr>
								   <th class="C">패스워드<em class="red">*</em></th>
								   <td class="L"><label for="criMbPwd"></label><input type="password" class="w60per" name="criMbPwd" id="criMbPwd" title="패스워드" data-type="required" autocomplete="off" />&nbsp;&nbsp;<span id="genPwdSpan"></span>
								   </td>
								   <th class="C">패스워드확인<em class="red">*</em></th>
								   <td class="L"><label for="criMbPwdRe"></label><input type="password" class="w50per" name="criMbPwdRe" id="criMbPwdRe" title="패스워드 확인"  data-type="required" autocomplete="off" />
									<div class="r_btn">
										<a href="#" class="btn_white" id="pwdBtn"><span>비밀번호 생성</span></a>
									</div>
								   </td>
							   </tr>                                                           
							   <tr>
							   
								   <th class="C">이메일<em class="red">*</em></th>
								   <td class="L"><label for="emailAddr"></label><input type="text" class="w100per" name="emailAddr" id="emailAddr" data-type="email" title="이메일" data-type="required"/></td>
								   <th class="C">직렬</th>
								   <td class="L">
									   <div class="inputbox w100per">
										   <p class="txt"></p>
										   <select id="criMbSroc" name="criMbSroc">
												<option value="">선택</option>	
												<c:forEach items="${criMbSrocList}" var="item">
												   <option value="${item.code}">${item.codeName}</option>
												</c:forEach> 																	
										   </select>
									   </div>                                                               
								   </td>
								   
							   </tr>           
							   <tr>
								   <th class="C">직급</th>
								   <td class="L">
									   <div class="inputbox w100per">
										   <p class="txt"></p>
										   <select id="criMbClas" name="criMbClas" >
												<option value="">선택</option>	
												<c:forEach items="${criMbClasList}" var="item">
												   <option value="${item.code}">${item.codeName}</option>
												</c:forEach> 																									   																			
										   </select>
									   </div>                                                              
								   </td> 													   
								   <th class="C">직위<em class="red">*</em></th>
								   <td class="L">
									   <div class="inputbox w100per">
										   <p class="txt"></p>
										   <select id="criMbPosi" name="criMbPosi" data-type="select" title="직위" >
												<option value="">선택</option>	
												<c:forEach items="${criMbPosiList}" var="item">
												   <option value="${item.code}">${item.codeName}</option>
												</c:forEach> 																									   																			
										   </select>
									   </div>                                                               
								   </td>                                                           
							   </tr>
							   <tr>
								   <th class="C">소속팀<em class="red">*</em></th>
								   <td class="L">
									   <div class="inputbox w100per">
										   <p class="txt"></p>
										   <select id="criTmId" name="criTmId" data-type="select" title="소속팀(부서)">
												<option value="">선택</option>
												<c:forEach items="${criTmList}" var="item">
													<option value="${item.criTmId}">${item.criTmNm}</option> 
												</c:forEach>																   																				
										   </select>
									   </div>                                                               
								   </td>
								   <th class="C">현재직급일</th>
								   <td class="L"><label for="currPosiDt"></label><input type="text" class="w100per calendar datepicker" name="currPosiDt" id="currPosiDt" />
								   </td>   								   
							   </tr>  
							   <tr>
							   	   <th class="C">파견기관</th>
								   <td class="L">
									   <div class="inputbox w100per">
										   <p class="txt"></p>
										   <select id="dispGuof" name="dispGuof">
												<option value="">선택</option>	
												<c:forEach items="${dispGuofList}" var="item">
													 <option value="${item.code}">${item.codeName}</option>
												</c:forEach>																   																			
										   </select>
									   </div>                                                              
								   </td>
								   <th class="C">파견기간</th>
								    <td class="L"><label for="dispBeDt"></label><input type="text" class="w45per calendar datepicker" name="dispBeDt" id="dispBeDt" />~
								    <label for="dispEdDt"></label><input type="text" class="w45per calendar datepicker" name="dispEdDt" id="dispEdDt" />
								    </td>								   
							   </tr>      
								<tr>
							   	   <th class="C">별도정원</th>
								   <td class="L" colspan="3">
									   <div class="inputbox w100per">
										   <p class="txt"></p>
										   <select id="sprPsn" name="sprPsn">
												<option value="">선택</option>	
												<c:forEach items="${sprPsnList}" var="item">
													 <option value="${item.code}">${item.codeName}</option>
												</c:forEach>																   																			
										   </select>
									   </div>                                                              
								   </td>							   
							   </tr>           							                                                    							   
							   <tr>
								   <th class="C">수사관전입일</th>
								   <td class="L"><label for="criOffiApptDt"></label><input type="text" class="w100per calendar datepicker" name="criOffiApptDt" id="criOffiApptDt" />
								   </td>
								   <th class="C">수사관전출일</th>
								   <td class="L"><label for="criOffiEdDt"></label><input type="text" class="w100per calendar datepicker" name="criOffiEdDt" id="criOffiEdDt" />
								   </td>                                     
							   </tr>                                                       
							   
							   <tr>
								   <th class="C">전문관발령일</th>
								   <td class="L"><label for="criProfOffiBeDt"></label><input type="text" class="w100per calendar datepicker" name="criProfOffiBeDt" id="criProfOffiBeDt" />
								   </td>
								   <th class="C">전문관해지일</th>
								   <td class="L"><label for="criProfOffiEdDt"></label><input type="text" class="w100per calendar datepicker" name="criProfOffiEdDt" id="criProfOffiEdDt" />
								   </td>                                     
							   </tr>   
									  
							   <tr>
								   <th class="C">접속아이피</th>
								   <td class="L">                                                              
									  <label for="acesIpA"></label><input type="text" class="w20per" name="acesIpA" id="acesIpA" data-type="number" title="접속아이피" data-optional-value=true maxlength="3"/>&nbsp;-&nbsp;
									  <label for="acesIpB"></label><input type="text" class="w20per" name="acesIpB" id="acesIpB" data-type="number" title="접속아이피" data-optional-value=true maxlength="3"/>&nbsp;-&nbsp;
									  <label for="acesIpC"></label><input type="text" class="w20per" name="acesIpC" id="acesIpC" data-type="number" title="접속아이피" data-optional-value=true maxlength="3"/>&nbsp;-&nbsp;
									  <label for="acesIpD"></label><input type="text" class="w20per" name="acesIpD" id="acesIpD" data-type="number" title="접속아이피" data-optional-value=true maxlength="3"/>                                                                                                   
								   </td>
								   <th class="C">최초임용일</th>
								   <td class="L"><label for="initApptDt"></label><input type="text" class="w100per calendar datepicker" name="initApptDt" id="initApptDt" />
								   </td>								                                                             
							   </tr>                                                                
									 
							   <tr>
								   <th class="C">생년월일(YYYYMMDD)</th>
								   <td class="L">
									   <label for="regNo"></label><input type="text" class="w100per" name="regNo" id="regNo" data-type="number" title="생년월일" data-optional-value=true maxlength="8" />                                                        
								   </td>
								   <th class="C">성별</th>
								   <td class="L">
									   <div class="inputbox w100per">
										   <p class="txt"></p>
										   <select id="sexFlag" name="sexFlag">
												<option value="">선택</option>
												<option value="1">남성</option>	
												<option value="2">여성</option>																			
										   </select>
									   </div>                                                              
								   </td>
							   </tr>  
						   		<tr>
								   <th class="C">전입전 부서</th>
								   <td class="L"><label for="miPreDeptNm"></label><input type="text" class="w100per" name="miPreDeptNm" id="miPreDeptNm" />
								   </td>
								   <th class="C">전출 부서</th>
								   <td class="L"><label for="moAftrDeptNm"></label><input type="text" class="w100per" name="moAftrDeptNm" id="moAftrDeptNm" />
								   </td>                                     
							   </tr>   							   
							   <!-- 
							   <tr>
								   <th class="C">주소</th>
								   <td class="L" colspan="3">                                                              
									  <label for="homeAddr1"></label><input type="text" class="w30per" name="homeAddr1" id="homeAddr1" />&nbsp;
									  <label for="homeAddr2"></label><input type="text" class="w30per" name="homeAddr2" id="homeAddr2" />                                                                                      
								   </td>                                                          
							   </tr>  
							   
							   <tr>
								   <th class="C">연락처</th>
								   <td class="L" colspan="3">                                                              
									  <label for="mobileTelA"></label><input type="text" class="w10per" name="mobileTelA" id="mobileTelA" maxlength="3" data-type="number" title="연락처" data-optional-value=true/>&nbsp;-&nbsp;
									  <label for="mobileTelB"></label><input type="text" class="w10per" name="mobileTelB" id="mobileTelB" maxlength="4" data-type="number" title="연락처" data-optional-value=true/>&nbsp;-&nbsp;
									  <label for="mobileTelC"></label><input type="text" class="w10per" name="mobileTelC" id="mobileTelC" maxlength="4" data-type="number" title="연락처" data-optional-value=true/>                                                                                                                                                             
								   </td>                                                          
							   </tr>
							  -->  
							   <tr>
								   <th class="C">기타사항</th>
								   <td class="L" colspan="3">                                                              
									  <label for="intro"></label><input type="text" class="w100per" name="intro" id="intro" />                                                                                      
								   </td>                                                          
							   </tr>                                                                                                                                                                                         
																															
						   </tbody>
					   </table>
					   <p>&nbsp;</p>                               				   
					   <div class="btnArea" id="step1Btn">
							<div class="r_btn">											   	    	
								<a href="#" class="btn_blue" id="saveBtn"><span>저장 </span></a>												   	    
							</div>
					   </div>                               				           
					   
				   </div>
				   <!-- tab_contents //-->
			   </li>
			   
			   <li class="m2" id="contentsAreaM2"><a href="#" class="tabtitle" id="criMbCarrTab"><span>경력관리</span></a>
					<div class="tab_mini_contents">                                      
						<div id="sheetCR" style="height: 250px; width: 100%"></div>  
						
						 <table class="list" cellpadding="0" cellspacing="0">
							   <colgroup>
								   <col width="15%" />
								   <col width="35%" />
								   <col width="15%" />
								   <col width="35%" />
							   </colgroup>
							   <tbody>
								   <tr>
									   <th class="C">총경력</th>
									   <td class="L" colspan="3"><span id="totlCarrSpan"></span></td>                                                           
								   </tr>                                                                                        
							   </tbody>
						  </table>
						  <div class="btnArea" id="step1Btn">
								<div class="r_btn">											   	    	
									<a href="#" class="btn_blue" id="newCRBtn"><span>경력신규</span></a>												   	    
								</div>
						   </div>                                                     
						  
						 <p>&nbsp;</p>
					   
					   
						 <table class="list" cellpadding="0" cellspacing="0">
							   <colgroup>
								   <col width="15%" />
								   <col width="35%" />
								   <col width="15%" />
								   <col width="35%" />
							   </colgroup>
							   <tbody>
								   <tr>
									   <th class="C">수사팀<em class="red">*</em></th>
									   <td class="L">
										   <div class="inputbox w50per">
											   <p class="txt"></p>
											   <select id="criTmIdCR" name="criTmIdCR" data-type="select" title="수사팀">
													<option value="">선택</option>
													<c:forEach items="${criTmList}" var="item">
														<option value="${item.criTmId}">${item.criTmNm}</option> 
													</c:forEach>																   																				
											   </select>
										   </div>                                                               
									   </td>
									   <th class="C">직위<em class="red">*</em></th>
									   <td class="L">
										   <div class="inputbox w50per">
											   <p class="txt"></p>
											   <select id="criMbPosiCR" name="criMbPosiCR" data-type="select" title="직위">
													<option value="">선택</option>	
													<c:forEach items="${criMbPosiList}" var="item">
													   <option value="${item.code}">${item.codeName}</option>
													</c:forEach> 																									   																			
											   </select>
										   </div>                                                               
									   </td>                                                           
								   </tr>                                                                                        
								   <tr>
									   <th class="C">직렬<em class="red">*</em></th>
									   <td class="L">
										   <div class="inputbox w50per">
											   <p class="txt"></p>
											   <select id="criMbSrocCR" name="criMbSrocCR" data-type="select" title="직렬">
													<option value="">선택</option>	
													<c:forEach items="${criMbSrocList}" var="item">
													   <option value="${item.code}">${item.codeName}</option>
													</c:forEach> 																	
											   </select>
										   </div>                                                               
									   </td>
									   <th class="C">직급<em class="red">*</em></th>
									   <td class="L">
										   <div class="inputbox w50per">
											   <p class="txt"></p>
											   <select id="criMbClasCR" name="criMbClasCR" data-type="select" title="직급">
													<option value="">선택</option>	
													<c:forEach items="${criMbClasList}" var="item">
													   <option value="${item.code}">${item.codeName}</option>
													</c:forEach> 																									   																			
											   </select>
										   </div>                                                              
									   </td>
								   </tr>           	
								   <tr>
									   <th class="C">전입일자</th>
									   <td class="L">
										  <label for="txt_05"></label><input type="text"  class="w30per calendar datepicker" name="carrBeDt" id="carrBeDt" />
									   </td>
									   <th class="C">전출일자</th>
									   <td class="L">
										  <label for="txt_05"></label><input type="text"  class="w30per calendar datepicker" name="carrEdDt" id="carrEdDt" />
									   </td>                                                           
								   </tr>	                                                                                                              
							   </tbody>
						  </table>    
																	   
						   <div class="btnArea" id="step1Btn">
								<div class="r_btn">											   	    	
									<a href="#" class="btn_blue" id="saveBtnCR"><span>저장</span></a>
									<a href="#" class="btn_blue" id="delBtnCR"><span>삭제</span></a>												   	    
								</div>
						   </div>                            	
					</div>                                       		
				</li>
			   
				<li class="m3" id="contentsAreaM3"><a href="#" class="tabtitle" id="profOffiTab"><span>전문관관리</span></a>
					<div class="tab_mini_contents">                                      
						<div id="sheetPO" style="height: 250px; width: 100%"></div>  
						
						 <table class="list" cellpadding="0" cellspacing="0">
							   <colgroup>
								   <col width="15%" />
								   <col width="35%" />
								   <col width="15%" />
								   <col width="35%" />
							   </colgroup>
							   <tbody>
								   <tr>
									   <th class="C">총경력</th>
									   <td class="L" colspan="3"><span id="totlPOSpan"></span></td>                                                           
								   </tr>                                                                                        
							   </tbody>
						  </table>
						  <div class="btnArea">
								<div class="r_btn">											   	    	
									<a href="#" class="btn_blue" id="newPOBtn"><span>전문관신규</span></a>												   	    
								</div>
						   </div>                                                     
						  
						 <p>&nbsp;</p>
					   
					   
						 <table class="list" cellpadding="0" cellspacing="0">
							   <colgroup>
								   <col width="15%" />
								   <col width="35%" />
								   <col width="15%" />
								   <col width="35%" />
							   </colgroup>
							   <tbody>
								   <tr>
									   <th class="C">수사팀<em class="red">*</em></th>
									   <td class="L">
										   <div class="inputbox w50per">
											   <p class="txt"></p>
											   <select id="criTmIdPO" name="criTmIdPO" data-type="select" title="수사팀">
													<option value="">선택</option>
													<c:forEach items="${criTmList}" var="item">
														<option value="${item.criTmId}">${item.criTmNm}</option> 
													</c:forEach>																   																				
											   </select>
										   </div>                                                               
									   </td>
									   <th class="C">직위<em class="red">*</em></th>
									   <td class="L">
										   <div class="inputbox w50per">
											   <p class="txt"></p>
											   <select id="criMbPosiPO" name="criMbPosiPO" data-type="select" title="직위">
													<option value="">선택</option>	
													<c:forEach items="${criMbPosiList}" var="item">
													   <option value="${item.code}">${item.codeName}</option>
													</c:forEach> 																									   																			
											   </select>
										   </div>                                                               
									   </td>                                                           
								   </tr>                                                                                        
								   <tr>
									   <th class="C">직렬<em class="red">*</em></th>
									   <td class="L">
										   <div class="inputbox w50per">
											   <p class="txt"></p>
											   <select id="criMbSrocPO" name="criMbSrocPO" data-type="select" title="직렬">
													<option value="">선택</option>	
													<c:forEach items="${criMbSrocList}" var="item">
													   <option value="${item.code}">${item.codeName}</option>
													</c:forEach> 																	
											   </select>
										   </div>                                                               
									   </td>
									   <th class="C">직급<em class="red">*</em></th>
									   <td class="L">
										   <div class="inputbox w50per">
											   <p class="txt"></p>
											   <select id="criMbClasPO" name="criMbClasPO" data-type="select" title="직급">
													<option value="">선택</option>	
													<c:forEach items="${criMbClasList}" var="item">
													   <option value="${item.code}">${item.codeName}</option>
													</c:forEach> 																									   																			
											   </select>
										   </div>                                                              
									   </td>
								   </tr>           	
								   <tr>
									   <th class="C">시작일자</th>
									   <td class="L">
										  <label for="txt_05"></label><input type="text"  class="w30per calendar datepicker" name="carrPOBeDt" id="carrPOBeDt" />
									   </td>
									   <th class="C">종료일자</th>
									   <td class="L">
										  <label for="txt_05"></label><input type="text"  class="w30per calendar datepicker" name="carrPOEdDt" id="carrPOEdDt" />
									   </td>                                                           
								   </tr>	                                                                                                              
							   </tbody>
						  </table>    
																	   
						   <div class="btnArea" id="step1Btn">
								<div class="r_btn">											   	    	
									<a href="#" class="btn_blue" id="saveBtnPO"><span>저장</span></a>
									<a href="#" class="btn_blue" id="delBtnPO"><span>삭제</span></a>													   	    
								</div>
						   </div>    
																
					</div>
					
			   </li>                                       
			   
													  
		   </ul>
	   </div>   
		</form>		
	</body>	
</html>

    	