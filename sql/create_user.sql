-- 创建目标数据库（如果不存在）
CREATE DATABASE IF NOT EXISTS `sse_library_back` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 创建新的 sse-library 账户，密码设为 123456（允许任意主机连接 `%`，若只允许本地可将 `%` 改为 `localhost`）
CREATE USER 'sse-library'@'%' IDENTIFIED BY '123456';

-- 授予 sse-library 账户对 sse_library_back 数据库的所有权限
GRANT ALL PRIVILEGES ON `sse_library_back`.* TO 'sse-library'@'%';

-- 刷新权限，使其立即生效
FLUSH PRIVILEGES;
