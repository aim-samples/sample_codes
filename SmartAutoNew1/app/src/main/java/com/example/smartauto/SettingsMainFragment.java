package com.example.smartauto;

import android.bluetooth.BluetoothAdapter;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.Uri;
import android.net.wifi.WifiManager;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CompoundButton;
import android.widget.Switch;
import android.widget.TextView;

import java.util.Objects;

public class SettingsMainFragment extends Fragment {
    WifiManager wifiManager;
    BluetoothAdapter bluetoothAdapter;
    TextView settingsMainCardWifiStatus;
    TextView settingsMainCardBluetoothStatus;
    Switch settingsMainCardWifiSwitch;
    Switch settingsMainCardBluetoothSwitch;
    String[] networkStatus = {
            "Disabled",
            "Disconnected",
            "Connected"
    };
    String[] bluetoothNetworkStatus = {
            "Disabled",
            "Disconnected",
            "Turning ON",
            "Turning OFF",
            "Connected"
    };
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_settings_main, container, false);
        Objects.requireNonNull(getActivity()).setTitle("Settings");
        configNetworkAdapters();
        configureWidgets(view);
        return view;
    }
    public void configureWidgets(View _view){
        settingsMainCardWifiStatus = _view.findViewById(R.id.settings_main_card_wifi_status);
        settingsMainCardBluetoothStatus = _view.findViewById(R.id.settings_main_card_bluetooth_status);
        settingsMainCardWifiSwitch = _view.findViewById(R.id.settings_main_card_wifi_switch);
        settingsMainCardBluetoothSwitch = _view.findViewById(R.id.settings_main_card_bluetooth_switch);
        settingsMainCardWifiSwitch.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (isChecked){ wifiManager.setWifiEnabled(true); }
                else{ wifiManager.setWifiEnabled(false); }
            }
        });
        settingsMainCardBluetoothSwitch.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (isChecked){ bluetoothAdapter.enable(); }
                else{ bluetoothAdapter.disable(); }
            }
        });
    }
    public void configNetworkAdapters(){
        wifiManager = (WifiManager) getContext().getSystemService(Context.WIFI_SERVICE);
        bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
    }
    private BroadcastReceiver wifiBroadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            int wifiStateExtra = intent.getIntExtra(WifiManager.EXTRA_WIFI_STATE,
                    WifiManager.WIFI_STATE_UNKNOWN);
            switch (wifiStateExtra){
                case WifiManager.WIFI_STATE_ENABLED:
                    settingsMainCardWifiSwitch.setChecked(true);
                    settingsMainCardWifiStatus.setText(networkStatus[1]);
                    break;
                case WifiManager.WIFI_STATE_DISABLED:
                    settingsMainCardWifiSwitch.setChecked(false);
                    settingsMainCardWifiStatus.setText(networkStatus[0]);
                    break;
                default:
                    settingsMainCardWifiStatus.setText(networkStatus[0]);
                    break;
            }
        }
    };
    private BroadcastReceiver bluetoothBroadcastReceiver = new BroadcastReceiver(){
        @Override
        public void onReceive(Context context, Intent intent) {
            int bluetoothStateExtra = intent.getIntExtra(BluetoothAdapter.EXTRA_STATE,
                    BluetoothAdapter.ERROR);
            switch (bluetoothStateExtra){
                case BluetoothAdapter.STATE_ON:
                    settingsMainCardBluetoothSwitch.setChecked(true);
                    settingsMainCardBluetoothStatus.setText(bluetoothNetworkStatus[1]);
                    break;
                case BluetoothAdapter.STATE_OFF:
                    settingsMainCardBluetoothSwitch.setChecked(false);
                    settingsMainCardBluetoothStatus.setText(bluetoothNetworkStatus[0]);
                    break;
                case BluetoothAdapter.STATE_TURNING_ON:
                    settingsMainCardBluetoothStatus.setText(bluetoothNetworkStatus[2]);
                    break;
                case BluetoothAdapter.STATE_TURNING_OFF:
                    settingsMainCardBluetoothStatus.setText(bluetoothNetworkStatus[3]);
                    break;
                case BluetoothAdapter.STATE_DISCONNECTED:
                    settingsMainCardBluetoothStatus.setText(bluetoothNetworkStatus[1]);
                    break;
                case BluetoothAdapter.STATE_CONNECTED:
                    settingsMainCardBluetoothStatus.setText(bluetoothNetworkStatus[4]);
                    break;
                default:
                    settingsMainCardBluetoothStatus.setText(bluetoothNetworkStatus[0]);
                    break;
            }
        }
    };
    @Override
    public void onStart() {
        super.onStart();
        IntentFilter wifiIntentFilter = new IntentFilter(WifiManager.WIFI_STATE_CHANGED_ACTION);
        Objects.requireNonNull(getContext()).registerReceiver(wifiBroadcastReceiver, wifiIntentFilter);
        IntentFilter bluetoothIntentFilter = new IntentFilter(BluetoothAdapter.ACTION_STATE_CHANGED);
        getContext().registerReceiver(bluetoothBroadcastReceiver, bluetoothIntentFilter);
    }
    @Override
    public void onStop() {
        super.onStop();
        Objects.requireNonNull(getContext()).unregisterReceiver(wifiBroadcastReceiver);
        getContext().unregisterReceiver(bluetoothBroadcastReceiver);
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 1){
        }
    }
}