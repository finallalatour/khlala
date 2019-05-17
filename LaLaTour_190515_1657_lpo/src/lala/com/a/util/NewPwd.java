package lala.com.a.util;

import java.util.Random;

public class NewPwd {
	
	public static String excuteGenerate() {
		int pwdLength = 8;
		
		char[] passwordTable = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O',
				'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0' };
		String accessCode="";
		
        Random random = new Random(System.currentTimeMillis());
        int tablelength = passwordTable.length;
        StringBuffer buf = new StringBuffer();
        
        for(int i = 0; i < pwdLength; i++) {
            buf.append(passwordTable[random.nextInt(tablelength)]);
        }
        accessCode = buf.toString();
        return accessCode;
    }


}
