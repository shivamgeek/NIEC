<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.database.*" import="java.sql.*" import="com.entity.*" import="java.text.SimpleDateFormat" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>Student Profile Page</h3><br>
<%

HttpSession se=request.getSession(false);
String roll=se.getAttribute("id").toString(),branch=se.getAttribute("branch").toString();
studentDatabase sd=new studentDatabase();
decodingStudent ds=new decodingStudent();
noticeDatabase nd=new noticeDatabase();
ResultSet rs=sd.fetchAll(roll,branch);
achievementDatabase ad=new achievementDatabase();
String pending=rs.getString("S_PENDINGLIST");
%><br>
<h4>Basic Info</h4><br>
Name- <%=rs.getString("S_NAME") %><br>
Roll- <%=rs.getString("S_ROLL") %><br>
Hexcode<%=rs.getString("S_HEXCODE") %><br>
Branch- <%=rs.getString("S_BRANCH") %><br>
Section- <%=rs.getString("S_SECTION") %><br><br>

<h4>Personal Info.</h4><br>
Phone- <%=rs.getString("S_PHONE") %><br>
About Me- <%=rs.getString("S_ABOUTME") %><br>
Address <%=rs.getString("S_ADDRESS") %><br>
Email- <%=rs.getString("S_EMAIL") %><br>
Gender- <%=rs.getString("S_GENDER") %><br><br>
<h4>FriendList</h4> <br>
<%

student s=null;
String key,value;
HashMap<String,String> hm;
try{
	s=new student(roll);
	hm=new HashMap<String,String>();
hm=s.showFriends();

for (String name: hm.keySet()){

            key =name.toString();
            value = hm.get(name).toString(); 
            %> 
<br>Student Roll- <%=key %> <br>Student Name- <%=value %><br>
<%
} 
}catch(Exception e){
out.println("Sorry No Student Friends");
e.printStackTrace();
}

%>
<br><br>
	



<h4> TeacherList</h4><br><%
	try{ 
hm=sd.fetchTeacherList(roll,branch);
for (String name: hm.keySet()){

            key =name.toString();
            value =hm.get(name).toString(); 
            %> 
<br>Teacher ID- <%=key %> <br>Teacher Name- <%=value %><br>
<%
}
	}catch(Exception e){
		out.println("Sorry No Teacher Friends");e.printStackTrace();
		}

%><br><br>
<h4>Societies joined</h4><br>
<% try{
hm=sd.getSociety(roll,s.s_branch);
for (String name: hm.keySet()){

            key =name.toString();
            value =hm.get(name).toString(); 
            %> 
<br>SOCIETY ID- <%=key %><br> SOCIETY Name- <%=value %><br>

<%
}
}catch(Exception e){
out.println("Sorry No Societies");e.printStackTrace();
}


%><br><br>
<h4>Notice</h4><br>
<% try{
 rs=nd.showNoticeStudent(s);
while(rs.next()){
	%><br>
<br>Notice ID- <%=rs.getString("ID") %><br>Notice Content- <%=rs.getString("CONTENT") %><br>Notice Sender- <%=rs.getString("SENDER") %>
<br>Notice Reciever -<%=rs.getString("RECEIVER") %><br> Notice approve- <%=rs.getString("APPROVE") %>
	
<%
}
}catch(Exception e){
out.println("Sorry No New Notices");e.printStackTrace();
}
%><br><br>
 <h4>Achievements</h4>:<br>
<% try{
 rs=ad.showAchievement(roll);
while(rs.next()){
	%><br>
Achievement ID- <%=rs.getString("ID") %><br>Achievement Content- <%=rs.getString("CONTENT") %><br> Achievement Sender- <%=rs.getString("SENDER") %>
<br>Achievement Student -<%=rs.getString("STUDENT") %> <br>Achievement Date- <%=rs.getString("DATE1") %><br>
	
<%
}
}catch(Exception e){
out.println("Sorry No Achievements");e.printStackTrace();
}

%>
<br><br>
<h4>Academics</h4><br>
<% try{
HashMap<String,String[]> hm1=new HashMap<String,String[]>();
 hm1=s.showMarks(s,s.s_semester);
 if(hm1!=null){
 String subjects[]=hm1.get("subject");
 String codes[]=hm1.get("codes");
 String marksCodes[]=hm1.get("marks");
 for(int i=0;i<marksCodes.length&&(subjects.length==marksCodes.length);i++){   %>
	 
	<br>SUBJECT--><%=subjects[i] %> <br>CODE--> <%=codes[i]%> <br>MARKS-->  <%= marksCodes[i]%><br>
	<%
	} 
 }}catch(Exception e){
	 out.println("Sorry No Academic Record yet");e.printStackTrace();
 }
	%><br><br>
	<h4>Pending List</h4><br>
	<h5>Students-</h5>
	
	<%
	HashMap<String,String> student=null,teacher=null;
	try{
	HashMap<String,HashMap<String,String>> pend=sd.decodePendingList(pending);
	 student=pend.get("student");
	 teacher=pend.get("teacher");
	
	for (String name: student.keySet()){

        key =name.toString();
        value =student.get(name).toString(); 
%>
<br>Student Roll- <%=key %> <br>Student Name- <%=value %>
 <%} 
	}catch(Exception e){
		out.println("Sorry No Student Pending List");e.printStackTrace();
		}
 %><br><br>
   <h5>Teachers-</h5> 
  <%
  try{
  for (String name: teacher.keySet()){

        key =name.toString();
        value =teacher.get(name).toString(); 
%>
<br>Teacher Roll- <%=key %><br> Teacher Name- <%=value %>
 <%}
  
  
}catch(Exception e){
out.println("Sorry no Teacher Pending List");e.printStackTrace();
}
  
  %>
    


</body>
</html>