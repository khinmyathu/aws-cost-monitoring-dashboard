-- 1. スキーマ作成
CREATE SCHEMA IF NOT EXISTS monitor;

-- 2. テーブル作成 (存在しない場合のみ)
CREATE TABLE IF NOT EXISTS monitor.t_aws_account (
    account_id VARCHAR(64) PRIMARY KEY,
    account_name VARCHAR(255),
    ins_dttm TIMESTAMP,
    up_dttm TIMESTAMP,
    up_empcd VARCHAR(12)
);

CREATE TABLE IF NOT EXISTS monitor.t_resource_inventory (
    resource_id VARCHAR(64) PRIMARY KEY,
    account_id VARCHAR(64),
    resource_name VARCHAR(255),
    service_code VARCHAR(64),
    status VARCHAR(64),
    last_checked_dttm TIMESTAMP,
    ins_dttm TIMESTAMP,
    up_dttm TIMESTAMP,
    up_empcd VARCHAR(12)
);

CREATE TABLE IF NOT EXISTS monitor.t_daily_cost (
    id BIGINT PRIMARY KEY,
    account_id VARCHAR(64),
    service_code VARCHAR(64),
    target_date DATE,
    cost_amount_jpy NUMERIC(15, 2),
    cost_amount_usd NUMERIC(15, 2),
    ins_dttm TIMESTAMP,
    up_dttm TIMESTAMP,
    up_empcd VARCHAR(12)
);