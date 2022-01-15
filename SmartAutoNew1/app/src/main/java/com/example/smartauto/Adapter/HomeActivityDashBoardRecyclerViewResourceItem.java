package com.example.smartauto.Adapter;

public class HomeActivityDashBoardRecyclerViewResourceItem {
    String itemValue1, itemValue2;
    int itemValue1TextSize;
    Integer itemIcon;
    public HomeActivityDashBoardRecyclerViewResourceItem(String _itemValue1, int _itemValue1TextSize, String _itemValue2, Integer _itemIcon){
        this.itemValue1 = _itemValue1;
        this.itemValue1TextSize = _itemValue1TextSize;
        this.itemValue2 = _itemValue2;
        this.itemIcon = _itemIcon;
    }
    public String getItemValue1() { return itemValue1; }
    public int getItemValue1TextSize() { return itemValue1TextSize; }
    public String getItemValue2() { return itemValue2; }
    public Integer getItemIcon() { return itemIcon; }
    public void setItemValue1(String itemValue1) { this.itemValue1 = itemValue1; }
    public void setItemValue1TextSize(int itemValue1TextSize) { this.itemValue1TextSize = itemValue1TextSize; }
    public void setItemValue2(String itemValue2) { this.itemValue2 = itemValue2; }
    public void setItemIcon(Integer itemIcon) { this.itemIcon = itemIcon; }
}
