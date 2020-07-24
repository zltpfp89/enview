<%@page import="com.saltware.enview.multiresource.EnviewMultiResourceManager"%>
<%@page import="com.saltware.enview.multiresource.MultiResourceBundle"%>
<%@page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFCellStyle"%>
<%@page import="org.apache.poi.ss.usermodel.CellStyle"%>
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

<%@ page import="com.saltware.enview.admin.user.service.UserpassVO" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%

	String langKnd = EnviewSSOManager.getLangKnd(request);
	MultiResourceBundle mr = EnviewMultiResourceManager.getInstance().getBundle( langKnd );


	List results = (List)request.getAttribute("results");
	Workbook wb    = null;
	Sheet    sheet = null;
	Row      row   = null;
	Cell     cell  = null;
	String 	 excelName = null;
	CellStyle cellStyle = null;
	wb = new XSSFWorkbook();

	// 기초 데이터 준비
	String[] fldNms   = {"userId","nmKor","emailAddr","homeTel","homeZip","homeAddr1","homeAddr2","birthYmdSF"};
	String[] fldTtls  = { 
			mr.getString( "ev.prop.userpass.userId")
			, mr.getString( "ev.prop.userpass.nmKor")
			, mr.getString( "ev.prop.mail")
			, mr.getString( "ev.prop.userpass.homeTel")
			, mr.getString( "ev.prop.userpass.homeZip")
			, mr.getString( "ev.prop.userpass.homeAddr1")
			, mr.getString( "ev.prop.userpass.homeAddr2")
			, mr.getString( "ev.prop.userpass.birthYmd")
		};
	int[]	 fldSzs	  = {3000, 4000, 7000, 4000, 3000, 8000, 8000, 3000};

	// 엑셀 시트 생성
	sheet = wb.createSheet("사용자");
	cellStyle = wb.createCellStyle();
	cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
    cellStyle.setBorderBottom(CellStyle.BORDER_THIN); //색상변경등 다양한 API를 제공하고 있다.
    cellStyle.setBorderLeft(CellStyle.BORDER_THIN);
    cellStyle.setBorderRight(CellStyle.BORDER_THIN);
    cellStyle.setBorderTop(CellStyle.BORDER_THIN);
	cellStyle.setVerticalAlignment (CellStyle.VERTICAL_CENTER);

	excelName = "User.xlsx";
	
	int rnum = 0;
	int cnum = 0;
	//도메인 로우
	row = sheet.createRow(rnum++);
	//도메인 컬럼
	cell = row.createCell(0);
	cell.setCellValue(mr.getString( "ev.prop.domain.domain")); // 도메인 
	
	cell.setCellStyle(cellStyle);
	//도메인 명
	cell = row.createCell(1);
	cell.setCellValue((String)request.getAttribute("domainNm"));
	cell.setCellStyle(cellStyle);
	
	//사용자 로우
	row = sheet.createRow(rnum++);
	//사용자 수 컬럼
	cell = row.createCell(0);
	cell.setCellValue(mr.getString( "hn.note.label.user")); // 사용자
	cell.setCellStyle(cellStyle);
	//사용자 수
	cell = row.createCell(1);
	cell.setCellValue(((List)request.getAttribute("results")).size());
	cell.setCellStyle(cellStyle);
	//한 줄 건너 뜀 로우
	row = sheet.createRow(rnum++);
	
	//타이틀 로우 생성	
	row = sheet.createRow(rnum++);
	for (int i=0; i<fldTtls.length; i++) {
		cell = row.createCell (cnum++);
		cell.setCellValue (fldTtls[i]);
		cell.setCellStyle(cellStyle);
		sheet.setColumnWidth(i, fldSzs[i]);
	}

	if( results != null ) {
		// 사용자 목록에 대해 루프를 돌면서 행 생성
		for(int i=0; i<results.size(); i++) {
			
			UserpassVO userpassVO = (UserpassVO)results.get(i);
			row = sheet.createRow (rnum++);
			cnum = 0;
			
			Class[]  clazz    = {};
			Object[] objec    = {};
			String   nmMethod = null;

			for (int j=0; j<fldTtls.length; j++) {
				nmMethod = "get" + fldNms[j].substring(0,1).toUpperCase() + fldNms[j].substring(1);
				//System.out.println("###### nmMethod=" + nmMethod + ", userpassVO=" + userpassVO);
				cell = row.createCell (cnum++);
				Object value = userpassVO.getClass().getDeclaredMethod (nmMethod, clazz).invoke (userpassVO, objec);
				if(value == null){
					value = "";
				}
				cell.setCellValue (value.toString());
				cell.setCellStyle(cellStyle);
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

