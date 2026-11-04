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
INSERT INTO monitor.t_daily_cost 
(id, account_id, service_code, target_date, cost_amount_jpy, cost_amount_usd, ins_dttm, up_dttm, up_empcd) 
VALUES 
(1, '123456789012', 'AmazonEC2', CURRENT_DATE, 4500, 30.50, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM'),
(2, '123456789012', 'AmazonRDS', CURRENT_DATE, 7500, 50.20, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM'),
(3, '123456789012', 'AmazonS3', CURRENT_DATE, 1200, 8.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM'),
(4, '123456789012', 'AWSLambda', CURRENT_DATE, 300, 2.10, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM'),
(5, '987654321098', 'AmazonEC2', CURRENT_DATE, 800, 5.40, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM')
ON CONFLICT (id) DO NOTHING;

--------------------------------------------------
-- 4. 予算データの拡充
--------------------------------------------------
INSERT INTO monitor.t_cost_budget 
(id, account_id, budget_name, period_type, budget_amount, currency, start_date, end_date, warning_threshold, critical_threshold, ins_dttm, up_dttm, up_empcd) 
VALUES 
(1, '123456789012', '本番環境 全体予算', 'MONTHLY', 1000.00, 'USD', '2026-08-01', '2026-08-31', 80.0, 95.0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM'),
(2, '987654321098', '開発環境 抑制予算', 'MONTHLY', 200.00, 'USD', '2026-08-01', '2026-08-31', 70.0, 90.0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM')
ON CONFLICT (id) DO NOTHING;

--------------------------------------------------
-- 5. アラートデータ（月間全体監視・新構造対応）
--------------------------------------------------
DELETE FROM monitor.t_cost_alert;

INSERT INTO monitor.t_cost_alert 
(id, account_id, budget_id, target_month, alert_type, threshold_value, actual_value, ins_dttm, up_dttm, up_empcd) 
VALUES 
-- actual_value を日次合計と同じ 878.10 に修正
(1, '123456789012', 1, '2026-10', 'WARNING', 800.00, 878.10, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM'),
(2, '987654321098', 2, '2026-10', 'WARNING', 140.00, 170.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM')
ON CONFLICT (id) DO UPDATE SET actual_value = EXCLUDED.actual_value;