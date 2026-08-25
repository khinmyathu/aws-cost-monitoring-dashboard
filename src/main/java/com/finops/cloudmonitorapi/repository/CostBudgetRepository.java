package com.finops.cloudmonitorapi.repository;

import com.finops.cloudmonitorapi.entity.CostBudget;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CostBudgetRepository extends JpaRepository<CostBudget, Long> {
    List<CostBudget> findByAccountId(String accountId);
}
