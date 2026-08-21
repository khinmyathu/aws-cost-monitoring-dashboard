package com.finops.cloudmonitorapi.repository;

import com.finops.cloudmonitorapi.entity.ResourceInventory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ResourceInventoryRepository extends JpaRepository<ResourceInventory, String> {
}