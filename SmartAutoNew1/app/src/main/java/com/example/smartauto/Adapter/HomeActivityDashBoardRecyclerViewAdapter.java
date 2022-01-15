package com.example.smartauto.Adapter;

import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.example.smartauto.R;

import java.util.ArrayList;

public class HomeActivityDashBoardRecyclerViewAdapter extends RecyclerView.Adapter<HomeActivityDashBoardRecyclerViewAdapter.HomeActivityDashBoardRecyclerViewAdapterViewHolder> {
    public ArrayList<HomeActivityDashBoardRecyclerViewResourceItem> homeActivityDashBoardRecyclerViewResourceItems;
    public HomeActivityDashBoardRecyclerViewAdapter(ArrayList<HomeActivityDashBoardRecyclerViewResourceItem> _homeActivityDashBoardRecyclerViewResourceItems){
        this.homeActivityDashBoardRecyclerViewResourceItems = _homeActivityDashBoardRecyclerViewResourceItems;
    }
    public class HomeActivityDashBoardRecyclerViewAdapterViewHolder extends RecyclerView.ViewHolder {
        public TextView activityHomeDashBoardResourceItemValue1;
        public TextView activityHomeDashBoardResourceItemValue2;
        public ImageView activityHomeDashBoardResourceItemIcon;
        public HomeActivityDashBoardRecyclerViewAdapterViewHolder(@NonNull View _itemView) {
            super(_itemView);
            activityHomeDashBoardResourceItemValue1 = _itemView.findViewById(R.id.activity_home_dash_board_resource_item_value1);
            activityHomeDashBoardResourceItemValue2 = _itemView.findViewById(R.id.activity_home_dash_board_resource_item_value2);
            activityHomeDashBoardResourceItemIcon = _itemView.findViewById(R.id.activity_home_dash_board_resource_item_icon);
        }
    }

    @NonNull
    @Override
    public HomeActivityDashBoardRecyclerViewAdapterViewHolder onCreateViewHolder(@NonNull ViewGroup _viewGroup, int i) {
        View view = LayoutInflater.from(_viewGroup.getContext()).inflate(R.layout.activity_home_dashboard_resource_view, _viewGroup, false);
        HomeActivityDashBoardRecyclerViewAdapterViewHolder homeScreenDashBoardAdapterViewHolder = new HomeActivityDashBoardRecyclerViewAdapterViewHolder(view);
        return homeScreenDashBoardAdapterViewHolder;
    }

    @Override
    public void onBindViewHolder(@NonNull HomeActivityDashBoardRecyclerViewAdapterViewHolder _homeActivityDashBoardRecyclerViewAdapterViewHolder, int _position) {
        HomeActivityDashBoardRecyclerViewResourceItem homeActivityDashBoardRecyclerViewResourceItem = homeActivityDashBoardRecyclerViewResourceItems.get(_position);
        _homeActivityDashBoardRecyclerViewAdapterViewHolder.activityHomeDashBoardResourceItemValue1.setText(homeActivityDashBoardRecyclerViewResourceItem.getItemValue1());
        _homeActivityDashBoardRecyclerViewAdapterViewHolder.activityHomeDashBoardResourceItemValue1.setTextSize(homeActivityDashBoardRecyclerViewResourceItem.getItemValue1TextSize());
        _homeActivityDashBoardRecyclerViewAdapterViewHolder.activityHomeDashBoardResourceItemValue2.setText(homeActivityDashBoardRecyclerViewResourceItem.getItemValue2());
        _homeActivityDashBoardRecyclerViewAdapterViewHolder.activityHomeDashBoardResourceItemIcon.setImageResource(homeActivityDashBoardRecyclerViewResourceItem.getItemIcon());
    }

    @Override
    public int getItemCount() {
        return homeActivityDashBoardRecyclerViewResourceItems.size();
    }

}
