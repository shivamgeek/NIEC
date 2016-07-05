package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.database.*;
import com.entity.*;


@WebServlet("/insertChatRoom")
public class insertChatRoom extends HttpServlet {
	private static final long serialVersionUID = 1L;

	String hex;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		try{
		
		HttpSession s=request.getSession(false);
		studentDatabase sd=new studentDatabase();
		chatRoomDatabase cd=new chatRoomDatabase();
		decodingStudent ds=new decodingStudent();
		response.setContentType("text/html");
		String h=request.getParameter("h");
		if(h.equals("member")){
			 hex=request.getParameter("mlist");
			
			 s.setAttribute("hex",hex);
			 if(hex.length()>4){
				 request.setAttribute("group","true");
				 RequestDispatcher rd=request.getRequestDispatcher("insertChatRoom.jsp");
				 rd.include(request, response);
			 }
			 else {
				 String member=ds.rollToHex(s.getAttribute("id").toString())+hex;
				 ResultSet rs=sd.fetchAll(ds.hexToRoll(hex),ds.branchName(ds.findBranchFromRoll(ds.hexToRoll(hex))));
				 cd.addChat(member,rs.getString("S_NAME"));
			 }
			
		}else{
			String member=ds.rollToHex(s.getAttribute("id").toString())+hex;
			String name=request.getParameter("gname");
			cd.addChat(member,name);
			
		}
		
		}catch(Exception e){
			PrintWriter p=response.getWriter();
			p.println("Some error occured in getting data");
			e.printStackTrace();
		}
		
		
		
		
		
		
	}

}
