-- name: CreateUser :one
INSERT INTO users (
    username,
    hashed_password,
    full_name,
    email,
    role -- добавьте новое поле здесь
) VALUES (
             $1, $2, $3, $4, $5 -- добавьте новое поле здесь
         ) RETURNING id, username, hashed_password, full_name, email, role, password_changed_at, created_at;

-- name: GetUser :one
SELECT id, username, hashed_password, full_name, email, role, password_changed_at, created_at
FROM users
WHERE username = $1 LIMIT 1;
