INSERT INTO monitor.t_aws_account (account_id, account_name) 
VALUES ('123456789012', 'Test Account') 
ON CONFLICT DO NOTHING;

-- アカウントの初期データ
INSERT INTO monitor.t_aws_account (account_id, account_name) 
VALUES ('123456789012', 'Test Account') 
ON CONFLICT DO NOTHING;

-- リソースの初期データ（テーブル名・カラム名はEntity定義に合わせて調整）
INSERT INTO monitor.t_resource_inventory (resource_id, account_id, resource_name, service_code, status)
VALUES ('res-001', '123456789012', 'Test EC2', 'AmazonEC2', 'RUNNING')
ON CONFLICT DO NOTHING;