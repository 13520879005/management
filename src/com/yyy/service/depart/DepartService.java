package com.yyy.service.depart;

import java.util.List;
import java.util.Map;

public interface DepartService {
    List<Map<String,String>> queryDepartList();

    String queryDepartCount(Map<String,String> param);

    List<Map<String,String>> queryDepartXx(Map<String,String> param);

    void deleteDepart(Map<String,String> param);

    Map<String,String> queryDepartMap(String departcode);

    void insertDepart(Map<String,String> param);

    void updateDepart(Map<String,String> param);
}
