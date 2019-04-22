package com.yyy.dao.home;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface HomeDao {

    List<Map<String,String>> queryTjList(@Param("usertag")String usertag);

    List<Map<String,String>> queryHotList();

    List<Map<String,String>> queryTeacherR();

    List<Map<String,String>> queryStudentR();

    List<Map<String,String>> queryXuek();

    List<Map<String,String>> queryWent();
}
