package com.smart.dao;


import com.smart.domain.Permission;
import com.smart.domain.Role;
import com.smart.domain.User;

import java.util.HashMap;
import java.util.List;
import java.util.Set;


public interface UserDao {
    //通过loginName获取user
    User selectUserByLoginName(String loginName);
    //插入一名用户
    Integer insertUser(User user);
    //通过loginName获取角色
    Set<String> selectRoleByLoginName(String loginName);
    //通过loginName获取权限
    Set<String> selectPermissionByLoginName(String loginName);
    //获取用户总数（全部）
    Integer selectUserCount();
    //获取当前页的用户数据（全部）
    List<User> selectUserByPage(HashMap<String,Object> map);
    //删除用户
    Integer deleteUser(Integer userId);
}
