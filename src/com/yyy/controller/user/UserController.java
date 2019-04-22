package com.yyy.controller.user;

import com.alibaba.fastjson.JSON;
import com.yyy.service.home.HomeService;
import com.yyy.service.login.LoginService;
import com.yyy.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import util.RequestMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user/")
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private LoginService loginService;

    @RequestMapping(value = "/gotoUser", method = {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView gotoUser() {
        ModelAndView mav = new ModelAndView("business/user/userlist");
        List<Map<String,String>> xueyList = loginService.queryXueyList();
        mav.addObject("xueyList",xueyList);
        return mav;
    }

    @RequestMapping(value="/queryUserList")
    @ResponseBody
    public String queryUserList(HttpServletRequest httpServletRequest){
        Map<String,String> param = RequestMap.convertMap(httpServletRequest.getParameterMap());
        Integer page =  Integer.valueOf(param.get("page"));
        int pageSize=10;//设置每页显示的数据为5条
        int total=Integer.valueOf(userService.queryUserCount(param));
        if(page<=1){
            page=1;
        }
        Map<String,Object> map=new HashMap<String,Object>();
        //每页的开始记录  第一页为1  第二页为number +1
        int start = (page-1)*pageSize;
        param.put("start",String.valueOf(start));
        param.put("pageSize",String.valueOf(pageSize));
        List<Map<String,String>> list=userService.queryUserList(param);
        map.put("rows",list);
        map.put("total",total);
        return JSON.toJSONString(map);
    }

    @RequestMapping(value="/deleteUser")
    @ResponseBody
    public String deleteUser(String userid){
        userService.updateUser(userid);
        return JSON.toJSONString("succeed");
    }

    @RequestMapping(value="/updateUser")
    @ResponseBody
    public String updateUser(HttpServletRequest httpServletRequest){
        Map<String,String> param = RequestMap.convertMap(httpServletRequest.getParameterMap());
        userService.updateUserStatus(param);
        return JSON.toJSONString("succeed");
    }

    @RequestMapping(value = "/userPass", method = {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView userPass(HttpSession session) {
        ModelAndView mav = new ModelAndView("business/user/userpass");
        Map<String,String> userMap = (Map<String, String>) session.getAttribute("userInfo");
        Map<String,String> user = userService.queryUser(userMap);
        mav.addObject("user",user);
        return mav;
    }

    @RequestMapping(value="/updatePass",method = {RequestMethod.GET,RequestMethod.POST})
    public String updatePass(HttpServletRequest httpServletRequest){
        Map<String,String> param = RequestMap.convertMap(httpServletRequest.getParameterMap());
        userService.updateUserPass(param);
        return "redirect:/home/gotoRight.xhtml";
    }

}
