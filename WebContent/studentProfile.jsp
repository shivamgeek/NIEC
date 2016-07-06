<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.database.*" import="java.sql.*" import="com.entity.*" import="java.text.SimpleDateFormat" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>New Student Profile Page</h3><br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="logout">LOGOUT</a>
<%
String who="";
HttpSession se=request.getSession(false);
Boolean profile=true;
String roll="",branch="";
ResultSet rs=null;
societyDatabase sod=new societyDatabase();
String pending="",sent="";
student s=null;
if(se.getAttribute("id")!=null){
	roll=se.getAttribute("id").toString();branch=se.getAttribute("branch").toString();
}else{
	response.sendRedirect("login.jsp");
}

try{
	
	
	
if(request.getParameter("who")!=null){
	
	if(!roll.equals(request.getParameter("who"))){
		
		s=new student(roll);
		roll=request.getParameter("who");
	    profile=false;
	}else{
		s=new student(roll);
	}
}else{
	s=new student(roll);
}
	    
	rs=s.sd.fetchAll(roll,branch);
 pending=rs.getString("S_PENDINGLIST");
 sent=rs.getString("S_SENTLIST");
System.out.println("profile is "+rs.getString("S_NAME"));
 
 if(!profile && !s.sd.isFriend(s,roll)){
	 System.out.println("1st");
	 if(!s.sd.isSent(roll,s.s_roll, branch)){
		 System.out.println("2nd"); 
	 
	%>Trying to send request
	<form action="sendRequest">
	<input type="hidden" value="<%=roll%>" name="who">
		 <input type="hidden" name="soc" value="s">
	<input type="submit" value="Send Friend Request">
	</form>
	<% 
	 }else{ 
	 System.out.println("3rd");%>
	 <form action="sendRequest">
	 <input type="hidden" name="soc" value="c">
	<input type="hidden" value="<%=roll%>" name="who">
	<input type="submit" value="Cancel Friend Request">
	</form>
	 <%
	 }
 }
 
%><br>
<h4>Basic Info</h4><br>
Name- <%=rs.getString("S_NAME") %><br>
Roll- <%=rs.getString("S_ROLL") %><br>

Branch- <%=rs.getString("S_BRANCH") %><br>
Section- <%=rs.getString("S_SECTION") %><br>
About Me- <%=rs.getString("S_ABOUTME") %><br>
Email- <%=rs.getString("S_EMAIL") %><br>
Gender- <%=rs.getString("S_GENDER") %><br><br>

<h4>Personal Info.</h4><br>
Phone- <%=rs.getString("S_PHONE") %><br>
Hexcode<%=rs.getString("S_HEXCODE") %><br>
Address <%=rs.getString("S_ADDRESS") %><br>

<h4>Student Class FriendList</h4> <br>
<%}catch(Exception e){
	out.println("Sorry error occured in basic info");
	e.printStackTrace();
	}
	


try{
	String sr="S_ROLL";
	
	rs=s.sd.fetchClassFriendList(roll, branch, s.s_section);
	String list=rs.getString("S_CLASSFRIENDS");
	for(int i=0;i<list.length();i=i+4){
		rs=s.sd.fetchAll(s.ds.hexToRoll(list.substring(i,i+4)), branch);
		
	%>
	  <a href="studentProfile.jsp?who=<%=rs.getString(sr)%>" ><%=rs.getString("S_NAME") %></a> <br> 
<%
	}
	 
}catch(Exception e){
out.println("Sorry No Student Class Friends");
e.printStackTrace();
}

try{
	

 rs=s.acd.showAchievement(roll);
 %>
 <h4>Achievements</h4>:<br>
 <%
while(rs.next()){
	%><br>
	
Achievement ID- <%=rs.getString("ID") %><br>Achievement Content- <%=rs.getString("CONTENT") %><br> Achievement Sender- <%=rs.getString("SENDER") %>
<br>Achievement Student -<%=rs.getString("STUDENT") %> <br>Achievement Date- <%=rs.getString("DATE1") %><br>
	
<%
}
}catch(Exception e){
out.println("Sorry No Achievements");e.printStackTrace();
}

try{
	
rs=s.sd.getSociety(roll, branch);
if(rs.next()){
	%>
	<br>
<h4>Societies joined</h4><br>
	<%
	String ids="ID";
	String id[]=rs.getString("S_SOCIETY").split("#");
	if(!rs.getString("S_SOCIETY").equals("")&&(!rs.getString("S_SOCIETY").equals(" "))){
	for(int i=0;i<id.length;i++){
		rs=sod.fetchAll(id[i]);
	
            %> 
            <a href="societyProfile.jsp?id=<%=rs.getString(ids) %>"><%=rs.getString("NAME") %></a><br>

<%
}
}
}
}catch(Exception e){
out.println("Sorry No Societies");e.printStackTrace();
}


%><br><br>
<% 
if(profile){
%>
<br><br>
<h4>Other Class FriendList</h4> <br>
<%try{
	String sr="S_ROLL";
	rs=s.sd.fetchOtherFriendList(roll,branch);
	String list=rs.getString("S_OTHERFRIENDLIST");
	String roll1="";
	for(int i=0;i<list.length();i=i+4){
		roll1=s.ds.hexToRoll(list.substring(i,i+4));
		rs=s.sd.fetchAll(roll1, s.ds.branchName(s.ds.findBranchFromRoll(roll1)));
	%>
		<a href="studentProfile.jsp?who=<%=rs.getString(sr)%>" ><%=rs.getString("S_NAME") %></a> <br>
		
		
	<%
	}
	 
}catch(Exception e){
out.println("Sorry No Other Class Friends");
e.printStackTrace();
}

%>



<h4> TeacherList</h4><br><%
	try{ 
		String idt="T_ID";
		rs=s.sd.fetchTeacherList(roll, branch);
		String tchr= rs.getString("S_TEACHERLIST");
		for(int i=0;i<tchr.length();i=i+4){
			rs=s.td.fetchAll(tchr.substring(i,i+4));
			%>
		<a href="teacherProfile.jsp?who=<%=rs.getString(idt).substring(1,4)%>" ><%=rs.getString("T_NAME") %></a> <br>
		<%}
}
	catch(Exception e){
		out.println("Sorry No Teacher Friends");e.printStackTrace();
		}

%><br><br>

<h4>Notice</h4><br> 
<% try{
 rs=s.nd.showNoticeStudent(s);
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
 <br>
<h4>Academics</h4><br>
<form action="studentMarks.jsp">
Select Semester<select name="semester">
<option value="1">1 </option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
</select>
<input type="submit">
</form>


<br><br>
	<h4>Pending List</h4><br>
	
	<%
	String temp="";
	try{
		String idt="T_ID";
		String ids="S_ROLL";
		for(int i=0;i<pending.length();i=i+4){
			temp=pending.substring(i,i+4);
			if(temp.charAt(0)=='|'){
				rs=s.td.fetchAll(temp);
				%>
				
<a href="teacherProfile.jsp?who=<%=rs.getString(idt).substring(1,4)%>" ><%=rs.getString("T_NAME") %></a>

<form action="acceptRequest" > <input type="submit" value="Accept Request"></form>	<br>	
		<%
			}else{
				rs=s.sd.fetchAll(s.ds.hexToRoll(temp),s.ds.branchName(s.ds.findBranchFromRoll(s.ds.hexToRoll(temp))));
				%>
	<a href="studentProfile.jsp?who=<%=rs.getString(ids)%>" ><%=rs.getString("S_NAME") %></a> 
	<form action="acceptRequest" > <input type="submit" value="Accept Request"></form>	<br>			
				<%
			}
		}
%>

 <% 
	}catch(Exception e){
		out.println("Sorry No Pending List");e.printStackTrace();
		}
	%>
	
<h4>Sent List</h4>	<br>
<%
try{
	 temp="";

	String idt="T_ID";
	String ids="S_ROLL";
	for(int i=0;i<sent.length();i=i+4){
		temp=sent.substring(i,i+4);
		if(temp.charAt(0)=='|'){
			rs=s.td.fetchAll(temp);
			%>
			
<a href="teacherProfile.jsp?who=<%=rs.getString(idt).substring(1,4)%>" ><%=rs.getString("T_NAME") %></a> <br>			
	<%
		}else{
			rs=s.sd.fetchAll(s.ds.hexToRoll(temp),s.ds.branchName(s.ds.findBranchFromRoll(s.ds.hexToRoll(temp))));
			%>
<a href="studentProfile.jsp?who=<%=rs.getString(ids)%>" ><%=rs.getString("S_NAME") %></a> <br>			
			<%
		}
	}
%>


	
<%	
}catch(Exception e){
	out.println("Sorry No Pending List");e.printStackTrace();
	}



}

/*
if(s!=null){
s.closeConnection();
}
try{
if(sd!=null){
	sd.closeConnection();
}
 if(td!=null){
	td.closeConnection();
} 
if(nd!=null){
	nd.closeConnection();
}if(ad!=null){
	ad.closeConnection();
}
if(sod!=null){
	sod.closeConnection();
}
}catch(Exception e){
	out.println("Sorry error occured");e.printStackTrace();
	}
 */


 %><br><br>

    




</body>
</html>