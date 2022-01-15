package com.example.smartauto;

import android.content.res.Configuration;
import android.os.Handler;
import android.support.annotation.NonNull;
import android.support.design.widget.BottomNavigationView;
import android.support.design.widget.NavigationView;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.example.smartauto.Adapter.HomeScreenDashBoardAdapter;
import com.example.smartauto.Adapter.HomeScreenDashBoardResourceItem;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

public class HomeActivity extends AppCompatActivity {
    public Handler handler = new Handler();
    DrawerLayout homeScreenDrawerLayout;                                                            //HomeScreenDrawerLayout
    NavigationView homeScreenNavigationView;                                                        //HomeScreenNavigationView
    View homeScreenNavigationDrawerHeader;                                                          //HomeScreenDrawerHeader

    //Dash Board Recycler View Definitions
    RecyclerView homeScreenDashBoardRecyclerView;
    RecyclerView.LayoutManager homeScreenDashBoardRecyclerViewLayoutManager;
    RecyclerView.Adapter homeScreenDashBoardRecyclerViewAdapter;
    ArrayList<HomeScreenDashBoardResourceItem> homeScreenDashBoardResourceItems;

    //Bottom Navigation View
    BottomNavigationView homeScreenBottomNavigationView;

    Integer[] iconList = {                                                                          //list of icons
            R.drawable.ic_access_time_teal_24dp,                                                    //time and date
            R.drawable.ic_navigation_teal_24dp,                                                     //speed
            R.drawable.ic_battery_charging_full_teal_24dp,                                          //battery
            R.drawable.ic_cloud_teal_24dp,                                                          //whether temperature
    };
    int[] textSize = {                                                                              //text size for value in recycler view
            14,                                                                                     //normal size
            18                                                                                      //large size like for speed
    };

    int cntr = 0;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);
        configureDrawer();
        configureBottomDrawer();
        populateDashBoardList();
        handler.post(clock_runnable);                                                               //start clock display loop
        handler.post(speed_runnable);                                                               //start speed display loop
    }
    public void configureDrawer(){                                                                  //Get Device Orientation And Configure Drawer
        homeScreenDrawerLayout = findViewById(R.id.home_drawer_layout);                             //get drawerlayout
        int orientation = this.getResources().getConfiguration().orientation;                       //get device orientation
        if (orientation == Configuration.ORIENTATION_LANDSCAPE){                                    //check is device is landscape
            homeScreenDrawerLayout.setDrawerLockMode(DrawerLayout.LOCK_MODE_LOCKED_OPEN);           //open drawer and lock
            homeScreenDrawerLayout.setScrimColor(0);                                                //shaddow color
        }
        //Navigation drawer header components
        homeScreenNavigationView = findViewById(R.id.home_drawer_navigation_view);                  //navigation view
        homeScreenNavigationDrawerHeader = homeScreenNavigationView.getHeaderView(0);         //get header view

        //Dash Board Recycler View Config
        homeScreenDashBoardResourceItems = new ArrayList<>();                                                                       //set array
        homeScreenDashBoardRecyclerView = homeScreenNavigationDrawerHeader.findViewById(R.id.home_screen_dashboard_recycler_view);  //asign widget to variable
        homeScreenDashBoardRecyclerViewLayoutManager = new LinearLayoutManager(getApplicationContext());                            //layout manager
        homeScreenDashBoardRecyclerViewAdapter = new HomeScreenDashBoardAdapter(homeScreenDashBoardResourceItems);                  //set items to adapter
        homeScreenDashBoardRecyclerView.setHasFixedSize(true);
        homeScreenDashBoardRecyclerView.setLayoutManager(homeScreenDashBoardRecyclerViewLayoutManager);                             //set layout to recycler view
        homeScreenDashBoardRecyclerView.setAdapter(homeScreenDashBoardRecyclerViewAdapter);                                         //set adapter to recycler view

    }                                                              //configure drawer
    public void configureBottomDrawer(){
        homeScreenBottomNavigationView = findViewById(R.id.home_screen_bottom_navigation_view);                                     //get bottom navigation view
        homeScreenBottomNavigationView.setOnNavigationItemSelectedListener(homeScreenBottomNavigationItemSelectedListener);         //navigation view selection listener
        homeScreenBottomNavigationView.setSelectedItemId(R.id.bottom_navigation_item_sensors);                                      //select default item sensors
        loadFragments(new SensorsFragment());                                                                                       //default open sensors fragment
    }                                                        //configure bottom navigation menu
    public void populateDashBoardList(){
        homeScreenDashBoardResourceItems.add(new HomeScreenDashBoardResourceItem(
                "12:00 am",     //time
                textSize[0],
                "01/01/2001",   //date
                iconList[0]));                                                                      //1 time and date
        homeScreenDashBoardResourceItems.add(new HomeScreenDashBoardResourceItem(
                "100 Km/hr",
                textSize[1],
                "Speed",
                iconList[1]));                                                                      //2 vehicle speed
        homeScreenDashBoardResourceItems.add(new HomeScreenDashBoardResourceItem(
                "100 %",
                textSize[0],
                "Battery",
                iconList[2]));                                                                      //3 battery level
        homeScreenDashBoardResourceItems.add(new HomeScreenDashBoardResourceItem(
                "24 \u2103",                                                                 //"\u2103" for degree celsius "\u2109" for degree fahrenheit
                textSize[0],
                "Temperature",
                iconList[3]));                                                                      //4 temperature
        homeScreenDashBoardRecyclerViewAdapter.notifyDataSetChanged();                              //notify data changes
    }                                                        //populate dash board recycler view
    public Runnable clock_runnable = new Runnable() {
        @Override
        public void run() {
            run_clock();
            handler.postDelayed(clock_runnable,1000);
        }
        void run_clock(){
            DateFormat timeFormat = new SimpleDateFormat("hh:mm a");                         //time format 14:30 pm
            DateFormat dateFormat = new SimpleDateFormat("EEE, dd MMM, yyyy");               //date format Fri, 10 May, 2019
            String currentTime = timeFormat.format(Calendar.getInstance().getTime());               //get current time with above timeformat
            String currentDate = dateFormat.format(Calendar.getInstance().getTime());               //get current date with above dateformat
            homeScreenDashBoardResourceItems.get(0).setValue1(currentTime);                                       //set current time
            homeScreenDashBoardResourceItems.get(0).setValue2(currentDate);                                       //set current date
            homeScreenDashBoardRecyclerViewAdapter.notifyDataSetChanged();                                //notify data changes
        }
    };                                          //runnable loop for clock
    public Runnable speed_runnable = new Runnable() {
        @Override
        public void run() {
            run_clock();
            handler.postDelayed(speed_runnable,3000);
        }
        void run_clock(){
            cntr++;
            homeScreenDashBoardResourceItems.get(1).setValue1(cntr + " kmph");                      //set current time
            homeScreenDashBoardRecyclerViewAdapter.notifyDataSetChanged();                          //notify data changes
        }
    };                                          //runnable loop for speed display
    BottomNavigationView.OnNavigationItemSelectedListener homeScreenBottomNavigationItemSelectedListener = new BottomNavigationView.OnNavigationItemSelectedListener() {
        @Override
        public boolean onNavigationItemSelected(@NonNull MenuItem menuItem) {
            Fragment fragment = null;
            try{
                switch (menuItem.getItemId()){
                    case R.id.bottom_navigation_item_sensors:
                        fragment = new SensorsFragment();
                        break;
                    case R.id.bottom_navigation_item_maps:
                        fragment = new MapFragment();
                        break;
                    case R.id.bottom_navigation_item_settings:
                        fragment = new SettingsFragment();
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
        getSupportFragmentManager().beginTransaction().replace(R.id.home_screen_frame_layout, _fragment).commit();
        return true;
    }                                           //start journey between fragments
}
