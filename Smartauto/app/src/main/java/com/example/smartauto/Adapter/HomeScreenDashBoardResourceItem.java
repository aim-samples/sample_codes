package com.example.smartauto.Adapter;

public class HomeScreenDashBoardResourceItem {
    String value1;
    int value1TextSize;
    String value2;
    Integer icon;
    public HomeScreenDashBoardResourceItem(String _value1, int _value1TextSize, String _value2, Integer _icon){
        this.value1 = _value1;
        this.value1TextSize = _value1TextSize;
        this.value2 = _value2;
        this.icon = _icon;
    }

    public String getValue1() { return value1; }
    public int getValue1TextSize() { return value1TextSize; }
    public String getValue2() { return value2; }
    public Integer getIcon() { return icon; }

    public void setValue1(String value1) { this.value1 = value1; }
    public void setValue1TextSize(int value1TextSize) { this.value1TextSize = value1TextSize; }
    public void setValue2(String value2) { this.value2 = value2; }
    public void setIcon(Integer icon) { this.icon = icon; }
}
