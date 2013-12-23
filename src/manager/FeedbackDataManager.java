package manager;

import java.io.Serializable;
import java.util.*;

import model.*;

public class FeedbackDataManager implements Serializable {
	private static final long serialVersionUID = 1L;

	public FeedbackDataManager() {
	}

	public void add(int teamId, int sponsorId, int technical, int domain, int project, int company,
			String commFrequency, String modeOfMeeting, String commHelpfulness, String miscExploit, String miscRecommend, String miscImprove) {
		
		MySQLConnector.executeMySQL("insert",
				"INSERT INTO `is480-matching`.`team_sponsorfeedback` (`team_id`, `sponsor_id`, `date`,"
				+ "`technical`, `domain`, `project`, `company`, `communication_frequency`, `communication_mode_of_meeting`,"
				+ "`communication_helpfulness`, `misc_exploit`, `misc_recommend`, `misc_improve`)"
				+ " VALUES (" + teamId + ", "
						+ sponsorId +", CURRENT_TIMESTAMP, "
						+ technical + ", "
						+ domain + ", "
						+ project + ", "
						+ company + ", '"
						+ commFrequency + "', '"
						+ modeOfMeeting + "', '"
						+ commHelpfulness + "', '"
						+ miscExploit + "', '"
						+ miscRecommend + "', '"
						+ miscImprove + "');");
	}
	
	public void add(int graderId, String teamName, int memberId, int feedbackRating, String feedbackComment) {
		
		MySQLConnector.executeMySQL("insert",
				"INSERT INTO `is480-matching`.`sponsor_teamfeedback` (`grader`, `feedback_date`, `feedback_team`,"
				+ "`member_graded`, `feedback_rating`, `feedback_comment`)"
				+ " VALUES (" + graderId + ", CURRENT_TIMESTAMP, '"
						+ teamName + "', "
						+ memberId + ", "
						+ feedbackRating + ", '"
						+ feedbackComment + "');");
	}

	public void modify() {
	}

	public void remove(int ID) {
	}

	public void removeAll() {
	}
}