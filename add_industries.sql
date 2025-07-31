-- Add new industries to the industries table
INSERT INTO industries (name, description, created_at, updated_at)
VALUES
('Artificial Intelligence', 'Artificial Intelligence and Machine Learning', GETDATE(), GETDATE()),
('Software Engineering', 'Software Development and Engineering', GETDATE(), GETDATE()),
('Information Technology', 'General IT Services', GETDATE(), GETDATE()),
('Data Analysis', 'Data Science and Analytics', GETDATE(), GETDATE()),
('Information Security', 'Cybersecurity and Information Protection', GETDATE(), GETDATE()); 