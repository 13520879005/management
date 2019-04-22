package com.yyy.controller.login;

import com.alibaba.fastjson.JSON;
import com.yyy.service.login.LoginService;
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
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/login/")
public class LoginController {

    @Autowired
    private LoginService loginService;

    //进入注册页面
    @RequestMapping(value = "/regUser", method = {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView gotoHomePlus() {
        ModelAndView mav = new ModelAndView("business/login/reguser");
        List<Map<String,String>> tagList = loginService.queryTagList();
        List<Map<String,String>> xueyList = loginService.queryXueyList();
        mav.addObject("tagList",tagList);
        mav.addObject("xueyList",xueyList);
        return mav;
    }
    //插入注册信息
    @ResponseBody
    @RequestMapping(value = "/gotoReg",method =RequestMethod.POST)
    public String gotoReg(HttpServletRequest httpServletRequest){
        Map<String,String> usermap = RequestMap.convertMap(httpServletRequest.getParameterMap());
        loginService.gotoReg(usermap);
        return JSON.toJSONString("succeed");
    }
    //登陆
    @ResponseBody
    @RequestMapping(value = "/gotoLogin",method =RequestMethod.POST)
    public String gotoLogin(HttpServletRequest httpServletRequest,HttpSession session){
        Map<String,String> loginmap = RequestMap.convertMap(httpServletRequest.getParameterMap());
        loginmap.put("userpassword", MD5.md5(loginmap.get("userpassword")));
        Map<String,String> userMap = loginService.queryLoginMap(loginmap);
        String rt="";
        if(userMap == null){
            rt="nouser";
        }else if("0".equals(userMap.get("status"))){
            rt="waituser";
        }else if("2".equals(userMap.get("status"))){
            rt="wxuser";
        }else if("3".equals(userMap.get("status"))){
            rt="wtguser";
        }else{
            session.setAttribute("userInfo",userMap);
            rt="succeed";
        }
        return JSON.toJSONString(rt);
    }

    //退出
    @RequestMapping("logout")
    public String logout(HttpSession session,HttpServletRequest request) {
        session.invalidate();
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
        return "redirect:/";
    }

    @ResponseBody
    @RequestMapping(value = "/chooseZy",method =RequestMethod.GET)
    public String chooseZy(HttpServletRequest httpServletRequest){
        Map<String,String> param = RequestMap.convertMap(httpServletRequest.getParameterMap());
        List<Map<String,String>> zhuanyList= loginService.queryZhuanyList(param);
        return JSON.toJSONString(zhuanyList);
    }
}
