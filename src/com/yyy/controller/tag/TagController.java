package com.yyy.controller.tag;

import com.alibaba.fastjson.JSON;
import com.yyy.service.tag.TagService;
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
@RequestMapping("/tag/")
public class TagController {
    @Autowired
    private TagService tagService;

    @RequestMapping(value = "/gotoTag", method = {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView gotoTag() {
        ModelAndView mav = new ModelAndView("business/tag/tags");
        return mav;
    }

    @RequestMapping(value="/queryTag")
    @ResponseBody
    public String queryTag(HttpServletRequest httpServletRequest){
        Map<String,String> param = RequestMap.convertMap(httpServletRequest.getParameterMap());
        Integer page =  Integer.valueOf(param.get("page"));
        int pageSize=10;//设置每页显示的数据为5条
        int total=Integer.valueOf(tagService.queryTagCount(param));
        if(page<=1){
            page=1;
        }
        Map<String,Object> map=new HashMap<String,Object>();
        //每页的开始记录  第一页为1  第二页为number +1
        int start = (page-1)*pageSize;
        param.put("start",String.valueOf(start));
        param.put("pageSize",String.valueOf(pageSize));
        List<Map<String,String>> list=tagService.queryTags(param);
        map.put("rows",list);
        map.put("total",total);
        return JSON.toJSONString(map);
    }

    @RequestMapping(value = "/addTag", method = {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView addTag() {
        ModelAndView mav = new ModelAndView("business/tag/addtag");
        return mav;
    }

    @RequestMapping(value = "/inertTag")
    @ResponseBody
    public String inertTag(HttpServletRequest httpServletRequest){
        Map<String,String> param = RequestMap.convertMap(httpServletRequest.getParameterMap());
        param.put("tagid",UuidUtil.get32UUID());
        tagService.inertTag(param);
        return JSON.toJSONString("succeed");
    }

    @RequestMapping(value = "/editTag", method = {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView editTag(String tagid) {
        ModelAndView mav = new ModelAndView("business/tag/edittag");
        Map<String,String> tagMap =tagService.queryTagMap(tagid);
        mav.addObject("tagMap",tagMap);
        return mav;
    }

    @RequestMapping(value = "/updateTag")
    @ResponseBody
    public String updateTag(HttpServletRequest httpServletRequest){
        Map<String,String> param = RequestMap.convertMap(httpServletRequest.getParameterMap());
        tagService.updateTag(param);
        return JSON.toJSONString("succeed");
    }

    @RequestMapping(value = "/deleteTag")
    @ResponseBody
    public String deleteTag(HttpServletRequest httpServletRequest){
        Map<String,String> param = RequestMap.convertMap(httpServletRequest.getParameterMap());
        tagService.deleteTag(param);
        return JSON.toJSONString("succeed");
    }

}
