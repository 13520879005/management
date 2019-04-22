package util;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;

public class ResourceMessage {
    private static final String defaultConfigFile = "/global.properties";
    private static ConcurrentHashMap<String, Properties> configMap = new ConcurrentHashMap();
    private String configFileName = null;

    private ResourceMessage(String configFileName) {
        if (configFileName != null && configFileName.trim().length() != 0) {
            configFileName = configFileName.trim().toLowerCase();
            if (configFileName.endsWith(".properties")) {
                this.configFileName = configFileName;
            } else {
                this.configFileName = configFileName + ".properties";
            }

            if (!configMap.containsKey(this.configFileName)) {
                Properties properties = new Properties();
                InputStream is = null;

                try {
                    is = this.getClass().getResourceAsStream(this.configFileName);
                    properties.load(is);
                } catch (Exception var13) {
                    System.out.println(">>>不能读取配置文件" + configFileName);
                    var13.printStackTrace();
                } finally {
                    try {
                        if (is != null) {
                            is.close();
                        }
                    } catch (IOException var12) {
                        var12.printStackTrace();
                    }

                    configMap.putIfAbsent(this.configFileName, properties);
                }

            }
        }
    }

    public static synchronized ResourceMessage newInstance(String configFileName) {
        return new ResourceMessage(configFileName);
    }

    public static synchronized ResourceMessage newInstance() {
        return new ResourceMessage("/global.properties");
    }

    public List<String> getKeys() {
        List<String> list = new ArrayList();
        Properties properties = (Properties)configMap.get(this.configFileName);
        if (properties == null) {
            return list;
        } else {
            Enumeration keys = properties.keys();

            while(keys.hasMoreElements()) {
                list.add(keys.nextElement().toString());
            }

            return list;
        }
    }

    public String getValue(String key) {
        Properties properties = (Properties)configMap.get(this.configFileName);
        if (properties == null) {
            return "";
        } else {
            String temp = properties.getProperty(key);
            return temp == null ? "" : temp.trim();
        }
    }
}
