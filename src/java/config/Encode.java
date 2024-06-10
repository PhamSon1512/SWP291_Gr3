package config;

import java.util.Base64;
import java.nio.charset.StandardCharsets;
import java.util.Objects;

public class Encode {

    public static String enCode(String s) {
        Objects.requireNonNull(s, "Input string must not be null");
        byte[] data = s.getBytes(StandardCharsets.UTF_8);
        return Base64.getEncoder().encodeToString(data);
    }

    public static String deCode(String s) {
        Objects.requireNonNull(s, "Input string must not be null");
        byte[] decodedBytes = Base64.getDecoder().decode(s);
        return new String(decodedBytes, StandardCharsets.UTF_8);
    }
}
