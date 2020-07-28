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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Content-style-type" content="text/css" />
<title>통신사실 확인자료제공 요청 집행사실통지유예 승인신청부</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0127.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" id="searchArea" data-view-type="mng">
		<form name="searchList" id="searchList" method="post">
			<ul>
			<%-- TODO 페이지별 수정 --%>
				<li><span class="title">연번</span>
					<label for="apprSiNumSc"></label><input type="text" class="w65per" id="apprSiNumSc" name="apprSiNumSc" />
				</li>		   
				<li><span class="title">신청일자</span>
				   <label for="sReqDtSc"></label><input type="text" class="w30per calendar datepicker" id="sReqDtSc" name="sReqDtSc" data-type="date" data-optional-value=true title="신청일자시작일" value=""/> ~ <label for="eDateSc"></label><input type="text" class="w30per calendar datepicker" id="eReqDtSc" name="eReqDtSc" data-type="date" data-optional-value=true title="신청일자종료일" value=""/>
			    </li>

					<label for="apltNmSc"></label><input type="text" class="w65per" id="apltNmSc" name="apltNmSc" />
				</li>
				<li><span class="title">통지대상자</span>
					<label for="notcTrgtPersSc"></label><input type="text" class="w65per" id="notcTrgtPersSc" name="notcTrgtPersSc" />
				</li>
				<li><span class="title">사건번호</span>
					<label for="rcptIncNumSc"></label><input type="text" class="w65per" id="rcptIncNumSc" name="rcptIncNumSc" />
				</li>
				<li><span class="title">처리일자</span>
					<label for="sHandDtSc"></label><input type="text" class="w30per calendar datepicker" id="sHandDtSc" name="sHandDtSc" data-type="date" data-optional-value=true title="처리일자시작일"/> ~ <label for="eHandDtSc"></label><input type="text" class="w30per calendar datepicker" id="eHandDtSc" name="eHandDtSc" data-type="date" data-optional-value=true title="처리일자종료일"/>
				</li>
				<li><span class="title">승인일자</span>
					<label for="sApprDtSc"></label><input type="text" class="w30per calendar datepicker" id="sApprDtSc" name="sApprDtSc" data-type="date" data-optional-value=true title="승인일자시작일"/> ~ <label for="eApprDtSc"></label><input type="text" class="w30per calendar datepicker" id="eApprDtSc" name="eApprDtSc" data-type="date" data-optional-value=true title="송인일자종료일"/>
				</li>
				<li><span class="title">등록자</span>
					<label for="regUserNmSc"></label><input type="text" class="w65per" id="regUserNmSc" name="regUserNmSc" />
				</li>
				
			</ul>
			<div class="searchbtn">
				<a href="javascript:initSearchData();" class="btn_white reset"><span>초기화</span></a>
				<a href="javascript:selectList();" class="btn_light_blue"><span>검색</span></a>
			</div>
		</form>
   </div>
   <!-- searchArea //-->
	
	<!-- listArea -->
	<div id="listSheet" class="listArea mrt15 area-mousewheel" style="height: 400px; width: 100%"></div>
	<!-- listArea// -->
	
	<!-- report -->
	<form name="reportForm" method="post">
		<input type="hidden" id="reptNm" name="reptNm" value="" />
		<input type="hidden" id="xmlData" name="xmlData" value="" />
		<input type="hidden" id="SEQNUM" name="SEQNUM" value="" />
		<input type="hidden" id="POLICENAME" name="POLICENAME" value="${userId}" />
	</form>
	<!-- //report -->
	
	<form name="contentsFormData" id="contentsFormData">
		<input type="hidden" id="userId" name="userId" value="${userInfo.userId}" />   <!-- 사용자계정 -->
		<input type="hidden" id="userName" name="userName" value="${userInfo.userName}" />  <!-- 사용자이름 -->
		<input type="hidden" id="orgCd" name="orgCd" value="${userInfo.orgCd}" />   <!-- 수사팀코드 -->
		<input type="hidden" id="kindCd" name="kindCd" value="${userInfo.kindCd}" />  <!-- 수사단원구분 01:수사관 02:팀장 03:과장 -->	
	</form>	
	
	<!-- btnArea -->
	<div class="btnArea">
		<div class="r_btn">
			<a href="javascript:insertDataView();" class="btn_light_blue new2" id="btnNewSeiz" data-view-type="inc"><span>신규</span></a>
			<a href="javascript:void(0);" class="btn_white print" id="prnBtn"><span>대장 출력</span></a>
		</div>
	</div>
	
	<!-- contents S -->
	<div class="tab_mini_wrap m1" id="docTab">                               	
	   	<ul>
			<!-- 통신사실 확인자료제공 요청 집행사실통지유예 승인신청부 관리대장 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>통신사실 확인자료제공 요청 집행사실통지유예 승인신청부  상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents" id="contentsArea">
					<div class="list">
			        	<input type="hidden" id="sjpbCmctCnfmDelyApprNum" name="sjpbCmctCnfmDelyApprNum" value="" />
			        	<input type="hidden" id="rcptNum" name="rcptNum" value="" />
			        	<input type="hidden" id="incSpNum" name="incSpNum" value="" />
        	
        	
			            <table class="list" cellpadding="0" cellspacing="0">
			                <caption>요청정보</caption>
			                <colgroup>
			                    <col width="10%"/>
								<col width="10%"/>
								<col width="35%"/>
								<col width="10%"/>
								<col width="35%"/>
			                </colgroup>
				             <tbody>
				             	 <tr>
				                	<th class="C th_line " colspan="2">연번</th>
				                	<td class="L td_line "><input type="text" id="apprSiNum" name="apprSiNum" class="w100per" maxlength="10"/></td>
				                	<th class="C th_line ">신청일자</th>
				                	<td class="L td_line "><label for="reqDt"></label><input type="text" class="w100per calendar datepicker" title="신청일자" id="reqDt" name="reqDt" data-type="date" data-optional-value=true maxlength="10" readonly/></td>
				                </tr>
				                <tr>
									<th class="C line_right" rowspan="2">피의자</th>
									<th class="C">성명</th>
									<td class="L">
										<p class="searchinput">
				                			<label for="txt_04"></label><input type="text" class="w100per" id="txt_04" name="spNm" disabled="disabled" data-always="y" readonly/><a name="spBtn" class="btn_search" id="spBtn" href="javascript:void(0);"><img alt="search" src="/sjpb/images/btn_search.png"></a>	
				                		</p>
									</td>
									<th class="C">주민등록번호</th>
									<td class="L"><span id="spIdNum" name="spIdNum"></span></td>
								</tr>
								<tr>
									<th class="C">직업</th>
									<td class="L"><span  id="spJob" name="spJob"></span></td>
									<th class="C">주거</th>
									<td class="L"><span id="spAddr" name="spAddr"></span></td>
								</tr>
				                
				                
				                 <tr>
				                	<th class="C th_line " colspan="2">사건번호</th>
				                	<td class="L td_line " colspan="3"><span id="rcptIncNum" name="rcptIncNum"></span></td>	
				                </tr>
					            <tr>
	                                <th class="C th_line" colspan="2">통신사실 확인자료 제공요청의<br /> 종류 및 자료의 범위</th>
	                                <td class="L td_line" colspan="3"><label for="reqTypeAndDataRang"><input type="text" class="w100per" id="reqTypeAndDataRang" name="reqTypeAndDataRang" maxlength="30"></label></td>
	                            </tr>
	                            <tr>
	                                <th class="C th_line" colspan="2">통신사실 확인자료제공 요청을<br />집행한 사건의 처리일자 및 결과</th>
	                                <td class="L td_line" colspan="3"><label for="reqIncDateAndRslt"><input type="text" class="w100per" id="reqIncDateAndRslt" name="reqIncDateAndRslt" maxlength="30"></label></td>
	                            </tr>
	                            <tr>
	                                <th class="C th_line" colspan="2">처리결과를 통보받은 일자</th>
	                                <td class="L td_line" colspan="3"><label for="rsltNotiDate"><input type="text" class="w100per" id="rsltNotiDate" name="rsltNotiDate" maxlength="30"></label></td>
	                            </tr>
				                
				                
				             </tbody>
				             <tbody id="afterDiv">
				             	<tr>
				                	<th class="C th_line " colspan="2">신청자관직</th>
				                	<td class="L td_line "><label for="apltTitl"></label><input type="text" class="w100per" id="apltTitl" name="apltTitl" maxlength="30"/></td>
				                     
				                	<th class="C th_line ">신청자성명</th>
				                	<td class="L td_line "><label for="apltNm"></label><input type="text" class="w100per" id="apltNm" name="apltNm" maxlength="30"/></td>
				                </tr>
				                
				                <tr>
				                	<th class="C th_line " colspan="2">허가서번호</th>
				                	<td class="L td_line "><label for="apprDocNum"></label><input type="text" class="w100per" id="apprDocNum" name="apprDocNum" maxlength="10"/></td>
				                     
				                	<th class="C th_line ">통지대상자</th>
				                	<td class="L td_line "><label for="notcTrgtPers"></label><input type="text" class="w100per" id="notcTrgtPers" name="notcTrgtPers" maxlength="30"/></td>
				                </tr>
				                <tr>
				                	<th class="C th_line " colspan="2">처리결과</th>
				                	<td class="L td_line " colspan="3"><label for="handRst"></label><input type="text" class="w100per" id="handRst" name="handRst" maxlength="30"/></td>
				                </tr>
				                <tr>
				                    <th class="C th_line " colspan="2">처리일자</th>
				                	<td class="L td_line "><label for="handDt"></label><input type="text" class="w100per calendar datepicker" title="처리일자" id="handDt" name="handDt" data-type="date" data-optional-value=true maxlength="10" readonly/></td>
				            
				                	<th class="C th_line ">통보받은일자</th>
				                	<td class="L td_line "><label for="notcDt"></label><input type="text" class="w100per calendar datepicker" title="통보받은일자" id="notcDt" name="notcDt" data-type="date" data-optional-value=true maxlength="10" readonly/></td>
				                </tr>
				                
				                <tr>
				                	<th class="C th_line " colspan="2">승인일자</th>
				                	<td class="L td_line "><label for="apprDt"></label><input type="text" class="w100per calendar datepicker" title="승인일자" id="apprDt" name="apprDt" data-type="date" data-optional-value=true maxlength="10" readonly/></td>
				                     
				                	<th class="C th_line ">유예사유해소후 통지일자</th>
				                	<td class="L td_line "><label for="clarAftrNotcDt"></label><input type="text" class="w100per calendar datepicker" title="유예사유해소후 통지일자" id="clarAftrNotcDt" name="clarAftrNotcDt" data-type="date" data-optional-value=true maxlength="10" readonly/></td>
				                </tr>
				             </tbody>
			       		</table>
       				
	       			</div>
			        <div class="btnArea">
			        	<div class="r_btn" id="btnAreaDiv">
			        		<%-- 그리는 영역 --%>
			        		<a href="javascript:requestReport();" class="btn_white print"><span>신청서 출력</span></a>
			            	<a href="javascript:insertData();" class="btn_light_blue save" id="btnInsert" data-view-type="inc"><span>저장</span></a>
			            </div>
			        </div>
		        </div>
        	</li>
        </ul>
    </div>
	<!-- contents E -->
</body>
</html>