package service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItem;

import java.io.IOException;
import java.util.List;

import business.AvailableQuantity;
import database.DataAccess;
import database.DatabaseConnect;

@WebServlet("/Cart")
public class Cart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		String username = (String) session.getAttribute("username");
		
		if(session == null || username == null)
		{
			response.sendRedirect("login.jsp");
			return;
		}
		
		response.sendRedirect("cart.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
		String username = (session!=null) ? (String) session.getAttribute("username") : null;
		
		if(session == null || username == null)
		{
			response.sendRedirect("login.jsp");
			return;
		}
		
		String action = request.getParameter("action");
		String source = request.getParameter("source");
		int productId = Integer.parseInt(request.getParameter("productId"));
		DataAccess dao = new DatabaseConnect();
		
		if(action.equals("add"))
		{
			if(AvailableQuantity.isAvailable(productId, 1))
			{
				dao.addToCart(username, productId, 1);
				List<CartItem> cart =  dao.getCartItems(username);
				session.setAttribute("cart", cart);
			}
			response.sendRedirect(source);
		}
		
		else if(action.equals("remove"))
		{
			dao.removeFromCart(username, productId);
			List<CartItem> cart =  dao.getCartItems(username);
			session.setAttribute("cart", cart);
			response.sendRedirect(source);
		}
		
		else if(action.equals("increase"))
		{
			dao.updateCartItemQuantity(username, productId, +1);
			List<CartItem> cart =  dao.getCartItems(username);
			session.setAttribute("cart", cart);
			response.sendRedirect(source);
		}
		
		else if(action.equals("decrease"))
		{
			dao.updateCartItemQuantity(username, productId, -1);
			List<CartItem> cart =  dao.getCartItems(username);
			session.setAttribute("cart", cart);
			response.sendRedirect(source);
		}
	}

}
