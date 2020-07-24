<%@page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@page import="com.saltware.enview.multiresource.EnviewMultiResourceManager"%>
<%@page import="com.saltware.enview.multiresource.MultiResourceBundle"%>
<%@page import="com.saltware.enview.admin.statistics.web.UserStatisticsForm"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFCellStyle"%>
<%@page import="org.apache.poi.hssf.util.HSSFColor"%>
<%@page import="org.apache.poi.ss.usermodel.CellStyle"%>
<%@ page contentType="application/vnd.ms-excel;charset=UTF-8" %> 
<%@ page buffer = "1024kb" %>
<%@ page language="java"   isThreadSafe="false" %>

<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@ page import="org.apache.poi.ss.usermodel.Cell"%>
<%@ page import="org.apache.poi.ss.usermodel.Row"%>
<%@ page import="org.apache.poi.ss.usermodel.Sheet"%>
<%@ page import="org.apache.poi.ss.usermodel.Workbook"%>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>

<%@ page import="com.saltware.enview.admin.statistics.service.UserStatisticsVO"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%
	UserStatisticsForm formData = (UserStatisticsForm)request.getAttribute("inform");
	List results = (List)request.getAttribute("results");
	Workbook wb    = null;
	Sheet    sheet = null;
	Row      row   = null;
	Cell     cell  = null;
	String 	 excelName = null;
	CellStyle cellStyleTit = null;
	CellStyle cellStyle = null;
	
	String langKnd = EnviewSSOManager.getLangKnd(request);
	MultiResourceBundle enviewMessages = EnviewMultiResourceManager.getInstance().getBundle( langKnd );
	
	wb = new XSSFWorkbook();

	// 기초 데이터 준비
	//String[] fldNms   = {"accessBrowser","userIp","domainNm","orgName","roleName","userId","userName","statusStr","timeStampByFormat"};
	//String[] fldTtls  = {"브라우저","사용자IP","도메인명","부서","역할","사용자ID","사용자이름","상태","생성일시"};
	String[] fldNms   = {"domainNm","userId","userName","orgName","roleName","userIp","statusStr","accessBrowser","timeStampByFormat"};
	//String[] fldTtls  = {"도메인명","사용자ID","사용자이름","부서","역할","사용자IP","상태","브라우저","생성일시"};
	String[] fldTtls  = {
		enviewMessages.getString("ev.prop.domain.domain"),
		enviewMessages.getString("ev.title.statistics.userId"),
		enviewMessages.getString("ev.title.statistics.userName"),
		enviewMessages.getString("ev.prop.userStatistics.orgName"),
		enviewMessages.getString("ev.prop.userStatistics.roleName"),
		enviewMessages.getString("ev.prop.userStatistics.userIp"),
		enviewMessages.getString("ev.prop.userStatistics.status"),
		enviewMessages.getString("ev.prop.userStatistics.accessBrowser"),
		enviewMessages.getString("ev.prop.userStatistics.timeStamp"),
	};
	
	
	int[]	 fldSzs	  = {3000, 4000, 4000, 4000, 4000, 4000, 4000, 4000, 7000};
	
	// 엑셀 시트 생성
	sheet = wb.createSheet("User Logs");
	
	//제목
	cellStyleTit = wb.createCellStyle();
	cellStyleTit.setAlignment(CellStyle.ALIGN_CENTER);
    cellStyleTit.setBorderBottom(CellStyle.BORDER_THIN); //색상변경등 다양한 API를 제공하고 있다.
    cellStyleTit.setBorderLeft(CellStyle.BORDER_THIN);
    cellStyleTit.setBorderRight(CellStyle.BORDER_THIN);
    cellStyleTit.setBorderTop(CellStyle.BORDER_THIN);
	cellStyleTit.setVerticalAlignment (CellStyle.VERTICAL_CENTER);
	cellStyleTit.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
	cellStyleTit.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
	
	//내용
	cellStyle = wb.createCellStyle();
	cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
    cellStyle.setBorderBottom(CellStyle.BORDER_THIN); //색상변경등 다양한 API를 제공하고 있다.
    cellStyle.setBorderLeft(CellStyle.BORDER_THIN);
    cellStyle.setBorderRight(CellStyle.BORDER_THIN);
    cellStyle.setBorderTop(CellStyle.BORDER_THIN);
	cellStyle.setVerticalAlignment (CellStyle.VERTICAL_CENTER);
	
	excelName = "UserStatistics.xlsx";
	
	int rnum = 0;
	int cnum = 0;
	
	row = sheet.createRow (rnum++);
	cell = row.createCell (0);
	cell.setCellValue (enviewMessages.getString("ev.prop.domain.domain") ); //도메인명
	cell.setCellStyle(cellStyleTit);
	sheet.setColumnWidth(0, 4000);
	
	cell = row.createCell (1);
	cell.setCellValue (enviewMessages.getString("domainNm"));
	cell.setCellStyle(cellStyle);
	sheet.setColumnWidth(1, 4000);
	
	cell = row.createCell (2);
	cell.setCellValue (enviewMessages.getString("ev.title.statistics.groupId")); // 그룹ID
	
	cell.setCellStyle(cellStyleTit);
	sheet.setColumnWidth(2, 4000);
	
	cell = row.createCell (3);
	cell.setCellValue (formData.getGroupIdCond2());
	cell.setCellStyle(cellStyle);
	sheet.setColumnWidth(3, 4000);
	
	cell = row.createCell (4);
	cell.setCellValue (enviewMessages.getString("ev.prop.securityUserRole.roleId")); // 역할ID
	cell.setCellStyle(cellStyleTit);
	sheet.setColumnWidth(4, 4000);
	
	cell = row.createCell (5);
	cell.setCellValue (formData.getRoleIdCond2());
	cell.setCellStyle(cellStyle);
	sheet.setColumnWidth(5, 4000);
	
	cell = row.createCell (6);
	cell.setCellValue ( enviewMessages.getString("ev.title.statistics.userId")); // "사용자ID";
	cell.setCellStyle(cellStyleTit);
	sheet.setColumnWidth(6, 4000);
	
	cell = row.createCell (7);
	cell.setCellValue (formData.getUserIdCond());
	cell.setCellStyle(cellStyle);
	sheet.setColumnWidth(7, 4000);
	
	cell = row.createCell (8);
	cell.setCellValue (  enviewMessages.getString("ev.title.statistics.userName"));
	cell.setCellStyle(cellStyleTit);
	sheet.setColumnWidth(8, 4000);
	
	cell = row.createCell (9);
	cell.setCellValue (formData.getUserNameCond());
	cell.setCellStyle(cellStyle);
	sheet.setColumnWidth(9, 4000);
	
	cell = row.createCell (10);
	cell.setCellValue ( enviewMessages.getString("ev.prop.userStatistics.userIp")); // 사용자IP
	cell.setCellStyle(cellStyleTit);
	sheet.setColumnWidth(10, 4000);
	
	cell = row.createCell (11);
	cell.setCellValue (formData.getUserIpCond());
	cell.setCellStyle(cellStyle);
	sheet.setColumnWidth(11, 4000);
	
	cell = row.createCell (12);
	cell.setCellValue ( enviewMessages.getString("ev.prop.userStatistics.status")); // 상태
	cell.setCellStyle(cellStyleTit);
	sheet.setColumnWidth(12, 4000);
	
	cell = row.createCell (13);
	cell.setCellValue ((String)request.getAttribute("statusCondNm"));
	cell.setCellStyle(cellStyle);
	sheet.setColumnWidth(13, 4000);
	
	cell = row.createCell (14);
	cell.setCellValue ("조회시작일자");
	cell.setCellStyle(cellStyleTit);
	sheet.setColumnWidth(14, 4000);
	
	cell = row.createCell (15);
	cell.setCellValue (formData.getStartTimeStampCond());
	cell.setCellStyle(cellStyle);
	sheet.setColumnWidth(15, 4000);
	
	cell = row.createCell (16);
	cell.setCellValue ("조회종료일자");
	cell.setCellStyle(cellStyleTit);
	sheet.setColumnWidth(16, 4000);
	
	cell = row.createCell (17);
	cell.setCellValue (formData.getEndTimeStampCond());
	cell.setCellStyle(cellStyle);
	sheet.setColumnWidth(17, 4000);	
	
	//빈 라인 추가
	row = sheet.createRow (rnum++);
	
	// 타이틀 행 생성
	row = sheet.createRow (rnum++);
	for (int i=0; i<fldTtls.length; i++) {
		cell = row.createCell (cnum++);
		cell.setCellValue (fldTtls[i]);
		cell.setCellStyle(cellStyleTit);
		
		sheet.setColumnWidth(i, fldSzs[i]);
	}

	if( results != null ) {
		// 페이지 목록에 대해 루프를 돌면서 행 생성
		for(int i=0; i<results.size(); i++) {
			
			UserStatisticsVO userStatisticsVO = (UserStatisticsVO)results.get(i);
			row = sheet.createRow (rnum++);
			cnum = 0;
			
			Class[]  clazz    = {};
			Object[] objec    = {};
			String   nmMethod = null;

			for (int j=0; j<fldTtls.length; j++) {
				nmMethod = "get" + fldNms[j].substring(0,1).toUpperCase() + fldNms[j].substring(1);
				cell = row.createCell (cnum++);
				cell.setCellValue (""+userStatisticsVO.getClass().getDeclaredMethod (nmMethod, clazz).invoke (userStatisticsVO, objec));
				cell.setCellStyle(cellStyle);
			}
		}
		
		// 해당 워크시트를 내려보냄.
		String strClient = request.getHeader("user-agent");
		if (strClient.indexOf("MSIE 5.5") != -1) {
			response.setHeader("Content-Type", "doesn/matter;");
			response.setHeader("Content-Disposition", "filename="+ excelName +";");
		} else {
			// 파일이 다운로드 되면서 바로 열리도록 한다.
			response.setHeader("Content-Type", "application/octet-stream;");
			response.setHeader("Content-Disposition", "attachment; filename="+ excelName +";");
		}
		response.setHeader("Content-Transfer-Encoding", "binary;");
		ServletOutputStream sos = null;
		try {
			out.clear();
			out=pageContext.pushBody();
			sos = response.getOutputStream();
			wb.write (sos);
		} catch (Exception e) {
			throw e;
		} finally {
			if(sos != null) sos.flush();
			if(sos != null) sos.close();			
		}
	}
	
%>

