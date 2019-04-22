package com.yyy.service.paste;

import com.yyy.dao.paste.PasteDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class PasteServiceImpl implements PasteService {
    @Autowired
    private PasteDao pasteDao;

    public String queryPasteCount(Map<String, String> param) {
        return pasteDao.queryPasteCount(param);
    }

    public List<Map<String, String>> queryPaste(Map<String, String> param) {
        return pasteDao.queryPaste(param);
    }

    public void insertPaste(Map<String, String> param) {
        pasteDao.insertPaste(param);
    }

    public void updatePaste(String pasteid) {
        pasteDao.updatePaste(pasteid);
    }

    public Map<String, String> queryPasteMap(String pasteid) {
        return pasteDao.queryPasteMap(pasteid);
    }

    public List<Map<String, String>> queryReplyList(String pasteid) {
        return pasteDao.queryReplyList(pasteid);
    }

    public void insertReplys(Map<String, String> param) {
        pasteDao.insertReplys(param);
    }

    public String queryPasteHisCount(Map<String, String> param) {
        return pasteDao.queryPasteHisCount(param);
    }

    public List<Map<String, String>> queryPasteHis(Map<String, String> param) {
        return pasteDao.queryPasteHis(param);
    }

    public String queryPasteAllCount(Map<String, String> param) {
        return pasteDao.queryPasteAllCount(param);
    }

    public List<Map<String, String>> queryPasteAll(Map<String, String> param) {
        return pasteDao.queryPasteAll(param);
    }

    public void updatePasteById(String pasteid) {
        pasteDao.updatePasteById(pasteid);
    }

    public void updateReplys(String praise,String replyid) {
        if("add".equals(praise)){
            pasteDao.addPraise(replyid);
        }else if("del".equals(praise)){
            pasteDao.delPraise(replyid);
        }
    }
}
