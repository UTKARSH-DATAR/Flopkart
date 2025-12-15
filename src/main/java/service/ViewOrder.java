package service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Order;
import model.User;

import java.io.IOException;

import database.DataAccess;
import database.DatabaseConnect;

@WebServlet("/ViewOrder")
public class ViewOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DataAccess dao = new DatabaseConnect();
		int orderId;
		boolean newOrder = false;
		if(request.getParameter("orderId")==null)
		{
			orderId = (int) request.getAttribute("orderId");
			newOrder = true;
		}
		else
		{
			orderId = Integer.parseInt(request.getParameter("orderId"));
		}
		Order order = dao.getOrderById(orderId);
		User user = dao.getUser(order.getUsername());
		request.setAttribute("order", order);
		request.setAttribute("user", user);
		request.setAttribute("newOrder", newOrder);
		request.getRequestDispatcher("vieworder.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
