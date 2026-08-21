package com.finops.cloudmonitorapi.config;

import tools.jackson.core.JacksonException;
import tools.jackson.core.JsonGenerator;
import tools.jackson.databind.SerializationContext;
import tools.jackson.databind.ValueSerializer;
import org.springframework.boot.jackson.JacksonComponent;

@JacksonComponent
public class StringTrimSerializer extends ValueSerializer<String> {

    @Override
    public void serialize(String value, JsonGenerator gen, SerializationContext serializers) throws JacksonException {
        if (value != null) {
            // 文字列の先頭と末尾の空白を取り除いてからJSONに出力する
            gen.writeString(value.trim());
        } else {
            gen.writeNull();
        }
    }
}