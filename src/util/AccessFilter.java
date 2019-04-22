package util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

public class AccessFilter implements HandlerInterceptor {

    @Override
    public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
            throws Exception {

    }

    @Override
    public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
            throws Exception {

    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse arg1, Object arg2) throws Exception {
        String requestURI = request.getRequestURI();

        if(requestURI.indexOf("login") < 0 && requestURI.indexOf("file") < 0){
            HttpSession session = request.getSession();
            Map<String,String> userInfo = (Map<String,String>)session.getAttribute("userInfo");
            if(userInfo!=null){
                //登陆成功的用户
                return true;
            }else{
                //没有登陆，转向登陆界面
                request.getRequestDispatcher("/").forward(request,arg1);
                return false;
            }
        }else{
            //如果不是以上两种方法的话,都进行放过
            return true;
        }
    }
}