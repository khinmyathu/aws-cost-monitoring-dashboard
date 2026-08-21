package com.finops.cloudmonitorapi.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "m_aws_account", schema = "monitor")
public class AwsAccount {

    @Id
    @Column(name = "account_id", columnDefinition = "char(16)")
    private String accountId;

    @Column(name = "account_name", columnDefinition = "char(64)")
    private String accountName;

    @Column(name = "env_type")
    private BigDecimal envType;

    @Column(name = "ins_dttm", insertable = false, updatable = false)
    private LocalDateTime insDttm;

    @Column(name = "up_empcd", columnDefinition = "char(12)")
    private String upEmpcd;

    @Column(name = "up_dttm", insertable = false, updatable = false)
    private LocalDateTime upDttm;
}