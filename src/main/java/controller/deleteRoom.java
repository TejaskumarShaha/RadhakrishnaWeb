package controller;
import DB.*;
import java.io.IOException;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class deleteRoom
 */
@WebServlet("/deleteRoom")
public class deleteRoom extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		int id = Integer.parseInt(request.getParameter("id"));
		DBConnection db = new DBConnection();
		try {
			PreparedStatement ps = db.getStatement("delete from stockroom where id =?");
			ps.setInt(1, id);
			int r = ps.executeUpdate();
			if(r>0) {
				request.setAttribute("deleteRoomStatus", true);
				RequestDispatcher rd = request.getRequestDispatcher("stockRoom.jsp");
				rd.forward(request, response);
			}else {
				RequestDispatcher rd = request.getRequestDispatcher("stockRoom.jsp");
				rd.forward(request, response);
				}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
	}

}
