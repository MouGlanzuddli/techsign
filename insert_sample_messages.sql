-- Thêm dữ liệu mẫu cho bảng messages
USE TechSignDB;

-- Thêm dữ liệu mẫu
INSERT INTO messages (sender_id, receiver_id, content, message_type, file_url, sent_at, is_read)
VALUES 
(1, 2, 'Hello! How are you?', 'text', NULL, GETDATE(), 0),
(2, 1, 'I am fine, thank you!', 'text', NULL, GETDATE(), 0),
(1, 3, 'Please check this file', 'file', '/uploads/document.pdf', GETDATE(), 0),
(3, 1, 'Thanks for sharing!', 'text', NULL, GETDATE(), 0),
(2, 3, 'Can you help me with this?', 'text', NULL, GETDATE(), 0),
(3, 2, 'Sure, what do you need?', 'text', NULL, GETDATE(), 0);

-- Hiển thị kết quả
SELECT 
    m.id,
    m.sender_id,
    m.receiver_id,
    m.content,
    m.message_type,
    m.file_url,
    m.sent_at,
    m.is_read,
    sender.full_name as sender_name,
    receiver.full_name as receiver_name
FROM messages m
JOIN users sender ON m.sender_id = sender.id
JOIN users receiver ON m.receiver_id = receiver.id
ORDER BY m.sent_at DESC; 