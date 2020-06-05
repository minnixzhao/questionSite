package com.smart.dao;

import com.smart.domain.Permission;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PermissionDao {
    //获得所有权限
    List<Permission> getAllPermissions();
    //角色对应的权限
    List<Permission> checked(Integer roleName);
    //增加角色对应权限
    Integer addRolePermiss(@Param("permissId") Integer permissId, @Param("roleId") Integer roleId,@Param("roleName") String roleName);
    //删除角色对应权限
    Integer deleteRolePermiss(@Param("permissId") Integer permissId ,@Param("roleId") Integer roleId);
    //增加权限
    Integer addPermission(Permission permission);
    //修改权限
    Integer updatePermission(Permission permission);
    //删除权限
    Integer deletePermission(Integer permissId);
    //删除权限
    Integer deletePermissionByPid(Integer pId);
}
