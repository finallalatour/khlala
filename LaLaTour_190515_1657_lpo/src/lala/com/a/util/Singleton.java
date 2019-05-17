package lala.com.a.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Singleton {
	public Map<String,Integer> rDate;
	public List<String> disDate;
	private Singleton() {
		rDate = new HashMap<>();
		disDate = new ArrayList<>();
    }
 
    private static class LazyHolder {
        public static final Singleton INSTANCE = new Singleton();
    }
 
    public static Singleton getInstance() {
        return LazyHolder.INSTANCE;
    }


}
