package com.database;
import com.entity.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class marksDatabase {

	Connection con;
	PreparedStatement pst;
	
	public marksDatabase() throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost:3306/DBNIEC","root","s");
	}
	//********************************METHODS ARE CHECKED**********************
	
	public void insertMarks(String marks,String roll,String branch) throws SQLException{ //ONLY FOR 1ST SEMESTER
		pst=con.prepareStatement("insert into RESULT_"+branch+"(ROLL,MARKS) values(?,?)");
		pst.setString(1,roll);
		pst.setString(2, marks);
		int result=pst.executeUpdate();
		System.out.println(result+" Records Affected");
	}
	
	
	public void updateMarks(String marks,String roll,String branch) throws SQLException{   //DEFALULT CASE 
		pst=con.prepareStatement("update RESULT_"+branch+" set MARKS=concat(MARKS,?) where ROLL=? ");
		pst.setString(1,marks);
		pst.setString(2,roll);
		int result=pst.executeUpdate();
		System.out.println(result+" Records Affected");
	}
	
	public String showMarksCode(String roll,String branch) throws SQLException{
		pst=con.prepareStatement("select MARKS from RESULT_"+branch+" where ROLL=?");
		pst.setString(1,roll);
		ResultSet rs=pst.executeQuery();
		rs.next();
		return rs.getString("MARKS");
	}
	
	
	
	
}
