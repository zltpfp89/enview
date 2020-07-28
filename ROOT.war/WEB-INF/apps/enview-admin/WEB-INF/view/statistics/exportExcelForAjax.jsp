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

<%@ page import="com.saltware.enview.admin.statistics.service.PageStatisticsVO"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%
	Map searchCondition = (Map)request.getAttribute("searchCondition");
	Map accumulationMap = (Map)request.getAttribute("accumulationMap");
	List results = (List)request.getAttribute("results");
	
	Workbook wb    = null;
	Sheet    sheet = null;
	Row      row   = null;
	Cell     cell  = null;
	String 	 excelName = null;
	CellStyle cellStyleTit = null;
	CellStyle cellStyle = null;
	
	wb = new XSSFWorkbook();

	// 기초 데이터 준비
	String[] fldNms   = {"domainNm","title","path","hits","maxTime","minTime","averageTime"};
	String[] fldTtls  = {"도메인","제목","경로","사용건수","최대소요시간","최소소요시간","평균소요시간"};

	// 엑셀 시트 생성
	sheet = wb.createSheet("페이지 사용통계");
	
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
	
	excelName = "PageStatistics.xlsx";
	
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
	cell.setCellValue (searchCondition.get("groupIdCond2") == null ? "" : searchCondition.get("groupIdCond2").toString());
	cell.setCellStyle(cellStyle);
	sheet.setColumnWidth(3, 4000);
	
	cell = row.createCell (4);
	cell.setCellValue ("역할ID");
	cell.setCellStyle(cellStyleTit);
	sheet.setColumnWidth(4, 4000);
	
	cell = row.createCell (5);
	cell.setCellValue (searchCondition.get("roleIdCond2") == null ? "" : searchCondition.get("roleIdCond2").toString());
	cell.setCellStyle(cellStyle);
	sheet.setColumnWidth(5, 4000);
	
	cell = row.createCell (6);
	cell.setCellValue ("사용자ID");
	cell.setCellStyle(cellStyleTit);
	sheet.setColumnWidth(6, 4000);
	
	cell = row.createCell (7);
	cell.setCellValue (searchCondition.get("userIdCond") == null ? "" : searchCondition.get("userIdCond").toString());
	cell.setCellStyle(cellStyle);
	sheet.setColumnWidth(7, 4000);
	
	cell = row.createCell (8);
	cell.setCellValue ("사용자이름");
	cell.setCellStyle(cellStyleTit);
	sheet.setColumnWidth(8, 4000);
	
	cell = row.createCell (9);
	cell.setCellValue (searchCondition.get("userNameCond") == null ? "" : searchCondition.get("userNameCond").toString());
	cell.setCellStyle(cellStyle);
	sheet.setColumnWidth(9, 4000);
	
	cell = row.createCell (10);
	cell.setCellValue ("제목");
	cell.setCellStyle(cellStyleTit);
	sheet.setColumnWidth(10, 4000);
	
	cell = row.createCell (11);
	cell.setCellValue (searchCondition.get("titleCond") == null ? "" : searchCondition.get("titleCond").toString());
	cell.setCellStyle(cellStyle);
	sheet.setColumnWidth(11, 4000);
	
	cell = row.createCell (12);
	cell.setCellValue ("경로");
	cell.setCellStyle(cellStyleTit);
	sheet.setColumnWidth(12, 4000);
	
	cell = row.createCell (13);
	cell.setCellValue (searchCondition.get("pathCond") == null ? "" : searchCondition.get("pathCond").toString());
	cell.setCellStyle(cellStyle);
	sheet.setColumnWidth(13, 4000);
	
	cell = row.createCell (14);
	cell.setCellValue ("조회시작일자");
	cell.setCellStyle(cellStyleTit);
	sheet.setColumnWidth(14, 4000);
	
	cell = row.createCell (15);
	cell.setCellValue (searchCondition.get("startTimeStampCond") == null ? "" : searchCondition.get("startTimeStampCond").toString());
	cell.setCellStyle(cellStyle);
	sheet.setColumnWidth(15, 4000);
	
	cell = row.createCell (16);
	cell.setCellValue ("조회종료일자");
	cell.setCellStyle(cellStyleTit);
	sheet.setColumnWidth(16, 4000);
	
	cell = row.createCell (17);
	cell.setCellValue (searchCondition.get("endTimeStampCond") == null ? "" : searchCondition.get("endTimeStampCond").toString());
	cell.setCellStyle(cellStyle);
	sheet.setColumnWidth(17, 4000);
	
	//빈 라인 추가
	row = sheet.createRow (rnum++);
	
	// 데이타 행
	row = sheet.createRow (rnum++);
	cell = row.createCell (0);
	cell.setCellValue ("전체 사용건수");
	cell.setCellStyle(cellStyleTit);
	
	cell = row.createCell (1);
	cell.setCellValue ( ((BigDecimal)accumulationMap.get("TOTALHITS")).toString() );
	cell.setCellStyle(cellStyle);
	
	cell = row.createCell (2);
	cell.setCellValue ("전체 최대소요시간");
	cell.setCellStyle(cellStyleTit);
	
	cell = row.createCell (3);
	cell.setCellValue ( String.valueOf(accumulationMap.get("TOTALMAXTIME")) );
	cell.setCellStyle(cellStyle);
	
	row = sheet.createRow (rnum++);
	cell = row.createCell (0);
	cell.setCellValue ("전체 최소소요시간");
	cell.setCellStyle(cellStyleTit);
	
	cell = row.createCell (1);
	cell.setCellValue ( String.valueOf(accumulationMap.get("TOTALMINTIME")) );
	cell.setCellStyle(cellStyle);
	
	cell = row.createCell (2);
	cell.setCellValue ("전체 평균소요시간");
	cell.setCellStyle(cellStyleTit);
	
	cell = row.createCell (3);
	cell.setCellValue ( String.valueOf(accumulationMap.get("TOTALAVERAGETIME")) );
	cell.setCellStyle(cellStyle);
	
	//빈 라인 추가
	row = sheet.createRow (rnum++);
	
	// 타이틀 행 생성
	row = sheet.createRow (rnum++);
	for (int i=0; i<fldTtls.length; i++) {
		cell = row.createCell (cnum++);
		cell.setCellValue (fldTtls[i]);
		cell.setCellStyle(cellStyleTit);
	}

	if( results != null ) {
		// 페이지 목록에 대해 루프를 돌면서 행 생성
		for(int i=0; i<results.size(); i++) {
			
			PageStatisticsVO pageStatisticsVO = (PageStatisticsVO)results.get(i);
			row = sheet.createRow (rnum++);
			cnum = 0;
			
			Class[]  clazz    = {};
			Object[] objec    = {};
			String   nmMethod = null;

			for (int j=0; j<fldTtls.length; j++) {
				nmMethod = "get" + fldNms[j].substring(0,1).toUpperCase() + fldNms[j].substring(1);
				cell = row.createCell (cnum++);
				cell.setCellValue (""+pageStatisticsVO.getClass().getDeclaredMethod (nmMethod, clazz).invoke (pageStatisticsVO, objec));
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

