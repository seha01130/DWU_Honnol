package model.service;

public class NotExistingLocationException extends Exception {
	private static final long serialVersionUID = 1L;

	public NotExistingLocationException() {
		super();
	}
	public NotExistingLocationException(String arg0) {
		super(arg0);
	}
}
