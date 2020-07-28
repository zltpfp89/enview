<%@page import="org.apache.commons.logging.LogFactory"%>
<%@page import="org.apache.commons.logging.Log"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.Writer"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.File"%>

<%!
public void renameFiles( PrintWriter pw, File dir) {
    try{
        pw.println( "checking " + dir.getAbsolutePath() + "<br>");
    	pw.flush();
    	File[] files = dir.listFiles();
    	for( int i=0;i<files.length;i++) {
    		String name = files[i].getAbsolutePath();
    		if( name.charAt( name.length()-1) == 13) {
    			String newName =  name.substring(0, name.length()-1);
    			files[i].renameTo( new File(  newName));
    			pw.println( files[i].getAbsolutePath() + " -> " + newName + "<br>");
    		}
    		if( files[i].isDirectory()) {
    			renameFiles( pw, files[i]);
    		}
    	}
    } catch(NullPointerException e){
        return;
    } catch(Exception e){
        return;
    }
}

%>
<%
PrintWriter pw = new PrintWriter(out);
try {
	File dir = new File("/usr2");
	renameFiles( pw, dir);
} catch(NullPointerException e) {
    Log log = LogFactory.getLog(getClass());
	log.error( e.getMessage(), e);;
    new PrintWriter(out);
} catch(Exception e) {
    Log log = LogFactory.getLog(getClass());
	log.error( e.getMessage(), e);;
	new PrintWriter(out);
}
	
%>
