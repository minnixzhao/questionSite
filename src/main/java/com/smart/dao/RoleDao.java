package com.smart.dao;

import com.smart.domain.Role;

import java.util.List;

public interface RoleDao {
    //获取所有角色
    List<Role> getRoles();
    //添加角色
    Integer addRole(Role role);
    //修改角色
    Integer updateRole(Role role);
    //删除一名角色
    Integer deleteRole(Integer roleId);
}
