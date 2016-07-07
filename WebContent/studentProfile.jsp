<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.database.*" import="java.sql.*" import="com.entity.*" import="java.text.SimpleDateFormat" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>New Student Profile Page</h3><br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="logout">LOGOUT</a><br>
<a href="studentProfile.jsp">Go to PROFILE</a>
<%
String who="",chatGroups="";
HttpSession se=request.getSession(false);
Boolean profile=true;
String roll="",branch="",me="",br="";
ResultSet rs=null;
societyDatabase sod=new societyDatabase();
String pending="",sent="";
student s=null;
if(se.getAttribute("id")!=null){
	roll=se.getAttribute("id").toString();
	me=roll;br=branch;
}else{
	response.sendRedirect("login.jsp");
}

try{
	
	
	
if(request.getParameter("who")!=null){
	// ROLL/WHO is myself as student and me is visitor
	if(!roll.equals(request.getParameter("who"))){
		roll=request.getParameter("who");
		s=new student(roll);
		 profile=false;
	}else{
		s=new student(roll);
	}
}else{
	s=new student(roll);
}
	  branch=s.ds.branchName(s.ds.findBranchFromRoll(roll));  
	rs=s.sd.fetchAll(roll,branch);
 pending=rs.getString("S_PENDINGLIST");
 sent=rs.getString("S_SENTLIST");
 chatGroups=rs.getString("CHATID");
 if(!profile && !s.sd.isFriend(s,me)){ 
	 
	 if(me.charAt(0)=='|'){
		 if(!s.sd.isSent(roll,me) && !s.sd.isPending(roll,me)){  //TEACHER
			 %>Trying to send request
				<form action="sendRequest">
				<input type="hidden" value="<%=roll%>" name="who">
					 <input type="hidden" name="soc" value="s">
				<input type="submit" value="Send Friend Request">
				</form>
				<%
				
		 }
		 else if(s.sd.isSent(roll,me)){  
			 %>
				<form action="acceptRequest" > <input type="submit" value="Accept Request">
			<input type="hidden" name="who" value="<%=roll%>">
				</form>
		 <% 
		 }
		 else{
			 %>
			 <form action="sendRequest">
			 <input type="hidden" name="soc" value="c">
			<input type="hidden" value="<%=roll%>" name="who">
			<input type="submit" value="Cancel Friend Request">
			</form>
			 <%
			 
		 }
	 }
	 else if(!s.sd.isSent(roll,me) && !s.sd.isPending(roll,me)){
		 
		 %>Trying to send request
			<form action="sendRequest">
			<input type="hidden" value="<%=roll%>" name="who">
				 <input type="hidden" name="soc" value="s">
			<input type="submit" value="Send Friend Request">
			</form>
			<% 
		 
	 }
	 
	 else if(s.sd.isPending(me,roll)){  
		 %>
			<form action="acceptRequest" > <input type="submit" value="Accept Request">
		<input type="hidden" name="who" value="<%=roll%>">
			</form>
	 <% 
	 }
	 
	 
	 
	else{ 
	 %>
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
		<a href="studentProfile.jsp?who=<%=rs.getString(sr)%>" ><%=rs.getString("S_NAME") %></a><%if(profile){ %>
		&nbsp<form action="removeFriend">
		<input type="hidden" name="friend" value="<%=rs.getString(sr)%>">
		<input type="submit" value="Remove Friend"></form>
		<%} %>
		<br>
		
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
		<a href="teacherProfile.jsp?who=<%=rs.getString(idt).substring(1,4)%>" ><%=rs.getString("T_NAME") %></a><%if(profile){ %>
		&nbsp<form action="removeFriend">
		<input type="hidden" name="friend" value="<%=rs.getString(idt)%>">
		<input type="submit" value="Remove Friend"></form>
		<%} %>
		 <br>
		<%}
}
	catch(Exception e){
		out.println("Sorry No Teacher Friends");e.printStackTrace();
		}

%><br><br>

<h4>Notice</h4> 
<% try{
 rs=s.nd.showNoticeStudent(s);
 %>
 <table border="3">
 <tr><th>Notice ID-</th><th>Notice Content</th><th>Notice Sender</th><th>Notice Reciever</th>
 <th>Notice approve</th></tr>
 <% 
while(rs.next()){
	%>
 <tr><td><%=rs.getString("ID")%></td> <td><%=rs.getString("CONTENT") %></td>  <td><%=rs.getString("SENDER") %></td>

 <td>-<%=rs.getString("RECEIVER") %></td> <td> <%=rs.getString("APPROVE") %></td></tr>
	
<%
}
%></table>
<% 
 
}catch(Exception e){
out.println("Sorry No New Notices");e.printStackTrace();
}
%><br>
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

<form action="acceptRequest" > <input type="submit" value="Accept Request">
<input type="hidden" name="who" value="<%= rs.getString(idt)%>">


</form>	<br>	
		<%
			}else{
				rs=s.sd.fetchAll(s.ds.hexToRoll(temp),s.ds.branchName(s.ds.findBranchFromRoll(s.ds.hexToRoll(temp))));
				%>
	<a href="studentProfile.jsp?who=<%=rs.getString(ids)%>" ><%=rs.getString("S_NAME") %></a> 
	<form action="acceptRequest" > <input type="submit" value="Accept Request">
	<input type="hidden" name="who" value="<%= rs.getString(ids)%>">
	</form>	<br>			
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
try{
%>
<br><br><h4>Chat Groups</h4><br>
<%
String cid[]=chatGroups.split("#"),chatid="CHATID";
for(int i=0;i<cid.length && !chatGroups.equals("");i++){
	rs=s.cd.fetchAll(cid[i]); 
	%>
	<a href="chatScreen.jsp?cid=<%=rs.getString(chatid)%>"><%=rs.getString("NAME") %></a><br>
	<form action="removeChat"> <input type="submit" value="Leave Group"> 
	<input type="hidden" name="cid" value="<%=rs.getString(chatid)%>" > </form>
	
	
	<%
}
%>
<h4>Create a New Chat Room</h4>
<a href="insertChatRoom.jsp">Create</a>

<%
}catch(Exception e){
	out.println("Error in getting chat groups ");e.printStackTrace();
	}



}  //FOR PROFILE ENDED

try{
if(s!=null){
s.closeConnection();
}

}catch(Exception e){
	out.println("Sorry error occured");e.printStackTrace();
	}
 


 %><br><br>

    




</body>
</html>