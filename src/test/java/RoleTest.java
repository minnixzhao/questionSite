import com.smart.domain.Permission;
import com.smart.domain.PermissionZtree;
import com.smart.domain.Role;
import com.smart.service.PermissionService;
import com.smart.service.RoleService;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

public class RoleTest {
    @Test
    //获取所有角色
    public  void getRoles() {
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        RoleService roleService = (RoleService) applicationContext.getBean("roleService");
        List<Role> roleList =roleService.getRoles();
        roleList.forEach(role -> System.out.println(role));
    }
    //角色对应权限
    @Test
    public  void gd() {
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        PermissionService permissionService = (PermissionService) applicationContext.getBean("permissionService");
        List<Permission> permissionList=permissionService.getAllPermissions();
        List<PermissionZtree> permissionZtreeList =permissionService.checked(permissionList,2);
        permissionZtreeList.forEach(permissionZtree -> System.out.println(permissionZtree));
    }
    @Test
    public  void gg(){
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        PermissionService permissionService = (PermissionService) applicationContext.getBean("permissionService");
        String[] Parm={"3","2","1"};
        Boolean b=permissionService.updateRolePermiss(2,"vip",Parm);
        System.out.println(b);
    }
}
