<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.database.*" import="java.sql.*" import="com.entity.*" import="java.text.SimpleDateFormat" import="java.util.* "%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
  setTimeout(function () { location.reload(true); }, 2500);
</script>
<%try{
HttpSession s=request.getSession(false);
chatDatabase cd=new chatDatabase();
s.setAttribute("id","01215602713");
String id="8";
ResultSet rs=cd.showChat(id);
while(rs.next()){
%>	
Message id- <%=rs.getString("MID") %>&nbsp&nbsp Sender- <%=rs.getString("SENDER") %>&nbsp&nbsp Message-	<%=rs.getString(2) %>
&nbsp&nbsp Time- <%=rs.getString(4) %><br>
<% 
}
cd.closeConnection();
}catch(Exception e){
	 out.println("Some problem occured in getting data");
	 e.printStackTrace();
	 }
%>






</body>
</html>