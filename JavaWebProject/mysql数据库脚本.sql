/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50051
Source Host           : localhost:3306
Source Database       : xiaoyoulu_db

Target Server Type    : MYSQL
Target Server Version : 50051
File Encoding         : 65001

Date: 2018-07-13 17:44:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL default '',
  `password` varchar(32) default NULL,
  PRIMARY KEY  (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_comment`
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment` (
  `commentId` int(11) NOT NULL auto_increment COMMENT '评论id',
  `shuoshuoObj` int(11) NOT NULL COMMENT '被评说说',
  `commentContent` varchar(800) NOT NULL COMMENT '评论内容',
  `userObj` varchar(30) NOT NULL COMMENT '评论人',
  `commentTime` varchar(20) default NULL COMMENT '评论时间',
  PRIMARY KEY  (`commentId`),
  KEY `shuoshuoObj` (`shuoshuoObj`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_comment_ibfk_1` FOREIGN KEY (`shuoshuoObj`) REFERENCES `t_shuoshuo` (`shuoshuoId`),
  CONSTRAINT `t_comment_ibfk_2` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_comment
-- ----------------------------
INSERT INTO `t_comment` VALUES ('1', '1', '朋友家美女很多！', 'STU001', '2018-03-29 16:07:30');
INSERT INTO `t_comment` VALUES ('2', '1', '你玩的真happy', 'STU002', '2018-04-03 13:04:10');

-- ----------------------------
-- Table structure for `t_guanzhu`
-- ----------------------------
DROP TABLE IF EXISTS `t_guanzhu`;
CREATE TABLE `t_guanzhu` (
  `guanzhuId` int(11) NOT NULL auto_increment COMMENT '关注id',
  `userObj1` varchar(30) NOT NULL COMMENT '被关注人',
  `userObj2` varchar(30) NOT NULL COMMENT '关注人',
  `guanzhuTime` varchar(20) default NULL COMMENT '关注时间',
  PRIMARY KEY  (`guanzhuId`),
  KEY `userObj1` (`userObj1`),
  KEY `userObj2` (`userObj2`),
  CONSTRAINT `t_guanzhu_ibfk_1` FOREIGN KEY (`userObj1`) REFERENCES `t_userinfo` (`user_name`),
  CONSTRAINT `t_guanzhu_ibfk_2` FOREIGN KEY (`userObj2`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_guanzhu
-- ----------------------------
INSERT INTO `t_guanzhu` VALUES ('2', 'STU001', 'STU002', '2018-04-03 14:35:59');

-- ----------------------------
-- Table structure for `t_leaveword`
-- ----------------------------
DROP TABLE IF EXISTS `t_leaveword`;
CREATE TABLE `t_leaveword` (
  `leaveWordId` int(11) NOT NULL auto_increment COMMENT '留言id',
  `leaveTitle` varchar(80) NOT NULL COMMENT '留言标题',
  `leaveContent` varchar(2000) NOT NULL COMMENT '留言内容',
  `userObj` varchar(30) NOT NULL COMMENT '留言人',
  `leaveTime` varchar(20) default NULL COMMENT '留言时间',
  `replyContent` varchar(1000) default NULL COMMENT '管理回复',
  `replyTime` varchar(20) default NULL COMMENT '回复时间',
  PRIMARY KEY  (`leaveWordId`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_leaveword_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_leaveword
-- ----------------------------
INSERT INTO `t_leaveword` VALUES ('1', '有2018届的校友吗', '我的2018届计算机专业的，有一个专业的校友吗？', 'STU001', '2018-03-29 16:08:04', '这里各个专业的朋友都有哈！', '2018-03-29 16:08:08');
INSERT INTO `t_leaveword` VALUES ('2', '这个校友都是真实的吧', '这里这个平台都是我们学校的校友吗？', 'STU001', '2018-04-03 11:14:44', '是的都是哈', '2018-04-03 14:44:03');

-- ----------------------------
-- Table structure for `t_notice`
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `noticeId` int(11) NOT NULL auto_increment COMMENT '公告id',
  `title` varchar(80) NOT NULL COMMENT '标题',
  `content` varchar(5000) NOT NULL COMMENT '公告内容',
  `publishDate` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`noticeId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES ('1', '校友录网站成立了', '<p>同学们可以来这里找到你们的校友一起玩！</p>', '2018-03-29 16:08:15');

-- ----------------------------
-- Table structure for `t_postinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_postinfo`;
CREATE TABLE `t_postinfo` (
  `postInfoId` int(11) NOT NULL auto_increment COMMENT '文章id',
  `title` varchar(80) NOT NULL COMMENT '文章标题',
  `postPhoto` varchar(60) NOT NULL COMMENT '文章图片',
  `content` varchar(5000) NOT NULL COMMENT '文章内容',
  `hitNum` int(11) NOT NULL COMMENT '浏览量',
  `userObj` varchar(30) NOT NULL COMMENT '发布人',
  `addTime` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`postInfoId`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_postinfo_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_postinfo
-- ----------------------------
INSERT INTO `t_postinfo` VALUES ('1', '我的妹妹要相亲！', 'upload/b6b53b4d-5fcc-4274-a0df-c292115bacd7.jpg', '<p>这是我妹妹，有哪个单身男士还没结婚的，可以来谈谈！</p>', '38', 'STU001', '2018-03-29 16:06:36');
INSERT INTO `t_postinfo` VALUES ('2', '谁周末一起去看桃花', 'upload/14275501-4655-4c76-9e74-f54b7e61a81d.jpg', '<p>太忙了都错过了看桃花的最好时节，现在估计还有几朵花吧，谁要和我一起去？</p>', '4', 'STU001', '2018-04-03 12:15:40');

-- ----------------------------
-- Table structure for `t_reply`
-- ----------------------------
DROP TABLE IF EXISTS `t_reply`;
CREATE TABLE `t_reply` (
  `replyId` int(11) NOT NULL auto_increment COMMENT '回复id',
  `postInfoObj` int(11) NOT NULL COMMENT '被回文章',
  `content` varchar(2000) NOT NULL COMMENT '回复内容',
  `userObj` varchar(30) NOT NULL COMMENT '回复人',
  `replyTime` varchar(20) default NULL COMMENT '回复时间',
  PRIMARY KEY  (`replyId`),
  KEY `postInfoObj` (`postInfoObj`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_reply_ibfk_1` FOREIGN KEY (`postInfoObj`) REFERENCES `t_postinfo` (`postInfoId`),
  CONSTRAINT `t_reply_ibfk_2` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_reply
-- ----------------------------
INSERT INTO `t_reply` VALUES ('1', '1', '我哥哥单身26岁，你妹妹多大了？', 'STU002', '2018-03-29 16:06:45');
INSERT INTO `t_reply` VALUES ('2', '1', '可以叫你哥哥出来看看！', 'STU001', '2018-04-03 11:42:51');

-- ----------------------------
-- Table structure for `t_shuoshuo`
-- ----------------------------
DROP TABLE IF EXISTS `t_shuoshuo`;
CREATE TABLE `t_shuoshuo` (
  `shuoshuoId` int(11) NOT NULL auto_increment COMMENT '说说id',
  `shuoshuoContent` varchar(800) NOT NULL COMMENT '说说内容',
  `photo1` varchar(60) NOT NULL COMMENT '图片1',
  `photo2` varchar(60) NOT NULL COMMENT '图片2',
  `photo3` varchar(60) NOT NULL COMMENT '图片3',
  `userObj` varchar(30) NOT NULL COMMENT '发布人',
  `addTime` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`shuoshuoId`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_shuoshuo_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_shuoshuo
-- ----------------------------
INSERT INTO `t_shuoshuo` VALUES ('1', '今天的天气真心不错啊，去朋友家吃席了！', 'upload/519adff4-bdf7-4bc6-918a-ddca8f1733c3.jpg', 'upload/78c23c03-65dc-45b7-b69d-6b7b72041622.jpg', 'upload/fb8ad2df-5614-450a-88fc-b7becd5f0eff.jpg', 'STU001', '2018-03-29 16:07:09');

-- ----------------------------
-- Table structure for `t_shuoshuozan`
-- ----------------------------
DROP TABLE IF EXISTS `t_shuoshuozan`;
CREATE TABLE `t_shuoshuozan` (
  `zanId` int(11) NOT NULL auto_increment COMMENT '点赞id',
  `shuoshuoObj` int(11) NOT NULL COMMENT '被点赞说说',
  `userObj` varchar(30) NOT NULL COMMENT '点赞用户',
  `zanTime` varchar(20) default NULL COMMENT '点赞时间',
  PRIMARY KEY  (`zanId`),
  KEY `shuoshuoObj` (`shuoshuoObj`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_shuoshuozan_ibfk_1` FOREIGN KEY (`shuoshuoObj`) REFERENCES `t_shuoshuo` (`shuoshuoId`),
  CONSTRAINT `t_shuoshuozan_ibfk_2` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_shuoshuozan
-- ----------------------------
INSERT INTO `t_shuoshuozan` VALUES ('1', '1', 'STU001', '2018-04-03 13:04:18');

-- ----------------------------
-- Table structure for `t_userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_userinfo`;
CREATE TABLE `t_userinfo` (
  `user_name` varchar(30) NOT NULL COMMENT 'user_name',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `gender` varchar(4) NOT NULL COMMENT '性别',
  `birthDate` varchar(20) default NULL COMMENT '出生日期',
  `userPhoto` varchar(60) NOT NULL COMMENT '用户照片',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `email` varchar(50) NOT NULL COMMENT '邮箱',
  `address` varchar(80) default NULL COMMENT '家庭地址',
  `shzt` varchar(20) NOT NULL COMMENT '审核状态',
  `regTime` varchar(20) default NULL COMMENT '注册时间',
  PRIMARY KEY  (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_userinfo
-- ----------------------------
INSERT INTO `t_userinfo` VALUES ('STU001', '123', '李文静', '女', '2018-03-13', 'upload/71d1ca3b-f4ee-4c63-831b-f7ce396009ee.jpg', '13988939843', 'wenjing@163.com', '四川成都海洋咯13号', '已审核', '2018-03-29 16:06:24');
INSERT INTO `t_userinfo` VALUES ('STU002', '123', '王希萌', '女', '2018-04-04', 'upload/aebd1d17-30f0-471e-8e6b-a369e759c586.jpg', '13589834234', 'ximeng@163.com', '四川南充滨江路', '已审核', '2018-04-03 13:22:13');

-- ----------------------------
-- Table structure for `t_zaninfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_zaninfo`;
CREATE TABLE `t_zaninfo` (
  `zanId` int(11) NOT NULL auto_increment COMMENT '点赞id',
  `postObj` int(11) NOT NULL COMMENT '被点赞文章',
  `userObj` varchar(30) NOT NULL COMMENT '点赞人',
  `zanTime` varchar(20) default NULL COMMENT '点赞时间',
  PRIMARY KEY  (`zanId`),
  KEY `postObj` (`postObj`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_zaninfo_ibfk_1` FOREIGN KEY (`postObj`) REFERENCES `t_postinfo` (`postInfoId`),
  CONSTRAINT `t_zaninfo_ibfk_2` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_zaninfo
-- ----------------------------
INSERT INTO `t_zaninfo` VALUES ('2', '1', 'STU001', '2018-04-03 12:14:30');
