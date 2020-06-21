/*
 Navicat Premium Data Transfer

 Source Server         : mysql8.0
 Source Server Type    : MySQL
 Source Server Version : 80013
 Source Host           : localhost:3306
 Source Schema         : questionnaire

 Target Server Type    : MySQL
 Target Server Version : 80013
 File Encoding         : 65001

 Date: 03/06/2019 12:44:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for qu_answer
-- ----------------------------
DROP TABLE IF EXISTS `qu_answer`;
CREATE TABLE `qu_answer`  (
  `answerId` int(11) NOT NULL AUTO_INCREMENT,
  `answerValue` int(11) DEFAULT 0 COMMENT '回答次数',
  `answerDesType` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '文字描述',
  `answerSum` decimal(7,2)  DEFAULT 0 COMMENT '回答的值总和',
  `answerCreateTime` datetime(0) DEFAULT NULL COMMENT '回答时间',
  `ques_id` int(11) DEFAULT NULL COMMENT '(外键)问题表主键',
  PRIMARY KEY (`answerId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qu_answer
-- ----------------------------
INSERT INTO `qu_answer` VALUES (1, 0,  '大', 0, '2019-04-21 12:12:19', 1);
INSERT INTO `qu_answer` VALUES (2, 0,  '不大', 0, '2019-04-21 12:14:42', 1);
INSERT INTO `qu_answer` VALUES (3, 0,  '高中', 0, '2019-04-21 12:14:47', 2);
INSERT INTO `qu_answer` VALUES (4, 0,  '大学', 0, '2019-04-21 12:14:52', 2);
INSERT INTO `qu_answer` VALUES (5, 0,  '毕业之后', 0, '2019-04-21 12:15:20', 2);
INSERT INTO `qu_answer` VALUES (6, 0,  '喜欢', 0, '2019-04-21 12:15:18', 3);
INSERT INTO `qu_answer` VALUES (7, 0,  '不喜欢', 0, '2019-04-21 12:15:15', 3);
INSERT INTO `qu_answer` VALUES (8, 0,  '10~15周岁', 0, '2019-04-21 12:15:24', 4);
INSERT INTO `qu_answer` VALUES (9, 0,  '16~20周岁', 0, '2019-04-21 12:14:58', 4);
INSERT INTO `qu_answer` VALUES (10, 0,  '20周岁之后', 0, '2019-04-21 12:15:12', 4);
INSERT INTO `qu_answer` VALUES (11, 0,  '充足', 0, '2019-04-21 12:15:09', 5);
INSERT INTO `qu_answer` VALUES (12, 0,  '不充足', 0, '2019-04-21 12:15:07', 5);
INSERT INTO `qu_answer` VALUES (13, 0,  '5~7小时', 0, '2019-04-21 12:15:04', 6);
INSERT INTO `qu_answer` VALUES (14, 0,  '7~9小时', 0, '2019-04-21 12:15:01', 6);
INSERT INTO `qu_answer` VALUES (15, 0,  '9小时以上', 0, '2019-04-21 12:14:56', 6);
INSERT INTO `qu_answer` VALUES (16, 0,  '弊', 0, '2019-05-17 11:34:30', 7);
INSERT INTO `qu_answer` VALUES (17, 0,  '利', 0, '2019-05-17 11:34:30', 7);
INSERT INTO `qu_answer` VALUES (18, 0,  '2小时以下', 0, '2019-05-17 12:03:51', 8);
INSERT INTO `qu_answer` VALUES (19, 0,  '2-4小时', 0, '2019-05-17 12:03:51', 8);
INSERT INTO `qu_answer` VALUES (20, 0,  '4小时以上', 0, '2019-05-17 12:03:51', 8);
INSERT INTO `qu_answer` VALUES (21, 0,  '早上', 0, '2019-05-17 12:03:51', 11);
INSERT INTO `qu_answer` VALUES (22, 0,  '下午', 0, '2019-05-17 12:03:51', 11);
INSERT INTO `qu_answer` VALUES (23, 0,  '晚上', 0, '2019-05-17 12:03:51', 11);

-- ----------------------------
-- Table structure for qu_main
-- ----------------------------
DROP TABLE IF EXISTS `qu_main`;
CREATE TABLE `qu_main`  (
  `mainId` int(11) NOT NULL AUTO_INCREMENT,
  `mainTitle` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '问卷标题',
  `mainCreateTime` datetime(0) DEFAULT NULL COMMENT '问卷创建时间',
  `mainIsuse` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '是否使用',
  `mainEndTime` date DEFAULT NULL COMMENT '问卷截止时间',
  `times` int(11) NOT NULL COMMENT '最大回答次数',
  `needRegister` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '是否需要注册',
  `mainCreateUser` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '问卷创建人',
  `mainAnswer` int(11) DEFAULT 0 COMMENT '作答问卷总人数',
  PRIMARY KEY (`mainId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qu_main
-- ----------------------------
INSERT INTO `qu_main` VALUES (1, '关于大学生是否恋爱问卷调查', '2020-05-01 11:48:52', 'y', '2020-07-01',100,'y', '凉宫春日', 0);
INSERT INTO `qu_main` VALUES (2, '对软件工程专业的看法', '2020-05-01 11:52:07', 'y', '2020-07-28', 100,'y','阿虚', 0);
INSERT INTO `qu_main` VALUES (3, '大学生睡眠质量统计', '2020-05-02 11:54:16', 'y', '2020-07-25', 100,'y','凉宫春日', 0);
INSERT INTO `qu_main` VALUES (4, '网络对大学生的影响', '2020-05-02 11:32:51', 'n', '2020-12-31', 100,'y','阿虚', 0);
INSERT INTO `qu_main` VALUES (5, '关于大学生学习的调查', '2020-06-02 11:32:51', 'n', '2020-12-31', 100,'y','阿虚', 0);

-- ----------------------------
-- Table structure for qu_message
-- ----------------------------
DROP TABLE IF EXISTS `qu_message`;
CREATE TABLE `qu_message`  (
  `messageId` int(11) NOT NULL AUTO_INCREMENT,
  `messageText` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '意见内容',
  `messageCreater` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建人',
  `messageCreateTime` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `main_id` int(11) DEFAULT NULL COMMENT '(外键)问卷主键',
  PRIMARY KEY (`messageId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qu_message
-- ----------------------------
INSERT INTO `qu_message` VALUES (1, 'very nice', '古泉一树', '2020-06-03 01:40:42', 4);

-- ----------------------------
-- Table structure for qu_question
-- ----------------------------
DROP TABLE IF EXISTS `qu_question`;
CREATE TABLE `qu_question`  (
  `quesId` int(11) NOT NULL AUTO_INCREMENT,
  `quesTitle` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '问题标题',
  `quesCreateTime` datetime(0) DEFAULT NULL COMMENT '问题创建时间',
  `quesType` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '问题类型',
  `main_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`quesId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qu_question
-- ----------------------------
INSERT INTO `qu_question` VALUES (1, '恋爱对学习影响大不大？', '2019-04-21 12:04:10', 'radio', 1);
INSERT INTO `qu_question` VALUES (2, '你认为学生哪个阶段恋爱合适？', '2019-04-21 12:05:47', 'check', 1);
INSERT INTO `qu_question` VALUES (3, '你喜欢软件工程这个专业吗？', '2019-04-21 12:06:31', 'radio', 2);
INSERT INTO `qu_question` VALUES (4, '您认为哪个年龄段适合IT行业？', '2019-04-21 12:07:08', 'check', 2);
INSERT INTO `qu_question` VALUES (5, '你的睡眠质量充足吗？', '2019-04-21 12:07:12', 'radio', 3);
INSERT INTO `qu_question` VALUES (6, '你认为大学生合适的睡眠时间？', '2019-04-21 12:07:16', 'check', 3);
INSERT INTO `qu_question` VALUES (7, '你认为网络对大学生利大？还是弊大？', '2019-05-17 11:34:30', 'radio', 4);
INSERT INTO `qu_question` VALUES (8, '你每天上网时间', '2019-05-17 12:03:51', 'check', 4);
INSERT INTO `qu_question` VALUES (9, '随便聊聊', '2019-05-17 12:03:51', 'text', 5);
INSERT INTO `qu_question` VALUES (10, '对自己学习评价', '2019-05-17 12:03:51', 'decimal', 5);
INSERT INTO `qu_question` VALUES (11, ' 你喜欢什么时候学习', '2019-05-17 12:03:51', 'radio', 5);


-- ----------------------------
-- Table structure for qu_user_main
-- 是否回答过某个问卷
-- ----------------------------
DROP TABLE IF EXISTS `qu_user_main`;
CREATE TABLE `qu_user_main`  (
  `umId` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `main_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`umId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qu_user_main
-- ----------------------------


-- ----------------------------
-- Table structure for sys_permiss
-- ----------------------------
DROP TABLE IF EXISTS `sys_permiss`;
CREATE TABLE `sys_permiss`  (
  `permissId` int(11) NOT NULL AUTO_INCREMENT,
  `permissName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `permissDes` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `pId` int(11) DEFAULT NULL,
  `avaliable` tinyint(255) DEFAULT 0,
  PRIMARY KEY (`permissId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_permiss
-- ----------------------------
INSERT INTO `sys_permiss` VALUES (1, 'father1', '问卷模块权限', 0, 0);
INSERT INTO `sys_permiss` VALUES (2, '/questionnaire/vote', '问卷投票', 1, 0);
INSERT INTO `sys_permiss` VALUES (3, '/result/see', '查看调查结果（全）', 1, 0);
INSERT INTO `sys_permiss` VALUES (4, 'father1.1', '维护问卷（admin)', 1, 0);
INSERT INTO `sys_permiss` VALUES (5, 'father1.2', '我的问卷（admin,draftsman）', 1, 0);
INSERT INTO `sys_permiss` VALUES (6, 'father2', '用户管理模块权限（admin）', 0, 0);
INSERT INTO `sys_permiss` VALUES (7, 'father3', '角色管理模块权限（admin）', 0, 0);
INSERT INTO `sys_permiss` VALUES (8, 'father4', '权限管理模块权限（admin）', 0, 0);
INSERT INTO `sys_permiss` VALUES (9, '/questionnaire/create', '创建问卷（admin,draftsman）', 1, 0);
INSERT INTO `sys_permiss` VALUES (10, '/questionnaire/delete', '删除问卷（admin,draftsman）', 1, 0);
INSERT INTO `sys_permiss` VALUES (11, '/questionnaire/search', '搜索问卷（admin,draftsman）', 1, 0);
INSERT INTO `sys_permiss` VALUES (12, '/questionnaire/update', '修改问卷（admin,draftsman）', 1, 0);
INSERT INTO `sys_permiss` VALUES (13, '/questionnaire/add', '发布问卷（admin,draftsman）', 1, 0);
INSERT INTO `sys_permiss` VALUES (14, '/questionnaire/stop', '停止问卷（admin,draftsman）', 1, 0);
INSERT INTO `sys_permiss` VALUES (15, '/questionnaire/copy', '复制问卷（admin,draftsman）', 1, 0);
INSERT INTO `sys_permiss` VALUES (16, '/user/delete', '删除用户（admin）', 6, 0);
INSERT INTO `sys_permiss` VALUES (17, '/role/distribute', '角色分配（admin）', 6, 0);
INSERT INTO `sys_permiss` VALUES (18, '/role/add', '角色添加（admin）', 7, 0);
INSERT INTO `sys_permiss` VALUES (19, '/role/update', '角色修改（admin）', 7, 0);
INSERT INTO `sys_permiss` VALUES (20, '/role/delete', '角色删除·（admin）', 7, 0);
INSERT INTO `sys_permiss` VALUES (21, '/permission/add', '权限添加（admin）', 8, 0);
INSERT INTO `sys_permiss` VALUES (22, '/permission/update', '权限修改（admin）', 8, 0);
INSERT INTO `sys_permiss` VALUES (23, '/permission/delete', '权限删除（admin）', 8, 0);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `roleId` int(11) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '角色名字',
  `roleDes` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '角色描述',
  `pId` int(11) DEFAULT NULL COMMENT '父节点',
  `avaliable` tinyint(1) DEFAULT 0 COMMENT '是否锁定',
  PRIMARY KEY (`roleId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, 'admin', '管理员', 0, 0);
INSERT INTO `sys_role` VALUES (2, 'vip', '会员', 0, 0);
INSERT INTO `sys_role` VALUES (3, 'draftsman', '起草人', 0, 0);

-- ----------------------------
-- Table structure for sys_role_permiss
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permiss`;
CREATE TABLE `sys_role_permiss`  (
  `rpId` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL,
  `permiss_id` int(11) DEFAULT NULL,
  `roleName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`rpId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_permiss
-- ----------------------------
INSERT INTO `sys_role_permiss` VALUES (3, 2, 3, 'vip');
INSERT INTO `sys_role_permiss` VALUES (6, 3, 9, 'draftsman');
INSERT INTO `sys_role_permiss` VALUES (7, 3, 10, 'draftsman');
INSERT INTO `sys_role_permiss` VALUES (8, 3, 11, 'draftsman');
INSERT INTO `sys_role_permiss` VALUES (9, 3, 12, 'draftsman');
INSERT INTO `sys_role_permiss` VALUES (10, 3, 13, 'draftsman');
INSERT INTO `sys_role_permiss` VALUES (11, 3, 14, 'draftsman');
INSERT INTO `sys_role_permiss` VALUES (12, 3, 15, 'draftsman');
INSERT INTO `sys_role_permiss` VALUES (16, 1, 4, 'admin');
INSERT INTO `sys_role_permiss` VALUES (17, 1, 5, 'admin');
INSERT INTO `sys_role_permiss` VALUES (18, 1, 7, 'admin');
INSERT INTO `sys_role_permiss` VALUES (19, 1, 8, 'admin');
INSERT INTO `sys_role_permiss` VALUES (20, 1, 9, 'admin');
INSERT INTO `sys_role_permiss` VALUES (21, 1, 10, 'admin');
INSERT INTO `sys_role_permiss` VALUES (22, 1, 11, 'admin');
INSERT INTO `sys_role_permiss` VALUES (23, 1, 12, 'admin');
INSERT INTO `sys_role_permiss` VALUES (24, 1, 13, 'admin');
INSERT INTO `sys_role_permiss` VALUES (25, 1, 14, 'admin');
INSERT INTO `sys_role_permiss` VALUES (26, 1, 15, 'admin');
INSERT INTO `sys_role_permiss` VALUES (27, 1, 16, 'admin');
INSERT INTO `sys_role_permiss` VALUES (28, 1, 17, 'admin');
INSERT INTO `sys_role_permiss` VALUES (29, 1, 18, 'admin');
INSERT INTO `sys_role_permiss` VALUES (30, 1, 19, 'admin');
INSERT INTO `sys_role_permiss` VALUES (31, 1, 20, 'admin');
INSERT INTO `sys_role_permiss` VALUES (32, 1, 21, 'admin');
INSERT INTO `sys_role_permiss` VALUES (33, 1, 22, 'admin');
INSERT INTO `sys_role_permiss` VALUES (34, 1, 23, 'admin');
INSERT INTO `sys_role_permiss` VALUES (35, 1, 24, 'admin');
INSERT INTO `sys_role_permiss` VALUES (42, 3, 5, 'draftsman');
INSERT INTO `sys_role_permiss` VALUES (51, 2, 2, 'vip');
INSERT INTO `sys_role_permiss` VALUES (54, 1, 6, 'admin');
INSERT INTO `sys_role_permiss` VALUES (57, 2, 1, 'vip');
INSERT INTO `sys_role_permiss` VALUES (59, 3, 3, 'draftsman');
INSERT INTO `sys_role_permiss` VALUES (60, 1, 3, 'admin');
INSERT INTO `sys_role_permiss` VALUES (61, 1, 2, 'admin');
INSERT INTO `sys_role_permiss` VALUES (62, 1, 1, 'admin');
INSERT INTO `sys_role_permiss` VALUES (63, 3, 2, 'draftsman');
INSERT INTO `sys_role_permiss` VALUES (64, 3, 1, 'draftsman');

-- ----------------------------
-- Table structure for sys_role_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_user`;
CREATE TABLE `sys_role_user`  (
  `ruId` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `loginName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`ruId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_user
-- ----------------------------
INSERT INTO `sys_role_user` VALUES (2, 2, 2, 'vip001');
INSERT INTO `sys_role_user` VALUES (3, 3, 3, 'draftsman1');
INSERT INTO `sys_role_user` VALUES (4, 4, 1, 'admin1');


-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `loginName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户账号',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户密码',
  `userName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户名',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '邮箱',
  `salt` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '盐值',
  `locked` tinyint(1) DEFAULT 0 COMMENT '是否锁定',
  PRIMARY KEY (`userId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (2, 'vip001', '79ee9045017fac5f8c38e656829cdf6e', '古泉一树', '344720672@qq.com', '4181b7ab5755630169abd52e16ca6bc0', 0);
INSERT INTO `sys_user` VALUES (4, 'admin2', '8c85631fe9269f3130ee9cd9f6eb0926', '凉宫春日', 'minnix.zhao@qq.com', 'c26f74251d9790d034ed7b52ee6d44bb', 0);
INSERT INTO `sys_user` VALUES (3, 'draftsman1', 'e58d182651a0fe3703aeac18511cd9be', '阿虚', 'minnix.zhao@foxmail.com', '3e9e6f1b55a4a114da8c1c09a1212c0b', 0);


SET FOREIGN_KEY_CHECKS = 1;
