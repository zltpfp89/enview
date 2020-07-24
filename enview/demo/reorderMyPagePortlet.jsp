<%@page import="org.springframework.transaction.TransactionStatus"%>
<%@page import="org.springframework.transaction.support.DefaultTransactionDefinition"%>
<%@page import="com.ibatis.sqlmap.engine.transaction.TransactionState"%>
<%@page import="org.springframework.transaction.jta.JtaTransactionManager"%>
<%@page import="org.springframework.transaction.PlatformTransactionManager"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.sun.org.apache.xalan.internal.xsltc.runtime.Hashtable"%>
<%@page import="com.saltware.enview.page.PageManager"%>
<%@page import="com.saltware.enview.Enview"%>
<%@page import="com.saltware.enview.components.SpringComponentManager"%>
<%@page import="com.saltware.enview.components.ComponentManager"%>
<%@page import="org.springframework.jdbc.core.JdbcTemplate"%>
<%@page contentType="text/html; charset=UTF-8" import="java.sql.*,javax.sql.*,javax.naming.*,java.io.*"%><%
	String pagePath = (String)request.getParameter("page_path");
	String fragementIds = (String)request.getParameter("fragment_ids");
	String parentId = (String)request.getParameter("parent_id");
	String layoutColumn = (String)request.getParameter("layout_column");
	
	try {
		JdbcTemplate jdbcTemplate = (JdbcTemplate)Enview.getComponentManager().getComponent("jdbcTemplate");
		
		String updateSql = "UPDATE FRAGMENT SET PARENT_ID = ?, LAYOUT_ROW = ?, LAYOUT_COLUMN = ? WHERE FRAGMENT_ID=?";
		String[] fragmentIdArray = fragementIds.split(",");
		System.out.println( "REORDER PORTLET");
		for( int row = 0; row < fragmentIdArray.length; row++) {
			
			System.out.println( "PARENT_ID=" + parentId + ", ROW=" + row + ", COL=" + layoutColumn + ", PORTLET=" + fragmentIdArray[row]);
			jdbcTemplate.update( updateSql, new String[] { parentId, row+"", layoutColumn, fragmentIdArray[row]});
		}
		
		// SYNC PAGE
		PageManager pageManager = (PageManager)Enview.getComponentManager().getComponent("com.saltware.enview.page.PageManager");
		Map param = new HashMap();
		param.put( "method", "update");
		param.put( "path", pagePath);
		pageManager.syncCache(param);
		out.println( "{ \"result\": \"true\"}");
	} catch (Exception e) {
		out.println( "{ \"result\": \"false\", \"error\" : \"" + e.getMessage() + "\"}");
	}
%>