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
<title>범죄인지보고서</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0215.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" id="searchArea" data-view-type="mng">
		<form name="searchList" id="searchList" method="post">
			<ul>
			<%-- TODO 페이지별 수정 --%>		   
				<li><span class="title">신청일자</span>
				   <label for="sReqDtSc"></label><input type="text" class="w30per calendar datepicker" id="sReqDtSc" name="sReqDtSc" data-type="date" data-optional-value=true title="신청일자시작일" value=""/> ~ <label for="eDateSc"></label><input type="text" class="w30per calendar datepicker" id="eReqDtSc" name="eReqDtSc" data-type="date" data-optional-value=true title="신청일자종료일" value=""/>
			    </li>				
				<li><span class="title">사건번호</span>
					<label for="rcptIncNumSc"></label><input type="text" class="w65per" id="rcptIncNumSc" name="rcptIncNumSc" />
				</li>
				<li><span class="title">등록자</span>
					<label for="regUserNmSc"></label><input type="text" class="w65per" id="regUserNmSc" name="regUserNmSc" />
				</li>			
			</ul>
			<div class="searchbtn">
				<a href="javascript:initSearchData();" class="btn_white reset"><span>초기화</span></a>
				<a href="javascript:selectList();" class="btn_light_blue search_01"><span>검색</span></a>
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
		<input type="hidden" id="POLICENAME" name="POLICENAME" value="${userInfo.userId}" />
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
		</div>
	</div>
	
	<!-- contents S -->
	<div class="tab_mini_wrap m1" id="docTab">                               	
	   	<ul>
			<!-- 출국금지 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>출국금지 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents" id="contentsArea">
					<div class="list">
			        	<input type="hidden" id="prhbDeptReqNum" name="prhbDeptReqNum" value="" />
			        	<input type="hidden" id="rcptNum" name="rcptNum" value="" /> 	
			        	<input type="hidden" id="incSpNum" name="incSpNum" value="" /> 	
			            
			            <table class="list" cellpadding="0" cellspacing="0">
			                <caption>요청정보</caption>
			                <colgroup>
								<col width="10%" />
                                <col width="10%" />
                                <col width="35%" />
                                <col width="10%" />
                                <col width="35%" />
			                </colgroup>
			                <tbody>
				             <tr>
                                <th class="C th_line" colspan="2">문서번호</th>
                                <td class="L td_line"><input type="text" class="w100per" id="docNum" name="docNum" maxlength="10"/></td>
                                <th class="C th_line">요청유형</th>
                                <td class="L td_line">
                                    <div class="inputbox w100per">
                                        <p class="txt"></p>
                                        <select id="reqType" name="reqType" data-type="select" title="요청유형">
                                            <option value="">선택</option>
                                            <option value="출국금지 요청">출국금지 요청</option>
                                            <option value="출국정지 요청">출국정지 요청</option>
                                            <option value="입국시통보 요청">입국시통보 요청</option>
                                            <option value="출국금지 해제 요청">출국금지 해제 요청</option>
                                            <option value="출국정지 해제 요청">출국정지 해제 요청</option>
                                            <option value="입국시통보 해제 요청">입국시통보 해제 요청</option>
                                        </select>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="C th_line r_line" rowspan="4">대상자</th>
                                <th class="C">성명</th>
                                <td class="L td_line">
                                	<p class="searchinput">
			                			<label for="spNm"></label><input type="text" class="w100per" id="spNm" name="spNm" disabled="disabled" data-always="y"/><a name="spBtn" class="btn_search" id="spBtn" href="javascript:void(0);"><img alt="search" src="/sjpb/images/btn_search.png"></a>	
			                		</p>
                                </td>
                                <th class="C th_line">주민등록번호</th>
                                <td class="L td_line"><span id="spIdNum" name="spIdNum"></span></td>                                
                            </tr>
                            <tr>
                                <th class="C th_line">국적</th>
                                <td class="L td_line"><label for="persNaty"><input type="text" class="w100per" id="persNaty" name="persNaty" maxlength="10"/></label></td>
                                <th class="C th_line">주소</th>
                                <td class="L td_line"><span id="spAddr" name="spAddr"></span></td>
                            </tr>
                            <tr>
                                <th class="C th_line">직업</th>
                                <td class="L td_line"><span id="spJob" name="spJob"/></span></td>
                                <th class="C th_line">여권번호</th>
                                <td class="L td_line"><label for="persPassportNum"><input type="text" class="w100per" id="persPassportNum" name="persPassportNum" maxlength="20"/></label></td>
                            </tr>
                            <tr>
                                <th class="C th_line">여권 유효기간 만료일</th>
                                <td class="L td_line" colspan="4">
                                   <label for="persPassportEndDate"></label><input type="text" class="calendar datepicker" id="persPassportEndDate" name="persPassportEndDate" />
                                </td>
                            </tr>

                            <tr>
                                <th class="C th_line" colspan="2">요청기간</th>
                                <td class="L td_line">
                                   <label for="persReqPeriod"></label><input type="text" class="w40per" id="persReqPeriod" name="persReqPeriod"  maxlength="30"/>
                                </td>
                                <th class="C th_line">요청사유</th>
                                <td class="L td_line"><label for="persReqResln"><input type="text" class="w100per" id="persReqResln" name="persReqResln" maxlength="30"/></label></td>                            
                            </tr>
                            <tr>
                                <th class="C th_line r_line" rowspan="2">검사</th>
                                <th class="C">성명</th>
                                <td class="L td_line"><label for="attorNm"><input type="text" class="w100per" id="attorNm" name="attorNm" maxlength="10"/></label></td>
                                <th class="C th_line">지휘연월일</th>
                                <td class="L td_line">
                                	<label for="attorCmdDate"></label><input type="text" class="w100per calendar datepicker" id="attorCmdDate" name="attorCmdDate" />
                                </td>                                
                            </tr>
                            <tr>
                                <th class="C th_line">의견</th>
                                <td class="L td_line" colspan="3">
                                   <label for="attorOpinion"></label><input type="text" class="w100per" id="attorOpinion" name="attorOpinion" maxlength="30" />
                                </td>
                            </tr>
                        </tbody>
                        <tbody id="afterDiv">
                            <tr>
                                <th class="C th_line r_line" rowspan="3">금지 등 요청</th>
                                <th class="C td_line">요청일</th>
                                <td class="L td_line">
                                   <label for="prhbBanDate"></label><input type="text" class="w100per calendar datepicker" id="prhbBanDate" name="prhbBanDate" />
                                </td>
                                <th class="C th_line">요청사유</th>
                                <td class="L td_line"><label for="prhbBanResn"><input type="text" class="w100per" id="prhbBanResn"  name="prhbBanResn" maxlength="30" /></label></td>
                            </tr>
                            <tr>
                                <th class="C th_line">요청근거</th>
                                <td class="L td_line"><label for="prhbBanGrnd"><input type="text" class="w100per" id="prhbBanGrnd" name="prhbBanGrnd" maxlength="30" /></label></td>
                                <th class="C th_line">승인여부</th>
                                <td class="L td_line"><label for="prhbBanYn"><input type="text" class="w100per" id="prhbBanYn" name="prhbBanYn" maxlength="30" /></label></td>
                            </tr>
                            <tr>
                                <th class="C th_line">출국금지 예정기간</th>
                                <td class="L td_line" colspan="3">
                                   <input type="text" id="prhbBanPerdCal" name="prhbBanPerdCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
									<input type="number" id="prhbBanPerdHour" min="0" max="24" step="1"  name="prhbBanPerdHour" class="w15per" disabled="disabled"/>시
									<input type="number" id="prhbBanPerdMin" name="prhbBanPerdMin" min="0" max="60" step="5" class="w15per" disabled="disabled"/>분
                                </td>
                            </tr>
                            <tr>
                            	<th class="C th_line r_line" rowspan="3">연장요청</th>
                                <th class="C th_line">요청일</th>
                                <td class="L td_line">
                                   <label for="prhbExtDate"></label><input type="text" class="w100per calendar datepicker" id="prhbExtDate" name="prhbExtDate" />
                                </td>
                                <th class="C th_line">요청사유</th>
                                <td class="L th_line">
                                	<label for="prhbExtResn"><input type="text" class="w100per" id="prhbExtResn" name="prhbExtResn" maxlength="30" /></label>
                                </td>
                            </tr>
                            <tr>
                                <th class="C th_line">요청근거</th>
                                <td class="L th_line">
                                	<label for="prhbExtGrnd"><input type="text" class="w100per" id="prhbExtGrnd" name="prhbExtGrnd"  maxlength="30"/></label>
                                </td>
                                <th class="C th_line">승인여부</th>
                                <td class="L th_line">
                                	<label for="prhbExtYn"><input type="text" class="w100per" id="prhbExtYn" name="prhbExtYn" maxlength="30" /></label>
                                </td>
                            </tr>
                            <tr>
                                <th class="C th_line">연장 예정기간</th>
                                <td class="L th_line" colspan="3">
                                	<label for="prhbExtPerd"><input type="text" class="w100per" id="prhbExtPerd" name="prhbExtPerd" maxlength="30" /></label>
                                </td>
                            </tr>
                            <tr>
                            	<th class="C th_line r_line" rowspan="2">해체요청</th>
                                <th class="C th_line">요청일</th>
                                <td class="L th_line" colspan="3">
                                	<label for="prhbDisDate"><input type="text" class="w100per calendar datepicker" id="prhbDisDate" name="prhbDisDate" /></label>
                                </td>
                            </tr>
                            <tr>    
                                <th class="C th_line">요청근거</th>
                                <td class="L th_line">
                                	<label for="prhbDisGrnd"><input type="text" class="w100per" id="prhbDisGrnd" name="prhbDisGrnd" maxlength="30" /></label>
                                </td>
                                <th class="C th_line">승인여부</th>
                                <td class="L th_line">
                                	<label for="prhbDisYn"><input type="text" class="w100per" id="prhbDisYn" name="prhbDisYn" maxlength="30" /></label>
                                </td>
                            </tr>
                            <tr>
                            	<th class="C th_line" colspan="2">비고</th>
                                <td class="L th_line" colspan="4">
                                	<label for="prhbComn"><input type="text" class="w100per" id="prhbComn" name="prhbComn" maxlength="30" /></label>
                                </td>
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