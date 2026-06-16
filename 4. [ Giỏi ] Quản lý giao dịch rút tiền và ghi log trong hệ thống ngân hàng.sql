CREATE DATABASE bank_log_system;

DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS accounts;

CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    balance NUMERIC(12,2)
);

CREATE TABLE transactions (
    trans_id SERIAL PRIMARY KEY,
    account_id INT REFERENCES accounts(account_id),
    amount NUMERIC(12,2),
    trans_type VARCHAR(20),
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO accounts (customer_name, balance)
VALUES ('Nguyen Van A', 1000.00), ('Tran Van B', 500.00);

-- Giao dịch rút tiền thành công
BEGIN;

UPDATE accounts
SET balance = balance - 200.00
WHERE account_id = 1 AND balance >= 200.00;

INSERT INTO transactions (account_id, amount, trans_type)
VALUES (1, 200.00, 'WITHDRAW');

COMMIT;

SELECT * FROM accounts;
SELECT * FROM transactions;

-- Giao dịch lỗi và Rollback
BEGIN;

UPDATE accounts
SET balance = balance - 300.00
WHERE account_id = 2 AND balance >= 300.00;

INSERT INTO transactions (account_id, amount, trans_type)
VALUES (999, 300.00, 'WITHDRAW');

ROLLBACK;

SELECT * FROM accounts;
SELECT * FROM transactions;