package com.smart.dao;

import com.smart.domain.Main;
import com.smart.domain.Message;
import com.smart.domain.User;
import org.apache.ibatis.annotations.Param;

import java.util.HashMap;
import java.util.List;

public interface MainDao {
    //查询问卷总记录数(所有)
    Integer selectMainCount();
    //查询问卷总记录数(已发布)
    Integer selectMainCount1();
    //查询问卷总数(通过mainTitle模糊查询)
    Integer selectMainCount2(@Param("mainTitle") String mainTitle,@Param("mainCreateTime")String mainCreateTime,@Param("mainEndTime")String mainEndTime);
    //查询问卷总记录数(我的)
    Integer selectMainCount3(User user);
    //查询当前页的问卷数据(所有)
    List<Main> selectMainByPage(HashMap<String,Object> map);
    //查询当前页的问卷数据(已发布)
    List<Main> selectMainByPage1(HashMap<String,Object> map);
    //通过mainTitle分页模糊查询问卷
    List<Main> selectMainByTitle(HashMap<String,Object> map);
    //查询当前页的问卷数据(我的)
    List<Main> selectMainByPageAndUser(HashMap<String,Object> map);
    //通过mainId,UserId查询用户是否答过问卷
    Integer isTrueAnswer(@Param("mainId") Integer mainId, @Param("userId") Integer userId);
    //通过mainId获取获取问卷，问题，答案
    Main selectMainById(Integer mainId);
    //通过mainId获取空白问卷
    Main selectMainById1(Integer mainId);
    //增加问卷额外信息
    void insertMessage(@Param("main") Main main, @Param("message1") Message message1);
    //获取问卷额外信息
    List<Message> selectMessage(Integer mainId);
    //增加用户已作答
    void insertAlreadyApply(@Param("mainId")Integer mainId,@Param("userId") Integer userId);
    //修改问卷回答人数
    void updateMainAnswer(Main main);
    //增加一份新问卷
    void insertMain(Main main);
    //修改问卷
    Integer updateMain(Main main);
    //删除一份问卷
    Integer deleteMain(Integer mainId);


}
