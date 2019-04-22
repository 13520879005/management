package com.yyy.dao.depart;

import java.util.List;
import java.util.Map;

public interface DepartDao {
    List<Map<String,String>> queryDepartList();

    String queryDepartCount(Map<String,String> param);

    List<Map<String,String>> queryDepartXx(Map<String,String> param);

    void deleteDepart(Map<String,String> param);

    Map<String,String> queryDepartMap(String departcode);

    void insertXuey(Map<String,String> param);

    void insertZhany(Map<String,String> param);

    String queryDepartNum(Map<String,String> param);

    void insertXueyToNull(Map<String,String> param);

    void insertZhanyToNull(Map<String,String> param);

    void updateDepart(Map<String,String> param);
}
