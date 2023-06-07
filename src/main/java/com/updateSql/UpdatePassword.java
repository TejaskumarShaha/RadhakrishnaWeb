package com.updateSql;

import java.io.IOException;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DB.*;
/**
 * Servlet implementation class UpdatePassword
 */
@WebServlet("/UpdatePassword")
public class UpdatePassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("customer_id"));
		String pass = request.getParameter("new_password");
		DBConnection db = new DBConnection();
		HttpSession session = request.getSession();
		boolean is_admin = (boolean)session.getAttribute("is_admin");
		if(is_admin)
		{
			try {
				PreparedStatement ps = db.getStatement("UPDATE admins SET password=? WHERE id=?");
				ps.setString(1, pass);
				ps.setInt(2, id);
				ps.execute();
				ps.close();
				HttpSession s = request.getSession();
				s.setAttribute("passwordUpdateStatus", true);
				s.setAttribute("passwordUpdateId", id);
				response.sendRedirect("adminPanel.jsp");
			} catch (Exception e) {
				
			}	
		}else {
			try {
				PreparedStatement ps = db.getStatement("UPDATE operators SET password=? WHERE id=?");
				ps.setString(1, pass);
				ps.setInt(2, id);
				ps.execute();
				ps.close();
				HttpSession s = request.getSession();
				s.setAttribute("passwordUpdateStatus", true);
				s.setAttribute("passwordUpdateId", id);
				response.sendRedirect("operatorPanel.jsp");
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}	
		}

	}
}  
