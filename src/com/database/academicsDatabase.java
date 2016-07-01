package com.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class academicsDatabase {


	Connection con;
	PreparedStatement pst;
	
	academicsDatabase() throws ClassNotFoundException, SQLException{
		Class.forName("com.jdbc.mysql.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","s");
	}
	
	void insertAll(String branch,String sem,String sub, String subcode,String previous,String teacher,String syllabus) throws SQLException{
		pst=con.prepareStatement("insert into ACADEMICS_"+branch+" (SEMESTER,SUBJECTS,SUBJECTCODES,PREVIOUSPPR,TEACHERS,SYLLABUS)"
				+ " values(?,?,?,?,?,?)");
		pst.setString(1, sem);
		pst.setString(2,sub );
		pst.setString(3,subcode );
		pst.setString(4,previous );
		pst.setString(5, teacher);
		pst.setString(6, syllabus);
	int result=	pst.executeUpdate();
	System.out.println(result+" records affected");
		
	}
	
	ResultSet getSubjects(student s,String sem) throws SQLException{
		pst=con.prepareStatement("select SUBJECTS,SUBJECTCODES FROM ACADEMICS_"+s.s_branch+" where SEMESTER=?");
		pst.setString(1,sem);
		ResultSet rs=pst.executeQuery();
		return rs;
		
	}
	
	
	
	
	
	
	
	
	

}
