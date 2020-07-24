<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>배너등록 가능일 보기</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<link href="<%=request.getContextPath()%>/hancer/css/super/banner/cssbasic.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.7.2.min.js"></script>
	</head>
	<script language="javascript">
	<!--
		var actPath = '<c:out value="${pageContext.request.contextPath}"/>'+"/hancer/banner";
		var yoil = ["SUN","MON","TUE","WEN","THI","FRI","SAT"];//요일을 표시하기 위한 배열
		var mon = [31,28,31,30,31,30,31,31,30,31,30,31];//각 월의 일수
		var y, m;
		today=new Date();
		y=today.getFullYear();
		m=today.getMonth();

		function makeCal(obj){
			
			if(m == 12){
				m=0;y=y+1;
			}
			if(m == -1){
				m=11;y=y-1;
			}
			var srchMon = y+""+((m+1)>9 ? ''+(m+1) : '0'+(m+1));
			$.ajax({ 
			   type: "POST", 
			   url: actPath+"/selectBannerReg.hanc", 
			   data: "BANNER_DAY="+srchMon,
			   dataType:"json",
			   success: function(data){ 
					var bannerCnt = data.data;
					var msg = data.msg;
					var limitCnt = data.limitcnt;
					if(msg == 'NoError'){					
						var today;
						obj.document.open(); // 문서를 지운다.
						day = new Date(y,m,1); 
						year = y;
						// 윤년이면 2월 날수를 29로...
						if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)
							mon[1] = 29;
						else
							mon[1] = 28;

						//년.월 출력
						obj.document.write('<link href="<%=request.getContextPath()%>/hancer/css/banner/cssbasic.css" rel="stylesheet" type="text/css"/>');
						obj.document.write('<div id="eventCalendar">');
						
						//요일 출력하기.
						obj.document.write('<table width="100%" border="0" cellspacing="0" cellpadding="0"><thead>\n<tr>');
						for (i=0;i<yoil.length;i++)
						{
							if (i==0)
								obj.document.write('<th>'+yoil[i]+'</th>');
							else if (i==6)
								obj.document.write('<th>'+yoil[i]+'</th>');
							else
								obj.document.write('<th>'+yoil[i]+'</th>');
						}
						obj.document.write('</tr></thead>');
						
						//달력 처음이 일요일이 아니면 공백으로 채움.
						if (day.getDay() != 0)
						{
							obj.document.write('<tr>');
							for (i=0;i<day.getDay();i++)
								obj.document.write('<td>&nbsp;</td>');
						}
						//날짜를 넣어줌
						for (i=1;i<=mon[day.getMonth()];i++)
						{
							today = new Date(y,m,i); // 오늘 날짜를 얻음 -> 요일을 알기 위해서.
							if (today.getDay() == 0) // 일요일이면 다음 줄로 넘어감.
								obj.document.write("<tr>");	
							if (bannerCnt[i-1].CNT >= limitCnt)
								obj.document.write('<td><font color="red">'+i+'['+bannerCnt[i-1].CNT+']</font></td>');
							else
								obj.document.write('<td>'+i+'['+bannerCnt[i-1].CNT+']</td>');
							
						}
						// 테이블의 나머지를 공백으로 채움.
						for (i=today.getDay();i<6;i++)
							obj.document.write('<td>&nbsp;</td>');
							
						obj.document.write('</table></div>');
						obj.document.close();
						document.getElementById("calendarTitle").innerHTML = '<span>'+year+'.'+(m+1)+'</span>';						
					}else{
						alert(msg);
					}
			   }, 
			   error: function(request, status, error) {
					//alert('네트워크 문제가 발생하였습니다.');
					
					alert(request.responseText);
			   }
			});			
		}
	-->
	</script>
	<body BGCOLOR="#FFFFFF" onLoad="makeCal(frames[0])">
		<center>
			<div id="eventCalendar" style="width:280px; padding-top:15px;">
				<div class="title">
					<strong id="calendarTitle"></strong> 
					<span class="page_navi">
						<a href="#link" onClick="m-=1;makeCal(frames[0],m);"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_prev.jpg" alt="이전 달" border="0" /></a> 
						<a href="#link" onClick="m+=1;makeCal(frames[0],m);"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_next.gif" alt="다음 달" border="0" /></a>
					</span>
				</div>
			</div>
			<iframe src="" width="280px;" height="100%" name="calendar" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe><br>
		</center>
	</body>
</html>