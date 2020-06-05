# questionnaire
## 问卷调查权限管理系统（ssm+shiro）
问卷调查系统是一款基于不同用户角色参与不同系统功能的问卷调查平台，用的技术框架是spring ，spring mvc，mybatis;此系统分为两大模核心块，一模块是<b>问卷调查</b>，另一模块是<b>权限管理</b>；另外，每个模块涵盖了不同的业务功能，并且此系统共有三类角色用户，分别是**普通用户，起草人，管理员**，并且不同角色对应不同的用户权限。  
**windows10/centos7环境：**

```
JDK 1.8
Tomcat 8.5.3 
Maven 3.6.0 
MySQL 8.1.7
```
**工具**
```
Intellij IDEA 2018 2
Navicat 12
Postman
```
**后端技术**  
 >spring  
 >spring mvc  
 >mybatis   
 >shiro
 
**前端技术**  
 >bootstrap ui  
 >jquery  
 >ztree.js   
 
### 业务模块
角色 | 普通用户 | 起草人 |管理员
-----|---------|--------|------|
权限  |问卷调查模块 |问卷管理模块<br>问卷调查模块|问卷调查模块<br>用户管理模块<br>角色管理模块<br>权限管理模块 |
### 功能模块
![ ](https://img-blog.csdnimg.cn/20190819124114583.jpg)
