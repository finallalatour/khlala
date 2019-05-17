package lala.com.a.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import lala.com.a.product.LalaProductService;

public class DownloadView extends AbstractView {

	@Autowired
	LalaProductService lalaProductService;
	
	@Override
	protected void renderMergedOutputModel(
			Map<String, Object> model, 
			HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		System.out.println("DownloadView renderMergedOutputModel()");
		System.out.println("downloadFile: " + model.get("downloadFile"));
		
		File file = (File)model.get("downloadFile"); //getAttribute
		response.setContentType(this.getContentType()); //현재경로??
		response.setContentLength((int)file.length()); //파일용량
		
		//IE / Chrome
		String userAgent = request.getHeader("user-Agent");
		boolean ie = userAgent.indexOf("MSIE")>-1;
		
		//String filename = null;
		//String filename = (String)model.get("filenamebf");
		String filename = (String)model.get("thumbNail");

		if(ie) {
			//java.net.URLEncoder
			//filename = URLEncoder.encode(file.getName(), "utf-8");
			filename = URLEncoder.encode(filename, "utf-8");
		}
		else {
			//filename = new String(file.getName().getBytes("utf-8"), "iso-8859-1");
			filename = new String(filename.getBytes("utf-8"), "iso-8859-1");
		}
		
		// window download 설정(다운로드 창) 
		response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary;");
		response.setHeader("Content-Length", "" + file.length());
		response.setHeader("Pragma", "no-cache;"); 
		response.setHeader("Expires", "-1;"); //기한 무한대
		
		//io
		OutputStream out = response.getOutputStream();
		FileInputStream fi = null;
		
		fi = new FileInputStream(file);
		FileCopyUtils.copy(fi, out);
		
		//download count 증가 (다운수)
		/*int seq = (int)model.get("seq");
		System.out.println("//////////////////seq: " + seq);
		khPdsService.downcountPlus(seq);*/
		
		//다운로드가 끝났으면..
		if(fi != null) {
			fi.close();
		}
	}

}


















