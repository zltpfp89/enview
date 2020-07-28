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
	
	Connection conn = null;
	PreparedStatement selectStmt = null;
	ResultSet rs = null;
	int totalCount = 0;
	StringBuffer queryBuffer = new StringBuffer();
	
	try {
		Context ctx = new InitialContext();
		try {
			out.println("jdbc/enview");
			DataSource ds = (DataSource)ctx.lookup("jdbc/enview");                
			conn = ds.getConnection();
		}
		catch(NameNotFoundException nnfe) {
			try {
				out.println("java:/comp/env/jdbc/enview");
				DataSource ds = (DataSource)ctx.lookup("java:/comp/env/jdbc/enview");                
//				DataSource ds = (DataSource)ctx.lookup("java:jboss/jdbc/enview");                
				conn = ds.getConnection();
			}
			catch(NameNotFoundException nnfe2) {
				out.println("java:/comp/env -> jdbc/enview");
				
				Context envContext  = (Context)ctx.lookup("java:/comp/env");
				DataSource ds = (DataSource)envContext.lookup("jdbc/enview");                
				conn = ds.getConnection();
			}
		}
			
		queryBuffer.append( "Select * from security_principal" );

		selectStmt = conn.prepareStatement( queryBuffer.toString() );
		rs = selectStmt.executeQuery();
		int count = 0;
		while( rs.next() ) {
			out.println("############################### " + rs.getString(1) + "," + rs.getString(2));
			if( count++ > 10 ) {
				break;
			}
		}
	}
	finally
	{
		try
		{
			if (null != selectStmt) selectStmt.close();
			if (null != rs) rs.close();
		} catch (Exception e)
		{
		}
	}
%>
</pre>