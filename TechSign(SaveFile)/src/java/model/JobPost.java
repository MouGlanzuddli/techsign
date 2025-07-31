package model;

public class JobPost {
    private int id;
    private String title;
    private int views;
    private int applyCount;

    public JobPost() {}

    public JobPost(int id, String title, int views, int applyCount) {
        this.id = id;
        this.title = title;
        this.views = views;
        this.applyCount = applyCount;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public int getViews() { return views; }
    public void setViews(int views) { this.views = views; }

    public int getApplyCount() { return applyCount; }
    public void setApplyCount(int applyCount) { this.applyCount = applyCount; }
} 