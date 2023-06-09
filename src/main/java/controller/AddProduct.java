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
 * Servlet implementation class AddProduct
 */
@WebServlet("/AddProduct")
public class AddProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String product_name 	= request.getParameter("productNameAddProduct");
		double product_quantity = Double.parseDouble(request.getParameter("productQuantityInAddProduct"));
		DBConnection db = new DBConnection();
		try {
			PreparedStatement ps = db.getStatement("insert into products(product_name,product_quantity) values(?,?)");
			ps.setString(1, product_name);
			ps.setDouble(2, product_quantity);
			int insertStatus = ps.executeUpdate();
			System.out.println(insertStatus);
			if(insertStatus >0) {
				request.setAttribute("insertProductStatus", "success");
				request.setAttribute("product_name", product_name);
				ps.close();
				RequestDispatcher rd = request.getRequestDispatcher("addProductInStock.jsp");
				rd.forward(request, response); 
				
			}
			
		} catch (Exception e) {
			request.setAttribute("insertProductStatus", "failed");
			request.setAttribute("product_name", product_name);
			
			RequestDispatcher rdisp = request.getRequestDispatcher("addProductInStock.jsp");
			rdisp.forward(request, response);
		}
	}

}
