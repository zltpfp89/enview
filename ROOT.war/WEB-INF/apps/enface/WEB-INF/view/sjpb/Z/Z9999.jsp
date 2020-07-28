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
		<title>Sample Test</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-style-type" content="text/css" />
		
		<script type="text/javascript" src="${pageContext.request.contextPath}/kbig/js/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/kbig/js/jquery-ui.min.js"></script>
		
		<script type="text/javascript">
		function generator(){
			
			//호출 URL : http://localhost:8088/sjpb/Z/Z9999.face
			
			var str = $("#inputArea").val();
			
			str = str.toLowerCase();
			//str.replace(/_([a-z])/gi,'\u\1')	정규표현식 
			
			// ,분리 
			var splitStr = new Array();
			splitStr = str.split(/,|\n/);
			
			var tmp = "";	//sql result
			var s_tmp = "";	//VO result
			var qcell_tmp = "";	//QCELL result
			
			// 가공 
			for(a in splitStr){
				if(isNumber(a)){	//숫자일경우에만
					if(splitStr[a] != ""){
						var split_ = new Array();
						split_ = splitStr[a].split("_");
	
						tmp += '<result property="';
						s_tmp += 'private String ';
						qcell_tmp += "{width: '100',	key: '";
						
						for (b in split_){
							if(isNumber(b)){	//숫자일경우에만
								if(b == 0){
									tmp += split_[b];
									s_tmp += split_[b];
									qcell_tmp += split_[b];
								}else{
									tmp += split_[b].substring(0,1).toUpperCase()+split_[b].substring(1);
									s_tmp += split_[b].substring(0,1).toUpperCase()+split_[b].substring(1);
									qcell_tmp += split_[b].substring(0,1).toUpperCase()+split_[b].substring(1);
								}
							}
						}
						tmp += '" column="'+splitStr[a].toUpperCase()+'"/>\n';
						s_tmp += ';\n';
						
						if(a == splitStr.length-1){
							qcell_tmp += "',			title: ['"+splitStr[a].toUpperCase()+"'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}\n"	
						}else{
							qcell_tmp += "',			title: ['"+splitStr[a].toUpperCase()+"'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},\n"
						}
						
					}
				}
			}
			$("#outputArea").text(tmp);
			$("#outputAreaProperty").text(s_tmp);
			$("#outputQcellProperty").text(qcell_tmp);
		}
		
		function isNumber(s) {
			s += ''; // 문자열로 변환
			s = s.replace(/^\s*|\s*$/g, ''); // 좌우 공백 제거
			if (s == '' || isNaN(s)) return false;
			return true;
		}
		
		</script>
		
	</head>
	<body>
		<table>
	
			<form name="listform" id="listform">
	
				<thead>
	
					<tr>
	
						<th width="50px">설명</th>
						<th width="500px">값</th>
	
					</tr>
	
				</thead>
	
				<tbody>
				
					<tr>
						<td>입력값</br>1. , 구분</br>2. 행구분</td>
						<td><textarea id="inputArea" name="inputArea" cols="130" rows="5">RCPT_INC_NUM,RCPT_NUM,CRI_TM_ID</textarea></td>
					</tr>
					
					<tr>
						<td>sql resultMap</td>
						<td><textarea id="outputArea" name="outputArea" cols="130" rows="5"></textarea></td>
					</tr>
					
					<tr>
						<td>VO</td>
						<td><textarea id="outputAreaProperty" name="outputAreaProperty" cols="130" rows="5"></textarea></td>
					</tr>
					
					<tr>
						<td>QCell</td>
						<td><textarea id="outputQcellProperty" name="outputQcellProperty" cols="130" rows="5"></textarea></td>
					</tr>
	
				</tbody>
				
			</form>
		</table>
		<input type="button" onclick="javascript:generator();" value="변환">
		
	</body>
</html>
