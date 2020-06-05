package com.smart.web;

import com.smart.domain.Main;
import com.smart.domain.Role;
import com.smart.domain.User;
import com.smart.service.RoleService;
import com.smart.service.UserService;
import com.smart.tool.Page;
import org.apache.ibatis.annotations.Param;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.Security;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    @Qualifier("userService")
    private UserService userService;
    @Autowired
    @Qualifier("roleService")
    private RoleService roleService;
    //用户注册
    @RequestMapping(value = "/",method =RequestMethod.POST)
    public String register(User user,Integer role){
        //生成盐(部分，需要存入数据库)
        String salt=new SecureRandomNumberGenerator().nextBytes().toHex();
        //密码加密
        String ciphertext=new Md5Hash(user.getPassword(),salt,1024).toString();
        user.setSalt(salt);
        user.setPassword(ciphertext);
        userService.insertUser(user,role);
        return "redirect:/login.jsp";
    }
    //用户是否被注册
    @RequestMapping(value = "/register",method =RequestMethod.GET)
    @ResponseBody
    public Map<String,Boolean> register1(String  loginName) {
        Map<String,Boolean> map=new HashMap<>();
        Boolean b;
        User user=userService.selectUserByLoginName(loginName);
        if (user!=null){b=true;}
        else {b=false;}
        map.put("success",b);
        return map;

    }
    //登录验证
    @RequestMapping(value = "/",method = RequestMethod.GET)
    public  String login(String loginName, String password, HttpSession session){
        Subject currentUser = SecurityUtils.getSubject();
        if (!currentUser.isAuthenticated()) {
            // 如果没有被认证，开始登录
            if(null == password ||password==""){
                session.setAttribute("error","密码为空！");
                return "redirect:/login.jsp";
            }
            UsernamePasswordToken token = new UsernamePasswordToken(loginName, password);
            try {
                currentUser.login(token);
                //保存用户
                User user=userService.selectUserByLoginName(loginName);
                session.setAttribute("user",user);
            } catch (UnknownAccountException ae) {
                System.out.println("登录失败！" + ae.getMessage());
                session.setAttribute("error","出用户不存在！");
                return "redirect:/login.jsp";

            }
        }
        //跳转获取问卷显示首页
        return "redirect:/main/";
    }
    //进入用户编辑界面
    @RequestMapping(value = "/userEdit",method = RequestMethod.GET)
    public  String userEdit(Page<User> page, Model model){
        if(page.getCurrentPage()==null){
            //登录默认当页为首页
            page.setCurrentPage(1);
        }
        Page<User> newPage=userService.selectUserByPage(page);
        model.addAttribute("newPage",newPage);    //保存用户分页对象

        List<Role> roleList=roleService.getRoles();
        model.addAttribute("roleList",roleList);  //保存所有角色
        return "user/userEdit";
    }
    //更新用户角色
    @RequestMapping(value ="/updateUserRole",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Boolean> updateUserRole(@RequestParam Integer roleId, @RequestParam Integer userId, @RequestParam String loginName ){
        Map<String,Boolean> map=new HashMap<>();
        Boolean b=userService.updateUserRole(roleId,userId,loginName);
        map.put("success",b);
        return map;
    }

    //删除用户
    @RequestMapping(value ="/deleteUser/{userId}",method = RequestMethod.DELETE)
    @ResponseBody
    public  Map<String, Boolean> deleteUser(@PathVariable Integer userId) {
        Map<String, Boolean> map = new HashMap<>();
        Boolean b = userService.deleteUser(userId);
        map.put("success",b);
        return map;
    }
    //退出登录
    @RequestMapping(value = "/logout",method = RequestMethod.GET)
    public  String logout(){
        //获取当前用户主体
        Subject subject= SecurityUtils.getSubject();
        if(subject.isAuthenticated()){
            subject.logout();
        }
        return "redirect:/login.jsp";
    }

}
