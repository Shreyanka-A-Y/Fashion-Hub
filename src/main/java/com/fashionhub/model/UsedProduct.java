package com.fashionhub.model;

public class UsedProduct {

    private int usedId;

    private int sellerId;

    private int buyerId;

    private int categoryId;

    private String productName;

    private String description;

    private String productCondition;

    private int coinPrice;

    private String image;

    private String approvalStatus;

    private String createdAt;
    
    private String status;
    
    public UsedProduct() {}


    public int getUsedId() {
        return usedId;
    }

    public void setUsedId(int usedId) {
        this.usedId = usedId;
    }

    public int getSellerId() {
        return sellerId;
    }

    public void setSellerId(int sellerId) {
        this.sellerId = sellerId;
    }

    public int getBuyerId() {
        return buyerId;
    }

    public void setBuyerId(int buyerId) {
        this.buyerId = buyerId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getProductCondition() {
        return productCondition;
    }

    public void setProductCondition(String productCondition) {
        this.productCondition = productCondition;
    }

    public int getCoinPrice() {
        return coinPrice;
    }

    public void setCoinPrice(int coinPrice) {
        this.coinPrice = coinPrice;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
    
    public boolean isSold() {
        return "SOLD".equalsIgnoreCase(this.approvalStatus);
    }

}