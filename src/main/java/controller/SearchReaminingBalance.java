package controller;
import DB.*;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class SearchReaminingBalance
 */
@WebServlet("/SearchReaminingBalance")
public class SearchReaminingBalance extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("shopIdSearchRemainingBalance"));
		DBConnection db = new DBConnection();
		try {
			PreparedStatement ps = db.getStatement("select remaining_balance from dealers WHERE id=?");
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				HttpSession s = request.getSession();
				s.setAttribute("remainingBalance", Double.parseDouble(rs.getString(1)));
				s.setAttribute("shopID", id);
				response.sendRedirect("addLedgerForm.jsp");
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

}
