CREATE TABLE users (
                       id SERIAL PRIMARY KEY,
                       username TEXT NOT NULL,
                       hashed_password TEXT NOT NULL,
                       full_name TEXT NOT NULL,
                       email TEXT NOT NULL UNIQUE,
                       role TEXT NOT NULL, -- добавьте это поле
                       password_changed_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
                       created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

ALTER TABLE "accounts" ADD FOREIGN KEY ("owner") REFERENCES "users" ("username");

CREATE UNIQUE INDEX ON "accounts" ("owner", "currency");
ALTER TABLE "accounts" ADD CONSTRAINT "owner_currency_key" UNIQUE ("owner", "currency");
