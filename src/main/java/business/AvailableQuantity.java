package business;

import database.DataAccess;
import database.DatabaseConnect;
import model.Product;

public class AvailableQuantity 
{
    public static boolean isAvailable(int ProductId, int requestedQuantity) 
	{
    	DataAccess dao = new DatabaseConnect();
    	Product p = dao.getProductById(ProductId);
    	
    	if(p != null && p.getQuantity() >= requestedQuantity)
		{
			return true;
		}
    	
    	return false;
	}
}
