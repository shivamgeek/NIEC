package com.database;

import java.sql.Connection;
import com.entity.*;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class societyDatabase {
	
	noticeDatabase nd;
	Connection con;
	PreparedStatement pst;
	
	public societyDatabase() throws SQLException, ClassNotFoundException{
		nd=new noticeDatabase();
		Class.forName("com.mysql.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost:3306/DBNIEC","root","s");
	}
	
	public void addSociety(String s[]) throws SQLException{
		pst=con.prepareStatement("insert into SOCIETY(ID,NAME,PASSWORD,MEMBERLIST,ABOUT,CONTACT,BRANCHLIST,TYPE)"
	+" values(?,?,?,?,?,?,?,?)");
		for(int i=1;i<=8;i++){
			pst.setString(i,s[i-1]);
		}
		int result=pst.executeUpdate();
		System.out.println(result+" Records Affected.");
		
	}
	
	public void addMember(String id,String hexcode,String branch) throws SQLException{
		pst=con.prepareStatement("update SOCIETY set MEMBERLIST=concat(MEMBERLIST,?),BRANCHLIST=concat(BRANCHLIST,?) where ID=?");
		pst.setString(1,hexcode);
        pst.setString(2,branch+" ");
        pst.setString(3,id);
        int result=pst.executeUpdate();
		System.out.println(result+" records are affected");
	}
	
	
	public void removeMember(String id,String hexcode) throws SQLException{
		pst=con.prepareStatement("select MEMBERLIST,BRANCHLIST from SOCIETY where ID=?");
		pst.setString(1,id);
		ResultSet rs=pst.executeQuery();
		String list=rs.getString("MEMBERLIST");
		String blist=rs.getString("BRANCHLIST");
		String temp="",temp1="";
		for(int i=0;i<list.length();i=i+4){
			if(!list.substring(i,i+4).equals(hexcode)){
				temp=temp+list.substring(i,i+4);
				temp1=temp1+blist.substring(i,i+4);
			}
		  pst=con.prepareStatement("update SOCIETY set MEMBERLIST=?,BRANCHLIST=? where ID=?");
			pst.setString(1,temp);
			pst.setString(2,temp1);
			pst.setString(3, id);
			int result=pst.executeUpdate();
			System.out.println(result+" Records Affected.");
		}	
	}
	
	public ResultSet showMembers(String id) throws SQLException{
		pst=con.prepareStatement("select MEMBERLIST,BRANCHLIST from SOCIETY where ID=?");
		pst.setString(1,id);
		ResultSet rs=pst.executeQuery();
		return rs;
	}
	
	
	public void sendNoticeToMembers(String content,String id,String name) throws SQLException{
		pst=con.prepareStatement("select MEMBERLIST from SOCIETY where ID=?");
		pst.setString(1,id);
		ResultSet rs=pst.executeQuery();
		String list=rs.getString("MEMBERLIST");
		String hexcode="";
		for(int i=0;i<list.length();i=i+4){		
			hexcode=list.substring(i,i+4);
			nd.addNotice(content,name,hexcode,"1");
		}
	}
	
	public void removeSociety(String id) throws SQLException{
		pst=con.prepareStatement("delete from SOCIETY where id=?");
		pst.setString(1,id);
		int result=pst.executeUpdate();
		System.out.println(result+" Records Affected.");
	}
	
	public void updateSociety(String s[]) throws SQLException{
		pst=con.prepareStatement("select * from SOCIETY where id=?");
		pst.setString(1,s[0]);
		ResultSet rs=pst.executeQuery();
		rs.next();
		String sql="update SOCIETY set NAME=?,TYPE=?,MEMBERLIST=?,ABOUT=?,CONTACT=?,PASSWORD=?,BRANCHLIST=? where ID=?";
		pst=con.prepareStatement(sql);
		for(int i=1;i<=s.length-1;i++){
			if(!s[i].equals("")){
				pst.setString(i,s[i]);
			}else{
				pst.setString(i,rs.getString(i+1));
			}
		}
		pst.setString(8,s[0]);
		
		System.out.println(sql);
		int result=pst.executeUpdate();
		System.out.println(result+" Records Affected.");
		
		
		
	}
	

}
