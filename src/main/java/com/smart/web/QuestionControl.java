package com.smart.web;

import com.smart.domain.Answer;
import com.smart.domain.Main;
import com.smart.domain.Question;
import com.smart.domain.User;
import com.smart.service.AnswerService;
import com.smart.service.MainService;
import com.smart.service.QuestionService;
import org.apache.shiro.web.session.HttpServletSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/question")
public class QuestionControl {

    @Autowired
    @Qualifier("questionService")
    private QuestionService questionService;
    @Autowired
    @Qualifier("mainService")
    private MainService mainService;
    @Autowired
    @Qualifier("answerService")
    private AnswerService answerService;
    //获取一份问卷及问题
    @RequestMapping(value = "/getMainQuestion/{mainId}",method =RequestMethod.GET)
    public String questionEdit(@PathVariable("mainId") Integer mainId, Model model){

        Map<String,Object> map= mainService.selectMainById(mainId);  //获取问卷，问题
        model.addAttribute("map",map);
        return "weihuMain/editMain";
    }

    //修改并保存一份问卷
    @RequestMapping(value = "/editMain",method =RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> editMain(Integer mainId, String mainTitle, String mainEndTime){
        Map<String,Object> map=new HashMap<>();
        try {
            Main main=new Main();
            main.setMainId(mainId);
            main.setMainTitle(mainTitle);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            main.setMainEndTime(sdf.parse(mainEndTime));
            map.put("success",mainService.updateMain(main));  //修改是否成功
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return map;
    }
    //获取将要修改的问题
    @RequestMapping(value = "/getQuestion/{quesId}",method = RequestMethod.GET)
    @ResponseBody
    public Map<String,Object> getQuestion(@PathVariable("quesId") Integer quesId,Model model){
        Map<String,Object> map=new HashMap<>();
        Question question=  questionService.selectQuestionById(quesId);
        List<Answer> answers =answerService.selectAnswerByQuesId(quesId);
        map.put("question",question);
        map.put("answers",answers);
        return map;
    }
    /**
     *  mainId       问题所在的问卷
     * questionNum  答案个数
     **/
    //修改并保存问题和答案
    @RequestMapping(value = "/editQuestion",method = RequestMethod.POST)
    public  String  editQuestion(Integer mainId,HttpServletRequest request){

        Map<String,String[]> map=new HashMap<>(request.getParameterMap());
        questionService.updateQuestionById(map);
        return "redirect:/question/getMainQuestion/"+mainId;
    }

    //增加问题及答案
    @RequestMapping(value = "/addQuestionAndAnswer",method = RequestMethod.POST)
    public  String  addQuestionAndAnswer(String mainId,HttpServletRequest request){

        Map<String,String[]> map=new HashMap<String,String[]>(request.getParameterMap());
        questionService.addQuestionAndAnswer(map);
        return"redirect:/question/getMainQuestion/"+mainId;
    }
  //删除一个问题及答案
    @RequestMapping(value = "/delQuestion/{quesId}",method = RequestMethod.DELETE)
    @ResponseBody
    public  Map<String,Object> delQuestion(@PathVariable("quesId") Integer quesId,Model model){
        Map<String,Object> map=new HashMap<>();
        boolean b=questionService.deleteQuestionById(quesId);    //是否删除成功
        map.put("success",b);
        return map;
  }

}
