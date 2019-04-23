package com.yyy.webservice;

import com.alibaba.fastjson.JSON;
import org.springframework.stereotype.Service;

public class TestWebServiceImpl implements TestWebService {
    @Override
    public String test() {
        return JSON.toJSONString("11111111111111111");
    }
}
