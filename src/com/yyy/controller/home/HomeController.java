package com.yyy.controller.home;

import com.alibaba.fastjson.JSON;
import com.yyy.service.home.HomeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/home/")
public class HomeController {
    @Autowired
    private HomeService homeService;
    //进入主页
    @RequestMapping(value = "/gotoHome", method = {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView gotoHome() {
        ModelAndView mav = new ModelAndView("business/home/home");
        return mav;
    }
    //进入注册页面
    @RequestMapping(value = "/gotoRight", method = {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView gotoRight(HttpSession session) {
        Map<String,String> userMap = (Map<String, String>) session.getAttribute("userInfo");
        ModelAndView mav = new ModelAndView("business/home/right");
        List<Map<String,String>> tjList = homeService.queryTjList(userMap.get("usertag"));
        List<Map<String,String>> hotList = homeService.queryHotList();
        List<Map<String,String>> teaR= homeService.queryTeacherR();
        List<Map<String,String>> stuR= homeService.queryStudentR();
        List<Map<String,String>> xuek= homeService.queryXuek();
        List<Map<String,String>> went= homeService.queryWent();
        mav.addObject("tjList",tjList);
        mav.addObject("hotList",hotList);
        mav.addObject("teaR",JSON.toJSONString(teaR));
        mav.addObject("stuR",JSON.toJSONString(stuR));
        mav.addObject("xuek",JSON.toJSONString(xuek));
        mav.addObject("went",JSON.toJSONString(went));
        return mav;
    }
}
