package controller;
import DB.*;
import java.io.IOException;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class updateProductName
 */
@WebServlet("/updateProductName")
public class updateProductName extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("productIDForUpdateProductName"));
		String product_name = request.getParameter("ProductNameForUpdateProductName");
		DBConnection db = new DBConnection();
		try {
			PreparedStatement ps = db.getStatement("update products set product_name=? where id =?");
			ps.setString(1, product_name);
			ps.setInt(2,id );
			int updateStatus = ps.executeUpdate();
			if(updateStatus>0) {
				HttpSession s = request.getSession();
				s.setAttribute("product_name_update_status", true);
				s.setAttribute("product_name_after_name_update", product_name);
				response.sendRedirect("allProducts.jsp");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
