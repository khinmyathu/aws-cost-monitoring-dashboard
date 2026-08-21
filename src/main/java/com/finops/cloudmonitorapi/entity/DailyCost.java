package com.finops.cloudmonitorapi.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "t_daily_cost", schema = "monitor")
public class DailyCost {

    @Id
    @Column(name = "id")
    private Long id;

    @Column(name = "target_date")
    private LocalDate targetDate;

    @Column(name = "account_id", columnDefinition = "char(64)")
    private String accountId;

    @Column(name = "service_code", columnDefinition = "char(64)")
    private String serviceCode;

    @Column(name = "cost_amount_usd")
    private BigDecimal costAmountUsd;

    @Column(name = "cost_amount_jpy")
    private BigDecimal costAmountJpy;

    @Column(name = "ins_dttm", insertable = false, updatable = false)
    private LocalDateTime insDttm;

    @Column(name = "up_empcd", columnDefinition = "char(12)")
    private String upEmpcd;

    @Column(name = "up_dttm", insertable = false, updatable = false)
    private LocalDateTime upDttm;
}