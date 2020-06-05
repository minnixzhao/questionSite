package com.smart.dao;

import com.smart.domain.RoleUser;

public interface RoleUserDao {
    //插入用户角色
    void insertRoleUser(RoleUser roleUser);
    //更新用户角色
    Integer updateUserRole(RoleUser roleUser);
    //删除用户对应角色
    Integer deleteUserRole(Integer userId);

}
