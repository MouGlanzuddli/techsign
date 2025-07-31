-- Thêm cột cho bảng messages
USE TechSignDB;

-- Kiểm tra xem cột message_type đã tồn tại chưa
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
               WHERE TABLE_NAME = 'messages' AND COLUMN_NAME = 'message_type')
BEGIN
    ALTER TABLE messages ADD message_type VARCHAR(20) DEFAULT 'text';
    PRINT 'Đã thêm cột message_type';
END
ELSE
BEGIN
    PRINT 'Cột message_type đã tồn tại';
END

-- Kiểm tra xem cột file_url đã tồn tại chưa
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
               WHERE TABLE_NAME = 'messages' AND COLUMN_NAME = 'file_url')
BEGIN
    ALTER TABLE messages ADD file_url VARCHAR(500);
    PRINT 'Đã thêm cột file_url';
END
ELSE
BEGIN
    PRINT 'Cột file_url đã tồn tại';
END

-- Hiển thị cấu trúc bảng sau khi thêm
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE, COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'messages'
ORDER BY ORDINAL_POSITION; 