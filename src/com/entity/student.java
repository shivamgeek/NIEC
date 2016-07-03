package com.entity;
import java.sql.*;

import java.util.HashMap;
import com.database.*;
public class student {

	public String s_roll,s_name,s_password,s_branch,s_section,s_semester,s_address,s_phone,
	s_email,s_gender,s_hexcode,s_otherFriendList,s_teacherList,s_pendingList,s_sentList,s_aboutMe,s_society;
	//Image s_profilePic;
	decodingStudent ds;
	studentDatabase sd;
	achievementDatabase acd;
	noticeDatabase nd;
	academicsDatabase ad;
	marksDatabase md;
	teacherDatabase td;
	
	public student(String s_roll) throws Exception{
		 sd=new studentDatabase();
		 acd=new achievementDatabase();
		 td=new teacherDatabase();
		 md=new marksDatabase();
		ad=new academicsDatabase(); 
		ds=new decodingStudent();
		ResultSet rs=sd.fetchAll(s_roll,ds.branchName(ds.findBranchFromRoll(s_roll)));
		s_roll=rs.getString("S_ROLL");
		s_name=rs.getString("S_NAME");
		s_branch=rs.getString("S_BRANCH");
		s_phone=rs.getString("S_PHONE");
		s_password=rs.getString("S_PASSSWORD");
		s_email=rs.getString("S_EMAIL");
		s_pendingList=rs.getString("S_PENDINGLIST");	
		s_sentList=rs.getString("S_SENTLIST");	
		s_aboutMe=rs.getString("S_ABOUT ME");
		s_gender=rs.getString("S_GENDER");
		s_section=rs.getString("S_SECTION");
		s_semester=rs.getString("S_SEMESTER");
		s_address=rs.getString("S_ADDRESS");
		s_hexcode=rs.getString("S_HEXCODE");
		s_otherFriendList=rs.getString("S_OTHERFRIENDLIST");
		s_teacherList=rs.getString("S_TEACHERLIST");
		s_society=rs.getString("S_SOCIETY");
	
		
	}
	
	public void showAchievment() throws SQLException{
		acd.showAchievment(s_roll);
	}
	
	public void showFriends() throws Exception{
		
		HashMap<String,String> hm=new HashMap<String,String>();
		String list=sd.fetchClassFriendList(s_roll,s_branch,s_section);
	    ds.decodeStudentList(list,true,this,hm);
		list=sd.fetchOtherFriendList(s_roll,s_branch);
		 ds.decodeStudentList(list,false,this,hm);
		}
	
	
	
	//WHILE CALLING THIS FUNCTION FOR TEACHER PASS T_ID AS FRIENDROLL
	public void sendFriendRequest(String friendRoll) throws Exception{  
		if(friendRoll.charAt(0)=='|'){
			//friendRoll=||24
			sd.insertSentList(s_roll,friendRoll,s_branch);   //for sending request to a teacher
			sd.insertPendingList(friendRoll,s_hexcode,ds.branchName(ds.findBranchFromRoll(friendRoll)));//for sending request to a teacher
		}
		else{
			//friendRoll=01215602713
		sd.insertSentList(s_roll,ds.rollToHex(friendRoll),s_branch);   
		sd.insertPendingList(friendRoll, s_hexcode,ds.branchName(ds.findBranchFromRoll(friendRoll)));
		}
		nd.addNotice(s_name+" has sent you a Friend Request",s_name,friendRoll,"1");
        
	}
	
	
	public void acceptFriendRequest(String friendRoll) throws Exception{
		if(friendRoll.charAt(0)=='|'){
			//friendRoll=||24
			sd.removeSentList(friendRoll,s_hexcode, ds.branchName(ds.findBranchFromRoll(friendRoll)));
			sd.removePendingList(s_roll,friendRoll,s_branch);
			sd.addFriendToStudent(s_roll,friendRoll);
			td.addFriendToTeacher(friendRoll,s_hexcode);
		}
		else{//friendRoll=01215602713
			String hex=ds.rollToHex(friendRoll);
			sd.removeSentList(friendRoll,s_hexcode, ds.branchName(ds.findBranchFromRoll(friendRoll)));
			sd.removePendingList(s_roll,hex,s_branch);	
			sd.addFriendToStudent(s_roll,hex);
			sd.addFriendToStudent(friendRoll,s_hexcode);
		}
		 nd=new noticeDatabase();
		nd.addNotice(s_name+" has Accepted your Friend Request",s_name,friendRoll,"1");
		
	}
	
	
	public void showMarks(student s,String sem) throws SQLException{   //?1?12#12#23#23#45#?2?12#12#23#23#45#?3?12#12#23#23#45#?4?12#12#23#
		
		if(Integer.parseInt(sem)<=Integer.parseInt(s_semester)){  
			String marks=md.showMarksCode(s_roll,s_branch);
			ResultSet rs=ad.getSubjects(s,sem);
			String subName=rs.getString("SUBJECTS");
			String subCode=rs.getString("SUBJECTCODES");
		    String subjects[]=subName.split("#"); 
		    String codes[]=subCode.split("#");  
		    int startIndex=marks.indexOf("?"+sem+"?")+3;
			String se=(Integer.parseInt(sem)+1)+"";
			int lastIndex=marks.indexOf("?"+se+"?");
			if(lastIndex==-1){
				lastIndex=marks.lastIndexOf('#'); 
			}
			String marksC=marks.substring(startIndex, lastIndex);
			String marksCodes[]=marksC.split("#");  
			for(int i=0;i<marksCodes.length&&(subjects.length==marksCodes.length);i++){
				System.out.println("SUBJECT--> "+subjects[i]+" CODE--> "+codes[i]+" MARKS--> "+marksCodes[i]);
			}
		}
		
		else{
			System.out.println("Invalid Semester ");
		}
		
	}
	
	/*void subjectCode(student s,String sem) throws SQLException{
		ResultSet rs=ad.getSubjects(s,sem);
		String subName=rs.getString("SUBJECTS");
		String subCode=rs.getString("SUBJECTCODES");
	    String subjects[]=subName.split("#");
	    String codes[]=subCode.split("#");
	   for(int i=0;i<subjects.length;i++){
	    	System.out.println("SUBJECT--> "+subjects[i]+" CODE--> "+codes[i]);
	    }
		
	}
	*/
	
	
	
	
	
}
