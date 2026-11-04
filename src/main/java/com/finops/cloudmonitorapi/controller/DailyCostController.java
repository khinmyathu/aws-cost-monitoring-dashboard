package com.finops.cloudmonitorapi.controller;

import com.finops.cloudmonitorapi.entity.DailyCost;
import com.finops.cloudmonitorapi.repository.DailyCostRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/v1/daily-costs")
@CrossOrigin(origins = "*")
public class DailyCostController {

    @Autowired
    private DailyCostRepository dailyCostRepository;

    @GetMapping
    public List<DailyCost> getDailyCosts(
            @RequestParam(required = false) String accountId,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {

        if (accountId != null && !accountId.isEmpty() && startDate != null && endDate != null) {
            return dailyCostRepository.findByAccountIdAndTargetDateBetweenOrderByTargetDateAsc(
                    accountId, startDate, endDate
            );
        }

        return dailyCostRepository.findAll();
    }
}