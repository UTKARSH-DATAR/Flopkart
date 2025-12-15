package service;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Address;
import model.CartItem;
import model.Order;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import business.OrderOperation;
import database.*;

@WebServlet("/Order")
public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DataAccess dao = new DatabaseConnect();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			List<Order> orders = dao.getAllOrders();
			request.setAttribute("orders", orders);
			RequestDispatcher rd = request.getRequestDispatcher("viewallorders.jsp");
			rd.forward(request, response);
		}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action = (String) request.getParameter("action");
		HttpSession session = request.getSession(false);
		String username = (String) session.getAttribute("username");
		
		if(action.equals("placeOrder"))
		{
			String orderNumber = OrderOperation.generateOrderNumber();
			List<CartItem> cart =  (List<CartItem>) session.getAttribute("cart");
			Address address = (Address) session.getAttribute("selectedAddress");
			String cardNumber = request.getParameter("cardNumber");
			Double totalAmount = OrderOperation.calculateTotalAmount(cart);
			LocalDate date = LocalDate.now();
			
			Order order = new Order(orderNumber, username, cart, address, cardNumber, totalAmount, date);
			int orderId = dao.placeOrder(order);
			OrderOperation.updateProductQuantity(cart);
			dao.emptyCart(username);
			session.setAttribute("cart", dao.getCartItems(username));
			session.setAttribute("orders", dao.getOrdersByUsername(username));
			request.setAttribute("orderId", orderId);
			request.getRequestDispatcher("ViewOrder").forward(request, response);
		}
		else if(action.equals("update"))
		{
			int orderId = Integer.parseInt(request.getParameter("orderId"));
			String status = request.getParameter("status");
			if(status.equals("Cancelled"))
			{
				List<CartItem> orderItems = dao.getOrderItems(orderId);
				OrderOperation.restockCancelledOrder(orderItems);
			}
			dao.updateOrderStatus(orderId, status);
			session.setAttribute("orders", dao.getOrdersByUsername(username));

			String source = request.getParameter("source");
			if(source==null)
			{
				response.sendRedirect("Order");
			}
			else
			{
				response.sendRedirect(source);
			}
		}

	}

}
