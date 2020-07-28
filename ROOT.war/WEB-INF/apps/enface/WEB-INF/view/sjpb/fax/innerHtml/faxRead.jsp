<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Iterator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	request.setAttribute("cPath", request.getContextPath());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>:: 금융감독원 수사지원시스템 ::</title>
<link rel="stylesheet" type="text/css" href="${cPath}/sjpb/css/sjpb_custom.css" />
<link rel="stylesheet" type="text/css" href="${cPath}/javascript/jstree/themes/default/style.min.css" />
<script type="text/javascript" src="${cPath}/sjpb/js/Z/jquery.base64.js"></script>
<script type="text/javascript" src="${cPath}/javascript/jstree/jstree.min.js" ></script>	

<script>
	$(document).ready(function(){
		
	});
</script>
</head>
<body class="iframe">
	<div class="tab_mini_wrap m1">
		<ul>
			<li class="m1"><a href="#" class="tabtitle"><span>FAX 송신정보</span></a>
				<div class="tab_mini_contents" id="faxDetailTab">
					<div class="list">
						<table class="list" cellpadding="0" cellspacing="0">
							<caption>게시판쓰기</caption>
							<colgroup>
								<col width="20%" />
								<col width="15%" />
								<col width="*" />
							</colgroup>
							<tr>
								<th class="C th_line">송신 일련번호</th>
								<td class="L td_line" colspan="2">
									<span id="sendNoSpan"></span>
								</td>
							</tr>
							<tr>
								<th class="C th_line">상태</th>
								<td class="L td_line" colspan="2">
									<span id="sendDivSpan"></span>
								</td>
							</tr>
							<tr>
								<th class="C th_line r_line" rowspan="2">발신정보</th>
								<th class="C th_line">담당자</th>
								<td class="L td_line">
									<span id="regUserSpan"></span>
								</td>
							</tr>
                            <tr>
								<th class="C th_line">FAX번호</th>
								<td class="L td_line">
									<span id="regUserFaxSpan"></span>
								</td>
                            </tr>
                            <tr>
								<th class="C th_line r_line" rowspan="2">수신정보</th>
								<th class="C">수신처<em class="red">*</em></th>
								<td class="L">
									<span id="receiverSpan"></span>
<!--                                 	<label for="txt_01"><input type="text" class="w100per" id="receiver" name="receiver" value="" readonly="readonly" /></label> -->
								</td>
							</tr>
                            <tr>
                            	<th class="C th_line">FAX번호<em class="red">*</em></th>
								<td class="L">
									<span id="sendFaxNoSpan"></span>
<!--                                 	<label for="txt_02"><input type="text" class="w100per" id="sendFaxNo" name="sendFaxNo" value="" readonly="readonly" /></label> -->
                                </td>
                            </tr>
                            <tr>
                            	<th class="C th_line">첨부파일</th>
                                <td class="L td_line" colspan="2">
                                	
                                </td>
                            </tr>
						</table>
					</div>
				</div>
			</li>
		</ul>
    </div>
</body>
</html>
