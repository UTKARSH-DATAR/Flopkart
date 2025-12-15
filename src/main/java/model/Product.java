package model;

public class Product 
{
	int id;
	String name;
	String description;
	double price;
	int quantity;
	String imgurl;
	
	public Product() 
	{
		this.id = 0;
	}
	
	//storing constructor
	public Product(String name, String description, double price, int quantity, String imgurl) {
		this.name = name;
		this.description = description;
		this.price = price;
		this.quantity = quantity;
		this.imgurl = imgurl;
	}
	
	//user side retrieving constructor
	public Product(int id, String name, String description, double price, String imgurl) {
		this.id = id;
		this.name = name;
		this.description = description;
		this.price = price;
		this.imgurl = imgurl;
	}
	
	//admin side retrieving constructor
	public Product(int id, String name, String description, double price, int quantity, String imgurl) 
	{
		this.id = id;
		this.name = name;
		this.description = description;
		this.price = price;
		this.quantity = quantity;
		this.imgurl = imgurl;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getImgurl() {
		return imgurl;
	}
	public void setImgurl(String imgurl) {
		this.imgurl = imgurl;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

}
