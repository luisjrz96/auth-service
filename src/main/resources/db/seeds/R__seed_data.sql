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
    ('admin', '{bcrypt}$2a$12$Q9IUGLB7hx6NsmzIc9tMxe8LbuwRpPZo7B8JXYD1Fp3g3v.mDTYte', true),
    ('john_doe', '{bcrypt}$2a$12$71dwnhGhjKRj3p/EYQVgMeB0zDNXHChgfT0RLFd0ZGy2m9mfz1O1i', true),
    ('jane_doe', '{bcrypt}$2a$12$UDTS0QjDl9dp.DDME1XECuB4dSOPiknP07RPS8ZZULFEovvG2RZsC', true)
ON CONFLICT (username) DO NOTHING;

-- Step 3: Assign roles to users
INSERT INTO user_roles (user_id, role_id)
VALUES
    ((SELECT id FROM users WHERE username = 'admin'), (SELECT id FROM roles WHERE name = 'ADMIN')),
    ((SELECT id FROM users WHERE username = 'john_doe'), (SELECT id FROM roles WHERE name = 'USER')),
    ((SELECT id FROM users WHERE username = 'jane_doe'), (SELECT id FROM roles WHERE name = 'MODERATOR'))
ON CONFLICT DO NOTHING;