package com.database;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

public class society {

/*	String societyId,societyName,societyType,societyAbout;
	HashMap<String,String> hm;
	
	society(String societyId){
		
	}
	
	
	//***********************SOCITY***********************
		
		void addStudentToSociety(String roll,String societyId) throws SQLException{
			ds=new decodingStudent();
			String hexcode=ds.rollToHex(roll);
			pst=con.prepareStatement("update SOCIETY set MEMBERLIST=concat(MEMBERLIST,?) where SOCIETYID=?");
			pst.setString(1,hexcode);
			pst.setString(2, societyId);
			pst.executeUpdate();
			
		}
		
		void removeStudentFromSociety(String roll,String societyId) throws SQLException{
			ds=new decodingStudent();
			String hexcode=ds.rollToHex(roll);
			pst=con.prepareStatement("select MEMBERLIST from SOCIETY where SOCIETYID=?");
			pst.setString(1,societyId);
			ResultSet rs=pst.executeQuery();
			String list=rs.getString("MEMBERLIST");
			String temp="";
			for(int i=0;i<list.length();i=i+4){
				if(!list.substring(i,i+4).equals(hexcode)){
					temp=temp+list.substring(i,i+4);
				}
			  pst=con.prepareStatement("update SOCIETY set MEMBERLIST=? where SOCIETYID=?");
				pst.setString(1,temp);
				pst.setString(2,societyId);
				pst.executeUpdate();
			}
		}
		
	  String societyMemberList(String societyId) throws SQLException{
		  pst=con.prepareStatement("select MEMBERLIST from SOCIETY where SOCIETYID=?");
		  pst.setString(1, societyId);
		  ResultSet rs=pst.executeQuery();
		  String list=rs.getString("MEMBERLIST");	  
		  return list;
	  }
		
	  void showSocietyMembers(){
			HashMap<String,String> hm=new HashMap<String,String>();	
			String list=sd.societyMemberList(societyId)
		ds.decodeStudentList(list, friends, s, hm);
		}*/
	
}
