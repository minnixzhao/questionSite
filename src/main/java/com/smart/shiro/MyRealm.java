package com.smart.shiro;

import com.smart.domain.User;
import com.smart.service.UserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;


public class MyRealm extends AuthorizingRealm {
    @Autowired
    @Qualifier("userService")
    private UserService userService;

    //角色权限获取（获取权限后加载到ehcache缓存管理器中，后面授授权直接到ehcache中获取）
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        //获取登录账号
        String loginName= principalCollection.getPrimaryPrincipal().toString();
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        System.out.print("当前用户："+loginName);
        //获取角色(保存到authorizationInfo的set集合当中)
        authorizationInfo.setRoles(userService.selectRoleByLoginName(loginName));
        //获取权限(保存到authorizationInfo的set集合当中)
        authorizationInfo.setStringPermissions(userService.selectPermissionByLoginName(loginName));
        System.out.print("当前角色："+authorizationInfo.getRoles());
        System.out.print("当前用户所拥有的权限："+authorizationInfo.getStringPermissions());
        return authorizationInfo;

    }

    @Override
    //身份验证
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        // 1.把AuthenticationToken类型的token转换为UsernamePasswordToken
        UsernamePasswordToken upToken = (UsernamePasswordToken) authenticationToken;
        //获取用户账号
        String loginName=upToken.getUsername();
        //验证
        User user= userService.selectUserByLoginName(loginName);
        if(user==null){
            throw new UnknownAccountException("该用户不存在！");
        }
        // 盐值：取用用户的盐值，用于密码匹配算法给前端传过来的密码加密，
        ByteSource Salt =ByteSource.Util.bytes(user.getSalt());
        SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(loginName,user.getPassword(),Salt,getName());
        return info;
    }

}
