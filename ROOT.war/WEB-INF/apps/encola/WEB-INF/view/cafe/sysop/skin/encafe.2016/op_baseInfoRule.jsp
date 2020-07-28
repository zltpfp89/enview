<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="cafeformpanel" style="width:100%;">
  <table cellpadding=0 cellspacing=0 border=0 width='99%'>
	<tr><td height="2" width="100%" class="cafeformlimit"></td></tr>
	<tr>
	  <td class="cafeformlabel">운영회칙</td>
	</tr>
	<tr>
	  <td class="cafeformfieldlast" align="left">
	    <textarea id="rule_cmntRule" name="rule_cmntRule" style="width:98%;height:200px"><c:out value="${langVO.cmntRule}"/></textarea>
	  </td>
	</tr>
	<tr><td height="2" width="100%" class="cafeformlimit"></td></tr>
  </table>
  <table style="width:99%;">
	<tr>
	  <td align="right">  
		<span class="btn_pack medium"><a href="javascript:cfOp.baseInfo.setBaseInfoRule()">저장</a></span>
	  </td>
	</tr>
  </table>
</div>
