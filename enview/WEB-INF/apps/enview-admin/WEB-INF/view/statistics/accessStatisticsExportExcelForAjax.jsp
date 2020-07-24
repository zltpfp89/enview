<%@page import="org.apache.poi.hssf.util.HSSFColor"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFCellStyle"%>
<%@page import="org.apache.poi.ss.usermodel.CellStyle"%>
<%@page import="com.saltware.enview.statistics.PortalStatistics"%>
<%@page import="com.saltware.enview.admin.statistics.web.AccessStatisticsForm"%>
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

<%@ page import="com.saltware.enview.admin.statistics.service.UserAccessVO"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%
	AccessStatisticsForm formData = (AccessStatisticsForm)request.getAttribute("inform");
	List results = (List)request.getAttribute("results");
	
	Workbook wb    = null;
	Sheet    sheet = null;
	Row      row   = null;
	Cell     cell  = null;
	String 	 excelName = null;
	CellStyle cellStyleTit = null;
	CellStyle cellStyle = null;
	
	wb = new XSSFWorkbook();
	
	String axisX = "";
	String axisXnm = "";
	
	String[] week = {"일요일","월요일","화요일","수요일","목요일","금요일","토요일"};
	
	switch( formData.getQueryType() ) {
		case PortalStatistics.QUERY_BY_TIME : 	    		/* 시간별 접속자수 */
			axisX = "time";
			axisXnm = "시간";	
			break;
		case PortalStatistics.QUERY_BY_DAY :				/* 일별 접속건수 */
			axisX = "day";
			axisXnm = "일";		
			break;
		case PortalStatistics.QUERY_BY_MONTH :				/* 월별 접속건수 */
			axisX = "month";
			axisXnm = "월";		
			break;
		case PortalStatistics.QUERY_BY_YEAR :				/* 년도별 접속건수 */
			axisX = "year";
			axisXnm = "년도";			
			break;
		case PortalStatistics.QUERY_BY_WEEK :				/* 주간별 접속건수  */
			
			axisX = "week";
			axisXnm = "요일";
			break;
	}
	
	String[] fldNms = {"name","value"};
	String[] fldTtls = {axisXnm,"횟수"};
	int[] fldSzs = {4000, 4000};
	
	// 엑셀 시트 생성
	sheet = wb.createSheet("사용자접속현황통계_" + axisXnm + "별 현황");

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
	
	excelName = "AccessStatistics_" + axisX + ".xlsx";
	
	int rnum = 0;
	int cnum = 0;

	row = sheet.createRow (rnum++);
	cell = row.createCell (0);
	cell.setCellValue ("도메인명");
	cell.setCellStyle(cellStyleTit);
	sheet.setColumnWidth(0, 4000);
	
	cell = row.createCell (1);
	cell.setCellValue ((String)request.getAttribute("domainNm"));
	cell.setCellStyle(cellStyle);
	sheet.setColumnWidth(1, 4000);
	
	cell = row.createCell (2);
	cell.setCellValue ("그룹ID");
	cell.setCellStyle(cellStyleTit);
	sheet.setColumnWidth(2, 4000);
	
	cell = row.createCell (3);
	cell.setCellValue (formData.getGroupIdCond2());
	cell.setCellStyle(cellStyle);
	sheet.setColumnWidth(3, 4000);
	
	cell = row.createCell (4);
	cell.setCellValue ("역할ID");
	cell.setCellStyle(cellStyleTit);
	sheet.setColumnWidth(4, 4000);
	
	cell = row.createCell (5);
	cell.setCellValue (formData.getRoleIdCond2());
	cell.setCellStyle(cellStyle);
	sheet.setColumnWidth(5, 4000);
	
	cell = row.createCell (6);
	cell.setCellValue ("사용자ID");
	cell.setCellStyle(cellStyleTit);
	sheet.setColumnWidth(6, 4000);
	
	cell = row.createCell (7);
	cell.setCellValue (formData.getUserIdCond());
	cell.setCellStyle(cellStyle);
	sheet.setColumnWidth(7, 4000);
	
	cell = row.createCell (8);
	cell.setCellValue ("사용자이름");
	cell.setCellStyle(cellStyleTit);
	sheet.setColumnWidth(8, 4000);
	
	cell = row.createCell (9);
	cell.setCellValue (formData.getUserNameCond());
	cell.setCellStyle(cellStyle);
	sheet.setColumnWidth(9, 4000);
	
	switch( formData.getQueryType() ) {
	case PortalStatistics.QUERY_BY_TIME : 	    		/* 시간별 접속자수 */
		cell = row.createCell (10);
		cell.setCellValue ("조회시작일자");
		cell.setCellStyle(cellStyleTit);
		sheet.setColumnWidth(10, 4000);
		
		cell = row.createCell (11);
		cell.setCellValue (formData.getStartTimeStampCond());
		cell.setCellStyle(cellStyle);
		sheet.setColumnWidth(11, 4000);
		
		cell = row.createCell (12);
		cell.setCellValue ("조회종료일자");
		cell.setCellStyle(cellStyleTit);
		sheet.setColumnWidth(12, 4000);
		
		cell = row.createCell (13);
		cell.setCellValue (formData.getEndTimeStampCond());
		cell.setCellStyle(cellStyle);
		sheet.setColumnWidth(13, 4000);
		
		break;
	case PortalStatistics.QUERY_BY_DAY :				/* 일별 접속건수 */
		cell = row.createCell (10);
		cell.setCellValue ("조회년월");
		cell.setCellStyle(cellStyleTit);
		sheet.setColumnWidth(10, 4000);
		
		cell = row.createCell (11);
		cell.setCellValue (formData.getSearchYear() + "/" + formData.getSearchMonth());
		cell.setCellStyle(cellStyle);
		sheet.setColumnWidth(11, 4000);
		
		break;
	case PortalStatistics.QUERY_BY_MONTH :				/* 월별 접속건수 */
		cell = row.createCell (10);
		cell.setCellValue ("조회년도");
		cell.setCellStyle(cellStyleTit);
		sheet.setColumnWidth(10, 4000);
		
		cell = row.createCell (11);
		cell.setCellValue (formData.getSearchYear());
		cell.setCellStyle(cellStyle);
		sheet.setColumnWidth(11, 4000);
		
		break;
	}

	
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
			
			UserAccessVO userAccessVO = (UserAccessVO)results.get(i);
			row = sheet.createRow (rnum++);
			cnum = 0;
			
			Class[]  clazz    = {};
			Object[] objec    = {};
			String   nmMethod = null;
			String 	 cellValue = null;
			
			for (int j=0; j<fldTtls.length; j++) {
				nmMethod = "get" + fldNms[j].substring(0,1).toUpperCase() + fldNms[j].substring(1);
				cell = row.createCell (cnum++);
				cellValue = ""+userAccessVO.getClass().getDeclaredMethod (nmMethod, clazz).invoke (userAccessVO, objec);
				
				if (j == 0) {
					switch( formData.getQueryType() ) {
						case PortalStatistics.QUERY_BY_TIME : 	    		/* 시간별 접속자수 */
						
							if(i<9) {
							   cellValue = "0"+(i)+"~"+"0"+(i+1);
							} else if (i==9) {
							   cellValue = "0"+(i)+"~"+(i+1);
							} else {
					        	cellValue = (i)+"~"+(i+1);
						    }
						
							break;
						case PortalStatistics.QUERY_BY_DAY :				/* 일별 접속건수 */
							break;
						case PortalStatistics.QUERY_BY_MONTH :				/* 월별 접속건수 */
							break;
						case PortalStatistics.QUERY_BY_YEAR :				/* 년도별 접속건수 */
							break;
						case PortalStatistics.QUERY_BY_WEEK :				/* 주간별 접속건수  */
							cellValue = week[Integer.parseInt(cellValue) - 1];
							break;
					}
				}

				cell.setCellValue (cellValue);
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

