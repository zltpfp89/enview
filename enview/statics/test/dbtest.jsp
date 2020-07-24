<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.NameNotFoundException"%>
<%@page import="javax.sql.DataSource"%>
<pre>
<%
	
	DataSource ds = null;                
	Connection conn = null;
	PreparedStatement selectStmt = null;
	ResultSet rs = null;
	int totalCount = 0;
	StringBuffer queryBuffer = new StringBuffer();
	try {
		Context ctx = new InitialContext();
		String dsNames[] = new String[] { "jdbc/enview", "java:/comp/env/jdbc/enview", "java:jboss/jdbc/enview"};
		for( int i=0; i < dsNames.length;i++) {
			out.print("Testing " + dsNames[i] + "...");
			out.flush();
			try {
				ds = (DataSource)ctx.lookup( dsNames[i]);                
				conn = ds.getConnection();
			} catch(NameNotFoundException nnfe) {
				out.println( "failed!");
				continue;
			}
			out.println( "success!");
			break;
		}
		if( conn ==null) {
			out.println( "Failed to get connection");
			return;
		}
		out.flush();
		out.println();
		queryBuffer.append( "Select * from userpass" );

		selectStmt = conn.prepareStatement( queryBuffer.toString() );
		rs = selectStmt.executeQuery();
		int count=0;
		while( rs.next() ) {
			out.println("# " + rs.getString(1) + "," + rs.getString(2));
			if( count++ > 10) break;
		}
	}finally	{
		if( rs!=null) {
			try {
				rs.close();
			} catch(Exception e) {
			}
		}
		if( selectStmt !=null) {
			try {
				selectStmt.close();
			} catch(Exception e) {
			}
		}
		if( conn!=null) {
			try {
				conn.close();
			} catch(Exception e) {
			}
		}
	}
%>
</pre>