public class Sponsor extends User{
  private String company;
  private String companyAddress;
  private String experience;
  
  public Sponsor(){}
  
  public Sponsor(Long id, String fullName, String userName, String contact, String gender, String email, String role, String company, String companyAddress, String experience){
    super(id, fullName, userName, contact, gender, email, role);
    this.company = company;
    this.companyAddress = companyAddress;
    this. experience = experience;
  }
  
  public Sponsor(String fullName, String userName, String contact, String gender, String email, String role, String company, String companyAddress, String experience){
    super(fullName, userName, contact, gender, email, role);
    this.company = company;
    this.companyAddress = companyAddress;
    this.experience = experience;
  }
  
  public String getCompany(){
    return company;
  }
  
  public void setCompany(String company){
    this.company = company;
  }
  
  public String getCompanyAddress(){
    return companyAddress;
  }
  
  public void setCompanyAddress(String companyAddress){
    this.companyAddress = companyAddress;
  }
  
  public String getExperience(){
    return experience;
  }
  
  public void setExperience(String experience){
    this.experience = experience;
  }
}