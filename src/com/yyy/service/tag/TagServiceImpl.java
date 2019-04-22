package com.yyy.service.tag;

import com.yyy.dao.tag.TagDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class TagServiceImpl implements TagService {
    @Autowired
    private TagDao tagDao;

    public String queryTagCount(Map<String, String> param) {
        return tagDao.queryTagCount(param);
    }

    public List<Map<String, String>> queryTags(Map<String, String> param) {
        return tagDao.queryTags(param);
    }

    public void inertTag(Map<String, String> param) {
        tagDao.inertTag(param);
    }

    public Map<String, String> queryTagMap(String tagid) {
        return tagDao.queryTagMap(tagid);
    }

    public void updateTag(Map<String, String> param) {
        tagDao.updateTag(param);
    }

    public void deleteTag(Map<String, String> param) {
        tagDao.deleteTag(param);
    }
}
