import com.smart.dao.RoleUserDao;
import com.smart.dao.UserDao;
import com.smart.domain.Role;
import com.smart.domain.RoleUser;
import com.smart.domain.User;
import com.smart.service.UserService;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.Set;

public class UserTest {

    @Test
    //通过loginName获取user
    public  void selectUserByLoginName() {
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        UserService userService = (UserService) applicationContext.getBean("userService");
        User user =userService.selectUserByLoginName("vip01");
        System.out.print(user);
    }
    @Test
    //通过loginName获取role
    public  void selectRole() {
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        UserService userService = (UserService) applicationContext.getBean("userService");
        Set<String> stringList=userService.selectRoleByLoginName("vip01");
        for(String s:stringList){
            System.out.print(s);
        }
    }
    @Test
    //通过loginName获取permission
    public  void selectPermission() {
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        UserService userService = (UserService) applicationContext.getBean("userService");
        Set<String> stringList=userService.selectPermissionByLoginName("admin");
        stringList.forEach(s -> System.out.println(s));
    }
    @Test
    //数据库密码加密
    public void encrypt(){
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        UserService userService = (UserService) applicationContext.getBean("userService");
        //生成盐(部分，需要存入数据库)
        String salt=new SecureRandomNumberGenerator().nextBytes().toHex();
        String ciphertext=new Md5Hash("123456",salt,1024).toString();
        User user=new User();
        user.setLoginName("201626701121");
        user.setPassword(ciphertext);
        user.setUserName("陈志平");
        user.setEmail("2771109447@qq.com");
        user.setSalt(salt);
        userService.insertUser(user,2);
       System.out.print(user.getUserId());

    }
    @Test

    public  void uu() {
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        UserService userService = (UserService) applicationContext.getBean("userService");
       Boolean b=userService.deleteUser(4);
       System.out.println(b);
    }
}
