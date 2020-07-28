<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager" %>
<%
	
	request.setAttribute("roles",EnviewSSOManager.getUserInfo(request).getRoleList());  //사용자가 가지고있는 모든 역할(role) 조회  List 형태
	request.setAttribute("INVIGTOR_ROLE_YN",  EnviewSSOManager.getUserInfo(request).getHasRole("INVIGTOR_role"));  //수사관 역활 존재여부 true / false
	request.setAttribute("TRNSR_ROLE_YN",  EnviewSSOManager.getUserInfo(request).getHasRole("TRNSR_role"));  //송치관 역활 존재여부 true / false
	request.setAttribute("HR_ROLE_YN",  EnviewSSOManager.getUserInfo(request).getHasRole("HR_role"));  //인사 역활 존재여부 true / false
	request.setAttribute("CENT_ROLE_YN",  EnviewSSOManager.getUserInfo(request).getHasRole("CENT_role"));  //팀장 역활 존재여부 true / false
	request.setAttribute("TIMHDER_ROLE_YN",  EnviewSSOManager.getUserInfo(request).getHasRole("TIMHDER_role"));  //팀장 역활 존재여부 true / false
	request.setAttribute("DRHF_ROLE_YN",  EnviewSSOManager.getUserInfo(request).getHasRole("DRHF_role"));  //과장 역활 존재여부 true / false
	request.setAttribute("HEADER_ROLE_YN",  EnviewSSOManager.getUserInfo(request).getHasRole("HEADER_role"));  //단장 역활 존재여부 true / false
	request.setAttribute("ROLE_MNG_RSRC_YN",  EnviewSSOManager.getUserInfo(request).getHasRole("ROLE_MNG_RSRC"));  //자원예약관리자 역활 존재여부 true / false
	request.setAttribute("DGT_FRS_ROLE_YN",  EnviewSSOManager.getUserInfo(request).getHasRole("DGT_FRS_role"));  //디지털 포렌식 운영자 역활 존재여부 true / false
	request.setAttribute("ROLE_MNG_BK_YN",  EnviewSSOManager.getUserInfo(request).getHasRole("ROLE_MNG_BK"));  //범죄수사자료조회담당 역활 존재여부 true / false
	
	request.setAttribute("GNLAFF_ROLE_YN", EnviewSSOManager.getUserInfo(request).getHasRole("GNLAFF_role"));  //서무담당자 역활 존재여부 true / false
	request.setAttribute("MAST_ROLE_YN", EnviewSSOManager.getUserInfo(request).getHasRole("MAST_role"));  //총 관리자 역활 존재여부 true / false
	request.setAttribute("SUB_DRHF_ROLE", EnviewSSOManager.getUserInfo(request).getHasRole("SUB_DRHF_role"));  //과장대직 역활 존재여부 true / false
	request.setAttribute("DEPT_ROLE", EnviewSSOManager.getUserInfo(request).getHasRole("DEPT_role"));  //부서장역활 존재여부 true / false
	request.setAttribute("SUB_DEPT_ROLE", EnviewSSOManager.getUserInfo(request).getHasRole("SUB_DEPT_role"));  //부서장대직역활 존재여부 true / false
	
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>수사지원시스템</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/Z/dhtmlx/suite/dhtmlx.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/Z/dhtmlx/suite/thirdparty/excanvas/excanvas.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/QCELL/css/qcell.css" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/QCELL/qcell.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/Z/common.js?r=<%=Math.random()%>"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/css/contents.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/css/board.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/js/Z/dhtmlx/suite/dhtmlx.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/Z/main.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/Z/webtoolkit.base64.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/dhtmlx/vault/dhtmlxvault.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/Z/sjpb_fileUpload.js"></script>
<script type="text/javascript" src="${cPath }/board/smarteditor/js/HuskyEZCreator.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/Z/loading/js/HoldOn.js"></script>
<link  rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/js/Z/loading/css/HoldOn.css">
<link rel="stylesheet" type="text/css" href="/dhtmlx/vault/dhtmlxvault.css" />

<script>
	
	//민사경 역할 상수
	const INVIGTOR_role = "INVIGTOR_role"; //수사관 역할
	const TRNSR_role = "TRNSR_role";  //송치관역할
	const HR_role = "HR_role";  //인사담당자 역할
	const TIMHDER_role = "TIMHDER_role";  //팀장 역할
	const DRHF_role = "DRHF_role";  //과장 역할
	const HEADER_role = "HEADER_role";  //단장역할
	const ROLE_MNG_RSRC = "ROLE_MNG_RSRC"; //자원예약관리자 역할
	const DGT_FRS_role = "DGT_FRS_role";  //디지털포렌식 관리자 역할
	const ROLE_MNG_BK = "ROLE_MNG_BK"; // 범죄수사자료조회담당 역할
	const GNLAFF_ROLE = "GNLAFF_ROLE_YN"; // 서무담당자 역할
	const MAST_ROLE = "MAST_ROLE_YN"; // 총 관리자 역할
	const SUB_DRHF_ROLE = "SUB_DRHF_role"; // 과장대직 역할
	const DEPT_ROLE = "DEPT_role"; // 부서장 역할
	const SUB_DEPT_ROLE = "SUB_DEPT_role"; // 부서장대직 역할
	
	const CENT_role = "CENT_role"; // 부서장대직 역할
	
	//민사경 역할 관리
	var SJPBRole = {			
			
		_roles : null,
		_INVIGTOR_ROLE_YN : ${INVIGTOR_ROLE_YN},
		_TRNSR_ROLE_YN : ${TRNSR_ROLE_YN},
		_HR_ROLE_YN : ${HR_ROLE_YN},
		_TIMHDER_ROLE_YN : ${TIMHDER_ROLE_YN},
		_DRHF_ROLE_YN : ${DRHF_ROLE_YN},
		_HEADER_ROLE_YN : ${HEADER_ROLE_YN},
		_DGT_FRS_ROLE_YN : ${DGT_FRS_ROLE_YN},
		_ROLE_MNG_BK_YN : ${ROLE_MNG_BK_YN},
		_ROLE_MNG_RSRC_YN : ${ROLE_MNG_RSRC_YN},
		_ROLE_GNLAFF_ROLE_YN : ${GNLAFF_ROLE_YN},
		_ROLE_MAST_ROLE_YN : ${MAST_ROLE_YN},
		_SUB_DRHF_ROLE_YN : ${SUB_DRHF_ROLE},
		_DEPT_ROLE_YN : ${DEPT_ROLE},
		_SUB_DEPT_ROLE_YN : ${SUB_DEPT_ROLE},
		_CENT_ROLE_YN : ${CENT_ROLE_YN},
		
		//수사관 역할 소유 여부 (true/false)
		//SJPBRole.getInvigtorRoleYn()
		getInvigtorRoleYn : function(){
			return this._INVIGTOR_ROLE_YN;
		},
		
		//송치관 역할 소유 여부 (true/false)
		//SJPBRole.getTrnsrRoleYn()
		getTrnsrRoleYn : function(){
			return this._TRNSR_ROLE_YN;
		},
		
		//인사담당자 역할 소유 여부 (true/false)
		//SJPBRole.getHrRoleYn()
		getHrRoleYn : function(){
			return this._HR_ROLE_YN;
		},
		
		//인사담당자 역할 소유 여부 (true/false)
		//SJPBRole.getHrRoleYn()
		getCentRoleYn : function(){
			return this._CENT_ROLE_YN;
		},
		
		//팀장 역할 소유 여부 (true/false)
		//SJPBRole.getTimhderRoleYn()
		getTimhderRoleYn : function(){
			return this._TIMHDER_ROLE_YN;
		},
		
		//과장 역할 소유 여부 (true/false)
		//SJPBRole.getDrhfRoleYn()
		getDrhfRoleYn : function(){
			return this._DRHF_ROLE_YN;
		},
		
		//단장 역할 소유 여부 (true/false)
		//SJPBRole.getHeaderRoleYn()
		getHeaderRoleYn : function(){
			return this._HEADER_ROLE_YN;
		},
		
		//자원예약관리자 역할 소유 여부 (true/false)
		//SJPBRole.getRoleMngRsrcYn()
		getRoleMngRsrcYn : function(){
			return this._ROLE_MNG_RSRC_YN;
		},
		
		//디지털 포렌식 운영자 역할 소유 여부 (true/false)
		//SJPBRole.getDgtFrsRoleYn()
		getDgtFrsRoleYn : function(){
			return this._DGT_FRS_ROLE_YN;
		},
		
		//범죄수사자료조회담당역할 소유 여부 (true/false)
		//SJPBRole.getRoleMngBkYn()
		getRoleMngBkYn : function(){
			return this._ROLE_MNG_BK_YN;
		},
		
		//서무담당자역할 소유 여부 (true/false)
		//SJPBRole.getRoleGnlaffYn()
		getRoleGnlaffYn : function(){
			return this._ROLE_GNLAFF_ROLE_YN;
		},
		
		//총 관리자 소유 여부 (true/false)
		//SJPBRole.getRoleMastYn()
		getRoleMastYn : function(){
			return this._ROLE_MAST_ROLE_YN;
		},
		
		//과장대직 소유 여부 (true/false)
		//SJPBRole.getSubDrhfYn()
		getSubDrhfYn : function(){
			return this._SUB_DRHF_ROLE_YN;
		},
		
		//부서장 소유 여부 (true/false)
		//SJPBRole.getDeptYn()
		getDeptRoleYn : function(){
			return this._DEPT_ROLE_YN;
		},
		
		//부서장대직 소유 여부 (true/false)
		//SJPBRole.getSubDeptYn()
		getSubDeptRoleYn : function(){
			return this._SUB_DEPT_ROLE_YN;
		},

		//역할 소유여부 확인
		//SJPBRole.getHasRole(INVIGTOR_role)
		getHasRole : function(pRole) {
			return $.inArray(pRole, this._roles) > 0 ? true : false;
		},
		
		//주어진 역할중에 포함된 것이 있는지 확인
		//SJPBRole.getHasAnyRole("INVIGTOR_role:TRNSR_role:HR_role")
		getHasAnyRole : function(pRoleList) {
			
			var result = false;			
			if (pRoleList.indexOf(":") > -1) {
				var roleList = pRoleList.split(":");
				for (i=0; i < roleList.length; i++) {
					if (this.getHasRole(roleList[i])) {
						result = true;					
						break;
					}
				}
			} else {
				result = this.getHasRole(pRoleList);
			}
			
			return result;
			
		},
		
		//역할 초기화
		init : function() {
			
			var roles = [];		
			<c:forEach items="${roles}" var="role" varStatus="status">		
				roles.push("${role}");
			</c:forEach>	
			this._roles = roles;
			
		},			
	}		
	SJPBRole.init();
	var sjpbFile = new SjpbEditManager();
	
	
</script>
<style>			
	#iframeContainer {width:80%; height: 30%; top: 200px; left:50%; display: none; position: fixed; transform: translate(-50%); background:#FFF; border: 1px solid #666;border: 1px solid #555;box-shadow: 2px 2px 40px #222;z-index: 999999;}
	#iframeContainer iframe {display:none; width: 100%; height: 100%; position: absolute; border: none; }
	
	#iframeLoader {background-repeat:no-repeat;  width: 250px; height: 250px; margin:auto;}			
	#iframeBlock {background: #000; opacity:0.6;  position: fixed; width: 100%; height: 100%; top:0; left:0; display:none;z-index: 999998;}
	
	#ajaxSpinnerContainer {background: #000; opacity:0.6;  position: fixed; width: 100%; height: 100%; top:0; left:0; display:block;z-index: 999998;}
	#ajaxSpinnerContainerCenter {width:100%; height: 100%; top: 50%; left:50%;  position: fixed;  }
​
</style> 	
			
</head>

<tiles:insertAttribute name="content" />

<div id="iframeBlock"></div>
<div id="iframeContainer" class="popup">		    
    <div id="iframeLoader"></div>
    <iframe title="blank"></iframe>
</div>  		  		
 		  		
 </html>