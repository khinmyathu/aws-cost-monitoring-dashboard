INSERT INTO monitor.m_aws_account (account_id, account_name, ins_dttm, up_dttm, up_empcd) 
VALUES ('123456789012', 'Production-Account', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM')
ON CONFLICT (account_id) DO NOTHING;

INSERT INTO monitor.t_resource_inventory (resource_id, account_id, resource_name, service_code, status, last_checked_dttm, ins_dttm, up_dttm, up_empcd)
VALUES ('res-ec2-001', '123456789012', 'Web-Server-EC2', 'AmazonEC2', 'RUNNING', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM')
ON CONFLICT (resource_id) DO NOTHING;

INSERT INTO monitor.t_daily_cost (id, account_id, service_code, target_date, cost_amount_jpy, cost_amount_usd, ins_dttm, up_dttm, up_empcd)
VALUES (1, '123456789012', 'AmazonEC2', '2026-08-24', 1500.00, 10.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'SYSTEM')
ON CONFLICT (id) DO NOTHING;