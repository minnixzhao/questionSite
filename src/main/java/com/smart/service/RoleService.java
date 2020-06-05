package com.smart.service;

import com.smart.dao.RoleDao;
import com.smart.domain.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleService {
    @Autowired
    private RoleDao roleDao;

    //获取所有角色
    public List<Role> getRoles(){
        return roleDao.getRoles();
    }
    //添加角色
    public Boolean addRole(String roleName,String roleDes){
        int k=0;
        Role role=new Role();
        role.setRoleName(roleName);
        role.setRoleDes(roleDes);
        role.setpId(0);
        role.setAvaliable(0);
       k= roleDao.addRole(role);
       if (k!=0){
        return true;}else {return false;}}
        //修改角色
        public Boolean updateRole(String roleName,String roleDes,Integer pId,Integer roleId){
            int k=0;
            Role role=new Role();
            role.setRoleId(roleId);
            role.setpId(pId);
            role.setRoleName(roleName);
            role.setRoleDes(roleDes);
            role.setAvaliable(0);
            k= roleDao.updateRole(role);
            if (k!=0){
                return true;}else {return false;}
    }
    //删除一名角色
    public Boolean deleteRole(Integer roleId){
        int k=0;
         k=roleDao.deleteRole(roleId);
        if (k!=0){
            return true;}else {return false;}
    }
}
