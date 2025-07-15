
package model;

import java.security.Timestamp;


public class UserFavourite {
    private int id;
    private int userId;
    private int companyId;
    private Timestamp followedAt;

    
    public UserFavourite() {}

    public UserFavourite(int id, int userId, int companyId, Timestamp followedAt) {
        this.id = id;
        this.userId = userId;
        this.companyId = companyId;
        this.followedAt = followedAt;
    }

    
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCompanyId() {
        return companyId;
    }
    public void setCompanyId(int companyId) {
        this.companyId = companyId;
    }

    public Timestamp getFollowedAt() {
        return followedAt;
    }
    public void setFollowedAt(Timestamp followedAt) {
        this.followedAt = followedAt;
    }
}
