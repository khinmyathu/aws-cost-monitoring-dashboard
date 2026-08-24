package com.finops.cloudmonitorapi.config;

import tools.jackson.core.JacksonException;
import tools.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.json.JsonTest;

import static org.junit.jupiter.api.Assertions.assertEquals;

@JsonTest
public class StringTrimSerializerTest {

    // Spring Bootが自動で用意してくれるJSON変換ツール
    @Autowired
    private ObjectMapper objectMapper;

    @Test
    public void testStringTrimming() throws JacksonException {
        // 1. 準備：前後に余白がある文字列を持つダミーデータを作成
        DummyDto dto = new DummyDto();
        dto.setName("   Hello FinOps   ");

        // 2. 実行：データをJSON文字列に変換
        String jsonResult = objectMapper.writeValueAsString(dto);

        // 3. 検証：余白が消えて "Hello FinOps" になっているか確認
        // JSONの形は {"name":"Hello FinOps"} になるはずです
        assertEquals("{\"name\":\"Hello FinOps\"}", jsonResult);
    }

    // テスト用のダミークラス
    static class DummyDto {
        private String name;
        
        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }
    }
}