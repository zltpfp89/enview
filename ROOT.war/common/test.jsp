<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>일정관리(DEV)</title>	
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="http://local.common.or.kr:8080/common/js/jquery.js" ></script>	
<script type="text/javascript"> 
  function fn_add() {
    var formData = $('#schdForm').serialize();
    alert( formData);
    $.ajax({
      url : 'http://local.common.or.kr:8080/schd/insertScheduleAjax.common',
      data : formData,
      type : 'json',
      success: function(data) {
        alert( data);
      }});
  }    
</script>


</head>
<body>
<table>
<form id="schdForm" action='http://local.common.or.kr:8080/schd/insertScheduleAjax.common'>
<tr><td>일정타입</td><td><input type='text' name='schdClsf' value='0'> (0:개인일정)</td></tr>
<tr><td>일정옵션</td><td><input type='text' name='schdOptClsf'	value='0'> 0:회의  1:보고  2:기념일  3:기타 </td></tr>
<tr><td>제목</td><td><input type='text' name='schdTitl'	value='테스트제목'></td></tr>
<tr><td>장소</td><td><input type='text' name='schdPlce'	value='테스트장소'></td></tr>
<tr><td>시작일</td><td><input type='text' name='schdStrtDt'	value='20160301093700'></td></tr>
<tr><td>종료일</td><td><input type='text' name='schdEndDt'	value='20160301180000'></td></tr>
<tr><td>내용</td><td><input type='text' name='htmlCntns'	value='<p>테스트내용<br></p>'></td></tr>
</table>
</form>
<br>
<a onclick='fn_add()'>추가</a>
</body>
