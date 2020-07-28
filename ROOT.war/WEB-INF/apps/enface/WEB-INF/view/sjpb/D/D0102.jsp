<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	request.setAttribute("cPath", request.getContextPath());
	request.setAttribute("rcptNum", request.getParameter("rcptNum"));
	request.setAttribute("incSpNum", request.getParameter("incSpNum"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>사건 조회</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/D/D0102.js?r=<%=Math.random()%>"></script>
<script type="text/javascript">
  var initRcptNumTmp = "${rcptNum}";	//진입시 선택할 rcptNum 정보 
  var initIncSpNumTmp = "${incSpNum}";	//진입시 선택할 rcptNum 정보 
</script>
</head>
<body class="iframe" onbeforeunload="window.opener.fn_d_selectList();">


<div class="tab_mini_wrap m1" id="mergeSpTab">                               	
   	<ul>
		<!-- 피의자 정보탭 -->
<!--        	<li class="m1"> -->
<!--        	<a href="javascript:fn_f_selectIntiIncTab();" class="tabtitle" id="intiIncTab"><span>피의자 정보</span></a> -->
       		<!-- tab_contents -->
       		<div class="tab_mini_contents">
       			<table class="list" cellpadding="0" cellspacing="0" id="spInfoTable">
					<colgroup>
						<col width="10%" />
						<col width="15%" />
						<col width="30%" />
						<col width="15%" />
						<col width="30%" />
					</colgroup>
					<tbody>
						<tr id="personalInfo">
							<th class="C line_right" rowspan="12">피의자 정보</th>
							<th class="C">구분</th>
							<td class="L" id="indvDivDesc"></td>
							<th class="C">내 외국인</th>
							<td class="L" id="homcForcPernDivDesc"></td>
						</tr>
						<tr id="corpInfo">
							<th class="C line_right" rowspan="12">피의자 정보</th>
							<th class="C" >구분</th>
							<td class="L" colspan="3" id="CorpDivDesc"></td>
						</tr>
						<tr>
							<th class="C">성명</th>
							<td class="L" colspan="3" id="spNmInfo"></td>
						</tr>
						<tr id="personalNum">
							<th class="C">주민등록번호</th>
							<td class="L" id="spIdNum"></td>
							<th class="C">성별</th>
							<td class="L" id="gendDivDesc"></td>
						</tr>
						<tr id="corpNum">
							<th class="C">법인번호</th>
							<td class="L" colspan="3" id="CorpNum"></td>
						</tr>
						<tr>
							<th class="C">주소</th>
							<td class="L" colspan="3" id="spAddr"></td>
						</tr>
						<tr>
							<th class="C">연락처</th>
							<td class="L" colspan="3" id="spCnttNum"></td>
						</tr>
						<tr id="vioArea">
							<td class="L" colspan="4" id="lawArea"></td>
						</tr>
					</tbody>
				</table> 
       		</div>
       		
       		<div class="btnArea">
				<div class="r_btn">
					<a href="javascript:void();" id="D0101Btn" class="btn_white" onclick="window.opener.fn_d_selectList();self.close();"><span>닫기</span></a>
				</div>
      			</div>
       		
			<!-- //tab_contents -->
<!-- 		</li> -->
		<!-- //피의자 상세탭 -->
	</ul>
</div>
</body>
</html>