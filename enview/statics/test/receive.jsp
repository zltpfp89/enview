<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<% 
	Map resultCmd = new HashMap();
	ObjectInputStream ois = null;
	ObjectOutputStream oos= null;
	String msg = "";
	try {
		ois = new ObjectInputStream( request.getInputStream() );
		Map cmd = (Map)ois.readObject();
		ois.close();
		
		String action = (String)cmd.get("action");
		msg = "######## receive action=" + action;
		
		resultCmd.put("result", "success");
		oos = new ObjectOutputStream( response.getOutputStream() );
		oos.writeObject( resultCmd );
		oos.flush();
		oos.close();
	}
	catch(Exception e) {
		e.printStackTrace();
		
		resultCmd.put("result", "fail");
		resultCmd.put("message", e.getMessage());
		oos = new ObjectOutputStream( response.getOutputStream() );
		oos.writeObject( resultCmd );
		oos.flush();
		oos.close();
	}
	finally {
		try {
			if( ois != null ) ois.close();
			if( oos != null ) oos.close();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
%>

<%= msg %>