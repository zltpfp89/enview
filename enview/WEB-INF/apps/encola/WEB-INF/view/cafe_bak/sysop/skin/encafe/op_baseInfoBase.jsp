<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
  <table cellpadding=0 cellspacing=0 border=0 width='100%' class="cafeformpanel">
	<tr><td height="2" colspan="2" width="100%" class="cafegridlimit"></td></tr>
	<tr>
	  <td width="20%" class="cafeformlabel">카페 이름</td>
	  <td class="cafeformfieldlast" align="left">
		<input type="text" id="base_cmntNm" name="base_cmntNm" value="<c:out value="${cmntVO.cmntNm}"/>" maxLength="30" class="full_cafetextfield"/>
	  </td>
	</tr>
	<tr>
	  <td width="20%" class="cafeformlabel">카페 주소</td>
	  <td class="cafeformfieldlast" align="left">
		<c:out value="${cafeFullUrl}"/>
	  </td>
	</tr>
	<tr>
	  <td width="20%" class="cafeformlabel">공개 여부</td>
	  <td class="cafeformfieldlast" align="left">
	    <c:forEach items="${openYnList}" var="openYn">
	      <input type="checkbox" id="base_openYn" name="base_openYn"  value="<c:out value="${openYn.code}"/>" <c:if test="${cmntVO.openYn==openYn.code}">checked</c:if>
		         onclick="ebUtil.setCheckedValue(document.getElementsByName('base_openYn'),'<c:out value="${openYn.code}"/>')" />
		  <c:out value="${openYn.codeName}"/>&nbsp;&nbsp;&nbsp;&nbsp;
		</c:forEach>
	  </td>
	</tr>
	<tr>
	  <td width="20%" class="cafeformlabel">가입 방식</td>
	  <td class="cafeformfieldlast" align="left">
	    <c:forEach items="${regTypeList}" var="regType">
	      <input type="checkbox" id="base_regType" name="base_regType"  value="<c:out value="${regType.code}"/>" <c:if test="${cmntVO.regType==regType.code}">checked</c:if>
		         onclick="ebUtil.setCheckedValue(document.getElementsByName('base_regType'),'<c:out value="${regType.code}"/>')" />
		  <c:out value="${regType.codeName}"/>&nbsp;&nbsp;&nbsp;&nbsp;
		</c:forEach>
	  </td>
	</tr>
	<tr>
	  <td width="20%" class="cafeformlabel">회원명 표시 방식</td>
	  <td class="cafeformfieldlast" align="left">
	    <c:forEach items="${nmTypeList}" var="nmType">
	      <input type="checkbox" id="base_nmType" name="base_nmType"  value="<c:out value="${nmType.code}"/>" <c:if test="${cmntVO.nmType==nmType.code}">checked</c:if>
		         onclick="ebUtil.setCheckedValue(document.getElementsByName('base_nmType'),'<c:out value="${nmType.code}"/>')" />
		  <c:out value="${nmType.codeName}"/>&nbsp;&nbsp;&nbsp;&nbsp;
		</c:forEach>
	  </td>
	</tr>
	<tr>
	  <td width="20%" class="cafeformlabel"><util:message key="mm.title.category"/><%--카테고리--%></td>
	  <td class="cafeformfieldlast" align="left">
	    <c:if test="${opForm.cateHier >= '1'}">
		  <select id="base_cateId1" name="base_cateId1"  <c:if test="${opForm.cateHier >= '2'}">onchange="cfHome.selectCateId(this, 1)"</c:if>>
		    <c:forEach items="${cmntCateList1}" var="cmntCate1">
			  <option value="<c:out value="${cmntCate1.cateId}"/>" <c:if test="${opForm.cateId1 == cmntCate1.cateId}">selected</c:if>><c:out value="${cmntCate1.cateNm}"/></option>
		    </c:forEach>
		  </select>
		</c:if>
	    <c:if test="${opForm.cateHier >= '2'}">
		  <select id="base_cateId2" name="base_cateId2"  <c:if test="${opForm.cateHier >= '3'}">onchange="cfHome.selectCateId(this, 2)"</c:if>>
		    <c:forEach items="${cmntCateList2}" var="cmntCate2">
			  <option value="<c:out value="${cmntCate2.cateId}"/>" <c:if test="${opForm.cateId2 == cmntCate2.cateId}">selected</c:if>><c:out value="${cmntCate2.cateNm}"/></option>
		    </c:forEach>
		  </select>
		</c:if>
	    <c:if test="${opForm.cateHier >= '3'}">
		  <select id="base_cateId3" name="base_cateId3">
		    <c:forEach items="${cmntCateList3}" var="cmntCate3">
			  <option value="<c:out value="${cmntCate3.cateId}"/>" <c:if test="${opForm.cateId3 == cmntCate3.cateId}">selected</c:if>><c:out value="${cmntCate3.cateNm}"/></option>
		    </c:forEach>
		  </select>
		</c:if>
	  </td>
	</tr>
	<tr>
	  <td width="20%" class="cafeformlabel"><util:message key="cf.title.cafe.tag"/><%--카페태그-%></td>
	  <td class="cafeformfieldlast" align="left">
	    <c:forEach items="${tagList}" var="tag" varStatus="status">
	      <input type="text" id="base_cmntTag<c:out value="${status.count}"/>" name="base_cmntTag<c:out value="${status.count}"/>" maxLength="30"
                 <c:if test="${!empty tag.tag}">style="width:100px"</c:if> <c:if test="${empty tag.tag}">style="width:100px;display:none"</c:if>
				 <c:if test="${!status.last}">onfocus="cfHome.focusCmntTag(this,<c:out value="${status.count}"/>)"</c:if>
				 value="<c:out value="${tag.tag}"/>"/>
		  <c:if test="${status.count == 4}"><br></c:if>
		</c:forEach>
	  </td>
	</tr>
	<tr>
	  <td width="20%" class="cafeformlabel">소개글</td>
	  <td class="cafeformfieldlast" align="left">
	    <textarea id="base_cmntIntro" name="base_cmntIntro" style="width:98%;height:70px"><c:out value="${cmntVO.cmntIntro}"/></textarea>
	  </td>
	</tr>
	<tr>
	  <td width="20%" class="cafeformlabel">가입 환영 인사</td>
	  <td class="cafeformfieldlast" align="left">
	    <textarea id="base_cmntWelcome" name="base_cmntWelcome" style="width:98%;height:70px"><c:out value="${cmntVO.cmntWelcome}"/></textarea>
	  </td>
	</tr>
	<!--tr>
	  <td width="20%" class="cafeformlabel">소모임 개설 허용 갯수</td>
	  <td class="cafeformfield" align="left">
		<input type="text" id="base_somoLimitCnt" name="base_somoLimitCnt" value="<c:out value="${cmntVO.somoLimitCnt}"/>" maxLength="2"/>
	  </td>
	</tr-->
  </table>
  <form id="baseInfoBaseFileForm" name="baseInfoBaseFileForm" style="display:inline" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
  <table cellpadding=0 cellspacing=0 border=0 width='100%' class="cafeformpanel">
	<tr>
	  <td width="20%" class="cafeformlabel">카페 대표 이미지</td>
	  <td class="cafeformfieldlast" align="left">
	    <a href="javascript:cfOp.popupView('<c:out value="${cmntVO.cmntImgSrc}"/>')"><c:out value="${cmntVO.thumbImgCmntImg}" escapeXml="false"/></a>
		&nbsp;<input type="file" id="file" name="file" style="width:84%;"/>
	  </td>
    </tr>
	<tr><td height="2" colspan="2" width="100%" class="cafegridlimit"></td></tr>
  </table>
  </form>
  <div class="cafecontrolpanel">
	<span class="btn_pack small">
		<a href="#" onclick="javascript:cfOp.baseInfo.checkBaseInfoBase()">저 장</a>
	</span>
  </div>
<form name="setForm" method="POST" action="" onsubmit="return false">
  <input type=hidden name=cateHier value=<c:out value="${opForm.cateHier}"/>>
  <input type=hidden name=cmntImgFileMask>
</form>
<iframe name='baseInfoBaseImg' frameborder=0 width=0 height=0></iframe>
