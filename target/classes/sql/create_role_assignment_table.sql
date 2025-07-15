-- Create role_assignment_requests table
CREATE TABLE role_assignment_requests (
    id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    requested_role_id INT NOT NULL,
    requested_by_admin_id INT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'pending', -- 'pending', 'accepted', 'rejected'
    token VARCHAR(255) NOT NULL UNIQUE,
    expires_at DATETIME NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    
    -- Foreign key constraints
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (requested_by_admin_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Create index for better performance
CREATE INDEX idx_role_assignment_token ON role_assignment_requests(token);
CREATE INDEX idx_role_assignment_status ON role_assignment_requests(status);
CREATE INDEX idx_role_assignment_user ON role_assignment_requests(user_id);
CREATE INDEX idx_role_assignment_expires ON role_assignment_requests(expires_at);

-- Add comments
EXEC sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Stores role assignment requests that require user confirmation',
    @level0type = N'SCHEMA', @level0name = N'dbo',
    @level1type = N'TABLE', @level1name = N'role_assignment_requests';

EXEC sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'User ID who is being assigned a new role',
    @level0type = N'SCHEMA', @level0name = N'dbo',
    @level1type = N'TABLE', @level1name = N'role_assignment_requests',
    @level2type = N'COLUMN', @level2name = N'user_id';

EXEC sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Role ID that is being requested',
    @level0type = N'SCHEMA', @level0name = N'dbo',
    @level1type = N'TABLE', @level1name = N'role_assignment_requests',
    @level2type = N'COLUMN', @level2name = N'requested_role_id';

EXEC sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Admin ID who initiated the role assignment request',
    @level0type = N'SCHEMA', @level0name = N'dbo',
    @level1type = N'TABLE', @level1name = N'role_assignment_requests',
    @level2type = N'COLUMN', @level2name = N'requested_by_admin_id';

EXEC sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Status of the request: pending, accepted, rejected',
    @level0type = N'SCHEMA', @level0name = N'dbo',
    @level1type = N'TABLE', @level1name = N'role_assignment_requests',
    @level2type = N'COLUMN', @level2name = N'status';

EXEC sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Unique token for email confirmation links',
    @level0type = N'SCHEMA', @level0name = N'dbo',
    @level1type = N'TABLE', @level1name = N'role_assignment_requests',
    @level2type = N'COLUMN', @level2name = N'token';

EXEC sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'When the token expires',
    @level0type = N'SCHEMA', @level0name = N'dbo',
    @level1type = N'TABLE', @level1name = N'role_assignment_requests',
    @level2type = N'COLUMN', @level2name = N'expires_at'; 