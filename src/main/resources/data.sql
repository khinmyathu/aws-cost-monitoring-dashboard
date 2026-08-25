-- 1. アカウント初期データ
INSERT INTO monitor.m_aws_account (account_id, account_name, ins_dttm, up_dttm, up_empcd) 
VALUES ('123456789012', 'Production-Account', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM')
ON CONFLICT (account_id) DO NOTHING;

-- サービスマスタ (m_aws_service) の初期データ
INSERT INTO monitor.m_aws_service (service_code, service_name, category, ins_dttm, up_dttm, up_empcd) 
VALUES 
('AmazonEC2', 'Amazon Elastic Compute Cloud', 'Compute', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM'),
('AmazonRDS', 'Amazon Relational Database Service', 'Database', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM'),
('AmazonS3', 'Amazon Simple Storage Service', 'Storage', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM'),
('AWSLambda', 'AWS Lambda', 'Compute', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM'),
('AmazonCloudWatch', 'Amazon CloudWatch', 'Management & Governance', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM')
ON CONFLICT (service_code) DO NOTHING;

-- 2. リソース初期データ (拡張カラム対応)
INSERT INTO monitor.t_resource_inventory (
    resource_id, account_id, service_code, resource_name, resource_arn, resource_type, region, status, last_checked_dttm, ins_dttm, up_dttm, up_empcd
) VALUES (
    'res-ec2-001', '123456789012', 'AmazonEC2', 'Web-Server-EC2', 
    'arn:aws:ec2:ap-northeast-1:123456789012:instance/i-0123456789abcdef0', 
    'EC2 Instance', 'ap-northeast-1', 'RUNNING', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM'
) ON CONFLICT (resource_id) DO NOTHING;

-- 3. コスト実績初期データ
INSERT INTO monitor.t_daily_cost (id, account_id, service_code, target_date, cost_amount_jpy, cost_amount_usd, ins_dttm, up_dttm, up_empcd)
VALUES (1, '123456789012', 'AmazonEC2', '2026-08-24', 1500.00, 10.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM')
ON CONFLICT (id) DO NOTHING;

-- 4. 予算初期データ (新規追加)
INSERT INTO monitor.t_cost_budget (
    id, account_id, budget_name, period_type, budget_amount, currency, start_date, end_date, warning_threshold, critical_threshold, ins_dttm, up_dttm, up_empcd
) VALUES (
    1, '123456789012', '月間全体予算', 'MONTHLY', 500.00, 'USD', '2026-08-01', '2026-08-31', 80.00, 100.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM'
) ON CONFLICT (id) DO NOTHING;

-- 5. アラート初期データ (新規追加)
INSERT INTO monitor.t_cost_alert (
    id, account_id, service_code, alert_type, threshold_value, actual_value, status, detected_dttm, ins_dttm, up_dttm, up_empcd
) VALUES (
    1, '123456789012', 'AmazonEC2', 'WARNING', 400.00, 420.00, 'OPEN', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM'
) ON CONFLICT (id) DO NOTHING;