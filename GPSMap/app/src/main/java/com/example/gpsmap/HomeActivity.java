package com.example.gpsmap;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;

import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;
import com.google.android.things.contrib.driver.gps.NmeaGpsDriver;
import com.google.android.things.contrib.driver.gps.NmeaGpsModule;
import com.google.android.things.userdriver.UserDriverManager;

import java.io.IOException;

public class HomeActivity extends AppCompatActivity implements OnMapReadyCallback {
    NmeaGpsDriver nmeaGpsDriver;
    String gpsUARTName = "UART0";
    int gpsBaudRate = 9600;
    float gpsAccuracy = Float.parseFloat(2.5 + "");

    SupportMapFragment supportMapFragment;
    GoogleMap googleMap;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);
        setupGPSDriver();
        registerGPSDriver();
        supportMapFragment = (SupportMapFragment) getSupportFragmentManager().findFragmentById(R.id.mapFragment);  //map fragment assign to object
        if (supportMapFragment != null) {
            supportMapFragment.getMapAsync(this);                                   //get map asynchronously
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        unregisterGPSDriver();
    }

    @Override
    protected void onPause() {
        super.onPause();
        unregisterGPSDriver();
    }

    public void setupGPSDriver(){
        try {
            nmeaGpsDriver = new NmeaGpsDriver(
                    this,
                    gpsUARTName,
                    gpsBaudRate,
                    gpsAccuracy
            );
        } catch (IOException e) {
            e.printStackTrace();
        }
    }                                                               //setup port and baud rate for gps driver
    public void registerGPSDriver(){
        nmeaGpsDriver.register();
    }                                                            //register gps driver for hardware
    public void unregisterGPSDriver(){
        nmeaGpsDriver.unregister();
        try {
            nmeaGpsDriver.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }                                                          //unregister gps driver from hardware

    @Override
    public void onMapReady(GoogleMap googleMap) {
        googleMap = googleMap;                                                                            //create object map
        LatLng maharashtra = new LatLng(19.120850, 75.183834);                                //latLong variable
        googleMap.addMarker(new MarkerOptions().position(maharashtra).title("Maharashtra"));              //add marker
        googleMap.moveCamera(CameraUpdateFactory.newLatLng(maharashtra));                                 //focus on map

    }
}
