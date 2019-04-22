package com.yyy.service.home;

import java.util.List;
import java.util.Map;

public interface HomeService {

    List<Map<String,String>> queryTjList(String usertag);

    List<Map<String,String>> queryHotList();

    List<Map<String, String>> queryTeacherR();

    List<Map<String, String>> queryStudentR();

    List<Map<String, String>> queryXuek();

    List<Map<String, String>> queryWent();
}
