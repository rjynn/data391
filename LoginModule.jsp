<HTML><BODY>
<%@ page import="connectionmaker.*"%>
<%@ page import="java.sql.*"%>
<%
Connection conn = null;
if(request.getParameter("Submit") != null) {	//extracting logininfo
    String username = (request.getParameter("USERID").trim());
    String password = (request.getParameter("PASSWD").trim());
    try{
	connmaker cn = new connmaker();
        conn = cn.mkconn(); 	//creates a connection with database
    }
    catch(Exception ex){
        out.println("<hr>"+ ex.getMessage() + "<hr>");
    }

    Statement stmt = null;
    ResultSet rset = null;
    String sqlstring = "SELECT password FROM users WHERE user_name = '"+username+"'";
    try{

        stmt = conn.createStatement();
        rset = stmt.executeQuery(sqlstring);
    }
    catch(Exception ex){
        out.println("<hr>"+ ex.getMessage() +"<hr>");
	out.println(sqlstring);
	conn.close();
    }

    String dbpassword = "";  	//checking if results includes logininfo
    while(rset != null && rset.next()){
        dbpassword = rset.getString(1).trim();
        if(password.equals(dbpassword)){
            out.println("login successful"); 	//need to change this to going to nextpage
	    conn.close();
            break;
        }
        else{
            out.println("user/password wrong");
	    conn.close();
            break;
        }
    }
}
else{ %>
<%@ include file="LoginModule.html"%>
<%}%>

</HTML>
</BODY>
