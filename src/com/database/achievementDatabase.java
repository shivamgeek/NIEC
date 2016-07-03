package com.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class achievementDatabase {

	String id,content,sender,student,date;//id is auto incremented
	//Image photo
	Connection con;
	PreparedStatement pst;
	
	public achievementDatabase() throws SQLException, ClassNotFoundException{
		Class.forName("com.mysql.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost:3306/DBNIEC","root","s");
		
	}
	public void addAchievement(String content,String sender,String student) throws SQLException{
		pst=con.prepareStatement("insert into ACHIEVEMENT(CONTENT,SENDER,STUDENT,DATE) values(?,?,?,?)");
		pst.setString(1, content);
		pst.setString(2, sender);
		pst.setString(3, student);
		pst.setString(4,new SimpleDateFormat("dd/MM/yyyy").format(Calendar.getInstance().getTime()));
		int result=pst.executeUpdate();
		System.out.println(result+" Results Affected");
		
	}
	
	public ResultSet showAchievment(String roll) throws SQLException{
		pst=con.prepareStatement("select * from ACHIEVMENT where STUDENT=?");
		pst.setString(1, roll);
		ResultSet rs=pst.executeQuery();
		return rs;
	}
	
	public void removeAchievment() throws SQLException{
		//String date=new SimpleDateFormat("dd/MM/yyyy").format(Calendar.getInstance().getTime());
		//TO BE TESTED........********
		pst=con.prepareStatement("delete from ACHIEVMENT where DATE < date_sub(now(),interval 7 month");
		int result=pst.executeUpdate();
		System.out.println(result+" Results Affected");
	}
	
	
	
	
	
	
	
	
}
