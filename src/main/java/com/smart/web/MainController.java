package com.smart.web;

import com.smart.domain.Main;
import com.smart.domain.Message;
import com.smart.domain.User;
import com.smart.service.AnswerService;
import com.smart.service.MainService;
import com.smart.tool.Page;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/main")
public class MainController {
    @Autowired
    @Qualifier("mainService")
    private MainService mainService;
    @Autowired
    @Qualifier("answerService")
    private AnswerService answerService;

    //登录验证成功跳转获取问卷显示在首页上
    @RequestMapping(value = "/",method = RequestMethod.GET)
    public String main(Page<Main> page, Model model){
        if(page.getCurrentPage()==null){
            //登录默认当页为首页
            page.setCurrentPage(1);
        }
        Page<Main> newPage=mainService.selectMainByPage1(page);
        /*
        for(Main main:newPage.getList()){
            if(main.getMainIsuse().equals("n")){
                newPage.getList().remove(main);
            }
        }*/
        model.addAttribute("newPage",newPage);
        return "index";
    }
    /**填写问卷模块**/
    //单击问卷标题进入问卷调查
    @RequiresRoles(value = "vip",logical = Logical.OR)
    @RequestMapping (value = "/see/{mainId}")
    public String seeQuestion(@PathVariable("mainId") Integer mainId, Model model, HttpSession session){
        //获取登录用户信息
        User user= (User) session.getAttribute("user");
        //查询用户是否答过问卷，答过为true，并且跳转至答过页面mainIsAnswer
        Boolean b=mainService.isTrueAnswer(mainId ,user.getUserId());
        if(b)
        {
            return "main/mainIsAnswer";
        }
        //获取问卷，包括question,answer;
        Map<String,Object> map= mainService.selectMainById(mainId);

        model.addAttribute("map",map);
        return "main/main";
    }

    //问卷填写数据入库****quesId数组保存答案id
    @RequestMapping(value = "/actionSub",method = RequestMethod.POST)
    public  String  actionSub( Main  main,String message,HttpSession session,HttpServletRequest request){
        //保存答案Id
        List<String> answerId = new ArrayList<>();
        Map<String, String[]> parm = request.getParameterMap();
        Set<Map.Entry<String, String[]>> entrySet = parm.entrySet();
        for (Map.Entry<String, String[]> entry : entrySet){
            if("message".equals(entry.getKey())==false && "main".equals(entry.getKey()) ==false) {
                String[] answerIds = entry.getValue();
                answerId.addAll(Arrays.asList(answerIds));
            }
        }
        User user= (User) session.getAttribute("user");
        //判断是否有额外建议，如有则入库
        if(message!=null&&message!=""){
            mainService.insertMessage(main,message,user.getUserName());
        }
        //修改问卷回答人数及答案被点击的次数
        answerService.updateApplyValues(answerId);

        //增加用户已作答
        mainService.insertAlreadyApply(main.getMainId(),user.getUserId());
        return "main/postSuccess";

    }
    //查看问卷结果
    @RequestMapping(value="/seeResult/{mainId}",method = RequestMethod.GET)
    public String seeResult(@PathVariable("mainId") Integer mainId ,Model model){
        //获取完整问卷
        Map<String,Object> map=mainService.selectMainById(mainId);
        //获取问卷额外信息
        List<Message> messageList=mainService.selectMessage(mainId);
        if(messageList!=null) {
            model.addAttribute("messageList", messageList);
        }
        model.addAttribute("map",map);
        return "main/seeResult";
    }
    /**维护问卷模块**/
    //维护问卷***获取问卷***分页
    @RequestMapping(value = "/weihu",method = RequestMethod.GET)
    public  String weihu(Page<Main> page,Model model){
        if(page.getCurrentPage()==null){
            //登录默认当页为首页
            page.setCurrentPage(1);
        }
        Page<Main> newPage=mainService.selectMainByPage(page);
        model.addAttribute("newPage",newPage);
        return "weihuMain/weihuMain";

    }
    //新建一份问卷
    @RequestMapping(value = "/create",method = RequestMethod.POST)
    public String Create(String mainTitle,String mainEndTime,HttpSession session) throws ParseException {
        Main main=new Main();
        main.setMainTitle(mainTitle); //问卷标题
        main.setMainCreateTime(new Date()); //创建时间
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        main.setMainEndTime(sdf.parse(mainEndTime));   //截止时间
        main.setMainIsuse("n");        //是否发布
        User user= (User) session.getAttribute("user");
        main.setMainCreateUser(user.getUserName()); //问卷创始人
        mainService.insertMain(main);
        return "redirect:/main/weihu";
    }

    //删除一份问卷
    @RequestMapping(value = "/delMain/{mainId}",method = RequestMethod.DELETE)
    @ResponseBody
    public Map<String,Object> deleteMain(@PathVariable("mainId") Integer mainId){
        Map<String,Object> map=new HashMap<>();
        boolean b=mainService.deleteMain(mainId);           //是否删除成功
        map.put("success",b);
        return map;
    }
    //批量删除问卷
    @RequestMapping(value = "/delBatch",method = RequestMethod.DELETE)
    @ResponseBody
    public Map<String,Object> deleteMain(HttpServletRequest request,@RequestParam("id") String[] mainId){
        Map<String,Object> map=new HashMap<>();
        boolean b= mainService.deleteBatchMain(mainId);   //是否批量删除成功
        map.put("success",b);
        return map;
    }
    //问卷发布
    @RequestMapping(value = "/mainIssue/{mainId}",method = RequestMethod.PUT)
    @ResponseBody
    public Map<String,Boolean> mainIssue(@PathVariable("mainId") Integer mainId){
        Map<String,Boolean> map=new HashMap<>();
        Main main=new Main();
        main.setMainId(mainId);
        main.setMainIsuse("y");
       boolean b=mainService.updateMain(main);
        map.put("success",b);
        return map;
    }
    //问卷停止发布
    @RequestMapping(value = "/mainPause/{mainId}",method = RequestMethod.PUT)
    @ResponseBody
    public Map<String,Boolean> mainPause(@PathVariable("mainId") Integer mainId){
        Map<String,Boolean> map=new HashMap<>();
        Main main=new Main();
        main.setMainId(mainId);
        main.setMainIsuse("n");
        boolean b=mainService.updateMain(main);
        map.put("success",b);
        return map;
    }
    //复制问卷
    @RequestMapping(value = "/copy/{mainId}",method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Boolean> mainCopy(@PathVariable("mainId") Integer mainId, HttpSession session){
        Map<String,Boolean> map=new HashMap<>();
        User user = (User) session.getAttribute("user");
        map.put("success",mainService.copyMain(user,mainId));
        return map;
    }
    //搜索问卷
    @RequestMapping(value = "/searchMain",method = RequestMethod.GET)
    public String searchMain(String mainCreateTime,String mainTitle,String mainEndTime,Page<Main> page,Model model){
        if(page.getCurrentPage()==null){
            //登录默认当页为首页
            page.setCurrentPage(1);
        }
        Page<Main> newPage=mainService.selectMainByTitle(page,mainTitle,mainCreateTime,mainEndTime);
        model.addAttribute("newPage",newPage);
        return "weihuMain/weihuMain";
    }

    /** 我的问卷模块**/
    @RequestMapping(value = "/wode",method = RequestMethod.GET)
    public  String wode(Page<Main> page,Model model,HttpSession session){
        if(page.getCurrentPage()==null){
            //登录默认当页为首页
            page.setCurrentPage(1);
        }
        User user= (User) session.getAttribute("user");
        Page<Main> newPage=mainService.selectMainByPageAndUser(page,user);
        model.addAttribute("newPage",newPage);
        return "wodeMain/wodeMain";

    }
}
