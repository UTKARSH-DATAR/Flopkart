package service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.util.Map;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

@WebServlet("/UploadAndForward")
@MultipartConfig
public class UploadAndForward extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static final String CLOUD_NAME = "dz8qf9ugu";
    private static final String API_KEY = "124898551783626";
    private static final String API_SECRET = "ThGjQhzPISzfDkrXBC23LzZH8CU";
 
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {


		// Grab the uploaded file
		Part filePart = request.getPart("productImage");

		if (filePart != null && filePart.getSize() > 0)
		{
            // Create Cloudinary object with hardcoded credentials
            Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
                    "cloud_name", CLOUD_NAME,
                    "api_key", API_KEY,
                    "api_secret", API_SECRET
                ));

            // Upload file stream to Cloudinary
            byte[] fileBytes = filePart.getInputStream().readAllBytes();

            Map uploadResult = cloudinary.uploader().upload(fileBytes, ObjectUtils.asMap("folder", "products"));


            // Get permanent HTTPS URL
            String imageUrl = (String) uploadResult.get("secure_url");
            
            // Store URL in DB or forward to next servlet
            request.setAttribute("imagePath", imageUrl);

		}
		
		String action = request.getParameter("action");
		
		if(action.equals("add"))
		{
			request.getRequestDispatcher("AddProduct").forward(request, response);
		}
		else if(action.equals("edit"))
		{
			request.getRequestDispatcher("UpdateProduct").forward(request, response);
		}
	}

}
