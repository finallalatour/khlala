package lala.com.a.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class HotelUtil {

	public static void reserveDate(String sDate, String eDate){
		System.out.println("sDateUtil : " + sDate);
		System.out.println("eDateUtil : " + eDate);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Singleton s = Singleton.getInstance();
		Date startDate;
		Date endDate;
		
		try {
			startDate = sdf.parse(sDate);
			endDate= sdf.parse(eDate);
			Date currentDate = startDate;
			while (currentDate.compareTo(endDate) <= 0) {
				//키값 조사후 있는키면 밸류 +1 없으면 put
				if(s.rDate.containsKey(sdf.format(currentDate))) {
					s.rDate.replace(sdf.format(currentDate), s.rDate.get(sdf.format(currentDate)) + 1);
				}else {
					s.rDate.put(sdf.format(currentDate), 1);
				}
				//sDate = sDate +1
				Calendar c = Calendar.getInstance();
				c.setTime(currentDate);
				
				c.add(Calendar.DAY_OF_MONTH, 1);
				currentDate = c.getTime();
			}
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//대댓글 화살표함수
	public static String arrow(int step){
	   String rs = "<img src='./images/arrow.png' width='20px' height='20px'/>";
	   String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";   // 여백

	   String ts = "";   
	   ts += nbsp;
	   return step==0?"":ts + rs;
	}
}
