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

public class HomeScreenDashBoardAdapter extends RecyclerView.Adapter<HomeScreenDashBoardAdapter.HomeScreenDashBoardAdapterViewHolder> {
    public ArrayList<HomeScreenDashBoardResourceItem> homeScreenDashBoardResourceItems;             //array list for recyclerView
    public class HomeScreenDashBoardAdapterViewHolder extends RecyclerView.ViewHolder{              //hold all components view
        public TextView homeScreenDashBoardRecyclerViewResourceValue1;
        public TextView homeScreenDashBoardRecyclerViewResourceValue2;
        public ImageView homeScreenDashBoardRecyclerViewResourceIcon;
        public HomeScreenDashBoardAdapterViewHolder(View _view){
            super(_view);
            homeScreenDashBoardRecyclerViewResourceValue1 = _view.findViewById(R.id.home_screen_dashboard_recycler_view_resource_value1);
            homeScreenDashBoardRecyclerViewResourceValue2 = _view.findViewById(R.id.home_screen_dashboard_recycler_view_resource_value2);
            homeScreenDashBoardRecyclerViewResourceIcon = _view.findViewById(R.id.home_screen_dashboard_recycler_view_resource_icon);
        }
    }
    public HomeScreenDashBoardAdapter(ArrayList<HomeScreenDashBoardResourceItem> _homeScreenDashBoardResourceItems){
        this.homeScreenDashBoardResourceItems = _homeScreenDashBoardResourceItems;
    }

    @NonNull
    @Override
    public HomeScreenDashBoardAdapterViewHolder onCreateViewHolder(@NonNull ViewGroup _viewGroup, int _i) {
        View view = LayoutInflater.from(_viewGroup.getContext()).inflate(R.layout.home_drawer_resource_view, _viewGroup, false);
        HomeScreenDashBoardAdapterViewHolder homeScreenDashBoardAdapterViewHolder = new HomeScreenDashBoardAdapterViewHolder(view);
        return homeScreenDashBoardAdapterViewHolder;
    }

    @Override
    public void onBindViewHolder(@NonNull HomeScreenDashBoardAdapterViewHolder _homeScreenDashBoardAdapterViewHolder, int _position) {
        HomeScreenDashBoardResourceItem homeScreenDashBoardResourceItem = homeScreenDashBoardResourceItems.get(_position);
        _homeScreenDashBoardAdapterViewHolder.homeScreenDashBoardRecyclerViewResourceValue1.setText(homeScreenDashBoardResourceItem.getValue1());
        _homeScreenDashBoardAdapterViewHolder.homeScreenDashBoardRecyclerViewResourceValue1.setTextSize(homeScreenDashBoardResourceItem.getValue1TextSize());
        _homeScreenDashBoardAdapterViewHolder.homeScreenDashBoardRecyclerViewResourceValue2.setText(homeScreenDashBoardResourceItem.getValue2());
        _homeScreenDashBoardAdapterViewHolder.homeScreenDashBoardRecyclerViewResourceIcon.setImageResource(homeScreenDashBoardResourceItem.getIcon());
    }

    @Override
    public int getItemCount() {
        return homeScreenDashBoardResourceItems.size();
    }


}
