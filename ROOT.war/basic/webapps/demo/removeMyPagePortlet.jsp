<%@page import="org.springframework.jdbc.datasource.DataSourceTransactionManager"%>
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
	String pageId = (String)request.getParameter("page_id");
	String pagePath = (String)request.getParameter("page_path");
	String fragementId = (String)request.getParameter("fragment_id");
	String parentId = (String)request.getParameter("parent_id");
	String layoutColumn = (String)request.getParameter("layout_column");
	
	try {
		JdbcTemplate jdbcTemplate = (JdbcTemplate)Enview.getComponentManager().getComponent("jdbcTemplate");
		
		// delete portlet
		System.out.println( "DELETE PORTLET");
		String deleteSql = "DELETE FROM FRAGMENT WHERE FRAGMENT_ID=? AND PARENT_ID=?";
		int count = jdbcTemplate.update( deleteSql, new String[] { fragementId, parentId});
		
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