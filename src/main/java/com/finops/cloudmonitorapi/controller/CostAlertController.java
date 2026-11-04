package com.finops.cloudmonitorapi.controller;

import com.finops.cloudmonitorapi.entity.CostAlert;
import com.finops.cloudmonitorapi.repository.CostAlertRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/alerts")
@CrossOrigin(origins = "*")
public class CostAlertController {

    @Autowired
    private CostAlertRepository costAlertRepository;

    @GetMapping
    public List<CostAlert> getAllAlerts(
            @RequestParam(required = false) String accountId,
            @RequestParam(required = false) String targetMonth) {

        if (accountId != null && !accountId.isEmpty() && targetMonth != null && !targetMonth.isEmpty()) {
            return costAlertRepository.findByAccountIdAndTargetMonth(accountId, targetMonth);
        }
        if (accountId != null && !accountId.isEmpty()) {
            return costAlertRepository.findByAccountId(accountId);
        }
        return costAlertRepository.findAll();
    }
}