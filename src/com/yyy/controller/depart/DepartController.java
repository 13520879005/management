package com.yyy.controller.depart;

import com.alibaba.fastjson.JSON;
import com.yyy.service.depart.DepartService;
import com.yyy.service.home.HomeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import util.MD5;
import util.RequestMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/depart/")
public class DepartController {
    @Autowired
    private DepartService departService;

    @RequestMapping(value = "/gotoDepart", method = {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView gotoDepart() {
        ModelAndView mav = new ModelAndView("business/depart/departtree");
        List<Map<String,String>> departList = departService.queryDepartList();
        mav.addObject("departList",JSON.toJSONString(departList));
        return mav;
    }

    @RequestMapping(value="/queryDepart")
    @ResponseBody
    public String queryDepart(HttpServletRequest httpServletRequest){
        Map<String,String> param = RequestMap.convertMap(httpServletRequest.getParameterMap());
        Integer page =  Integer.valueOf(param.get("page"));
        int pageSize=10;//设置每页显示的数据为5条
        int total=Integer.valueOf(departService.queryDepartCount(param));
        if(page<=1){
            page=1;
        }
        Map<String,Object> map=new HashMap<String,Object>();
        //每页的开始记录  第一页为1  第二页为number +1
        int start = (page-1)*pageSize;
        param.put("start",String.valueOf(start));
        param.put("pageSize",String.valueOf(pageSize));
        List<Map<String,String>> list=departService.queryDepartXx(param);
        map.put("rows",list);
        map.put("total",total);
        return JSON.toJSONString(map);
    }

    //删除部门
    @ResponseBody
    @RequestMapping(value = "/deleteDepart",method =RequestMethod.GET)
    public String deleteDepart(HttpServletRequest httpServletRequest){
        Map<String,String> param = RequestMap.convertMap(httpServletRequest.getParameterMap());
        departService.deleteDepart(param);
        return JSON.toJSONString("succeed");
    }

    //进入添加页面
    @RequestMapping(value = "/addDepart", method = {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView addDepart(String departparentcode) {
        ModelAndView mav = new ModelAndView("business/depart/adddepart");
        Map<String,String> departMap = new HashMap<String,String>();
        if("00".equals(departparentcode)){
            departMap.put("departparentcode","00");
            departMap.put("departlevel","1");
        }else{
            departMap.put("departparentcode",departparentcode);
            departMap.put("departlevel","2");
        }
        mav.addObject("departMap",departMap);
        return mav;
    }

    //插入数据
    @ResponseBody
    @RequestMapping(value = "/inertDepart",method =RequestMethod.POST)
    public String inertDepart(HttpServletRequest httpServletRequest){
        Map<String,String> param = RequestMap.convertMap(httpServletRequest.getParameterMap());
        departService.insertDepart(param);
        return JSON.toJSONString("succeed");
    }

    //进入编辑
    @RequestMapping(value = "/editDepart", method = {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView editDepart(String departcode) {
        ModelAndView mav = new ModelAndView("business/depart/editdepart");
        Map<String, String> departMap = new HashMap<String, String>();
        departMap = departService.queryDepartMap(departcode);
        mav.addObject("departMap", departMap);
        return mav;
    }

    //修改数据
    @ResponseBody
    @RequestMapping(value = "/updateDepart",method =RequestMethod.POST)
    public String updateDepart(HttpServletRequest httpServletRequest){
        Map<String,String> param = RequestMap.convertMap(httpServletRequest.getParameterMap());
        departService.updateDepart(param);
        return JSON.toJSONString("succeed");
    }
}
