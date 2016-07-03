package com.database;
import java.sql.*;
import com.entity.*;
public class noticeDatabase {

	Connection con;
	PreparedStatement pst;
	
	public noticeDatabase() throws SQLException, ClassNotFoundException{
		Class.forName("com.mysql.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost:3306/DBNIEC","root","s");
	}
	
	
	
	public void addNotice(String content,String sender,String receiver,String approve) throws SQLException{  
		//ID will be a auto-incremented integer
		pst=con.prepareStatement("insert into NOTICE(CONTENT,SENDER,RECEIVER,APPROVE) values(?,?,?,?)");
		pst.setString(1, content);
		pst.setString(2, sender);
		pst.setString(3, receiver);
		pst.setString(4, approve);
		int result=pst.executeUpdate();
		System.out.println(result+" Records Affected.");
	}
	
	public void deleteNotice(String id) throws SQLException{
		pst=con.prepareStatement("delete from NOTICE where ID=?");
		pst.setString(1,id);
		int result=pst.executeUpdate();
		System.out.println(result+" Records Affected.");
	}
	
	public ResultSet showNoticeStudent(student s) throws SQLException{
		pst=con.prepareStatement("select * from NOTICE where (receiver=? or receiver=? or receiver=? or receiver=?) and approve=1");
		pst.setString(1,s.s_branch);
		pst.setString(2,s.s_section);
		pst.setString(3,"all");
		pst.setString(4,s.s_roll);
		ResultSet rs=pst.executeQuery();
		return rs;
		}
	
	public ResultSet showNoticeTeacher(teacher t) throws SQLException{
		pst=con.prepareStatement("select * from NOTICE where (receiver=? or receiver=? or receiver=?) and approve=1");
		pst.setString(1,t.t_branch);
		pst.setString(2,"all");
		pst.setString(3,t.t_id);
		ResultSet rs=pst.executeQuery();
		return rs;
		}
	
	
	public void approveNotice(String id) throws SQLException{
		pst=con.prepareStatement("update NOTICE set approve=1 where ID=?");
		pst.setString(1, id);
		int result=pst.executeUpdate();
		System.out.println(result+" Records Affected.");
	}
	
	
}
