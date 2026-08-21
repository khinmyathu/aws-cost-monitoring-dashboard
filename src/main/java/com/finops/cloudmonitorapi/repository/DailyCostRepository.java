package com.finops.cloudmonitorapi.repository;

import com.finops.cloudmonitorapi.entity.DailyCost;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DailyCostRepository extends JpaRepository<DailyCost, Long> {
}