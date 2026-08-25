package com.finops.cloudmonitorapi.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "t_cost_budget", schema = "monitor")
public class CostBudget {

    @Id
    @Column(name = "id")
    private Long id;

    @Column(name = "account_id")
    private String accountId;

    @Column(name = "budget_name")
    private String budgetName;

    @Column(name = "period_type")
    private String periodType;

    @Column(name = "budget_amount")
    private BigDecimal budgetAmount;

    @Column(name = "currency")
    private String currency;

    @Column(name = "start_date")
    private LocalDate startDate;

    @Column(name = "end_date")
    private LocalDate endDate;

    @Column(name = "warning_threshold")
    private BigDecimal warningThreshold;

    @Column(name = "critical_threshold")
    private BigDecimal criticalThreshold;

    @Column(name = "ins_dttm")
    private LocalDateTime insDttm;

    @Column(name = "up_dttm")
    private LocalDateTime upDttm;

    @Column(name = "up_empcd")
    private String upEmpcd;
}
