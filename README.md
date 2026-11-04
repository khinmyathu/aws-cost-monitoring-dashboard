# AWS FinOps & Cost Monitoring Dashboard

[🇯🇵 日本語](#japanese) | [🇺🇸 English](#english)

---

<span id="japanese"></span>
## 日本語

AWS 環境におけるクラウドリソースと利用コストを可視化・管理するための FinOps ダッシュボードアプリケーションです。
**AWS ネイティブ環境（S3, CloudFront, EC2, RDS）** へのフルスタック移行を完了し、本番運用を行っています。

### 📸 スクリーンショット
<img width="981" height="1256" alt="Image" src="https://github.com/user-attachments/assets/d8daba30-3085-4811-aceb-b24bb012a2c9" />

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
- [x] **v1.0:** フルスタック MVP 開発とホスティング環境（Render / Vercel）での公開
- [x] **v2.0:** AWS ネイティブ環境へのインフラ完全移行 (S3/CloudFront, EC2, RDS, Route 53)
- [ ] **v2.1:** AWS Cost Explorer API を用いたデータ自動連携

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
    m_aws_account ||--o{ t_resource_inventory : "1 : N"

    m_aws_service ||--o{ t_daily_cost : "1 : N"
    m_aws_service ||--o{ t_resource_inventory : "1 : N"

    t_cost_budget ||--o{ t_cost_alert : "1 : N (FK)"

    m_aws_account {
        CHARACTER account_id PK "アカウントID"
        CHARACTER account_name "アカウント名"
        NUMERIC env_type "環境区分"
        TIMESTAMP ins_dttm "作成日時"
        CHARACTER up_empcd "更新者"
        TIMESTAMP up_dttm "更新日時"
    }

    m_aws_service {
        CHARACTER service_code PK "サービスコード"
        CHARACTER service_name "サービス名"
        CHARACTER category "カテゴリ"
        TIMESTAMP ins_dttm "作成日時"
        CHARACTER up_empcd "更新者"
        TIMESTAMP up_dttm "更新日時"
    }

    t_daily_cost {
        NUMERIC id PK "サロゲートキー"
        DATE target_date "利用日"
        CHARACTER account_id FK "AWSアカウントID"
        CHARACTER service_code FK "サービスコード"
        NUMERIC cost_amount_usd "利用料金(USD)"
        NUMERIC cost_amount_jpy "利用料金(円換算)"
        TIMESTAMP ins_dttm "作成日時"
        CHARACTER up_empcd "更新者"
        TIMESTAMP up_dttm "更新日時"
    }

    t_cost_budget {
        BIGINT id PK "予算ID"
        VARCHAR account_id FK "AWSアカウントID"
        VARCHAR budget_name "予算名称"
        VARCHAR period_type "期間種別"
        NUMERIC budget_amount "予算額"
        VARCHAR currency "通貨"
        DATE start_date "適用開始日"
        DATE end_date "適用終了日"
        NUMERIC warning_threshold "警告閾値(%)"
        NUMERIC critical_threshold "危険閾値(%)"
        TIMESTAMP ins_dttm "作成日時"
        VARCHAR up_empcd "更新者"
        TIMESTAMP up_dttm "更新日時"
    }

    t_cost_alert {
        BIGINT id PK "アラートID"
        VARCHAR account_id FK "AWSアカウントID"
        BIGINT budget_id FK "対象予算ID"
        VARCHAR target_month "対象年月(YYYY-MM)"
        VARCHAR alert_type "アラート種別"
        NUMERIC threshold_value "判定基準閾値額(USD)"
        NUMERIC actual_value "月間利用実績額(USD)"
        TIMESTAMP ins_dttm "作成日時"
        VARCHAR up_empcd "更新者"
        TIMESTAMP up_dttm "更新日時"
    }

    t_resource_inventory {
        VARCHAR resource_id PK "リソースID"
        VARCHAR account_id FK "AWSアカウントID"
        VARCHAR service_code FK "サービスコード"
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
```

---

<span id="english"></span>
## English

A cloud cost visualization and FinOps monitoring dashboard application built with **React**, **Spring Boot 3**, and **PostgreSQL**, deployed entirely on **AWS Cloud Infrastructure**.

### Architecture & Tech Stack
- **Frontend**: React (Vite), Recharts — Hosted on **Amazon S3** + **Amazon CloudFront**
- **Backend**: Java 17, Spring Boot 3, Spring Data JPA (Hibernate) — Deployed on **Amazon EC2** (Public Subnet)
- **Database**: PostgreSQL 18 — Hosted on **Amazon RDS** (Isolated in Private Subnet)
- **DNS & SSL**: Amazon Route 53 + AWS Certificate Manager (ACM)
- **Security & Ops**: AWS Systems Manager (SSM Session Manager), VPC network segmentation, environment variables injection for credentials

### Key Features
- **Cost Analytics**: Visualizes daily and monthly AWS usage cost breakdown by service.
- **Budget Monitoring**: Tracks budget thresholds per account/service.
- **Alert Detection & Resolution**: Detects threshold violations and allows in-app alert status resolution.

### Roadmap
- [x] **v1.0:** Full-stack MVP development & deployment on hosting platforms (Render / Vercel)
- [x] **v2.0:** Full infrastructure migration to native AWS (S3/CloudFront, EC2, RDS, Route 53)
- [ ] **v2.1:** Automated cost ingestion via AWS Cost Explorer API

### 🔌 UI to API Mapping

| UI Component | HTTP | Endpoint | Data Handled |
| :--- | :--- | :--- | :--- |
| **Service Daily Costs & Breakdown** | `GET` | `/api/v1/daily-costs` | `serviceCode`, `costAmountUsd` |
| **AWS Accounts List** | `GET` | `/api/v1/accounts` | `accountId`, `accountName` |
| **Monthly Budget** | `GET` | `/api/v1/budgets` | `budgetName`, `budgetAmount`, `warningThreshold` |
| **Alerts (Open)** | `GET` | `/api/v1/alerts?status=OPEN` | `serviceCode`, `actualValue`, `thresholdValue` |
| **Resolve Alert** | `PUT` | `/api/v1/alerts/{id}/resolve` | Updates status to `RESOLVED` |
