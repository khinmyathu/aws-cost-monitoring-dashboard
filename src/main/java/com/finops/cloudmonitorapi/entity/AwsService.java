package com.finops.cloudmonitorapi.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;

@Entity
@Table(name = "m_aws_service", schema = "monitor") // ※スキーマ名は環境に合わせてください
public class AwsService {

    @Id
    @Column(name = "service_code")
    private String serviceCode;

    @Column(name = "service_name")
    private String serviceName;

    @Column(name = "category")
    private String category;

    @Column(name = "ins_dttm")
    private LocalDateTime insDttm;

    @Column(name = "up_empcd")
    private String upEmpcd;

    @Column(name = "up_dttm")
    private LocalDateTime upDttm;

    // --- 以下、GetterとSetter ---
    public String getServiceCode() { return serviceCode; }
    public void setServiceCode(String serviceCode) { this.serviceCode = serviceCode; }

    public String getServiceName() { return serviceName; }
    public void setServiceName(String serviceName) { this.serviceName = serviceName; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public LocalDateTime getInsDttm() { return insDttm; }
    public void setInsDttm(LocalDateTime insDttm) { this.insDttm = insDttm; }

    public String getUpEmpcd() { return upEmpcd; }
    public void setUpEmpcd(String upEmpcd) { this.upEmpcd = upEmpcd; }

    public LocalDateTime getUpDttm() { return upDttm; }
    public void setUpDttm(LocalDateTime upDttm) { this.upDttm = upDttm; }
}