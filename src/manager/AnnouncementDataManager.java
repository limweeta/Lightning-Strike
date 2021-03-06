package manager;

import java.io.Serializable;
import java.util.*;

import model.*;

public class AnnouncementDataManager implements Serializable {
	private static final long serialVersionUID = 1L;

	public AnnouncementDataManager() {
	}
	
	public ArrayList<Announcement> retrieveAll() {
		ArrayList<Announcement> announcements = new ArrayList<Announcement>();
		HashMap<String, ArrayList<String>> map = MySQLConnector.executeMySQL("select","SELECT * FROM `is480-matching`.announcements ORDER BY time_stamp DESC;");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int id = Integer.parseInt(array.get(0));
			String timestamp = array.get(1);
			String ann = array.get(2);
			
			Announcement announcement = new Announcement(id, ann, timestamp);
			announcements.add(announcement);
		}
		
		Collections.sort(announcements, new Comparator<Announcement>() {
			  public int compare(Announcement a1, Announcement a2) {
			      return a2.getTimestamp().compareTo(a1.getTimestamp());
			  }
			});
		
		return announcements;
	}
	
	//id = announcement id
	public Announcement retrieve(int id) throws Exception {
		Announcement announcement = null;
		HashMap<String, ArrayList<String>> map = MySQLConnector
				.executeMySQL(
						"select",
						"SELECT * FROM `is480-matching`.announcements where announcements.id = "+ id + ";");
		Set<String> keySet = map.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			ArrayList<String> array = map.get(key);
			int id2 = Integer.parseInt(array.get(0));
			String timestamp = array.get(1);
			String ann = array.get(2);
			
			announcement = new Announcement(id2, ann, timestamp);
		}
		return announcement;
	}
	
	//adding a new announcement
	public void add(Announcement announcement) {
		String ann = announcement.getAnnouncement();
		MySQLConnector.executeMySQL("insert",
				"INSERT INTO `is480-matching`.`announcements` (time_stamp, announcement)"
				+ " VALUES ( CURRENT_TIMESTAMP, '" + ann + "');");
	}

	public void modify(Announcement announcement) {
	}

	public void remove(int ID) {
	}

	public void removeAll() {
	}
}