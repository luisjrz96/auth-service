-- Step 1: Ensure roles exist
INSERT INTO roles (name)
VALUES
    ('ADMIN'),
    ('USER'),
    ('MODERATOR')
ON CONFLICT (name) DO NOTHING;

-- Step 2: Ensure users are inserted
INSERT INTO users (username, password, enabled)
VALUES
    ('admin', '{bcrypt}$2b$12$leHrDsTrxAdR0ezoU4vjGuaTVwZv7QLjcokC.TLBz1haGkPXoa.rm', true), -- admin123
    ('john_doe', '{bcrypt}$2b$12$ZQp3WMrLvXNSY//C0Puqdu7NnA8me6o4nhc6wxAQ9THu9SjWXtuLO', true), -- user123
    ('jane_doe', '{noop}mod123', true) -- mod123
ON CONFLICT (username) DO NOTHING;

-- Step 3: Assign roles to users
INSERT INTO user_roles (user_id, role_id)
VALUES
    ((SELECT id FROM users WHERE username = 'admin'), (SELECT id FROM roles WHERE name = 'ADMIN')),
    ((SELECT id FROM users WHERE username = 'john_doe'), (SELECT id FROM roles WHERE name = 'USER')),
    ((SELECT id FROM users WHERE username = 'jane_doe'), (SELECT id FROM roles WHERE name = 'MODERATOR'))
ON CONFLICT DO NOTHING;