package com.example.smartauto;

import android.content.Context;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;

public class SettingsFragment extends Fragment {
    TextView tvDemo2;
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_settings, container, false);
        tvDemo2 = view.findViewById(R.id.tv_demo2);
        //tvDemo2.setText("settings");
        Button tvDemo3 = view.findViewById(R.id.tv_demo3);
        tvDemo3.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                MapFragment mapFragment = new MapFragment();
                assert getFragmentManager() != null;
                getFragmentManager().beginTransaction()
                        .replace(R.id.home_screen_frame_layout, mapFragment)
                        .commit();
            }
        });
        return view;
    }
}
