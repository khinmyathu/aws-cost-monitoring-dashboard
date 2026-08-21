package com.finops.cloudmonitorapi.service;

import com.finops.cloudmonitorapi.entity.AwsAccount;
import com.finops.cloudmonitorapi.repository.AwsAccountRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AwsAccountService {

    private final AwsAccountRepository awsAccountRepository;

    // アカウント一覧を全件取得するメソッド
    public List<AwsAccount> getAllAccounts() {
        return awsAccountRepository.findAll();
    }
}