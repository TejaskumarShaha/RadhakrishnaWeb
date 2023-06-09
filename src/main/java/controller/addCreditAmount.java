package controller;
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

/**
 * Servlet implementation class addCreditAmount
 */
@WebServlet("/addCreditAmount")
public class addCreditAmount extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int    shop_id 	 = Integer.parseInt(request.getParameter("shop_name_in_credit_amount"));
		double credit_amount = Double.parseDouble(request.getParameter("creditAmount"));
		String creditor_name = request.getParameter("CreditorName");
		String credit_date 	 = request.getParameter("creditAddDate");
		String shop_name_for_Success = "";
		DBConnection db = new DBConnection();
		double remaining_balance = 0;
		
		try {
			
//			extracting remaining balance of dealer
			PreparedStatement ps = db.getStatement("select remaining_balance,shop_name from dealers where id =?");
			ps.setInt(1, shop_id);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				remaining_balance = remaining_balance + rs.getDouble(1);
				shop_name_for_Success = shop_name_for_Success + rs.getString(2);
				
			}
			if(remaining_balance > credit_amount || remaining_balance  == credit_amount) {
				remaining_balance = remaining_balance - credit_amount; 
				// update dealers remaining balance
				PreparedStatement psu = db.getStatement("update dealers set remaining_balance = ? where id = ?");
				psu.setDouble(1, remaining_balance);
				psu.setInt(2, shop_id);
				int updateRemainingBalance = psu.executeUpdate();
				if(updateRemainingBalance > 0) {
					PreparedStatement CreditRemainingBalance = db.getStatement("insert into CreditRemainingBalance(shop_id,credit_amount,credit_date,creditor_name) values(?,?,?,?)");
					CreditRemainingBalance.setInt(1, shop_id);
					CreditRemainingBalance.setDouble(2, credit_amount);
					CreditRemainingBalance.setString(3, credit_date);
					CreditRemainingBalance.setString(4, creditor_name);
					int insertintocredit = CreditRemainingBalance.executeUpdate();
					System.out.println("inserted into credt"+insertintocredit);
					request.setAttribute("creditAddStatus", "success");
					request.setAttribute("shop_name_for_Dealer", shop_name_for_Success);
					request.setAttribute("remaining_balance_ater_update", remaining_balance);
					RequestDispatcher reqDisp = request.getRequestDispatcher("creditAmountForDealer.jsp");
					reqDisp.forward(request, response);
					
				}
				
			}else {
				request.setAttribute("creditAddStatus", "failed");
				request.setAttribute("shop_name_for_Dealer", shop_name_for_Success);
				request.setAttribute("remaining_balance_ater_update", remaining_balance);
				RequestDispatcher reqDisp = request.getRequestDispatcher("creditAmountForDealer.jsp");
				reqDisp.forward(request, response);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
