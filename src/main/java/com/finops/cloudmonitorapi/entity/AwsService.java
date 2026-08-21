package com.finops.cloudmonitorapi.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "m_aws_service", schema = "monitor")
public class AwsService {

    @Id
    @Column(name = "service_code", columnDefinition = "char(16)")
    private String serviceCode;

    @Column(name = "service_name", columnDefinition = "char(64)")
    private String serviceName;

    @Column(name = "category", columnDefinition = "char(64)")
    private String category;

    @Column(name = "ins_dttm", insertable = false, updatable = false)
    private LocalDateTime insDttm;

    @Column(name = "up_empcd", columnDefinition = "char(12)")
    private String upEmpcd;

    @Column(name = "up_dttm", insertable = false, updatable = false)
    private LocalDateTime upDttm;
}