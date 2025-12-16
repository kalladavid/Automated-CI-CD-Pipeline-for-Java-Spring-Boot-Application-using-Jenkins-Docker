package com.example.employee;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class EmployeeController {

    @GetMapping("/")
    public String home() {
        return "Employee Management Application is Running 🚀";
    }

    @GetMapping("/health")
    public String health() {
        return "Application is Healthy ✅";
    }
}

