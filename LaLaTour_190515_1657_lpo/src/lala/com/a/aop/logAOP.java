package lala.com.a.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

@Aspect
public class logAOP {
	
	
	@Around("within(lala.com.a.product.*) or within(kh.com.a.dao.impl.*)")
	public Object loggerAop(ProceedingJoinPoint joinpoint) throws Throwable {
		
		String signatureStr = joinpoint.getSignature().toShortString();
		
	//	System.out.println(signatureStr + "시작");
		
		try {
			System.out.println("loggerAOP:" + signatureStr + " 메소드가 실행되었습니다.");
			// 실행전 처리 -------------
			Object obj = joinpoint.proceed();	// 기능 실행
			return obj;
			
		} finally {
		//	System.out.println("실행 후 : " + System.currentTimeMillis());
			
		//	System.out.println(signatureStr + "종료");
		}
		
	}
}
