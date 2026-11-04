-- 1. スキーマ作成
CREATE SCHEMA IF NOT EXISTS monitor;

-- Table: monitor.m_aws_account

-- DROP TABLE IF EXISTS monitor.m_aws_account;

CREATE TABLE IF NOT EXISTS monitor.m_aws_account
(
    account_id character(16) COLLATE pg_catalog."default" NOT NULL,
    account_name character(64) COLLATE pg_catalog."default",
    env_type numeric,
    ins_dttm timestamp(3) without time zone DEFAULT now(),
    up_empcd character(12) COLLATE pg_catalog."default",
    up_dttm timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT m_aws_account_pk PRIMARY KEY (account_id)
)

TABLESPACE pg_default;

COMMENT ON TABLE monitor.m_aws_account
    IS 'アカウントマスタ';

COMMENT ON COLUMN monitor.m_aws_account.account_id
    IS 'アカウントID';

COMMENT ON COLUMN monitor.m_aws_account.account_name
    IS 'アカウント名';

COMMENT ON COLUMN monitor.m_aws_account.env_type
    IS '環境区分';

COMMENT ON COLUMN monitor.m_aws_account.ins_dttm
    IS '作成日時';

COMMENT ON COLUMN monitor.m_aws_account.up_empcd
    IS '更新者';

COMMENT ON COLUMN monitor.m_aws_account.up_dttm
    IS '更新日時';

-- Table: monitor.m_aws_service

-- DROP TABLE IF EXISTS monitor.m_aws_service;

CREATE TABLE IF NOT EXISTS monitor.m_aws_service
(
    service_code character(16) COLLATE pg_catalog."default" NOT NULL,
    service_name character(64) COLLATE pg_catalog."default",
    category character(64) COLLATE pg_catalog."default",
    ins_dttm timestamp(3) without time zone DEFAULT now(),
    up_empcd character(12) COLLATE pg_catalog."default",
    up_dttm timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT m_aws_service_pk PRIMARY KEY (service_code)
)

TABLESPACE pg_default;

COMMENT ON TABLE monitor.m_aws_service
    IS 'サービスマスタ';

COMMENT ON COLUMN monitor.m_aws_service.service_code
    IS 'サービスコード:AmazonEC2", "AmazonRDS';

COMMENT ON COLUMN monitor.m_aws_service.service_name
    IS '表示用サービス名';

COMMENT ON COLUMN monitor.m_aws_service.category
    IS 'カテゴリ:Compute, Database, Storageなど';

COMMENT ON COLUMN monitor.m_aws_service.ins_dttm
    IS '作成日時';

COMMENT ON COLUMN monitor.m_aws_service.up_empcd
    IS '更新者';

COMMENT ON COLUMN monitor.m_aws_service.up_dttm
    IS '更新日時';

DROP TABLE IF EXISTS monitor.t_cost_alert;

CREATE TABLE IF NOT EXISTS monitor.t_cost_alert
(
    id bigint NOT NULL,
    account_id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    budget_id bigint,
    target_month character varying(7) NOT NULL,
    alert_type character varying(255) COLLATE pg_catalog."default",
    threshold_value numeric(38,2),
    actual_value numeric(38,2),
    ins_dttm timestamp(3) without time zone DEFAULT now(),
    up_empcd character varying(255) COLLATE pg_catalog."default",
    up_dttm timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT t_cost_alert_pk PRIMARY KEY (id),
    CONSTRAINT fk_cost_alert_budget FOREIGN KEY (budget_id) 
        REFERENCES monitor.t_cost_budget (id) ON DELETE SET NULL
);

COMMENT ON TABLE monitor.t_cost_alert IS '月次コストアラート（表示確認専用）';
COMMENT ON COLUMN monitor.t_cost_alert.id IS 'アラートID';
COMMENT ON COLUMN monitor.t_cost_alert.account_id IS 'AWSアカウントID';
COMMENT ON COLUMN monitor.t_cost_alert.budget_id IS '対象予算ID';
COMMENT ON COLUMN monitor.t_cost_alert.target_month IS '対象年月 (YYYY-MM)';
COMMENT ON COLUMN monitor.t_cost_alert.alert_type IS 'アラート種別 (WARNING, CRITICAL)';
COMMENT ON COLUMN monitor.t_cost_alert.threshold_value IS '判定基準閾値額 (USD)';
COMMENT ON COLUMN monitor.t_cost_alert.actual_value IS '月間利用実績額 (USD)';
COMMENT ON COLUMN monitor.t_cost_alert.ins_dttm IS 'レコード作成日時';
COMMENT ON COLUMN monitor.t_cost_alert.up_empcd IS '更新者';
COMMENT ON COLUMN monitor.t_cost_alert.up_dttm IS '更新日時';

-- Table: monitor.t_cost_budget

-- DROP TABLE IF EXISTS monitor.t_cost_budget;

CREATE TABLE IF NOT EXISTS monitor.t_cost_budget
(
    id bigint NOT NULL,
    account_id character varying(64) COLLATE pg_catalog."default",
    budget_name character varying(255) COLLATE pg_catalog."default",
    period_type character varying(32) COLLATE pg_catalog."default",
    budget_amount numeric(15,2),
    currency character varying(8) COLLATE pg_catalog."default",
    start_date date,
    end_date date,
    warning_threshold numeric(5,2),
    critical_threshold numeric(5,2),
    ins_dttm timestamp(3) without time zone DEFAULT now(),
    up_empcd character varying(12) COLLATE pg_catalog."default",
    up_dttm timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT t_cost_budget_pk PRIMARY KEY (id)
)

TABLESPACE pg_default;

COMMENT ON TABLE monitor.t_cost_budget
    IS 'コスト予算設定';

COMMENT ON COLUMN monitor.t_cost_budget.id
    IS '予算ID';

COMMENT ON COLUMN monitor.t_cost_budget.account_id
    IS 'AWSアカウントID';

COMMENT ON COLUMN monitor.t_cost_budget.budget_name
    IS '予算名称';

COMMENT ON COLUMN monitor.t_cost_budget.period_type
    IS '期間種別 (例: MONTHLY, ANNUALLY)';

COMMENT ON COLUMN monitor.t_cost_budget.budget_amount
    IS '予算額';

COMMENT ON COLUMN monitor.t_cost_budget.currency
    IS '通貨 (例: USD, JPY)';

COMMENT ON COLUMN monitor.t_cost_budget.start_date
    IS '適用開始日';

COMMENT ON COLUMN monitor.t_cost_budget.end_date
    IS '適用終了日';

COMMENT ON COLUMN monitor.t_cost_budget.warning_threshold
    IS '警告閾値 (%)';

COMMENT ON COLUMN monitor.t_cost_budget.critical_threshold
    IS '危険閾値 (%)';

COMMENT ON COLUMN monitor.t_cost_budget.ins_dttm
    IS '作成日時';

COMMENT ON COLUMN monitor.t_cost_budget.up_empcd
    IS '更新者';

COMMENT ON COLUMN monitor.t_cost_budget.up_dttm
    IS '更新日時';

-- Table: monitor.t_daily_cost

-- DROP TABLE IF EXISTS monitor.t_daily_cost;

CREATE TABLE IF NOT EXISTS monitor.t_daily_cost
(
    id numeric NOT NULL,
    target_date date,
    account_id character(64) COLLATE pg_catalog."default",
    service_code character(64) COLLATE pg_catalog."default" NOT NULL,
    cost_amount_usd numeric(9,0),
    cost_amount_jpy numeric(9,0),
    ins_dttm timestamp(3) without time zone DEFAULT now(),
    up_empcd character(12) COLLATE pg_catalog."default",
    up_dttm timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT t_daily_cost_pk PRIMARY KEY (id)
)

TABLESPACE pg_default;

COMMENT ON TABLE monitor.t_daily_cost
    IS '日別コスト実績';

COMMENT ON COLUMN monitor.t_daily_cost.id
    IS 'サロゲートキー';

COMMENT ON COLUMN monitor.t_daily_cost.target_date
    IS '利用日';

COMMENT ON COLUMN monitor.t_daily_cost.account_id
    IS 'AWSアカウントID';

COMMENT ON COLUMN monitor.t_daily_cost.service_code
    IS 'サービスコード';

COMMENT ON COLUMN monitor.t_daily_cost.cost_amount_usd
    IS '利用料金（ドル・小数点考慮）';

COMMENT ON COLUMN monitor.t_daily_cost.cost_amount_jpy
    IS '利用料金（円換算）';

COMMENT ON COLUMN monitor.t_daily_cost.ins_dttm
    IS '作成日時';

COMMENT ON COLUMN monitor.t_daily_cost.up_empcd
    IS '更新者';

COMMENT ON COLUMN monitor.t_daily_cost.up_dttm
    IS '更新日時';

-- Table: monitor.t_resource_inventory

-- DROP TABLE IF EXISTS monitor.t_resource_inventory;

CREATE TABLE IF NOT EXISTS monitor.t_resource_inventory
(
    resource_id character varying(64) COLLATE pg_catalog."default" NOT NULL,
    account_id character varying(64) COLLATE pg_catalog."default",
    service_code character varying(64) COLLATE pg_catalog."default",
    resource_name character varying(255) COLLATE pg_catalog."default",
    resource_arn character varying(512) COLLATE pg_catalog."default",
    resource_type character varying(64) COLLATE pg_catalog."default",
    region character varying(32) COLLATE pg_catalog."default",
    status character varying(64) COLLATE pg_catalog."default",
    last_checked_dttm timestamp(3) without time zone,
    ins_dttm timestamp(3) without time zone DEFAULT now(),
    up_empcd character varying(12) COLLATE pg_catalog."default",
    up_dttm timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT t_resource_inventory_pk PRIMARY KEY (resource_id)
)

TABLESPACE pg_default;

COMMENT ON TABLE monitor.t_resource_inventory
    IS 'リソースインベントリ情報';

COMMENT ON COLUMN monitor.t_resource_inventory.resource_id
    IS 'リソースID';

COMMENT ON COLUMN monitor.t_resource_inventory.account_id
    IS 'AWSアカウントID';

COMMENT ON COLUMN monitor.t_resource_inventory.service_code
    IS 'サービスコード';

COMMENT ON COLUMN monitor.t_resource_inventory.resource_name
    IS 'リソース名';

COMMENT ON COLUMN monitor.t_resource_inventory.resource_arn
    IS 'リソースARN';

COMMENT ON COLUMN monitor.t_resource_inventory.resource_type
    IS 'リソース種別 (例: EC2 Instance, S3 Bucket)';

COMMENT ON COLUMN monitor.t_resource_inventory.region
    IS 'リージョン (例: ap-northeast-1)';

COMMENT ON COLUMN monitor.t_resource_inventory.status
    IS 'ステータス';

COMMENT ON COLUMN monitor.t_resource_inventory.last_checked_dttm
    IS '最終確認日時';

COMMENT ON COLUMN monitor.t_resource_inventory.ins_dttm
    IS '作成日時';

COMMENT ON COLUMN monitor.t_resource_inventory.up_empcd
    IS '更新者';

COMMENT ON COLUMN monitor.t_resource_inventory.up_dttm
    IS '更新日時';