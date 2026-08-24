package com.finops.cloudmonitorapi.controller;

import com.finops.cloudmonitorapi.entity.DailyCost;
import com.finops.cloudmonitorapi.repository.DailyCostRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/daily-costs")
@CrossOrigin(origins = "*")
public class DailyCostController {

    @Autowired
    private DailyCostRepository dailyCostRepository;

    @GetMapping
    public List<DailyCost> getAllDailyCosts() {
        return dailyCostRepository.findAll();
    }
}