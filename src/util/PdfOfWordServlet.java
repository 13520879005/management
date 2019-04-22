package util;



import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

import java.io.*;

public class PdfOfWordServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	response.setContentType("application/pdf;charset=gbk");
    	response.setHeader("content-type","application/pdf;charset=gbk");
    	response.setCharacterEncoding("gbk");
        ByteArrayOutputStream stream = new ByteArrayOutputStream();
        try {
            String filename = new String(request.getParameter("filename").getBytes("iso-8859-1"), "utf-8");//???????
            String fileType = request.getParameter("fileType");//???????PDF DOC,DOCX
            if(fileType!=null) fileType = fileType.toLowerCase();
            String path = request.getParameter("path");//????·??wordfile.path
            String ywzj = request.getParameter("ywzj");//?????????????????????
            byte[] byteword = null;
           //String file_path = getFilePath(path,ywzj,filename);
           if("application/pdf".equals(fileType.toLowerCase())){/**?????PDF????????????**/
        	   byteword = getBytes(filename);
           }else{/**?????word????PDF???**/
        	   WordUtil word = new WordUtil(new FileInputStream(filename));
        	   byteword = word.makePdf();
           }
            stream.write(byteword);
        } catch (Exception e) {
            e.printStackTrace();
        }
        //???????????????pdf
        //????????????С
        response.setContentLength(stream.size());
        //????????????
        ServletOutputStream out = response.getOutputStream();
        //??pdf??????д?????????????
        stream.writeTo(out);
        out.flush();
        out.close();
    }
    public String getFilePath(String path,String ywzj,String fileName){
    	String filePath ="";
    	//try {
			//String fname = java.net.URLDecoder.decode(fileName, "iso-8859-1");
			filePath = ResourceMessage.newInstance().getValue(path)+fileName;
			if(StringUtils.isNotEmpty(ywzj)){
				filePath = ResourceMessage.newInstance().getValue(path)+ywzj+File.separator+fileName;
			}
		/*} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}*/
    	return filePath;
    }
    /**
     * ???????????byte????
     */
    public static byte[] getBytes(String filePath){
        byte[] buffer = null;
        try {
            File file = new File(filePath);
            FileInputStream fis = new FileInputStream(file);
            ByteArrayOutputStream bos = new ByteArrayOutputStream(1000);
            byte[] b = new byte[1000];
            int n;
            while ((n = fis.read(b)) != -1) {
                bos.write(b, 0, n);
            }
            fis.close();
            bos.close();
            buffer = bos.toByteArray();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return buffer;
    }
}
