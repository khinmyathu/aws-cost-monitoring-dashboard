INSERT INTO monitor.t_aws_account (account_id, account_name) 
VALUES ('123456789012', 'Production-Account')
ON CONFLICT (account_id) DO NOTHING;

INSERT INTO monitor.t_resource_inventory (resource_id, account_id, resource_name, service_code, status)
VALUES ('res-ec2-001', '123456789012', 'Web-Server-EC2', 'AmazonEC2', 'RUNNING')
ON CONFLICT DO NOTHING;

INSERT INTO monitor.t_daily_cost (id, account_id, service_code, target_date, cost_amount_jpy, cost_amount_usd)
VALUES (1, '123456789012', 'AmazonEC2', '2026-08-24', 1500.00, 10.00)
ON CONFLICT DO NOTHING;