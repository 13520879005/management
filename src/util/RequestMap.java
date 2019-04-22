package util;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import org.apache.commons.lang3.StringUtils;
public class RequestMap {
    //参数封装
    public static Map<String,String> convertMap(Map<String, String[]> map){
        Map<String,String> reMap = new HashMap<String,String>();
        Iterator<String> iterator = map.keySet().iterator();
        while(iterator.hasNext()){
            String key = iterator.next().toString();
            String[] value = (String[])map.get(key);
            if(value.length>1){
                reMap.put(key.toLowerCase(),StringUtils.join(value,","));
            }else{
                reMap.put(key.toLowerCase(),value[0].trim());
            }
        }
        return reMap;
    }
}
