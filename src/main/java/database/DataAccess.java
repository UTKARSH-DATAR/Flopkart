package database;

import java.util.List;

import model.*;

public interface DataAccess 
{
	public void addUser(User user);
	public boolean validate(String username, String password);
	public boolean addProduct(Product product);
	public List<Product> getAllProducts();
	public List<User> getAllUsers();
	public User getUser(String username);
	public Product getProductById(int id);
	public boolean updateProduct(Product product);
	public boolean deleteProduct(int id);
	public boolean addToCart(String username, int productId, int quantity);
	public boolean removeFromCart(String username, int productId);
	public List<CartItem> getCartItems(String username);
	public boolean updateCartItemQuantity(String username, int productId, int quantity);
	public boolean emptyCart(String username);
	public boolean addAddress(String username, Address address);
	public List<Address> getAddresses(String username);
	public Address getAddressById(int addressId);
	public boolean deleteAddress(int addressId);
	public boolean editAddress(int addressId, Address address);
	public int placeOrder(Order order);
	public List<Order> getOrdersByUsername(String username);
	public Order getOrderById(int orderId);
	public List<Order> getAllOrders();
	public List<CartItem> getOrderItems(int orderId);
	public boolean updateOrderStatus(int orderId, String status);
}
