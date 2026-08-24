package com.finops.cloudmonitorapi.controller;

import com.finops.cloudmonitorapi.entity.AwsAccount;
import com.finops.cloudmonitorapi.service.AwsAccountService;
import lombok.RequiredArgsConstructor;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/accounts")
@CrossOrigin(origins = "*")
@RequiredArgsConstructor
public class AwsAccountController {

    private final AwsAccountService awsAccountService;

    // GET: http://localhost:8081/api/v1/accounts
    @GetMapping
    public List<AwsAccount> getAllAccounts() {
        return awsAccountService.getAllAccounts();
    }
}