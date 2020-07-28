<%@page import="org.apache.poi.ss.usermodel.RichTextString"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@ page contentType="application/vnd.ms-excel;charset=UTF-8" %> 
<%@ page buffer = "1024kb" %>
<%@ page language="java"   isThreadSafe="false" %>

<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@ page import="org.apache.poi.ss.usermodel.Cell"%>
<%@ page import="org.apache.poi.ss.usermodel.Row"%>
<%@ page import="org.apache.poi.ss.usermodel.Sheet"%>
<%@ page import="org.apache.poi.ss.usermodel.Workbook"%>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>

<%@ page import="com.saltware.enview.admin.page.service.PageVO" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%
	List results = (List)request.getAttribute("results");
	Workbook wb    = null;
	Sheet    sheet = null;
	Row      row   = null;
	Cell     cell  = null;
	String 	 excelName = null;
	
	wb = new XSSFWorkbook();

	// 기초 데이터 준비
	String[] fldNms   = {"domainId", "pageId","parentId","path","name","title","url"};
	String[] fldTtls  = {"도메인ID","페이지ID","상위페이지ID","경로","페이지이름","제목","URL"};

	// 엑셀 시트 생성
	sheet = wb.createSheet("페이지");
	excelName = "Page.xlsx";
	
	int rnum = 0;
	int cnum = 0;
	// 타이틀 행 생성
	row = sheet.createRow (rnum++);
	for (int i=0; i<fldTtls.length; i++) {
		cell = row.createCell (cnum++);
		cell.setCellValue (fldTtls[i]);
	}

	if( results != null ) {
		// 페이지 목록에 대해 루프를 돌면서 행 생성
		for(int i=0; i<results.size(); i++) {
			
			PageVO pageVO = (PageVO)results.get(i);
			row = sheet.createRow (rnum++);
			cnum = 0;
			
			Class[]  clazz    = {};
			Object[] objec    = {};
			String   nmMethod = null;

			for (int j=0; j<fldTtls.length; j++) {
				nmMethod = "get" + fldNms[j].substring(0,1).toUpperCase() + fldNms[j].substring(1);
				//System.out.println("###### nmMethod=" + nmMethod + ", pageVO=" + pageVO);
				cell = row.createCell (cnum++);
				Object value = pageVO.getClass().getDeclaredMethod (nmMethod, clazz).invoke (pageVO, objec);
				if(value == null){
					value = "";
				}
				if(value instanceof Boolean){
					cell.setCellValue ((Boolean)value);
				} else if(value instanceof Calendar){
					cell.setCellValue ((Calendar)value);
				} else if(value instanceof Date){
					cell.setCellValue ((Date)value);
				} else if(value instanceof Number){
					cell.setCellValue ((Integer)value);
				} else if(value instanceof RichTextString){
					cell.setCellValue ((RichTextString)value);
				} else if(value instanceof String){
					cell.setCellValue ((String)value);
				} else {
					cell.setCellValue (value.toString());
				}
				
			}
		}
		
		// 해당 워크시트를 내려보냄.
		String strClient = request.getHeader("user-agent");
		if (strClient.indexOf("MSIE 5.5") != -1) {
			System.out.println("###### MSIE 5.5");
			response.setHeader("Content-Type", "doesn/matter;");
			response.setHeader("Content-Disposition", "inline; filename="+ excelName +";");
		} else {
			// 파일이 다운로드 되면서 바로 열리도록 한다.
			System.out.println("###### application/octet-stream");
			//response.setHeader("Content-Type", "application/octet-stream;");
			response.setHeader("Content-Type", "application/vnd.ms-excel; charset=UTF-8");
			response.setHeader("Content-Disposition", "attachment; filename="+ excelName +";");
		}
		response.setHeader("Content-Transfer-Encoding", "binary;");
		try {
			out.clear();
			out = pageContext.pushBody(); 

			ServletOutputStream sos = response.getOutputStream();
			wb.write (sos);
			sos.flush();
			sos.close();
		} catch (Exception e) {
			throw e;
		}
	}
%>

