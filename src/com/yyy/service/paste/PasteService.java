package com.yyy.service.paste;

import java.util.List;
import java.util.Map;

public interface PasteService {
    String queryPasteCount(Map<String,String> param);

    List<Map<String,String>> queryPaste(Map<String,String> param);

    void insertPaste(Map<String,String> param);

    void updatePaste(String pasteid);

    Map<String, String> queryPasteMap(String pasteid);

    List<Map<String,String>> queryReplyList(String pasteid);

    void insertReplys(Map<String,String> param);

    String queryPasteHisCount(Map<String,String> param);

    List<Map<String,String>> queryPasteHis(Map<String,String> param);

    String queryPasteAllCount(Map<String,String> param);

    List<Map<String,String>> queryPasteAll(Map<String,String> param);

    void updatePasteById(String pasteid);

    void updateReplys(String praise,String replyid);
}
