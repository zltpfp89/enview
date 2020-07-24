<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<div class="cafeformpanel" style="width: 100%; padding-right: 0px; padding-left: 0px;">
  <table cellpadding=0 cellspacing=0 border=0 width='100%'>
	<input type="hidden" id="makeCafe_isCreate">
	<tr><td colspan="2" width="100%" class="webformheaderline"></td></tr>
	<tr>
	  <td width="20%" class="cafeformlabel">카페 이름 *</td>
	  <td class="cafeformfield" align="left">
		<input type="text" id="makeCafe_cmntNm" name="makeCafe_cmntNm" maxLength="30" class="full_cafetextfield"/>
	  </td>
	</tr>
	<tr>
	  <td width="20%" class="cafeformlabel">카페 주소 *</td>
	  <td class="cafeformfield" align="left">
		<c:out value="${urlPrefix}"/>
		<input type="text" id="makeCafe_cmntUrl" name="makeCafe_cmntUrl" maxLength="30" class="full_cafetextfield" 
		       onfocus="cfHome.dupCheckCmntUrlReset()" onblur="cfHome.dupCheckCmntUrl(this)"/>
		<br>
		<input type="hidden" id="cmntUrlValidted" value="false"/>
		<span id="makeCafe_cmntUrlRslt"></span>
	  </td>
	</tr> 
	<!--tr>
	  <td width="20%" class="cafeformlabel">공개 여부</td>
	  <td class="cafeformfield" align="left">
	    <input type="checkbox" id="makeCafe_openYn" name="makeCafe_openYn" class="full_cafetextfield" value="Y" <c:if test="${cmntVO.openYn=='Y'}">checked</c:if>
		       onclick="ebUtil.setCheckedValue(document.getElementsByName('makeCafe_openYn'),'Y')" />
		<util:message key='co.property.openYn.yes'/>&nbsp;&nbsp;&nbsp;&nbsp;
	    <input type="checkbox" id="makeCafe_openYn" name="makeCafe_openYn" class="full_cafetextfield" value="N" <c:if test="${cmntVO.openYn=='N'}">checked</c:if>
		       onclick="ebUtil.setCheckedValue(document.getElementsByName('makeCafe_openYn'),'N')" />
		<util:message key='co.property.openYn.no'/>
	  </td>
	</tr-->
	<tr>
	  <td width="20%" class="cafeformlabel">공개 여부</td>
	  <td class="cafeformfield" align="left">
		<c:forEach items="${openYnList}" var="openYn">
	      <input type="checkbox" id="makeCafe_openYn" name="makeCafe_openYn" class="full_cafetextfield" value="<c:out value="${openYn.code}"/>" <c:if test="${cmntVO.openYn==openYn.code}">checked</c:if>
		         onclick="ebUtil.setCheckedValue(document.getElementsByName('makeCafe_openYn'),'<c:out value="${openYn.code}"/>')" />
		  <c:out value="${openYn.codeName}"/>&nbsp;&nbsp;&nbsp;&nbsp;
		</c:forEach>
	  </td>
	</tr>
	<tr>
	  <td width="20%" class="cafeformlabel"><util:message key="mm.title.category"/><%--카테고리--%></td>
	  <td class="cafeformfield" align="left">
	    <c:if test="${homeForm.cateHier >= '1'}">
		  <select id="makeCafe_cateId1" name="makeCafe_cateId1" class='cafedropdownlist' <c:if test="${homeForm.cateHier >= '2'}">onchange="cfHome.selectCateId(this, 1)"</c:if>>
		    <c:forEach items="${cmntCateList1}" var="cmntCate1">
			  <option value="<c:out value="${cmntCate1.cateId}"/>"><c:out value="${cmntCate1.cateNm}"/></option>
		    </c:forEach>
		  </select>
		</c:if>
	    <c:if test="${homeForm.cateHier >= '2'}">
		  <select id="makeCafe_cateId2" name="makeCafe_cateId2" class='cafedropdownlist' <c:if test="${homeForm.cateHier >= '3'}">onchange="cfHome.selectCateId(this, 2)"</c:if>>
		    <c:forEach items="${cmntCateList2}" var="cmntCate2">
			  <option value="<c:out value="${cmntCate2.cateId}"/>"><c:out value="${cmntCate2.cateNm}"/></option>
		    </c:forEach>
		  </select>
		</c:if>
	    <c:if test="${homeForm.cateHier >= '3'}">
		  <select id="makeCafe_cateId3" name="makeCafe_cateId3" class='cafedropdownlist'>
		    <c:forEach items="${cmntCateList3}" var="cmntCate3">
			  <option value="<c:out value="${cmntCate3.cateId}"/>"><c:out value="${cmntCate3.cateNm}"/></option>
		    </c:forEach>
		  </select>
		</c:if>
	  </td>
	</tr>
	<tr>
	  <td width="20%" class="cafeformlabel"><util:message key="cf.title.cafe.tag"/><%--카페태그-%> *</td>
	  <td class="cafeformfield" align="left">
	    <input type="text" id="makeCafe_cmntTag1" name="makeCafe_cmntTag1" maxLength="30" class="full_cafetextfield" style="width:100px" onfocus="cfHome.focusCmntTag(this,1)"/>
	    <input type="text" id="makeCafe_cmntTag2" name="makeCafe_cmntTag2" maxLength="30" class="full_cafetextfield" style="width:100px;display:none" onfocus="cfHome.focusCmntTag(this,2)"/>
	    <input type="text" id="makeCafe_cmntTag3" name="makeCafe_cmntTag3" maxLength="30" class="full_cafetextfield" style="width:100px;display:none" onfocus="cfHome.focusCmntTag(this,3)"/>
	    <input type="text" id="makeCafe_cmntTag4" name="makeCafe_cmntTag4" maxLength="30" class="full_cafetextfield" style="width:100px;display:none" onfocus="cfHome.focusCmntTag(this,4)"/>
		<br>
	    <input type="text" id="makeCafe_cmntTag5" name="makeCafe_cmntTag5" maxLength="30" class="full_cafetextfield" style="width:100px;display:none" onfocus="cfHome.focusCmntTag(this,5)"/>
	    <input type="text" id="makeCafe_cmntTag6" name="makeCafe_cmntTag6" maxLength="30" class="full_cafetextfield" style="width:100px;display:none" onfocus="cfHome.focusCmntTag(this,6)"/>
	    <input type="text" id="makeCafe_cmntTag7" name="makeCafe_cmntTag7" maxLength="30" class="full_cafetextfield" style="width:100px;display:none" onfocus="cfHome.focusCmntTag(this,7)"/>
	    <input type="text" id="makeCafe_cmntTag8" name="makeCafe_cmntTag8" maxLength="30" class="full_cafetextfield" style="width:100px;display:none"/>
	  </td>
	</tr>
	<tr>
	  <td width="20%" class="cafeformlabel">소개글 *</td>
	  <td class="cafeformfield" align="left">
	    <textarea id="makeCafe_cmntIntro" name="makeCafe_cmntIntro" class="full_cafetextarea" style="width:98%;height:70px"></textarea>
	  </td>
	</tr>
	<tr>
	  <td width="20%" class="cafeformlabel">카페 테마</td>
	  <td class="cafeformfield" align="left">
		<input type="text" id="makeCafe_themeNm" name="makeCafe_themeNm" maxLength="" class="full_cafetextfield"/>
	  </td>
	</tr>
  </table>
  <form id="makeCafeFileForm" name="makeCafeFileForm" style="display:inline" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
  <table cellpadding=0 cellspacing=0 border=0 width='100%'>
	<tr style="border-bottom: 1px solid #CACACA;">
	  <td width="20%" class="cafeformlabel">카페 대표 이미지</td>
	  <td class="cafeformfield" align="left">
		<input type="file" id="file" name="file" class="full_cafetextfield" style="width:98%"/>
	  </td>
    </tr>
  </table>
  </form>
  <table style="width:100%;margin-top:5px;" class="cafebuttonpanel">
	<tr>
	  <td align="right">
	  	<span class="btn_pack small">
			<a href="#" onclick="javascript:cfHome.checkMakeCafe()">카페만들기</a>
		</span>
		<span class="btn_pack small">
			<a href="#" onclick="javascript:cfHome.cancelMakeCafe()">취소</a>
		</span>
	  </td>
	</tr>
  </table>
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
