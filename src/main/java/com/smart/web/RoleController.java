package com.smart.web;

import com.smart.domain.Main;
import com.smart.domain.Permission;
import com.smart.domain.PermissionZtree;
import com.smart.domain.Role;
import com.smart.service.PermissionService;
import com.smart.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/role")
public class RoleController {
    @Autowired
    private RoleService roleService;
    @Autowired
    private PermissionService permissionService;
   //进入角色管理界面
   @RequestMapping(value = "/role",method = RequestMethod.GET)
    public String role(){
       return "role/role";
   }
   //获取所有角色
   @RequestMapping(value = "/getRoles",method = RequestMethod.GET)
   @ResponseBody
   public List<Role> getRoles(HttpServletResponse response){
       response.setHeader("Content-type", "text/html;charset=UTF-8");
       List<Role> roleList=roleService.getRoles();
       return roleList;
   }
   //进入全部权限界面（包括被选中）
   @RequestMapping(value = "/editView",method = RequestMethod.GET)
    public String editView(Model model, @RequestParam("roleDes") String roleDes,@RequestParam("roleId")Integer roleId, @RequestParam("roleName") String roleName){
       Role role=new Role();
       role.setRoleId(roleId);
       role.setRoleDes(roleDes);
       role.setRoleName(roleName);
       model.addAttribute("entity",role);
       return "role/role_permiss";
   }
    //返回全部权限（角色对应的被选中）
   @RequestMapping(value = "getTreeCheck",method = RequestMethod.POST)
   @ResponseBody
    public List<PermissionZtree> getPermissions(@RequestParam Integer roleId){
       List<Permission> permissionList=null;
       permissionList= permissionService.getAllPermissions();   //获得全部权限
       return permissionService.checked(permissionList,roleId);  //返回全部权限（角色对应的被选中）
   }

   //更新被选中角色的权限(parm被选中的权限集合)
    @RequestMapping(value = "/updateRolePermiss",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Boolean> addRolePermiss(String parm,Integer roleId,String roleName){
        Map<String,Boolean> map=new HashMap<>();
        String[] Parm=parm.split(",");
        Boolean b= permissionService.updateRolePermiss(roleId,roleName,Parm);
        map.put("success",b);
        return map;
    }
    //进入添加角色界面
    @RequestMapping(value = "/addRoleView",method = RequestMethod.GET)
    public String addRoleView(){
       return "role/addRole";
    }
    //进入修改角色界面
    @RequestMapping(value = "/updateRoleView",method = RequestMethod.GET)
    public String updateRoleView(Integer roleId,Integer pId,String roleName,String roleDes,Model model){
       Role role=new Role();
       role.setRoleName(roleName);
       role.setRoleDes(roleDes);
       role.setRoleId(roleId);
       role.setpId(pId);
       model.addAttribute("role",role);
       return "role/updateRole";
   }
   //删除被选角色
    @RequestMapping(value = "/deleteRoleView/{roleId}",method = RequestMethod.DELETE)
    @ResponseBody
    public Map<String,Boolean> deleteRoleView(@PathVariable Integer roleId){
        Map<String,Boolean> map=new HashMap<>();
        Boolean b=roleService.deleteRole(roleId);
        map.put("success",b);
        return map;
    }

    //添加角色
    @RequestMapping(value = "/addRole",method = RequestMethod.POST)
    public String addRole(String roleName,String roleDes,Model model){
       Boolean b= roleService.addRole(roleName,roleDes);
       if(b) {
           model.addAttribute("success", "OK");
           model.addAttribute("msg","保存成功");
       }else {model.addAttribute("success","NO");
           model.addAttribute("msg","保存失败");
       }
        return "role/addRole";
    }
    //修改角色
    @RequestMapping(value = "/updateRole",method = RequestMethod.POST)
    public String updateRole(String roleName,String roleDes,Integer roleId,Integer pId,Model model){
        Boolean b= roleService.updateRole(roleName,roleDes,pId,roleId);
        if(b){
            model.addAttribute("success", "OK");
            model.addAttribute("msg","更新成功");
        }else {model.addAttribute("success","NO");
            model.addAttribute("msg","更新失败");
        }
        return "role/updateRole";
    }


}
