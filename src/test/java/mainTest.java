import com.smart.dao.MainDao;
import com.smart.domain.Main;
import com.smart.domain.Message;
import com.smart.service.MainService;
import com.smart.tool.Page;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class mainTest {
    //测试分页
    @Test
    public void select(){
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        MainDao mainDao= (MainDao) applicationContext.getBean("mainDao");
        System.out.println(mainDao.selectMainCount());
        HashMap<String,Object> map=new HashMap<String,Object>();
        map.put("start",2);
        map.put("size",2);
        List<Main> mainList=mainDao.selectMainByPage(map);
        mainList.forEach(main -> System.out.println(main));

        MainService mainService= (MainService) applicationContext.getBean("mainService");
        Page<Main> page=new Page<Main>();
        page.setCurrentPage(1);
        Page<Main> newPage= mainService.selectMainByPage(page);
       newPage.getList().forEach(main -> System.out.println(main));
    }
    //测试用户是否答过问卷
    @Test
    public void select1(){
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        MainService mainService= (MainService) applicationContext.getBean("mainService");
        Boolean b=mainService.isTrueAnswer(2,1);
        System.out.println(b);

    }
    //测试通过mainId查询问卷
    @Test
    public void select2(){
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        MainService mainService= (MainService) applicationContext.getBean("mainService");
        Map<String,Object> map= mainService.selectMainById(1);
        System.out.println(map);

    }
    //测试插入问卷额外信息
    @Test
    public void select3(){
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        MainService mainService= (MainService) applicationContext.getBean("mainService");
        mainService.insertAlreadyApply(2,1);
    }
    @Test
    public void select4(){
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        MainService mainService= (MainService) applicationContext.getBean("mainService");
        List<Message> messageList=mainService.selectMessage(3);
        messageList.forEach(message ->System.out.println(message));
    }
    //更改问卷
    @Test
    public void select5(){
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        MainService mainService= (MainService) applicationContext.getBean("mainService");
        Main main=new Main();
        main.setMainTitle("对软件工程专业的看法??");
        main.setMainId(2);
         boolean b=mainService.updateMain(main);
        System.out.println(b);
    }
}
