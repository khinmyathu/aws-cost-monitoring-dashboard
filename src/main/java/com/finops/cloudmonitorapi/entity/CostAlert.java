package com.finops.cloudmonitorapi.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "t_cost_alert", schema = "monitor")
public class CostAlert {

    @Id
    @Column(name = "id")
    private Long id;

    @Column(name = "account_id")
    private String accountId;

    @Column(name = "budget_id")
    private Long budgetId;

    @Column(name = "target_month")
    private String targetMonth;

    @Column(name = "alert_type")
    private String alertType;

    @Column(name = "threshold_value")
    private BigDecimal thresholdValue;

    @Column(name = "actual_value")
    private BigDecimal actualValue;

    @Column(name = "ins_dttm")
    private LocalDateTime insDttm;

    @Column(name = "up_dttm")
    private LocalDateTime upDttm;

    @Column(name = "up_empcd")
    private String upEmpcd;
}