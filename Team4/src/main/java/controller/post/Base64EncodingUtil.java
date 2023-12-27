package controller.post;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.Base64;

public class Base64EncodingUtil {

    public static String base64Image(Blob instance) {
        try {
            InputStream inputStream = instance.getBinaryStream();
            byte[] data = new byte[(int) instance.length()];
            inputStream.read(data);
            inputStream.close();
            return Base64.getEncoder().encodeToString(data);
        } catch (SQLException | IOException e) {
            throw new RuntimeException(e);
        }
    }
}
