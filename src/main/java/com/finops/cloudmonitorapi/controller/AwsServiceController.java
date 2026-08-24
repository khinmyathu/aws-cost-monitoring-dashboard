package com.finops.cloudmonitorapi.controller;

import com.finops.cloudmonitorapi.entity.AwsService;
import com.finops.cloudmonitorapi.repository.AwsServiceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/services")
@CrossOrigin(origins = "*")
public class AwsServiceController {

    @Autowired
    private AwsServiceRepository awsServiceRepository;

    @GetMapping
    public List<AwsService> getAllServices() {
        // データベースからすべてのサービス情報を取得して返す
        return awsServiceRepository.findAll();
    }
}