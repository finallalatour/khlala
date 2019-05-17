package lala.com.a.util;

public class pagingBean {
	
	private String findWord;
	private String choice;
	private int nowPage;	
	private int startNum;
	private int totalCount;	
	private int countPerPage;	
	private int blockCount;		
	public int getNowPage() {
		return nowPage;
	}
	
	public String getFindWord() {
		return findWord;
	}

	public void setFindWord(String findWord) {
		this.findWord = findWord;
	}

	public String getChoice() {
		return choice;
	}

	public void setChoice(String choice) {
		this.choice = choice;
	}

	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}
	public int getStartNum() {
		return startNum;
	}
	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getCountPerPage() {
		return countPerPage;
	}
	public void setCountPerPage(int countPerPage) {
		this.countPerPage = countPerPage;
	}
	public int getBlockCount() {
		return blockCount;
	}
	public void setBlockCount(int blockCount) {
		this.blockCount = blockCount;
	}
	
	
}
