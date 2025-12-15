package model;

import java.time.LocalDate;
import java.util.List;

public class Order 
{
	int id;
	String orderNumber;
	String username;
	List<CartItem> items;
	Address address;
	String cardNumber;
	double totalAmount;
	LocalDate orderDate;
	String status;
	
	public Order() 
	{
		
	}

	//storing constructor
	public Order(String orderNumber, String username, List<CartItem> items, Address address, String cardNumber,
			double totalAmount, LocalDate orderDate) {
		this.orderNumber = orderNumber;
		this.username = username;
		this.items = items;
		this.address = address;
		this.cardNumber = cardNumber;
		this.totalAmount = totalAmount;
		this.orderDate = orderDate;
	}

	//retrieving constructor
	public Order(int id, String orderNumber, String username, List<CartItem> items, Address address, String cardNumber,
			double totalAmount, LocalDate orderDate, String status) {
		this.id = id;
		this.orderNumber = orderNumber;
		this.username = username;
		this.items = items;
		this.address = address;
		this.cardNumber = cardNumber;
		this.totalAmount = totalAmount;
		this.orderDate = orderDate;
		this.status = status;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getOrderNumber() {
		return orderNumber;
	}

	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public List<CartItem> getItems() {
		return items;
	}

	public void setItems(List<CartItem> items) {
		this.items = items;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public String getCardNumber() {
		return cardNumber;
	}

	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}

	public double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public LocalDate getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(LocalDate orderDate) {
		this.orderDate = orderDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
