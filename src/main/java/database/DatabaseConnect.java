package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import business.AvailableQuantity;
import model.Address;
import model.CartItem;
import model.Order;
import model.Product;
import model.User;

public class DatabaseConnect implements DataAccess
{
	public static HikariDataSource dataSource;
	Connection con;
	Statement stmt;
	
    static {
    	
//		String url = "jdbc:mysql://localhost:3306/adv_java_project";
//		String username = "root";
//		String password = "Root";
    	
        try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl("jdbc:mysql://flopkart-utkarsh-flopkart.l.aivencloud.com:19875/adv_java_project?sslMode=REQUIRED");
        config.setUsername("avnadmin");
        config.setPassword("AVNS_LJSnsEOiYyhizvVgRsp");
        
        config.setMaximumPoolSize(3);
        config.setMinimumIdle(2);
        config.setIdleTimeout(30000);
        config.setMaxLifetime(1800000);
        
        dataSource = new HikariDataSource(config);
        } catch (ClassNotFoundException e) {
        	 throw new RuntimeException("MySQL driver not found", e);
        }
    }
    
	
	private void connect() throws ClassNotFoundException, SQLException
	{
		
			if(con==null || con.isClosed())
			{
			con = dataSource.getConnection();
			stmt = con.createStatement();
			}
			
	}//connect
	
	private void disconnect() throws SQLException
	{
			if(con!=null)
			{
			con.close();
			}
	}//disconnect

	@Override
	public void addUser(User user) 
	{
		try 
		{
			connect();
				String query = "insert into users values (?,?,?,?)";
				PreparedStatement pstmt = con.prepareStatement(query);
				pstmt.setString(1, user.getUsername());
				pstmt.setString(2, user.getPassword());
				pstmt.setString(3, user.getName());
				pstmt.setString(4, user.getContact());
				pstmt.executeUpdate();
		        pstmt.close();
			disconnect();
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
	}
	
	public User getUser(String username)
	{
		User user = null;
		try 
		{
			connect();
				String query = "select * from users where username=?";
				PreparedStatement ptsmt = con.prepareStatement(query);
				ptsmt.setString(1, username);
				ResultSet rs = ptsmt.executeQuery();
				
				if(rs.next())
				{
					user = new User(rs.getString("name"), rs.getString("contact_no"), username, rs.getString("password"));
				}
				
				rs.close();
				ptsmt.close();
			disconnect();
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return user;
	}
	
	@Override
	public List<User> getAllUsers() 
	{
		List<User> users = new ArrayList<User>();
		try 
		{
			connect();
				String query = "select * from users";
				PreparedStatement pstmt = con.prepareStatement(query);
		        ResultSet rs = pstmt.executeQuery();
		        
		        while(rs.next())
		        {
		        	String username = rs.getString("username");
		        	String password = rs.getString("password");
		        	String name = rs.getString("name");
		        	String contact = rs.getString("contact_no");
		        	
		        	User user = new User(name, contact, username, password);
		        	users.add(user);
		        }
		        rs.close();
		        pstmt.close();
			disconnect();
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return users;
	}

	@Override
	public boolean validate(String username, String password) 
	{
		boolean isValid = false;
		try 
		{
			connect();
				String query = "select * from users where username=? and password=?";
				PreparedStatement pstmt = con.prepareStatement(query);
				pstmt.setString(1, username);
				pstmt.setString(2, password);
		        ResultSet rs = pstmt.executeQuery();
		        if (rs.next()) {
		            isValid = true;
		        }
		        rs.close();
		        pstmt.close();
			disconnect();
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return isValid;
	}

	@Override
	public boolean addProduct(Product product) 
	{
		try 
		{
			connect();
				String query = "insert into products (name, description, price, quantity, url) values (?,?,?,?,?)";
				PreparedStatement pstmt = con.prepareStatement(query);
				pstmt.setString(1, product.getName());
				pstmt.setString(2, product.getDescription());
				pstmt.setDouble(3, product.getPrice());
				pstmt.setInt(4, product.getQuantity());
				pstmt.setString(5, product.getImgurl());
				int rows = pstmt.executeUpdate();
		        pstmt.close();
			disconnect();
			
			if(rows>0) return true;
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public List<Product> getAllProducts() 
	{
		List<Product> products = new ArrayList<Product>();
		try 
		{
			connect();
				String query = "select * from products where status='Active'";
				PreparedStatement pstmt = con.prepareStatement(query);
		        ResultSet rs = pstmt.executeQuery();
		        
		        while(rs.next())
		        {
		        	int id = rs.getInt("p_id");
		        	String name = rs.getString("name");
		        	String description = rs.getString("description");
		        	double price = rs.getDouble("price");
		        	int quantity = rs.getInt("quantity");
		        	String url = rs.getString("url");
		        	
		        	Product product = new Product(id,name, description, price, quantity, url);
		        	products.add(product);
		        }
		        rs.close();
		        pstmt.close();
			disconnect();
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return products;
	}

	@Override
	public Product getProductById(int id) 
	{
		Product product = null;
		try 
		{
			connect();
				String query = "select * from products where p_id=?";
				PreparedStatement pstmt = con.prepareStatement(query);
				pstmt.setInt(1, id);
		        ResultSet rs = pstmt.executeQuery();
		        
		        if(rs.next())
		        {
		        	String name = rs.getString("name");
		        	String description = rs.getString("description");
		        	double price = rs.getDouble("price");
		        	int quantity = rs.getInt("quantity");
		        	String url = rs.getString("url");
		        	
		        	product = new Product(id,name, description, price, quantity, url);
		        }
		        rs.close();
		        pstmt.close();
			disconnect();
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return product;
	}

	@Override
	public boolean updateProduct(Product product) 
	{
		try 
		{
			connect();
				String query = "update products set name=?, description=?, price=?, quantity=?, url=? where p_id=?";
				PreparedStatement pstmt = con.prepareStatement(query);
				pstmt.setString(1, product.getName());
				pstmt.setString(2, product.getDescription());
				pstmt.setDouble(3, product.getPrice());
				pstmt.setInt(4, product.getQuantity());
				pstmt.setString(5, product.getImgurl());
				pstmt.setInt(6, product.getId());
				int rows = pstmt.executeUpdate();
		        pstmt.close();
			disconnect();
			
			if(rows>0) return true;
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean deleteProduct(int id) 
	{
		try 
		{
			connect();
				String query = "update products set status='Deleted',quantity=0 where p_id=?";
				PreparedStatement pstmt = con.prepareStatement(query);
				pstmt.setInt(1, id);
				int rows = pstmt.executeUpdate();
		        pstmt.close();
			disconnect();
			
			if(rows>0) return true;
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean addToCart(String username, int productId, int quantity ) 
	{
		try 
		{
			connect();
			   String query = "insert into cart(username,p_id,quantity) values (?,?,?)";
			   PreparedStatement pstmt = con.prepareStatement(query);
			   pstmt.setString(1, username);
			   pstmt.setInt(2, productId);
			   pstmt.setInt(3, quantity);
			   int rows = pstmt.executeUpdate();
		       pstmt.close();
		       
		       if(rows>0) 
		       {return true;}
			disconnect();
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean removeFromCart(String username, int productId) 
	{
        try 
		{
			connect();
				String query = "delete from cart where username=? and p_id=?";
				PreparedStatement pstmt = con.prepareStatement(query);
				pstmt.setString(1, username);
				pstmt.setInt(2, productId);
				int rows = pstmt.executeUpdate();
		        pstmt.close();
			disconnect();
			
			if(rows>0) return true;
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public List<CartItem> getCartItems(String username) 
	{
		List<CartItem> cart = new ArrayList<CartItem>();
		try 
		{
			connect();
				String query = "select p.*, c.quantity as 'item_quantity' from products p join cart c on p.p_id=c.p_id where c.username=?";
				PreparedStatement pstmt = con.prepareStatement(query);
				pstmt.setString(1, username);
		        ResultSet rs = pstmt.executeQuery();
		        
		        while(rs.next())
		        {
		        	int p_id = rs.getInt("p_id");
		        	String p_name = rs.getString("name");
		        	String p_desc = rs.getString("description");
		        	double p_price = rs.getDouble("price");
		        	String p_url = rs.getString("url");
		        	int quantity = rs.getInt("quantity");
		        	int itemQuantity = rs.getInt("item_quantity");
		        	
		        	Product product = new Product(p_id, p_name, p_desc, p_price, quantity, p_url);
		        	CartItem item = new CartItem(product, itemQuantity);
		        	cart.add(item);
		        }
		        rs.close();
		        pstmt.close();
			disconnect();
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return cart;
	}

	@Override
	public boolean updateCartItemQuantity(String username, int productId, int quantity) 
	{
		try 
		{
			connect();
				String query = "select * from cart where username=? and p_id=?";
				PreparedStatement pstmt = con.prepareStatement(query);
				pstmt.setString(1, username);
				pstmt.setInt(2, productId);
		        ResultSet rs = pstmt.executeQuery();
		        
        		int rows = 0;
		        if(rs.next())
		        {
		        	int currentQty = rs.getInt("quantity");
		        	int newQty = currentQty + quantity;

		        	if(newQty<=0)
		        	{
		        		return removeFromCart(username, productId);
		        	}
		        	else
		        	{
		        		if(AvailableQuantity.isAvailable(productId, newQty))
		        		{
		        			connect();
		        			String updateQuery = "update cart set quantity=? where username=? and p_id=?";
		        			PreparedStatement updatePstmt = con.prepareStatement(updateQuery);
		        			updatePstmt.setInt(1, newQty);
		        			updatePstmt.setString(2, username);
		        			updatePstmt.setInt(3, productId);
		        			rows = updatePstmt.executeUpdate();
		        			updatePstmt.close();
		        		}
		        	}

		          }
			      rs.close();
			      pstmt.close();
			      disconnect();
			      if(rows>0) return true;
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean emptyCart(String username)
	{
		try 
		{
			connect();
				String query = "delete from cart where username=?";
				PreparedStatement pstmt = con.prepareStatement(query);
				pstmt.setString(1, username);
				int rows = pstmt.executeUpdate();
		        pstmt.close();
			disconnect();
			
			if(rows>0) return true;
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean addAddress(String username, Address address) 
	{
		try 
		{
			connect();
				String query = "insert into addresses (username, line_1, line_2, city, state, pincode) values (?,?,?,?,?,?)";
				PreparedStatement pstmt = con.prepareStatement(query);
				pstmt.setString(1, username);
				pstmt.setString(2, address.getLine1());
				pstmt.setString(3, address.getLine2());
				pstmt.setString(4, address.getCity());
				pstmt.setString(5, address.getState());
				pstmt.setInt(6, address.getPincode());
				int rows = pstmt.executeUpdate();
		        pstmt.close();
			disconnect();
			
			if(rows>0) return true;
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return false;
	 }

	@Override
	public List<Address> getAddresses(String username) 
	{
		List<Address> addresses = new ArrayList<Address>();
		try 
		{
			connect();
				String query = "select * from addresses where username=?";
				PreparedStatement pstmt = con.prepareStatement(query);
				pstmt.setString(1, username);
		        ResultSet rs = pstmt.executeQuery();
		        
		        while(rs.next())
		        {
		        	int addressId = rs.getInt("a_id");
		        	String line1 = rs.getString("line_1");
		        	String line2 = rs.getString("line_2");
		        	String city = rs.getString("city");
		        	String state = rs.getString("state");
		        	int pincode = rs.getInt("pincode");
		        	
		        	Address address = new Address(addressId, line1, line2, city, state, pincode);
		        	addresses.add(address);
		        }
		        rs.close();
		        pstmt.close();
			disconnect();
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return addresses;
	}

	@Override
	public Address getAddressById(int addressId) 
	{
		Address address = null;
		try 
		{
			connect();
				String query = "select * from addresses where a_id=?";
				PreparedStatement pstmt = con.prepareStatement(query);
				pstmt.setInt(1, addressId);
		        ResultSet rs = pstmt.executeQuery();
		        
		        if(rs.next())
		        {
		        	String line1 = rs.getString("line_1");
		        	String line2 = rs.getString("line_2");
		        	String city = rs.getString("city");
		        	String state = rs.getString("state");
		        	int pincode = rs.getInt("pincode");
		        	
		        	address = new Address(addressId, line1, line2, city, state, pincode);
		        }
		        rs.close();
		        pstmt.close();
			disconnect();
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return address;
	}

	@Override
	public boolean deleteAddress(int addressId) 
	{
		try 
		{
			connect();
				String query = "delete from addresses where a_id=?";
				PreparedStatement pstmt = con.prepareStatement(query);
				pstmt.setInt(1, addressId);
				int rows = pstmt.executeUpdate();
		        pstmt.close();
			disconnect();
			
			if(rows>0) return true;
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean editAddress(int addressId, Address address) 
	{
		try 
		{
			connect();
				String query = "update addresses set line_1=?, line_2=?, city=?, state=?, pincode=? where a_id=?";
				PreparedStatement pstmt = con.prepareStatement(query);
				pstmt.setString(1, address.getLine1());
				pstmt.setString(2, address.getLine2());
				pstmt.setString(3, address.getCity());
				pstmt.setString(4, address.getState());
				pstmt.setInt(5, address.getPincode());
				pstmt.setInt(6, addressId);
				int rows = pstmt.executeUpdate();
		        pstmt.close();
			disconnect();
			
			if(rows>0) return true;
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return false;

	}

	@Override
	public int placeOrder(Order order)
	{
		int orderId = 0;
		try {
			connect();
			con.setAutoCommit(false);
			String insertOrderQuery = "insert into orders (o_number, username, a_id, card_no, amount, o_date) values (?,?,?,?,?,?)";
			PreparedStatement pstmt = con.prepareStatement(insertOrderQuery, Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, order.getOrderNumber());
			pstmt.setString(2, order.getUsername());
			pstmt.setInt(3, order.getAddress().getId());
			pstmt.setString(4, order.getCardNumber());
			pstmt.setDouble(5, order.getTotalAmount());
			pstmt.setDate(6, Date.valueOf(order.getOrderDate()));
			pstmt.executeUpdate();
			
			ResultSet generatedKeys = pstmt.getGeneratedKeys();
			if (generatedKeys.next()) 
			{
			    orderId = generatedKeys.getInt(1);
			}
			generatedKeys.close();
			pstmt.close();
			
			String insertOrderItemQuery = "insert into order_items (o_id, p_id, price, quantity) values (?,?,?,?)";
			PreparedStatement itemPs = con.prepareStatement(insertOrderItemQuery);
			for(CartItem item : order.getItems())
			{
				itemPs.setInt(1, orderId);
			    itemPs.setInt(2, item.getProduct().getId());
			    itemPs.setDouble(3, item.getProduct().getPrice());
			    itemPs.setInt(4, item.getQuantity());
			    itemPs.addBatch();
			}
			itemPs.executeBatch();
			itemPs.close();
		    con.commit();
		} catch (Exception e) {
		    try {
				con.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		    e.printStackTrace();
		} finally {
		    try {
				con.setAutoCommit(true);
				disconnect();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return orderId;
	}

	@Override
	public List<Order> getOrdersByUsername(String username) 
	{
		DataAccess dao = new DatabaseConnect();
		List<Order> orders = new ArrayList<Order>();
		try 
		{
			connect();
				String query = "select * from orders where username=? order by o_id desc;";
				PreparedStatement pstmt = con.prepareStatement(query);
				pstmt.setString(1, username);
		        ResultSet rst = pstmt.executeQuery();
		        
		        while(rst.next())
		        {
		        	int id = rst.getInt("o_id");
		        	String orderNumber = rst.getString("o_number");
		        	int addressId = rst.getInt("a_id");
		        	String cardNumber = rst.getString("card_no");
		        	double totalAmount = rst.getDouble("amount");
		        	Date orderDate = rst.getDate("o_date");
		        	String status = rst.getString("status");
		        	
		        	Address address = dao.getAddressById(addressId);
		        	List<CartItem> items = dao.getOrderItems(id);
		        	Order order = new Order(id, orderNumber,  username, items, address, cardNumber, totalAmount, orderDate.toLocalDate(), status);
		        	orders.add(order);
		        }
		        rst.close();
		        pstmt.close();
			disconnect();
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return orders;
		
	}

	@Override
	public Order getOrderById(int orderId) 
	{
		DataAccess dao = new DatabaseConnect();
		Order order = null;
		try 
		{
			connect();
				String query = "select * from orders where o_id=?";
				PreparedStatement pstmt = con.prepareStatement(query);
				pstmt.setInt(1, orderId);
		        ResultSet rs = pstmt.executeQuery();
		        
		        while(rs.next())
		        {
		        	String orderNumber = rs.getString("o_number");
		        	String username = rs.getString("username");
		        	int addressId = rs.getInt("a_id");
		        	String cardNumber = rs.getString("card_no");
		        	double totalAmount = rs.getDouble("amount");
		        	Date orderDate = rs.getDate("o_date");
		        	String status = rs.getString("status");
		        	
		        	Address address = dao.getAddressById(addressId);
		        	List<CartItem> items = dao.getOrderItems(orderId);
		        	order = new Order(orderId, orderNumber,  username, items, address, cardNumber, totalAmount, orderDate.toLocalDate(), status);
		        	connect();
		        }
		        rs.close();
		        pstmt.close();
			disconnect();
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return order;
	}

	@Override
	public List<Order> getAllOrders() 
	{
		DataAccess dao = new DatabaseConnect();
		List<Order> orders = new ArrayList<Order>();
		try 
		{
			connect();
				String query = "select * from orders order by o_id desc;";
				PreparedStatement pstmt = con.prepareStatement(query);
		        ResultSet rs = pstmt.executeQuery();
		        
		        while(rs.next())
		        {
		        	int id = rs.getInt("o_id");
		        	String orderNumber = rs.getString("o_number");
		        	String username = rs.getString("username");
		        	int addressId = rs.getInt("a_id");
		        	String cardNumber = rs.getString("card_no");
		        	double totalAmount = rs.getDouble("amount");
		        	Date orderDate = rs.getDate("o_date");
		        	String status = rs.getString("status");
		        	
		        	Address address = dao.getAddressById(addressId);
		        	List<CartItem> items = dao.getOrderItems(id);
		        	Order order = new Order(id, orderNumber,  username, items, address, cardNumber, totalAmount, orderDate.toLocalDate(), status);
		        	orders.add(order);
		        	connect();
		        }
		        rs.close();
		        pstmt.close();
			disconnect();
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return orders;
	}

	@Override
	public List<CartItem> getOrderItems(int orderId) 
	{
		List<CartItem> items = new ArrayList<CartItem>();
		try 
		{
			connect();
				String query = "select p.p_id,p.name,p.description,p.quantity,o.price,p.url,o.quantity as item_quantity from products p join order_items o on p.p_id=o.p_id where o_id=?";
				PreparedStatement pstmt = con.prepareStatement(query);
				pstmt.setInt(1, orderId);
		        ResultSet rs = pstmt.executeQuery();
		        
		        while(rs.next())
		        {
		        	int p_id = rs.getInt("p_id");
		        	String p_name = rs.getString("name");
		        	String p_desc = rs.getString("description");
		        	double p_price = rs.getDouble("price");
		        	String p_url = rs.getString("url");
		        	int quantity = rs.getInt("quantity");
		        	int itemQuantity = rs.getInt("item_quantity");
		        	
		        	Product product = new Product(p_id, p_name, p_desc, p_price,quantity, p_url);
		        	CartItem item = new CartItem(product, itemQuantity);
		        	items.add(item);
		        }
		        rs.close();
		        pstmt.close();
			disconnect();
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return items;
	}

	@Override
	public boolean updateOrderStatus(int orderId, String status) 
	{
		try 
		{
			connect();
				String query = "update orders set status=? where o_id=?";
				PreparedStatement pstmt = con.prepareStatement(query);
				pstmt.setString(1, status);
				pstmt.setInt(2, orderId);
				int rows = pstmt.executeUpdate();
		        pstmt.close();
			disconnect();
			
			if(rows>0) return true;
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return false;
	}
	
	
}//end of class