package com.example.smartauto.Adapters;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.smartauto.R;

import java.util.ArrayList;

public class HomeActivityDashBoardAdapter extends RecyclerView.Adapter<HomeActivityDashBoardAdapter.HomeActivityDashBoardAdapterViewHolder> {
    public ArrayList<HomeActivityDashBoardResourceItem> homeActivityDashBoardResourceItems;
    public class HomeActivityDashBoardAdapterViewHolder extends RecyclerView.ViewHolder{
        TextView tvHomeActivityDashBoardValue1;
        TextView tvHomeActivityDashBoardValue2;
        ImageView ivHomeActivityDashBoardIcon;
        public HomeActivityDashBoardAdapterViewHolder(View _view){
            super(_view);
            tvHomeActivityDashBoardValue1 = _view.findViewById(R.id.activity_home_dash_board_recycler_view_item_value_1);
            tvHomeActivityDashBoardValue2 = _view.findViewById(R.id.activity_home_dash_board_recycler_view_item_value_2);
            ivHomeActivityDashBoardIcon = _view.findViewById(R.id.activity_home_dash_board_recycler_view_item_icon);
        }
    }
    public HomeActivityDashBoardAdapter(ArrayList<HomeActivityDashBoardResourceItem> _homeActivityDashBoardResourceItems){
        this.homeActivityDashBoardResourceItems = _homeActivityDashBoardResourceItems;
    }

    @NonNull
    @Override
    public HomeActivityDashBoardAdapterViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.activity_home_dash_board_item_resource_view, parent, false);
        HomeActivityDashBoardAdapterViewHolder homeActivityDashBoardAdapterViewHolder = new HomeActivityDashBoardAdapterViewHolder(view);
        return homeActivityDashBoardAdapterViewHolder;
    }

    @Override
    public void onBindViewHolder(@NonNull HomeActivityDashBoardAdapterViewHolder holder, int position) {
        HomeActivityDashBoardResourceItem homeActivityDashBoardResourceItem = homeActivityDashBoardResourceItems.get(position);
        holder.tvHomeActivityDashBoardValue1.setText(homeActivityDashBoardResourceItem.getItemValue1());
        holder.tvHomeActivityDashBoardValue1.setTextSize(homeActivityDashBoardResourceItem.getItemValue1TextSize());
        holder.tvHomeActivityDashBoardValue2.setText(homeActivityDashBoardResourceItem.getItemValue2());
        holder.ivHomeActivityDashBoardIcon.setImageResource(homeActivityDashBoardResourceItem.getItemIcon());
    }

    @Override
    public int getItemCount() {
        return homeActivityDashBoardResourceItems.size();
    }

}
