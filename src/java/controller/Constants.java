/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import model.*;

/**
 *
 * @author Admin
 */
public class Constants {
   
        public static String GOOGLE_CLIENT_ID = "662818990560-8t0tkh07kp0kktc2mk7177k5gj8dvkdn.apps.googleusercontent.com";

	public static String GOOGLE_CLIENT_SECRET = "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";

	public static String GOOGLE_REDIRECT_URI = "http://localhost:8080/JobSearchManagement/LoginGoogleHandler";

	public static String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";

	public static String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";

	public static String GOOGLE_GRANT_TYPE = "authorization_code";
}
