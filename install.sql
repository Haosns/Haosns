/*
 Navicat Premium Data Transfer

 Source Server         : a1
 Source Server Type    : MySQL
 Source Server Version : 50743 (5.7.43-log)
 Source Host           : 47.100.206.214:3306
 Source Schema         : a1

 Target Server Type    : MySQL
 Target Server Version : 50743 (5.7.43-log)
 File Encoding         : 65001

 Date: 01/12/2025 17:29:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for la_admin
-- ----------------------------
DROP TABLE IF EXISTS `la_admin`;
CREATE TABLE `la_admin`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `root` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否超级管理员 0-否 1-是',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '名称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户头像',
  `account` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '账号',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `login_time` int(10) NULL DEFAULT NULL COMMENT '最后登录时间',
  `login_ip` varchar(39) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录ip',
  `multipoint_login` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '是否支持多处登录：1-是；0-否；',
  `disable` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '是否禁用：0-否；1-是；',
  `create_time` int(10) NOT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '修改时间',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '管理员表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_admin
-- ----------------------------
INSERT INTO `la_admin` VALUES (1, 1, 'admin', 'resource/image/adminapi/default/avatar.png', 'admin', '26cd015246cb6cbf992a9bfd900512dd', 1764581044, '182.107.140.197', 1, 0, 1762171560, 1764581044, NULL);
INSERT INTO `la_admin` VALUES (2, 1, 'admin2', 'resource/image/adminapi/default/avatar.png', 'admin2', '165f86ed36484fb789187f50e49f3475', 1764164354, '39.144.170.9', 1, 0, 1762844478, 1764164354, NULL);

-- ----------------------------
-- Table structure for la_admin_dept
-- ----------------------------
DROP TABLE IF EXISTS `la_admin_dept`;
CREATE TABLE `la_admin_dept`  (
  `admin_id` int(10) NOT NULL DEFAULT 0 COMMENT '管理员id',
  `dept_id` int(10) NOT NULL DEFAULT 0 COMMENT '部门id',
  PRIMARY KEY (`admin_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_admin_dept
-- ----------------------------
INSERT INTO `la_admin_dept` VALUES (1, 1);

-- ----------------------------
-- Table structure for la_admin_jobs
-- ----------------------------
DROP TABLE IF EXISTS `la_admin_jobs`;
CREATE TABLE `la_admin_jobs`  (
  `admin_id` int(10) NOT NULL COMMENT '管理员id',
  `jobs_id` int(10) NOT NULL COMMENT '岗位id',
  PRIMARY KEY (`admin_id`, `jobs_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_admin_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for la_admin_role
-- ----------------------------
DROP TABLE IF EXISTS `la_admin_role`;
CREATE TABLE `la_admin_role`  (
  `admin_id` int(10) NOT NULL COMMENT '管理员id',
  `role_id` int(10) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`admin_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_admin_role
-- ----------------------------
INSERT INTO `la_admin_role` VALUES (2, 1);

-- ----------------------------
-- Table structure for la_admin_session
-- ----------------------------
DROP TABLE IF EXISTS `la_admin_session`;
CREATE TABLE `la_admin_session`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) UNSIGNED NOT NULL COMMENT '用户id',
  `terminal` tinyint(1) NOT NULL DEFAULT 1 COMMENT '客户端类型：1-pc管理后台 2-mobile手机管理后台',
  `token` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '令牌',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `expire_time` int(10) NOT NULL COMMENT '到期时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `admin_id_client`(`admin_id`, `terminal`) USING BTREE COMMENT '一个用户在一个终端只有一个token',
  UNIQUE INDEX `token`(`token`) USING BTREE COMMENT 'token是唯一的'
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '管理员会话表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_admin_session
-- ----------------------------
INSERT INTO `la_admin_session` VALUES (1, 1, 1, '44e445bab61d223cf0ca5cdf572d52d4', 1764581044, 1764609844);
INSERT INTO `la_admin_session` VALUES (2, 2, 1, '860082b0acbc69d08054fcd4eeb6a956', 1764164354, 1764193154);

-- ----------------------------
-- Table structure for la_article
-- ----------------------------
DROP TABLE IF EXISTS `la_article`;
CREATE TABLE `la_article`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文章id',
  `cid` int(11) NOT NULL COMMENT '文章分类',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文章标题',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '简介',
  `abstract` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '文章摘要',
  `image` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文章图片',
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '作者',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '文章内容',
  `click_virtual` int(10) NULL DEFAULT 0 COMMENT '虚拟浏览量',
  `click_actual` int(11) NULL DEFAULT 0 COMMENT '实际浏览量',
  `is_show` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否显示:1-是.0-否',
  `sort` int(5) NULL DEFAULT 0 COMMENT '排序',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_article
-- ----------------------------

-- ----------------------------
-- Table structure for la_article_cate
-- ----------------------------
DROP TABLE IF EXISTS `la_article_cate`;
CREATE TABLE `la_article_cate`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文章分类id',
  `name` varchar(90) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类名称',
  `sort` int(11) NULL DEFAULT 0 COMMENT '排序',
  `is_show` tinyint(1) NULL DEFAULT 1 COMMENT '是否显示:1-是;0-否',
  `create_time` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_article_cate
-- ----------------------------
INSERT INTO `la_article_cate` VALUES (1, '科技', 0, 1, 1663317280, 1663317280, NULL);
INSERT INTO `la_article_cate` VALUES (2, '生活', 0, 1, 1663317280, 1663321464, NULL);
INSERT INTO `la_article_cate` VALUES (3, '好物', 0, 1, 1727070858, 1727070858, NULL);

-- ----------------------------
-- Table structure for la_article_collect
-- ----------------------------
DROP TABLE IF EXISTS `la_article_collect`;
CREATE TABLE `la_article_collect`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `article_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文章ID',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '收藏状态 0-未收藏 1-已收藏',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章收藏表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_article_collect
-- ----------------------------

-- ----------------------------
-- Table structure for la_config
-- ----------------------------
DROP TABLE IF EXISTS `la_config`;
CREATE TABLE `la_config`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型',
  `name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '名称',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '值',
  `create_time` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 98 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_config
-- ----------------------------
INSERT INTO `la_config` VALUES (1, 'mnp_setting', 'name', '', 1762851515, 1762851515);
INSERT INTO `la_config` VALUES (2, 'mnp_setting', 'original_id', '', 1762851515, 1762851515);
INSERT INTO `la_config` VALUES (3, 'mnp_setting', 'qr_code', '', 1762851515, 1762851515);
INSERT INTO `la_config` VALUES (4, 'mnp_setting', 'app_id', '', 1762851515, 1763002640);
INSERT INTO `la_config` VALUES (5, 'mnp_setting', 'app_secret', '', 1762851515, 1763002640);
INSERT INTO `la_config` VALUES (6, 'config', 'default_avatar', 'https://mp.haosns.com/resource/image/adminapi/default/default_avatar.png', 1762939953, 1762939953);
INSERT INTO `la_config` VALUES (7, 'config', 'default_user_home_bj', 'https://mp.haosns.com/uploads/images/20251112/202511121732292b6cf4649.jpg', 1762939953, 1762939953);
INSERT INTO `la_config` VALUES (8, 'login', 'bg_type', 'image', 1762946165, 1762946165);
INSERT INTO `la_config` VALUES (9, 'login', 'bg_src', 'https://mp.haosns.com/uploads/images/20251112/2025111219120530c6b7643.jpg', 1762946165, 1762946203);
INSERT INTO `la_config` VALUES (10, 'login', 'bg_scroll', '0', 1762946165, 1762946453);
INSERT INTO `la_config` VALUES (11, 'website', 'name', 'HaoSNN社交系统', 1762946727, 1763019955);
INSERT INTO `la_config` VALUES (12, 'website', 'web_favicon', 'uploads/images/20251112/20251112192405667c60359.png', 1762946727, 1762996633);
INSERT INTO `la_config` VALUES (13, 'website', 'web_logo', 'uploads/images/20251112/20251112192405667c60359.png', 1762946727, 1762946727);
INSERT INTO `la_config` VALUES (14, 'website', 'login_image', 'uploads/images/20251201/202512011713217c0032865.png', 1762946727, 1764580417);
INSERT INTO `la_config` VALUES (15, 'website', 'shop_name', 'HaoSNS – 免费开源的社交管理系统', 1762946727, 1762946908);
INSERT INTO `la_config` VALUES (16, 'website', 'shop_logo', 'resource/image/adminapi/default/shop_logo.png', 1762946727, 1762946727);
INSERT INTO `la_config` VALUES (17, 'website', 'pc_logo', 'resource/image/adminapi/default/pc_logo.png', 1762946727, 1762946727);
INSERT INTO `la_config` VALUES (18, 'website', 'pc_title', 'HaoSNS – 免费开源的社交管理系统', 1762946727, 1762946727);
INSERT INTO `la_config` VALUES (19, 'website', 'pc_ico', 'resource/image/adminapi/default/web_favicon.ico', 1762946727, 1762946727);
INSERT INTO `la_config` VALUES (20, 'website', 'pc_desc', '1.1111111111111E+32', 1762946727, 1762996633);
INSERT INTO `la_config` VALUES (21, 'website', 'pc_keywords', '2.2222222222222E+32', 1762946727, 1762996633);
INSERT INTO `la_config` VALUES (22, 'website', 'h5_favicon', 'resource/image/adminapi/default/web_favicon.ico', 1762946727, 1762946727);
INSERT INTO `la_config` VALUES (23, 'article', 'article_index_sort', '1', 1762951353, 1762951353);
INSERT INTO `la_config` VALUES (24, 'article', 'disclaimer_status', '1', 1762951353, 1762951353);
INSERT INTO `la_config` VALUES (25, 'article', 'disclaimer_value', '', 1762951353, 1762951353);
INSERT INTO `la_config` VALUES (26, 'article', 'send_examine', '0', 1762951353, 1762951353);
INSERT INTO `la_config` VALUES (27, 'article', 'send_show_title', '1', 1762951353, 1762951353);
INSERT INTO `la_config` VALUES (28, 'article', 'send_require_circle', '0', 1762951353, 1762951353);
INSERT INTO `la_config` VALUES (29, 'article', 'max_word_len_ellipsis', '0', 1762951353, 1762951353);
INSERT INTO `la_config` VALUES (30, 'article', 'min_word_len_ellipsis', '0', 1762951353, 1762951353);
INSERT INTO `la_config` VALUES (31, 'article', 'send_limit_day', '10', 1762951353, 1762951353);
INSERT INTO `la_config` VALUES (32, 'article', 'send_get_integral', '0', 1762951353, 1762951353);
INSERT INTO `la_config` VALUES (33, 'article', 'send_get_experience', '0', 1762951353, 1762951353);
INSERT INTO `la_config` VALUES (34, 'article', 'video_status', '0', 1762951353, 1762951353);
INSERT INTO `la_config` VALUES (35, 'article', 'send_comment_limit_day', '50', 1762951353, 1763000921);
INSERT INTO `la_config` VALUES (36, 'article', 'send_comment_get_integral', '0', 1762951353, 1762951353);
INSERT INTO `la_config` VALUES (37, 'article', 'max_image', '9', 1762951353, 1763359293);
INSERT INTO `la_config` VALUES (38, 'article', 'is_update', '1', 1762951353, 1763000579);
INSERT INTO `la_config` VALUES (39, 'article', 'send_get_experience_globle', '0', 1762951353, 1762951353);
INSERT INTO `la_config` VALUES (40, 'article', 'send_require_wechat', '0', 1762951353, 1762951353);
INSERT INTO `la_config` VALUES (41, 'article', 'enable_rich_text', '0', 1762951353, 1762951353);
INSERT INTO `la_config` VALUES (42, 'security', 'is_open', '0', 1762951353, 1762951353);
INSERT INTO `la_config` VALUES (43, 'security', 'default', 'qcloud', 1762951353, 1762951353);
INSERT INTO `la_config` VALUES (44, 'security', 'qcloud', '{\"region\":\"\",\"secret_id\":\"\",\"secret_key\":\"\",\"bucket\":\"\"}', 1762951353, 1762951353);
INSERT INTO `la_config` VALUES (45, 'shop', 'name', 'HaoSNS – 免费开源的社交管理系统', 1762995684, 1762995684);
INSERT INTO `la_config` VALUES (46, 'shop', 'logo', '', 1762995684, 1762995684);
INSERT INTO `la_config` VALUES (47, 'shop', 'mobile_logo', 'https://mp.haosns.com/', 1762995684, 1762995684);
INSERT INTO `la_config` VALUES (48, 'shop', 'pc_logo', 'https://mp.haosns.com/', 1762995684, 1762995684);
INSERT INTO `la_config` VALUES (49, 'shop', 'pc_article_default_image', '', 1762995684, 1762995684);
INSERT INTO `la_config` VALUES (50, 'shop', 'favicon', '', 1762995684, 1762995684);
INSERT INTO `la_config` VALUES (51, 'shop', 'admin_login_image', '', 1762995684, 1762995684);
INSERT INTO `la_config` VALUES (52, 'shop', 'login_restrictions', '0', 1762995684, 1762995684);
INSERT INTO `la_config` VALUES (53, 'shop', 'status', '1', 1762995684, 1763000242);
INSERT INTO `la_config` VALUES (54, 'shop', 'mall_contact', '谢先生', 1762995684, 1762995684);
INSERT INTO `la_config` VALUES (55, 'shop', 'mall_contact_mobile', '18979795297', 1762995684, 1762995684);
INSERT INTO `la_config` VALUES (56, 'shop', 'return_contact', '谢先生', 1762995684, 1762995684);
INSERT INTO `la_config` VALUES (57, 'shop', 'return_contact_mobile', '18979795297', 1762995684, 1762995684);
INSERT INTO `la_config` VALUES (58, 'shop', 'return_province', '0', 1762995684, 1762995684);
INSERT INTO `la_config` VALUES (59, 'shop', 'return_city', '0', 1762995684, 1762995684);
INSERT INTO `la_config` VALUES (60, 'shop', 'return_district', '0', 1762995684, 1762995684);
INSERT INTO `la_config` VALUES (61, 'shop', 'return_address', '江西省赣州市赣县区', 1762995684, 1762995684);
INSERT INTO `la_config` VALUES (62, 'shop', 'global_login', NULL, 1762995684, 1762995684);
INSERT INTO `la_config` VALUES (63, 'shop', 'user_login_image', NULL, 1762995685, 1762995685);
INSERT INTO `la_config` VALUES (64, 'default_image', 'system_notice_icon', 'https://mp.haosns.com/uploads/images/20251113/20251113082625ec5309764.png', 1762995685, 1762996381);
INSERT INTO `la_config` VALUES (65, 'default_image', 'notice_collect_icon', 'https://mp.haosns.com/uploads/images/20251113/202511130825265876a0842.png', 1762995685, 1762996381);
INSERT INTO `la_config` VALUES (66, 'default_image', 'notice_comment_icon', 'https://mp.haosns.com/uploads/images/20251113/2025111308255094aee7386.png', 1762995685, 1762996381);
INSERT INTO `la_config` VALUES (67, 'default_image', 'notice_follow_icon', 'https://mp.haosns.com/uploads/images/20251113/20251113082607c51ac5717.png', 1762995685, 1762996381);
INSERT INTO `la_config` VALUES (68, 'config', 'is_demo', NULL, 1762995685, 1762995685);
INSERT INTO `la_config` VALUES (69, 'config', 'share_domain', NULL, 1762995685, 1762995685);
INSERT INTO `la_config` VALUES (70, 'index', 'notice', 'HaoSNS社交系统官网:www.haosns.com|HaoSNS社交系统交流QQ群：251136725', 1762995685, 1762997193);
INSERT INTO `la_config` VALUES (71, 'login', 'login_way', '[\"2\",\"1\"]', 1762997762, 1763640772);
INSERT INTO `la_config` VALUES (72, 'login', 'coerce_mobile', '1', 1762997762, 1762997762);
INSERT INTO `la_config` VALUES (73, 'login', 'login_agreement', '1', 1762997762, 1762997762);
INSERT INTO `la_config` VALUES (74, 'login', 'third_auth', '1', 1762997762, 1762997762);
INSERT INTO `la_config` VALUES (75, 'login', 'wechat_auth', '1', 1762997762, 1763641046);
INSERT INTO `la_config` VALUES (76, 'login', 'qq_auth', '0', 1762997762, 1762997762);
INSERT INTO `la_config` VALUES (77, 'oa_setting', 'name', '', 1763002603, 1763002603);
INSERT INTO `la_config` VALUES (78, 'oa_setting', 'original_id', '', 1763002603, 1763002603);
INSERT INTO `la_config` VALUES (79, 'oa_setting', 'qr_code', '', 1763002603, 1763002603);
INSERT INTO `la_config` VALUES (80, 'oa_setting', 'app_id', '', 1763002603, 1763002603);
INSERT INTO `la_config` VALUES (81, 'oa_setting', 'app_secret', '', 1763002603, 1763002603);
INSERT INTO `la_config` VALUES (82, 'oa_setting', 'token', '', 1763002603, 1763002603);
INSERT INTO `la_config` VALUES (83, 'oa_setting', 'encoding_aes_key', '', 1763002603, 1763002603);
INSERT INTO `la_config` VALUES (84, 'oa_setting', 'encryption_type', '1', 1763002603, 1763002603);
INSERT INTO `la_config` VALUES (85, 'open_platform', 'app_id', '', 1763002833, 1763002833);
INSERT INTO `la_config` VALUES (86, 'open_platform', 'app_secret', '', 1763002833, 1763002833);
INSERT INTO `la_config` VALUES (87, 'agreement', 'service_title', '', 1763262597, 1763262597);
INSERT INTO `la_config` VALUES (88, 'agreement', 'service_content', '<p>55555555555555555555555555555555555555555555555555</p>', 1763262597, 1763262616);
INSERT INTO `la_config` VALUES (89, 'agreement', 'privacy_title', '', 1763262597, 1763262597);
INSERT INTO `la_config` VALUES (90, 'agreement', 'privacy_content', '<p>66666666666666666666666666666666666666666666666666666666666</p>', 1763262597, 1763262616);
INSERT INTO `la_config` VALUES (91, 'map', 'tencent_map_key', '7NEBZ-ASH3U-R64VL-4DPJD-X7AKE-SSF33', 1763379788, 1763379788);
INSERT INTO `la_config` VALUES (92, 'sms', 'ali', '{\"name\":\"阿里云短信\",\"type\":\"ali\",\"sign\":\"乐易\",\"app_key\":\"LTAI5tRfcsoz7bwf1C85MhE6\",\"app_id\":\"\",\"secret_key\":\"rFZAjqoQM0ZTcVr2Plj4emT9lGRtVl\",\"secret_id\":\"\",\"status\":\"1\"}', 1763638110, 1763638110);
INSERT INTO `la_config` VALUES (93, 'sms', 'engine', 'ALI', 1763638110, 1763638110);
INSERT INTO `la_config` VALUES (94, 'circle', 'circle_name', '圈子', 1764204158, 1764204158);
INSERT INTO `la_config` VALUES (95, 'circle', 'create_circle_price', '0', 1764204158, 1764204158);
INSERT INTO `la_config` VALUES (96, 'circle', 'circle_profit_pct', '0', 1764204158, 1764204158);
INSERT INTO `la_config` VALUES (97, 'system', 'version', '1.002', 1764580373, 1764581253);

-- ----------------------------
-- Table structure for la_decorate_page
-- ----------------------------
DROP TABLE IF EXISTS `la_decorate_page`;
CREATE TABLE `la_decorate_page`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` tinyint(2) UNSIGNED NOT NULL DEFAULT 10 COMMENT '页面类型 1=商城首页, 2=个人中心, 3=客服设置 4-PC首页',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '页面名称',
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '页面数据',
  `meta` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '页面设置',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(10) UNSIGNED NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '装修页面配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_decorate_page
-- ----------------------------
INSERT INTO `la_decorate_page` VALUES (1, 1, '商城首页', '[{\"title\":\"搜索\",\"name\":\"search\",\"disabled\":1,\"content\":{},\"styles\":{}},{\"title\":\"首页轮播图\",\"name\":\"banner\",\"content\":{\"enabled\":1,\"data\":[{\"image\":\"/resource/image/adminapi/default/banner001.png\",\"name\":\"\",\"link\":{\"id\":6,\"name\":\"来自瓷器的爱\",\"path\":\"/pages/news_detail/news_detail\",\"query\":{\"id\":6},\"type\":\"article\"},\"is_show\":\"1\",\"bg\":\"/resource/image/adminapi/default/banner001_bg.png\"},{\"image\":\"/resource/image/adminapi/default/banner002.png\",\"name\":\"\",\"link\":{\"id\":3,\"name\":\"金山电池公布“沪广深市民绿色生活方式”调查结果\",\"path\":\"/pages/news_detail/news_detail\",\"query\":{\"id\":3},\"type\":\"article\"},\"is_show\":\"1\",\"bg\":\"/resource/image/adminapi/default/banner002_bg.png\"},{\"is_show\":\"1\",\"image\":\"/resource/image/adminapi/default/banner003.png\",\"name\":\"\",\"link\":{\"id\":1,\"name\":\"让生活更精致！五款居家好物推荐，实用性超高\",\"path\":\"/pages/news_detail/news_detail\",\"query\":{\"id\":1},\"type\":\"article\"},\"bg\":\"/resource/image/adminapi/default/banner003_bg.png\"}],\"style\":1,\"bg_style\":1},\"styles\":{}},{\"title\":\"导航菜单\",\"name\":\"nav\",\"content\":{\"enabled\":1,\"data\":[{\"image\":\"/resource/image/adminapi/default/nav01.png\",\"name\":\"资讯中心\",\"link\":{\"path\":\"/pages/news/news\",\"name\":\"文章资讯\",\"type\":\"shop\",\"canTab\":true},\"is_show\":\"1\"},{\"image\":\"/resource/image/adminapi/default/nav03.png\",\"name\":\"个人设置\",\"link\":{\"path\":\"/pages/user_set/user_set\",\"name\":\"个人设置\",\"type\":\"shop\"},\"is_show\":\"1\"},{\"image\":\"/resource/image/adminapi/default/nav02.png\",\"name\":\"我的收藏\",\"link\":{\"path\":\"/pages/collection/collection\",\"name\":\"我的收藏\",\"type\":\"shop\"},\"is_show\":\"1\"},{\"image\":\"/resource/image/adminapi/default/nav05.png\",\"name\":\"关于我们\",\"link\":{\"path\":\"/pages/as_us/as_us\",\"name\":\"关于我们\",\"type\":\"shop\"},\"is_show\":\"1\"},{\"image\":\"/resource/image/adminapi/default/nav04.png\",\"name\":\"联系客服\",\"link\":{\"path\":\"/pages/customer_service/customer_service\",\"name\":\"联系客服\",\"type\":\"shop\"},\"is_show\":\"1\"}],\"style\":2,\"per_line\":5,\"show_line\":2},\"styles\":{}},{\"title\":\"首页中部轮播图\",\"name\":\"middle-banner\",\"content\":{\"enabled\":1,\"data\":[{\"is_show\":\"1\",\"image\":\"/resource/image/adminapi/default/index_ad01.png\",\"name\":\"\",\"link\":{\"path\":\"/pages/agreement/agreement\",\"name\":\"隐私政策\",\"query\":{\"type\":\"privacy\"},\"type\":\"shop\"}}]},\"styles\":{}},{\"id\":\"l84almsk2uhyf\",\"title\":\"资讯\",\"name\":\"news\",\"disabled\":1,\"content\":{},\"styles\":{}}]', '[{\"title\":\"页面设置\",\"name\":\"page-meta\",\"content\":{\"title\":\"首页\",\"bg_type\":\"2\",\"bg_color\":\"#2F80ED\",\"bg_image\":\"/resource/image/adminapi/default/page_meta_bg01.png\",\"text_color\":\"2\",\"title_type\":\"2\",\"title_img\":\"/resource/image/adminapi/default/page_mate_title.png\"},\"styles\":{}}]', 1661757188, 1710989700);
INSERT INTO `la_decorate_page` VALUES (2, 2, '个人中心', '[{\"title\":\"用户信息\",\"name\":\"user-info\",\"disabled\":1,\"content\":{},\"styles\":{}},{\"title\":\"我的服务\",\"name\":\"my-service\",\"content\":{\"style\":1,\"title\":\"我的服务\",\"data\":[{\"image\":\"/resource/image/adminapi/default/user_collect.png\",\"name\":\"我的收藏\",\"link\":{\"path\":\"/pages/collection/collection\",\"name\":\"我的收藏\",\"type\":\"shop\"},\"is_show\":\"1\"},{\"image\":\"/resource/image/adminapi/default/user_setting.png\",\"name\":\"个人设置\",\"link\":{\"path\":\"/pages/user_set/user_set\",\"name\":\"个人设置\",\"type\":\"shop\"},\"is_show\":\"1\"},{\"image\":\"/resource/image/adminapi/default/user_kefu.png\",\"name\":\"联系客服\",\"link\":{\"path\":\"/pages/customer_service/customer_service\",\"name\":\"联系客服\",\"type\":\"shop\"},\"is_show\":\"1\"},{\"image\":\"/resource/image/adminapi/default/wallet.png\",\"name\":\"我的钱包\",\"link\":{\"path\":\"/packages/pages/user_wallet/user_wallet\",\"name\":\"我的钱包\",\"type\":\"shop\"},\"is_show\":\"1\"}],\"enabled\":1},\"styles\":{}},{\"title\":\"个人中心广告图\",\"name\":\"user-banner\",\"content\":{\"enabled\":1,\"data\":[{\"image\":\"/resource/image/adminapi/default/user_ad01.png\",\"name\":\"\",\"link\":{\"path\":\"/pages/customer_service/customer_service\",\"name\":\"联系客服\",\"type\":\"shop\"},\"is_show\":\"1\"},{\"image\":\"/resource/image/adminapi/default/user_ad02.png\",\"name\":\"\",\"link\":{\"path\":\"/pages/customer_service/customer_service\",\"name\":\"联系客服\",\"type\":\"shop\"},\"is_show\":\"1\"}]},\"styles\":{}}]', '[{\"title\":\"页面设置\",\"name\":\"page-meta\",\"content\":{\"title\":\"个人中心\",\"bg_type\":\"1\",\"bg_color\":\"#2F80ED\",\"bg_image\":\"\",\"text_color\":\"1\",\"title_type\":\"2\",\"title_img\":\"/resource/image/adminapi/default/page_mate_title.png\"},\"styles\":{}}]', 1661757188, 1710933097);
INSERT INTO `la_decorate_page` VALUES (3, 3, '客服设置', '[{\"title\":\"客服设置\",\"name\":\"customer-service\",\"content\":{\"title\":\"添加客服二维码\",\"time\":\"早上 9:30 - 19:00\",\"mobile\":\"18578768757\",\"qrcode\":\"/resource/image/adminapi/default/kefu01.png\",\"remark\":\"长按添加客服或拨打客服热线\"},\"styles\":{}}]', '', 1661757188, 1710929953);
INSERT INTO `la_decorate_page` VALUES (4, 4, 'PC设置', '[{\"id\":\"lajcn8d0hzhed\",\"title\":\"首页轮播图\",\"name\":\"pc-banner\",\"content\":{\"enabled\":1,\"data\":[{\"image\":\"/resource/image/adminapi/default/banner003.png\",\"name\":\"\",\"link\":{\"path\":\"/pages/news/news\",\"name\":\"文章资讯\",\"type\":\"shop\"}},{\"image\":\"/resource/image/adminapi/default/banner002.png\",\"name\":\"\",\"link\":{\"path\":\"/pages/collection/collection\",\"name\":\"我的收藏\",\"type\":\"shop\"}},{\"image\":\"/resource/image/adminapi/default/banner001.png\",\"name\":\"\",\"link\":{}}]},\"styles\":{\"position\":\"absolute\",\"left\":\"40\",\"top\":\"75px\",\"width\":\"750px\",\"height\":\"340px\"}}]', '', 1661757188, 1710990175);
INSERT INTO `la_decorate_page` VALUES (5, 5, '系统风格', '{\"themeColorId\":3,\"topTextColor\":\"white\",\"navigationBarColor\":\"#A74BFD\",\"themeColor1\":\"#A74BFD\",\"themeColor2\":\"#CB60FF\",\"buttonColor\":\"white\"}', '', 1710410915, 1710990415);

-- ----------------------------
-- Table structure for la_decorate_tabbar
-- ----------------------------
DROP TABLE IF EXISTS `la_decorate_tabbar`;
CREATE TABLE `la_decorate_tabbar`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '导航名称',
  `selected` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '未选图标',
  `unselected` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '已选图标',
  `link` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '链接地址',
  `is_show` tinyint(255) UNSIGNED NOT NULL DEFAULT 1 COMMENT '显示状态',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '装修底部导航表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_decorate_tabbar
-- ----------------------------
INSERT INTO `la_decorate_tabbar` VALUES (1, '首页', 'resource/image/adminapi/default/tabbar_home_sel.png', 'resource/image/adminapi/default/tabbar_home.png', '{\"path\":\"/pages/index/index\",\"name\":\"商城首页\",\"type\":\"shop\"}', 1, 1662688157, 1662688157);
INSERT INTO `la_decorate_tabbar` VALUES (2, '资讯', 'resource/image/adminapi/default/tabbar_text_sel.png', 'resource/image/adminapi/default/tabbar_text.png', '{\"path\":\"/pages/news/news\",\"name\":\"文章资讯\",\"type\":\"shop\",\"canTab\":\"1\"}', 1, 1662688157, 1662688157);
INSERT INTO `la_decorate_tabbar` VALUES (3, '我的', 'resource/image/adminapi/default/tabbar_me_sel.png', 'resource/image/adminapi/default/tabbar_me.png', '{\"path\":\"/pages/user/user\",\"name\":\"个人中心\",\"type\":\"shop\",\"canTab\":\"1\"}', 1, 1662688157, 1662688157);

-- ----------------------------
-- Table structure for la_dept
-- ----------------------------
DROP TABLE IF EXISTS `la_dept`;
CREATE TABLE `la_dept`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '部门名称',
  `pid` bigint(20) NOT NULL DEFAULT 0 COMMENT '上级部门id',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  `leader` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `mobile` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '部门状态（0停用 1正常）',
  `create_time` int(10) NOT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '修改时间',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_dept
-- ----------------------------
INSERT INTO `la_dept` VALUES (1, '公司', 0, 0, 'boss', '12345698745', 1, 1650592684, 1653640368, NULL);
INSERT INTO `la_dept` VALUES (2, '开发部', 1, 0, '', '', 1, 1762862107, 1762862107, NULL);

-- ----------------------------
-- Table structure for la_dev_crontab
-- ----------------------------
DROP TABLE IF EXISTS `la_dev_crontab`;
CREATE TABLE `la_dev_crontab`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '定时任务名称',
  `type` tinyint(1) NOT NULL COMMENT '类型 1-定时任务',
  `system` tinyint(4) NULL DEFAULT 0 COMMENT '是否系统任务 0-否 1-是',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `command` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '命令内容',
  `params` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '状态 1-运行 2-停止 3-错误',
  `expression` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '运行规则',
  `error` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '运行失败原因',
  `last_time` int(11) NULL DEFAULT NULL COMMENT '最后执行时间',
  `time` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '实时执行时长',
  `max_time` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '最大执行时长',
  `create_time` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '计划任务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_dev_crontab
-- ----------------------------

-- ----------------------------
-- Table structure for la_dev_pay_config
-- ----------------------------
DROP TABLE IF EXISTS `la_dev_pay_config`;
CREATE TABLE `la_dev_pay_config`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '模版名称',
  `pay_way` tinyint(1) NOT NULL COMMENT '支付方式:1-余额支付;2-微信支付;3-支付宝支付;',
  `config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '对应支付配置(json字符串)',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
  `sort` int(5) NULL DEFAULT NULL COMMENT '排序',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_dev_pay_config
-- ----------------------------
INSERT INTO `la_dev_pay_config` VALUES (1, '余额支付', 1, '', '/resource/image/adminapi/default/balance_pay.png', 128, '余额支付备注');
INSERT INTO `la_dev_pay_config` VALUES (2, '微信支付', 2, '{\"interface_version\":\"v3\",\"merchant_type\":\"ordinary_merchant\",\"mch_id\":\"\",\"pay_sign_key\":\"\",\"apiclient_cert\":\"\",\"apiclient_key\":\"\"}', '/resource/image/adminapi/default/wechat_pay.png', 123, '微信支付备注');
INSERT INTO `la_dev_pay_config` VALUES (3, '支付宝支付', 3, '{\"mode\":\"normal_mode\",\"merchant_type\":\"ordinary_merchant\",\"app_id\":\"\",\"private_key\":\"\",\"ali_public_key\":\"\"}', '/resource/image/adminapi/default/ali_pay.png', 123, '支付宝支付');

-- ----------------------------
-- Table structure for la_dev_pay_way
-- ----------------------------
DROP TABLE IF EXISTS `la_dev_pay_way`;
CREATE TABLE `la_dev_pay_way`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pay_config_id` int(11) NOT NULL COMMENT '支付配置ID',
  `scene` tinyint(1) NOT NULL COMMENT '场景:1-微信小程序;2-微信公众号;3-H5;4-PC;5-APP;',
  `is_default` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否默认支付:0-否;1-是;',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态:0-关闭;1-开启;',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_dev_pay_way
-- ----------------------------
INSERT INTO `la_dev_pay_way` VALUES (1, 1, 1, 0, 1);
INSERT INTO `la_dev_pay_way` VALUES (2, 2, 1, 1, 1);
INSERT INTO `la_dev_pay_way` VALUES (3, 1, 2, 0, 1);
INSERT INTO `la_dev_pay_way` VALUES (4, 2, 2, 1, 1);
INSERT INTO `la_dev_pay_way` VALUES (5, 1, 3, 0, 1);
INSERT INTO `la_dev_pay_way` VALUES (6, 2, 3, 1, 1);
INSERT INTO `la_dev_pay_way` VALUES (7, 3, 3, 0, 1);

-- ----------------------------
-- Table structure for la_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `la_dict_data`;
CREATE TABLE `la_dict_data`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据名称',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据值',
  `type_id` int(11) NOT NULL COMMENT '字典类型id',
  `type_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典类型',
  `sort` int(10) NULL DEFAULT 0 COMMENT '排序值',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '状态 0-停用 1-正常',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `create_time` int(10) NOT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '修改时间',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_dict_data
-- ----------------------------
INSERT INTO `la_dict_data` VALUES (1, '隐藏', '0', 1, 'show_status', 0, 1, '', 1656381543, 1656381543, NULL);
INSERT INTO `la_dict_data` VALUES (2, '显示', '1', 1, 'show_status', 0, 1, '', 1656381550, 1656381550, NULL);
INSERT INTO `la_dict_data` VALUES (3, '进行中', '0', 2, 'business_status', 0, 1, '', 1656381410, 1656381410, NULL);
INSERT INTO `la_dict_data` VALUES (4, '成功', '1', 2, 'business_status', 0, 1, '', 1656381437, 1656381437, NULL);
INSERT INTO `la_dict_data` VALUES (5, '失败', '2', 2, 'business_status', 0, 1, '', 1656381449, 1656381449, NULL);
INSERT INTO `la_dict_data` VALUES (6, '待处理', '0', 3, 'event_status', 0, 1, '', 1656381212, 1656381212, NULL);
INSERT INTO `la_dict_data` VALUES (7, '已处理', '1', 3, 'event_status', 0, 1, '', 1656381315, 1656381315, NULL);
INSERT INTO `la_dict_data` VALUES (8, '拒绝处理', '2', 3, 'event_status', 0, 1, '', 1656381331, 1656381331, NULL);
INSERT INTO `la_dict_data` VALUES (9, '禁用', '1', 4, 'system_disable', 0, 1, '', 1656312030, 1656312030, NULL);
INSERT INTO `la_dict_data` VALUES (10, '正常', '0', 4, 'system_disable', 0, 1, '', 1656312040, 1656312040, NULL);
INSERT INTO `la_dict_data` VALUES (11, '未知', '0', 5, 'sex', 0, 1, '', 1656062988, 1656062988, NULL);
INSERT INTO `la_dict_data` VALUES (12, '男', '1', 5, 'sex', 0, 1, '', 1656062999, 1656062999, NULL);
INSERT INTO `la_dict_data` VALUES (13, '女', '2', 5, 'sex', 0, 1, '', 1656063009, 1656063009, NULL);

-- ----------------------------
-- Table structure for la_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `la_dict_type`;
CREATE TABLE `la_dict_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '字典名称',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '字典类型名称',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '状态 0-停用 1-正常',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `create_time` int(10) NOT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '修改时间',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_dict_type
-- ----------------------------
INSERT INTO `la_dict_type` VALUES (1, '显示状态', 'show_status', 1, '', 1656381520, 1656381520, NULL);
INSERT INTO `la_dict_type` VALUES (2, '业务状态', 'business_status', 1, '', 1656381393, 1656381393, NULL);
INSERT INTO `la_dict_type` VALUES (3, '事件状态', 'event_status', 1, '', 1656381075, 1656381075, NULL);
INSERT INTO `la_dict_type` VALUES (4, '禁用状态', 'system_disable', 1, '', 1656311838, 1656311838, NULL);
INSERT INTO `la_dict_type` VALUES (5, '用户性别', 'sex', 1, '', 1656062946, 1656380925, NULL);

-- ----------------------------
-- Table structure for la_file
-- ----------------------------
DROP TABLE IF EXISTS `la_file`;
CREATE TABLE `la_file`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `cid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '类目ID',
  `source_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上传者id',
  `source` tinyint(1) NOT NULL DEFAULT 0 COMMENT '来源类型[0-后台,1-用户]',
  `type` tinyint(2) UNSIGNED NOT NULL DEFAULT 10 COMMENT '类型[10=图片, 20=视频]',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '文件名称',
  `uri` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件路径',
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 92 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文件表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_file
-- ----------------------------
INSERT INTO `la_file` VALUES (1, 0, 1, 1, 10, '1762570703953_cro_avatar.png', 'uploads/images/20251108/202511081058236b8676341.png', 1762570703, 1762570703, NULL);
INSERT INTO `la_file` VALUES (2, 0, 1, 1, 10, '1762570712887_cro_avatar.png', 'uploads/images/20251108/20251108105832e583f3750.png', 1762570712, 1762570712, NULL);
INSERT INTO `la_file` VALUES (3, 0, 1, 1, 10, 'O1CN01qdwXab1a92RXBH5ih_!!2872433286-2-alimamacc.png', 'uploads/images/20251108/20251108152603fb3b65902.png', 1762586763, 1762586763, NULL);
INSERT INTO `la_file` VALUES (4, 0, 1, 1, 10, 'O1CN01qdwXab1a92RXBH5ih_!!2872433286-2-alimamacc.png', 'uploads/images/20251108/20251108152914804209993.png', 1762586954, 1762586954, NULL);
INSERT INTO `la_file` VALUES (5, 0, 1, 1, 10, 'O1CN01qdwXab1a92RXBH5ih_!!2872433286-2-alimamacc.png', 'uploads/images/20251108/202511081535026f7e13179.png', 1762587302, 1762587302, NULL);
INSERT INTO `la_file` VALUES (6, 0, 1, 1, 10, '86547c3c289aad6.jpg', 'uploads/images/20251110/20251110203406590799533.jpg', 1762778046, 1762778046, NULL);
INSERT INTO `la_file` VALUES (7, 0, 0, 0, 10, '202508201432180ef187919[1].jpg', 'uploads/images/20251112/202511121409101d3fd5650.jpg', 1762927750, 1762927750, NULL);
INSERT INTO `la_file` VALUES (8, 0, 1, 1, 10, '1762938138432_cro_avatar.png', 'uploads/images/20251112/202511121702190f2ec3520.png', 1762938139, 1762938139, NULL);
INSERT INTO `la_file` VALUES (9, 0, 1, 1, 10, '1762938143957_cro_avatar.png', 'uploads/images/20251112/20251112170224bfd672416.png', 1762938144, 1762938144, NULL);
INSERT INTO `la_file` VALUES (10, 0, 1, 1, 10, '1762938152334_cro_avatar.png', 'uploads/images/20251112/202511121702323c1643659.png', 1762938152, 1762938152, NULL);
INSERT INTO `la_file` VALUES (11, 0, 0, 0, 10, '2025052917414577ce34440[1].jpg', 'uploads/images/20251112/202511121732292b6cf4649.jpg', 1762939949, 1762939949, NULL);
INSERT INTO `la_file` VALUES (12, 0, 0, 0, 10, 'bg.jpg', 'uploads/images/20251112/2025111219120530c6b7643.jpg', 1762945925, 1762945925, NULL);
INSERT INTO `la_file` VALUES (13, 0, 0, 0, 10, '20250523203057c85fc6773[1].png', 'uploads/images/20251112/20251112192405667c60359.png', 1762946645, 1762946645, NULL);
INSERT INTO `la_file` VALUES (14, 0, 0, 0, 10, '2025052619071403ff97750[1].png', 'uploads/images/20251113/202511130825265876a0842.png', 1762993526, 1762993526, NULL);
INSERT INTO `la_file` VALUES (15, 0, 0, 0, 10, '20250526191105ce2d26731[1].png', 'uploads/images/20251113/2025111308255094aee7386.png', 1762993550, 1762993550, NULL);
INSERT INTO `la_file` VALUES (16, 0, 0, 0, 10, '20250526200745d58a72866[1].png', 'uploads/images/20251113/20251113082607c51ac5717.png', 1762993567, 1762993567, NULL);
INSERT INTO `la_file` VALUES (17, 0, 0, 0, 10, '2025052620101156df80043[1].png', 'uploads/images/20251113/20251113082625ec5309764.png', 1762993585, 1762993585, NULL);
INSERT INTO `la_file` VALUES (18, 0, 1, 1, 10, '2025052620101156df80043[1].png', 'uploads/images/20251113/202511130938573c4d31101.png', 1762997937, 1762997937, NULL);
INSERT INTO `la_file` VALUES (19, 0, 1, 1, 10, '2025052620101156df80043[2].png', 'uploads/images/20251113/20251113093857be3975179.png', 1762997937, 1762997937, NULL);
INSERT INTO `la_file` VALUES (20, 0, 1, 1, 10, '2025052620101156df80043[2].png', 'uploads/images/20251113/202511131000007776c4196.png', 1762999200, 1762999200, NULL);
INSERT INTO `la_file` VALUES (21, 0, 1, 1, 10, '2025052620101156df80043[1].png', 'uploads/images/20251113/2025111310000015a5e4801.png', 1762999200, 1762999200, NULL);
INSERT INTO `la_file` VALUES (22, 0, 1, 1, 10, '2025052620101156df80043[1].png', 'uploads/images/20251113/2025111310023749b6b9785.png', 1762999357, 1762999357, NULL);
INSERT INTO `la_file` VALUES (23, 0, 1, 1, 10, '2025052620101156df80043[2].png', 'uploads/images/20251113/2025111310023743f402320.png', 1762999357, 1762999357, NULL);
INSERT INTO `la_file` VALUES (24, 0, 1, 1, 10, '8f50929f00fc9ce147b09221ec23fa0b.jpeg', 'uploads/images/20251116/20251116162701d42270967.jpeg', 1763281621, 1763281621, NULL);
INSERT INTO `la_file` VALUES (25, 0, 1, 1, 10, '37fb57e0c0c093717a58550726b26196.png', 'uploads/images/20251116/2025111616310977df61733.png', 1763281869, 1763281869, NULL);
INSERT INTO `la_file` VALUES (26, 0, 1, 1, 10, '8f50929f00fc9ce147b09221ec23fa0b.jpeg', 'uploads/images/20251116/202511161631355fb7f4254.jpeg', 1763281895, 1763281895, NULL);
INSERT INTO `la_file` VALUES (27, 0, 1, 1, 10, '37fb57e0c0c093717a58550726b26196.png', 'uploads/images/20251116/20251116163141b8b292690.png', 1763281901, 1763281901, NULL);
INSERT INTO `la_file` VALUES (28, 0, 1, 1, 10, '2d9e68c9398d09b907aacbffa5e8e4d4.jpeg', 'uploads/images/20251116/20251116163339e3aa70083.jpeg', 1763282019, 1763282019, NULL);
INSERT INTO `la_file` VALUES (29, 0, 1, 1, 10, '2d9e68c9398d09b907aacbffa5e8e4d4.jpeg', 'uploads/images/20251116/20251116174141a49eb4201.jpeg', 1763286101, 1763286101, NULL);
INSERT INTO `la_file` VALUES (30, 0, 1, 1, 10, '2d9e68c9398d09b907aacbffa5e8e4d4.jpeg', 'uploads/images/20251116/2025111617421808a897547.jpeg', 1763286138, 1763286138, NULL);
INSERT INTO `la_file` VALUES (31, 0, 1, 1, 10, '2d9e68c9398d09b907aacbffa5e8e4d4.jpeg', 'uploads/images/20251116/202511161748152cb0a9011.jpeg', 1763286495, 1763286495, NULL);
INSERT INTO `la_file` VALUES (32, 0, 1, 1, 10, '2d9e68c9398d09b907aacbffa5e8e4d4.jpeg', 'uploads/images/20251116/202511161749034aa987989.jpeg', 1763286543, 1763286543, NULL);
INSERT INTO `la_file` VALUES (33, 0, 1, 1, 10, '2d9e68c9398d09b907aacbffa5e8e4d4.jpeg', 'uploads/images/20251116/202511161753256fa228587.jpeg', 1763286805, 1763286805, NULL);
INSERT INTO `la_file` VALUES (34, 0, 1, 1, 10, '2d9e68c9398d09b907aacbffa5e8e4d4.jpeg', 'uploads/images/20251116/2025111617535332e540092.jpeg', 1763286833, 1763286833, NULL);
INSERT INTO `la_file` VALUES (35, 0, 2, 1, 10, '1000019001.jpg', 'uploads/images/20251116/20251116175559580dd4493.jpg', 1763286959, 1763286959, NULL);
INSERT INTO `la_file` VALUES (36, 0, 1, 1, 10, '2d9e68c9398d09b907aacbffa5e8e4d4.jpeg', 'uploads/images/20251116/20251116182710cf9e70789.jpeg', 1763288830, 1763288830, NULL);
INSERT INTO `la_file` VALUES (37, 0, 1, 1, 10, '2d9e68c9398d09b907aacbffa5e8e4d4.jpeg', 'uploads/images/20251116/2025111618281525eef8660.jpeg', 1763288895, 1763288895, NULL);
INSERT INTO `la_file` VALUES (38, 0, 5, 1, 10, 'Screenshot_20251115_092606.jpg', 'uploads/images/20251116/20251116214344d366e3072.jpg', 1763300624, 1763300624, NULL);
INSERT INTO `la_file` VALUES (39, 0, 5, 1, 10, '1763301221580_cro_avatar.png', 'uploads/images/20251116/20251116215341b1f136930.png', 1763301221, 1763301221, NULL);
INSERT INTO `la_file` VALUES (40, 0, 0, 0, 10, '202506171347597e9710897[1].png', 'uploads/images/20251117/2025111708360056c700044.png', 1763339760, 1763339760, NULL);
INSERT INTO `la_file` VALUES (41, 0, 1, 1, 10, '202506171347597e9710897[2].png', 'uploads/images/20251117/202511171027537bdff2163.png', 1763346473, 1763346473, NULL);
INSERT INTO `la_file` VALUES (42, 0, 1, 1, 10, '202506171347597e9710897[2].png', 'uploads/images/20251117/20251117103144039b20231.png', 1763346704, 1763346704, NULL);
INSERT INTO `la_file` VALUES (43, 0, 1, 1, 10, '202506171347597e9710897[2].png', 'uploads/images/20251117/20251117103249233b09231.png', 1763346769, 1763346769, NULL);
INSERT INTO `la_file` VALUES (44, 0, 1, 1, 10, '202506171347597e9710897[2].png', 'uploads/images/20251117/202511171033530f6378179.png', 1763346833, 1763346833, NULL);
INSERT INTO `la_file` VALUES (45, 0, 1, 1, 10, '202506171347597e9710897[2].png', 'uploads/images/20251117/20251117103433127e49628.png', 1763346873, 1763346873, NULL);
INSERT INTO `la_file` VALUES (46, 0, 1, 1, 10, '202506171347597e9710897[2].png', 'uploads/images/20251117/202511171035442876b9739.png', 1763346944, 1763346944, NULL);
INSERT INTO `la_file` VALUES (47, 0, 1, 1, 10, '202506171347597e9710897[2].png', 'uploads/images/20251117/20251117103634f94813681.png', 1763346994, 1763346994, NULL);
INSERT INTO `la_file` VALUES (48, 0, 1, 1, 10, '202506171347597e9710897[2].png', 'uploads/images/20251117/20251117103708a0c416999.png', 1763347028, 1763347028, NULL);
INSERT INTO `la_file` VALUES (49, 0, 4, 1, 10, 'IMG_0254.jpeg', 'uploads/images/20251117/20251117123255cf7110694.jpeg', 1763353975, 1763353975, NULL);
INSERT INTO `la_file` VALUES (50, 0, 1, 1, 10, '202506171347597e9710897[2].png', 'uploads/images/20251117/202511171358395e6f55630.png', 1763359119, 1763359119, NULL);
INSERT INTO `la_file` VALUES (51, 0, 1, 1, 10, '衣服2.jpg', 'uploads/images/20251117/20251117135907db2e79038.jpg', 1763359147, 1763359147, NULL);
INSERT INTO `la_file` VALUES (52, 0, 1, 1, 10, '86547c3c289aad6.jpg', 'uploads/images/20251117/20251117171428c55686593.jpg', 1763370868, 1763370868, NULL);
INSERT INTO `la_file` VALUES (53, 0, 1, 1, 10, 'ChMkJ1kRrUGIU6bFAB7EyXOo1FoAAcQtwIB8tMAHsTh613[1].jpg', 'uploads/images/20251117/20251117171514b17b98252.jpg', 1763370914, 1763370914, NULL);
INSERT INTO `la_file` VALUES (54, 0, 1, 1, 10, 'ChMkJ1kRrUGIU6bFAB7EyXOo1FoAAcQtwIB8tMAHsTh613[1].jpg', 'uploads/images/20251117/202511171741427cd4b8987.jpg', 1763372502, 1763372502, NULL);
INSERT INTO `la_file` VALUES (55, 0, 1, 1, 10, '1763374877136_cro_avatar.png', 'uploads/images/20251117/2025111718211724bd23037.png', 1763374877, 1763374877, NULL);
INSERT INTO `la_file` VALUES (56, 0, 1, 1, 10, '8f50929f00fc9ce147b09221ec23fa0b.jpeg', 'uploads/images/20251117/202511172023408e8175740.jpeg', 1763382220, 1763382220, NULL);
INSERT INTO `la_file` VALUES (57, 0, 1, 1, 10, '8f50929f00fc9ce147b09221ec23fa0b.jpeg', 'uploads/images/20251117/202511172024292de910019.jpeg', 1763382269, 1763382269, NULL);
INSERT INTO `la_file` VALUES (58, 0, 1, 1, 10, '951671675f24ab3ffb2a60eb5e60c810.jpeg', 'uploads/images/20251117/20251117203011cf9736436.jpeg', 1763382611, 1763382611, NULL);
INSERT INTO `la_file` VALUES (59, 0, 1, 1, 10, '951671675f24ab3ffb2a60eb5e60c810.jpeg', 'uploads/images/20251117/2025111720315272df96070.jpeg', 1763382712, 1763382712, NULL);
INSERT INTO `la_file` VALUES (60, 0, 1, 1, 10, '951671675f24ab3ffb2a60eb5e60c810.jpeg', 'uploads/images/20251117/202511172033466435b3117.jpeg', 1763382826, 1763382826, NULL);
INSERT INTO `la_file` VALUES (61, 0, 13, 1, 10, 'IMG_2249.jpeg', 'uploads/images/20251117/202511172053125a0c03180.jpeg', 1763383992, 1763383992, NULL);
INSERT INTO `la_file` VALUES (62, 0, 14, 1, 10, 'IMG_20251005_150447.jpg', 'uploads/images/20251117/2025111720584351a551377.jpg', 1763384323, 1763384324, NULL);
INSERT INTO `la_file` VALUES (63, 0, 14, 1, 10, 'Camera_XHS_1763024335079.jpg', 'uploads/images/20251117/202511172059027be999514.jpg', 1763384342, 1763384342, NULL);
INSERT INTO `la_file` VALUES (64, 0, 14, 1, 10, 'Camera_XHS_1763024335079.jpg', 'uploads/images/20251117/20251117210038564ef5446.jpg', 1763384438, 1763384438, NULL);
INSERT INTO `la_file` VALUES (65, 0, 16, 1, 10, '联想截图_20240307162727.png', 'uploads/images/20251117/20251117212032ebb582945.png', 1763385632, 1763385632, NULL);
INSERT INTO `la_file` VALUES (66, 0, 16, 1, 10, '1763385851757_cro_avatar.png', 'uploads/images/20251117/20251117212409481412479.png', 1763385849, 1763385849, NULL);
INSERT INTO `la_file` VALUES (67, 0, 16, 1, 10, '1763385874627_cro_avatar.png', 'uploads/images/20251117/20251117212503f79c08859.png', 1763385903, 1763385903, NULL);
INSERT INTO `la_file` VALUES (68, 0, 16, 1, 10, '1763385873549_cro_avatar.png', 'uploads/images/20251117/2025111721250382d9f7548.png', 1763385903, 1763385903, NULL);
INSERT INTO `la_file` VALUES (69, 0, 16, 1, 10, '1763385875196_cro_avatar.png', 'uploads/images/20251117/20251117212503b38133601.png', 1763385903, 1763385903, NULL);
INSERT INTO `la_file` VALUES (70, 0, 1, 1, 10, 'O1CN018bv7Kd1OxcV9qxUS0_!!0-saturn_solar.jpg', 'uploads/images/20251118/20251118114731262fd2873.jpg', 1763437651, 1763437651, NULL);
INSERT INTO `la_file` VALUES (71, 0, 4, 1, 10, 'IMG_0273.png', 'uploads/images/20251118/20251118212407192523735.png', 1763472247, 1763472247, NULL);
INSERT INTO `la_file` VALUES (72, 0, 4, 1, 10, 'AD0FFF04-BAF8-4D70-B388-404C4B2F2C46.jpeg', 'uploads/images/20251118/202511182124155b2c34363.jpeg', 1763472255, 1763472255, NULL);
INSERT INTO `la_file` VALUES (73, 0, 1, 1, 10, '388379538bf2af745f3f7cfea82816a2[1].jpg', 'uploads/images/20251118/202511182139328227a7215.jpg', 1763473172, 1763473172, NULL);
INSERT INTO `la_file` VALUES (74, 0, 1, 1, 10, 'O1CN01qdwXab1a92RXBH5ih_!!2872433286-2-alimamacc.png', 'uploads/images/20251119/2025111914315207e307619.png', 1763533912, 1763533912, NULL);
INSERT INTO `la_file` VALUES (75, 0, 1, 1, 10, 'O1CN01qdwXab1a92RXBH5ih_!!2872433286-2-alimamacc.png', 'uploads/images/20251119/202511191436176f0d45863.png', 1763534177, 1763534177, NULL);
INSERT INTO `la_file` VALUES (76, 0, 1, 1, 10, 'O1CN01qdwXab1a92RXBH5ih_!!2872433286-2-alimamacc.png', 'uploads/images/20251119/202511191437112b62e8394.png', 1763534231, 1763534231, NULL);
INSERT INTO `la_file` VALUES (77, 0, 1, 1, 10, 'O1CN01TOhlPD1i3YdMu0xcN_!!713464357-0-alimamacc.jpg', 'uploads/images/20251119/20251119150223df5677950.jpg', 1763535743, 1763535743, NULL);
INSERT INTO `la_file` VALUES (78, 0, 1, 1, 10, 'O1CN015RvG062LY21272Yef_!!3937219703-0-C2M.jpg', 'uploads/images/20251119/2025111915030973e3f4605.jpg', 1763535789, 1763535789, NULL);
INSERT INTO `la_file` VALUES (79, 0, 1, 1, 10, 'O1CN01RKUmyF1NboL0UJPxD_!!0-item_pic.jpg', 'uploads/images/20251119/2025111915034469b0f1408.jpg', 1763535824, 1763535824, NULL);
INSERT INTO `la_file` VALUES (80, 0, 1, 1, 10, 'O1CN01dxCMTD1VubW3R5sGD_!!0-item_pic.jpg', 'uploads/images/20251119/202511191504075613d9112.jpg', 1763535847, 1763535847, NULL);
INSERT INTO `la_file` VALUES (81, 0, 1, 1, 10, '柜子.jpg', 'uploads/images/20251119/20251119154215719437306.jpg', 1763538135, 1763538135, NULL);
INSERT INTO `la_file` VALUES (82, 0, 1, 1, 10, 'O1CN015RvG062LY21272Yef_!!3937219703-0-C2M.jpg', 'uploads/images/20251119/202511191542154a3909062.jpg', 1763538135, 1763538135, NULL);
INSERT INTO `la_file` VALUES (83, 0, 1, 1, 10, '1763606143171_cro_avatar.png', 'uploads/images/20251120/20251120103543085310723.png', 1763606143, 1763606143, NULL);
INSERT INTO `la_file` VALUES (84, 0, 1, 1, 10, '1763606157301_cro_avatar.png', 'uploads/images/20251120/20251120103557cd2fb0580.png', 1763606157, 1763606157, NULL);
INSERT INTO `la_file` VALUES (85, 0, 1, 1, 10, 'O1CN01SRbT5O25mCOUegNNJ_!!2210923507568-0-alimamacc.jpg', 'uploads/images/20251120/20251120154124167db0762.jpg', 1763624484, 1763624484, NULL);
INSERT INTO `la_file` VALUES (86, 0, 1, 1, 10, 'O1CN01D0Djpl1Sf5DxOBJwK_!!0-item_pic.jpg', 'uploads/images/20251120/2025112015472128bae2922.jpg', 1763624841, 1763624841, NULL);
INSERT INTO `la_file` VALUES (87, 0, 1, 1, 10, '柜子.jpg', 'uploads/images/20251120/20251120204532bd15f1547.jpg', 1763642732, 1763642732, NULL);
INSERT INTO `la_file` VALUES (88, 0, 12, 1, 10, 'f14786e5-5934-4bea-9130-727e39e3d7db1761021894129.jpeg', 'uploads/images/20251120/20251120233622e8a742668.jpeg', 1763652982, 1763652982, NULL);
INSERT INTO `la_file` VALUES (89, 0, 4, 1, 10, 'IMG_0351.webp', 'uploads/images/20251122/20251122002751dd5495713.webp', 1763742471, 1763742471, NULL);
INSERT INTO `la_file` VALUES (90, 0, 1, 1, 10, 'O1CN01HLCOnJ1K85n2NdgSY_!!0-saturn_solar.jpg', 'uploads/images/20251201/2025120113104958d407369.jpg', 1764565849, 1764565849, NULL);
INSERT INTO `la_file` VALUES (91, 0, 0, 0, 10, 'no_permission.png', 'uploads/images/20251201/202512011713217c0032865.png', 1764580401, 1764580401, NULL);

-- ----------------------------
-- Table structure for la_file_cate
-- ----------------------------
DROP TABLE IF EXISTS `la_file_cate`;
CREATE TABLE `la_file_cate`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父级ID',
  `type` tinyint(2) UNSIGNED NOT NULL DEFAULT 10 COMMENT '类型[10=图片，20=视频，30=文件]',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文件分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_file_cate
-- ----------------------------

-- ----------------------------
-- Table structure for la_generate_column
-- ----------------------------
DROP TABLE IF EXISTS `la_generate_column`;
CREATE TABLE `la_generate_column`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `table_id` int(11) NOT NULL DEFAULT 0 COMMENT '表id',
  `column_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '字段名称',
  `column_comment` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '字段描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '字段类型',
  `is_required` tinyint(1) NULL DEFAULT 0 COMMENT '是否必填 0-非必填 1-必填',
  `is_pk` tinyint(1) NULL DEFAULT 0 COMMENT '是否为主键 0-不是 1-是',
  `is_insert` tinyint(1) NULL DEFAULT 0 COMMENT '是否为插入字段 0-不是 1-是',
  `is_update` tinyint(1) NULL DEFAULT 0 COMMENT '是否为更新字段 0-不是 1-是',
  `is_lists` tinyint(1) NULL DEFAULT 0 COMMENT '是否为列表字段 0-不是 1-是',
  `is_query` tinyint(1) NULL DEFAULT 0 COMMENT '是否为查询字段 0-不是 1-是',
  `query_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '=' COMMENT '查询类型',
  `view_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'input' COMMENT '显示类型',
  `dict_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `create_time` int(10) NOT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 351 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成表字段信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_generate_column
-- ----------------------------
INSERT INTO `la_generate_column` VALUES (1, 1, 'id', '圈子id', 'int', 0, 1, 0, 0, 0, 0, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (2, 1, 'name', '圈子名称', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (3, 1, 'synopsis', '简介', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (4, 1, 'sort', '排序', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (5, 1, 'is_show', '是否显示 0-隐藏 1-显示', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (6, 1, 'icon', '图标', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (7, 1, 'pid', '父级', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (8, 1, 'home_show', '是否首页显示 0-隐藏 1-显示', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (9, 1, 'create_time', '创建时间', 'int', 0, 0, 0, 0, 0, 0, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (10, 1, 'update_time', '更新时间', 'int', 0, 0, 0, 0, 0, 0, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (11, 1, 'delete_time', '删除时间', 'int', 0, 0, 0, 0, 0, 0, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (12, 1, 'cate_id', '分类ID', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (13, 1, 'subscription_price', '订阅收费', 'float', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (14, 1, 'release_price', '发帖收费', 'float', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (15, 1, 'vip_level_id', '有id=需要某个vip身份才才能访问', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (16, 1, 'template', '模板', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (17, 1, 'chat_status', '1=开启群聊,2=关闭群聊', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (18, 1, 'bg_image', '圈子背景图', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (19, 1, 'user_id', '创建者用户id', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (20, 1, 'status', '0=待审核,1=审核通过,2=拒审,3=已注销', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (21, 1, 'examine_msg', '审核结果信息', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (22, 1, 'send_limit_day', '发布限制次数0代表无限制', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (23, 1, 'visit_level', '访问权限用户等级,0=无限制', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (24, 1, 'send_level', '发帖等级限制', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (25, 1, 'reply_level', '回帖等级限制', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (26, 1, 'disable_reply', '禁止回复', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (27, 1, 'disbale_upload_image', '禁止发表图片', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (28, 1, 'diable_upload_file', '禁止上传附件', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (29, 1, 'notice', '圈子公告', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (30, 1, 'label', '标签', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (31, 1, 'is_pay', '是否支付', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (32, 1, 'only_circle_send', '只允许圈主发帖', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (33, 1, 'signal_get_experience', '签到获得经验', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (34, 1, 'is_hot', '是否热门', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (35, 1, 'is_recommend', '是否推荐', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (36, 1, 'edit_template', '编辑模板', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (37, 1, 'latitude', '纬度', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (38, 1, 'longitude', '经度', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (39, 1, 'dz_id', 'discuz的id', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842247);
INSERT INTO `la_generate_column` VALUES (40, 2, 'id', '评论id', 'int', 0, 1, 0, 0, 0, 0, '=', 'input', '', 1762841849, 1762842209);
INSERT INTO `la_generate_column` VALUES (41, 2, 'aid', '帖子id', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842209);
INSERT INTO `la_generate_column` VALUES (42, 2, 'pid', '评论id 0评论帖子; 评论id = 子评论', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842209);
INSERT INTO `la_generate_column` VALUES (43, 2, 'user_id', '用户id', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842209);
INSERT INTO `la_generate_column` VALUES (44, 2, 'comment', '评论文本', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842209);
INSERT INTO `la_generate_column` VALUES (45, 2, 'content', '评论内容带格式', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842209);
INSERT INTO `la_generate_column` VALUES (46, 2, 'status', '审核状态 0-待审核 1-审核通过 2-审核拒绝', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842209);
INSERT INTO `la_generate_column` VALUES (47, 2, 'topic_id', '#话题 id,多个话题逗号分隔', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842209);
INSERT INTO `la_generate_column` VALUES (48, 2, 'msg_user_ids', '@用户id,多个用户逗号分隔', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842209);
INSERT INTO `la_generate_column` VALUES (49, 2, 'create_time', '创建时间', 'int', 0, 0, 0, 0, 0, 0, '=', 'input', '', 1762841849, 1762842209);
INSERT INTO `la_generate_column` VALUES (50, 2, 'update_time', '更新时间', 'int', 0, 0, 0, 0, 0, 0, '=', 'input', '', 1762841849, 1762842209);
INSERT INTO `la_generate_column` VALUES (51, 2, 'delete_time', '删除时间', 'int', 0, 0, 0, 0, 0, 0, '=', 'input', '', 1762841849, 1762842209);
INSERT INTO `la_generate_column` VALUES (52, 2, 'ip', 'ip', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842209);
INSERT INTO `la_generate_column` VALUES (53, 2, 'ip_address', 'ip解析后的地址名', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842209);
INSERT INTO `la_generate_column` VALUES (54, 2, 'star_num', '点赞数', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842209);
INSERT INTO `la_generate_column` VALUES (55, 2, 'goods_id', '自营商城商品', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842209);
INSERT INTO `la_generate_column` VALUES (56, 2, 'reply_user_id', '回复用户id', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842209);
INSERT INTO `la_generate_column` VALUES (57, 2, 'floor', '楼层', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842209);
INSERT INTO `la_generate_column` VALUES (58, 2, 'is_pin', '是否置顶', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842209);
INSERT INTO `la_generate_column` VALUES (59, 2, 'is_author_star', '作者赞过', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842209);
INSERT INTO `la_generate_column` VALUES (60, 2, 'dz_id', 'discuz的id', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842209);
INSERT INTO `la_generate_column` VALUES (61, 3, 'id', 'id', 'int', 0, 1, 0, 0, 0, 0, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (62, 3, 'user_id', '用户Id', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (63, 3, 'type', '帖子类型 1文章 2视频', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (64, 3, 'title', '标题', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (65, 3, 'image', '封面图,多个图片逗号分隔', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (66, 3, 'content', '文章内容', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (67, 3, 'visit', '浏览人数', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (68, 3, 'sort', '排序', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (69, 3, 'status', '审核状态  0-待审核 1-显示  2驳回', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (70, 3, 'is_top', '置顶  1是 0否', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (71, 3, 'is_recomment', '推荐  1是 0否', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (72, 3, 'region', '地区', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (73, 3, 'video', '视频', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (74, 3, 'video_cover', '视频封面', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (75, 3, 'pay_money', '支付金额，有支付金额为付费帖', 'float', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (76, 3, 'topic_ids', '#所属话题，多个逗号分隔', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (77, 3, 'circle_id', '所属圈子', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (78, 3, 'user_ids', '@用户信息，多个逗号分隔', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (79, 3, 'is_open', '是否公开  1公开 2不公开', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (80, 3, 'create_time', '创建时间', 'int', 0, 0, 0, 0, 0, 0, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (81, 3, 'update_time', '更新时间', 'int', 0, 0, 0, 0, 0, 0, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (82, 3, 'delete_time', '删除时间', 'int', 0, 0, 0, 0, 0, 0, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (83, 3, 'goods_id', '商品ID', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (84, 3, 'vip_level_id', 'null=无需vip,vip_id=阅读需要某个vip身份', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (85, 3, 'field_values', '搜索字段内容', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (86, 3, 'ip', 'ip地址', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (87, 3, 'ip_address', 'ip解析后的地址名', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (88, 3, 'is_show', '是否显示', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (89, 3, 'release_pay', '发布付费:1=已支付,0=未支付,2=无需支付', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (90, 3, 'examine_result', '审核结果：0（审核正常），1 （判定为违规敏感文件），2（疑似敏感，建议人工复核）', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (91, 3, 'examine_id', '审核平台的任务id', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (92, 3, 'examine_label', '审核标签', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (93, 3, 'examine_msg', '审核内容提示', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (94, 3, 'free_image_count', '免费预览图片个数', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (95, 3, 'free_vip', '允许会员免费', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (96, 3, 'free_word_count', '免费预览文本字数', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (97, 3, 'free_video_time', '免费试看多少秒', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (98, 3, 'file', '附件', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (99, 3, 'cloud_url', '网盘链接', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (100, 3, 'cloud_password', '网盘密码', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (101, 3, 'polish_time', '擦亮时间', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (102, 3, 'only_look_user_ids', '仅哪些用户可见', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (103, 3, 'disable_look_user_ids', '不给哪些用户看', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (104, 3, 'only_look_user_level', '仅用户达到多少级后可见', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (105, 3, 'only_look_follow', '仅关注可见', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (106, 3, 'sub_category_id', '圈子下的子分类', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (107, 3, 'title_pinyin', '标题拼音', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (108, 3, 'content_pinyin', '内容拼音', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (109, 3, 'reply_visible_content', '回复可见指定内容', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (110, 3, 'mp3', '音频', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (111, 3, 'chat_group_id', '聊天组id', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (112, 3, 'city', '市区', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (113, 3, 'province', '省', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (114, 3, 'area', '区/详细地址', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (115, 3, 'city_json', '城市json', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (116, 3, 'longitude', '经度', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (117, 3, 'latitude', '纬度', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (118, 3, 'label', '标签', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (119, 3, 'terminal', '0=未知,1-微信小程序；2-微信公众号；3-手机H5；4-电脑PC；5-苹果APP；6-安卓APP\'', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (120, 3, 'reply_only_visible_author', '评论仅作者可见', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (121, 3, 'share_count', '分享次数', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (122, 3, 'region_ids', '地区库id以‘,’分割如:,1,2,', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (123, 3, 'contact_phone', '联系手机号', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (124, 3, 'contact_name', '联系人', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (125, 3, 'contact_wechat', '联系微信号', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (126, 3, 'dz_id', 'discuz的id', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (127, 3, 'vars', '变量', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762841849, 1762842184);
INSERT INTO `la_generate_column` VALUES (206, 4, 'id', '', 'int', 0, 1, 0, 0, 0, 0, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (207, 4, 'sn', '会员码', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (208, 4, 'nickname', '用户昵称', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (209, 4, 'avatar', '用户头像', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (210, 4, 'real_name', '真实姓名', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (211, 4, 'mobile', '手机号码', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (212, 4, 'level', '等级', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (213, 4, 'group_id', '所属分组id', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (214, 4, 'sex', '性别:0-未知；1-男；2-女', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (215, 4, 'birthday', '生日', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (216, 4, 'user_money', '用户余额', 'float', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (217, 4, 'user_integral', '用户积分', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (218, 4, 'total_order_amount', '消费累计额度', 'float', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (219, 4, 'total_order_num', '累计消费次数', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (220, 4, 'total_recharge_amount', '累计充值金额', 'float', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (221, 4, 'account', '账号', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (222, 4, 'password', '密码', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (223, 4, 'pay_password', '支付密码', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (224, 4, 'login_time', '最后登录时间', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (225, 4, 'login_ip', '最后登录ip', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (226, 4, 'disable', '是否禁用：0-否；1-是；', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (227, 4, 'user_growth', '用户成长值', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (228, 4, 'remark', '备注', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (229, 4, 'first_leader', '第一个上级', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (230, 4, 'second_leader', '第二个上级', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (231, 4, 'third_leader', '第三个上级', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (232, 4, 'ancestor_relation', '关系链', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (233, 4, 'code', '邀请码', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (234, 4, 'user_earnings', '用户收益(可提现)', 'float', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (235, 4, 'register_source', '用户注册来源', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (236, 4, 'inviter_id', '邀请人id', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (237, 4, 'id_card', '身份证号', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (238, 4, 'is_certification', '是否认证： 0-否 1-通过;', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (239, 4, 'push_clientid', 'app推送设备标识', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (240, 4, 'create_time', '创建时间', 'int', 0, 0, 0, 0, 0, 0, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (241, 4, 'update_time', '修改时间', 'int', 0, 0, 0, 0, 0, 0, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (242, 4, 'delete_time', '删除时间', 'int', 0, 0, 0, 0, 0, 0, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (243, 4, 'is_new_user', '是否是新注册用户:1-是;0-否;', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (244, 4, 'is_logoff', '是否注销申请:1-是;0-否;', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (245, 4, 'credit', '信用分：良好=60-70，优秀=70-80,极好=80-100,一般=50-60,差=50以下', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (246, 4, 'vip_expire_time', 'vip到期时间', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (247, 4, 'vip_level_id', 'vip等级id', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (248, 4, 'ip', '', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (249, 4, 'ip_address', '', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (250, 4, 'home_bg', '背景图', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (251, 4, 'notice_comment_auth_check', '0', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (252, 4, 'private_like', '', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (253, 4, 'private_follow', '', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (254, 4, 'private_collect', '', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (255, 4, 'private_fans', '', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (256, 4, 'private_visitor', '', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842322, 1762842322);
INSERT INTO `la_generate_column` VALUES (257, 4, 'only_look_ids', '仅用户可见', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (258, 4, 'withdraw_wepay_code', '提现微信收款二维码', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (259, 4, 'withdraw_alipay_code', '提现支付宝收款二维码', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (260, 4, 'withdraw_name', '提现真实姓名', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (261, 4, 'withdraw_alipay_account', '提现支付宝账号', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (262, 4, 'desc', '个人简介', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (263, 4, 'longitude', '经度', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (264, 4, 'latitude', '纬度', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (265, 4, 'address', '地址', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (266, 4, 'district', '区', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (267, 4, 'city', '城市', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (268, 4, 'province', '省', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (269, 4, 'county', '县', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (270, 4, 'area', '具体定位', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (271, 4, 'birth', '出生年月日', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (272, 4, 'career', '职业', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (273, 4, 'height', '身高', 'float', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (274, 4, 'weight', '体重', 'float', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (275, 4, 'experience', '经验', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (276, 4, 'last_online_time', '最后上线时间', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (277, 4, 'is_fake_user', '', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (278, 4, 'fake_user_owner_id', '', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (279, 4, 'is_fake_admin', '', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (280, 4, 'salt', '', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (281, 4, 'dz_uid', '', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (282, 4, 'font_size', '字体大小倍数', 'float', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (283, 4, 'theme', '主题', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762842323, 1762842323);
INSERT INTO `la_generate_column` VALUES (284, 5, 'id', 'id', 'int', 0, 1, 0, 0, 0, 0, '=', 'input', '', 1762864340, 1762864436);
INSERT INTO `la_generate_column` VALUES (285, 5, 'name', '名称', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762864340, 1762864436);
INSERT INTO `la_generate_column` VALUES (286, 5, 'sort', '排序', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762864340, 1762864436);
INSERT INTO `la_generate_column` VALUES (287, 5, 'is_show', '是否展示', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762864340, 1762864436);
INSERT INTO `la_generate_column` VALUES (288, 5, 'pid', '上级id', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762864340, 1762864436);
INSERT INTO `la_generate_column` VALUES (289, 5, 'create_time', '创建时间', 'int', 0, 0, 0, 0, 0, 0, '=', 'input', '', 1762864340, 1762864436);
INSERT INTO `la_generate_column` VALUES (290, 5, 'delete_time', '更新时间', 'int', 0, 0, 0, 0, 0, 0, '=', 'input', '', 1762864340, 1762864436);
INSERT INTO `la_generate_column` VALUES (291, 6, 'id', '轮播图ID', 'int', 0, 1, 0, 0, 0, 0, '=', 'input', '', 1762925832, 1762925832);
INSERT INTO `la_generate_column` VALUES (292, 6, 'title', '轮播图标题', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762925832, 1762925832);
INSERT INTO `la_generate_column` VALUES (293, 6, 'image', '图片URL', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762925832, 1762925832);
INSERT INTO `la_generate_column` VALUES (294, 6, 'desc', '描述文字', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762925832, 1762925832);
INSERT INTO `la_generate_column` VALUES (295, 6, 'sort', '排序权重(数字越大越靠前)', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762925832, 1762925832);
INSERT INTO `la_generate_column` VALUES (296, 6, 'jump_type', 'web=跳转网页,app=app内跳转', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762925832, 1762925832);
INSERT INTO `la_generate_column` VALUES (297, 6, 'jump_path', '跳转路径url', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762925832, 1762925832);
INSERT INTO `la_generate_column` VALUES (298, 6, 'jump_params', '跳转携带的参数', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762925832, 1762925832);
INSERT INTO `la_generate_column` VALUES (299, 6, 'status', '状态(0禁用,1启用)', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762925832, 1762925832);
INSERT INTO `la_generate_column` VALUES (300, 6, 'created_time', '创建时间', 'timestamp', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762925832, 1762925832);
INSERT INTO `la_generate_column` VALUES (301, 6, 'location', '位置:index=首页,goods=自营商城,twoshop=二手商城', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762925832, 1762925832);
INSERT INTO `la_generate_column` VALUES (302, 6, 'bg_color', '背景颜色亿,分割', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762925832, 1762925832);
INSERT INTO `la_generate_column` VALUES (303, 7, 'id', 'id', 'int', 0, 1, 0, 0, 0, 0, '=', 'input', '', 1762925904, 1762925935);
INSERT INTO `la_generate_column` VALUES (304, 7, 'name', '名称', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762925904, 1762925935);
INSERT INTO `la_generate_column` VALUES (305, 7, 'type', '类型', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762925904, 1762925935);
INSERT INTO `la_generate_column` VALUES (306, 7, 'path', '路径', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762925904, 1762925935);
INSERT INTO `la_generate_column` VALUES (307, 7, 'image', '图片', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762925904, 1762925935);
INSERT INTO `la_generate_column` VALUES (308, 7, 'params', '参数', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762925904, 1762925935);
INSERT INTO `la_generate_column` VALUES (309, 7, 'status', '状态', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762925904, 1762925935);
INSERT INTO `la_generate_column` VALUES (310, 7, 'location', '展示位置:index_tab=首页,index_image=首页的图片按钮,send=首页', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762925904, 1762925935);
INSERT INTO `la_generate_column` VALUES (311, 7, 'show_type', '展示形式,button=按钮,image=图片形式', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762925904, 1762925935);
INSERT INTO `la_generate_column` VALUES (312, 7, 'desc', '描述', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1762925904, 1762925935);
INSERT INTO `la_generate_column` VALUES (313, 7, 'sort', '排序', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1762925904, 1762925935);
INSERT INTO `la_generate_column` VALUES (314, 8, 'id', 'id', 'int', 0, 1, 0, 0, 0, 0, '=', 'input', '', 1763186137, 1763186167);
INSERT INTO `la_generate_column` VALUES (315, 8, 'name', '话题名称', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1763186137, 1763186167);
INSERT INTO `la_generate_column` VALUES (316, 8, 'synopsis', '简介', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1763186137, 1763186167);
INSERT INTO `la_generate_column` VALUES (317, 8, 'sort', '排序', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1763186137, 1763186167);
INSERT INTO `la_generate_column` VALUES (318, 8, 'status', '审核状态  1-正常 2驳回', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1763186137, 1763186167);
INSERT INTO `la_generate_column` VALUES (319, 8, 'create_time', '创建时间', 'int', 0, 0, 0, 0, 0, 0, '=', 'input', '', 1763186137, 1763186167);
INSERT INTO `la_generate_column` VALUES (320, 8, 'update_time', '更新时间', 'int', 0, 0, 0, 0, 0, 0, '=', 'input', '', 1763186137, 1763186167);
INSERT INTO `la_generate_column` VALUES (321, 8, 'delete_time', '删除时间', 'int', 0, 0, 0, 0, 0, 0, '=', 'input', '', 1763186137, 1763186167);
INSERT INTO `la_generate_column` VALUES (322, 8, 'longitude', '经度', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1763186137, 1763186167);
INSERT INTO `la_generate_column` VALUES (323, 8, 'latitude', '纬度', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1763186137, 1763186167);
INSERT INTO `la_generate_column` VALUES (324, 8, 'address', '位置', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1763186137, 1763186167);
INSERT INTO `la_generate_column` VALUES (325, 8, 'hot', '热度', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1763186137, 1763186167);
INSERT INTO `la_generate_column` VALUES (326, 8, 'bg_image', '背景图', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1763186137, 1763186167);
INSERT INTO `la_generate_column` VALUES (327, 8, 'bg_color', '背景颜色', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1763186137, 1763186167);
INSERT INTO `la_generate_column` VALUES (328, 9, 'id', 'id', 'int', 0, 1, 0, 0, 0, 0, '=', 'input', '', 1763186137, 1763186172);
INSERT INTO `la_generate_column` VALUES (329, 9, 'a_id', '帖子id', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1763186137, 1763186172);
INSERT INTO `la_generate_column` VALUES (330, 9, 'topic_id', '话题id', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1763186137, 1763186172);
INSERT INTO `la_generate_column` VALUES (331, 9, 'create_time', '加入时间', 'int', 0, 0, 0, 0, 0, 0, '=', 'input', '', 1763186137, 1763186172);
INSERT INTO `la_generate_column` VALUES (332, 10, 'id', 'id', 'int', 0, 1, 0, 0, 0, 0, '=', 'input', '', 1763206319, 1763206340);
INSERT INTO `la_generate_column` VALUES (333, 10, 'name', '分类名称', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1763206319, 1763206340);
INSERT INTO `la_generate_column` VALUES (334, 10, 'pid', '父级id', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1763206319, 1763206340);
INSERT INTO `la_generate_column` VALUES (335, 10, 'sort', '排序', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1763206319, 1763206340);
INSERT INTO `la_generate_column` VALUES (336, 10, 'status', '状态:1=启用,0=禁用', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1763206319, 1763206340);
INSERT INTO `la_generate_column` VALUES (337, 10, 'circle_id', '圈子id', 'int', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1763206319, 1763206340);
INSERT INTO `la_generate_column` VALUES (338, 10, 'label', '标签', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1763206319, 1763206340);
INSERT INTO `la_generate_column` VALUES (339, 10, 'edit_template', '编辑模板', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1763206319, 1763206340);
INSERT INTO `la_generate_column` VALUES (340, 10, 'image', '图片', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1763206319, 1763206340);
INSERT INTO `la_generate_column` VALUES (341, 11, 'id', 'id', 'int', 0, 1, 0, 0, 0, 0, '=', 'input', '', 1763292652, 1763292660);
INSERT INTO `la_generate_column` VALUES (342, 11, 'name', '分类名称', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1763292652, 1763292660);
INSERT INTO `la_generate_column` VALUES (343, 11, 'sort', '排序', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1763292652, 1763292660);
INSERT INTO `la_generate_column` VALUES (344, 11, 'status', '状态:1=启用,0=禁用', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1763292652, 1763292660);
INSERT INTO `la_generate_column` VALUES (345, 11, 'image', '图片', 'string', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1763292652, 1763292660);
INSERT INTO `la_generate_column` VALUES (346, 12, 'id', 'id', 'int', 0, 1, 0, 0, 0, 0, '=', 'input', '', 1763292652, 1763292652);
INSERT INTO `la_generate_column` VALUES (347, 12, 'category_id', '分类id', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1763292652, 1763292652);
INSERT INTO `la_generate_column` VALUES (348, 12, 'user_id', '用户id用户自定义表情', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1763292652, 1763292652);
INSERT INTO `la_generate_column` VALUES (349, 12, 'image', '分类图标', 'string', 1, 0, 1, 1, 1, 1, '=', 'input', '', 1763292652, 1763292652);
INSERT INTO `la_generate_column` VALUES (350, 12, 'sort', '排序', 'int', 0, 0, 1, 1, 1, 1, '=', 'input', '', 1763292652, 1763292652);

-- ----------------------------
-- Table structure for la_generate_table
-- ----------------------------
DROP TABLE IF EXISTS `la_generate_table`;
CREATE TABLE `la_generate_table`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '表描述',
  `template_type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '模板类型 0-单表(curd) 1-树表(curd)',
  `author` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '作者',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `generate_type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '生成方式  0-压缩包下载 1-生成到模块',
  `module_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块名',
  `class_dir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '类目录名',
  `class_comment` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '类描述',
  `admin_id` int(11) NULL DEFAULT 0 COMMENT '管理员id',
  `menu` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '菜单配置',
  `delete` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '删除配置',
  `tree` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '树表配置',
  `relations` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '关联配置',
  `create_time` int(10) NOT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成表信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_generate_table
-- ----------------------------
INSERT INTO `la_generate_table` VALUES (1, 'la_haosns_circle', '圈子', 0, '', '', 0, 'adminapi', '', '', 1, '{\"pid\":0,\"type\":0,\"name\":\"\\u5708\\u5b50\"}', '{\"type\":0,\"name\":\"delete_time\"}', '{\"tree_id\":\"\",\"tree_pid\":\"\",\"tree_name\":\"\"}', '[]', 1762841849, 1762842247);
INSERT INTO `la_generate_table` VALUES (2, 'la_haosns_article_comment', '帖子评论表', 0, '', '', 0, 'adminapi', '', '', 1, '{\"pid\":0,\"type\":0,\"name\":\"\\u5e16\\u5b50\\u8bc4\\u8bba\\u8868\"}', '{\"type\":0,\"name\":\"delete_time\"}', '{\"tree_id\":\"\",\"tree_pid\":\"\",\"tree_name\":\"\"}', '[]', 1762841849, 1762842209);
INSERT INTO `la_generate_table` VALUES (3, 'la_haosns_article', '帖子表', 0, '', '', 0, 'adminapi', '', '', 1, '{\"pid\":0,\"type\":0,\"name\":\"\\u5e16\\u5b50\\u8868\"}', '{\"type\":0,\"name\":\"delete_time\"}', '{\"tree_id\":\"\",\"tree_pid\":\"\",\"tree_name\":\"\"}', '[]', 1762841849, 1762842184);
INSERT INTO `la_generate_table` VALUES (4, 'la_haosns_user', '用户表', 0, '', '', 0, 'adminapi', '', '', 1, '{\"pid\":0,\"type\":0,\"name\":\"\\u7528\\u6237\\u8868\"}', '{\"type\":0,\"name\":\"delete_time\"}', '{\"tree_id\":\"\",\"tree_pid\":\"\",\"tree_name\":\"\"}', '[]', 1762841894, 1762842348);
INSERT INTO `la_generate_table` VALUES (5, 'la_haosns_circle_cate', '圈子分类表', 0, '', '', 0, 'adminapi', '', '', 2, '{\"pid\":0,\"type\":0,\"name\":\"\\u5708\\u5b50\\u5206\\u7c7b\\u8868\"}', '{\"type\":0,\"name\":\"delete_time\"}', '{\"tree_id\":\"\",\"tree_pid\":\"\",\"tree_name\":\"\"}', '[]', 1762864340, 1762864436);
INSERT INTO `la_generate_table` VALUES (6, 'la_haosns_banner', '轮播图表', 0, '', '', 0, 'adminapi', '', '', 2, '{\"pid\":0,\"type\":0,\"name\":\"\\u8f6e\\u64ad\\u56fe\\u8868\"}', '{\"type\":0,\"name\":\"delete_time\"}', '[]', '[]', 1762925832, 1762925832);
INSERT INTO `la_generate_table` VALUES (7, 'la_haosns_nav', '导航栏表', 0, '', '', 0, 'adminapi', '', '', 2, '{\"pid\":0,\"type\":0,\"name\":\"\\u5bfc\\u822a\\u680f\\u8868\"}', '{\"type\":0,\"name\":\"delete_time\"}', '{\"tree_id\":\"\",\"tree_pid\":\"\",\"tree_name\":\"\"}', '[]', 1762925904, 1762925935);
INSERT INTO `la_generate_table` VALUES (8, 'la_haosns_topic', '话题表', 0, '', '', 0, 'adminapi', '', '', 1, '{\"pid\":0,\"type\":0,\"name\":\"\\u8bdd\\u9898\\u8868\"}', '{\"type\":0,\"name\":\"delete_time\"}', '{\"tree_id\":\"\",\"tree_pid\":\"\",\"tree_name\":\"\"}', '[]', 1763186137, 1763186167);
INSERT INTO `la_generate_table` VALUES (9, 'la_haosns_topic_article', '话题帖子关联表', 0, '', '', 0, 'adminapi', '', '', 1, '{\"pid\":0,\"type\":0,\"name\":\"\\u8bdd\\u9898\\u5e16\\u5b50\\u5173\\u8054\\u8868\"}', '{\"type\":0,\"name\":\"delete_time\"}', '{\"tree_id\":\"\",\"tree_pid\":\"\",\"tree_name\":\"\"}', '[]', 1763186137, 1763186172);
INSERT INTO `la_generate_table` VALUES (10, 'la_haosns_circle_sub_category', '圈子子分类表', 0, '', '', 0, 'adminapi', '', '', 2, '{\"pid\":0,\"type\":0,\"name\":\"\\u5708\\u5b50\\u5b50\\u5206\\u7c7b\\u8868\"}', '{\"type\":0,\"name\":\"delete_time\"}', '{\"tree_id\":\"\",\"tree_pid\":\"\",\"tree_name\":\"\"}', '[]', 1763206319, 1763206340);
INSERT INTO `la_generate_table` VALUES (11, 'la_haosns_emo_category', '表情分类表', 0, '', '', 0, 'adminapi', '', '', 1, '{\"pid\":0,\"type\":0,\"name\":\"\\u8868\\u60c5\\u5206\\u7c7b\\u8868\"}', '{\"type\":0,\"name\":\"delete_time\"}', '{\"tree_id\":\"\",\"tree_pid\":\"\",\"tree_name\":\"\"}', '[]', 1763292652, 1763292660);
INSERT INTO `la_generate_table` VALUES (12, 'la_haosns_emo_image', '自定义表情图片', 0, '', '', 0, 'adminapi', '', '', 1, '{\"pid\":0,\"type\":0,\"name\":\"\\u81ea\\u5b9a\\u4e49\\u8868\\u60c5\\u56fe\\u7247\"}', '{\"type\":0,\"name\":\"delete_time\"}', '[]', '[]', 1763292652, 1763292652);

-- ----------------------------
-- Table structure for la_haosns_article
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_article`;
CREATE TABLE `la_haosns_article`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(11) NOT NULL DEFAULT 0 COMMENT '用户Id',
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '帖子类型 1文章 2视频',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '封面图,多个图片逗号分隔',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '文章内容',
  `visit` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '浏览人数',
  `sort` int(11) UNSIGNED NOT NULL DEFAULT 50 COMMENT '排序',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '审核状态  0-待审核 1-显示  2驳回  ',
  `is_top` tinyint(1) NOT NULL DEFAULT 0 COMMENT '置顶  1是 0否',
  `is_recomment` tinyint(1) NOT NULL DEFAULT 0 COMMENT '推荐  1是 0否',
  `region` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '地区',
  `video` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '视频',
  `video_cover` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '视频封面',
  `pay_money` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '支付金额，有支付金额为付费帖',
  `topic_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '#所属话题，多个逗号分隔',
  `circle_id` int(11) NULL DEFAULT 0 COMMENT '所属圈子',
  `user_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '@用户信息，多个逗号分隔',
  `is_open` tinyint(1) NULL DEFAULT 1 COMMENT '是否公开  1公开 2不公开',
  `create_time` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  `goods_id` int(11) NULL DEFAULT NULL COMMENT '商品ID',
  `vip_level_id` int(11) NULL DEFAULT NULL COMMENT 'null=无需vip,vip_id=阅读需要某个vip身份',
  `field_values` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '搜索字段内容',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip地址',
  `ip_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip解析后的地址名',
  `is_show` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否显示',
  `release_pay` tinyint(1) NOT NULL DEFAULT 0 COMMENT '发布付费:1=已支付,0=未支付,2=无需支付',
  `examine_result` tinyint(1) NULL DEFAULT NULL COMMENT '审核结果：0（审核正常），1 （判定为违规敏感文件），2（疑似敏感，建议人工复核）',
  `examine_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核平台的任务id',
  `examine_label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核标签',
  `examine_msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核内容提示',
  `free_image_count` int(2) NOT NULL DEFAULT 0 COMMENT '免费预览图片个数',
  `free_vip` tinyint(1) NOT NULL DEFAULT 0 COMMENT '允许会员免费',
  `free_word_count` int(11) NOT NULL DEFAULT 0 COMMENT '免费预览文本字数',
  `free_video_time` int(11) NOT NULL DEFAULT 0 COMMENT '免费试看多少秒',
  `file` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '附件',
  `cloud_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '网盘链接',
  `cloud_password` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '网盘密码',
  `polish_time` int(11) NOT NULL DEFAULT 0 COMMENT '擦亮时间',
  `only_look_user_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '仅哪些用户可见',
  `disable_look_user_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '不给哪些用户看',
  `only_look_user_level` int(11) NOT NULL DEFAULT 0 COMMENT '仅用户达到多少级后可见',
  `only_look_follow` tinyint(1) NULL DEFAULT NULL COMMENT '仅关注可见',
  `sub_category_id` int(11) NULL DEFAULT NULL COMMENT '圈子下的子分类',
  `title_pinyin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `content_pinyin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `reply_visible_content` text CHARACTER SET utf16le COLLATE utf16le_general_ci NULL COMMENT '回复可见指定内容',
  `mp3` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `chat_group_id` int(11) NULL DEFAULT NULL,
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市区',
  `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省',
  `area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区/详细地址',
  `city_json` json NULL,
  `longitude` int(11) NULL DEFAULT NULL COMMENT '经度',
  `latitude` int(11) NULL DEFAULT NULL COMMENT '纬度',
  `label` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `terminal` int(1) NOT NULL DEFAULT 0 COMMENT '0=未知,1-微信小程序；2-微信公众号；3-手机H5；4-电脑PC；5-苹果APP；6-安卓APP\'',
  `reply_only_visible_author` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论仅作者可见',
  `share_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '分享次数',
  `region_ids` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地区库id以‘,’分割如:,1,2,',
  `contact_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系手机号',
  `contact_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `contact_wechat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系微信号',
  `dz_id` int(11) NULL DEFAULT NULL,
  `vars` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_haosns_article_dz_id`(`dz_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '帖子表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_article
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_article_comment
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_article_comment`;
CREATE TABLE `la_haosns_article_comment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `aid` int(128) NOT NULL COMMENT '帖子id',
  `pid` int(128) NOT NULL COMMENT '评论id 0评论帖子; 评论id = 子评论',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '评论文本',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '评论内容带格式',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '审核状态 0-待审核 1-审核通过 2-审核拒绝 ',
  `topic_id` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '#话题 id,多个话题逗号分隔',
  `msg_user_ids` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '@用户id,多个用户逗号分隔',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  `ip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ip_address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip解析后的地址名',
  `star_num` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞数',
  `goods_id` int(11) NULL DEFAULT NULL COMMENT '自营商城商品',
  `reply_user_id` int(11) NULL DEFAULT NULL,
  `floor` int(11) NULL DEFAULT NULL,
  `is_pin` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `is_author_star` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '作者赞过',
  `dz_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_haosns_article_comment_dz_id`(`dz_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '帖子评论表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_article_comment
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_article_draft
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_article_draft`;
CREATE TABLE `la_haosns_article_draft`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(11) NOT NULL DEFAULT 0 COMMENT '用户Id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '封面图,多个图片逗号分隔',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '文章内容',
  `circle_id` int(11) NOT NULL DEFAULT 0 COMMENT '圈子id',
  `region` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '地区',
  `create_time` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '帖子草稿表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_article_draft
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_article_dun
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_article_dun`;
CREATE TABLE `la_haosns_article_dun`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_article_dun
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_article_field
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_article_field`;
CREATE TABLE `la_haosns_article_field`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `article_id` int(11) NOT NULL COMMENT '文章id',
  `field_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字段id',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `article_id`(`article_id`, `field_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_article_field
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_article_order
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_article_order`;
CREATE TABLE `la_haosns_article_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sn` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `transaction_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第三方平台交易流水号',
  `terminal` tinyint(1) NULL DEFAULT 1 COMMENT '终端',
  `pay_way` tinyint(2) NOT NULL DEFAULT 1 COMMENT '支付方式',
  `pay_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '支付状态：0-待支付；1-已支付',
  `pay_time` int(10) NULL DEFAULT NULL COMMENT '支付时间',
  `article_id` int(11) NULL DEFAULT 0 COMMENT '帖子id',
  `order_amount` decimal(10, 2) NOT NULL COMMENT '支付金额',
  `create_time` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  `sell_user_id` int(11) NULL DEFAULT NULL COMMENT '卖家用户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '帖子付费订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_article_order
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_article_rand_image
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_article_rand_image`;
CREATE TABLE `la_haosns_article_rand_image`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章随机图片' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_article_rand_image
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_article_reward_order
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_article_reward_order`;
CREATE TABLE `la_haosns_article_reward_order`  (
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL COMMENT '打赏的文章id',
  `sn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单号',
  `pay_status` int(2) NOT NULL DEFAULT 0 COMMENT '支付状态:1=已支付,0=未支付',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `order_amount` decimal(10, 2) NOT NULL COMMENT '订单金额',
  `delete_time` datetime NULL DEFAULT NULL,
  `order_status` int(11) NOT NULL DEFAULT 0 COMMENT '订单状态;0-待付款;1-待发货;2-待收货;3-已完成;4-已关闭',
  `pay_time` int(11) NULL DEFAULT NULL,
  `message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_article_reward_order
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_article_share_log
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_article_share_log`;
CREATE TABLE `la_haosns_article_share_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `article_id` int(11) UNSIGNED NOT NULL COMMENT '文章ID',
  `user_id` int(11) UNSIGNED NOT NULL COMMENT '访问用户id,0=游客',
  `from_user_id` int(11) UNSIGNED NOT NULL COMMENT '来自哪个用户分享',
  `create_time` int(11) UNSIGNED NOT NULL COMMENT '创建时间',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问则ip',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '分享访问日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_article_share_log
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_article_visit
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_article_visit`;
CREATE TABLE `la_haosns_article_visit`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `aid` int(11) NOT NULL COMMENT '帖子id',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ip地址',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `visit` int(11) NOT NULL COMMENT '浏览量',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 229 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '帖子浏览记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_article_visit
-- ----------------------------
INSERT INTO `la_haosns_article_visit` VALUES (228, 56, '182.107.140.197', 0, 2, 1764570865, 1764570980, NULL);

-- ----------------------------
-- Table structure for la_haosns_banner
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_banner`;
CREATE TABLE `la_haosns_banner`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '轮播图ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '轮播图标题',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '图片URL',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述文字',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序权重(数字越大越靠前)',
  `jump_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '_self' COMMENT 'web=跳转网页,app=app内跳转',
  `jump_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '跳转路径url',
  `jump_params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '跳转携带的参数',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态(0禁用,1启用)',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'index' COMMENT '位置:index=首页,goods=自营商城,twoshop=二手商城',
  `bg_color` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '背景颜色亿,分割',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '轮播图表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_banner
-- ----------------------------
INSERT INTO `la_haosns_banner` VALUES (1, '广告', 'https://mp.haosns.com/uploads/images/20251112/202511121409101d3fd5650.jpg', 'Haosns广告', 0, 'web', 'index.html', '', 1, '2025-11-12 14:34:00', 'index', NULL);

-- ----------------------------
-- Table structure for la_haosns_chat_circle_message
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_chat_circle_message`;
CREATE TABLE `la_haosns_chat_circle_message`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `from_id` int(11) NOT NULL COMMENT '发送者',
  `circle_id` int(11) NULL DEFAULT NULL COMMENT '圈子id',
  `msg_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '消息内容类型（text/image/video/mp3/goods/article等）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '消息内容',
  `is_read` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0=未读,1=已读',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NULL DEFAULT NULL COMMENT '修改时间',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=正常,2=已撤回',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_chat_circle_message
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_chat_collect
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_chat_collect`;
CREATE TABLE `la_haosns_chat_collect`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `from_user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '来自哪个用户',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '所属用户ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '内容',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '类型',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态（0删除1正常2锁定）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `message_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '收藏内容' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_chat_collect
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_chat_group
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_chat_group`;
CREATE TABLE `la_haosns_chat_group`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '群名称',
  `create_by_user_id` int(11) NOT NULL COMMENT '创建者ID',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '群描述',
  `max_members` int(11) NOT NULL DEFAULT 200 COMMENT '最大群成员数',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态:1=正常,0=禁用',
  `price` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '进群价格',
  `category_id` int(11) NOT NULL COMMENT '群分类',
  `visit_level` tinyint(1) NOT NULL DEFAULT 0 COMMENT '访问权限,用户等级,0=所有用户',
  `longitude` int(10) NULL DEFAULT NULL COMMENT '经度',
  `latitude` int(10) NULL DEFAULT NULL COMMENT '纬度',
  `province` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '省份',
  `city` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '城市',
  `district` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区',
  `county` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '县',
  `area` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详细地址',
  `address` json NULL,
  `home_show` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '个人主页显示',
  `num` int(1) NOT NULL DEFAULT 0,
  `image` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `label_ids` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_chat_group
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_chat_group_member
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_chat_group_member`;
CREATE TABLE `la_haosns_chat_group_member`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `group_id` int(11) UNSIGNED NOT NULL COMMENT '群组id',
  `user_id` int(11) UNSIGNED NOT NULL COMMENT '用户id',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态:1=正常,0=已退出',
  `muted_until` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '禁言时间',
  PRIMARY KEY (`id`, `group_id`, `user_id`) USING BTREE,
  UNIQUE INDEX `group_id_user_id`(`group_id`, `user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_chat_group_member
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_chat_group_message
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_chat_group_message`;
CREATE TABLE `la_haosns_chat_group_message`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `from_id` int(11) NOT NULL COMMENT '发送者',
  `group_id` int(11) NULL DEFAULT NULL COMMENT '群id',
  `msg_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '消息内容类型（text/image/video/mp3/goods/article等）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '消息内容',
  `is_read` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0=未读,1=已读',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NULL DEFAULT NULL COMMENT '修改时间',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=正常,0=已撤回',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_chat_group_message
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_chat_kefu_message
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_chat_kefu_message`;
CREATE TABLE `la_haosns_chat_kefu_message`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `from` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发送方:kefu=客服,user=用户',
  `kefu_id` int(11) NOT NULL COMMENT '客服id',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `msg_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '消息内容类型（text/image/video/mp3/goods/article等）',
  `msg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '消息内容',
  `is_read` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0=未读,1=已读',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NULL DEFAULT NULL COMMENT '修改时间',
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '1=正常,2=撤回',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_chat_kefu_message
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_chat_private_message
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_chat_private_message`;
CREATE TABLE `la_haosns_chat_private_message`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `from_id` int(11) NOT NULL COMMENT '发送者',
  `to_id` int(11) NULL DEFAULT NULL COMMENT '接收者',
  `msg_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '消息内容类型（text/image/video等）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '消息内容',
  `is_read` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0=未读,1=已读',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NULL DEFAULT NULL COMMENT '修改时间',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=正常,2=撤回',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_chat_private_message
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_chat_temp
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_chat_temp`;
CREATE TABLE `la_haosns_chat_temp`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '聊天类型:private_chat=私聊,group_chat=群聊,circle_chat=圈子聊天',
  `group_id` int(11) NULL DEFAULT 0 COMMENT '群id',
  `to_id` int(11) NULL DEFAULT 0 COMMENT '接收者的id',
  `create_time` datetime NULL DEFAULT NULL,
  `unread` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `goods_id` int(11) NULL DEFAULT NULL COMMENT '商品id',
  `circle_id` int(11) NULL DEFAULT NULL COMMENT '圈子id',
  `identity` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'user' COMMENT '身份:user=用户,kefu=客服',
  `update_time` datetime NULL DEFAULT NULL,
  `delete_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`, `group_id`, `to_id`, `identity`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_chat_temp
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_circle
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_circle`;
CREATE TABLE `la_haosns_circle`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '圈子id',
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '圈子名称',
  `synopsis` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '简介',
  `sort` int(10) UNSIGNED NOT NULL DEFAULT 50 COMMENT '排序',
  `is_show` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否显示 0-隐藏 1-显示',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图标',
  `pid` int(11) NULL DEFAULT 0 COMMENT '父级',
  `home_show` tinyint(1) NULL DEFAULT 0 COMMENT '是否首页显示 0-隐藏 1-显示',
  `create_time` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  `cate_id` int(10) NULL DEFAULT NULL COMMENT '分类ID',
  `subscription_price` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '订阅收费',
  `release_price` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '发帖收费',
  `vip_level_id` int(11) NOT NULL DEFAULT 0 COMMENT '有id=需要某个vip身份才才能访问',
  `template` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'circle' COMMENT '模板',
  `chat_status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=开启群聊,2=关闭群聊',
  `bg_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '圈子背景图',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '创建者用户id',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0=待审核,1=审核通过,2=拒审,3=已注销',
  `examine_msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核结果信息',
  `send_limit_day` int(11) NOT NULL DEFAULT 0 COMMENT '发布限制次数0代表无限制',
  `visit_level` int(11) NOT NULL DEFAULT 0 COMMENT '访问权限用户等级,0=无限制',
  `send_level` int(11) NOT NULL DEFAULT 0 COMMENT '发帖等级限制',
  `reply_level` int(11) NOT NULL DEFAULT 0 COMMENT '回帖等级限制',
  `disable_reply` tinyint(1) NOT NULL DEFAULT 0 COMMENT '禁止回复',
  `disbale_upload_image` tinyint(1) NOT NULL DEFAULT 0 COMMENT '禁止发表图片',
  `diable_upload_file` tinyint(1) NOT NULL DEFAULT 0 COMMENT '禁止上传附件',
  `notice` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '圈子公告',
  `label` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `is_pay` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否支付',
  `only_circle_send` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '只允许圈主发帖',
  `signal_get_experience` int(128) UNSIGNED NOT NULL DEFAULT 0 COMMENT '签到获得经验',
  `is_hot` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `is_recommend` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `edit_template` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'page',
  `latitude` int(11) NULL DEFAULT NULL,
  `longitude` int(11) NULL DEFAULT NULL,
  `dz_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `dz_id`(`dz_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '圈子' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_circle
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_circle_cate
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_circle_cate`;
CREATE TABLE `la_haosns_circle_cate`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sort` int(11) NOT NULL,
  `is_show` tinyint(4) NOT NULL,
  `pid` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `create_time` int(10) NULL DEFAULT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_circle_cate
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_circle_create_order
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_circle_create_order`;
CREATE TABLE `la_haosns_circle_create_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '支付方式,1=余额支付',
  `sn` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `transaction_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第三方平台交易流水号',
  `terminal` tinyint(1) NULL DEFAULT 1 COMMENT '终端',
  `pay_way` tinyint(2) NOT NULL DEFAULT 1 COMMENT '支付方式,1=余额支付,2=微信,3=支付宝',
  `pay_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '支付状态：0-待支付；1-已支付',
  `pay_time` int(10) NULL DEFAULT NULL COMMENT '支付时间',
  `circle_id` int(11) NULL DEFAULT 0 COMMENT '帖子id',
  `order_amount` decimal(10, 2) NOT NULL COMMENT '支付金额',
  `create_time` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '圈子创建订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_circle_create_order
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_circle_field
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_circle_field`;
CREATE TABLE `la_haosns_circle_field`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `circle_id` int(11) NOT NULL COMMENT '圈子ID',
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '键名',
  `placehold` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表单预设值',
  `unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '单位',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '键值',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置类型',
  `sort` int(10) NOT NULL DEFAULT 0 COMMENT '排序',
  `require` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否必选',
  `update` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否可修改',
  `search` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否可搜索',
  `price` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '价格',
  `max_font` int(11) NOT NULL DEFAULT 0 COMMENT '最大字数',
  `is_search` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否开启搜索',
  `sub_category_id` int(11) NOT NULL DEFAULT 0 COMMENT '圈子下的分类',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_circle_field
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_circle_level
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_circle_level`;
CREATE TABLE `la_haosns_circle_level`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '连续签到天数',
  `circle_id` bigint(20) NOT NULL COMMENT '圈子id',
  `level` int(11) NOT NULL COMMENT '等级',
  `user_id` int(11) NOT NULL,
  `experience` int(11) NOT NULL DEFAULT 0 COMMENT '经验',
  `color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `keep_day` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '连续签到天数',
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `update_time` int(11) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `circle_id`(`circle_id`, `user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '圈子等级关联记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_circle_level
-- ----------------------------
INSERT INTO `la_haosns_circle_level` VALUES (1, 1, 1, 1, 0, NULL, 0, 1762937757, 1762937757);
INSERT INTO `la_haosns_circle_level` VALUES (2, 1, 1, 5, 0, NULL, 0, 1763301285, 1763301285);
INSERT INTO `la_haosns_circle_level` VALUES (3, 1, 1, 22, 0, NULL, 0, 1763948451, 1763948451);

-- ----------------------------
-- Table structure for la_haosns_circle_logoff
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_circle_logoff`;
CREATE TABLE `la_haosns_circle_logoff`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `circle_id` int(11) NULL DEFAULT NULL COMMENT '父级地区ID，顶级地区为0或NULL',
  `msg` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '注销理由',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '0-待处理,1=已处理,2=拒绝',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '圈子注销申请记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_circle_logoff
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_circle_order
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_circle_order`;
CREATE TABLE `la_haosns_circle_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sn` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `transaction_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第三方平台交易流水号',
  `terminal` tinyint(1) NULL DEFAULT 1 COMMENT '终端',
  `pay_way` tinyint(2) NOT NULL DEFAULT 1 COMMENT '支付方式',
  `pay_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '支付状态：0-待支付；1-已支付',
  `pay_time` int(10) NULL DEFAULT NULL COMMENT '支付时间',
  `circle_id` int(11) NULL DEFAULT 0 COMMENT '圈子id',
  `order_amount` decimal(10, 2) NOT NULL COMMENT '支付金额',
  `create_time` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  `sell_user_id` int(11) NULL DEFAULT NULL COMMENT '卖家用户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '关注订阅圈子收费' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_circle_order
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_circle_release_order
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_circle_release_order`;
CREATE TABLE `la_haosns_circle_release_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sn` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `transaction_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第三方平台交易流水号',
  `terminal` tinyint(1) NULL DEFAULT 1 COMMENT '终端',
  `pay_way` tinyint(2) NOT NULL DEFAULT 1 COMMENT '支付方式',
  `pay_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '支付状态：0-待支付；1-已支付',
  `pay_time` int(10) NULL DEFAULT NULL COMMENT '支付时间',
  `article_id` int(11) NULL DEFAULT 0 COMMENT '帖子id',
  `order_amount` decimal(10, 2) NOT NULL COMMENT '支付金额',
  `create_time` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '圈子发帖付费' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_circle_release_order
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_circle_sign
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_circle_sign`;
CREATE TABLE `la_haosns_circle_sign`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '签到记录ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `circle_id` bigint(20) NOT NULL COMMENT '圈子id',
  `create_time` int(11) NOT NULL,
  `experience` int(11) NOT NULL COMMENT '获得经验',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '圈子签到表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_circle_sign
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_circle_sub_category
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_circle_sub_category`;
CREATE TABLE `la_haosns_circle_sub_category`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(90) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类名称',
  `pid` int(11) UNSIGNED NOT NULL COMMENT '父级id',
  `sort` int(5) UNSIGNED NULL DEFAULT 255 COMMENT '排序',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '状态:1=启用,0=禁用',
  `circle_id` int(11) NOT NULL COMMENT '圈子id',
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `edit_template` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '圈子子分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_circle_sub_category
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_circle_user_level
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_circle_user_level`;
CREATE TABLE `la_haosns_circle_user_level`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '等级名称',
  `rank` int(11) NOT NULL COMMENT '等级权重（1-为系统默认等级）',
  `image` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '等级描述',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  `experience` int(128) NOT NULL DEFAULT 10000 COMMENT '升级所需要的经验',
  `color` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '背景颜色',
  `circle_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户等级表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_circle_user_level
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_dev_notice_setting
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_dev_notice_setting`;
CREATE TABLE `la_haosns_dev_notice_setting`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `scene_id` int(10) NOT NULL COMMENT '场景id',
  `scene_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '场景名称',
  `scene_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '场景描述',
  `recipient` tinyint(1) NOT NULL DEFAULT 1 COMMENT '接收者 1-买家 2-卖家',
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '通知类型: 1-业务通知 2-验证码',
  `system_notice` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '系统通知设置',
  `sms_notice` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '短信通知设置',
  `oa_notice` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '公众号通知设置',
  `mnp_notice` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '小程序通知设置',
  `support` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '支持的发送类型 1-系统通知 2-短信通知 3-微信模板消息 4-小程序提醒',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知设置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_dev_notice_setting
-- ----------------------------
INSERT INTO `la_haosns_dev_notice_setting` VALUES (1, 100, '注册验证码', '用户注册时发送', 1, 2, '{\"type\":\"system\",\"title\":\"\",\"content\":\"\",\"status\":\"0\",\"tips\":[\"可选变量 验证码:code\"],\"is_show\":\"\"}', '{\"type\":\"sms\",\"template_id\":\"2497585\",\"content\":\"验证码为：{1}，您正在登录，若非本人操作，请勿泄露。\",\"status\":\"1\",\"tips\":[\"可选变量 验证码:code\",\"示例：您正在申请注册，验证码${code}，切勿将验证码泄露于他人，本条验证码有效期5分钟。\",\"生效条件：1、管理后台完成短信设置。2、第三方短信平台申请模板。\"],\"is_show\":\"1\"}', '{\"type\":\"oa\",\"template_id\":\"\",\"template_sn\":\"\",\"name\":\"\",\"first\":\"\",\"remark\":\"\",\"tpl\":[],\"status\":\"0\",\"tips\":[\"可选变量 验证码:code\",\"配置路径：小程序后台 > 功能 > 订阅消息\"],\"is_show\":\"\"}', '{\"type\":\"mnp\",\"template_id\":\"\",\"template_sn\":\"\",\"name\":\"\",\"tpl\":[],\"status\":\"0\",\"tips\":[\"可选变量 验证码:code\",\"配置路径：小程序后台 > 功能 > 订阅消息\"],\"is_show\":\"\"}', '2', NULL);
INSERT INTO `la_haosns_dev_notice_setting` VALUES (2, 101, '登录验证码', '用户手机号码登录时发送', 1, 2, '{\"type\":\"system\",\"title\":\"\",\"content\":\"\",\"status\":\"0\",\"tips\":[\"可选变量 验证码:code\"],\"is_show\":\"\"}', '{\"type\":\"sms\",\"template_id\":\"2497585\",\"content\":\"验证码为：${code}，您正在登录，若非本人操作，请勿泄露。\",\"status\":\"1\",\"tips\":[\"可选变量 验证码:code\",\"示例：您正在登录，验证码${code}，切勿将验证码泄露于他人，本条验证码有效期5分钟。\",\"生效条件：1、管理后台完成短信设置。2、第三方短信平台申请模板。\"],\"is_show\":\"1\"}', '{\"type\":\"oa\",\"template_id\":\"\",\"template_sn\":\"\",\"name\":\"\",\"first\":\"\",\"remark\":\"\",\"tpl\":[],\"status\":\"0\",\"tips\":[\"可选变量 验证码:code\",\"配置路径：小程序后台 > 功能 > 订阅消息\"],\"is_show\":\"\"}', '{\"type\":\"mnp\",\"template_id\":\"\",\"template_sn\":\"\",\"name\":\"\",\"tpl\":[],\"status\":\"0\",\"tips\":[\"可选变量 验证码:code\",\"配置路径：小程序后台 > 功能 > 订阅消息\"],\"is_show\":\"\"}', '2', NULL);
INSERT INTO `la_haosns_dev_notice_setting` VALUES (3, 102, '绑定手机验证码', '用户绑定手机号码时发送', 1, 2, '{\"type\":\"system\",\"title\":\"\",\"content\":\"\",\"status\":\"0\",\"tips\":[\"可选变量 验证码:code\"],\"is_show\":\"\"}', '{\"type\":\"sms\",\"template_id\":\"SMS_122095016\",\"content\":\"你的验证码是${code}，请在10分钟内输入。\",\"status\":\"1\",\"tips\":[\"可选变量 验证码:code\",\"示例：您正在绑定手机号，验证码${code}，切勿将验证码泄露于他人，本条验证码有效期5分钟。\",\"生效条件：1、管理后台完成短信设置。2、第三方短信平台申请模板。\"],\"is_show\":\"1\"}', '', '', '2', NULL);
INSERT INTO `la_haosns_dev_notice_setting` VALUES (4, 103, '变更手机验证码', '用户变更手机号码时发送', 1, 2, '{\"type\":\"system\",\"title\":\"\",\"content\":\"\",\"status\":\"0\",\"tips\":[\"可选变量 验证码:code\"],\"is_show\":\"\"}', '{\"type\":\"sms\",\"template_id\":\"\",\"content\":\"\",\"status\":\"1\",\"tips\":[\"可选变量 验证码:code\",\"示例：您正在变更手机号，验证码${code}，切勿将验证码泄露于他人，本条验证码有效期5分钟。\",\"生效条件：1、管理后台完成短信设置。2、第三方短信平台申请模板。\"],\"is_show\":\"1\"}', '', '', '2', NULL);
INSERT INTO `la_haosns_dev_notice_setting` VALUES (5, 104, '找回登录密码验证码', '用户找回登录密码号码时发送', 1, 2, '{\"type\":\"system\",\"title\":\"\",\"content\":\"\",\"status\":\"0\",\"tips\":[\"可选变量 验证码:code\"],\"is_show\":\"\"}', '{\"type\":\"sms\",\"template_id\":\"\",\"content\":\"\",\"status\":\"1\",\"tips\":[\"可选变量 验证码:code\",\"示例：您正在找回登录密码，验证码${code}，切勿将验证码泄露于他人，本条验证码有效期5分钟。\",\"生效条件：1、管理后台完成短信设置。2、第三方短信平台申请模板。\"],\"is_show\":\"1\"}', '', '', '2', NULL);
INSERT INTO `la_haosns_dev_notice_setting` VALUES (6, 105, '找回支付密码验证码', '用户找回支付密码时发送', 1, 2, '', '', '', '', '2', NULL);
INSERT INTO `la_haosns_dev_notice_setting` VALUES (7, 106, '订单付款通知', '订单付款成功时通知买家', 1, 1, '{\"type\":\"system\",\"title\":\"订单付款通知\",\"content\":\"亲爱的{nickname}，您的订单 {order_sn}已支付成功，商家正在快马加鞭为您安排发货。\",\"status\":\"1\",\"tips\":[\"可选变量 用户昵称:nickname 订单编号:order_sn 支付时间:pay_time\",\"亲爱的{nickname}，您的订单 {order_sn}已支付成功，商家正在快马加鞭为您安排发货。\"],\"is_show\":\"1\"}', '{\"type\":\"sms\",\"template_id\":\"\",\"content\":\"\",\"status\":\"0\",\"tips\":[\"可选变量 用户昵称:nickname 订单编号:order_sn 支付时间:pay_time\",\"示例：亲爱的${nickname}，您的订单${order_sn}已支付成功，商家正在快马加鞭为您安排发货。\",\"生效条件：1、管理后台完成短信设置。2、第三方短信平台申请模板。\"],\"is_show\":\"1\"}', '{\"type\":\"oa\",\"template_id\":\"\",\"template_sn\":\"\",\"name\":\"\",\"first\":\"\",\"remark\":\"\",\"tpl\":[],\"status\":\"0\",\"tips\":[\"可选变量 用户昵称:nickname 订单编号:order_sn 支付时间:pay_time\",\"模板库: 搜索 “订单支付成功通知”，选用类目：软件服务提供商的模板，选用并选择以下参数，提交获得模板ID。\",\"字段名 字段值 字段内容\",\"订单编号 character_string1 {order_sn}\",\"支付时间 time2 {pay_time}\",\"订单金额 amount3 {order_amount}\",\"商品名称 thing4 {goods_name}\",\"配置路径：小程序后台 > 功能 > 订阅消息\"],\"is_show\":\"1\"}', '{\"type\":\"mnp\",\"template_id\":\"\",\"template_sn\":\"\",\"name\":\"\",\"tpl\":[],\"status\":\"0\",\"tips\":[\"可选变量 用户昵称:nickname 订单编号:order_sn 支付时间:pay_time\",\"模板库: 搜索 “订单支付成功通知”，选用类目：软件服务提供商的模板，选用并选择以下参数，提交获得模板ID。\",\"字段名 字段值 字段内容\",\"订单编号 character_string1 {order_sn}\",\"支付时间 time2 {pay_time}\",\"订单金额 amount3 {order_amount}\",\"商品名称 thing4 {goods_name}\",\"配置路径：小程序后台 > 功能 > 订阅消息\"],\"is_show\":\"1\"}', '1,2,3,4', NULL);
INSERT INTO `la_haosns_dev_notice_setting` VALUES (8, 107, '订单发货通知', '卖家发货时通知买家', 1, 1, '{\"type\":\"system\",\"title\":\"您的订单已发货\",\"content\":\"亲爱的{nickname}、您的订单{order_sn}已发货!\",\"status\":\"1\",\"tips\":[\"可选变量 用户昵称:nickname 订单编号:order_sn 快递名称:express_name 物流单号:invoice_no\",\"亲爱的{nickname}、您的订单{order_sn}已发货，{express_name}单号{invoice_no}，请保持收件手机畅通!。\"],\"is_show\":\"1\"}', '{\"type\":\"sms\",\"template_id\":\"\",\"content\":\"\",\"status\":\"0\",\"tips\":[\"可选变量 用户昵称:nickname 订单编号:order_sn 快递名称:express_name 物流单号:invoice_no\",\"示例：亲爱的${nickname}、您的订单${order_sn}已发货，${express_name}单号${invoice_no}，请保持收件手机畅通。\",\"生效条件：1、管理后台完成短信设置。2、第三方短信平台申请模板。\"],\"is_show\":\"1\"}', '{\"type\":\"oa\",\"template_id\":\"\",\"template_sn\":\"\",\"name\":\"\",\"first\":\"\",\"remark\":\"\",\"tpl\":[],\"status\":\"0\",\"tips\":[\"可选变量 用户昵称:nickname 订单编号:order_sn 快递名称:express_name 物流单号:invoice_no\",\"模板库: 搜索 “订单发货通知”，选用类目：软件服务提供商的模板，选用并选择以下参数，提交获得模板ID。\",\"字段名 字段值 字段内容\",\"商品名称 thing1 {goods_name}\",\"订单号 character_string2 {order_sn}\",\"发货时间 date3 {ship_time}\",\"快递公司 thing4 {express_name}\",\"快递单号 character_string5 {invoice_no}\",\"配置路径：小程序后台 > 功能 > 订阅消息\"],\"is_show\":\"1\"}', '{\"type\":\"mnp\",\"template_id\":\"\",\"template_sn\":\"\",\"name\":\"\",\"tpl\":[],\"status\":\"0\",\"tips\":[\"可选变量 用户昵称:nickname 订单编号:order_sn 快递名称:express_name 物流单号:invoice_no\",\"模板库: 搜索 “订单发货通知”，选用类目：软件服务提供商的模板，选用并选择以下参数，提交获得模板ID。\",\"字段名 字段值 字段内容\",\"商品名称 thing1 {goods_name}\",\"订单号 character_string2 {order_sn}\",\"发货时间 date3 {ship_time}\",\"快递公司 thing4 {express_name}\",\"快递单号 character_string5 {invoice_no}\",\"配置路径：小程序后台 > 功能 > 订阅消息\"],\"is_show\":\"1\"}', '1,2,3,4', NULL);
INSERT INTO `la_haosns_dev_notice_setting` VALUES (9, 108, '售后退款拒绝通知', '卖家拒绝售后退款时通知买家', 1, 1, '{\"type\":\"system\",\"title\":\"\",\"content\":\"\",\"status\":\"1\",\"tips\":[\"可选变量 用户昵称:nickname 售后单号:after_sale_sn\",\"亲爱的{nickname}，您的售后申请{after_sale_sn}已被卖家拒绝。\"],\"is_show\":\"1\"}', '{\"type\":\"sms\",\"template_id\":\"\",\"content\":\"\",\"status\":\"0\",\"tips\":[\"可选变量 用户昵称:nickname 售后单号:after_sale_sn\",\"示例：亲爱的${nickname}，您的售后申请${after_sale_sn}已被卖家拒绝。\",\"生效条件：1、管理后台完成短信设置。2、第三方短信平台申请模板。\"],\"is_show\":\"1\"}', '', '', '1,2,3,4', NULL);
INSERT INTO `la_haosns_dev_notice_setting` VALUES (15, 109, '售后退款成功通知', '售后退款金额到账时通知买家', 1, 1, '{\"type\":\"system\",\"title\":\"\",\"content\":\"\",\"status\":\"1\",\"tips\":[\"可选变量 用户昵称:nickname 售后单号:after_sale_sn 退款金额:refund_amount\",\"亲爱的{nickname}，您的售后申请{after_sale_sn}已成功退款。\"],\"is_show\":\"1\"}', '{\"type\":\"sms\",\"template_id\":\"\",\"content\":\"\",\"status\":\"0\",\"tips\":[\"可选变量 用户昵称:nickname 售后单号:after_sale_sn 退款金额:refund_amount\",\"示例：亲爱的${nickname}，您的售后申请${after_sale_sn}已成功退款。\",\"生效条件：1、管理后台完成短信设置。2、第三方短信平台申请模板。\"],\"is_show\":\"1\"}', '', '', '1,2,3,4', NULL);
INSERT INTO `la_haosns_dev_notice_setting` VALUES (17, 200, '订单付款通知', '买家订单付款成功时通知卖家', 2, 1, '{\"type\":\"system\",\"title\":\"\",\"content\":\"\",\"status\":\"0\",\"tips\":[\"可选变量 订单编号:order_sn\"],\"is_show\":\"\"}', '{\"type\":\"sms\",\"template_id\":\"\",\"content\":\"\",\"status\":\"0\",\"tips\":[\"可选变量 订单编号:order_sn\",\"示例：亲爱的卖家，您有新的付款订单，订单编号${order_sn}，请及时处理。\",\"生效条件：1、管理后台完成短信设置。2、第三方短信平台申请模板。\"],\"is_show\":\"1\"}', '', '', '2', NULL);
INSERT INTO `la_haosns_dev_notice_setting` VALUES (18, 201, '售后退款申请通知', '买家发起售后退款申请时通知卖家', 2, 1, NULL, NULL, NULL, NULL, '2', NULL);
INSERT INTO `la_haosns_dev_notice_setting` VALUES (19, 202, '关注通知', '用户关注时发送', 1, 1, '{\"type\":\"system\",\"title\":\"关注通知\",\"content\":\"{fans_name}关注了您。\",\"status\":\"1\",\"tips\":[],\"is_show\":\"1\"}', '{\"type\":\"sms\",\"template_id\":\"\",\"content\":\"\",\"status\":\"0\",\"tips\":[\"生效条件：1、管理后台完成短信设置。2、第三方短信平台申请模板。\"],\"is_show\":\"\"}', '{\"type\":\"oa\",\"template_id\":\"\",\"template_sn\":\"\",\"name\":\"\",\"first\":\"\",\"remark\":\"\",\"tpl\":[],\"status\":\"0\",\"tips\":[\"配置路径：小程序后台 > 功能 > 订阅消息\"],\"is_show\":\"\"}', '{\"type\":\"mnp\",\"template_id\":\"\",\"template_sn\":\"\",\"name\":\"\",\"tpl\":[],\"status\":\"0\",\"tips\":[\"配置路径：小程序后台 > 功能 > 订阅消息\"],\"is_show\":\"\"}', '1', NULL);
INSERT INTO `la_haosns_dev_notice_setting` VALUES (20, 203, '帖子评论通知', '用户评论帖子时发送', 1, 1, '{\"type\":\"system\",\"title\":\"帖子评论通知\",\"content\":\"{fans_name}评论了您的帖子。\",\"status\":\"1\",\"tips\":[],\"is_show\":\"1\"}', '{\"type\":\"sms\",\"template_id\":\"\",\"content\":\"\",\"status\":\"0\",\"tips\":[\"生效条件：1、管理后台完成短信设置。2、第三方短信平台申请模板。\"],\"is_show\":\"\"}', '{\"type\":\"oa\",\"template_id\":\"\",\"template_sn\":\"\",\"name\":\"\",\"first\":\"\",\"remark\":\"\",\"tpl\":[],\"status\":\"0\",\"tips\":[\"配置路径：小程序后台 > 功能 > 订阅消息\"],\"is_show\":\"\"}', '{\"type\":\"mnp\",\"template_id\":\"\",\"template_sn\":\"\",\"name\":\"\",\"tpl\":[],\"status\":\"0\",\"tips\":[\"配置路径：小程序后台 > 功能 > 订阅消息\"],\"is_show\":\"\"}', '1', NULL);
INSERT INTO `la_haosns_dev_notice_setting` VALUES (21, 204, '点赞收藏通知', '用户点赞收藏帖子时发送', 1, 1, '{\"type\":\"system\",\"title\":\"点赞收藏通知\",\"content\":\"{fans_name}点赞收藏了我的帖子。\",\"status\":\"1\",\"tips\":[],\"is_show\":\"1\"}', '{\"type\":\"sms\",\"template_id\":\"\",\"content\":\"\",\"status\":\"0\",\"tips\":[\"生效条件：1、管理后台完成短信设置。2、第三方短信平台申请模板。\"],\"is_show\":\"\"}', '{\"type\":\"oa\",\"template_id\":\"\",\"template_sn\":\"\",\"name\":\"\",\"first\":\"\",\"remark\":\"\",\"tpl\":[],\"status\":\"0\",\"tips\":[\"配置路径：小程序后台 > 功能 > 订阅消息\"],\"is_show\":\"\"}', '{\"type\":\"mnp\",\"template_id\":\"\",\"template_sn\":\"\",\"name\":\"\",\"tpl\":[],\"status\":\"0\",\"tips\":[\"配置路径：小程序后台 > 功能 > 订阅消息\"],\"is_show\":\"\"}', '1', NULL);
INSERT INTO `la_haosns_dev_notice_setting` VALUES (22, 205, '帖子审核结果通知', '后台审核帖子结果时发送', 1, 1, '{\"type\":\"system\",\"title\":\"帖子评论通知\",\"content\":\"审核结果\",\"status\":\"1\",\"tips\":[],\"is_show\":\"1\"}', '{\"type\":\"sms\",\"template_id\":\"\",\"content\":\"\",\"status\":\"0\",\"tips\":[\"生效条件：1、管理后台完成短信设置。2、第三方短信平台申请模板。\"],\"is_show\":\"\"}', '{\"type\":\"oa\",\"template_id\":\"\",\"template_sn\":\"\",\"name\":\"\",\"first\":\"\",\"remark\":\"\",\"tpl\":[],\"status\":\"0\",\"tips\":[\"配置路径：小程序后台 > 功能 > 订阅消息\"],\"is_show\":\"\"}', '{\"type\":\"mnp\",\"template_id\":\"\",\"template_sn\":\"\",\"name\":\"\",\"tpl\":[],\"status\":\"0\",\"tips\":[\"配置路径：小程序后台 > 功能 > 订阅消息\"],\"is_show\":\"\"}', '1', NULL);
INSERT INTO `la_haosns_dev_notice_setting` VALUES (23, 301, '发信息预留手机号验证码', '发信息预留手机号验证码', 1, 2, '{\"type\":\"system\",\"title\":\"\",\"content\":\"\",\"status\":\"0\",\"tips\":[],\"is_show\":\"\"}', '{\"type\":\"sms\",\"template_id\":\"SMS_122095016\",\"content\":\"你的验证码是${code}，请在10分钟内输入。\",\"status\":\"1\",\"tips\":[\"生效条件：1、管理后台完成短信设置。2、第三方短信平台申请模板。\"],\"is_show\":\"1\"}', '', '', '2', NULL);

-- ----------------------------
-- Table structure for la_haosns_dev_region
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_dev_region`;
CREATE TABLE `la_haosns_dev_region`  (
  `id` int(10) NOT NULL DEFAULT 0 COMMENT '地区编号',
  `parent_id` int(10) NOT NULL DEFAULT 0 COMMENT '父级地区编码',
  `level` tinyint(1) NOT NULL DEFAULT 0 COMMENT '等级 0-国家；1-省份；2-地级市；3-县区',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `short` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '简称',
  `city_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地区编码',
  `zip_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮政编码',
  `gcj02_lng` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '纬度',
  `gcj02_lat` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '经度',
  `db09_lng` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '纬度',
  `db09_lat` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '经度',
  `remark1` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注一',
  `remark2` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注二',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '地区表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_dev_region
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_emo_category
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_emo_category`;
CREATE TABLE `la_haosns_emo_category`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(90) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类名称',
  `sort` int(5) UNSIGNED NULL DEFAULT 255 COMMENT '排序',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '状态:1=启用,0=禁用',
  `image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '表情分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_emo_category
-- ----------------------------
INSERT INTO `la_haosns_emo_category` VALUES (1, '测试', 1, 1, 'uploads/images/20251117/2025111708360056c700044.png');

-- ----------------------------
-- Table structure for la_haosns_emo_image
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_emo_image`;
CREATE TABLE `la_haosns_emo_image`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id',
  `category_id` int(11) UNSIGNED NULL DEFAULT 255 COMMENT '分类id',
  `user_id` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '用户id用户自定义表情',
  `image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类图标',
  `sort` int(11) UNSIGNED NULL DEFAULT 255 COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '自定义表情图片' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_emo_image
-- ----------------------------
INSERT INTO `la_haosns_emo_image` VALUES (9, 1, NULL, 'https://mp.haosns.com/uploads/images/20251117/2025111708360056c700044.png', 0);
INSERT INTO `la_haosns_emo_image` VALUES (10, 1, NULL, 'https://mp.haosns.com/uploads/images/20251116/2025111618281525eef8660.jpeg', 0);
INSERT INTO `la_haosns_emo_image` VALUES (11, 1, NULL, 'https://mp.haosns.com/uploads/images/20251113/2025111310023743f402320.png', 0);

-- ----------------------------
-- Table structure for la_haosns_home_visitor
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_home_visitor`;
CREATE TABLE `la_haosns_home_visitor`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(11) NOT NULL COMMENT '访问者用户ID',
  `visited_user_id` int(11) NOT NULL COMMENT '被访问用户ID',
  `update_time` int(11) NULL DEFAULT NULL,
  `create_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '个人主页访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_home_visitor
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_nav
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_nav`;
CREATE TABLE `la_haosns_nav`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '参数',
  `status` tinyint(11) NOT NULL DEFAULT 0 COMMENT '状态',
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'index_tab' COMMENT '展示位置:index_tab=首页,index_image=首页的图片按钮,send=首页',
  `show_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'button' COMMENT '展示形式,button=按钮,image=图片形式',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_nav
-- ----------------------------
INSERT INTO `la_haosns_nav` VALUES (1, '测试', 'web', '11112', 'https://mp.haosns.com/uploads/images/20251108/202511081535026f7e13179.png', '', 1, 'index_tab', 'button', '测试', 0);

-- ----------------------------
-- Table structure for la_haosns_notice
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_notice`;
CREATE TABLE `la_haosns_notice`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '用户id',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '内容',
  `scene_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '场景',
  `read` tinyint(1) NULL DEFAULT 0 COMMENT '已读状态;0-未读,1-已读',
  `recipient` tinyint(1) NULL DEFAULT 0 COMMENT '通知接收对象类型;1-会员;2-商家;3-平台;4-游客(未注册用户)',
  `send_type` tinyint(1) NULL DEFAULT 0 COMMENT '通知发送类型 1-系统通知 2-短信通知 3-微信模板 4-微信小程序',
  `notice_type` tinyint(1) NULL DEFAULT NULL COMMENT '通知类型 1-业务通知 2-验证码',
  `extra` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '其他',
  `create_time` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_notice
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_search_log
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_search_log`;
CREATE TABLE `la_haosns_search_log`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint(20) UNSIGNED NULL DEFAULT NULL COMMENT '用户ID，未登录用户可为空',
  `keyword` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '搜索关键词',
  `search_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'general' COMMENT '搜索类型article,goods',
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户IP地址',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `num` int(11) NOT NULL DEFAULT 1 COMMENT '搜索次数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '搜索日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_search_log
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_topic
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_topic`;
CREATE TABLE `la_haosns_topic`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '话题名称',
  `synopsis` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '简介',
  `sort` int(10) UNSIGNED NOT NULL DEFAULT 255 COMMENT '排序',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '审核状态  1-正常 2驳回',
  `create_time` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  `longitude` int(10) NULL DEFAULT NULL COMMENT '经度',
  `latitude` int(10) NULL DEFAULT NULL COMMENT '纬度',
  `address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '位置',
  `hot` int(100) UNSIGNED NOT NULL DEFAULT 0 COMMENT '热度',
  `bg_image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '背景图',
  `bg_color` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '话题表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_topic
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_topic_article
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_topic_article`;
CREATE TABLE `la_haosns_topic_article`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `a_id` int(11) NOT NULL COMMENT '帖子id',
  `topic_id` int(11) NOT NULL COMMENT '话题id',
  `create_time` int(11) NOT NULL COMMENT '加入时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '话题帖子关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_topic_article
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_user
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_user`;
CREATE TABLE `la_haosns_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sn` varchar(32) CHARACTER SET utf32 COLLATE utf32_general_ci NULL DEFAULT NULL COMMENT '会员码',
  `nickname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `avatar` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户头像',
  `real_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `mobile` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `level` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '等级',
  `group_id` int(11) NULL DEFAULT NULL COMMENT '所属分组id',
  `sex` tinyint(1) NULL DEFAULT 0 COMMENT '性别:0-未知；1-男；2-女',
  `birthday` int(11) NULL DEFAULT NULL COMMENT '生日',
  `user_money` decimal(10, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '用户余额',
  `user_integral` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '用户积分',
  `total_order_amount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '消费累计额度',
  `total_order_num` int(11) NULL DEFAULT 0 COMMENT '累计消费次数',
  `total_recharge_amount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '累计充值金额',
  `account` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '账号',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `pay_password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付密码',
  `login_time` int(10) NULL DEFAULT NULL COMMENT '最后登录时间',
  `login_ip` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录ip',
  `disable` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否禁用：0-否；1-是；',
  `user_growth` int(128) NULL DEFAULT 0 COMMENT '用户成长值',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `first_leader` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '第一个上级',
  `second_leader` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '第二个上级',
  `third_leader` int(11) NOT NULL DEFAULT 0 COMMENT '第三个上级',
  `ancestor_relation` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '关系链',
  `code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '邀请码',
  `user_earnings` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '用户收益(可提现)',
  `register_source` tinyint(1) NOT NULL COMMENT '用户注册来源',
  `inviter_id` int(11) NOT NULL DEFAULT 0 COMMENT '邀请人id',
  `id_card` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '身份证号',
  `is_certification` tinyint(1) NULL DEFAULT 0 COMMENT '是否认证： 0-否 1-通过;',
  `push_clientid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'app推送设备标识',
  `create_time` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '修改时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  `is_new_user` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否是新注册用户:1-是;0-否;',
  `is_logoff` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否注销申请:1-是;0-否;',
  `credit` int(11) NOT NULL DEFAULT 60 COMMENT '信用分：良好=60-70，优秀=70-80,极好=80-100,一般=50-60,差=50以下',
  `vip_expire_time` int(11) NOT NULL DEFAULT 0 COMMENT 'vip到期时间',
  `vip_level_id` int(11) NULL DEFAULT NULL COMMENT 'vip等级id',
  `ip` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ip_address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `home_bg` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '背景图',
  `notice_comment_auth_check` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0',
  `private_like` tinyint(1) NOT NULL DEFAULT 0,
  `private_follow` tinyint(1) NOT NULL DEFAULT 0,
  `private_collect` tinyint(1) NOT NULL DEFAULT 0,
  `private_fans` tinyint(1) NOT NULL DEFAULT 0,
  `private_visitor` tinyint(1) NOT NULL DEFAULT 0,
  `only_look_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '仅用户可见',
  `withdraw_wepay_code` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '提现微信收款二维码',
  `withdraw_alipay_code` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '提现支付宝收款二维码',
  `withdraw_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '提现真实姓名',
  `withdraw_alipay_account` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '提现支付宝账号',
  `desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '个人简介',
  `longitude` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '经度',
  `latitude` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '纬度',
  `address` json NULL COMMENT '地址',
  `district` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '城市',
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省',
  `county` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '县',
  `area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '具体定位',
  `birth` int(11) NOT NULL DEFAULT 0 COMMENT '出生年月日',
  `career` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '职业',
  `height` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '身高',
  `weight` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '体重',
  `experience` int(128) UNSIGNED NOT NULL DEFAULT 0 COMMENT '经验',
  `last_online_time` int(11) NOT NULL DEFAULT 0 COMMENT '最后上线时间',
  `is_fake_user` tinyint(1) NOT NULL DEFAULT 0,
  `fake_user_owner_id` int(11) NULL DEFAULT NULL,
  `is_fake_admin` tinyint(1) NOT NULL DEFAULT 0,
  `salt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `dz_uid` int(11) NULL DEFAULT NULL,
  `font_size` decimal(10, 0) NOT NULL DEFAULT 0 COMMENT '字体大小倍数',
  `theme` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '主题',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sn`(`sn`) USING BTREE,
  UNIQUE INDEX `idx_haosns_user_dz_uid`(`dz_uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_user
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_user_address
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_user_address`;
CREATE TABLE `la_haosns_user_address`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '用户id',
  `contact` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '收货人',
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '联系方式',
  `province_id` int(11) NOT NULL COMMENT '省',
  `city_id` int(11) NULL DEFAULT NULL COMMENT '市',
  `district_id` int(11) NULL DEFAULT NULL COMMENT '区',
  `address` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '详细地址',
  `longitude` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '经度',
  `latitude` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '纬度',
  `is_default` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否默认(1为默认)',
  `create_time` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '修改时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户地址表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_user_address
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_user_auth
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_user_auth`;
CREATE TABLE `la_haosns_user_auth`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `openid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '微信openid',
  `unionid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '微信unionid',
  `terminal` tinyint(1) NOT NULL DEFAULT 1 COMMENT '客户端类型：1-微信小程序；2-微信公众号；3-手机H5；4-电脑PC；5-苹果APP；6-安卓APP',
  `create_time` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `openid`(`openid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户授权表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_user_auth
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_user_block
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_user_block`;
CREATE TABLE `la_haosns_user_block`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '操作人ID',
  `target_user_id` bigint(20) UNSIGNED NOT NULL COMMENT '被拉黑用户ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id_target_id`(`user_id`, `target_user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户拉黑表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_user_block
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_user_circle
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_user_circle`;
CREATE TABLE `la_haosns_user_circle`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `circle_id` int(11) NOT NULL COMMENT '圈子id',
  `create_time` int(11) NOT NULL COMMENT '加入时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户圈子表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_user_circle
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_user_collect
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_user_collect`;
CREATE TABLE `la_haosns_user_collect`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `aid` int(11) NOT NULL COMMENT '帖子id',
  `comments_id` int(11) NOT NULL DEFAULT 0 COMMENT '评论id',
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '类型 1帖子收藏 2帖子点赞  3评论点赞',
  `create_time` int(11) NOT NULL COMMENT '加入时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户点赞表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_user_collect
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_user_field
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_user_field`;
CREATE TABLE `la_haosns_user_field`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '键名',
  `placehold` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表单预设值',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '键值',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置类型',
  `sort` int(10) NOT NULL DEFAULT 0 COMMENT '排序',
  `require` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否必选',
  `update` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否可修改',
  `max_font` int(11) NOT NULL DEFAULT 0 COMMENT '最大字数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_user_field
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_user_field_data
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_user_field_data`;
CREATE TABLE `la_haosns_user_field_data`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `field_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字段id',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id`, `field_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户字段信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_user_field_data
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_user_follow
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_user_follow`;
CREATE TABLE `la_haosns_user_follow`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `follow_user_id` int(11) NOT NULL COMMENT '关注id',
  `create_time` int(11) NOT NULL COMMENT '加入时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户关注表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_user_follow
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_user_label
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_user_label`;
CREATE TABLE `la_haosns_user_label`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  `label_type` tinyint(1) NOT NULL COMMENT '标签类型：0-手动标签；1-自动标签',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户标签表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_user_label
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_user_label_group
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_user_label_group`;
CREATE TABLE `la_haosns_user_label_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_user_label_group
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_user_label_index
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_user_label_index`;
CREATE TABLE `la_haosns_user_label_index`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `label_id` int(11) NOT NULL COMMENT '标签id',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户标签关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_user_label_index
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_user_label_item
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_user_label_item`;
CREATE TABLE `la_haosns_user_label_item`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `color_type` int(11) NULL DEFAULT 0 COMMENT '颜色类型: 0-普通 1-渐变',
  `color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_user_label_item
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_user_label_record
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_user_label_record`;
CREATE TABLE `la_haosns_user_label_record`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `label_item_id` int(11) NOT NULL,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_user_label_record
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_user_level
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_user_level`;
CREATE TABLE `la_haosns_user_level`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '等级名称',
  `rank` int(11) NOT NULL COMMENT '等级权重（1-为系统默认等级）',
  `image` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
  `background_image` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '背景图',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '等级描述',
  `discount` decimal(4, 2) NULL DEFAULT NULL COMMENT '等级折扣（空表示无折扣）',
  `condition` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '条件(保存json格式)',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  `experience` int(128) NOT NULL DEFAULT 10000 COMMENT '升级所需要的经验',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户等级表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_user_level
-- ----------------------------

-- ----------------------------
-- Table structure for la_haosns_user_session
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_user_session`;
CREATE TABLE `la_haosns_user_session`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `terminal` tinyint(1) NOT NULL DEFAULT 1 COMMENT '客户端类型：1-微信小程序；2-微信公众号；3-手机H5；4-电脑PC；5-苹果APP；6-安卓APP',
  `token` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '令牌',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `expire_time` int(10) NOT NULL COMMENT '到期时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `admin_id_client`(`user_id`, `terminal`) USING BTREE COMMENT '一个用户在一个终端只有一个token',
  UNIQUE INDEX `token`(`token`) USING BTREE COMMENT 'token是唯一的'
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会话表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_user_session
-- ----------------------------
INSERT INTO `la_haosns_user_session` VALUES (1, 1, 3, 'a8d0f3e08a7d64b16b8ede37c59aaa6f', 1764565726, 1764594526);
INSERT INTO `la_haosns_user_session` VALUES (2, 3, 2, 'bc1f246f887f4428d78ea65c9a6abfb9', 1763018426, 1763047226);
INSERT INTO `la_haosns_user_session` VALUES (3, 4, 2, '1922ba7afb623360b9308adefe062740', 1763788006, 1763816806);
INSERT INTO `la_haosns_user_session` VALUES (4, 5, 2, '58fea6d1f76c948b035b386cb25432a0', 1764387764, 1764416564);
INSERT INTO `la_haosns_user_session` VALUES (5, 6, 2, '04ad569027af2e50cb01796e7273dd50', 1763375076, 1763403876);
INSERT INTO `la_haosns_user_session` VALUES (6, 7, 2, '9f13cc7ec7a2cbae90147ca30aa8d182', 1763312559, 1763341359);
INSERT INTO `la_haosns_user_session` VALUES (7, 2, 3, '05fa13b64a51ce9ef7a71316e0b78a14', 1763547313, 1763576113);
INSERT INTO `la_haosns_user_session` VALUES (8, 8, 2, 'f53cdf04412f4c87dacd167d7f0b1e8a', 1763351472, 1763380272);
INSERT INTO `la_haosns_user_session` VALUES (9, 9, 2, '6817bc96781789836874a82620eea8dd', NULL, 1763381128);
INSERT INTO `la_haosns_user_session` VALUES (10, 10, 2, 'f571ec6aec9d68199f6e0ec327a38ce0', NULL, 1763411990);
INSERT INTO `la_haosns_user_session` VALUES (11, 11, 2, 'e138bb194d3862a4aa7a3f06d1002408', 1763383298, 1763412098);
INSERT INTO `la_haosns_user_session` VALUES (12, 12, 2, 'e8cf4f5d2c24d40994c4e013dea4b74a', 1763652758, 1763681558);
INSERT INTO `la_haosns_user_session` VALUES (13, 13, 3, '0a3f026406e41c16ee4ea54342e16dec', NULL, 1763412728);
INSERT INTO `la_haosns_user_session` VALUES (14, 14, 2, '517752fae99387e599748ef6b258432a', NULL, 1763412909);
INSERT INTO `la_haosns_user_session` VALUES (15, 17, 3, '16d9d2af14ad3e655882e7c459c960b2', 1763385363, 1763414163);
INSERT INTO `la_haosns_user_session` VALUES (16, 16, 3, '01eebdbebe8ba98443940c685f921cb1', 1763385376, 1763414176);
INSERT INTO `la_haosns_user_session` VALUES (17, 18, 2, '3fa730f77a21c9ea24b05814e82c4ee4', NULL, 1763427338);
INSERT INTO `la_haosns_user_session` VALUES (18, 19, 2, 'e3fda27e112c9f42b9814ebba088aa9a', NULL, 1763596681);
INSERT INTO `la_haosns_user_session` VALUES (19, 21, 2, '3f0ef1603b2ae0b96122bacb7705199e', 1763653212, 1763682012);
INSERT INTO `la_haosns_user_session` VALUES (20, 22, 2, 'a401acd95e0f9d741f8b0ea8994eaaba', 1764422537, 1764451337);
INSERT INTO `la_haosns_user_session` VALUES (21, 23, 2, '122aaf6ffaecce57af8f742b4625bbe8', NULL, 1764497325);

-- ----------------------------
-- Table structure for la_haosns_user_withdrawal
-- ----------------------------
DROP TABLE IF EXISTS `la_haosns_user_withdrawal`;
CREATE TABLE `la_haosns_user_withdrawal`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '提现记录ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '提现类型: balance',
  `channel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '提现类型: alipay_code ， wepay_code ， alipay_account',
  `amount` decimal(15, 2) NOT NULL COMMENT '提现金额',
  `fee` decimal(15, 2) NULL DEFAULT 0.00 COMMENT '手续费',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态：0-待处理,1-已打款,2-拒绝打款',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户提现申请表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_haosns_user_withdrawal
-- ----------------------------

-- ----------------------------
-- Table structure for la_hot_search
-- ----------------------------
DROP TABLE IF EXISTS `la_hot_search`;
CREATE TABLE `la_hot_search`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '关键词',
  `sort` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序号',
  `create_time` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '热门搜索表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_hot_search
-- ----------------------------

-- ----------------------------
-- Table structure for la_jobs
-- ----------------------------
DROP TABLE IF EXISTS `la_jobs`;
CREATE TABLE `la_jobs`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `sort` int(11) NULL DEFAULT 0 COMMENT '显示顺序',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '状态（0停用 1正常）',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` int(10) NOT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '修改时间',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for la_notice_record
-- ----------------------------
DROP TABLE IF EXISTS `la_notice_record`;
CREATE TABLE `la_notice_record`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '用户id',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '内容',
  `scene_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '场景',
  `read` tinyint(1) NULL DEFAULT 0 COMMENT '已读状态;0-未读,1-已读',
  `recipient` tinyint(1) NULL DEFAULT 0 COMMENT '通知接收对象类型;1-会员;2-商家;3-平台;4-游客(未注册用户)',
  `send_type` tinyint(1) NULL DEFAULT 0 COMMENT '通知发送类型 1-系统通知 2-短信通知 3-微信模板 4-微信小程序',
  `notice_type` tinyint(1) NULL DEFAULT NULL COMMENT '通知类型 1-业务通知 2-验证码',
  `extra` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '其他',
  `create_time` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_notice_record
-- ----------------------------

-- ----------------------------
-- Table structure for la_notice_setting
-- ----------------------------
DROP TABLE IF EXISTS `la_notice_setting`;
CREATE TABLE `la_notice_setting`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `scene_id` int(10) NOT NULL COMMENT '场景id',
  `scene_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '场景名称',
  `scene_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '场景描述',
  `recipient` tinyint(1) NOT NULL DEFAULT 1 COMMENT '接收者 1-用户 2-平台',
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '通知类型: 1-业务通知 2-验证码',
  `system_notice` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '系统通知设置',
  `sms_notice` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '短信通知设置',
  `oa_notice` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '公众号通知设置',
  `mnp_notice` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '小程序通知设置',
  `support` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '支持的发送类型 1-系统通知 2-短信通知 3-微信模板消息 4-小程序提醒',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知设置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_notice_setting
-- ----------------------------
INSERT INTO `la_notice_setting` VALUES (1, 101, '登录验证码', '用户手机号码登录时发送', 1, 2, '{\"type\":\"system\",\"title\":\"\",\"content\":\"\",\"status\":\"0\",\"is_show\":\"\",\"tips\":[\"可选变量 验证码:code\"]}', '{\"type\":\"sms\",\"template_id\":\"2497585\",\"content\":\"验证码为：${code}，您正在登录，若非本人操作，请勿泄露。\",\"status\":\"1\",\"is_show\":\"1\",\"tips\":[\"可选变量 验证码:code\",\"示例：您正在登录，验证码${code}，切勿将验证码泄露于他人，本条验证码有效期5分钟。\",\"生效条件：1、管理后台完成短信设置。 2、第三方短信平台申请模板。\"]}', '{\"type\":\"oa\",\"template_id\":\"\",\"template_sn\":\"\",\"name\":\"\",\"first\":\"\",\"remark\":\"\",\"tpl\":[],\"status\":\"0\",\"is_show\":\"\",\"tips\":[\"可选变量 验证码:code\",\"配置路径：小程序后台 > 功能 > 订阅消息\"]}', '{\"type\":\"mnp\",\"template_id\":\"\",\"template_sn\":\"\",\"name\":\"\",\"tpl\":[],\"status\":\"0\",\"is_show\":\"\",\"tips\":[\"可选变量 验证码:code\",\"配置路径：小程序后台 > 功能 > 订阅消息\"]}', '2', NULL);
INSERT INTO `la_notice_setting` VALUES (2, 102, '绑定手机验证码', '用户绑定手机号码时发送', 1, 2, '{\"type\":\"system\",\"title\":\"\",\"content\":\"\",\"status\":\"0\",\"is_show\":\"\"}', '{\"type\":\"sms\",\"template_id\":\"SMS_123456\",\"content\":\"您正在绑定手机号，验证码${code}，切勿将验证码泄露于他人，本条验证码有效期5分钟。\",\"status\":\"1\",\"is_show\":\"1\"}', '{\"type\":\"oa\",\"template_id\":\"\",\"template_sn\":\"\",\"name\":\"\",\"first\":\"\",\"remark\":\"\",\"tpl\":[],\"status\":\"0\",\"is_show\":\"\"}', '{\"type\":\"mnp\",\"template_id\":\"\",\"template_sn\":\"\",\"name\":\"\",\"tpl\":[],\"status\":\"0\",\"is_show\":\"\"}', '2', NULL);
INSERT INTO `la_notice_setting` VALUES (3, 103, '变更手机验证码', '用户变更手机号码时发送', 1, 2, '{\"type\":\"system\",\"title\":\"\",\"content\":\"\",\"status\":\"0\",\"is_show\":\"\",\"tips\":[\"可选变量 验证码:code\"]}', '{\"type\":\"sms\",\"template_id\":\"SMS_123456\",\"content\":\"您正在变更手机号，验证码${code}，切勿将验证码泄露于他人，本条验证码有效期5分钟。\",\"status\":\"1\",\"is_show\":\"1\"}', '{\"type\":\"oa\",\"template_id\":\"\",\"template_sn\":\"\",\"name\":\"\",\"first\":\"\",\"remark\":\"\",\"tpl\":[],\"status\":\"0\",\"is_show\":\"\",\"tips\":[\"可选变量 验证码:code\",\"配置路径：小程序后台 > 功能 > 订阅消息\"]}', '{\"type\":\"mnp\",\"template_id\":\"\",\"template_sn\":\"\",\"name\":\"\",\"tpl\":[],\"status\":\"0\",\"is_show\":\"\",\"tips\":[\"可选变量 验证码:code\",\"配置路径：小程序后台 > 功能 > 订阅消息\"]}', '2', NULL);
INSERT INTO `la_notice_setting` VALUES (4, 104, '找回登录密码验证码', '用户找回登录密码号码时发送', 1, 2, '{\"type\":\"system\",\"title\":\"\",\"content\":\"\",\"status\":\"0\",\"is_show\":\"\",\"tips\":[\"可选变量 验证码:code\"]}', '{\"type\":\"sms\",\"template_id\":\"SMS_123456\",\"content\":\"您正在找回登录密码，验证码${code}，切勿将验证码泄露于他人，本条验证码有效期5分钟。\",\"status\":\"1\",\"is_show\":\"1\"}', '{\"type\":\"oa\",\"template_id\":\"\",\"template_sn\":\"\",\"name\":\"\",\"first\":\"\",\"remark\":\"\",\"tpl\":[],\"status\":\"0\",\"is_show\":\"\",\"tips\":[\"可选变量 验证码:code\",\"配置路径：小程序后台 > 功能 > 订阅消息\"]}', '{\"type\":\"mnp\",\"template_id\":\"\",\"template_sn\":\"\",\"name\":\"\",\"tpl\":[],\"status\":\"0\",\"is_show\":\"\",\"tips\":[\"可选变量 验证码:code\",\"配置路径：小程序后台 > 功能 > 订阅消息\"]}', '2', NULL);

-- ----------------------------
-- Table structure for la_official_account_reply
-- ----------------------------
DROP TABLE IF EXISTS `la_official_account_reply`;
CREATE TABLE `la_official_account_reply`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '规则名称',
  `keyword` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '关键词',
  `reply_type` tinyint(1) NOT NULL COMMENT '回复类型 1-关注回复 2-关键字回复 3-默认回复',
  `matching_type` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '匹配方式：1-全匹配；2-模糊匹配',
  `content_type` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '内容类型：1-文本',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '回复内容',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '启动状态：1-启动；0-关闭',
  `sort` int(11) UNSIGNED NOT NULL DEFAULT 50 COMMENT '排序',
  `create_time` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '公众号消息回调表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_official_account_reply
-- ----------------------------

-- ----------------------------
-- Table structure for la_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `la_operation_log`;
CREATE TABLE `la_operation_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL COMMENT '管理员ID',
  `admin_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '管理员名称',
  `account` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '管理员账号',
  `action` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作名称',
  `type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求方式',
  `url` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '访问链接',
  `params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '请求数据',
  `result` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '请求结果',
  `ip` varchar(39) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'ip地址',
  `create_time` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4766 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_operation_log
-- ----------------------------

-- ----------------------------
-- Table structure for la_recharge_order
-- ----------------------------
DROP TABLE IF EXISTS `la_recharge_order`;
CREATE TABLE `la_recharge_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sn` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `pay_sn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '支付编号-冗余字段，针对微信同一主体不同客户端支付需用不同订单号预留。',
  `pay_way` tinyint(2) NOT NULL DEFAULT 2 COMMENT '支付方式 2-微信支付 3-支付宝支付',
  `pay_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '支付状态：0-待支付；1-已支付',
  `pay_time` int(10) NULL DEFAULT NULL COMMENT '支付时间',
  `order_amount` decimal(10, 2) NOT NULL COMMENT '充值金额',
  `order_terminal` tinyint(1) NULL DEFAULT 1 COMMENT '终端',
  `transaction_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第三方平台交易流水号',
  `refund_status` tinyint(1) NULL DEFAULT 0 COMMENT '退款状态 0-未退款 1-已退款',
  `refund_transaction_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退款交易流水号',
  `create_time` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_recharge_order
-- ----------------------------

-- ----------------------------
-- Table structure for la_refund_log
-- ----------------------------
DROP TABLE IF EXISTS `la_refund_log`;
CREATE TABLE `la_refund_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sn` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '编号',
  `record_id` int(11) NOT NULL COMMENT '退款记录id',
  `user_id` int(11) NOT NULL DEFAULT 0 COMMENT '关联用户',
  `handle_id` int(11) NOT NULL DEFAULT 0 COMMENT '处理人id（管理员id）',
  `order_amount` decimal(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '订单总的应付款金额，冗余字段',
  `refund_amount` decimal(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '本次退款金额',
  `refund_status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '退款状态，0退款中，1退款成功，2退款失败',
  `refund_msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '退款信息',
  `create_time` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_refund_log
-- ----------------------------

-- ----------------------------
-- Table structure for la_refund_record
-- ----------------------------
DROP TABLE IF EXISTS `la_refund_record`;
CREATE TABLE `la_refund_record`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sn` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '退款编号',
  `user_id` int(11) NOT NULL DEFAULT 0 COMMENT '关联用户',
  `order_id` int(11) NOT NULL DEFAULT 0 COMMENT '来源订单id',
  `order_sn` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '来源单号',
  `order_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'order' COMMENT '订单来源 order-商品订单 recharge-充值订单',
  `order_amount` decimal(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '订单总的应付款金额，冗余字段',
  `refund_amount` decimal(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '本次退款金额',
  `transaction_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第三方平台交易流水号',
  `refund_way` tinyint(1) NOT NULL DEFAULT 1 COMMENT '退款方式 1-线上退款 2-线下退款',
  `refund_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '退款类型 1-后台退款',
  `refund_status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '退款状态，0退款中，1退款成功，2退款失败',
  `create_time` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_refund_record
-- ----------------------------

-- ----------------------------
-- Table structure for la_sms_log
-- ----------------------------
DROP TABLE IF EXISTS `la_sms_log`;
CREATE TABLE `la_sms_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `scene_id` int(11) NOT NULL COMMENT '场景id',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机号码',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '发送内容',
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发送关键字（注册、找回密码）',
  `is_verify` tinyint(1) NULL DEFAULT 0 COMMENT '是否已验证；0-否；1-是',
  `check_num` int(5) NULL DEFAULT 0 COMMENT '验证次数',
  `send_status` tinyint(1) NOT NULL COMMENT '发送状态：0-发送中；1-发送成功；2-发送失败',
  `send_time` int(10) NOT NULL COMMENT '发送时间',
  `results` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '短信结果',
  `create_time` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '短信记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_sms_log
-- ----------------------------

-- ----------------------------
-- Table structure for la_system_menu
-- ----------------------------
DROP TABLE IF EXISTS `la_system_menu`;
CREATE TABLE `la_system_menu`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级菜单',
  `type` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '权限类型: M=目录，C=菜单，A=按钮',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '菜单图标',
  `sort` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '菜单排序',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '权限标识',
  `paths` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '前端组件',
  `selected` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '选中路径',
  `params` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '路由参数',
  `is_cache` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否缓存: 0=否, 1=是',
  `is_show` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否显示: 0=否, 1=是',
  `is_disable` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否禁用: 0=否, 1=是',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 262 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统菜单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_system_menu
-- ----------------------------
INSERT INTO `la_system_menu` VALUES (4, 28, 'M', '权限管理', 'el-icon-Lock', 300, '', 'permission', '', '', '', 0, 1, 0, 1656664556, 1762859526);
INSERT INTO `la_system_menu` VALUES (5, 0, 'C', '首页', 'el-icon-Monitor', 1000, 'workbench/index', 'workbench', 'workbench/index', '', '', 0, 1, 0, 1656664793, 1762855207);
INSERT INTO `la_system_menu` VALUES (6, 4, 'C', '菜单', 'el-icon-Operation', 100, 'auth.menu/lists', 'menu', 'permission/menu/index', '', '', 1, 1, 0, 1656664960, 1710472994);
INSERT INTO `la_system_menu` VALUES (7, 4, 'C', '管理员', 'local-icon-shouyiren', 80, 'auth.admin/lists', 'admin', 'permission/admin/index', '', '', 0, 1, 0, 1656901567, 1710473013);
INSERT INTO `la_system_menu` VALUES (8, 4, 'C', '角色', 'el-icon-Female', 90, 'auth.role/lists', 'role', 'permission/role/index', '', '', 0, 1, 0, 1656901660, 1710473000);
INSERT INTO `la_system_menu` VALUES (12, 8, 'A', '新增', '', 1, 'auth.role/add', '', '', '', '', 0, 1, 0, 1657001790, 1663750625);
INSERT INTO `la_system_menu` VALUES (14, 8, 'A', '编辑', '', 1, 'auth.role/edit', '', '', '', '', 0, 1, 0, 1657001924, 1663750631);
INSERT INTO `la_system_menu` VALUES (15, 8, 'A', '删除', '', 1, 'auth.role/delete', '', '', '', '', 0, 1, 0, 1657001982, 1663750637);
INSERT INTO `la_system_menu` VALUES (16, 6, 'A', '新增', '', 1, 'auth.menu/add', '', '', '', '', 0, 1, 0, 1657072523, 1663750565);
INSERT INTO `la_system_menu` VALUES (17, 6, 'A', '编辑', '', 1, 'auth.menu/edit', '', '', '', '', 0, 1, 0, 1657073955, 1663750570);
INSERT INTO `la_system_menu` VALUES (18, 6, 'A', '删除', '', 1, 'auth.menu/delete', '', '', '', '', 0, 1, 0, 1657073987, 1663750578);
INSERT INTO `la_system_menu` VALUES (19, 7, 'A', '新增', '', 1, 'auth.admin/add', '', '', '', '', 0, 1, 0, 1657074035, 1663750596);
INSERT INTO `la_system_menu` VALUES (20, 7, 'A', '编辑', '', 1, 'auth.admin/edit', '', '', '', '', 0, 1, 0, 1657074071, 1663750603);
INSERT INTO `la_system_menu` VALUES (21, 7, 'A', '删除', '', 1, 'auth.admin/delete', '', '', '', '', 0, 1, 0, 1657074108, 1663750609);
INSERT INTO `la_system_menu` VALUES (23, 28, 'M', '开发工具', 'el-icon-EditPen', 40, '', 'dev_tools', '', '', '', 0, 1, 1, 1657097744, 1764568956);
INSERT INTO `la_system_menu` VALUES (24, 23, 'C', '代码生成器', 'el-icon-DocumentAdd', 1, 'tools.generator/generateTable', 'code', 'dev_tools/code/index', '', '', 0, 1, 0, 1657098110, 1658989423);
INSERT INTO `la_system_menu` VALUES (25, 204, 'M', '组织管理', 'el-icon-OfficeBuilding', 400, '', 'organization', '', '', '', 0, 1, 0, 1657099914, 1762859109);
INSERT INTO `la_system_menu` VALUES (26, 25, 'C', '部门管理', 'el-icon-Coordinate', 100, 'dept.dept/lists', 'department', 'organization/department/index', '', '', 1, 1, 0, 1657099989, 1710472962);
INSERT INTO `la_system_menu` VALUES (27, 25, 'C', '岗位管理', 'el-icon-PriceTag', 90, 'dept.jobs/lists', 'post', 'organization/post/index', '', '', 0, 1, 0, 1657100044, 1710472967);
INSERT INTO `la_system_menu` VALUES (28, 0, 'M', '系统设置', 'el-icon-Setting', 200, '', 'setting', '', '', '', 0, 1, 0, 1657100164, 1710472807);
INSERT INTO `la_system_menu` VALUES (29, 28, 'M', '网站设置', 'el-icon-Basketball', 100, '', 'website', '', '', '', 0, 1, 0, 1657100230, 1710473049);
INSERT INTO `la_system_menu` VALUES (30, 29, 'C', '网站信息', '', 1, 'setting.web.web_setting/getWebsite', 'information', 'setting/website/information', '', '', 0, 1, 0, 1657100306, 1657164412);
INSERT INTO `la_system_menu` VALUES (31, 29, 'C', '网站备案', '', 1, 'setting.web.web_setting/getCopyright', 'filing', 'setting/website/filing', '', '', 0, 1, 0, 1657100434, 1657164723);
INSERT INTO `la_system_menu` VALUES (32, 29, 'C', '政策协议', '', 1, 'setting.web.web_setting/getAgreement', 'protocol', 'setting/website/protocol', '', '', 0, 1, 0, 1657100571, 1657164770);
INSERT INTO `la_system_menu` VALUES (33, 28, 'C', '存储设置', 'el-icon-FolderOpened', 70, 'setting.storage/lists', 'storage', 'setting/storage/index', '', '', 0, 1, 0, 1657160959, 1710473095);
INSERT INTO `la_system_menu` VALUES (34, 23, 'C', '字典管理', 'el-icon-Box', 1, 'setting.dict.dict_type/lists', 'dict', 'setting/dict/type/index', '', '', 0, 1, 0, 1657161211, 1663225935);
INSERT INTO `la_system_menu` VALUES (35, 28, 'M', '系统维护', 'el-icon-SetUp', 50, '', 'system', '', '', '', 0, 1, 0, 1657161569, 1710473122);
INSERT INTO `la_system_menu` VALUES (36, 35, 'C', '系统日志', '', 90, 'setting.system.log/lists', 'journal', 'setting/system/journal', '', '', 0, 1, 0, 1657161696, 1710473253);
INSERT INTO `la_system_menu` VALUES (37, 35, 'C', '系统缓存', '', 80, '', 'cache', 'setting/system/cache', '', '', 0, 1, 0, 1657161896, 1710473258);
INSERT INTO `la_system_menu` VALUES (38, 35, 'C', '系统环境', '', 70, 'setting.system.system/info', 'environment', 'setting/system/environment', '', '', 0, 1, 0, 1657162000, 1710473265);
INSERT INTO `la_system_menu` VALUES (39, 24, 'A', '导入数据表', '', 1, 'tools.generator/selectTable', '', '', '', '', 0, 1, 0, 1657162736, 1657162736);
INSERT INTO `la_system_menu` VALUES (40, 24, 'A', '代码生成', '', 1, 'tools.generator/generate', '', '', '', '', 0, 1, 0, 1657162806, 1657162806);
INSERT INTO `la_system_menu` VALUES (41, 23, 'C', '编辑数据表', '', 1, 'tools.generator/edit', 'code/edit', 'dev_tools/code/edit', '/dev_tools/code', '', 1, 0, 0, 1657162866, 1663748668);
INSERT INTO `la_system_menu` VALUES (42, 24, 'A', '同步表结构', '', 1, 'tools.generator/syncColumn', '', '', '', '', 0, 1, 0, 1657162934, 1657162934);
INSERT INTO `la_system_menu` VALUES (43, 24, 'A', '删除数据表', '', 1, 'tools.generator/delete', '', '', '', '', 0, 1, 0, 1657163015, 1657163015);
INSERT INTO `la_system_menu` VALUES (44, 24, 'A', '预览代码', '', 1, 'tools.generator/preview', '', '', '', '', 0, 1, 0, 1657163263, 1657163263);
INSERT INTO `la_system_menu` VALUES (45, 26, 'A', '新增', '', 1, 'dept.dept/add', '', '', '', '', 0, 1, 0, 1657163548, 1663750492);
INSERT INTO `la_system_menu` VALUES (46, 26, 'A', '编辑', '', 1, 'dept.dept/edit', '', '', '', '', 0, 1, 0, 1657163599, 1663750498);
INSERT INTO `la_system_menu` VALUES (47, 26, 'A', '删除', '', 1, 'dept.dept/delete', '', '', '', '', 0, 1, 0, 1657163687, 1663750504);
INSERT INTO `la_system_menu` VALUES (48, 27, 'A', '新增', '', 1, 'dept.jobs/add', '', '', '', '', 0, 1, 0, 1657163778, 1663750524);
INSERT INTO `la_system_menu` VALUES (49, 27, 'A', '编辑', '', 1, 'dept.jobs/edit', '', '', '', '', 0, 1, 0, 1657163800, 1663750530);
INSERT INTO `la_system_menu` VALUES (50, 27, 'A', '删除', '', 1, 'dept.jobs/delete', '', '', '', '', 0, 1, 0, 1657163820, 1663750535);
INSERT INTO `la_system_menu` VALUES (51, 30, 'A', '保存', '', 1, 'setting.web.web_setting/setWebsite', '', '', '', '', 0, 1, 0, 1657164469, 1663750649);
INSERT INTO `la_system_menu` VALUES (52, 31, 'A', '保存', '', 1, 'setting.web.web_setting/setCopyright', '', '', '', '', 0, 1, 0, 1657164692, 1663750657);
INSERT INTO `la_system_menu` VALUES (53, 32, 'A', '保存', '', 1, 'setting.web.web_setting/setAgreement', '', '', '', '', 0, 1, 0, 1657164824, 1663750665);
INSERT INTO `la_system_menu` VALUES (54, 33, 'A', '设置', '', 1, 'setting.storage/setup', '', '', '', '', 0, 1, 0, 1657165303, 1663750673);
INSERT INTO `la_system_menu` VALUES (55, 34, 'A', '新增', '', 1, 'setting.dict.dict_type/add', '', '', '', '', 0, 1, 0, 1657166966, 1663750783);
INSERT INTO `la_system_menu` VALUES (56, 34, 'A', '编辑', '', 1, 'setting.dict.dict_type/edit', '', '', '', '', 0, 1, 0, 1657166997, 1663750789);
INSERT INTO `la_system_menu` VALUES (57, 34, 'A', '删除', '', 1, 'setting.dict.dict_type/delete', '', '', '', '', 0, 1, 0, 1657167038, 1663750796);
INSERT INTO `la_system_menu` VALUES (58, 62, 'A', '新增', '', 1, 'setting.dict.dict_data/add', '', '', '', '', 0, 1, 0, 1657167317, 1663750758);
INSERT INTO `la_system_menu` VALUES (59, 62, 'A', '编辑', '', 1, 'setting.dict.dict_data/edit', '', '', '', '', 0, 1, 0, 1657167371, 1663750751);
INSERT INTO `la_system_menu` VALUES (60, 62, 'A', '删除', '', 1, 'setting.dict.dict_data/delete', '', '', '', '', 0, 1, 0, 1657167397, 1663750768);
INSERT INTO `la_system_menu` VALUES (61, 37, 'A', '清除系统缓存', '', 1, 'setting.system.cache/clear', '', '', '', '', 0, 1, 0, 1657173837, 1657173939);
INSERT INTO `la_system_menu` VALUES (62, 23, 'C', '字典数据管理', '', 1, 'setting.dict.dict_data/lists', 'dict/data', 'setting/dict/data/index', '/dev_tools/dict', '', 1, 0, 0, 1657174351, 1663745617);
INSERT INTO `la_system_menu` VALUES (63, 158, 'M', '素材管理', 'el-icon-Picture', 0, '', 'material', '', '', '', 0, 1, 0, 1657507133, 1710472243);
INSERT INTO `la_system_menu` VALUES (64, 63, 'C', '素材中心', 'el-icon-PictureRounded', 0, '', 'index', 'material/index', '', '', 0, 1, 0, 1657507296, 1664355653);
INSERT INTO `la_system_menu` VALUES (66, 26, 'A', '详情', '', 0, 'dept.dept/detail', '', '', '', '', 0, 1, 0, 1663725459, 1663750516);
INSERT INTO `la_system_menu` VALUES (67, 27, 'A', '详情', '', 0, 'dept.jobs/detail', '', '', '', '', 0, 1, 0, 1663725514, 1663750559);
INSERT INTO `la_system_menu` VALUES (68, 6, 'A', '详情', '', 0, 'auth.menu/detail', '', '', '', '', 0, 1, 0, 1663725564, 1663750584);
INSERT INTO `la_system_menu` VALUES (69, 7, 'A', '详情', '', 0, 'auth.admin/detail', '', '', '', '', 0, 1, 0, 1663725623, 1663750615);
INSERT INTO `la_system_menu` VALUES (70, 158, 'M', '文章资讯', 'el-icon-ChatLineSquare', 90, '', 'article', '', '', '', 0, 0, 1, 1663749965, 1762857004);
INSERT INTO `la_system_menu` VALUES (71, 70, 'C', '文章管理', 'el-icon-ChatDotSquare', 0, 'article.article/lists', 'lists', 'article/lists/index', '', '', 0, 1, 0, 1663750101, 1664354615);
INSERT INTO `la_system_menu` VALUES (72, 70, 'C', '文章添加/编辑', '', 0, 'article.article/add:edit', 'lists/edit', 'article/lists/edit', '/article/lists', '', 0, 0, 0, 1663750153, 1664356275);
INSERT INTO `la_system_menu` VALUES (73, 70, 'C', '文章栏目', 'el-icon-CollectionTag', 0, 'article.articleCate/lists', 'column', 'article/column/index', '', '', 1, 1, 0, 1663750287, 1664354678);
INSERT INTO `la_system_menu` VALUES (74, 71, 'A', '新增', '', 0, 'article.article/add', '', '', '', '', 0, 1, 0, 1663750335, 1663750335);
INSERT INTO `la_system_menu` VALUES (75, 71, 'A', '详情', '', 0, 'article.article/detail', '', '', '', '', 0, 1, 0, 1663750354, 1663750383);
INSERT INTO `la_system_menu` VALUES (76, 71, 'A', '删除', '', 0, 'article.article/delete', '', '', '', '', 0, 1, 0, 1663750413, 1663750413);
INSERT INTO `la_system_menu` VALUES (77, 71, 'A', '修改状态', '', 0, 'article.article/updateStatus', '', '', '', '', 0, 1, 0, 1663750442, 1663750442);
INSERT INTO `la_system_menu` VALUES (78, 73, 'A', '添加', '', 0, 'article.articleCate/add', '', '', '', '', 0, 1, 0, 1663750483, 1663750483);
INSERT INTO `la_system_menu` VALUES (79, 73, 'A', '删除', '', 0, 'article.articleCate/delete', '', '', '', '', 0, 1, 0, 1663750895, 1663750895);
INSERT INTO `la_system_menu` VALUES (80, 73, 'A', '详情', '', 0, 'article.articleCate/detail', '', '', '', '', 0, 1, 0, 1663750913, 1663750913);
INSERT INTO `la_system_menu` VALUES (81, 73, 'A', '修改状态', '', 0, 'article.articleCate/updateStatus', '', '', '', '', 0, 1, 0, 1663750936, 1663750936);
INSERT INTO `la_system_menu` VALUES (82, 0, 'M', '客户端设置', 'el-icon-Iphone', 150, '', 'channel', '', '', '', 0, 1, 0, 1663754084, 1762866027);
INSERT INTO `la_system_menu` VALUES (83, 82, 'C', 'h5设置', 'el-icon-Cellphone', 100, 'channel.web_page_setting/getConfig', 'h5', 'channel/h5', '', '', 0, 1, 0, 1663754158, 1710472929);
INSERT INTO `la_system_menu` VALUES (84, 83, 'A', '保存', '', 0, 'channel.web_page_setting/setConfig', '', '', '', '', 0, 1, 0, 1663754259, 1663754259);
INSERT INTO `la_system_menu` VALUES (85, 82, 'M', '微信公众号', 'local-icon-dingdan', 80, '', 'wx_oa', '', '', '', 0, 1, 0, 1663755470, 1710472946);
INSERT INTO `la_system_menu` VALUES (86, 85, 'C', '公众号配置', '', 0, 'channel.official_account_setting/getConfig', 'config', 'channel/wx_oa/config', '', '', 0, 1, 0, 1663755663, 1664355450);
INSERT INTO `la_system_menu` VALUES (87, 85, 'C', '菜单管理', '', 0, 'channel.official_account_menu/detail', 'menu', 'channel/wx_oa/menu', '', '', 0, 1, 0, 1663755767, 1664355456);
INSERT INTO `la_system_menu` VALUES (88, 86, 'A', '保存', '', 0, 'channel.official_account_setting/setConfig', '', '', '', '', 0, 1, 0, 1663755799, 1663755799);
INSERT INTO `la_system_menu` VALUES (89, 86, 'A', '保存并发布', '', 0, 'channel.official_account_menu/save', '', '', '', '', 0, 1, 0, 1663756490, 1663756490);
INSERT INTO `la_system_menu` VALUES (90, 85, 'C', '关注回复', '', 0, 'channel.official_account_reply/lists', 'follow', 'channel/wx_oa/reply/follow_reply', '', '', 0, 1, 0, 1663818358, 1663818366);
INSERT INTO `la_system_menu` VALUES (91, 85, 'C', '关键字回复', '', 0, '', 'keyword', 'channel/wx_oa/reply/keyword_reply', '', '', 0, 1, 0, 1663818445, 1663818445);
INSERT INTO `la_system_menu` VALUES (93, 85, 'C', '默认回复', '', 0, '', 'default', 'channel/wx_oa/reply/default_reply', '', '', 0, 1, 0, 1663818580, 1663818580);
INSERT INTO `la_system_menu` VALUES (94, 82, 'C', '微信小程序', 'local-icon-weixin', 90, 'channel.mnp_settings/getConfig', 'weapp', 'channel/weapp', '', '', 0, 1, 0, 1663831396, 1710472941);
INSERT INTO `la_system_menu` VALUES (95, 94, 'A', '保存', '', 0, 'channel.mnp_settings/setConfig', '', '', '', '', 0, 1, 0, 1663831436, 1663831436);
INSERT INTO `la_system_menu` VALUES (96, 0, 'M', '装修管理', 'el-icon-Brush', 600, '', 'decoration', '', '', '', 0, 0, 1, 1663834825, 1762858833);
INSERT INTO `la_system_menu` VALUES (97, 175, 'C', '页面装修', 'el-icon-CopyDocument', 100, 'decorate.page/detail', 'pages', 'decoration/pages/index', '', '', 0, 1, 0, 1663834879, 1710929256);
INSERT INTO `la_system_menu` VALUES (98, 97, 'A', '保存', '', 0, 'decorate.page/save', '', '', '', '', 0, 1, 0, 1663834956, 1663834956);
INSERT INTO `la_system_menu` VALUES (99, 175, 'C', '底部导航', 'el-icon-Position', 90, 'decorate.tabbar/detail', 'tabbar', 'decoration/tabbar', '', '', 0, 1, 0, 1663835004, 1710929262);
INSERT INTO `la_system_menu` VALUES (100, 99, 'A', '保存', '', 0, 'decorate.tabbar/save', '', '', '', '', 0, 1, 0, 1663835018, 1663835018);
INSERT INTO `la_system_menu` VALUES (101, 158, 'M', '消息管理', 'el-icon-ChatDotRound', 80, '', 'message', '', '', '', 0, 1, 0, 1663838602, 1710471874);
INSERT INTO `la_system_menu` VALUES (102, 101, 'C', '通知设置', '', 0, 'notice.notice/settingLists', 'notice', 'message/notice/index', '', '', 0, 1, 0, 1663839195, 1663839195);
INSERT INTO `la_system_menu` VALUES (103, 102, 'A', '详情', '', 0, 'notice.notice/detail', '', '', '', '', 0, 1, 0, 1663839537, 1663839537);
INSERT INTO `la_system_menu` VALUES (104, 101, 'C', '通知设置编辑', '', 0, 'notice.notice/set', 'notice/edit', 'message/notice/edit', '/message/notice', '', 0, 0, 0, 1663839873, 1663898477);
INSERT INTO `la_system_menu` VALUES (105, 71, 'A', '编辑', '', 0, 'article.article/edit', '', '', '', '', 0, 1, 0, 1663840043, 1663840053);
INSERT INTO `la_system_menu` VALUES (107, 101, 'C', '短信设置', '', 0, 'notice.sms_config/getConfig', 'short_letter', 'message/short_letter/index', '', '', 0, 1, 0, 1663898591, 1664355708);
INSERT INTO `la_system_menu` VALUES (108, 107, 'A', '设置', '', 0, 'notice.sms_config/setConfig', '', '', '', '', 0, 1, 0, 1663898644, 1663898644);
INSERT INTO `la_system_menu` VALUES (109, 107, 'A', '详情', '', 0, 'notice.sms_config/detail', '', '', '', '', 0, 1, 0, 1663898661, 1663898661);
INSERT INTO `la_system_menu` VALUES (110, 28, 'C', '热门搜索', 'el-icon-Search', 60, 'setting.hot_search/getConfig', 'search', 'setting/search/index', '', '', 0, 0, 1, 1663901821, 1764579584);
INSERT INTO `la_system_menu` VALUES (111, 110, 'A', '保存', '', 0, 'setting.hot_search/setConfig', '', '', '', '', 0, 1, 0, 1663901856, 1663901856);
INSERT INTO `la_system_menu` VALUES (112, 28, 'M', '用户设置', 'local-icon-keziyuyue', 90, '', 'user', '', '', '', 0, 1, 0, 1663903302, 1710473056);
INSERT INTO `la_system_menu` VALUES (113, 112, 'C', '用户设置', '', 0, 'setting.user.user/getConfig', 'setup', 'setting/user/setup', '', '', 0, 1, 0, 1663903506, 1663903506);
INSERT INTO `la_system_menu` VALUES (114, 113, 'A', '保存', '', 0, 'setting.user.user/setConfig', '', '', '', '', 0, 1, 0, 1663903522, 1663903522);
INSERT INTO `la_system_menu` VALUES (115, 112, 'C', '登录注册', '', 0, 'setting.user.user/getRegisterConfig', 'login_register', 'setting/user/login_register', '', '', 0, 1, 0, 1663903832, 1663903832);
INSERT INTO `la_system_menu` VALUES (116, 115, 'A', '保存', '', 0, 'setting.user.user/setRegisterConfig', '', '', '', '', 0, 1, 0, 1663903852, 1663903852);
INSERT INTO `la_system_menu` VALUES (117, 0, 'M', '用户管理', 'el-icon-User', 900, '', 'consumer', '', '', '', 0, 1, 0, 1663904351, 1710472074);
INSERT INTO `la_system_menu` VALUES (118, 117, 'C', '用户列表', 'local-icon-user_guanli', 100, 'user.user/lists', 'lists', 'consumer/lists/index', '', '', 0, 0, 1, 1663904392, 1762856271);
INSERT INTO `la_system_menu` VALUES (119, 117, 'C', '用户详情', '', 90, 'user.user/detail', 'lists/detail', 'consumer/lists/detail', '/consumer/lists', '', 0, 0, 1, 1663904470, 1762856277);
INSERT INTO `la_system_menu` VALUES (120, 119, 'A', '编辑', '', 0, 'user.user/edit', '', '', '', '', 0, 1, 0, 1663904499, 1663904499);
INSERT INTO `la_system_menu` VALUES (140, 82, 'C', '微信开发平台', 'local-icon-notice_buyer', 70, 'channel.open_setting/getConfig', 'open_setting', 'channel/open_setting', '', '', 0, 1, 0, 1666085713, 1710472951);
INSERT INTO `la_system_menu` VALUES (141, 140, 'A', '保存', '', 0, 'channel.open_setting/setConfig', '', '', '', '', 0, 1, 0, 1666085751, 1666085776);
INSERT INTO `la_system_menu` VALUES (142, 176, 'C', 'PC端装修', 'el-icon-Monitor', 8, '', 'pc', 'decoration/pc', '', '', 0, 1, 0, 1668423284, 1710901602);
INSERT INTO `la_system_menu` VALUES (143, 35, 'C', '定时任务', '', 100, 'crontab.crontab/lists', 'scheduled_task', 'setting/system/scheduled_task/index', '', '', 0, 1, 0, 1669357509, 1710473246);
INSERT INTO `la_system_menu` VALUES (144, 35, 'C', '定时任务添加/编辑', '', 0, 'crontab.crontab/add:edit', 'scheduled_task/edit', 'setting/system/scheduled_task/edit', '/setting/system/scheduled_task', '', 0, 0, 0, 1669357670, 1669357765);
INSERT INTO `la_system_menu` VALUES (145, 143, 'A', '添加', '', 0, 'crontab.crontab/add', '', '', '', '', 0, 1, 0, 1669358282, 1669358282);
INSERT INTO `la_system_menu` VALUES (146, 143, 'A', '编辑', '', 0, 'crontab.crontab/edit', '', '', '', '', 0, 1, 0, 1669358303, 1669358303);
INSERT INTO `la_system_menu` VALUES (147, 143, 'A', '删除', '', 0, 'crontab.crontab/delete', '', '', '', '', 0, 1, 0, 1669358334, 1669358334);
INSERT INTO `la_system_menu` VALUES (148, 0, 'M', '模板示例', 'el-icon-SetUp', 100, '', 'template', '', '', '', 0, 0, 1, 1670206819, 1762859562);
INSERT INTO `la_system_menu` VALUES (149, 148, 'M', '组件示例', 'el-icon-Coin', 0, '', 'component', '', '', '', 0, 1, 0, 1670207182, 1670207244);
INSERT INTO `la_system_menu` VALUES (150, 149, 'C', '富文本', '', 90, '', 'rich_text', 'template/component/rich_text', '', '', 0, 1, 0, 1670207751, 1710473315);
INSERT INTO `la_system_menu` VALUES (151, 149, 'C', '上传文件', '', 80, '', 'upload', 'template/component/upload', '', '', 0, 1, 0, 1670208925, 1710473322);
INSERT INTO `la_system_menu` VALUES (152, 149, 'C', '图标', '', 100, '', 'icon', 'template/component/icon', '', '', 0, 1, 0, 1670230069, 1710473306);
INSERT INTO `la_system_menu` VALUES (153, 149, 'C', '文件选择器', '', 60, '', 'file', 'template/component/file', '', '', 0, 1, 0, 1670232129, 1710473341);
INSERT INTO `la_system_menu` VALUES (154, 149, 'C', '链接选择器', '', 50, '', 'link', 'template/component/link', '', '', 0, 1, 0, 1670292636, 1710473346);
INSERT INTO `la_system_menu` VALUES (155, 149, 'C', '超出自动打点', '', 40, '', 'overflow', 'template/component/overflow', '', '', 0, 1, 0, 1670292883, 1710473351);
INSERT INTO `la_system_menu` VALUES (156, 149, 'C', '悬浮input', '', 70, '', 'popover_input', 'template/component/popover_input', '', '', 0, 1, 0, 1670293336, 1710473329);
INSERT INTO `la_system_menu` VALUES (157, 119, 'A', '余额调整', '', 0, 'user.user/adjustMoney', '', '', '', '', 0, 1, 0, 1677143088, 1677143088);
INSERT INTO `la_system_menu` VALUES (158, 0, 'M', '运营管理', 'el-icon-Postcard', 800, '', 'app', '', '', '', 0, 1, 0, 1677143430, 1762857030);
INSERT INTO `la_system_menu` VALUES (159, 158, 'C', '用户充值', 'local-icon-fukuan', 100, 'recharge.recharge/getConfig', 'recharge', 'app/recharge/index', '', '', 0, 1, 0, 1677144284, 1710471860);
INSERT INTO `la_system_menu` VALUES (160, 159, 'A', '保存', '', 0, 'recharge.recharge/setConfig', '', '', '', '', 0, 1, 0, 1677145012, 1677145012);
INSERT INTO `la_system_menu` VALUES (161, 28, 'M', '支付设置', 'local-icon-set_pay', 80, '', 'pay', '', '', '', 0, 1, 0, 1677148075, 1710473061);
INSERT INTO `la_system_menu` VALUES (162, 161, 'C', '支付方式', '', 0, 'setting.pay.pay_way/getPayWay', 'method', 'setting/pay/method/index', '', '', 0, 1, 0, 1677148207, 1677148207);
INSERT INTO `la_system_menu` VALUES (163, 161, 'C', '支付配置', '', 0, 'setting.pay.pay_config/lists', 'config', 'setting/pay/config/index', '', '', 0, 1, 0, 1677148260, 1677148374);
INSERT INTO `la_system_menu` VALUES (164, 162, 'A', '设置支付方式', '', 0, 'setting.pay.pay_way/setPayWay', '', '', '', '', 0, 1, 0, 1677219624, 1677219624);
INSERT INTO `la_system_menu` VALUES (165, 163, 'A', '配置', '', 0, 'setting.pay.pay_config/setConfig', '', '', '', '', 0, 1, 0, 1677219655, 1677219655);
INSERT INTO `la_system_menu` VALUES (166, 158, 'M', '财务管理', 'local-icon-user_gaikuang', 700, '', 'finance', '', '', '', 0, 1, 0, 1677552269, 1762857060);
INSERT INTO `la_system_menu` VALUES (167, 166, 'C', '充值记录', 'el-icon-Wallet', 90, 'recharge.recharge/lists', 'recharge_record', 'finance/recharge_record', '', '', 0, 1, 0, 1677552757, 1710472902);
INSERT INTO `la_system_menu` VALUES (168, 166, 'C', '余额明细', 'local-icon-qianbao', 100, 'finance.account_log/lists', 'balance_details', 'finance/balance_details', '', '', 0, 1, 0, 1677552976, 1710472894);
INSERT INTO `la_system_menu` VALUES (169, 167, 'A', '退款', '', 0, 'recharge.recharge/refund', '', '', '', '', 0, 1, 0, 1677809715, 1677809715);
INSERT INTO `la_system_menu` VALUES (170, 166, 'C', '退款记录', 'local-icon-heshoujilu', 0, 'finance.refund/record', 'refund_record', 'finance/refund_record', '', '', 0, 1, 0, 1677811271, 1677811271);
INSERT INTO `la_system_menu` VALUES (171, 170, 'A', '重新退款', '', 0, 'recharge.recharge/refundAgain', '', '', '', '', 0, 1, 0, 1677811295, 1677811295);
INSERT INTO `la_system_menu` VALUES (172, 170, 'A', '退款日志', '', 0, 'finance.refund/log', '', '', '', '', 0, 1, 0, 1677811361, 1677811361);
INSERT INTO `la_system_menu` VALUES (173, 175, 'C', '系统风格', 'el-icon-Brush', 80, '', 'style', 'decoration/style/style', '', '', 0, 1, 0, 1681635044, 1710929278);
INSERT INTO `la_system_menu` VALUES (175, 96, 'M', '移动端', '', 100, '', 'mobile', '', '', '', 0, 1, 0, 1710901543, 1710929294);
INSERT INTO `la_system_menu` VALUES (176, 96, 'M', 'PC端', '', 90, '', 'pc', '', '', '', 0, 1, 0, 1710901592, 1710929299);
INSERT INTO `la_system_menu` VALUES (177, 29, 'C', '站点统计', '', 0, 'setting.web.web_setting/getSiteStatistics', 'statistics', 'setting/website/statistics', '', '', 0, 1, 0, 1726841481, 1726843434);
INSERT INTO `la_system_menu` VALUES (178, 177, 'A', '保存', '', 0, 'setting.web.web_setting/saveSiteStatistics', '', '', '', '', 1, 1, 0, 1726841507, 1726841507);
INSERT INTO `la_system_menu` VALUES (181, 117, 'C', '用户列表', 'el-icon-User', 1, 'haosns_user/lists', 'haosns_user', 'haosns_user/index', '', '', 0, 1, 0, 1762844683, 1762856335);
INSERT INTO `la_system_menu` VALUES (182, 181, 'A', '添加', '', 1, 'haosns_user/add', '', '', '', '', 0, 1, 0, 1762844683, 1762844683);
INSERT INTO `la_system_menu` VALUES (183, 181, 'A', '编辑', '', 1, 'haosns_user/edit', '', '', '', '', 0, 1, 0, 1762844683, 1762844683);
INSERT INTO `la_system_menu` VALUES (184, 181, 'A', '删除', '', 1, 'haosns_user/delete', '', '', '', '', 0, 1, 0, 1762844683, 1762844683);
INSERT INTO `la_system_menu` VALUES (185, 193, 'C', '帖子管理', 'el-icon-Notebook', 0, 'haosns_article/lists', 'haosns_article', 'haosns_article/index', '', '', 0, 1, 0, 1762844708, 1762856170);
INSERT INTO `la_system_menu` VALUES (186, 185, 'A', '添加', '', 1, 'haosns_article/add', '', '', '', '', 0, 1, 0, 1762844708, 1762844708);
INSERT INTO `la_system_menu` VALUES (187, 185, 'A', '编辑', '', 1, 'haosns_article/edit', '', '', '', '', 0, 1, 0, 1762844708, 1762844708);
INSERT INTO `la_system_menu` VALUES (188, 185, 'A', '删除', '', 1, 'haosns_article/delete', '', '', '', '', 0, 1, 0, 1762844708, 1762844708);
INSERT INTO `la_system_menu` VALUES (189, 193, 'C', '帖子评论', 'el-icon-ChatDotSquare', 0, 'haosns_article_comment/lists', 'haosns_article_comment', 'haosns_article_comment/index', '', '', 0, 1, 0, 1762844767, 1763195009);
INSERT INTO `la_system_menu` VALUES (190, 189, 'A', '添加', '', 1, 'haosns_article_comment/add', '', '', '', '', 0, 1, 0, 1762844767, 1762844767);
INSERT INTO `la_system_menu` VALUES (191, 189, 'A', '编辑', '', 1, 'haosns_article_comment/edit', '', '', '', '', 0, 1, 0, 1762844767, 1762844767);
INSERT INTO `la_system_menu` VALUES (192, 189, 'A', '删除', '', 1, 'haosns_article_comment/delete', '', '', '', '', 0, 1, 0, 1762844767, 1762844767);
INSERT INTO `la_system_menu` VALUES (193, 0, 'M', '内容管理', 'el-icon-Collection', 901, 'haosns_circle/lists', 'haosns_content', 'haosns_circle/index', '', '', 0, 1, 0, 1762844777, 1762858934);
INSERT INTO `la_system_menu` VALUES (194, 197, 'A', '添加', '', 1, 'haosns_circle/add', '', '', '', '', 0, 1, 0, 1762844777, 1762855868);
INSERT INTO `la_system_menu` VALUES (195, 197, 'A', '编辑', '', 1, 'haosns_circle/edit', '', '', '', '', 0, 1, 0, 1762844777, 1762855875);
INSERT INTO `la_system_menu` VALUES (196, 197, 'A', '删除', '', 1, 'haosns_circle/delete', '', '', '', '', 0, 1, 0, 1762844777, 1762855881);
INSERT INTO `la_system_menu` VALUES (197, 193, 'C', '圈子管理', 'el-icon-Aim', 1, '', 'haosns_circle', 'haosns_circle/index', '', '', 0, 1, 0, 1762855801, 1762856198);
INSERT INTO `la_system_menu` VALUES (198, 193, 'C', '圈子分类', 'el-icon-Coin', 2, '', 'content', 'haosns_circle_cate/index', '', '', 0, 1, 0, 1762855951, 1762864981);
INSERT INTO `la_system_menu` VALUES (199, 193, 'C', '话题管理', 'el-icon-Paperclip', 0, '', 'tag', 'error/404', '', '', 0, 1, 0, 1762856084, 1762856084);
INSERT INTO `la_system_menu` VALUES (200, 117, 'C', '用户等级', 'el-icon-User', 0, '', 'manage', 'error/404', '', '', 0, 0, 1, 1762856444, 1764579401);
INSERT INTO `la_system_menu` VALUES (201, 117, 'C', '会员等级', 'el-icon-CollectionTag', 0, '', 'vipList', 'error/404', '', '', 0, 1, 1, 1762856720, 1764572760);
INSERT INTO `la_system_menu` VALUES (202, 117, 'C', '会员套餐', 'el-icon-Bell', 0, '', 'vipOrder', 'error/404', '', '', 0, 1, 1, 1762856783, 1764572778);
INSERT INTO `la_system_menu` VALUES (203, 117, 'C', '个性标签分类', 'el-icon-Coin', 0, '', 'selfTag', 'error/404', '', '', 0, 1, 1, 1762856869, 1764572801);
INSERT INTO `la_system_menu` VALUES (204, 0, 'M', '群组管理', 'el-icon-User', 799, '', 'group', '', '', '', 1, 1, 1, 1762859001, 1764569055);
INSERT INTO `la_system_menu` VALUES (205, 204, 'C', '群分类', 'el-icon-CopyDocument', 0, '', 'type', 'error/404', '', '', 0, 1, 0, 1762859211, 1762859360);
INSERT INTO `la_system_menu` VALUES (206, 204, 'C', '群标签', 'el-icon-CollectionTag', 0, '', 'tag', 'error/404', '', '', 0, 1, 0, 1762859262, 1762859262);
INSERT INTO `la_system_menu` VALUES (207, 204, 'C', '群列表', 'el-icon-Expand', 0, '', 'list', 'error/404', '', '', 0, 1, 0, 1762859299, 1762859373);
INSERT INTO `la_system_menu` VALUES (208, 0, 'M', '界面管理', 'el-icon-Camera', 790, '', 'view', '', '', '', 1, 1, 0, 1762859627, 1762859659);
INSERT INTO `la_system_menu` VALUES (209, 208, 'C', '轮播图', 'el-icon-DataAnalysis', 0, '', 'images', 'haosns-banner/list', '', '', 0, 1, 0, 1762859754, 1762907460);
INSERT INTO `la_system_menu` VALUES (210, 208, 'C', '导航按钮', 'el-icon-FolderAdd', 0, '', 'position', 'haosns_nav_button/list', '', '', 0, 1, 0, 1762859811, 1762916115);
INSERT INTO `la_system_menu` VALUES (211, 208, 'C', '底部菜单', 'el-icon-DocumentCopy', 0, '', 'bottom', 'error/404', '', '', 0, 1, 1, 1762859858, 1764569194);
INSERT INTO `la_system_menu` VALUES (212, 208, 'M', '表情包设置', 'el-icon-Setting', 0, '', 'emoji', '', '', '', 1, 1, 0, 1762859912, 1762859912);
INSERT INTO `la_system_menu` VALUES (213, 212, 'C', '表情包类型', 'el-icon-CollectionTag', 0, '', 'type', 'haosns_emo_category/index', '', '', 0, 1, 0, 1762859943, 1763637661);
INSERT INTO `la_system_menu` VALUES (214, 212, 'C', '表情包列表', 'el-icon-Compass', 0, '', 'upload', 'haosns_emo_image/index', '', '', 0, 1, 0, 1762859987, 1763637799);
INSERT INTO `la_system_menu` VALUES (215, 208, 'M', '模板设置', 'el-icon-Notebook', 0, '', 'template', '', '', '', 1, 0, 1, 1762860031, 1764579458);
INSERT INTO `la_system_menu` VALUES (216, 215, 'C', '首页模板', 'el-icon-Guide', 0, '', 'index', 'error/404', '', '', 1, 1, 0, 1762860128, 1762860128);
INSERT INTO `la_system_menu` VALUES (217, 215, 'M', '用户模板', 'el-icon-User', 0, '', 'user', '', '', '', 1, 1, 0, 1762860160, 1762860160);
INSERT INTO `la_system_menu` VALUES (218, 215, 'C', '分类模板', 'el-icon-Coin', 0, '', 'type', 'error/404', '', '', 0, 1, 0, 1762860206, 1762860206);
INSERT INTO `la_system_menu` VALUES (219, 0, 'C', '圈子分类表', '', 1, 'haosns_circle_cate/lists', 'haosns_circle_cate', 'haosns_circle_cate/index', '', '', 0, 0, 1, 1762864439, 1762865498);
INSERT INTO `la_system_menu` VALUES (220, 219, 'A', '添加', '', 1, 'haosns_circle_cate/add', '', '', '', '', 0, 1, 0, 1762864439, 1762864439);
INSERT INTO `la_system_menu` VALUES (221, 219, 'A', '编辑', '', 1, 'haosns_circle_cate/edit', '', '', '', '', 0, 1, 0, 1762864439, 1762864439);
INSERT INTO `la_system_menu` VALUES (222, 219, 'A', '删除', '', 1, 'haosns_circle_cate/delete', '', '', '', '', 0, 1, 0, 1762864439, 1762864439);
INSERT INTO `la_system_menu` VALUES (223, 0, 'C', '轮播图表', '', 1, 'haosns_banner/lists', 'haosns_banner', 'haosns_banner/index', '', '', 0, 0, 1, 1762926325, 1762928544);
INSERT INTO `la_system_menu` VALUES (224, 223, 'A', '添加', '', 1, 'haosns_banner/add', '', '', '', '', 0, 1, 0, 1762926325, 1762926325);
INSERT INTO `la_system_menu` VALUES (225, 223, 'A', '编辑', '', 1, 'haosns_banner/edit', '', '', '', '', 0, 1, 0, 1762926325, 1762926325);
INSERT INTO `la_system_menu` VALUES (226, 223, 'A', '删除', '', 1, 'haosns_banner/delete', '', '', '', '', 0, 1, 0, 1762926325, 1762926325);
INSERT INTO `la_system_menu` VALUES (227, 0, 'C', '导航栏表', '', 1, 'haosns_nav/lists', 'haosns_nav', 'haosns_nav/index', '', '', 0, 0, 1, 1762926366, 1762928574);
INSERT INTO `la_system_menu` VALUES (228, 227, 'A', '添加', '', 1, 'haosns_nav/add', '', '', '', '', 0, 1, 0, 1762926366, 1762926366);
INSERT INTO `la_system_menu` VALUES (229, 227, 'A', '编辑', '', 1, 'haosns_nav/edit', '', '', '', '', 0, 1, 0, 1762926366, 1762926366);
INSERT INTO `la_system_menu` VALUES (230, 227, 'A', '删除', '', 1, 'haosns_nav/delete', '', '', '', '', 0, 1, 0, 1762926366, 1762926366);
INSERT INTO `la_system_menu` VALUES (231, 112, 'C', '登录背景设置', '', 0, '', 'background', 'setting/user/login_background', '', '', 0, 1, 0, 1762942423, 1762942451);
INSERT INTO `la_system_menu` VALUES (232, 28, 'M', '文章设置', 'el-icon-Notebook', 0, '', 'article', '', '', '', 1, 1, 0, 1762948910, 1762948910);
INSERT INTO `la_system_menu` VALUES (233, 232, 'C', '文章设置', '', 0, '', 'articleSetting', 'setting/article/setting', '', '', 0, 1, 0, 1762948984, 1762948984);
INSERT INTO `la_system_menu` VALUES (234, 28, 'M', '通知设置', 'el-icon-ChatDotRound', 0, '', 'talk', '', '', '', 1, 1, 0, 1762951719, 1762951719);
INSERT INTO `la_system_menu` VALUES (235, 234, 'C', '通知设置', '', 0, '', 'setting', 'setting/notice/setting', '', '', 0, 1, 0, 1762951909, 1762993452);
INSERT INTO `la_system_menu` VALUES (236, 0, 'C', '话题表', '', 1, 'haosns_topic/lists', 'haosns_topic', 'haosns_topic/index', '', '', 0, 0, 1, 1763186178, 1763195150);
INSERT INTO `la_system_menu` VALUES (237, 236, 'A', '添加', '', 1, 'haosns_topic/add', '', '', '', '', 0, 1, 0, 1763186178, 1763186178);
INSERT INTO `la_system_menu` VALUES (238, 236, 'A', '编辑', '', 1, 'haosns_topic/edit', '', '', '', '', 0, 1, 0, 1763186178, 1763186178);
INSERT INTO `la_system_menu` VALUES (239, 236, 'A', '删除', '', 1, 'haosns_topic/delete', '', '', '', '', 0, 1, 0, 1763186178, 1763186178);
INSERT INTO `la_system_menu` VALUES (240, 0, 'C', '话题帖子关联表', '', 1, 'haosns_topic_article/lists', 'haosns_topic_article', 'haosns_topic_article/index', '', '', 0, 0, 1, 1763186286, 1763195155);
INSERT INTO `la_system_menu` VALUES (241, 240, 'A', '添加', '', 1, 'haosns_topic_article/add', '', '', '', '', 0, 1, 0, 1763186286, 1763186286);
INSERT INTO `la_system_menu` VALUES (242, 240, 'A', '编辑', '', 1, 'haosns_topic_article/edit', '', '', '', '', 0, 1, 0, 1763186286, 1763186286);
INSERT INTO `la_system_menu` VALUES (243, 240, 'A', '删除', '', 1, 'haosns_topic_article/delete', '', '', '', '', 0, 1, 0, 1763186286, 1763186286);
INSERT INTO `la_system_menu` VALUES (244, 199, 'C', '话题列表', '', 0, '', 'topicList', 'haosns_topic/index', '', '', 0, 1, 0, 1763195069, 1763195069);
INSERT INTO `la_system_menu` VALUES (245, 199, 'C', '话题关联管理', '', 0, '', 'topicMore', 'haosns_topic_article/index', '', '', 0, 1, 0, 1763195119, 1763195119);
INSERT INTO `la_system_menu` VALUES (246, 0, 'C', '圈子子分类表', '', 1, 'haosns_circle_sub_category/lists', 'haosns_circle_sub_category', 'haosns_circle_sub_category/index', '', '', 0, 0, 1, 1763206343, 1763207104);
INSERT INTO `la_system_menu` VALUES (247, 246, 'A', '添加', '', 1, 'haosns_circle_sub_category/add', '', '', '', '', 0, 1, 0, 1763206343, 1763206343);
INSERT INTO `la_system_menu` VALUES (248, 246, 'A', '编辑', '', 1, 'haosns_circle_sub_category/edit', '', '', '', '', 0, 1, 0, 1763206343, 1763206343);
INSERT INTO `la_system_menu` VALUES (249, 246, 'A', '删除', '', 1, 'haosns_circle_sub_category/delete', '', '', '', '', 0, 1, 0, 1763206343, 1763206343);
INSERT INTO `la_system_menu` VALUES (250, 193, 'C', '圈子子分类', 'el-icon-Document', 0, '', 'subCIrcle', 'haosns_circle_sub_category/index', '', '', 0, 1, 0, 1763207094, 1763207094);
INSERT INTO `la_system_menu` VALUES (251, 0, 'C', '表情分类表', '', 1, 'haosns_emo_category/lists', 'haosns_emo_category', 'haosns_emo_category/index', '', '', 0, 0, 1, 1763292666, 1763637689);
INSERT INTO `la_system_menu` VALUES (252, 251, 'A', '添加', '', 1, 'haosns_emo_category/add', '', '', '', '', 0, 1, 0, 1763292666, 1763292666);
INSERT INTO `la_system_menu` VALUES (253, 251, 'A', '编辑', '', 1, 'haosns_emo_category/edit', '', '', '', '', 0, 1, 0, 1763292666, 1763292666);
INSERT INTO `la_system_menu` VALUES (254, 251, 'A', '删除', '', 1, 'haosns_emo_category/delete', '', '', '', '', 0, 1, 0, 1763292666, 1763292666);
INSERT INTO `la_system_menu` VALUES (255, 0, 'C', '自定义表情图片', '', 1, 'haosns_emo_image/lists', 'haosns_emo_image', 'haosns_emo_image/index', '', '', 0, 0, 1, 1763292703, 1763637695);
INSERT INTO `la_system_menu` VALUES (256, 255, 'A', '添加', '', 1, 'haosns_emo_image/add', '', '', '', '', 0, 1, 0, 1763292703, 1763292703);
INSERT INTO `la_system_menu` VALUES (257, 255, 'A', '编辑', '', 1, 'haosns_emo_image/edit', '', '', '', '', 0, 1, 0, 1763292703, 1763292703);
INSERT INTO `la_system_menu` VALUES (258, 255, 'A', '删除', '', 1, 'haosns_emo_image/delete', '', '', '', '', 0, 1, 0, 1763292703, 1763292703);
INSERT INTO `la_system_menu` VALUES (259, 28, 'C', '地图配置', 'el-icon-MapLocation', 0, '', 'mapSetting', 'setting/map/setting', '', '', 0, 1, 0, 1763378371, 1763378371);
INSERT INTO `la_system_menu` VALUES (260, 28, 'C', '圈子设置', 'el-icon-ChatLineSquare', 0, '', 'circleSetting', 'setting/circle/setting', '', '', 0, 1, 0, 1764202490, 1764203199);
INSERT INTO `la_system_menu` VALUES (261, 0, 'C', '在线更新', 'el-icon-Promotion', 0, '', 'update', 'workbench/update', '', '', 0, 1, 0, 1764573867, 1764573902);

-- ----------------------------
-- Table structure for la_system_role
-- ----------------------------
DROP TABLE IF EXISTS `la_system_role`;
CREATE TABLE `la_system_role`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '名称',
  `desc` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '描述',
  `sort` int(11) NULL DEFAULT 0 COMMENT '排序',
  `create_time` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_system_role
-- ----------------------------
INSERT INTO `la_system_role` VALUES (1, 'admin', '', 0, 1762844466, 1762844466, NULL);

-- ----------------------------
-- Table structure for la_system_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `la_system_role_menu`;
CREATE TABLE `la_system_role_menu`  (
  `role_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '角色ID',
  `menu_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色菜单关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_system_role_menu
-- ----------------------------

-- ----------------------------
-- Table structure for la_user
-- ----------------------------
DROP TABLE IF EXISTS `la_user`;
CREATE TABLE `la_user`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `sn` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '编号',
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '头像',
  `real_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '真实姓名',
  `nickname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `account` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户账号',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户密码',
  `mobile` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户电话',
  `sex` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户性别: [1=男, 2=女]',
  `channel` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '注册渠道: [1-微信小程序 2-微信公众号 3-手机H5 4-电脑PC 5-苹果APP 6-安卓APP]',
  `is_disable` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否禁用: [0=否, 1=是]',
  `login_ip` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '最后登录IP',
  `login_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最后登录时间',
  `is_new_user` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否是新注册用户: [1-是, 0-否]',
  `user_money` decimal(10, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '用户余额',
  `total_recharge_amount` decimal(10, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '累计充值',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `delete_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sn`(`sn`) USING BTREE COMMENT '编号唯一',
  UNIQUE INDEX `account`(`account`) USING BTREE COMMENT '账号唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_user
-- ----------------------------

-- ----------------------------
-- Table structure for la_user_account_log
-- ----------------------------
DROP TABLE IF EXISTS `la_user_account_log`;
CREATE TABLE `la_user_account_log`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sn` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '流水号',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `change_object` tinyint(1) NOT NULL DEFAULT 0 COMMENT '变动对象',
  `change_type` smallint(5) NOT NULL COMMENT '变动类型',
  `action` tinyint(1) NOT NULL DEFAULT 0 COMMENT '动作 1-增加 2-减少',
  `change_amount` decimal(10, 2) NOT NULL COMMENT '变动数量',
  `left_amount` decimal(10, 2) NOT NULL DEFAULT 100.00 COMMENT '变动后数量',
  `source_sn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联单号',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `extra` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '预留扩展字段',
  `create_time` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(10) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_user_account_log
-- ----------------------------

-- ----------------------------
-- Table structure for la_user_auth
-- ----------------------------
DROP TABLE IF EXISTS `la_user_auth`;
CREATE TABLE `la_user_auth`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `openid` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '微信openid',
  `unionid` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '微信unionid',
  `terminal` tinyint(1) NOT NULL DEFAULT 1 COMMENT '客户端类型：1-微信小程序；2-微信公众号；3-手机H5；4-电脑PC；5-苹果APP；6-安卓APP',
  `create_time` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `openid`(`openid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户授权表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_user_auth
-- ----------------------------

-- ----------------------------
-- Table structure for la_user_session
-- ----------------------------
DROP TABLE IF EXISTS `la_user_session`;
CREATE TABLE `la_user_session`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `terminal` tinyint(1) NOT NULL DEFAULT 1 COMMENT '客户端类型：1-微信小程序；2-微信公众号；3-手机H5；4-电脑PC；5-苹果APP；6-安卓APP',
  `token` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '令牌',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `expire_time` int(10) NOT NULL COMMENT '到期时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `admin_id_client`(`user_id`, `terminal`) USING BTREE COMMENT '一个用户在一个终端只有一个token',
  UNIQUE INDEX `token`(`token`) USING BTREE COMMENT 'token是唯一的'
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户会话表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of la_user_session
-- ----------------------------
INSERT INTO `la_user_session` VALUES (1, 1, 3, 'f6a49afc34ffc397587b3e5e0599f75f', 1762520847, 1762549647);
INSERT INTO `la_user_session` VALUES (2, 3, 2, '68bf4b83668e1f292c764858915207b7', 1763017804, 1763046604);
INSERT INTO `la_user_session` VALUES (3, 6, 2, '3be9482b34f91c57300b01947ac5d778', 1763300394, 1763329194);

SET FOREIGN_KEY_CHECKS = 1;
