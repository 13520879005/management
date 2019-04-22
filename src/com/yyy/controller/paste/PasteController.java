package com.yyy.controller.paste;

import com.alibaba.fastjson.JSON;
import com.yyy.service.login.LoginService;
import com.yyy.service.paste.PasteService;
import com.yyy.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import util.RequestMap;
import util.UuidUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/paste/")
public class PasteController {
    @Autowired
    private PasteService pasteService;

    @Autowired
    private LoginService loginService;

    @RequestMapping(value = "/gotoPaste", method = {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView gotoPaste() {
        ModelAndView mav = new ModelAndView("business/paste/paste");
        return mav;
    }

    @RequestMapping(value="/queryPaste")
    @ResponseBody
    public String queryPaste(HttpServletRequest httpServletRequest,HttpSession session){
        Map<String,String> param = RequestMap.convertMap(httpServletRequest.getParameterMap());
        Map<String,String> userMap = (Map<String, String>) session.getAttribute("userInfo");
        param.put("usertag",userMap.get("usertag"));
        Integer page =  Integer.valueOf(param.get("page"));
        int pageSize=10;//设置每页显示的数据为5条
        int total=Integer.valueOf(pasteService.queryPasteCount(param));
        if(page<=1){
            page=1;
        }
        Map<String,Object> map=new HashMap<String,Object>();
        //每页的开始记录  第一页为1  第二页为number +1
        int start = (page-1)*pageSize;
        param.put("start",String.valueOf(start));
        param.put("pageSize",String.valueOf(pageSize));
        List<Map<String,String>> list=pasteService.queryPaste(param);
        map.put("rows",list);
        map.put("total",total);
        return JSON.toJSONString(map);
    }

    @RequestMapping(value = "/addPaste", method = {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView addPaste() {
        ModelAndView mav = new ModelAndView("business/paste/addpaste");
        List<Map<String,String>> tagList = loginService.queryTagList();
        mav.addObject("tagList",tagList);
        return mav;
    }

    @RequestMapping(value="/insertPaste")
    @ResponseBody
    public String insertPaste(HttpServletRequest httpServletRequest,HttpSession session){
        Map<String,String> param = RequestMap.convertMap(httpServletRequest.getParameterMap());
        Map<String,String> userMap = (Map<String, String>) session.getAttribute("userInfo");
        param.put("pasteid",UuidUtil.get32UUID());
        param.put("pasteuserid",userMap.get("userid"));
        param.put("pasteusertype",userMap.get("usertype"));
        param.put("hits","0");
        pasteService.insertPaste(param);
        return JSON.toJSONString("succeed");
    }

    @RequestMapping(value = "/gotoReply", method = {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView gotoReply(String pasteid) {
        ModelAndView mav = new ModelAndView("business/paste/reply");
        pasteService.updatePaste(pasteid);
        Map<String,String> paMap = pasteService.queryPasteMap(pasteid);
        List<Map<String,String>> rpList = pasteService.queryReplyList(pasteid);
        mav.addObject("paMap",paMap);
        mav.addObject("rpList",rpList);
        return mav;
    }

    @RequestMapping(value="/insertReplys")
    @ResponseBody
    public String insertReplys(HttpServletRequest httpServletRequest,HttpSession session){
        Map<String,String> param = RequestMap.convertMap(httpServletRequest.getParameterMap());
        Map<String,String> userMap = (Map<String, String>) session.getAttribute("userInfo");
        param.put("replyid",UuidUtil.get32UUID());
        param.put("replyuserid",userMap.get("userid"));
        param.put("replyusertype",userMap.get("usertype"));
        param.put("praise","0");
        pasteService.insertReplys(param);
        return JSON.toJSONString("succeed");
    }

    @RequestMapping(value = "/gotoPasteHis", method = {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView gotoPasteHis() {
        ModelAndView mav = new ModelAndView("business/paste/hispaste");
        return mav;
    }

    @RequestMapping(value="/queryPasteHis")
    @ResponseBody
    public String queryPasteHis(HttpServletRequest httpServletRequest,HttpSession session){
        Map<String,String> param = RequestMap.convertMap(httpServletRequest.getParameterMap());
        Map<String,String> userMap = (Map<String, String>) session.getAttribute("userInfo");
        param.put("userid",userMap.get("userid"));
        Integer page =  Integer.valueOf(param.get("page"));
        int pageSize=10;//设置每页显示的数据为5条
        int total=Integer.valueOf(pasteService.queryPasteHisCount(param));
        if(page<=1){
            page=1;
        }
        Map<String,Object> map=new HashMap<String,Object>();
        //每页的开始记录  第一页为1  第二页为number +1
        int start = (page-1)*pageSize;
        param.put("start",String.valueOf(start));
        param.put("pageSize",String.valueOf(pageSize));
        List<Map<String,String>> list=pasteService.queryPasteHis(param);
        map.put("rows",list);
        map.put("total",total);
        return JSON.toJSONString(map);
    }


    @RequestMapping(value = "/gotoPasteAll", method = {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView gotoPasteAll() {
        ModelAndView mav = new ModelAndView("business/paste/allpaste");
        return mav;
    }

    @RequestMapping(value="/queryPasteAll")
    @ResponseBody
    public String queryPasteAll(HttpServletRequest httpServletRequest,HttpSession session){
        Map<String,String> param = RequestMap.convertMap(httpServletRequest.getParameterMap());
        Map<String,String> userMap = (Map<String, String>) session.getAttribute("userInfo");
        Integer page =  Integer.valueOf(param.get("page"));
        int pageSize=10;//设置每页显示的数据为5条
        int total=Integer.valueOf(pasteService.queryPasteAllCount(param));
        if(page<=1){
            page=1;
        }
        Map<String,Object> map=new HashMap<String,Object>();
        //每页的开始记录  第一页为1  第二页为number +1
        int start = (page-1)*pageSize;
        param.put("start",String.valueOf(start));
        param.put("pageSize",String.valueOf(pageSize));
        List<Map<String,String>> list=pasteService.queryPasteAll(param);
        map.put("rows",list);
        map.put("total",total);
        return JSON.toJSONString(map);
    }

    @RequestMapping(value="/deletePaste")
    @ResponseBody
    public String deletePaste(String pasteid){
        pasteService.updatePasteById(pasteid);
        return JSON.toJSONString("succeed");
    }

    @RequestMapping(value="/updateReplys")
    @ResponseBody
    public String updateReplys(String praise,String replyid){
        pasteService.updateReplys(praise,replyid);
        return JSON.toJSONString("succeed");
    }

}
