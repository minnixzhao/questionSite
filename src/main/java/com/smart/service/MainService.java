package com.smart.service;

import com.smart.dao.AnswerDao;
import com.smart.dao.MainDao;
import com.smart.dao.QuestionDao;
import com.smart.domain.*;
import com.smart.tool.Page;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MainService {
    @Autowired
    private MainDao mainDao;
    @Autowired
    private QuestionDao questionDao;
    @Autowired
    private AnswerDao answerDao;
    //分页查询(所有问卷)
    @Transactional
    public Page<Main> selectMainByPage(Page<Main> page){

        //创建Page对象用来查询分页数据
        Page<Main> newPage =new Page<Main>();
        //封装当前页数
        newPage.setCurrentPage(page.getCurrentPage());
        //封装每页显示的数据
        int pageSize=5;
        newPage.setPageSize(pageSize);
        //封装总记录数
        int totalCount=mainDao.selectMainCount();
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
        List<Main> mainList=mainDao.selectMainByPage(map);
        newPage.setList(mainList);
        return newPage;

    }
    //分页查询(已经发布的问卷)
    public Page<Main> selectMainByPage1(Page<Main> page){

        //创建Page对象用来查询分页数据
        Page<Main> newPage =new Page<Main>();
        //封装当前页数
        newPage.setCurrentPage(page.getCurrentPage());
        //封装每页显示的数据
        int pageSize=5;
        newPage.setPageSize(pageSize);
        //封装总记录数
        int totalCount=mainDao.selectMainCount1();
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
        List<Main> mainList=mainDao.selectMainByPage1(map);
        newPage.setList(mainList);
        return newPage;

    }
    //判断用户是否答过问卷
    @Transactional
    @RequiresRoles(value = "vip",logical = Logical.OR)
    public boolean isTrueAnswer(Integer mainId,Integer userId){
        Integer k=mainDao.isTrueAnswer(mainId,userId);
        //如果查询结果为空，则未答过，否则答过
        boolean b;
        if(k==null){
            b=false;
        }else{
            b=true;
        }
        return b;
    }
    //获取问卷信息，包括question，answer
    //获取每个问题答案被选择的次数总和
    @Transactional
    public Map<String,Object> selectMainById(Integer mainId){
        Map<String,Object> map=new HashMap<>();
        //获取问卷信息
        Main main=mainDao.selectMainById(mainId);
        //获取每个问题答案被选择的次数总和
        Map<Integer,Object> counts = new HashMap<>();
        if(main!=null) {
            for (Question question : main.getQuestionList()) {
                Integer count = 0;
                for (Answer answer : question.getAnswerList()) {
                    count = count + answer.getAnswerValue();
                }
                counts.put(question.getQuesId(), count);
            }
        }
        if(main==null){main=mainDao.selectMainById1(mainId);}
        //将问卷信息，与每个问题答案被选择的次数总和存入map中
        map.put("counts",counts);
        map.put("main",main);
        return map;
    }

    //增加用户已作答
    @Transactional
    public void insertAlreadyApply(Integer mainId,Integer userId){
        mainDao.insertAlreadyApply(mainId,userId);
    }

    //增加问卷信息额外入库
    @Transactional
    public void insertMessage(Main main,String message,String userName){
        Message message1=new Message();
        message1.setMessageText(message);
        message1.setMessageCreater(userName);
        message1.setMessageCreateTime(new Date());
        message1.setMain(main);
        mainDao.insertMessage(main,message1);
    }
    //获取额外信息
    @Transactional
    public List<Message> selectMessage(Integer mainId){
       return mainDao.selectMessage(mainId);
    }
    //增加一份新问卷
    public void insertMain(Main main){
          mainDao.insertMain(main);
    }
    //修改问卷
    public boolean updateMain(Main main){
        Integer k=mainDao.updateMain(main);
        if(k==1){
            return true;
        }else {return false;}
    }
    //删除一份问卷
    @Transactional
    public boolean deleteMain(Integer mainId){
        Main main=mainDao.selectMainById(mainId);
        Integer k= mainDao.deleteMain(mainId);
        Integer t=questionDao.deleteQuestion(mainId);
        Integer n=0;
        if(main!=null){
        for(Question question:main.getQuestionList()){
              n=  answerDao.deleteAnswer(question.getQuesId());

        }}
        if(k!=0||t!=0|| n!=0){return  true;}
        else {
            return  false;}
    }

    //批量删除问卷
    @Transactional
    public boolean deleteBatchMain(String[] mainid){
        Integer k=0;
        Integer t=0;
        Integer n=0;
        for(String mainId:mainid) {
            Main main=mainDao.selectMainById(Integer.valueOf(mainId));
                    k= mainDao.deleteMain(Integer.valueOf(mainId));
                    t=questionDao.deleteQuestion(Integer.valueOf(mainId));

            for(Question question:main.getQuestionList()){
                n=  answerDao.deleteAnswer(question.getQuesId());

            }
        }
        if(k!=0&&t!=0&& n!=0){return  true;}
        else {
            return  false;}
    }
    //拷贝一份问卷
    @Transactional
    public boolean copyMain(User user, Integer mainId){
        Main main=mainDao.selectMainById(mainId);
        main.setMainTitle(main.getMainTitle()+"(副本)");
        main.setMainCreateTime(new Date());
        main.setMainIsuse("n");
        main .setMainCreateUser(user.getUserName());
        mainDao.insertMain(main);
        for(Question question:main.getQuestionList()){
            question.setMain(main);
            questionDao.addQuestion(question);
            for(Answer answer:question.getAnswerList()){
                answer.setQuestion(question);
                answerDao.insertAnswer(answer);
            }
        }
        return true;
    }
    //搜索问卷
    @Transactional
    public Page<Main> selectMainByTitle(Page<Main> page,String mainTitle,String mainCreateTime,String mainEndTime){
        //创建Page对象用来查询分页数据
        Page<Main> newPage =new Page<Main>();
        //封装当前页数
        newPage.setCurrentPage(page.getCurrentPage());
        //封装每页显示的数据
        int pageSize=2;
        newPage.setPageSize(pageSize);
        //封装总记录数
        int totalCount=mainDao.selectMainCount2(mainTitle,mainCreateTime,mainEndTime);
        newPage.setTotalCount(totalCount);
        //封装总页数
        double tc=totalCount;
        Double num=Math.ceil(tc/pageSize);//向上取整
        newPage.setTotalPage(num.intValue());
        //创建map存储start,size用于查询当前页要显示的数据
        HashMap<String,Object> map=new HashMap<String,Object>();
        map.put("start",(page.getCurrentPage()-1)*pageSize);
        map.put("size",newPage.getPageSize());
        map.put("mainTitle",mainTitle);
        map.put("mainCreateTime",mainCreateTime);
        map.put("mainEndTime",mainEndTime);
        //封装当前页要显示的数据
        List<Main> mainList=mainDao.selectMainByTitle(map);
        newPage.setList(mainList);
        return newPage;

    }
    //分页查询(我的问卷)
    public Page<Main> selectMainByPageAndUser(Page<Main> page,User user){
        //创建Page对象用来查询分页数据
        Page<Main> newPage =new Page<Main>();
        //封装当前页数
        newPage.setCurrentPage(page.getCurrentPage());
        //封装每页显示的数据
        int pageSize=2;
        newPage.setPageSize(pageSize);
        //封装总记录数
        int totalCount=mainDao.selectMainCount3(user);
        newPage.setTotalCount(totalCount);
        //封装总页数
        double tc=totalCount;
        Double num=Math.ceil(tc/pageSize);//向上取整
        newPage.setTotalPage(num.intValue());
        //创建map存储start,size用于查询当前页要显示的数据
        HashMap<String,Object> map=new HashMap<String,Object>();
        map.put("start",(page.getCurrentPage()-1)*pageSize);
        map.put("size",newPage.getPageSize());
        map.put("user",user);
        //封装当前页要显示的数据
        List<Main> mainList=mainDao.selectMainByPageAndUser(map);
        newPage.setList(mainList);
        return newPage;

    }
}
