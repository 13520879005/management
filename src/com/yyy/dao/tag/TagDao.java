package com.yyy.dao.tag;

import java.util.List;
import java.util.Map;

public interface TagDao {
    String queryTagCount(Map<String,String> param);

    List<Map<String,String>> queryTags(Map<String,String> param);

    void inertTag(Map<String,String> param);

    Map<String,String> queryTagMap(String tagid);

    void updateTag(Map<String,String> param);

    void deleteTag(Map<String,String> param);
}
