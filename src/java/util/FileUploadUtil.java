package util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;
import jakarta.servlet.http.Part;

public class FileUploadUtil {
    private static final String UPLOAD_DIR = "uploads";
    private static final String JOB_ATTACHMENTS_DIR = "job-attachments";
    private static final String COMPANY_LOGOS_DIR = "company-logos";
    
    // Allowed file types
    private static final String[] ALLOWED_IMAGE_TYPES = {
        "image/jpeg", "image/jpg", "image/png", "image/gif"
    };
    
    private static final String[] ALLOWED_DOCUMENT_TYPES = {
        "application/pdf", "application/msword", 
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    };

    public static String saveCompanyLogo(Part filePart, String uploadPath) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        // Validate file type
        String contentType = filePart.getContentType();
        if (!isValidImageType(contentType)) {
            throw new IOException("Invalid file type. Only images are allowed for company logos.");
        }

        // Create upload directory if it doesn't exist
        Path uploadDir = Paths.get(uploadPath, UPLOAD_DIR, COMPANY_LOGOS_DIR);
        Files.createDirectories(uploadDir);

        // Generate unique filename
        String originalFileName = getFileName(filePart);
        String fileExtension = getFileExtension(originalFileName);
        String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

        // Save file
        Path filePath = uploadDir.resolve(uniqueFileName);
        Files.copy(filePart.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

        // Return relative path for database storage
        return UPLOAD_DIR + "/" + COMPANY_LOGOS_DIR + "/" + uniqueFileName;
    }

    public static String saveJobAttachment(Part filePart, String uploadPath) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        // Validate file type
        String contentType = filePart.getContentType();
        if (!isValidDocumentType(contentType) && !isValidImageType(contentType)) {
            throw new IOException("Invalid file type. Only documents and images are allowed.");
        }

        // Create upload directory if it doesn't exist
        Path uploadDir = Paths.get(uploadPath, UPLOAD_DIR, JOB_ATTACHMENTS_DIR);
        Files.createDirectories(uploadDir);

        // Generate unique filename
        String originalFileName = getFileName(filePart);
        String fileExtension = getFileExtension(originalFileName);
        String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

        // Save file
        Path filePath = uploadDir.resolve(uniqueFileName);
        Files.copy(filePart.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

        // Return relative path for database storage
        return UPLOAD_DIR + "/" + JOB_ATTACHMENTS_DIR + "/" + uniqueFileName;
    }

    private static String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String content : contentDisposition.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "unknown";
    }

    private static String getFileExtension(String fileName) {
        int lastDotIndex = fileName.lastIndexOf('.');
        return (lastDotIndex == -1) ? "" : fileName.substring(lastDotIndex);
    }

    private static boolean isValidImageType(String contentType) {
        for (String allowedType : ALLOWED_IMAGE_TYPES) {
            if (allowedType.equals(contentType)) {
                return true;
            }
        }
        return false;
    }

    private static boolean isValidDocumentType(String contentType) {
        for (String allowedType : ALLOWED_DOCUMENT_TYPES) {
            if (allowedType.equals(contentType)) {
                return true;
            }
        }
        return false;
    }

    public static boolean deleteFile(String filePath, String uploadPath) {
        try {
            Path path = Paths.get(uploadPath, filePath);
            return Files.deleteIfExists(path);
        } catch (IOException e) {
            System.err.println("Error deleting file: " + e.getMessage());
            return false;
        }
    }
}
