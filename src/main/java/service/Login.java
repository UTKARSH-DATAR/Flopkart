package service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import model.Address;
import model.CartItem;
import model.Order;
import model.User;
import database.*;

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DataAccess dao = new DatabaseConnect();
		String username = request.getParameter("username");
		HttpSession session = request.getSession();
		session.setAttribute("username", username);
		User user = dao.getUser(username);
		session.setAttribute("clientName", user.getName());
		
		if(username.equals("utkarsh_datar"))
		{
			response.sendRedirect("admin.jsp");
		}
		else
		{
//			session.setAttribute("clientContact", user.getContact());
			List<CartItem> cart =  dao.getCartItems(username);
			session.setAttribute("cart", cart);
			List<Address> addresses = dao.getAddresses(username);
			session.setAttribute("addresses", addresses);
			List<Order> orders = dao.getOrdersByUsername(username);
			session.setAttribute("orders", orders);
			response.sendRedirect("home");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
