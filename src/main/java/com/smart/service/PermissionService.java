package com.smart.service;

import com.smart.dao.PermissionDao;
import com.smart.domain.Permission;
import com.smart.domain.PermissionZtree;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class PermissionService {
    @Autowired
    private PermissionDao permissionDao;

    //获取所有权限
    public List<Permission> getAllPermissions(){
        return permissionDao.getAllPermissions();
    }
    //获取所有权限树节点（被选中角色权限已选择checked=true）
    @Transactional
    public List<PermissionZtree> checked(List<Permission> permissionList,Integer roleId ){
        List<PermissionZtree> permissionZtreeList=new ArrayList<PermissionZtree>();    //存放权限树节点（包含checked属性）
        List<Permission> permissionList1;
        permissionList1  =permissionDao.checked(roleId);  //用于存放角色对应的权限
        for(int k=0;k<permissionList.size();k++){
            PermissionZtree permissionZtree=new PermissionZtree();   //创建一个权限树节点,依次复值
                           permissionZtree.setId(permissionList.get(k).getPermissId());
                           permissionZtree.getPermissZtreeName(permissionList.get(k).getPermissName());
                           permissionZtree.setName(permissionList.get(k).getPermissDes());
                           permissionZtree.setpId1(permissionList.get(k).getpId());
                           permissionZtree.setAvaliable2(permissionList.get(k).getAvaliable());
               for(int i=0;i<permissionList1.size();i++){
                        String a=permissionList.get(k).getPermissName();
                        String b=permissionList1.get(i).getPermissName();
                   if(a.equals(b)){
                       permissionZtree.setChecked(true);  //权限被选中
                       break;
                   }else{
                       permissionZtree.setChecked(false);
                   }
               }
               permissionZtreeList.add(permissionZtree);
        }
         return permissionZtreeList;
    }
//被选中角色修改后的权限
    @Transactional
    public Boolean updateRolePermiss(Integer roleId,String roleName,String[] Parm){
         int k=0;
         List<Permission> permissionList=permissionDao.checked(roleId);
         Set<Integer> set=new HashSet<>();
         Set<Integer> set1=new HashSet<>();
        Set<Integer> sett=new HashSet<>();
        Set<Integer> sett1=new HashSet<>();
         for (int i=0;i<permissionList.size();i++){    //将已有的权限id保存到set集合中
             set.add(permissionList.get(i).getPermissId());
         }
         for(int i=0;i<Parm.length;i++){               //将被选中的权限id保存到set集合中
             set1.add(Integer.valueOf(Parm[i]));
         }
        for (int i=0;i<permissionList.size();i++){    //将已有的权限id保存到set集合中
            sett.add(permissionList.get(i).getPermissId());
        }
        for(int i=0;i<Parm.length;i++){               //将被选中的权限id保存到set集合中
            sett1.add(Integer.valueOf(Parm[i]));
        }
         int m=addRolePermiss(set1,set,roleId,roleName);   //增加
         int n=deleteRolePermiss(sett1,sett,roleId,roleName);  //删除
        return true;
    }
    //添加角色对应权限
    @Transactional
    public Integer addRolePermiss(Set<Integer> set1,Set<Integer> set,Integer roleId,String roleName){
        int k=0;
        set1.removeAll(set);           //新增权限
        set1.forEach(integer -> System.out.println(integer));
        for(Integer permissId:set1){
            if(set1!=null){
                permissionDao.addRolePermiss(permissId,roleId,roleName);
                k++;
            }
        }
        return k;
    }
    //删除角色对应权限
    @Transactional
    public Integer deleteRolePermiss(Set<Integer> sett1,Set<Integer> sett,Integer roleId,String roleName){
        int k=0;
        sett.removeAll(sett1);           //新增权限
        sett.forEach(integer -> System.out.println(integer));
        for(Integer permissId:sett){
            if(sett!=null){
                permissionDao.deleteRolePermiss(permissId,roleId);
                k++;
            }
        }
        return k;
    }
    //添加权限
    @Transactional
    public Boolean addPermission(Permission permission){
        int k=0;

        permission.setAvaliable(0);
        k=permissionDao.addPermission(permission);
        if(k!=0){return true;}
        else {
            return false;
        }
    }
    //删除权限
    public Boolean deletePermission(Integer permissId){
        int k=0;

         k=permissionDao.deletePermission(permissId)+ permissionDao.deletePermissionByPid(permissId);
        if(k!=0){return true;}
        else {
            return false;
        }
    }
    //修改权限
    public Boolean updatePermission(Permission permission){
        int k=0;
       k= permissionDao.updatePermission(permission);
        if(k!=0){return true;}
        else {
            return false;
        }
    }
}
