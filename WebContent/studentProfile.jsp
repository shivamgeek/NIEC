<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.database.*" import="java.sql.*" import="com.entity.*" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>Student Profile Page</h3><br>
<%
String roll="01215602713",branch="CSE";
studentDatabase sd=new studentDatabase();
decodingStudent ds=new decodingStudent();
ResultSet rs=sd.fetchAll(roll,branch);
%><br><br>
Basic Info<br>
Name- <%=rs.getString("S_NAME") %><br>
Roll- <%=rs.getString("S_ROLL") %><br>
Hexcode<%=rs.getString("S_HEXCODE") %><br>
Branch- <%=rs.getString("S_BRANCH") %><br>
Section- <%=rs.getString("S_SECTION") %><br><br>

Personal Info.<br>
Phone- <%=rs.getString("S_PHONE") %><br>
About Me- <%=rs.getString("S_ABOUTME") %><br>
Address <%=rs.getString("S_ADDRESS") %><br>
Email- <%=rs.getString("S_EMAIL") %><br>
Gender- <%=rs.getString("S_GENDER") %><br><br>
 FriendList HELLO.<br>
<%
student s=new student(roll);

HashMap<String,String> hm=new HashMap<String,String>();
hm=s.showFriends();
String key,value;
for (String name: hm.keySet()){

            key =name.toString();
            value = hm.get(name).toString(); 
            %> 
Student Roll- <%=key %> Student Name- <%=value %><br>
<%
} %>
<br><br>
 TeacherList<br><%try{
	 
hm=sd.fetchTeacherList(roll,branch);
for (String name: hm.keySet()){

            key =name.toString();
            value =hm.get(name).toString(); 
            %> 
Teacher ID- <%=key %> Teacher Name- <%=value %><br>
<%
}

}catch(Exception e){
out.println("Sorry no friends");
}
%>
Societies joined<br>
<%
hm=sd.getSociety(roll,s.s_branch);
for (String name: hm.keySet()){

            key =name.toString();
            value =hm.get(name).toString(); 
            %> 
SOCIETY ID- <%=key %> SOCIETY Name- <%=value %><br>

<%
}
%>

 
    
     
    
  

</body>
</html>