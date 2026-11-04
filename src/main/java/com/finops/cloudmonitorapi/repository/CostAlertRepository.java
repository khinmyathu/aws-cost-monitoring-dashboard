package com.finops.cloudmonitorapi.repository;

import com.finops.cloudmonitorapi.entity.CostAlert;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CostAlertRepository extends JpaRepository<CostAlert, Long> {
    List<CostAlert> findByAccountId(String accountId);
    List<CostAlert> findByAccountIdAndTargetMonth(String accountId, String targetMonth);
}