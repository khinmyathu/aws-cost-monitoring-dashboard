package com.finops.cloudmonitorapi.repository;

import com.finops.cloudmonitorapi.entity.AwsService;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AwsServiceRepository extends JpaRepository<AwsService, String> {
}