package com.database;

import java.sql.SQLException;

public class notice {
	
	String id,content,sender,type,approve;  //APPROVE--> 0 for FALSE, 1 for TRUE
	  										//TYPE--> branch, all, section, society, friendrequest related
	
	noticeDatabase nd;
	notice() throws ClassNotFoundException, SQLException{
		nd=new noticeDatabase();
	}
	void addNotice(String content,String sender,String type,String approve) throws SQLException{
		nd.addNotice(content, sender, type,approve);
	}

	void removeNotice(String id) throws SQLException{
		nd.deleteNotice(id);
	}
	
	void show(){
		
	}
	
}
