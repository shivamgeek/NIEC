package com.database;


import java.sql.*;

public class studentDatabase {
	decodingStudent ds;
	Connection con;
	//Statement smt;
	PreparedStatement pst;
	
	studentDatabase() throws ClassNotFoundException, SQLException{
		Class.forName("com.jdbc.mysql.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","s");
		//smt=con.createStatement();
	}

	
	
//**********************SELECT***********************
	
	ResultSet fetchAll(String roll,String branch) throws SQLException{

	pst=con.prepareStatement("select * from STUDENT_"+branch+" where S_ROLL=?");  //add concatenation to student - csse
		pst.setString(1,roll);
		ResultSet rs=pst.executeQuery();
		return rs;
	}
	
	String fetchOtherFriendList(String roll,String branch) throws SQLException{

		pst=con.prepareStatement("select S_OTHERFRIENDLIST from STUDENT_"+branch+" where S_ROLL=?");
		pst.setString(1,roll);
		ResultSet rs=pst.executeQuery();
		String list =rs.getString("S_OTHERFRIENDLIST");
		return list;
	}
	
	ResultSet fetchNameRoll(String hex,String branch) throws SQLException{
		
			pst=con.prepareStatement("select S_NAME,S_ROLL from STUDENT_"+branch+" where S_HEXCODE=?");
			pst.setString(1,hex);
			ResultSet rs=pst.executeQuery();
			return rs;
		
	}
	
	
	String fetchTeacherList(String roll,String branch) throws SQLException{
		pst=con.prepareStatement("select S_TEACHERLIST from STUDENT_"+branch+" where S_ROLL=?");
		pst.setString(1, roll);
		ResultSet rs=pst.executeQuery();
		return rs.getString("S_TEACHERLIST");
	}
	

	
//*********************INSERT*******************
	

	void insert(String roll,String val) throws SQLException{
		pst.setString(1,val);
		pst.setString(2,roll);
		int result=pst.executeUpdate();
		System.out.println(result+" Records Affected.");
	}
	
	
	int insertPendingList(String roll,String hexcode,String branch) throws SQLException{
		if(roll.charAt(0)=='|'){  // INSERT HEXCODE TO TEACHER PENDING LIST
			pst=con.prepareStatement("update TEACHER set T_PENDINGLIST=concat(T_PENDINGLIST,?) where T_ID=?");
		}else{    // INSERT HEXCODE TO STUDENT PENDING LIST
		pst=con.prepareStatement("update STUDENT_"+branch+" set S_PENDINGLIST=concat(S_PENDINGLIST,?) where S_ROLL=?");
		}  
		pst.setString(1,hexcode);
		pst.setString(2,roll);
		int result=pst.executeUpdate();
		System.out.println(result+" Records Affected.");
		return result;
	}
	
	
	int insertSentList(String roll,String hexcode,String branch) throws SQLException{ 
		
		pst=con.prepareStatement("update STUDENT_"+branch+" set S_SENTLIST=concat(S_SENTLIST,?) where S_ROLL=?");
		pst.setString(1,hexcode);
		pst.setString(2,roll);
		int result=pst.executeUpdate();
		System.out.println(result+" Records Affected.");
		return result;
		
	}

//*********************UPDATE****************
	
	void update(String roll,String val) throws SQLException{
		pst.setString(1,val);
		pst.setString(2,roll);
		int result=pst.executeUpdate();
		System.out.println(result+" Records Affected.");
}
	
	void updateSem(String roll,String val,String branch) throws SQLException{
		pst=con.prepareStatement("update STUDENT_"+branch+"  set S_SEMESTER=? where S_ROLL=? ");
		update(roll,val);
	}
	
	void updatePhone(String roll,String val,String branch) throws SQLException{
		pst=con.prepareStatement("update STUDENT_"+branch+"  set S_PHONE=? where S_ROLL=? ");
		update(roll,val);
	}

	void updateAddress(String roll,String val,String branch) throws SQLException{
		pst=con.prepareStatement("update STUDENT_"+branch+"  set S_ADDRESS=? where S_ROLL=? ");
		update(roll,val);
	}

	void updateEmail(String roll,String val,String branch) throws SQLException{
		pst=con.prepareStatement("update STUDENT_"+branch+"  set S_EMAIL=? where S_ROLL=? ");
		update(roll,val);
	}
	
	void updatePassword(String roll,String val,String branch) throws SQLException{
		pst=con.prepareStatement("update STUDENT_"+branch+"  set S_PASSWORD=? where S_ROLL=? ");
		update(roll,val);
	}
	
	void updateAboutMe(String roll,String val,String branch) throws SQLException{
		pst=con.prepareStatement("update STUDENT_"+branch+"  set S_ABOUTME=? where S_ROLL=? ");
		update(roll,val);
	}
	
	
	
	
//********************CLASSINFO DATABASE*****************************************
	
	String fetchClassFriendList(String roll,String branch,String section) throws SQLException{

		pst=con.prepareStatement("select S_CLASSFRIENDS from CLASSINFO where S_BRANCH=? and S_SECTION=?");
		pst.setString(1,branch);
		pst.setString(2,section);
		ResultSet rs=pst.executeQuery();
		String list=rs.getString("S_CLASSFRIENDS");
		return list;
		}
	
	
	int addStudentHexcodeToClass(String roll,String branch,String section,String value) throws SQLException{
		pst=con.prepareStatement("update CLASSINFO set S_CLASSFRIENDS=concat(S_CLASSFRIENDS,?) where S_SECTION=? and S_BRANCH=?");
		pst.setString(1,value);
		pst.setString(2,section);
		pst.setString(3,branch);
		int result=pst.executeUpdate();
		System.out.println(result+" Records Affected.");
		return result;
	}
	
	void addFriendToStudent(String roll,String id) throws SQLException{
		if(id.charAt(0)=='|'){
			pst=con.prepareStatement("update STUDENT_"+ds.branchName(ds.findBranchFromRoll(roll))+" set S_TEACHERLIST=concat(S_TEACHERLIST,?) where S_ROLL=?");
		}else{
			pst=con.prepareStatement("update STUDENT_"+ds.branchName(ds.findBranchFromRoll(roll))+" set S_OTHERFRIENDLIST=concat(S_OTHERFRIENDLIST,?) where S_ROLL=?");
		}
		pst.setString(1,id);
		pst.setString(2,roll);
		int result=pst.executeUpdate();
		System.out.println(result+" Records Affected.");
	}
	
	
//***********************DELETE******************
	
	void removeSentList(String roll,String hexcode,String branch) throws SQLException{
		if(roll.charAt(0)=='|'){
			pst=con.prepareStatement("select T_SENTLIST from TEACHER where T_ID=?");
		}else{
		pst=con.prepareStatement("select S_SENTLIST from STUDENT_"+branch+" where S_ROLL=?");
		}
		pst.setString(1, roll);
		ResultSet rs=pst.executeQuery();
		String list;
		if(roll.charAt(0)=='|'){
			list=rs.getString("T_SENTLIST");
		}else{
			list=rs.getString("S_SENTLIST");
		}
		
		String temp="";
		for(int i=0;i<list.length();i=i+4){
			if(!list.substring(i,i+4).equals(hexcode)){
				temp=temp+list.substring(i,i+4);
			}
		}
		if(roll.charAt(0)=='|'){
			pst=con.prepareStatement("update TEACHER set T_SENTLIST=? where T_ID=?");
		}else{
		  pst=con.prepareStatement("update STUDENT_"+branch+" set S_SENTLIST=? where S_ROLL=?");
		}
			pst.setString(1,temp);
			pst.setString(2, roll);
			int result=pst.executeUpdate();
			System.out.println(result+" Records Affected.");
		
	}
	
	
	void removePendingList(String roll,String hexcode,String branch) throws SQLException{
		pst=con.prepareStatement("select S_PENDINGLIST from STUDENT_"+branch+" where S_ROLL=?");
		pst.setString(1, roll);
		ResultSet rs=pst.executeQuery();
		String list=rs.getString("S_PENDINGLIST");
		String temp="";
		for(int i=0;i<list.length();i=i+4){
			if(!list.substring(i,i+4).equals(hexcode)){
				temp=temp+list.substring(i,i+4);
			}
		  pst=con.prepareStatement("update STUDENT_"+branch+" set S_PENDINGLIST=? where S_ROLL=?");
			pst.setString(1,temp);
			pst.setString(2, roll);
			int result=pst.executeUpdate();
			System.out.println(result+" Records Affected.");
		}	
	}

	String findSectionFromRoll(String roll) throws SQLException{
		pst=con.prepareStatement("select S_SECTION from STUDENT_"+ds.branchName(ds.findBranchFromRoll(roll))
		+" where S_ROLL=?");
		pst.setString(1, roll);
		ResultSet rs=pst.executeQuery();
		return rs.getString("S_SECTION");
	}
	
	
	
	
	Boolean isFriend(student s,String id) throws SQLException{
		if(id.charAt(0)=='|'){   //TEACHER
			String teacherList=fetchTeacherList(s.s_roll,s.s_branch);
			if((teacherList.indexOf(id)==-1) || ((teacherList.indexOf(id)%4)!=0)){
				return false;
			}
			return true;
		}
		
		else{  //STUDENT
			if(s.s_section.equals(findSectionFromRoll(id))){
				return true;
			}
			else {
				String list=fetchOtherFriendList(s.s_roll,s.s_branch);
				String hex=ds.rollToHex(id);
				if((!(list.indexOf(hex)==-1) && ((list.indexOf(hex)%4)==0))){
					return true;
			}
			return false;
			}
		}
	}
	
	
	
	
	
	
	
	
	
	
	}
	
	
	
	
	
	
	
	
	
	

