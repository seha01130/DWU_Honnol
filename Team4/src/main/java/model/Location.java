package model;

public class Location {
	 private int locationId;
	 private String name;
	 private String address;
	 
	 public Location() {}
	 
	 public Location(int locationId, String name, String address) {
		 super();
		 this.locationId = locationId;
		 this.name = name;
		 this.address = address;
	 }
	 
	public int getLocationId() {
		return locationId;
	}
	
	public void setLocationId(int locationId) {
		this.locationId = locationId;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getAddress() {
		return address;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
}
