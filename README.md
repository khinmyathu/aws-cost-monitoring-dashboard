# AWS FinOps & Cost Monitoring Dashboard

[日本語](#日本語) | [English](#english)

---

## 日本語

AWS 環境におけるクラウドリソースと利用コストを可視化・管理するための FinOps ダッシュボードアプリケーションです。
**AWS ネイティブ環境（S3, CloudFront, EC2, RDS）** へのフルスタック移行を完了し、本番運用を行っています。

### 📸 スクリーンショット
<img width="933" height="1283" alt="Image" src="[https://github.com/user-attachments/assets/3340edb6-5793-4ec8-a72a-2f80ce9e1725](https://github.com/user-attachments/assets/3340edb6-5793-4ec8-a72a-2f80ce9e1725)" />

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
