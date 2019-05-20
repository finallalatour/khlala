package lala.com.a.model;

import java.io.Serializable;

public class ReplyDto extends MemberDto implements Serializable {
/*
	private int seq;
	private int pseq; //본문글
	private String id; //쓴사람
	
	private String content;
	private String wdate; //수정하면 바뀜
	
	private int ref;
	private int step;
	
	private int del; //0일반, 1삭제, 2수정
	private int lock_; //비밀댓글 0:기본, 1:숨김
	private String tname; //어떤테이블인지 대문자로.
	*/
   private int seq;
   private int pseq;
   private String tname;
   private String id;
   private String content;
   private int ref;
   private int step;
   private String wdate;
   private int del;
   private int lock_;
   private double grade;
   public ReplyDto() {
      // TODO Auto-generated constructor stub
   }
   
   
   
   public ReplyDto(int seq, String id) {
      super();
      this.seq = seq;
      this.id = id;
   }



   public ReplyDto(int pseq, String id, String content) {
      super();
      this.pseq = pseq;
      this.id = id;
      this.content = content;
   }

   public ReplyDto(int seq, int pseq, String tname, String id, String content, int ref, int step, String wdate,
         int del, int lock_) {
      super();
      this.seq = seq;
      this.pseq = pseq;
      this.tname = tname;
      this.id = id;
      this.content = content;
      this.ref = ref;
      this.step = step;
      this.wdate = wdate;
      this.del = del;
      this.lock_ = lock_;
   }
   
   public ReplyDto(int seq, int pseq, String tname, String id, String content, int ref, int step, String wdate,
         int del, int lock_, double grade) {
      super();
      this.seq = seq;
      this.pseq = pseq;
      this.tname = tname;
      this.id = id;
      this.content = content;
      this.ref = ref;
      this.step = step;
      this.wdate = wdate;
      this.del = del;
      this.lock_ = lock_;
      this.grade = grade;
   }



   public int getSeq() {
      return seq;
   }
   public void setSeq(int seq) {
      this.seq = seq;
   }
   public int getPseq() {
      return pseq;
   }
   public void setPseq(int pseq) {
      this.pseq = pseq;
   }
   public String getTname() {
      return tname;
   }
   public void setTname(String tname) {
      this.tname = tname;
   }
   public String getId() {
      return id;
   }
   public void setId(String id) {
      this.id = id;
   }
   public String getContent() {
      return content;
   }
   public void setContent(String content) {
      this.content = content;
   }
   public int getRef() {
      return ref;
   }
   public void setRef(int ref) {
      this.ref = ref;
   }
   public int getStep() {
      return step;
   }
   public void setStep(int step) {
      this.step = step;
   }
   public String getWdate() {
      return wdate;
   }
   public void setWdate(String wdate) {
      this.wdate = wdate;
   }
   public int getDel() {
      return del;
   }
   public void setDel(int del) {
      this.del = del;
   }
   public int getLock_() {
      return lock_;
   }
   public void setLock_(int lock_) {
      this.lock_ = lock_;
   }
   
   public double getGrade() {
      return grade;
   }

   public void setGrade(double grade) {
      this.grade = grade;
   }

   @Override
   public String toString() {
      return "ReplyDto [seq=" + seq + ", pseq=" + pseq + ", tname=" + tname + ", id=" + id + ", content=" + content
            + ", ref=" + ref + ", step=" + step + ", wdate=" + wdate + ", del=" + del + ", lock_=" + lock_
            + ", grade=" + grade + "]";
   }

}