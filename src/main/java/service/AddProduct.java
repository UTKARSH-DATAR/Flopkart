package service;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import model.Product;
import database.*;

@WebServlet("/AddProduct")
public class AddProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		
		
		String productName = request.getParameter("productName");
		String productDescription = request.getParameter("productDescription");
		Double productPrice = Double.parseDouble(request.getParameter("price"));
		int productQuantity = Integer.parseInt(request.getParameter("quantity"));	
		String imagePath = (String) request.getAttribute("imagePath");
		
		Product product = new Product(productName, productDescription, productPrice, productQuantity, imagePath);
		DataAccess dao = new DatabaseConnect();
		// Forward to alertRedirect.jsp instead of admin.jsp
		RequestDispatcher rd = request.getRequestDispatcher("alertRedirect.jsp");
		request.setAttribute("target", "admin.jsp");
		
		if(dao.addProduct(product))
		{
			request.setAttribute("msg", "Product added successfully");
		}
		else
		{
			request.setAttribute("msg", "Product adding failed");
		}
		
		rd.forward(request, response);
	}
}