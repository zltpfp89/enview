<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

	<div class="board_btn_wrap" style="margin-top:30px;">
		<div class="board_btn_wrap_left">
			<h3><util:message key="cf.title.makeCafe"/></h3>
		</div>
	</div>
	<form id="makeCafeFileForm" name="makeCafeFileForm" style="display:inline" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
		<table class="table_type01 write" summary="게시판">
			<caption>게시판</caption>
			<colgroup>
				<col width="150px;">
				<col width="auto;">
			</colgroup>			
			<tbody>				
			<tr>
				<th><util:message key="cf.title.cafe.name"/><%--카페이름--%>*</th>
				<td>
					<input type="text" id="makeCafe_cmntNm" name="makeCafe_cmntNm" maxLength="30" class="w_p100" title="<util:message key="cf.title.cafe.name"/>"/>					
				</td>
			</tr>
			<tr>
				<th><util:message key="cf.title.cafe.url"/><%--카페URL--%>*</th>
				<td>
					
					<span class="txt_cafe"><c:out value="${urlPrefix}"/></span>
					<input type="text" id="makeCafe_cmntUrl" name="makeCafe_cmntUrl" maxLength="30" class="w_p50"
					       onfocus="cfHome.dupCheckCmntUrlReset()" 
					       onblur="cfHome.dupCheckCmntUrl(this)"
					       onkeyup="cfHome.keyCheckCmntUrl(this)"
					       
					       />
					<br>
					<input type="hidden" id="cmntUrlValidted" value="false"/>
					<span id="makeCafe_cmntUrlRslt"></span>					
				</td>
			</tr>
			<tr>
				<th><util:message key="cf.title.openYn"/></th>
				<td>
					<c:forEach items="${openYnList}" var="openYn">
					 <input type="checkbox" id="makeCafe_openYn" name="makeCafe_openYn" class="lm10" value="<c:out value="${openYn.code}"/>" <c:if test="${cmntVO.openYn==openYn.code}">checked</c:if>
					         onclick="ebUtil.setCheckedValue(document.getElementsByName('makeCafe_openYn'),'<c:out value="${openYn.code}"/>')" />
					  <c:out value="${openYn.codeName}"/>&nbsp;&nbsp;&nbsp;&nbsp;
					</c:forEach>
				</td>
			</tr>
			<tr>
				<th><util:message key="mm.title.category"/><%--카테고리--%></th>
				<td>
				    <c:if test="${homeForm.cateHier >= '1'}">
					  <select id="makeCafe_cateId1" name="makeCafe_cateId1" class='cafedropdownlist' <c:if test="${homeForm.cateHier >= '2'}">onchange="cfHome.selectCateId(this, 1)"</c:if>>
					    <c:forEach items="${cmntCateList1}" var="cmntCate1">
						  <option value="<c:out value="${cmntCate1.cateId}"/>"><c:out value="${cmntCate1.cateNm}"/></option>
					    </c:forEach>
					  </select>
					</c:if>
				</td>
			</tr>
			<tr>
				<th><util:message key="cf.title.cafe.tag"/><%--<util:message key="cf.title.cafe.tag"/><%--카페태그--%>*</th>
				 <td class="cafeformfield" align="left">
				    <input type="text" id="makeCafe_cmntTag1" name="makeCafe_cmntTag1" class="w_100"  maxlength="30" onfocus="cfHome.focusCmntTag(this,1)" title="<util:message key="cf.title.cafe.tag"/>"/>
				    <input type="text" id="makeCafe_cmntTag2" name="makeCafe_cmntTag2" class="w_100"  maxlength="30" style="display:none" onfocus="cfHome.focusCmntTag(this,2)" title="<util:message key="cf.title.cafe.tag"/>"/>
				    <input type="text" id="makeCafe_cmntTag3" name="makeCafe_cmntTag3" class="w_100"  maxlength="30" style="display:none" onfocus="cfHome.focusCmntTag(this,3)" title="<util:message key="cf.title.cafe.tag"/>"/>
				    <input type="text" id="makeCafe_cmntTag4" name="makeCafe_cmntTag4" class="w_100"  maxlength="30" style="display:none" onfocus="cfHome.focusCmntTag(this,4)" title="<util:message key="cf.title.cafe.tag"/>"/>
					<br>
				    <input type="text" id="makeCafe_cmntTag5" name="makeCafe_cmntTag5" class="w_100"  maxlength="30" style="display:none" onfocus="cfHome.focusCmntTag(this,5)" title="<util:message key="cf.title.cafe.tag"/>"/>
				    <input type="text" id="makeCafe_cmntTag6" name="makeCafe_cmntTag6" class="w_100"  maxlength="30" style="display:none" onfocus="cfHome.focusCmntTag(this,6)" title="<util:message key="cf.title.cafe.tag"/>"/>
				    <input type="text" id="makeCafe_cmntTag7" name="makeCafe_cmntTag7" class="w_100"  maxlength="30" style="display:none" onfocus="cfHome.focusCmntTag(this,7)" title="<util:message key="cf.title.cafe.tag"/>"/>
				    <input type="text" id="makeCafe_cmntTag8" name="makeCafe_cmntTag8" class="w_100"  maxlength="30" style="display:none" title="<util:message key="cf.title.cafe.tag"/>"/>
				  </td>
			</tr>
			<tr>
				<th><util:message key="cf.prop.cmntLang.cmntIntro"/>*</th>
				<td class="cafeformfield" align="left">
					<textarea id="makeCafe_cmntIntro" name="makeCafe_cmntIntro" class="cafe_textarea" style="width:98%;height:70px"></textarea>
				</td>
			</tr>
			<tr style="display:none;">
			  <td width="20%" class="cafeformlabel"><util:message key="cf.prop.theme"/></td>
			  <td class="cafeformfield" align="left">
				<input type="text" id="makeCafe_themeNm" name="makeCafe_themeNm" maxLength="" class="full_cafetextfield" value="encafe"/>
			  </td>
			</tr>
			<tr>
				<th><util:message key="cf.title.cafeImg"/></th>
				<td class="cafeformfield" align="left">
					<input type="file" id="file" name="file" class="cafe_textfield" style="width:98%"/>
				</td>
			</tr>
			</tbody>
		</table>
	</form>
	<div class="board_btn_wrap">				
		<div class="board_btn_wrap_right" id="btns_make_cafe">
			<a id="btn_make_cafe" href="#" onclick="javascript:cfHome.checkMakeCafe()" class="btn black"><util:message key="cf.title.makeCafe"/></a>
			<a href="#" onclick="javascript:cfHome.cancelMakeCafe()" class="btn white"><util:message key="ev.title.cancel"/></a>
		</div>
	</div>
	<form name="setForm" method="POST" action="" onsubmit="return false">
	  <input type=hidden name=cateHier value=<c:out value="${homeForm.cateHier}"/>>
	  <!--input type=hidden name=cmntNm>
	  <input type=hidden name=cmntUrl>
	  <input type=hidden name=openYn>
	  <input type=hidden name=cateId>
	  <input type=hidden name=cmntTag>
	  <input type=hidden name=cmntIntro>
	  <input type=hidden name=themeNm-->
	  <input type=hidden name=cmntImgFileMask>
	</form>
	<iframe name='makeCafeImg' frameborder=0 width=0 height=0></iframe>
