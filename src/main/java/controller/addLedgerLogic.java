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
@WebServlet("/addLedgerLogic")
public class addLedgerLogic extends HttpServlet {
	private static final long serialVersionUID = 1L;
       protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	  
    	   int shopId 						= Integer.parseInt(request.getParameter("shopId"));
    	   int product_id 					= Integer.parseInt(request.getParameter("product_id"));
    	   double quantity 					= Double.parseDouble(request.getParameter("product_quantity"));
    	   String ledger_add_date 			= request.getParameter("ledger_add_date");
    	   double product_net_price 		= Double.parseDouble(request.getParameter("product_net_price"));
    	   double credit_rupee 				= Double.parseDouble(request.getParameter("credit_rupee"));
    	   double initial_remaining_price   = 0 ;
    	   //gross product price    	   
    	   double gross_prod_price  		= quantity * product_net_price;
    	   double price_after_credit 		= gross_prod_price - credit_rupee;
    	   
    	   String shop_name 				= "";
	   	   DBConnection db 				= new DBConnection();
	   		try {
	   			
	   			PreparedStatement pstatement = db.getStatement("select remaining_balance,shop_name from dealers where id =?");
	   			pstatement.setInt(1, shopId);
	   			ResultSet re_balance = pstatement.executeQuery();
	   			while(re_balance.next()) {
	   				 initial_remaining_price =  initial_remaining_price + re_balance.getDouble(1) ;
	   				 shop_name = shop_name+re_balance.getString(2);
	   			}
	   			double remaining_balance_of_dealer = initial_remaining_price + price_after_credit;
	   			PreparedStatement ps = db.getStatement("insert into ledger(shop_id,product_id,product_quantity,date,product_net_price,product_gross_price,credit_rupee,price_after_credit,initial_remaining_price,remaining_balance) values(?,?,?,?,?,?,?,?,?,?);");
	   			ps.setInt(1, shopId);
	   			ps.setInt(2, product_id);
	   			ps.setDouble(3, quantity);
	   			ps.setString(4, ledger_add_date);
	   			ps.setDouble(5, product_net_price);
	   			ps.setDouble(6, gross_prod_price);
	   			ps.setDouble(7, credit_rupee);
	   			ps.setDouble(8, price_after_credit);
	   			ps.setDouble(9, initial_remaining_price);
	   			ps.setDouble(10, remaining_balance_of_dealer);
	   			int rs = ps.executeUpdate();
	   			PreparedStatement psd = db.getStatement("update dealers set remaining_balance=? where id = ?");
	   			psd.setDouble(1, remaining_balance_of_dealer);
	   			psd.setInt(2, shopId);
	   			int rsd = psd.executeUpdate();
	   			if(rs > 0 && rsd >0) {
	   				HttpSession s = request.getSession();
	   				s.setAttribute("messageForInsertLedger", true);
	   				s.setAttribute("shop_name", shop_name);
	   				response.sendRedirect("addLedgerForm.jsp");
	   			}
	   			else {
	   				HttpSession s = request.getSession();
	   				s.setAttribute("messageForInsertLedger", false);
	   				response.sendRedirect("addLedgerForm.jsp");
	   			}
	   		} catch (Exception e) {
	   			System.out.println(e.getMessage());
	   		}
	}

}
