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
 * Servlet implementation class deleteProduct
 */
@WebServlet("/deleteProduct")
public class deleteProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int product_id = Integer.parseInt(request.getParameter("product_id"));
		String product_name = "";
		DBConnection db = new DBConnection();
		try {
			PreparedStatement psr = db.getStatement("select product_name from products where id =?");
			psr.setInt(1, product_id);
			ResultSet name = psr.executeQuery();
			while(name.next()) {
				product_name = product_name+name.getString(1);
			}
			PreparedStatement ps = db.getStatement("delete from products where id =?");
			ps.setInt(1, product_id);
			int r = ps.executeUpdate();
			if(r>0) {
				HttpSession s = request.getSession();
				s.setAttribute("productDeleteStatus", true);
				s.setAttribute("product_name_from_delete_product",product_name);
				response.sendRedirect("allProducts.jsp");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
