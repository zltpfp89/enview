
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/configurationManager.js"></script>

<form id="ConfigurationManager_EditForm" style="display:inline" action="" method="post">
	<input type="hidden" id="ConfigurationManager_isCreate">
	<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
 		<caption>게시판</caption>
		<colgroup>
			<col width="140px" />
			<col width="*" />
			<col width="140px" />
			<col width="*" />
		</colgroup>			
		<tr>
			<th class="L"><util:message key='ev.prop.configuration.configCd'/> <em>*</em></th>
			<td colspan="3" class="L">
				<input type="text" id="ConfigurationManager_configCd" name="configCd" value="<c:out value="${aConfigurationVO.configCd}"/>" maxLength="100" label="<util:message key='ev.prop.configuration.configCd'/>" class="txt_600" readonly="readonly"/>
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.prop.configuration.systemCode'/> <em>*</em></th>
			<td class="L">
				<div class="sel_100">
					<select id="ConfigurationManager_systemCode" name="systemCode" label="<util:message key='ev.prop.configuration.systemCode'/>" class='txt_145'>
						<c:forEach items="${systemCodeList}" var="systemCode">
							<option value="<c:out value="${systemCode.code}"/>"><c:out value="${systemCode.codeName}"/></option>
						</c:forEach>
					</select>
				</div>
			</td>
			<th class="L"><util:message key='ev.prop.configuration.configType'/> <em>*</em></th>
			<td class="L">
				<div class="sel_100">
					<select id="ConfigurationManager_configType" name="configType" label="<util:message key='ev.prop.configuration.configType'/>" class='txt_145'>
						<c:forEach items="${configTypeList}" var="configType">
							<option value="<c:out value="${configType.code}"/>"><c:out value="${configType.codeName}"/></option>
						</c:forEach>
					</select>
				</div>
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.title.configuration.configValue'/> <em>*</em></th>
			<td colspan="3" class="L">
				<textarea id="ConfigurationManager_configValue" name="configValue" value="<c:out value="${aConfigurationVO.configValue}"/>" cols="80" rows="3" maxLength="512" label="<util:message key='ev.title.configuration.configValue'/>" class="txtbox" >	</textarea>
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.title.configuration.encrypt'/> </th>
			<td colspan="3" class="L">
				<input type="checkbox" id="ConfigurationManager_encrypt" name="encrypt" value="Y">
				<util:message key='ev.title.configuration.encrypt.desc'/>
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.prop.configuration.remark'/></th>
			<td colspan="3" class="L">
				<textarea id="ConfigurationManager_remark" name="remark" value="<c:out value="${aConfigurationVO.remark}"/>" cols="80" rows="3" maxLength="250" label="<util:message key='ev.prop.configuration.remark'/>" class="txtbox" ></textarea>
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.prop.configuration.updUserId'/></th>
			<td class="L">
				<input type="text" id="ConfigurationManager_updUserId" name="updUserId" value="<c:out value="${aConfigurationVO.updUserId}"/>" maxLength="" label="<util:message key='ev.prop.configuration.updUserId'/>" class="txt_100" />
			</td>
			<th class="L"><util:message key='ev.prop.configuration.updDatim'/></th>
			<td class="L"><input type="text" id="ConfigurationManager_updDatim" name="updDatim" value="<c:out value="${aConfigurationVO.updDatim}"/>" label="<util:message key='ev.prop.configuration.updDatim'/>" class="txt_200" /></td>
		</tr>
	</table>
	<!-- btnArea-->
	<div class="btnArea">
		<div class="rightArea">
			<a href="javascript:aConfigurationManager.doUpdate(true)" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
		</div>
	</div>
	<!-- btnArea//-->	
</form>

<div id="ConfigurationManager_ConfigurationChooser"></div>