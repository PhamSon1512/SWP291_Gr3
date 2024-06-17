package config;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Validate {

    public static boolean checkPhone(String phone) {
        String regex = "\\d{10}";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(phone);
        return matcher.matches();
    }

    public static boolean checkUsername(String username) {
        String regex = "^[a-zA-Z0-9]([a-zA-Z0-9]+[_.])*[a-zA-Z0-9]+$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(username);
        return matcher.matches();
    }

    public static boolean checkEmail(String email) {
        String regex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }

//    public static String capitalizeFirstLetter(String s) {
//        String[] words = s.toLowerCase().split("\\s+");
//        StringBuilder capitalized = new StringBuilder();
//        for (String word : words) {
//            if (!word.isEmpty()) {
//                capitalized.append(Character.toUpperCase(word.charAt(0)))
//                        .append(word.substring(1))
//                        .append(" ");
//            }
//        }
//        return capitalized.toString().trim();
//    }

   public static boolean checkFullName(String fullname) {
    String regex = "^[\\p{L} ]+$";
    Pattern pattern = Pattern.compile(regex);
    Matcher matcher = pattern.matcher(fullname);
    return matcher.matches();
}


    public static boolean checkPassword(String password) {
        String regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d]{8,}$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(password);
        return matcher.matches();
    }

}
