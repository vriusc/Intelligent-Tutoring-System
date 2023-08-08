package com.example.demo.entity;

import lombok.Data;

/**
 * (ErrorResponse) entity
 *
 * @author qianyongru
 * @since 2023-06-23 19:27:35
 */
@Data
public class ErrorResponse {
    private String message;

    public ErrorResponse(String message) {
        this.message = message;
    }
}
