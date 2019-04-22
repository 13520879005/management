package com.yyy.controller.file;

import com.alibaba.fastjson.JSON;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

@Controller
@RequestMapping("/file/")
public class UploadFile {


    @RequestMapping(value = "uploadFiles")
    @ResponseBody
    public String filesUpload(HttpServletRequest request, HttpServletResponse response,MultipartFile file) {
        //消息提示
        String message = "";
            //循环获取file数组中得文件
                String fileElemName = file.getName();
                String fileName = file.getOriginalFilename();
                String fileExtName = fileName.substring(fileName.lastIndexOf(".")+1);

                /*if(fileExtName==null || !fileExtName.equalsIgnoreCase("xml"))
                {
                    message += file.getOriginalFilename()+"文件类型不是xml文件！";
                    return message;
                }*/

                //保存文件
                boolean res = saveFile(file,request);
                if(res)
                {
                    message += file.getOriginalFilename()+"文件上传服务器成功！      ";

                    //do something......

                }
                else
                {
                    message += file.getOriginalFilename()+"文件上传服务器失败！";
                    return message;
                }
        return message;
    }

    private boolean saveFile(MultipartFile file,HttpServletRequest request) {
        // 判断文件是否为空
        if (!file.isEmpty()) {
            try {
                String savePath = "D:\\upload\\images\\";
                File file_folder = new File(savePath);
                //判断上传文件的保存目录是否存在
                if (!file_folder.exists() && !file_folder.isDirectory()) {
                    System.out.println(savePath+"目录不存在，需要创建");
                    //创建目录
                    file_folder.mkdir();
                }

                // 文件保存
                String filePath = savePath + file.getOriginalFilename();

                // 转存文件
                file.transferTo(new File(filePath));
                return true;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    @RequestMapping(value = "/gotofile", method = {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView gotoDepart() {
        ModelAndView mav = new ModelAndView("business/file/file");
        return mav;
    }
}
