package com.yyy.service.depart;

import com.yyy.dao.depart.DepartDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import util.UuidUtil;

import java.util.List;
import java.util.Map;

@Service
public class DepartServiceImpl implements DepartService {
    @Autowired
    private DepartDao departDao;

    public List<Map<String, String>> queryDepartList() {
        return departDao.queryDepartList();
    }

    public String queryDepartCount(Map<String, String> param) {
        return departDao.queryDepartCount(param);
    }

    public List<Map<String, String>> queryDepartXx(Map<String, String> param) {
        return departDao.queryDepartXx(param);
    }

    public void deleteDepart(Map<String, String> param) {
        departDao.deleteDepart(param);
    }

    public Map<String, String> queryDepartMap(String departcode) {
        return departDao.queryDepartMap(departcode);
    }

    public void insertDepart(Map<String, String> param) {
        param.put("departid",UuidUtil.get32UUID());
        String num = departDao.queryDepartNum(param);
        if("1".equals(param.get("departlevel"))){
            if("0".equals(num)){
                departDao.insertXueyToNull(param);
            }else{
                departDao.insertXuey(param);
            }

        }else{
            if("0".equals(num)){
                departDao.insertZhanyToNull(param);
            }else {
                departDao.insertZhany(param);
            }
        }
    }

    public void updateDepart(Map<String, String> param) {
        departDao.updateDepart(param);
    }
}
