package service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;
import java.util.List;

import database.DataAccess;
import database.DatabaseConnect;

@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String name = request.getParameter("name");
		String contact = request.getParameter("contact");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		DataAccess dao = new DatabaseConnect();
		List<User> users = dao.getAllUsers();
		for(User user : users)
		{
			if(user.getUsername().equals(username))
			{
				String msg = "Username already exists. Please choose a different username.";
				request.setAttribute("msg", msg);
				request.setAttribute("target", "register.jsp");
				request.getRequestDispatcher("alertRedirect.jsp").forward(request, response);
				return;
			}
		}
		dao.addUser(new User(name, contact, username, password));
		
		HttpSession session = request.getSession();
		session.setAttribute("username", username);
		User user = dao.getUser(username);
		session.setAttribute("clientName", user.getName());
		response.sendRedirect("home");
	}

}
