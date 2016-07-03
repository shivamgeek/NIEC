package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.studentDatabase;
import com.entity.student;

/**
 * Servlet implementation class login
 */
@WebServlet("/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	studentDatabase sd;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter p=response.getWriter();
		try {
			response.setContentType("text/html");
			sd=new studentDatabase();
			
			RequestDispatcher rd=request.getRequestDispatcher("studentProfile.jsp");
			String roll=request.getParameter("roll");
			String pass=request.getParameter("pass");
			if(sd.loginStudent(roll, pass)){
				rd.forward(request, response);
			}
				p.println("Invalid Roll or Password");
				RequestDispatcher rd1=request.getRequestDispatcher("login.jsp");
				rd1.include(request, response);
				
		} catch (Exception e) {
			p.println("Invalid Roll or Password");
			e.printStackTrace();
		} 
		

		
		
		
		
		
	}

}
