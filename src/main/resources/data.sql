--------------------------------------------------
-- 1. アカウントの追加（本番環境と開発環境）
--------------------------------------------------
INSERT INTO monitor.m_aws_account (account_id, account_name, ins_dttm, up_dttm, up_empcd) 
VALUES 
('123456789012', 'Production-Account', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM'),
('987654321098', 'Development-Account', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM')
ON CONFLICT (account_id) DO NOTHING;

--------------------------------------------------
-- 2. リソースインベントリの拡充
--------------------------------------------------
INSERT INTO monitor.t_resource_inventory 
(resource_id, account_id, service_code, resource_name, resource_arn, resource_type, region, status, ins_dttm, up_dttm, up_empcd) 
VALUES 
('i-0abcd1234efgh5678', '123456789012', 'AmazonEC2', 'Prod-Web-Server-01', 'arn:aws:ec2:ap-northeast-1:123456789012:instance/i-0abcd...', 't3.medium', 'ap-northeast-1', 'RUNNING', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM'),
('i-0abcd9999efgh8888', '123456789012', 'AmazonEC2', 'Prod-Web-Server-02', 'arn:aws:ec2:ap-northeast-1:123456789012:instance/i-0abcd...', 't3.medium', 'ap-northeast-1', 'RUNNING', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM'),
('db-XYZ123ABC', '123456789012', 'AmazonRDS', 'Prod-Database-Primary', 'arn:aws:rds:ap-northeast-1:123456789012:db:prod-db', 'db.r5.large', 'ap-northeast-1', 'AVAILABLE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM'),
('my-company-assets-bucket', '123456789012', 'AmazonS3', 'Prod-Assets-Storage', 'arn:aws:s3:::my-company-assets-bucket', 'Bucket', 'ap-northeast-1', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM'),
('i-0devd1234efgh5678', '987654321098', 'AmazonEC2', 'Dev-Test-Server', 'arn:aws:ec2:ap-northeast-1:987654321098:instance/i-0devd...', 't3.micro', 'ap-northeast-1', 'STOPPED', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM')
ON CONFLICT (resource_id) DO NOTHING;

--------------------------------------------------
-- 3. 日次コストの拡充（グラフをカラフルにするため複数サービスを登録）
--------------------------------------------------
-- ※idが自動採番(SERIAL/IDENTITY)であることを前提にid列は省略しています。
INSERT INTO monitor.t_daily_cost 
(account_id, service_code, target_date, cost_amount_jpy, cost_amount_usd, ins_dttm, up_dttm, up_empcd) 
VALUES 
('123456789012', 'AmazonEC2', CURRENT_DATE, 4500, 30.50, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM'),
('123456789012', 'AmazonRDS', CURRENT_DATE, 7500, 50.20, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM'),
('123456789012', 'AmazonS3', CURRENT_DATE, 1200, 8.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM'),
('123456789012', 'AWSLambda', CURRENT_DATE, 300, 2.10, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM'),
('987654321098', 'AmazonEC2', CURRENT_DATE, 800, 5.40, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM');

--------------------------------------------------
-- 4. 予算データの拡充
--------------------------------------------------
INSERT INTO monitor.t_cost_budget 
(account_id, budget_name, period_type, budget_amount, currency, start_date, end_date, warning_threshold, critical_threshold, ins_dttm, up_dttm, up_empcd) 
VALUES 
('123456789012', '本番環境 全体予算', 'MONTHLY', 1000.00, 'USD', '2026-08-01', '2026-08-31', 80.0, 95.0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM'),
('987654321098', '開発環境 抑制予算', 'MONTHLY', 200.00, 'USD', '2026-08-01', '2026-08-31', 70.0, 90.0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM');

--------------------------------------------------
-- 5. アラートデータの拡充 (OPENとRESOLVEDを混在)
--------------------------------------------------
INSERT INTO monitor.t_cost_alert 
(account_id, service_code, alert_type, threshold_value, actual_value, status, detected_dttm, ins_dttm, up_dttm, up_empcd) 
VALUES 
('123456789012', 'AmazonRDS', 'BUDGET_EXCEEDED', 400.00, 420.50, 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM'),
('987654321098', 'AmazonEC2', 'ANOMALY_DETECTION', 10.00, 25.00, 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM'),
('123456789012', 'AWSLambda', 'BUDGET_EXCEEDED', 5.00, 6.20, 'RESOLVED', CURRENT_TIMESTAMP - INTERVAL '2 days', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM');