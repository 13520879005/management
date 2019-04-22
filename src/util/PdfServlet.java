package util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class PdfServlet extends HttpServlet{


	/**
	 * 
	 */
	private static final long serialVersionUID = -1122841401313782286L;

	public PdfServlet() {      
		super(); 
	}  
	public void destroy() {         
		super.destroy();    
	}    
	public void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		this.doPost(request, response);
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)           

	throws ServletException, IOException {      
		String url=request.getParameter("url");
//		response.setContentType("application/pdf");      
		FileInputStream in = new FileInputStream(new File(url));
		OutputStream out = response.getOutputStream();       
		byte[] b = new byte[512];      
		while ((in.read(b)) != -1) {         
			out.write(b);         
		}       
		out.flush();  
		in.close();        
		out.close();  
		}     
	
	public void init() throws ServletException {     

	}   
}
