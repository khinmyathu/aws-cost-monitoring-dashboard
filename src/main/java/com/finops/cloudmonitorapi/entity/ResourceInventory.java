package com.finops.cloudmonitorapi.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;

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

    @Column(name = "status")
    private String status;

    @Column(name = "last_checked_dttm")
    private LocalDateTime lastCheckedDttm;

    @Column(name = "ins_dttm")
    private LocalDateTime insDttm;

    @Column(name = "up_empcd")
    private String upEmpcd;

    @Column(name = "up_dttm")
    private LocalDateTime upDttm;

    // --- 以下、GetterとSetter ---
    public String getResourceId() { return resourceId; }
    public void setResourceId(String resourceId) { this.resourceId = resourceId; }

    public String getAccountId() { return accountId; }
    public void setAccountId(String accountId) { this.accountId = accountId; }

    public String getServiceCode() { return serviceCode; }
    public void setServiceCode(String serviceCode) { this.serviceCode = serviceCode; }

    public String getResourceName() { return resourceName; }
    public void setResourceName(String resourceName) { this.resourceName = resourceName; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public LocalDateTime getLastCheckedDttm() { return lastCheckedDttm; }
    public void setLastCheckedDttm(LocalDateTime lastCheckedDttm) { this.lastCheckedDttm = lastCheckedDttm; }

    public LocalDateTime getInsDttm() { return insDttm; }
    public void setInsDttm(LocalDateTime insDttm) { this.insDttm = insDttm; }

    public String getUpEmpcd() { return upEmpcd; }
    public void setUpEmpcd(String upEmpcd) { this.upEmpcd = upEmpcd; }

    public LocalDateTime getUpDttm() { return upDttm; }
    public void setUpDttm(LocalDateTime upDttm) { this.upDttm = upDttm; }
}