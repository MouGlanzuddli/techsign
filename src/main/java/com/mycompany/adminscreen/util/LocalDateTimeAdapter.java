package com.mycompany.adminscreen.util;

import com.google.gson.*;
import java.lang.reflect.Type;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

public class LocalDateTimeAdapter implements JsonSerializer<LocalDateTime>, JsonDeserializer<LocalDateTime> {
    
    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    
    @Override
    public JsonElement serialize(LocalDateTime src, Type typeOfSrc, JsonSerializationContext context) {
        if (src == null) {
            return JsonNull.INSTANCE;
        }
        try {
            return new JsonPrimitive(src.format(formatter));
        } catch (Exception e) {
            // Fallback to ISO format if our format fails
            return new JsonPrimitive(src.toString());
        }
    }
    
    @Override
    public LocalDateTime deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context)
            throws JsonParseException {
        if (json == null || json.isJsonNull()) {
            return null;
        }
        
        String dateTimeString = json.getAsString();
        if (dateTimeString == null || dateTimeString.trim().isEmpty()) {
            return null;
        }
        
        try {
            return LocalDateTime.parse(dateTimeString, formatter);
        } catch (DateTimeParseException e) {
            try {
                // Try ISO format as fallback
                return LocalDateTime.parse(dateTimeString);
            } catch (DateTimeParseException e2) {
                throw new JsonParseException("Unable to parse date: " + dateTimeString, e2);
            }
        }
    }
} 