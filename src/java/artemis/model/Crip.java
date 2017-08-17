package artemis.model;

import org.jasypt.util.text.*;

public class Crip{
    private static BasicTextEncryptor bte = new BasicTextEncryptor();
    private  BasicTextEncryptor bt = new BasicTextEncryptor();
    public Crip(){
        bte.setPassword("artemisTeteh270520Wallass");
        bt.setPassword("artemisTeteh270520Wallass");
    }
    public Crip(String key){
        bt.setPassword(key);
    }
    public static String encrypt(String text){
        text = bte.encrypt(text);
        return text;
    }
    public static String decrypt(String text){
        text = bte.decrypt(text);
        return text;
    }
    public String enc(String text){
        text = bt.encrypt(text);
        return text;
    }
    
    public String dec(String text){
        text = bt.decrypt(text);
        return text; 
    }
}
