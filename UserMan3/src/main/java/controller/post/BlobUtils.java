package controller.post;

import java.io.ByteArrayInputStream;
import java.io.UnsupportedEncodingException;
import java.sql.Blob;
import java.sql.SQLException;

import javax.sql.rowset.serial.SerialBlob;

public class BlobUtils {

    public static Blob getBlobFromString(String data) throws SQLException {
        try {
            byte[] bytes = data.getBytes("UTF-8");
            ByteArrayInputStream inputStream = new ByteArrayInputStream(bytes);
            return new SerialBlob(bytes);
        } catch (UnsupportedEncodingException e) {
            throw new SQLException("Failed to convert string to Blob", e);
        }
    }

    
    
    public static void main(String[] args) throws SQLException {
        String exampleString = "This is an example string.";
        Blob blob = getBlobFromString(exampleString);
        // Now you can use 'blob' in your database operations
    }
}
