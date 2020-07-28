<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

  <table class="table_type01 write" summary="게시판">
	<caption><util:message key="cf.prop.cmntLang.cmntRule"/></caption>
	<colgroup>
		<col width="150px;">
		<col width="auto;">
	</colgroup>			
	<tbody>		
	<tr>
	  <th><util:message key="cf.prop.cmntLang.cmntRule"/></th>
	  <td>
		<textarea id="rule_cmntRule" name="rule_cmntRule" class="cafe_textarea" style="width:99%;height:70px; border:1px solid #ddd"><c:out value="${langVO.cmntRule}"/></textarea>
	  </td>
	</tr>
	</tbody>
	</table>
	<div class="board_btn_wrap">				
		<div class="board_btn_wrap_center">
			<a href="javascript:cfOp.baseInfo.setBaseInfoRule()" class="btn black"><util:message key="cf.title.save"/></a>
		</div>
	</div>