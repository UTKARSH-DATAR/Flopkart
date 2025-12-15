package service;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

import java.io.IOException;

import database.*;

@WebServlet("/UpdateProduct")
public class UpdateProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int id = Integer.parseInt(request.getParameter("productId"));
		String name = request.getParameter("productName");
		String description = request.getParameter("productDescription");
		Double price = Double.parseDouble(request.getParameter("price"));
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		
		String imagePath = (String) request.getAttribute("imagePath");
		if(imagePath == null || imagePath.isEmpty()) 
		{
		    imagePath = request.getParameter("existingImage");
		}
		
		Product product = new Product(id,name, description, price, quantity, imagePath);
		
		DataAccess dao = new DatabaseConnect();
		RequestDispatcher rd = request.getRequestDispatcher("alertRedirect.jsp");
		request.setAttribute("target", "ViewProducts");
		String msg = "";
		
		if(dao.updateProduct(product))
		{
			msg = "Product updated successfully";
		}
		else
		{
			msg = "Product updating failed";
		}
		
		request.setAttribute("msg", msg);
		rd.forward(request, response);
		
	}

}
