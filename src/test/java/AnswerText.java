import com.smart.domain.Answer;
import com.smart.domain.Question;
import com.smart.service.AnswerService;
import com.smart.service.QuestionService;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

public class AnswerText {
    //通过answerId查询answer
    @Test
    public void text1(){
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        AnswerService answerService= (AnswerService) applicationContext.getBean("answerService");
        List<Answer> answer= answerService.selectAnswerByQuesId(1);
        answer.forEach(answer1 ->System.out.println(answer1));
    }
    //更新answer表
    @Test
    public void text2(){
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        AnswerService answerService= (AnswerService) applicationContext.getBean("answerService");


    }
    //更新question表
    @Test
    public void text3(){
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        QuestionService questionService= (QuestionService) applicationContext.getBean("questionService");

    }
    //插入answer
    @Test
    public void text4(){
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        AnswerService answerService= (AnswerService) applicationContext.getBean("answerService");
        String[] answerText={"爸爸","妈妈"};
        boolean k=answerService.insertAnswer(answerText,6,2);
        System.out.println(k);
    }
}
