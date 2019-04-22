package com.yyy.service.home;

import com.yyy.dao.home.HomeDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class HomeServiceImpl implements HomeService{
    @Autowired
    private HomeDao homeDao;

    public List<Map<String, String>> queryTjList(String usertag) {
        return homeDao.queryTjList(usertag);
    }

    public List<Map<String, String>> queryHotList() {
        return homeDao.queryHotList();
    }

    public List<Map<String, String>> queryTeacherR() {
        return homeDao.queryTeacherR();
    }

    public List<Map<String, String>> queryStudentR() {
        return homeDao.queryStudentR();
    }

    public List<Map<String, String>> queryXuek() {
        return homeDao.queryXuek();
    }

    public List<Map<String, String>> queryWent() {
        return homeDao.queryWent();
    }
}
