package com.smart.web;

import com.smart.domain.Permission;
import com.smart.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("permission")
public class PermissionController {
    @Resource
    private PermissionService permissionService;


    //进入权限管理界面
    @RequestMapping(value = "/permission",method = RequestMethod.GET)
    public String permission(){
        return "permission/permission";
    }
    //获取全部权限
    @RequestMapping(value = "/getPermission",method = RequestMethod.GET)
    @ResponseBody
    public List<Permission> getPermission(){
        List<Permission> permissionList=permissionService.getAllPermissions();
        return permissionList;
    }
    //进入添加权限界面
    @RequestMapping(value = "/addPermissionView",method = RequestMethod.GET)
    public String addRoleView(Permission permission, Model model){
        model.addAttribute("permission",permission);
        return "permission/addPermission";
    }
    //进入权限修改界面
    @RequestMapping(value = "/updatePermissionView",method = RequestMethod.GET)
    public String updateRoleView(Permission permission,Model model){
        model.addAttribute("permission",permission);
        return "permission/updatePermission";
    }
    //删除权限
    @RequestMapping(value = "/deletePermission/{permissId}",method = RequestMethod.DELETE)
    @ResponseBody
    public Map<String,Boolean> deleteRoleView(@PathVariable Integer permissId){
        Map<String,Boolean> map=new HashMap<>();
        Boolean b=permissionService.deletePermission(permissId);
        map.put("success",b);
        return map;
    }
    //添加权限
    @RequestMapping(value = "/addPermission",method = RequestMethod.POST)
    public String addRole(Permission permission,Model model){
        Boolean k= permissionService.addPermission(permission);
        if(k){
            model.addAttribute("success", "ok");
            model.addAttribute("msg","保存成功");
        }else {model.addAttribute("success","NO");
            model.addAttribute("msg","保存失败");
        }
        return "permission/addPermission";
    }
    //修改权限
    @RequestMapping(value = "/updatePermission",method = RequestMethod.POST)
    public String updatePermission(Permission permission,Model model){
        Boolean b= permissionService.updatePermission(permission);
        if(b) {
            model.addAttribute("success", "OK");
            model.addAttribute("msg","更新成功");
        }else {model.addAttribute("success","NO");
            model.addAttribute("msg","更新失败");
        }
        return "permission/updatePermission";
    }
}
