package util;

import com.aspose.words.Document;
import com.aspose.words.License;
import com.aspose.words.SaveFormat;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;

public class WordUtil {
    static {
        try {
            License license = new License();
            license.setLicense(new ByteArrayInputStream("<License><Data><Products><Product>Aspose.Total for Java</Product><Product>Aspose.Words for Java</Product></Products><EditionType>Enterprise</EditionType><SubscriptionExpiry>20991231</SubscriptionExpiry><LicenseExpiry>21991231</LicenseExpiry><SerialNumber>23dcc79f-44ec-4a23-be3a-03c1632404e9</SerialNumber></Data><Signature>sNLLKGMUdF0r8O1kKilWAGdgfs2BvJb/2Xp8p5iuDVfZXmhppo+d0Ran1P9TKdjV4ABwAgKXxJ3jcQTqE/2IRfqwnPf8itN8aFZlV3TJPYeD3yWE7IT55Gz6EijUpC7aKeoohTb4w2fpox58wWoF3SNp6sK6jDfiAUGEHYJ9pjU=</Signature></License>".getBytes()));
        } catch (Exception e) {
            System.out.println("aspose授权失败!");
        }
    }

    private Document doc;
    /**
     * 构造器输入Doc文档的流
     *
     * @param template
     * @throws Exception
     */
    public WordUtil(InputStream template) throws Exception {
        doc = new Document(template);
    }

    /**
     * 保存文件
     * @return
     * @throws Exception
     */
    public byte[] makePdf() throws Exception {
        byte[] rst = null;
        ByteArrayOutputStream boutput = new ByteArrayOutputStream();
        doc.save(boutput, SaveFormat.PDF);
        rst = boutput.toByteArray();
        boutput.close();
        return rst;
    }
    
    
    
    
    
    
    

}