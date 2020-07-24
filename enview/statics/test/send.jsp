<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<% 
	URLConnection con = null;
	ObjectOutputStream oos= null;
	ObjectInputStream ois = null;
	String msg = "";
	try {
		String connUrl = "http://192.168.0.28:8081/enview/statics/receive.jsp";
		
		URL cluster = new URL(connUrl);
		con = cluster.openConnection();
		//con.setConnectTimeout(30000);
		con.setDoOutput( true ); 
		con.setDoInput( true ); 
		con.setUseCaches( false ); 
		con.setRequestProperty( "Content-type", "application/x-www-form-urlencoded" ); 
		
		Map cmd = new HashMap();
		cmd.put("action", "test");
		oos = new ObjectOutputStream( con.getOutputStream() );
		oos.writeObject( cmd );
		oos.flush();
		oos.close();

		ois = new ObjectInputStream(con.getInputStream());
		cmd = (Map)ois.readObject();
		ois.close();
		
		String result = (String)cmd.get("result");
		msg = "######## server result=" + result;
	}
	catch(Exception ne) {
		ne.printStackTrace();
	}
	finally {
		try {
			if( oos != null ) oos.close();
			if( ois != null ) ois.close();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
%>

<%= msg %>