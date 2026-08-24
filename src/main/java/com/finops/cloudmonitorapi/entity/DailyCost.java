package com.finops.cloudmonitorapi.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "t_daily_cost", schema = "monitor")
public class DailyCost {

    @Id
    @Column(name = "id")
    private Long id;

    @Column(name = "target_date")
    private LocalDate targetDate;

    @Column(name = "account_id")
    private String accountId;

    @Column(name = "service_code")
    private String serviceCode;

    @Column(name = "cost_amount_usd")
    private BigDecimal costAmountUsd;

    @Column(name = "cost_amount_jpy")
    private BigDecimal costAmountJpy;

    @Column(name = "ins_dttm")
    private LocalDateTime insDttm;

    @Column(name = "up_empcd")
    private String upEmpcd;

    @Column(name = "up_dttm")
    private LocalDateTime upDttm;

    // --- 以下、GetterとSetter ---
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public LocalDate getTargetDate() { return targetDate; }
    public void setTargetDate(LocalDate targetDate) { this.targetDate = targetDate; }

    public String getAccountId() { return accountId; }
    public void setAccountId(String accountId) { this.accountId = accountId; }

    public String getServiceCode() { return serviceCode; }
    public void setServiceCode(String serviceCode) { this.serviceCode = serviceCode; }

    public BigDecimal getCostAmountUsd() { return costAmountUsd; }
    public void setCostAmountUsd(BigDecimal costAmountUsd) { this.costAmountUsd = costAmountUsd; }

    public BigDecimal getCostAmountJpy() { return costAmountJpy; }
    public void setCostAmountJpy(BigDecimal costAmountJpy) { this.costAmountJpy = costAmountJpy; }

    public LocalDateTime getInsDttm() { return insDttm; }
    public void setInsDttm(LocalDateTime insDttm) { this.insDttm = insDttm; }

    public String getUpEmpcd() { return upEmpcd; }
    public void setUpEmpcd(String upEmpcd) { this.upEmpcd = upEmpcd; }

    public LocalDateTime getUpDttm() { return upDttm; }
    public void setUpDttm(LocalDateTime upDttm) { this.upDttm = upDttm; }
}