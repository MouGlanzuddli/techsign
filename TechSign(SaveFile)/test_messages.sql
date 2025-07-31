-- Test messages table
USE TechSignDB;

-- Kiểm tra cấu trúc bảng messages
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'messages';

-- Kiểm tra dữ liệu messages
SELECT * FROM messages ORDER BY sent_at DESC;

-- Kiểm tra users
SELECT id, email, full_name FROM users ORDER BY id;

-- Thêm tin nhắn test nếu chưa có
IF NOT EXISTS (SELECT * FROM messages WHERE sender_id = 1 AND receiver_id = 2)
BEGIN
    INSERT INTO messages (sender_id, receiver_id, content, message_type, file_url, sent_at, is_read)
    VALUES 
    (1, 2, 'Hello!', 'text', NULL, GETDATE(), 0),
    (2, 1, 'Hi there!', 'text', NULL, GETDATE(), 0),
    (1, 2, 'How are you?', 'text', NULL, GETDATE(), 0);
    PRINT 'Đã thêm tin nhắn test';
END
ELSE
BEGIN
    PRINT 'Đã có tin nhắn test';
END

-- Hiển thị tin nhắn test
SELECT 
    m.id,
    m.sender_id,
    m.receiver_id,
    m.content,
    m.message_type,
    m.sent_at,
    m.is_read,
    s.full_name as sender_name,
    r.full_name as receiver_name
FROM messages m
JOIN users s ON m.sender_id = s.id
JOIN users r ON m.receiver_id = r.id
ORDER BY m.sent_at DESC; 