/*
 Navicat Premium Data Transfer

 Source Server         : ATuan
 Source Server Type    : MySQL
 Source Server Version : 80403 (8.4.3)
 Source Host           : localhost:3306
 Source Schema         : lootplay

 Target Server Type    : MySQL
 Target Server Version : 80403 (8.4.3)
 File Encoding         : 65001

 Date: 05/10/2026 10:03:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cache
-- ----------------------------
DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`) USING BTREE,
  INDEX `cache_expiration_index`(`expiration` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cache
-- ----------------------------

-- ----------------------------
-- Table structure for cache_locks
-- ----------------------------
DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`) USING BTREE,
  INDEX `cache_locks_expiration_index`(`expiration` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cache_locks
-- ----------------------------

-- ----------------------------
-- Table structure for cart_items
-- ----------------------------
DROP TABLE IF EXISTS `cart_items`;
CREATE TABLE `cart_items`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `cart_id` bigint UNSIGNED NOT NULL,
  `game_id` bigint UNSIGNED NOT NULL,
  `quantity` int NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `cart_items_cart_id_game_id_unique`(`cart_id` ASC, `game_id` ASC) USING BTREE,
  INDEX `cart_items_game_id_foreign`(`game_id` ASC) USING BTREE,
  CONSTRAINT `cart_items_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `cart_items_game_id_foreign` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cart_items
-- ----------------------------
INSERT INTO `cart_items` VALUES (2, 2, 1, 20, '2026-09-24 06:10:07', '2026-09-24 09:35:37');

-- ----------------------------
-- Table structure for carts
-- ----------------------------
DROP TABLE IF EXISTS `carts`;
CREATE TABLE `carts`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `carts_user_id_unique`(`user_id` ASC) USING BTREE,
  CONSTRAINT `carts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of carts
-- ----------------------------
INSERT INTO `carts` VALUES (1, 1, '2026-09-23 17:30:52', '2026-09-23 17:30:52');
INSERT INTO `carts` VALUES (2, 2, '2026-09-24 06:10:07', '2026-09-24 06:10:07');
INSERT INTO `carts` VALUES (3, 3, '2026-10-04 06:07:59', '2026-10-04 06:07:59');

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, 'Action', 'Game hành động', '2026-09-23 17:05:44', '2026-09-23 17:05:44');
INSERT INTO `categories` VALUES (2, 'RPG', 'Game nhập vai', '2026-09-23 17:05:44', '2026-09-23 17:05:44');
INSERT INTO `categories` VALUES (3, 'Racing', 'Game đua xe', '2026-09-23 17:05:44', '2026-09-23 17:05:44');
INSERT INTO `categories` VALUES (4, 'Sports', 'Game thể thao', '2026-09-23 17:05:44', '2026-09-23 17:05:44');

-- ----------------------------
-- Table structure for game_images
-- ----------------------------
DROP TABLE IF EXISTS `game_images`;
CREATE TABLE `game_images`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `game_id` bigint UNSIGNED NOT NULL,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_primary` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `game_images_game_id_foreign`(`game_id` ASC) USING BTREE,
  CONSTRAINT `game_images_game_id_foreign` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of game_images
-- ----------------------------
INSERT INTO `game_images` VALUES (1, 1, 'https://i.postimg.cc/GpzFjdgH/6bbde3a78c180b4ba5e3efc6000ecf62.webp', 1, '2026-09-23 17:05:44', '2026-09-23 17:05:44');
INSERT INTO `game_images` VALUES (2, 2, 'https://i.postimg.cc/G2BgHXdT/helltaker.jpg', 1, '2026-09-23 17:05:44', '2026-09-23 17:05:44');
INSERT INTO `game_images` VALUES (3, 3, 'https://i.postimg.cc/HxJvV6d7/92236-Helltaker-Bonus-Chapter-Examtaker.webp', 1, '2026-09-23 17:05:44', '2026-09-23 17:05:44');
INSERT INTO `game_images` VALUES (4, 4, 'https://i.postimg.cc/PxLVPSTZ/deltarune.webp', 1, '2026-09-23 17:05:44', '2026-09-23 17:05:44');
INSERT INTO `game_images` VALUES (5, 5, 'https://i.postimg.cc/fL3qJ8Dm/Pokemon-Heartgold-and-Soulsilver.webp', 1, '2026-09-27 15:05:05', '2026-09-27 15:05:08');
INSERT INTO `game_images` VALUES (6, 6, 'https://i.postimg.cc/YCTB8L09/yu.jpg', 1, '2026-09-27 15:42:58', '2026-09-27 15:43:04');
INSERT INTO `game_images` VALUES (7, 7, 'https://i.postimg.cc/Vkr3Ssg6/cuphead.jpg', 1, '2026-09-27 15:43:01', '2026-09-27 15:43:07');
INSERT INTO `game_images` VALUES (8, 8, 'https://i.postimg.cc/fbsBwMr4/raven.jpg', 1, '2026-09-27 15:43:10', '2026-09-27 15:43:12');
INSERT INTO `game_images` VALUES (9, 9, 'https://i.postimg.cc/bNM5jcPs/paper.png', 1, '2026-09-27 15:43:15', '2026-09-27 15:43:17');
INSERT INTO `game_images` VALUES (10, 10, 'https://i.postimg.cc/XvK1FrCV/lich-Trinh.jpg', 1, NULL, NULL);

-- ----------------------------
-- Table structure for games
-- ----------------------------
DROP TABLE IF EXISTS `games`;
CREATE TABLE `games`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `price` decimal(12, 2) NOT NULL,
  `stock` int NOT NULL DEFAULT 0,
  `developer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `publisher` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `release_date` date NULL DEFAULT NULL,
  `version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `views` bigint UNSIGNED NOT NULL DEFAULT 0,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `games_category_id_foreign`(`category_id` ASC) USING BTREE,
  CONSTRAINT `games_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of games
-- ----------------------------
INSERT INTO `games` VALUES (1, 2, 'Awaria', 'Chào mừng bạn gia nhập đội bảo trì đường hầm. Nếu máy phát điện gặp sự cố, nhiệm vụ của bạn là sửa chữa chúng. Hãy kiểm tra lỗi, chế tạo các linh kiện cần thiết và mang chúng đến nơi sửa chữa. Mọi việc rất đơn giản. Chỉ cần tránh xa bất cứ thứ gì bất ngờ phóng ra tia điện, phun lửa, bắn các mảnh phế liệu sắc nhọn với tốc độ cao hoặc phát ra ánh sáng xanh lục đầy đe dọa.', 299000.00, 99, 'vanripper', 'LootPlay', '2024-12-17', 'v1.0.0', 1263, 'active', '2026-09-27 17:05:44', '2026-10-04 11:19:50');
INSERT INTO `games` VALUES (2, 2, 'Helltaker', 'Một ngày nọ, bạn thức dậy với một giấc mơ: sở hữu một dàn hậu cung toàn những cô nàng quỷ. Bạn đã mở cánh cổng không gian với hy vọng thỏa mãn những khao khát táo bạo nhất của mình. Lửa địa ngục thiêu đốt buồng phổi, cái chết rình rập khắp mọi ngóc ngách, và mọi thứ trông cứ như bước ra từ một tựa game di động dễ thương vậy. Bạn đang ở địa ngục.', 399000.00, 73, 'vanripper', 'LootPlay', '2020-05-11', 'v1.2.5', 1003, 'active', '2026-09-27 17:05:44', '2026-10-05 02:33:22');
INSERT INTO `games` VALUES (3, 2, 'Exam Taker', 'Examtaker X là phiên bản mở rộng của bản DLC dành cho Helltaker! Nó vẫn giữ lại các màn chơi cũ (từ màn 1 đến màn 7) và bổ sung thêm những màn chơi mới! Nếu chưa chơi, bạn hãy thử trải nghiệm Helltaker ngay nhé! Đây là một tựa game tuyệt vời và xứng đáng nhận được thật nhiều sự yêu mến!', 249000.00, 119, 'vanripper', 'LootPlay', '2021-05-11', 'v2.1.0', 1562, 'active', '2026-09-27 17:05:44', '2026-10-01 14:44:51');
INSERT INTO `games` VALUES (4, 2, 'Deltarune', 'Cuộc phiêu lưu tiếp theo trong loạt game UNDERTALE đã xuất hiện!\r\nHãy chiến đấu (hoặc tha mạng) cùng những nhân vật mới trong câu chuyện song song của UNDERTALE: DELTARUNE...!', 349000.00, 90, 'Toby Fox', 'LootPlay', '2019-10-31', 'v3.0.2', 2104, 'active', '2026-09-27 17:05:44', '2026-09-27 21:51:40');
INSERT INTO `games` VALUES (5, 2, 'Pokemon heart gold version', 'Cùng với Pokémon SoulSilver Version, Pokémon HeartGold Version là phiên bản nâng cấp của game nhập vai  Pokémon Gold và Silver (1999). Đây là thế hệ thứ 4 của series game Pokemon đình đám của nhà Nintendo, cho phép trải nghiệm miễn phí trên Nintendo DS.', 300000.00, 100, 'Game Freak', 'LootPlay', '2009-09-12', 'v1.0.0', 366, 'active', '2026-09-27 15:04:01', '2026-09-27 15:04:05');
INSERT INTO `games` VALUES (6, 2, 'Yu-Gi-Oh! The Legend Reborn', 'Một cuộc đấu tay đôi đầy hoài niệm hiện đại\r\nYu-Gi-Oh! The Legend Reborn mời người chơi đắm mình vào nỗi nhớ của vũ trụ Yu-Gi-Oh! với trải nghiệm chơi bài kỹ thuật số mở rộng. Đưa các bậc thầy đấu bài trở lại thế giới quen thuộc của việc lập chiến lược và xây dựng bộ bài, trò chơi này gói gọn bản chất cạnh tranh đã thúc đẩy sự phổ biến của loạt Yu-Gi-Oh! trong nhiều thập kỷ.\r\nXây dựng bộ bài tối ưu\r\nCốt lõi của Yu-Gi-Oh! The Legend Reborn là hệ thống xây dựng bộ bài toàn diện. Trò chơi tự hào có bộ sưu tập phong phú gồm hơn 1.100 lá bài, bao gồm nhiều loại quái vật trải dài từ những quái vật được người hâm mộ yêu thích mang tính biểu tượng đến những thực thể ít được biết đến nhưng cũng hấp dẫn không kém trong truyền thuyết Yu-Gi-Oh!. Những người chơi kỳ cựu của series sẽ đánh giá cao chiều sâu của sự lựa chọn, cho phép tạo ra các bộ bài được cá nhân hóa cao phù hợp với phong cách chơi và chiến lược của từng người.\r\nĐấu tay đôi với chiến lược và trí tuệ\r\nTrái tim của Yu-Gi-Oh! The Legend Reborn nằm ở các trận chiến của nó. Trò chơi đã làm rất tốt việc tái hiện sự phức tạp của trò chơi bài thực tế, phản ánh tất cả các quy tắc và cơ chế chơi trò chơi đã làm nên thành công của trò chơi vật lý. Cho dù là giao tranh với đối thủ AI hay đấu với bạn bè trong chế độ nhiều người chơi, trò chơi đều thách thức người chơi phải suy nghĩ chiến thuật, dự đoán động thái của đối thủ và thực hiện các chiến lược được cân nhắc kỹ lưỡng.\r\n', 300000.00, 33, 'Team YGO-TLR', 'LootPlay', '2012-01-01', 'v1.0.0', 444, 'active', '2026-09-27 15:28:16', '2026-09-27 15:28:22');
INSERT INTO `games` VALUES (7, 2, 'Cuphead', 'Cuphead là một tựa game hành động platformer 2D với phong cách đồ họa hoạt hình cổ điển những năm 1930, được phát triển bởi Studio MDHR. Người chơi vào vai Cuphead hoặc Mugman, hai anh em bị mắc nợ quỷ dữ và phải tham gia vào các trận đấu với những con boss đầy thử thách để lấy lại linh hồn của mình.\r\nGame nổi bật với lối chơi khó khăn nhưng cực kỳ hấp dẫn, nơi người chơi phải vượt qua hàng loạt màn chơi với các đối thủ mạnh mẽ và các thử thách gian nan. Đồ họa phong cách hoạt hình cổ điển, âm nhạc jazz sôi động, và các chi tiết trang trí trong game mang đến một cảm giác hoài cổ rất đặc biệt. Cuphead yêu cầu sự phản xạ nhanh chóng, chiến thuật và sự kiên nhẫn, với những trận chiến boss đầy thử thách và những pha nhảy qua chướng ngại vật đầy kỹ năng.\r\n', 200000.00, 55, 'Studio MDHR', 'LootPlay', '2017-09-29', 'v1.0.0', 6767, 'active', '2026-09-27 15:31:15', '2026-09-27 15:31:20');
INSERT INTO `games` VALUES (8, 2, 'Ravenfield', 'Ravenfield là một tựa game bắn súng lấy hình ảnh nhật vật là những chú lính sơn. Trong game sẽ có 2 phe và người chơi sẽ cùng những người đồng đội của mình ở phe xanh đi chinh chiến với phe màu đỏ. Tính vật lý trong Ravenfield rất chính xác, cùng sự thông minh đến từ những người đồng đội là \"máy\" của bạn, sẽ giúp bạn trải nghiệm game 1 cách tuyệt vời nhất.', 200000.00, 33, 'SteelRaven7', 'LootPlay', '2017-05-19', 'v1.0.0', 6767, 'active', '2026-09-27 15:33:02', '2026-09-27 15:33:08');
INSERT INTO `games` VALUES (9, 2, 'Papers, Please', 'Không như tên gọi, trong Papers, Please người chơi sẽ phải hoàn thành một nhiệm vụ khá mơ hồ. Bạn phải tiến hành kiểm tra giấy tờ cũng như những câu chuyện mà mỗi đối tượng thêm thắt vào.\r\nNhiệm vụ xuyên suốt Papers, Please của người chơi là kiểm soát biên giới, kiểm tra giấy tờ của người dân trước cho phép hoặc từ chối họ đặt chân vào đất nước mình. Nghe qua thì thực sự không mấy hấp dẫn. Tuy nhiên có hai yếu tố đã khiến Papers, Please không trở thành một game đơn điệu. Trước hết đó là tại một mức độ đơn giản, game dần dần giới thiệu các yếu tố cần thiết mà bạn phải đạt được.\r\nLúc bắt đầu, người chơi chỉ cần kiểm tra xem hộ chiếu của đối tượng chính xác, chưa hết hạn, và ảnh thẻ giống hệt họ. Sau đó các quy tắc mới được thêm vào, chẳng hạn như người nước ngoài cần giấy phép lao động hoặc thị thực nhập cảnh. Các nhà ngoại giao muốn đi vào cũng phải tuân thủ một số các quy tắc khác nhau.\r\nĐôi khi tên của họ không phù hợp và bạn phải thẩm vấn các đối tượng để xem họ đang nói dối hay chỉ là nhầm lẫn. Papers, Please vận hành theo cách khá đơn giản được, nhưng lại cung cấp cho người chơi cảm giác quyền lực nhiều hơn bạn mong đợi. Chẳng bao lâu sau bạn sẽ được tiến hành quét cơ thể để xác định giới tính và kiểm tra dấu vân tay cho các bí danh khác.\r\nKhông như tên gọi, trong Papers, Please người chơi sẽ phải hoàn thành một nhiệm vụ khá mơ hồ. Bạn phải tiến hành kiểm tra giấy tờ cũng như những câu chuyện mà mỗi đối tượng thêm thắt vào.\r\nNhiệm vụ xuyên suốt Papers, Please của người chơi là kiểm soát biên giới, kiểm tra giấy tờ của người dân trước cho phép hoặc từ chối họ đặt chân vào đất nước mình. Nghe qua thì thực sự không mấy hấp dẫn. Tuy nhiên có hai yếu tố đã khiến Papers, Please không trở thành một game đơn điệu. Trước hết đó là tại một mức độ đơn giản, game dần dần giới thiệu các yếu tố cần thiết mà bạn phải đạt được.\r\nLúc bắt đầu, người chơi chỉ cần kiểm tra xem hộ chiếu của đối tượng chính xác, chưa hết hạn, và ảnh thẻ giống hệt họ. Sau đó các quy tắc mới được thêm vào, chẳng hạn như người nước ngoài cần giấy phép lao động hoặc thị thực nhập cảnh. Các nhà ngoại giao muốn đi vào cũng phải tuân thủ một số các quy tắc khác nhau.\r\nĐôi khi tên của họ không phù hợp và bạn phải thẩm vấn các đối tượng để xem họ đang nói dối hay chỉ là nhầm lẫn. Papers, Please vận hành theo cách khá đơn giản được, nhưng lại cung cấp cho người chơi cảm giác quyền lực nhiều hơn bạn mong đợi. Chẳng bao lâu sau bạn sẽ được tiến hành quét cơ thể để xác định giới tính và kiểm tra dấu vân tay cho các bí danh khác.\r\n', 200000.00, 11, 'Lucas Pope', 'LootPlay', '2013-08-08', 'v1.0.0', 6767, 'active', '2026-09-27 15:34:59', '2026-09-27 15:35:02');
INSERT INTO `games` VALUES (10, 2, 'Schedule I', 'Thăng tiến qua các cấp bậc của thế giới ngầm\r\nSchedule I là một đế chế tội phạm mô phỏng diễn ra tại Hyland Point, nơi người chơi từ những kẻ buôn bán nhỏ trở thành những ông trùm tội phạm. Với việc xây dựng đế chế chiến lược, cạnh tranh tàn nhẫn và các cuộc đàn áp của cơ quan thực thi pháp luật, mỗi lựa chọn đều quan trọng khi họ sản xuất, phân phối và mở rộng trong thế giới nguy hiểm của thương mại bất hợp pháp.\r\nTừ kẻ lừa đảo đường phố đến ông trùm\r\nSchedule I thách thức người chơi xây dựng một đế chế ma túy, sản xuất và bán các chất, và vượt mặt cơ quan thực thi pháp luật cũng như các băng nhóm đối thủ. Người chơi có thể mở khóa các công thức độc đáo, mua bất động sản, và thuê nhân viên để tối ưu hóa hoạt động. Dù xử lý doanh số hay ủy quyền cho các tay buôn, nhiều con đường dẫn đến sự thống trị tội phạm.\r\nMặc dù sâu sắc và hấp dẫn, chủ đề và cơ chế của nó có thể không phù hợp với tất cả mọi người. Hệ thống thực thi pháp luật và sự cạnh tranh từ đối thủ thêm chiến lược nhưng cũng làm tăng độ khó. Tuy nhiên, đối với những người hâm mộ việc tạo dựng đế chế, lối chơi năng động, chơi đồng đội nhiều người, và quản lý rộng rãi mang lại một trải nghiệm đầy thách thức và phần thưởng.\r\n', 2000000.00, 11, 'TVGS', 'LootPlay', '2026-09-27', 'v1.0.0', 6767, 'active', '2026-09-27 15:36:17', '2026-09-27 15:36:20');

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '2026_09_23_125649_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '2026_09_23_125742_create_verification_codes_table', 1);
INSERT INTO `migrations` VALUES (3, '2026_09_23_130217_create_categories_table', 1);
INSERT INTO `migrations` VALUES (4, '2026_09_23_130259_create_games_table', 1);
INSERT INTO `migrations` VALUES (5, '2026_09_23_130347_create_game_images_table', 1);
INSERT INTO `migrations` VALUES (6, '2026_09_23_130411_create_carts_table', 1);
INSERT INTO `migrations` VALUES (7, '2026_09_23_130513_create_cart_items_table', 1);
INSERT INTO `migrations` VALUES (8, '2026_09_23_130612_create_orders_table', 1);
INSERT INTO `migrations` VALUES (9, '2026_09_23_130701_create_order_details_table', 1);
INSERT INTO `migrations` VALUES (10, '2026_09_23_130728_create_payments_table', 1);
INSERT INTO `migrations` VALUES (11, '2026_09_23_130801_create_reviews_table', 1);
INSERT INTO `migrations` VALUES (12, '2026_09_23_130822_create_wishlists_table', 1);
INSERT INTO `migrations` VALUES (13, '2026_09_23_143857_create_cache_table', 1);
INSERT INTO `migrations` VALUES (14, '2026_09_23_170225_add_detail_fields_to_games_table', 1);

-- ----------------------------
-- Table structure for order_details
-- ----------------------------
DROP TABLE IF EXISTS `order_details`;
CREATE TABLE `order_details`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` bigint UNSIGNED NOT NULL,
  `game_id` bigint UNSIGNED NOT NULL,
  `quantity` int NOT NULL DEFAULT 1,
  `price` decimal(12, 2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_details_order_id_game_id_unique`(`order_id` ASC, `game_id` ASC) USING BTREE,
  INDEX `order_details_game_id_foreign`(`game_id` ASC) USING BTREE,
  CONSTRAINT `order_details_game_id_foreign` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `order_details_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_details
-- ----------------------------
INSERT INTO `order_details` VALUES (1, 1, 2, 1, 399000.00, '2026-10-01 14:30:03', '2026-10-01 14:30:03');
INSERT INTO `order_details` VALUES (2, 2, 2, 1, 399000.00, '2026-10-01 14:43:15', '2026-10-01 14:43:15');
INSERT INTO `order_details` VALUES (3, 3, 3, 1, 249000.00, '2026-10-01 14:44:51', '2026-10-01 14:44:51');
INSERT INTO `order_details` VALUES (4, 4, 2, 1, 399000.00, '2026-10-01 14:54:32', '2026-10-01 14:54:32');
INSERT INTO `order_details` VALUES (5, 5, 2, 1, 399000.00, '2026-10-04 06:08:06', '2026-10-04 06:08:06');
INSERT INTO `order_details` VALUES (6, 6, 2, 2, 399000.00, '2026-10-04 11:09:45', '2026-10-04 11:09:45');
INSERT INTO `order_details` VALUES (7, 7, 1, 1, 299000.00, '2026-10-04 11:19:50', '2026-10-04 11:19:50');
INSERT INTO `order_details` VALUES (8, 8, 2, 1, 399000.00, '2026-10-05 02:33:22', '2026-10-05 02:33:22');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `order_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_amount` decimal(12, 2) NOT NULL DEFAULT 0.00,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `orders_order_code_unique`(`order_code` ASC) USING BTREE,
  INDEX `orders_user_id_foreign`(`user_id` ASC) USING BTREE,
  CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, 1, 'LP20261001143003390', 399000.00, 'pending', '2026-10-01 14:30:03', '2026-10-01 14:30:03');
INSERT INTO `orders` VALUES (2, 1, 'LP20261001144315234', 399000.00, 'pending', '2026-10-01 14:43:15', '2026-10-01 14:43:15');
INSERT INTO `orders` VALUES (3, 1, 'LP20261001144451465', 249000.00, 'pending', '2026-10-01 14:44:51', '2026-10-01 14:44:51');
INSERT INTO `orders` VALUES (4, 1, 'LP20261001145432501', 399000.00, 'paid', '2026-10-01 14:54:32', '2026-10-01 14:54:41');
INSERT INTO `orders` VALUES (5, 3, 'LP20261004060806447', 399000.00, 'paid', '2026-10-04 06:08:06', '2026-10-04 06:08:13');
INSERT INTO `orders` VALUES (6, 1, 'LP20261004110945857', 798000.00, 'pending', '2026-10-04 11:09:45', '2026-10-04 11:09:45');
INSERT INTO `orders` VALUES (7, 1, 'LP20261004111950685', 299000.00, 'paid', '2026-10-04 11:19:50', '2026-10-04 11:19:56');
INSERT INTO `orders` VALUES (8, 1, 'LP20261005023322467', 399000.00, 'paid', '2026-10-05 02:33:22', '2026-10-05 02:37:17');

-- ----------------------------
-- Table structure for payments
-- ----------------------------
DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` bigint UNSIGNED NOT NULL,
  `payment_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `amount` decimal(12, 2) NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `paid_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `payments_order_id_unique`(`order_id` ASC) USING BTREE,
  UNIQUE INDEX `payments_transaction_code_unique`(`transaction_code` ASC) USING BTREE,
  CONSTRAINT `payments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of payments
-- ----------------------------
INSERT INTO `payments` VALUES (1, 2, 'banking', 'PAY20261001144315692', 399000.00, 'pending', NULL, '2026-10-01 14:43:15', '2026-10-01 14:43:15');
INSERT INTO `payments` VALUES (2, 3, 'banking', 'PAY20261001144451257', 249000.00, 'pending', NULL, '2026-10-01 14:44:51', '2026-10-01 14:44:51');
INSERT INTO `payments` VALUES (3, 4, 'banking', 'PAY20261001145432848', 399000.00, 'paid', '2026-10-01 14:54:41', '2026-10-01 14:54:32', '2026-10-01 14:54:41');
INSERT INTO `payments` VALUES (4, 5, 'banking', 'PAY20261004060807211', 399000.00, 'paid', '2026-10-04 06:08:13', '2026-10-04 06:08:07', '2026-10-04 06:08:13');
INSERT INTO `payments` VALUES (5, 6, 'banking', NULL, 798000.00, 'pending', NULL, '2026-10-04 11:09:45', '2026-10-04 11:09:45');
INSERT INTO `payments` VALUES (6, 7, 'banking', 'DEMO_1791112796233', 299000.00, 'paid', '2026-10-04 11:19:56', '2026-10-04 11:19:50', '2026-10-04 11:19:56');
INSERT INTO `payments` VALUES (7, 8, 'banking', 'DEMO_1791167839749', 399000.00, 'paid', '2026-10-05 02:37:19', '2026-10-05 02:33:23', '2026-10-05 02:37:19');

-- ----------------------------
-- Table structure for reviews
-- ----------------------------
DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `game_id` bigint UNSIGNED NOT NULL,
  `rating` tinyint UNSIGNED NOT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'approved',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `reviews_user_id_game_id_unique`(`user_id` ASC, `game_id` ASC) USING BTREE,
  INDEX `reviews_game_id_foreign`(`game_id` ASC) USING BTREE,
  CONSTRAINT `reviews_game_id_foreign` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `reviews_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of reviews
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'Hoàng Anh Tuấn', 'tuanhocgioi101@gmail.com', '$2y$12$aVXkdn/KcKCtxoP5djjEyudx5vG7vqWgYR0J4J/KVuchEUkKk9qkq', '0362927305', 'user', NULL, '2026-09-23 17:22:30', '2026-09-23 17:22:30');
INSERT INTO `users` VALUES (2, 'Trần Văn Duy Bảo', 'kinnamphuoc2@gmail.com', '$2y$12$MmE6iYxw54jEeZ0D1KU1zuATYevv9MOdFT1eG9qjZZ76Zonx46HK.', '0362927305', 'user', NULL, '2026-09-24 06:08:35', '2026-09-24 06:08:35');
INSERT INTO `users` VALUES (3, 'anh tuấn', 'tuandam6789@gmail.com', '$2y$12$XOpXAxhYTFY/2plcXQpZduvEQDBwb347T6yBmNRlg2WRAYokZJe1a', '0362927305', 'user', NULL, '2026-10-04 06:07:24', '2026-10-04 06:07:24');

-- ----------------------------
-- Table structure for verification_codes
-- ----------------------------
DROP TABLE IF EXISTS `verification_codes`;
CREATE TABLE `verification_codes`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of verification_codes
-- ----------------------------
INSERT INTO `verification_codes` VALUES (1, 'sad1@gmail.com', '650922', '2026-09-23 17:25:54', '2026-09-23 17:20:54', '2026-09-23 17:20:54');

-- ----------------------------
-- Table structure for wishlists
-- ----------------------------
DROP TABLE IF EXISTS `wishlists`;
CREATE TABLE `wishlists`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `game_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `wishlists_user_id_game_id_unique`(`user_id` ASC, `game_id` ASC) USING BTREE,
  INDEX `wishlists_game_id_foreign`(`game_id` ASC) USING BTREE,
  CONSTRAINT `wishlists_game_id_foreign` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `wishlists_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wishlists
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
