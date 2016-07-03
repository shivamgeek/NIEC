package com.servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.noticeDatabase;
import com.database.societyDatabase;

/**
 * Servlet implementation class insertNotice
 */
@WebServlet("/insertNotice")
public class insertNotice extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		noticeDatabase nd;
		Enumeration<String> e12=request.getParameterNames(); //TO FIND THE LENGTH OF PARAMETERS DYANAMICALLY
		String radio=request.getParameter("choice");
		String roll=request.getParameter("id");
		Enumeration<String> e=request.getParameterNames();
		
		int length=0;
		while(e12.hasMoreElements()){
		length++;
			System.out.println(	e12.nextElement());
		}
		System.out.println(length);
		String values[]=new String[length];
		for(int i=0;i<length;i++){
			values[i]=request.getParameter(e.nextElement());
			}
		try {
			nd=new noticeDatabase();
			if(radio.equals("insert")){
				nd.addNotice(values[1],values[2],values[3],values[4]);
			}
			else if(radio.equals("delete")){
				nd.deleteNotice(values[0]);
			}
			else if(radio.equals("approve")){
			nd.approveNotice(values[0]);
			}
		}
		 catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		};
	}
	
	}

	
	


