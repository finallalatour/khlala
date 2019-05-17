package lala.com.a.util;



import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.TreeMap;

import org.springframework.beans.factory.annotation.Autowired;

import lala.com.a.hotel.HotelService;

public class CalendarUtil{
	
	@Autowired
	HotelService hotelService;
	
	public static boolean nvl(String msg) {
		return msg == null || msg.trim().equals("")?true:false;
	}
	
	// 날짜를 클릭하면, 그날의 일정이 모두 보이도록 하는 callist.jsp로 이동시키는 함수
	public static String callist(int year, int month, int day) {
		String s = "";
		
		s = "<font>";
		s += String.format("%2d", day);
		s += "</font>";
		
		return s;		
	}
	
	// 일정을 추가하기 위한 calwrite.jsp로 이돌하기 위한 함수로 이미지(펜)를 클릭시 처리
	public static String showPen(int year, int month, int day) {
		String s = "";
		
		String image = "<img src='./image/pen.gif'>";
		
		s = String.format("<a href='%s?year=%d&month=%d&day=%d'>%s</a>", 
							"calwrite.do", year, month, day, image);		
		return s;		
	}
	
	// 1 -> 01
	public static String two(String msg) {
		return msg.trim().length()<2?"0"+msg.trim():msg.trim();
	}
	
	// 각 날짜별로 테이블을 생성하는 함수
	public static String makeTable(int year, int month, int day,int maxcount) {
		Singleton ss = Singleton.getInstance();
		if(day ==1) {
			ss.disDate.clear();
		}
		String s = "";
		String dates = (year + "") + "-" + two(month + "") + "-" + two(day + ""); // "2019-03-01"
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		int count = 0;
		try {
			Date sDate = sdf.parse(dates);
			if(ss.rDate.containsKey(sdf.format(sDate))) {
				count = ss.rDate.get(sdf.format(sDate));
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}

		maxcount -= count;
		if(maxcount <= 0) {
			ss.disDate.add(dates);
		}
		s += "<table>";
		s += "<col width='98'>";
		
				s += "<tr>";
				s += "<td>";
				
				s += "<font style='font-size:11px;font-weight:bold'>";
				s += "남은 객실 수 : " + maxcount;
				s += "</font>";
				
				s += "</td>";
				s += "</tr>";
		
		s += "</table>";
		
		return s;
	}
	
	// 제목이 너무 길면, ...으로 처리할 함수	
	public static String dot3(String msg) {
		String s = "";
		if(msg.length() >= 5) {
			s = msg.substring(0, 5);
			s += "...";
		}else {
			s = msg.trim();
		}	
		return s;
	}

	

}






