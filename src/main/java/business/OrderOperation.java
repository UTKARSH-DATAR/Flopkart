package business;

import java.util.List;

import model.Order;
import model.Product;
import model.CartItem;
import database.*;

public class OrderOperation 
{
	static DataAccess dao = new DatabaseConnect();
	
	public static String generateOrderNumber()
	{
		String prefix = "FLPKRT";
		List<Order> allOrders = dao.getAllOrders();
		if(allOrders.isEmpty())
		{
			return prefix + "000001";
		}
		int orderId = allOrders.get(0).getId() + 1;
		String orderNumber = prefix + String.format("%06d", orderId);
		return orderNumber;
	}
	
	public static double calculateTotalAmount(List<CartItem> cart)
	{
		double total = 0.0;
		for(CartItem item : cart)
		{
			total = total + item.getProduct().getPrice() * item.getQuantity();
		}
		return total;
	}
	
	public static void updateProductQuantity(List<CartItem> cart)
	{
		for(CartItem item : cart)
		{
			Product p = item.getProduct();
			int newQuantity = p.getQuantity()-item.getQuantity();
			p.setQuantity(newQuantity);
			dao.updateProduct(p);
		}
	}
	
	public static void restockCancelledOrder(List<CartItem> cart)
	{
		for(CartItem item : cart)
		{
			Product p = item.getProduct();
			int newQuantity = p.getQuantity()+item.getQuantity();
			p.setQuantity(newQuantity);
			dao.updateProduct(p);
		}
	}
}
