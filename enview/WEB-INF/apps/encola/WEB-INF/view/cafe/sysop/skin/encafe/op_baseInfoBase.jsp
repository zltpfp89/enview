<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<form id="baseInfoBaseFileForm" name="baseInfoBaseFileForm" style="display:inline" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
	<table class="table_type01 write" summary="게시판">
		<caption><util:message key="cf.title.basicInfo"/></caption>
		<colgroup>
			<col width="150px;">
			<col width="auto;">
		</colgroup>			
		<tbody>				
		<tr>
			<th><label for="in_txt_01"><util:message key="cf.title.cafeName"/></label></th>
			<td>
				<input type="text" id="base_cmntNm" class="w_p100" name="base_cmntNm" value="<c:out value="${cmntVO.cmntNm}"/>" class="full_cafetextfield" maxlength="60" title="<util:message key="cf.title.cafeName"/>"/>
			</td>
		</tr>
		<tr>
			<th><util:message key="cf.title.cafeAddress"/></th>
			<td><c:out value="${cafeFullUrl}"/></td>
		</tr>
		<tr>
			<th><util:message key="cf.title.openYn"/></th>
			<td>
			<c:forEach items="${openYnList}" var="openYn">
		    	<input type="checkbox" id="base_openYn" name="base_openYn" class="lm10" value="<c:out value="${openYn.code}"/>" <c:if test="${cmntVO.openYn==openYn.code}">checked</c:if>
			         onclick="cfOp.baseInfo.setOpenType('<c:out value="${openYn.code}"/>')" />
				<label class="lm3"><c:out value="${openYn.codeName}"/></label>
			</c:forEach>
			</td>
		</tr>
		<tr>
			<th><util:message key="mm.title.category"/><%--카테고리--%></th>
			<td>
				<c:if test="${opForm.cateHier >= '1'}">
				  <select id="base_cateId1" class="rm5" name="base_cateId1"  <c:if test="${opForm.cateHier >= '2'}">onchange="cfHome.selectCateId(this, 1)"</c:if>>
				    <c:forEach items="${cmntCateList1}" var="cmntCate1">
					  <option value="<c:out value="${cmntCate1.cateId}"/>" <c:if test="${opForm.cateId1 == cmntCate1.cateId}">selected</c:if>><c:out value="${cmntCate1.cateNm}"/></option>
				    </c:forEach>
				  </select>
				</c:if>
				    <c:if test="${opForm.cateHier >= '2'}">
					  <select id="base_cateId2" class="rm5" name="base_cateId2"  <c:if test="${opForm.cateHier >= '3'}">onchange="cfHome.selectCateId(this, 2)"</c:if>>
					    <c:forEach items="${cmntCateList2}" var="cmntCate2">
						  <option value="<c:out value="${cmntCate2.cateId}"/>" <c:if test="${opForm.cateId2 == cmntCate2.cateId}">selected</c:if>><c:out value="${cmntCate2.cateNm}"/></option>
					    </c:forEach>
					  </select>
					</c:if>
				    <c:if test="${opForm.cateHier >= '3'}">
					  <select id="base_cateId3" class="rm5"  name="base_cateId3">
					    <c:forEach items="${cmntCateList3}" var="cmntCate3">
						  <option value="<c:out value="${cmntCate3.cateId}"/>" <c:if test="${opForm.cateId3 == cmntCate3.cateId}">selected</c:if>><c:out value="${cmntCate3.cateNm}"/></option>
					    </c:forEach>
					  </select>
					</c:if>
		  </td>
		</tr>
		<tr>
			<th><label for="in_txt_02"><util:message key="cf.title.cafe.tag"/><%--카페태그--%></label></th>
			<td>
				<c:forEach items="${tagList}" var="tag" varStatus="status">
			      <input type="text" id="base_cmntTag<c:out value="${status.count}"/>" name="base_cmntTag<c:out value="${status.count}"/>"  class="w_p100" 
		                 <c:if test="${!empty tag.tag}">style="width:100px"</c:if> <c:if test="${empty tag.tag}">style="width:100px;display:none"</c:if>
						 <c:if test="${!status.last}">onfocus="cfHome.focusCmntTag(this,<c:out value="${status.count}"/>)"</c:if>
						 value="<c:out value="${tag.tag}"/>" maxlength="30" />
				  <c:if test="${status.count == 4}"><br></c:if>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<th><label for="in_txt_03"><util:message key="cf.prop.cmntLang.cmntIntro"/></label></th>
			<td>
				<textarea id="base_cmntIntro" name="base_cmntIntro" class="cafe_textarea" maxlength="600" title="<util:message key="cf.prop.cmntLang.cmntIntro"/>"><c:out value="${cmntVO.cmntIntro}"/></textarea>
			</td>
		</tr>
		<tr>
			<th><label for="in_txt_04"><util:message key="cf.prop.cmntLang.cmntWelcome"/></label></th>
			<td>
				<textarea id="base_cmntWelcome" name="base_cmntWelcome" class="cafe_textarea" maxlength="600" title="<util:message key="cf.prop.cmntLang.cmntWelcome"/>"><c:out value="${cmntVO.cmntWelcome}"/></textarea>
			</td>
		</tr>
		<tr>
			<th><label for="in_file"><util:message key="cf.title.cafeImg"/></label></th>
			<td>
				<a href="javascript:cfOp.popupView('<c:out value="${cmntVO.cmntImgSrc}"/>')"><c:out value="${cmntVO.thumbImgCmntImg}" escapeXml="false"/></a>
				<input type="file" id="file" name="file" class="cafe_textfield"/>
			  
			</td>
		</tr>
		<tr><td height="2" colspan="2" width="100%" class="cafegridlimit"></td></tr>
		<tr>
	  		<th><util:message key="cf.title.joiningMethod"/></th>
	  		<td>
			    <c:forEach items="${regTypeList}" var="regType">
			      <input type="checkbox" id="base_regType" name="base_regType"  value="<c:out value="${regType.code}"/>" <c:if test="${cmntVO.regType==regType.code}">checked</c:if>
				         onclick="ebUtil.setCheckedValue(document.getElementsByName('base_regType'),'<c:out value="${regType.code}"/>')" />
				  <c:out value="${regType.codeName}"/>
				  &nbsp; &nbsp;
				</c:forEach>
			</td>
		</tr>
		<%--
		<tr>
	  		<th><util:message key="cf.title.nameMethod"/></th>
	  		<td>
			    <c:forEach items="${nmTypeList}" var="nmType">
			      <input type="checkbox" id="base_nmType" name="base_nmType"  value="<c:out value="${nmType.code}"/>" <c:if test="${cmntVO.nmType==nmType.code}">checked</c:if>
				         onclick="ebUtil.setCheckedValue(document.getElementsByName('base_nmType'),'<c:out value="${nmType.code}"/>')" />
				  <c:out value="${nmType.codeName}"/>
				  &nbsp; &nbsp;
				</c:forEach>
	  		</td>
		</tr>
		 --%>
		</tbody>
	</table>
	<input type="hidden" id="base_nmType" name="base_nmType" value="A"/>
</form>

<div class="board_btn_wrap">				
	<div class="board_btn_wrap_center">
		<a href="#" onclick="javascript:cfOp.baseInfo.checkBaseInfoBase()" class="btn black"><util:message key="cf.title.save"/></a>
	</div>
</div>

<form name="setForm" method="POST" action="" onsubmit="return false">
  <input type=hidden name=cateHier value=<c:out value="${opForm.cateHier}"/>>
  <input type=hidden name=cmntImgFileMask>
</form>
<iframe name='baseInfoBaseImg' frameborder=0 width=0 height=0></iframe>
