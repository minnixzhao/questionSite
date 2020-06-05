package com.smart.service;

import com.smart.dao.RoleUserDao;
import com.smart.dao.UserDao;
import com.smart.domain.Role;
import com.smart.domain.RoleUser;
import com.smart.domain.User;
import com.smart.tool.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Set;

@Service

public class UserService {

    @Autowired
    private UserDao userDao;
    @Autowired
    private  RoleUserDao roleUserDao;
    //通过loginName获取user
    public User selectUserByLoginName(String loginName){
        return userDao.selectUserByLoginName(loginName);
    }
    //插入一条用户以及对应的角色
    @Transactional
    public void insertUser(User user,Integer role){
        userDao.insertUser(user);
        RoleUser roleUser=new RoleUser();
        if(role==0) {
            roleUser.setRoleId(2); //注册用户为会员
        }
        if(role==1)
        {roleUser.setRoleId(3);}     //注册用户为起草人
        roleUser.setUserId(user.getUserId());
        roleUser.setLoginName(user.getLoginName());
        roleUserDao.insertRoleUser(roleUser);
    }
    //通过loginName获取角色
    public Set<String> selectRoleByLoginName(String loginName){
        return userDao.selectRoleByLoginName(loginName);
    }
    //通过loginName获取权限
    public Set<String> selectPermissionByLoginName(String loginName){
        return  userDao.selectPermissionByLoginName(loginName);
    }
   //分页查询（所有用户）
   @Transactional
   public Page<User> selectUserByPage(Page<User> page){

       //创建Page对象用来查询分页数据
       Page<User> newPage =new Page<User>();
       //封装当前页数
       newPage.setCurrentPage(page.getCurrentPage());
       //封装每页显示的数据
       int pageSize=5;     //(待修改/////////////////////////////////)
       newPage.setPageSize(pageSize);
       //封装总记录数
       int totalCount=userDao.selectUserCount();
       newPage.setTotalCount(totalCount);
       //封装总页数
       double tc=totalCount;
       Double num=Math.ceil(tc/pageSize);//向上取整
       newPage.setTotalPage(num.intValue());
       //创建map存储start,size用于查询当前页要显示的数据
       HashMap<String,Object> map=new HashMap<String,Object>();
       map.put("start",(page.getCurrentPage()-1)*pageSize);
       map.put("size",newPage.getPageSize());
       //封装当前页要显示的数据
       List<User> userList=userDao.selectUserByPage(map);
       newPage.setList(userList);
       return newPage;
   }
   //更新用户对应的角色
    @Transactional
    public Boolean updateUserRole(Integer roleId,Integer userId,String loginName){
        int k=0;
        RoleUser roleUser=new RoleUser();
        roleUser.setRoleId(roleId);
        roleUser.setUserId(userId);
        roleUser.setLoginName(loginName);
        k=roleUserDao.updateUserRole(roleUser);
        if(k!=0){
            return true;
        }else { return false;}
    }
    //删除用户
    @Transactional
    public Boolean deleteUser(Integer userId){
        int k=0;
        int n=0;
        k=userDao.deleteUser(userId);
        n=roleUserDao.deleteUserRole(userId);
        if (k!=0&&n!=0){ return true;}else{return false;}
    }
}
