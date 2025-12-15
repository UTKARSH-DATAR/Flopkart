package service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Address;

import java.io.IOException;
import database.*;

@WebServlet("/Address")
public class AddressServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DataAccess dao = new DatabaseConnect();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String target = request.getParameter("target");
		HttpSession session = request.getSession(false);
		
		String username = (String) session.getAttribute("username");
		if(session == null || username == null)
		{
			response.sendRedirect("login.jsp");
			return;
		}

		if(target==null)
		{
			response.sendRedirect("addresses.jsp");
		}
		else
		{
			response.sendRedirect(target);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String source = request.getParameter("source");
		HttpSession session = request.getSession(false);
		String username = (String) session.getAttribute("username");
		String action = request.getParameter("action");
		
		if(action.equals("add"))
		{
			String line1 = request.getParameter("line1");
			String line2 = request.getParameter("line2");
			String city = request.getParameter("city");
			String state = request.getParameter("state");
			int pincode = Integer.parseInt(request.getParameter("pincode"));
			Address address = new Address(line1, line2, city, state, pincode);
			
			dao.addAddress(username, address);
			session.setAttribute("addresses", dao.getAddresses(username));
			String msg = "Address added successfully.";
			request.setAttribute("msg", msg);
			request.setAttribute("target", "Address?target="+source);
			request.getRequestDispatcher("alertRedirect.jsp").forward(request, response);
			
		}
		else if(action.equals("select"))
		{
			int id = Integer.parseInt(request.getParameter("addressId"));
			Address address = dao.getAddressById(id);
			session.setAttribute("selectedAddress", address);
			response.sendRedirect("payment.jsp");
		}
		else if(action.equals("update"))
		{
			int id = Integer.parseInt(request.getParameter("addressId"));
			String line1 = request.getParameter("line1");
			String line2 = request.getParameter("line2");
			String city = request.getParameter("city");
			String state = request.getParameter("state");
			int pincode = Integer.parseInt(request.getParameter("pincode"));
			Address address = new Address(line1, line2, city, state, pincode);
			
			dao.editAddress(id, address);
			session.setAttribute("addresses", dao.getAddresses(username));
			String msg = "Changes saved successfully.";
			request.setAttribute("msg", msg);
			request.setAttribute("target", "Address");
			request.getRequestDispatcher("alertRedirect.jsp").forward(request, response);
		}
		else if(action.equals("edit"))
		{
			int id =  Integer.parseInt(request.getParameter("addressId"));
			Address address = dao.getAddressById(id);
			request.setAttribute("address", address);
			request.getRequestDispatcher("editaddress.jsp").forward(request, response);
		}
		else if(action.equals("delete"))
		{
			int id =  Integer.parseInt(request.getParameter("addressId"));
			dao.deleteAddress(id);
			session.setAttribute("addresses", dao.getAddresses(username));
			response.sendRedirect("Address");
		}
	}

}
