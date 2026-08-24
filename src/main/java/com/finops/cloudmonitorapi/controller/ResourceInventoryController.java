package com.finops.cloudmonitorapi.controller;

import com.finops.cloudmonitorapi.entity.ResourceInventory;
import com.finops.cloudmonitorapi.repository.ResourceInventoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/resource-inventories")
public class ResourceInventoryController {

    @Autowired
    private ResourceInventoryRepository resourceInventoryRepository;

    @GetMapping
    public List<ResourceInventory> getAllResourceInventories() {
        return resourceInventoryRepository.findAll();
    }
}