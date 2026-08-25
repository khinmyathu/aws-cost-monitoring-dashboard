package com.finops.cloudmonitorapi.controller;

import com.finops.cloudmonitorapi.entity.CostBudget;
import com.finops.cloudmonitorapi.repository.CostBudgetRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/v1/budgets")
@CrossOrigin(origins = "*")
public class CostBudgetController {

    @Autowired
    private CostBudgetRepository costBudgetRepository;

    @GetMapping
    public List<CostBudget> getAllBudgets(@RequestParam(required = false) String accountId) {
        if (accountId != null && !accountId.isEmpty()) {
            return costBudgetRepository.findByAccountId(accountId);
        }
        return costBudgetRepository.findAll();
    }

    @PostMapping
    public CostBudget createBudget(@RequestBody CostBudget budget) {
        budget.setInsDttm(LocalDateTime.now());
        budget.setUpDttm(LocalDateTime.now());
        budget.setUpEmpcd("SYSTEM");
        return costBudgetRepository.save(budget);
    }
}
