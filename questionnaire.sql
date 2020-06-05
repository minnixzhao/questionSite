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
  `answerType` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '有无附件',
  `answerDesType` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '文字描述',
  `answerText` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '附件路径',
  `answerCreateTime` datetime(0) DEFAULT NULL COMMENT '回答时间',
  `ques_id` int(11) DEFAULT NULL COMMENT '(外键)问题表主键',
  PRIMARY KEY (`answerId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qu_answer
-- ----------------------------
INSERT INTO `qu_answer` VALUES (1, 0, 'n', '大', '/', '2019-04-21 12:12:19', 1);
INSERT INTO `qu_answer` VALUES (2, 0, 'n', '不大', '/', '2019-04-21 12:14:42', 1);
INSERT INTO `qu_answer` VALUES (3, 0, 'n', '高中', '/', '2019-04-21 12:14:47', 2);
INSERT INTO `qu_answer` VALUES (4, 0, 'n', '大学', '/', '2019-04-21 12:14:52', 2);
INSERT INTO `qu_answer` VALUES (5, 0, 'n', '毕业之后', '/', '2019-04-21 12:15:20', 2);
INSERT INTO `qu_answer` VALUES (6, 0, 'n', '喜欢', '/', '2019-04-21 12:15:18', 3);
INSERT INTO `qu_answer` VALUES (7, 0, 'n', '不喜欢', '/', '2019-04-21 12:15:15', 3);
INSERT INTO `qu_answer` VALUES (8, 0, 'n', '10~15周岁', '/', '2019-04-21 12:15:24', 4);
INSERT INTO `qu_answer` VALUES (9, 0, 'n', '16~20周岁', '/', '2019-04-21 12:14:58', 4);
INSERT INTO `qu_answer` VALUES (10, 0, 'n', '20周岁之后', '/', '2019-04-21 12:15:12', 4);
INSERT INTO `qu_answer` VALUES (11, 0, 'n', '充足', '/', '2019-04-21 12:15:09', 5);
INSERT INTO `qu_answer` VALUES (12, 0, 'n', '不充足', '/', '2019-04-21 12:15:07', 5);
INSERT INTO `qu_answer` VALUES (13, 0, 'n', '5~7小时', '/', '2019-04-21 12:15:04', 6);
INSERT INTO `qu_answer` VALUES (14, 0, 'n', '7~9小时', '/', '2019-04-21 12:15:01', 6);
INSERT INTO `qu_answer` VALUES (15, 0, 'n', '9小时以上', '/', '2019-04-21 12:14:56', 6);
INSERT INTO `qu_answer` VALUES (16, 0, 'n', '弊', '/', '2019-05-17 11:34:30', 32);
INSERT INTO `qu_answer` VALUES (17, 0, 'n', '利', '/', '2019-05-17 11:34:30', 32);
INSERT INTO `qu_answer` VALUES (18, 0, 'n', '2小时以下', '/', '2019-05-17 12:03:51', 36);
INSERT INTO `qu_answer` VALUES (19, 0, 'n', '2-4小时', '/', '2019-05-17 12:03:51', 36);
INSERT INTO `qu_answer` VALUES (20, 0, 'n', '4小时以上', '/', '2019-05-17 12:03:51', 36);

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
  `mainCreateUser` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '问卷创建人',
  `mainAnswer` int(11) DEFAULT 0 COMMENT '作答问卷总人数',
  PRIMARY KEY (`mainId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qu_main
-- ----------------------------
INSERT INTO `qu_main` VALUES (1, '关于大学生是否恋爱问卷调查', '2019-04-21 11:48:52', 'y', '2019-07-01', '陈志平', 0);
INSERT INTO `qu_main` VALUES (2, '对软件工程专业的看法', '2019-04-21 11:52:07', 'y', '2019-07-28', '陈志平', 0);
INSERT INTO `qu_main` VALUES (3, '大学生睡眠质量统计', '2019-04-22 11:54:16', 'y', '2019-07-25', '龚超', 0);
INSERT INTO `qu_main` VALUES (30, '网络对大学生的影响', '2019-05-17 11:32:51', 'n', '2019-12-31', '管理员', 0);

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
INSERT INTO `qu_message` VALUES (1, '张三', '龚超', '2019-06-03 01:40:42', 3);

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
INSERT INTO `qu_question` VALUES (32, '你认为网络对大学生利大？还是弊大？', '2019-05-17 11:34:30', 'radio', 30);
INSERT INTO `qu_question` VALUES (36, '你每天上网时间', '2019-05-17 12:03:51', 'check', 30);

-- ----------------------------
-- Table structure for qu_user_main
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
INSERT INTO `qu_user_main` VALUES (7, 1, 2);
INSERT INTO `qu_user_main` VALUES (8, 2, 3);

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
INSERT INTO `sys_permiss` VALUES (2, '/questionnaire/vote', '问卷投票（vip）', 1, 0);
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
INSERT INTO `sys_role_user` VALUES (1, 1, 1, 'admin');
INSERT INTO `sys_role_user` VALUES (2, 2, 2, 'vip01');
INSERT INTO `sys_role_user` VALUES (3, 3, 3, 'draftsman01');
INSERT INTO `sys_role_user` VALUES (12, 15, 2, 'vip02');
INSERT INTO `sys_role_user` VALUES (13, 16, 2, 'vip03');
INSERT INTO `sys_role_user` VALUES (14, 17, 3, 'draftsman02');

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
INSERT INTO `sys_user` VALUES (1, 'admin', 'b891a1ba0e9a3226c682f89cef02c218', '管理员', '2771109447@qq.com', 'a700e536309f1bf14c1a94eaa25f876a', 0);
INSERT INTO `sys_user` VALUES (2, 'vip01', '05fa8520b6a3e4088e82bbdb13b5d1f8', '龚超', '2771109447@qq.com', '03089a17360766ff956e35b83e4b7802', 0);
INSERT INTO `sys_user` VALUES (3, 'draftsman01', '63c68fe9c04ee6f74439e3ea60017e4b', '陈志平', '2771109447@qq.com', '7898b33bcdc6eb31edb57c0a13b63ce9', 0);
INSERT INTO `sys_user` VALUES (15, 'vip02', 'a510a87556047ae1338e251d516fcba9', '陈志平', '2771109447@qq.com', '68ee41db09fa71a59ee90be0eecf11e8', 0);
INSERT INTO `sys_user` VALUES (16, 'vip03', '518cc6dda633ba6d284547ba52f6a6e6', '陈志平', 'hgfhgfgg9447@qq.com', '5437f57dcc06cbb7ed5c686dc247479a', 0);
INSERT INTO `sys_user` VALUES (17, 'draftsman02', '725da465026998dbd41fd86706464815', '陈志平', '2771109447@qq.com', 'd3194edf70a4f3e8240bf60dba776c9e', 0);

SET FOREIGN_KEY_CHECKS = 1;
