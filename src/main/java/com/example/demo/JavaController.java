package com.example.demo;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api")
public class JavaController {

    @GetMapping("/test")
    public ResponseEntity<String> checkec2()
    {
        return ResponseEntity.ok("checking done...");
    }

}
