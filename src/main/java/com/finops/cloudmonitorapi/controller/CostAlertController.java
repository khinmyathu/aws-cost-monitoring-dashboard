package com.finops.cloudmonitorapi.controller;

import com.finops.cloudmonitorapi.entity.CostAlert;
import com.finops.cloudmonitorapi.repository.CostAlertRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
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
            @RequestParam(required = false) String status) {
        if (accountId != null && !accountId.isEmpty()) {
            return costAlertRepository.findByAccountId(accountId);
        }
        if (status != null && !status.isEmpty()) {
            return costAlertRepository.findByStatus(status);
        }
        return costAlertRepository.findAll();
    }

    @PutMapping("/{id}/resolve")
    public ResponseEntity<CostAlert> resolveAlert(@PathVariable Long id) {
        return costAlertRepository.findById(id)
                .map(alert -> {
                    alert.setStatus("RESOLVED");
                    alert.setResolvedDttm(LocalDateTime.now());
                    alert.setUpDttm(LocalDateTime.now());
                    return ResponseEntity.ok(costAlertRepository.save(alert));
                })
                .orElse(ResponseEntity.notFound().build());
    }
}