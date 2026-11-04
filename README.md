# AWS FinOps & Cost Monitoring Dashboard

[English](#english) | [日本語](#japanese)

---

<a name="english"></a>
## English

A cloud cost visualization and FinOps monitoring dashboard application built with **React**, **Spring Boot 3**, and **PostgreSQL**, deployed entirely on **AWS Cloud Infrastructure**.

### Architecture
- **Frontend**: React (Vite), Recharts — Hosted on **Amazon S3** + **Amazon CloudFront**
- **Backend**: Spring Boot 3, Java 17, Spring Data JPA (Hibernate) — Deployed on **Amazon EC2** (Public Subnet)
- **Database**: PostgreSQL 18 — Hosted on **Amazon RDS** (Isolated in Private Subnet)
- **DNS & SSL**: Amazon Route 53 + AWS Certificate Manager (ACM)
- **Security**: 
  - VPC network segmentation (Public/Private Subnets)
  - IAM Instance Profile for least-privilege access
  - Database credentials externalized and injected at runtime via arguments/environment variables

### Key Features
- **Cost Analytics**: Visualizes daily and monthly AWS usage cost breakdown by service.
- **Budget Monitoring**: Tracks budget thresholds per account/service.
- **Alert Detection & Resolution**: Detects threshold violations and allows in-app alert status resolution.

### UI to API Mapping

| UI Component | HTTP | Endpoint | Data Handled |
| :--- | :--- | :--- | :--- |
| **Service Daily Costs & Breakdown** | `GET` | `/api/v1/daily-costs` | `serviceCode`, `costAmountUsd` |
| **AWS Accounts List** | `GET` | `/api/v1/accounts` | `accountId`, `accountName` |
| **Monthly Budget** | `GET` | `/api/v1/budgets` | `budgetName`, `budgetAmount`, `warningThreshold` |
| **Alerts (Open)** | `GET` | `/api/v1/alerts?status=OPEN` | `serviceCode`, `actualValue`, `thresholdValue` |
| **Resolve Alert** | `PUT` | `/api/v1/alerts/{id}/resolve` | Updates status to `RESOLVED` |

### Database Schema (ER Diagram)
```mermaid
erDiagram
    m_aws_account ||--o{ t_daily_cost : "1 : N"
    m_aws_account ||--o{ t_cost_budget : "1 : N"
    m_aws_account ||--o{ t_cost_alert : "1 : N"

    m_aws_service ||--o{ t_daily_cost : "1 : N"
    m_aws_service ||--o{ t_cost_alert : "1 : N"

    m_aws_service {
        CHARACTER service_code PK "Service Code"
        CHARACTER service_name "Service Name"
        CHARACTER category "Category"
        TIMESTAMP ins_dttm "Created At"
        CHARACTER up_empcd "Updated By"
        TIMESTAMP up_dttm "Updated At"
    }

    m_aws_account {
        VARCHAR account_id PK "AWS Account ID"
        VARCHAR account_name "Account Name"
        TIMESTAMP ins_dttm "Created At"
        TIMESTAMP up_dttm "Updated At"
        VARCHAR up_empcd "Updated By"
    }

    t_daily_cost {
        BIGINT id PK "ID"
        VARCHAR account_id FK "AWS Account ID"
        CHARACTER service_code FK "Service Code"
        DATE target_date "Target Date"
        NUMERIC cost_amount_jpy "Cost (JPY)"
        NUMERIC cost_amount_usd "Cost (USD)"
        TIMESTAMP ins_dttm "Created At"
        TIMESTAMP up_dttm "Updated At"
        VARCHAR up_empcd "Updated By"
    }

    t_cost_budget {
        BIGINT id PK "Budget ID"
        VARCHAR account_id FK "AWS Account ID"
        VARCHAR budget_name "Budget Name"
        VARCHAR period_type "Period Type"
        NUMERIC budget_amount "Budget Amount"
        VARCHAR currency "Currency"
        DATE start_date "Start Date"
        DATE end_date "End Date"
        NUMERIC warning_threshold "Warning Threshold (%)"
        NUMERIC critical_threshold "Critical Threshold (%)"
        TIMESTAMP ins_dttm "Created At"
        VARCHAR up_empcd "Updated By"
        TIMESTAMP up_dttm "Updated At"
    }

    t_cost_alert {
        BIGINT id PK "Alert ID"
        VARCHAR account_id FK "AWS Account ID"
        CHARACTER service_code FK "Service Code"
        BIGINT budget_id "Budget ID Reference"
        VARCHAR target_month "Target Month"
        VARCHAR alert_type "Alert Type"
        NUMERIC threshold_value "Threshold Value"
        NUMERIC actual_value "Actual Value"
        VARCHAR status "Status"
        TIMESTAMP detected_dttm "Detected At"
        TIMESTAMP resolved_dttm "Resolved At"
        TIMESTAMP ins_dttm "Created At"
        VARCHAR up_empcd "Updated By"
        TIMESTAMP up_dttm "Updated At"
    }


    # AWS FinOps & Cost Monitoring Dashboard

[日本語](#日本語) | [English](#english)

---

## 日本語

AWS 環境におけるクラウドリソースと利用コストを可視化・管理するための FinOps ダッシュボードアプリケーションです。
**AWS ネイティブ環境（S3, CloudFront, EC2, RDS）** へのフルスタック移行を完了し、本番運用を行っています。

### 📸 スクリーンショット
<img width="933" height="1283" alt="Image" src="https://github.com/user-attachments/assets/3340edb6-5793-4ec8-a72a-2f80ce9e1725" />

### 技術スタック
- **フロントエンド:** React, Vite, Recharts (Amazon S3 + CloudFront にて配信)
- **バックエンド:** Java 17, Spring Boot 3, Spring Data JPA (Amazon EC2 にてホスティング)
- **データベース:** PostgreSQL 18 (Amazon RDS - プライベートサブネット配置)
- **DNS・SSL:** Amazon Route 53 + AWS Certificate Manager (ACM)
- **セキュリティ・運用:** AWS Systems Manager (SSM Session Manager), VPC分離設計

### 主な機能
- **コスト可視化:** サービス別のコスト推移と利用割合を直感的にグラフ表示。
- **予算管理:** アカウント・サービスごとの月間予算と警告閾値のモニタリング。
- **アラート検知・対応:** 予算超過の兆候を検知し、ダッシュボードから確認・解消（Resolve）可能。

### ロードマップ
- **[x] v1.0:** フルスタック MVP 開発とホスティング環境（Render / Vercel）での公開
- **[x] v2.0:** AWS ネイティブ環境へのインフラ完全移行 (S3/CloudFront, EC2, RDS, Route 53)
- **[ ] v2.1:** AWS Cost Explorer API を用いたデータ自動連携

### 🔌 画面構成とAPI仕様 (UI to API Mapping)

| UIコンポーネント (画面) | HTTP | APIエンドポイント | 主な取得・更新データ |
| :--- | :--- | :--- | :--- |
| **サービス別 日次コスト**<br>(棒グラフ) / **コスト割合** (円グラフ) | `GET` | `/api/v1/daily-costs` | `serviceCode` (サービス名)<br>`costAmountUsd` (コスト額) |
| **AWSアカウント** (リスト) | `GET` | `/api/v1/accounts` | `accountId` (アカウントID)<br>`accountName` (アカウント名) |
| **月間コスト予算** (リスト) | `GET` | `/api/v1/budgets` | `budgetName` (予算名)<br>`budgetAmount` (予算額)<br>`warningThreshold` (警告閾値) |
| **アラート** (リスト) | `GET` | `/api/v1/alerts?status=OPEN` | `serviceCode` (対象サービス)<br>`actualValue` (実績値)<br>`thresholdValue` (閾値) |
| **確認済みにする** (ボタン) | `PUT` | `/api/v1/alerts/{id}/resolve` | `status` を "RESOLVED" に更新し、未確認一覧から除外 |

### データベース設計（ER図）
```mermaid
erDiagram
    m_aws_account ||--o{ t_daily_cost : "1 : N"
    m_aws_account ||--o{ t_cost_budget : "1 : N"
    m_aws_account ||--o{ t_cost_alert : "1 : N"

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
        BIGINT budget_id "紐づく予算ID"
        VARCHAR target_month "対象月"
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
