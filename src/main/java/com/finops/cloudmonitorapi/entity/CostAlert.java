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

    @Column(name = "service_code")
    private String serviceCode;

    @Column(name = "alert_type")
    private String alertType;

    @Column(name = "threshold_value")
    private BigDecimal thresholdValue;

    @Column(name = "actual_value")
    private BigDecimal actualValue;

    @Column(name = "status")
    private String status;

    @Column(name = "detected_dttm")
    private LocalDateTime detectedDttm;

    @Column(name = "resolved_dttm")
    private LocalDateTime resolvedDttm;

    @Column(name = "ins_dttm")
    private LocalDateTime insDttm;

    @Column(name = "up_dttm")
    private LocalDateTime upDttm;

    @Column(name = "up_empcd")
    private String upEmpcd;
}
