package util;

import java.security.SecureRandom;

public class OtpGenerator {
    private static final String NUMBERS = "0123456789";
    private static final SecureRandom random = new SecureRandom();
    
    public static String generateOtp(int length) {
        StringBuilder otp = new StringBuilder();
        for (int i = 0; i < length; i++) {
            otp.append(NUMBERS.charAt(random.nextInt(NUMBERS.length())));
        }
        return otp.toString();
    }
    
    public static String generateSixDigitOtp() {
        return generateOtp(6);
    }
}