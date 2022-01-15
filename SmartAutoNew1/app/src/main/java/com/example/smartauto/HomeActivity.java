package com.example.smartauto;

import android.content.res.Configuration;
import android.support.annotation.NonNull;
import android.support.design.widget.BottomNavigationView;
import android.support.design.widget.NavigationView;
import android.support.v4.app.Fragment;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.view.MenuItem;
import android.view.View;

import com.example.smartauto.Adapter.HomeActivityDashBoardRecyclerViewAdapter;
import com.example.smartauto.Adapter.HomeActivityDashBoardRecyclerViewResourceItem;

import java.util.ArrayList;

public class HomeActivity extends AppCompatActivity {
    Toolbar toolbar;

    DrawerLayout homeActivityDrawerLayout;
    NavigationView homeActivityDrawerNavigationView;
    View homeActivityDrawerHeader;

    RecyclerView homeActivitydashBoardRecyclerView;
    RecyclerView.LayoutManager homeActivitydashBoardRecyclerViewLayoutManager;
    RecyclerView.Adapter homeActivitydashBoardRecyclerViewAdapter;
    ArrayList<HomeActivityDashBoardRecyclerViewResourceItem> homeActivityDashBoardRecyclerViewResourceItems;

    Integer[] iconList = {
      R.drawable.ic_access_time_blue_grey_24dp,
      R.drawable.ic_navigation_blue_grey_24dp,
      R.drawable.ic_battery_charging_full_blue_grey_24dp,
      R.drawable.ic_cloud_blue_grey_24dp
    };

    int[] textSize = {
      14, 18
    };

    BottomNavigationView homeActivityBottomNavigationMenu;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);
        configureToolBar();
        configureDrawer();
        populateDashBoard();
        configureBottomNavigation();
    }
    public void configureToolBar(){
        toolbar = findViewById(R.id.home_activity_frame_layout_toolbar);
        setSupportActionBar(toolbar);
    }
    public void configureDrawer(){
        homeActivityDrawerLayout = findViewById(R.id.home_activity_drawer_layout);
        int orientation = this.getResources().getConfiguration().orientation;                       //get device orientation
        if (orientation == Configuration.ORIENTATION_LANDSCAPE){                                    //check is device is landscape
            homeActivityDrawerLayout.setDrawerLockMode(DrawerLayout.LOCK_MODE_LOCKED_OPEN);           //open drawer and lock
            homeActivityDrawerLayout.setScrimColor(0);                                                //shaddow color
        }
        //Navigation drawer header components
        homeActivityDrawerNavigationView = findViewById(R.id.home_activity_drawer_navigation_menu);                  //navigation view
        homeActivityDrawerHeader = homeActivityDrawerNavigationView.getHeaderView(0);         //get header view

        //Dash Board Recycler View Config
        homeActivityDashBoardRecyclerViewResourceItems = new ArrayList<>();                                                                       //set array
        homeActivitydashBoardRecyclerView = homeActivityDrawerHeader.findViewById(R.id.activity_home_dash_board_recycler_view);  //asign widget to variable
        homeActivitydashBoardRecyclerViewLayoutManager = new LinearLayoutManager(getApplicationContext());                            //layout manager
        homeActivitydashBoardRecyclerViewAdapter = new HomeActivityDashBoardRecyclerViewAdapter(homeActivityDashBoardRecyclerViewResourceItems);                  //set items to adapter
        homeActivitydashBoardRecyclerView.setHasFixedSize(true);
        homeActivitydashBoardRecyclerView.setLayoutManager(homeActivitydashBoardRecyclerViewLayoutManager);                             //set layout to recycler view
        homeActivitydashBoardRecyclerView.setAdapter(homeActivitydashBoardRecyclerViewAdapter);                                         //set adapter to recycler view
    }
    public void populateDashBoard(){
        homeActivityDashBoardRecyclerViewResourceItems.add(new HomeActivityDashBoardRecyclerViewResourceItem(
                "12:00 am",     //time
                textSize[0],
                "01/01/2001",   //date
                iconList[0]));                                                                      //1 time and date
        homeActivityDashBoardRecyclerViewResourceItems.add(new HomeActivityDashBoardRecyclerViewResourceItem(
                "100 Km/hr",
                textSize[1],
                "Speed",
                iconList[1]));                                                                      //2 vehicle speed
        homeActivityDashBoardRecyclerViewResourceItems.add(new HomeActivityDashBoardRecyclerViewResourceItem(
                "100 %",
                textSize[0],
                "Battery",
                iconList[2]));                                                                      //3 battery level
        homeActivityDashBoardRecyclerViewResourceItems.add(new HomeActivityDashBoardRecyclerViewResourceItem(
                "24 \u2103",                                                                 //"\u2103" for degree celsius "\u2109" for degree fahrenheit
                textSize[0],
                "Temperature",
                iconList[3]));                                                                      //4 temperature
        homeActivitydashBoardRecyclerViewAdapter.notifyDataSetChanged();                              //notify data changes
    }                                                        //populate dash board recycler view
    public void configureBottomNavigation(){
        homeActivityBottomNavigationMenu = findViewById(R.id.home_activity_bottom_navigation_menu);
        homeActivityBottomNavigationMenu.setOnNavigationItemSelectedListener(homeActivityBottomNavigationItemSelectedListener);
        homeActivityBottomNavigationMenu.setSelectedItemId(R.id.bottom_navigation_item_sensors);
        loadFragments(new SensorsFragment());
    }
    BottomNavigationView.OnNavigationItemSelectedListener homeActivityBottomNavigationItemSelectedListener = new BottomNavigationView.OnNavigationItemSelectedListener() {
        @Override
        public boolean onNavigationItemSelected(@NonNull MenuItem menuItem) {
            Fragment fragment = null;
            try{
                switch (menuItem.getItemId()){
                    case R.id.bottom_navigation_item_sensors:
                        fragment = new SensorsFragment();
                        break;
                    case R.id.bottom_navigation_item_maps:
                        fragment = new MapLocationFragment();
                        break;
                    case R.id.bottom_navigation_item_settings:
                        fragment = new SettingsMainFragment();
                        break;
                    default:
                        break;
                }
            }catch (Exception e) {
                e.printStackTrace();
            }
            return loadFragments(fragment);                                                         //load selected fragment
        }
    };                                                                                              //Bottom Navigation View Selection
    public boolean loadFragments(Fragment _fragment){
        getSupportFragmentManager().beginTransaction().replace(R.id.home_activity_frame_layout, _fragment).commit();
        return true;
    }                                           //start journey between fragments
    public void showUpButton(){
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
    }
    public void hideUpButton(){
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
    }
}