package com.finops.cloudmonitorapi.repository;

import com.finops.cloudmonitorapi.entity.AwsAccount;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AwsAccountRepository extends JpaRepository<AwsAccount, String> {
}