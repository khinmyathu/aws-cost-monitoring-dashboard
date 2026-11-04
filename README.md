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
