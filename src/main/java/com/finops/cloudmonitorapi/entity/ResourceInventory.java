package com.finops.cloudmonitorapi.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "t_resource_inventory", schema = "monitor")
public class ResourceInventory {

    @Id
    @Column(name = "resource_id", columnDefinition = "char(64)")
    private String resourceId;

    @Column(name = "account_id", columnDefinition = "char(64)")
    private String accountId;

    @Column(name = "service_code", columnDefinition = "char(64)")
    private String serviceCode;

    @Column(name = "resource_name", columnDefinition = "char(64)")
    private String resourceName;

    @Column(name = "status", columnDefinition = "char(64)")
    private String status;

    @Column(name = "last_checked_dttm")
    private LocalDateTime lastCheckedDttm;

    @Column(name = "ins_dttm", insertable = false, updatable = false)
    private LocalDateTime insDttm;

    @Column(name = "up_empcd", columnDefinition = "char(12)")
    private String upEmpcd;

    @Column(name = "up_dttm", insertable = false, updatable = false)
    private LocalDateTime upDttm;
}