<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="cafeformpanel" style="width:100%;">
  <table cellpadding=0 cellspacing=0 border=0 width='99%'>
	<tr><td height="2" width="100%" class="cafeformlimit"></td></tr>
	<tr>
	  <td class="cafeformfieldlast"><img src="<%=request.getContextPath()%>/cola/cafe/images/tb_icon.gif" width="5" height="5" align="absmiddle">운영회칙</td>
	</tr>
	<tr>
	  <td class="cafeformfieldlast" align="left">
	    <textarea id="rule_cmntRule" name="rule_cmntRule" style="width:98%;height:200px"><c:out value="${langVO.cmntRule}"/></textarea>
	  </td>
	</tr>
	<tr><td height="2" width="100%" class="cafeformlimit"></td></tr>
  </table>
  <table style="width:100%;">
	<tr>
	  <td align="right">  
		<span class="btn_pack medium"><a href="javascript:cfOp.baseInfo.setBaseInfoRule()"><util:message key="ev.title.save"/></a></span>
	  </td>
	</tr>
  </table>
</div>
