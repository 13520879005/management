package com.yyy.service.login;

import com.yyy.dao.login.LoginDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import util.MD5;
import util.UuidUtil;

import java.util.List;
import java.util.Map;

@Service
public class LoginServiceImpl implements LoginService {
    @Autowired
    private LoginDao loginDao;

    public List<Map<String, String>> queryTagList() {
        return loginDao.queryTagList();
    }

    public void gotoReg(Map<String, String> usermap) {
        usermap.put("userid", UuidUtil.get32UUID());
        usermap.put("userpassword", MD5.md5(usermap.get("passwordshow")));
        //插入注册表
        loginDao.insertZcxx(usermap);
        //插入基本信息表
        loginDao.insertJbxx(usermap);
    }

    public Map<String, String> queryLoginMap(Map<String, String> loginmap) {
        return loginDao.queryLoginMap(loginmap);
    }

    public List<Map<String, String>> queryXueyList() {
        return loginDao.queryXueyList();
    }

    public List<Map<String, String>> queryZhuanyList(Map<String, String> param) {
        return loginDao.queryZhuanyList(param);
    }
}
