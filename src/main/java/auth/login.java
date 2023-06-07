package auth;
import DB.*;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		int id 	= Integer.parseInt(request.getParameter("id"));
		String password = request.getParameter("password");
		String is_operator 	= request.getParameter("is_operator");
			if(is_operator!=null){
				try {
					DBConnection c = new DBConnection();
					PreparedStatement ps = c.getStatement("select * from operators where id=? and password =?");
					ps.setInt(1, id);
					ps.setString(2, password);
					ResultSet r  = ps.executeQuery();
					if(r.next()) {
						HttpSession s = request.getSession();
						s.setAttribute("id", r.getInt(1));
						s.setAttribute("name", r.getString(2));
						s.setAttribute("is_admin", r.getBoolean(7));
						s.setAttribute("loggedIn", true);
						s.setAttribute("message", null);
						response.sendRedirect("operatorPanel.jsp");
					}
					else {
						HttpSession s = request.getSession();
						s.setAttribute("message", "Oops! please check your credentials");
						s.setAttribute("mobilenumberforFailAttempt", id);
						response.sendRedirect("login.jsp");
					}
				}catch(Exception e) {System.out.println(e.getMessage());
					}
				}else{
					try {
						DBConnection c = new DBConnection();
						PreparedStatement ps = c.getStatement("select * from admins where id=? and password =?");
						ps.setInt(1, id);
						ps.setString(2, password);
						ResultSet r  = ps.executeQuery();
						if(r.next()) {
							HttpSession s = request.getSession();
							s.setAttribute("id", r.getString(1));
							s.setAttribute("name", r.getString(2));
							s.setAttribute("is_admin", r.getBoolean(5));
							s.setAttribute("loggedIn", true);
							s.setAttribute("message", null);
							response.sendRedirect("adminPanel.jsp");
						}else {
							HttpSession s = request.getSession();
							s.setAttribute("message", "Oops! please check your credentials");
							s.setAttribute("mobilenumberforFailAttempt", id);
							response.sendRedirect("login.jsp");
							}
						}catch(Exception e) {System.out.println(e.getMessage());
					}
				}
		}
}
