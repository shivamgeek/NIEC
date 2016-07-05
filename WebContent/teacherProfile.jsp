<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.database.*" import="java.sql.*" import="com.entity.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>


<h3>Teacher Profile Page</h3><br>
<%

HttpSession se=request.getSession(false);
String id=se.getAttribute("id").toString();
teacherDatabase td=new teacherDatabase();
ResultSet rs=null;
String tid=null,tnme=null,list=null;
teacher t=new teacher(id);
studentDatabase sd=new studentDatabase();
decodingStudent ds=new decodingStudent();
noticeDatabase nd=new noticeDatabase();
achievementDatabase ad=new achievementDatabase();
try{
	 rs=td.fetchAll(id);

tid=rs.getString("T_ID");
tnme=rs.getString("T_NAME");
se.setAttribute("name",tnme);
%><br>
<h4>Basic Info</h4><br>
Name- <%=rs.getString("T_NAME") %><br>
Roll- <%=rs.getString("T_ID") %><br>
Hexcode<%=rs.getString("T_ID") %><br>
Branch- <%=rs.getString("T_BRANCH") %><br>
Classes- <%=rs.getString("T_CLASSES") %>
<br><br>

<h4>Personal Info.</h4><br>
Phone- <%=rs.getString("T_PHONE") %><br>
About Me- <%=rs.getString("T_ABOUTME") %><br>
Email- <%=rs.getString("T_EMAIL") %><br>
Gender- <%=rs.getString("T_GENDER") %><br><br>
<h4>Teacher FriendList</h4><br>
<%
rs=td.fetchAll(id);
 list=rs.getString("T_TEACHERLIST");
 if(list.length()>3){
for(int i=0;i<list.length();i=i+4){
	rs=td.fetchAll(list.substring(i,i+4));
	%>
		Name-<%=rs.getString("T_NAME") %> <br>
<%	
}
 }}catch(Exception e){
	 out.println("Sorry some problem occured in getting basic information");
	 e.printStackTrace();
	 }
%>

<h4>Student FriendList</h4><br>
<% try{

rs=td.fetchAll(id);
list=rs.getString("T_STUDENTLIST");
if(list.length()>3){
for(int i=0;i<list.length();i=i+4){
	rs=sd.fetchAll(ds.hexToRoll(list.substring(i,i+4)),ds.branchName(ds.findBranchFromRoll(ds.hexToRoll((list.substring(i,i+4))))));
	%>
		Name-<%=rs.getString("S_NAME") %> <br>
<%	
}
 }	}catch(Exception e){
	 out.println("Sorry No FriendList");
	 e.printStackTrace();
	 }
 
 %>
<h4>Notice</h4>
<%
try{
 rs=nd.showNoticeTeacher(t);
while(rs.next()){
	%><br>
<br>Notice ID- <%=rs.getString("ID") %><br>Notice Content- <%=rs.getString("CONTENT") %><br>Notice Sender- <%=rs.getString("SENDER") %>
<br>Notice Reciever -<%=rs.getString("RECEIVER") %><br> Notice approve- <%=rs.getString("APPROVE") %>
	
<%
}
}catch(Exception e){
	 out.println("Sorry No Notices");
	 e.printStackTrace();
	 }
%><br><br>
<form action="noticeTeacher.jsp">
<input type="submit" value="Add Notice"> </form>
<br>
<form action="teacherAchievement.jsp">
<input type="submit" value="Add Achevement"> </form><br>
<form action="teacherMarks.jsp">
<input type="submit" value="Show/Update Marks"> </form>






</body>
</html>