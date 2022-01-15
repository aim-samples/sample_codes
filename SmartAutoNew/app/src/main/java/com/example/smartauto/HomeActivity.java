package com.example.smartauto;

import androidx.appcompat.app.AppCompatActivity;
import androidx.drawerlayout.widget.DrawerLayout;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.res.Configuration;
import android.os.Bundle;
import android.view.View;

import com.example.smartauto.Adapters.HomeActivityDashBoardAdapter;
import com.example.smartauto.Adapters.HomeActivityDashBoardResourceItem;
import com.google.android.material.navigation.NavigationView;

import java.util.ArrayList;

/**
 * Skeleton of an Android Things activity.
 * <p>
 * Android Things peripheral APIs are accessible through the class
 * PeripheralManagerService. For example, the snippet below will open a GPIO pin and
 * set it to HIGH:
 *
 * <pre>{@code
 * PeripheralManagerService service = new PeripheralManagerService();
 * mLedGpio = service.openGpio("BCM6");
 * mLedGpio.setDirection(Gpio.DIRECTION_OUT_INITIALLY_LOW);
 * mLedGpio.setValue(true);
 * }</pre>
 * <p>
 * For more complex peripherals, look for an existing user-space driver, or implement one if none
 * is available.
 *
 * @see <a href="https://github.com/androidthings/contrib-drivers#readme">https://github.com/androidthings/contrib-drivers#readme</a>
 */
public class HomeActivity extends AppCompatActivity {
    DrawerLayout homeActivityDrawerLayout;
    NavigationView homeActivityDrawerNavigationView;
    View homeActivityDrawerNavigationHeader;

    RecyclerView homeActivityDashBoardRecyclerView;
    RecyclerView.LayoutManager homeActivityDashBoardRecyclerViewLayoutManager;
    RecyclerView.Adapter homeActivityDashBoardRecyclerViewAdapter;
    ArrayList<HomeActivityDashBoardResourceItem> homeActivityDashBoardResourceItems;

    Integer[] iconList = {
            R.drawable.ic_access_time_blue_grey_24dp,
            R.drawable.ic_navigation_blue_grey_24dp,
            R.drawable.ic_battery_charging_full_blue_grey_24dp,
            R.drawable.ic_cloud_blue_grey_24dp
    };
    int[] textSize = {
            14,
            18
    };
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);
        configureDrawer();
        populateDashBoardList();
    }
    public void configureDrawer(){
        homeActivityDrawerLayout = findViewById(R.id.activity_home_drawer_layout);
        int orientation = this.getResources().getConfiguration().orientation;
        if (orientation == Configuration.ORIENTATION_LANDSCAPE){
            homeActivityDrawerLayout.setDrawerLockMode(DrawerLayout.LOCK_MODE_LOCKED_OPEN);
            homeActivityDrawerLayout.setScrimColor(0);
        }
        homeActivityDrawerNavigationView = findViewById(R.id.activity_home_drawer_navigation_view);
        homeActivityDrawerNavigationHeader = homeActivityDrawerNavigationView.getHeaderView(0);

        homeActivityDashBoardResourceItems = new ArrayList<>();
        homeActivityDashBoardRecyclerView = homeActivityDrawerNavigationHeader.findViewById(R.id.activity_home_dash_board_recycler_view);
        homeActivityDashBoardRecyclerViewLayoutManager = new LinearLayoutManager(getApplicationContext());
        homeActivityDashBoardRecyclerViewAdapter = new HomeActivityDashBoardAdapter(homeActivityDashBoardResourceItems);
        //homeActivityDashBoardRecyclerView.setHasFixedSize(true);
        homeActivityDashBoardRecyclerView.setLayoutManager(homeActivityDashBoardRecyclerViewLayoutManager);
        homeActivityDashBoardRecyclerView.setAdapter(homeActivityDashBoardRecyclerViewAdapter);
    }
    public void populateDashBoardList(){
        homeActivityDashBoardResourceItems.add(new HomeActivityDashBoardResourceItem(
                "12:00 am",
                textSize[0],
                "01/01/2001",
                iconList[0]));
        homeActivityDashBoardResourceItems.add(new HomeActivityDashBoardResourceItem(
                "100 km/hr",
                textSize[1],
                "Speed",
                iconList[1]));
        homeActivityDashBoardResourceItems.add(new HomeActivityDashBoardResourceItem(
                "100 %",
                textSize[0],
                "Battery",
                iconList[2]));
        homeActivityDashBoardResourceItems.add(new HomeActivityDashBoardResourceItem(
                "24 \u2103",
                textSize[0],
                "Temperature",
                iconList[3]));
        homeActivityDashBoardRecyclerViewAdapter.notifyDataSetChanged();
    }
}
