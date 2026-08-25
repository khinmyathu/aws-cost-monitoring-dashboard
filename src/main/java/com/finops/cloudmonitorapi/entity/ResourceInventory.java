package com.finops.cloudmonitorapi.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "t_resource_inventory", schema = "monitor")
public class ResourceInventory {

    @Id
    @Column(name = "resource_id")
    private String resourceId;

    @Column(name = "account_id")
    private String accountId;

    @Column(name = "service_code")
    private String serviceCode;

    @Column(name = "resource_name")
    private String resourceName;

    @Column(name = "resource_arn")
    private String resourceArn;

    @Column(name = "resource_type")
    private String resourceType;

    @Column(name = "region")
    private String region;

    @Column(name = "status")
    private String status;

    @Column(name = "last_checked_dttm")
    private LocalDateTime lastCheckedDttm;

    @Column(name = "ins_dttm")
    private LocalDateTime insDttm;

    @Column(name = "up_dttm")
    private LocalDateTime upDttm;

    @Column(name = "up_empcd")
    private String upEmpcd;
}