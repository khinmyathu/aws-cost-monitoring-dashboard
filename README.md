# aws-cost-monitoring-dashboard
AWS Cost and Resource Monitoring Dashboard (Spring Boot 3 / Python / PostgreSQL)
## データベース設計（ER図）

本プロジェクトのデータベースはPostgreSQLを使用し、以下の設計としています。

```mermaid
erDiagram
    m_aws_account ||--o{ t_resource_inventory : "1 : N"
    m_aws_account ||--o{ t_daily_cost : "1 : N"
    m_aws_account ||--o{ t_cost_budget : "1 : N"
    m_aws_account ||--o{ t_cost_alert : "1 : N"

    m_aws_service ||--o{ t_resource_inventory : "1 : N"
    m_aws_service ||--o{ t_daily_cost : "1 : N"
    m_aws_service ||--o{ t_cost_alert : "1 : N"

    m_aws_service {
        CHARACTER service_code PK "サービスコード"
        CHARACTER service_name "サービス名"
        CHARACTER category "カテゴリ"
        TIMESTAMP ins_dttm "作成日時"
        CHARACTER up_empcd "更新者"
        TIMESTAMP up_dttm "更新日時"
    }

    m_aws_account {
        VARCHAR account_id PK "AWSアカウントID"
        VARCHAR account_name "アカウント名"
        TIMESTAMP ins_dttm "作成日時"
        TIMESTAMP up_dttm "更新日時"
        VARCHAR up_empcd "更新者"
    }

    t_resource_inventory {
        VARCHAR resource_id PK "リソースID"
        VARCHAR account_id FK "AWSアカウントID"
        CHARACTER service_code FK "サービスコード"
        VARCHAR resource_name "リソース名"
        VARCHAR resource_arn "リソースARN"
        VARCHAR resource_type "リソース種別"
        VARCHAR region "リージョン"
        VARCHAR status "ステータス"
        TIMESTAMP last_checked_dttm "最終確認日時"
        TIMESTAMP ins_dttm "作成日時"
        VARCHAR up_empcd "更新者"
        TIMESTAMP up_dttm "更新日時"
    }

    t_daily_cost {
        BIGINT id PK "ID"
        VARCHAR account_id FK "AWSアカウントID"
        CHARACTER service_code FK "サービスコード"
        DATE target_date "対象日付"
        NUMERIC cost_amount_jpy "コスト(JPY)"
        NUMERIC cost_amount_usd "コスト(USD)"
        TIMESTAMP ins_dttm "作成日時"
        TIMESTAMP up_dttm "更新日時"
        VARCHAR up_empcd "更新者"
    }

    t_cost_budget {
        BIGINT id PK "予算ID"
        VARCHAR account_id FK "AWSアカウントID"
        VARCHAR budget_name "予算名称"
        VARCHAR period_type "期間種別"
        NUMERIC budget_amount "予算額"
        VARCHAR currency "通貨"
        DATE start_date "開始日"
        DATE end_date "終了日"
        NUMERIC warning_threshold "警告閾値(%)"
        NUMERIC critical_threshold "危険閾値(%)"
        TIMESTAMP ins_dttm "作成日時"
        VARCHAR up_empcd "更新者"
        TIMESTAMP up_dttm "更新日時"
    }

    t_cost_alert {
        BIGINT id PK "アラートID"
        VARCHAR account_id FK "AWSアカウントID"
        CHARACTER service_code FK "サービスコード"
        VARCHAR alert_type "アラート種別"
        NUMERIC threshold_value "判定時閾値"
        NUMERIC actual_value "実績値"
        VARCHAR status "ステータス"
        TIMESTAMP detected_dttm "検知日時"
        TIMESTAMP resolved_dttm "解消日時"
        TIMESTAMP ins_dttm "作成日時"
        VARCHAR up_empcd "更新者"
        TIMESTAMP up_dttm "更新日時"
    }
```
