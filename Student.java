public class Student{
  
  @Id private Long id;
  private String studentEamil;
  private String studentName;
  private String studentContact;
  private String secondMajor;
  
  public Student(){}
  
  public Student(Long id, String studentEmail, String studentName, String studentContact, String secondMajor){
    this(studentEmail, studentName, studentContact, secondMajor);
    this.id=id;
  }
  
  public Student(String studentEmail, String studentName, String studentContact, String secondMajor){
    this.studentEmail = studentEmail;
    this.studentName = studentName;
    this.studentContact = studentContact;
    this.secondMajor = secondMajor;
  }
  
  public Long getId(){
    return id;
  }
  
  public String getStudentEmail(){
    return studentEmail;
  }
  
  public void setStudentEmail(String studentEmail){
    this.studentEmail = studentEmail;
  }
  
  public String getStudentName(){
    return studentName;
  }
  
  public void setStudentName(String studentName){
    this.studentName = studentName;
  }
  
  public String getStudentContact(){
    return studentContact;
  }
  
  public void setStudentContact(String studentContact){
    this.studentContact = studentContact;
  }
  
  public String getSecondMajor(){
    return secondMajor;
  }
  
  public void setSecondMajor(String secondMajor){
    this.secondMajor = secondMajor;
  }
} 
