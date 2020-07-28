<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.NameNotFoundException"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.lang.*"%>
<%@page import="java.sql.*"%>



<%
	Connection conn = null;
	ResultSet rs = null;
	int totalCount = 0;
	StringBuffer queryBuffer = new StringBuffer();
	PreparedStatement selectStmt = null;
	PreparedStatement insertStmt = null;
	String selectQuery = null;
	String insertQuery = null;
	Clob clob = null;
	Writer writer = null;
	Reader reader = null;
	
	try {
		Context ctx = new InitialContext();
		try {
			Context envContext  = (Context)ctx.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/enview");                
			conn = ds.getConnection();
		}
		catch(NameNotFoundException nnfe) {
			System.out.println("### 1");
			try {
				DataSource ds = (DataSource)ctx.lookup("jdbc/enview");                
				conn = ds.getConnection();
			}
			catch(NameNotFoundException nnfe2) {
				System.out.println("### 2");
				DataSource ds = (DataSource)ctx.lookup("java:/comp/env/jdbc/enview");                
				conn = ds.getConnection();
			}
		}
		
		
		Timestamp current = new Timestamp(System.currentTimeMillis());
		String sid = "ABC" + String.valueOf( System.currentTimeMillis() );
		Map userData = new HashMap();
		userData.put("user_id", "zzz");
		userData.put("lang_knd", "ko");
		
		insertQuery = "INSERT INTO SESSION_DATA (SID, USER_DATA, CREATION_DATE) VALUES( ?, EMPTY_CLOB(), ? )";
		selectQuery = "SELECT USER_DATA FROM SESSION_DATA WHERE SID=? FOR UPDATE";
		
		insertStmt = conn.prepareStatement( insertQuery );
		insertStmt.setString(1, sid);
		insertStmt.setTimestamp(2, current);
		insertStmt.executeUpdate();
		
		selectStmt = conn.prepareStatement( selectQuery );
		selectStmt.setString(1, sid);
		rs = selectStmt.executeQuery();
		if( rs.next() ) {
			System.out.println("### userData=" + userData);
			clob = rs.getClob(1);
			
			/*
			writer = clob.setCharacterStream(0);
			reader = new CharArrayReader( userData.toString().toCharArray() );
			
			char[] buffer = new char[1024];
			int read = 0;
			while (( read = reader.read( buffer, 0, 1024 )) != -1 ) {
				writer.write(buffer, 0, read);
			}
			*/
			
			ObjectOutputStream ois = new ObjectOutputStream( clob.setAsciiStream(0) );
			ois.writeObject( userData );
			ois.close();
		}
		
		if (null != rs) rs.close();
		if (null != selectStmt) selectStmt.close();
		
		selectQuery = "SELECT USER_DATA FROM SESSION_DATA WHERE SID=?";
		selectStmt = conn.prepareStatement( selectQuery );
		selectStmt.setString(1, sid);
		rs = selectStmt.executeQuery();
		if( rs.next() ) {
			clob = rs.getClob(1);
			System.out.println("### clob=" + clob);
		}
		
		Map userData2 = null;
		ObjectInputStream ois = new ObjectInputStream( clob.getAsciiStream() );
		userData2 = (Map)ois.readObject();
		System.out.println("### userData=" + userData2);
		ois.close();
	}
	finally
	{
		try
		{
			if (null != rs) rs.close();
			if (null != selectStmt) selectStmt.close();
			if (null != conn) conn.close();
		} catch (Exception ee)
		{
		}
	}
%>