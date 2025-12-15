package service;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import database.*;

@WebServlet("/DeleteProduct")
public class DeleteProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int productId = Integer.parseInt(request.getParameter("productId"));
		
		DataAccess dao = new DatabaseConnect();
		
		RequestDispatcher rd = request.getRequestDispatcher("alertRedirect.jsp");
		request.setAttribute("target", "ViewProducts");
		
		String msg = "";
		if(dao.deleteProduct(productId))
		{
			msg = "Product deleted successfully";
		}
		else
		{
			msg = "Product deletion failed";
		}
		request.setAttribute("msg", msg);
		
		rd.forward(request, response);
	}

}
