package com.finops.cloudmonitorapi.repository;

import com.finops.cloudmonitorapi.entity.DailyCost;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface DailyCostRepository extends JpaRepository<DailyCost, Long> {

    // targetDate の期間指定で取得
    List<DailyCost> findByAccountIdAndTargetDateBetweenOrderByTargetDateAsc(
            String accountId, LocalDate startDate, LocalDate endDate
    );
}