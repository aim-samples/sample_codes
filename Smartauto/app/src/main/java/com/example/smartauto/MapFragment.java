package com.example.smartauto;

import android.app.Activity;
import android.content.Context;
import android.net.Uri;
import android.opengl.Visibility;
import android.os.Bundle;
import android.support.design.card.MaterialCardView;
import android.support.v4.app.Fragment;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.TextView;

import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.MapView;
import com.google.android.gms.maps.MapsInitializer;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;


public class MapFragment extends Fragment implements OnMapReadyCallback {
    MapView locationFragmentMapView;
    GoogleMap map;
    EditText etLocationFragmentSearchLocation;
    Boolean bwidgetsHidden = true;
    MaterialCardView searchLocationcardView;
    float defaultZoom = 15;
    //MaterialCardView
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_map, container, false);
        configMapView(view, savedInstanceState);
        configEtLocationSearch(view);
        return view;
    }
    @Override
    public void onMapReady(GoogleMap _googleMap) {
        map = _googleMap;
        map.setMyLocationEnabled(true);
        map.getUiSettings().setMyLocationButtonEnabled(true);
        LatLng maharashtra = new LatLng(19.120850, 75.183834);                                //latLong variable
        //map.addMarker(new MarkerOptions().position(maharashtra).title("Maharashtra"));              //add marker
        map.moveCamera(CameraUpdateFactory.newLatLngZoom(maharashtra,defaultZoom));                                 //focus on map
        map.animateCamera(CameraUpdateFactory.newLatLngZoom(maharashtra,defaultZoom));
        map.setOnMapClickListener(new GoogleMap.OnMapClickListener() {
            @Override
            public void onMapClick(LatLng latLng) {
                hideWidgets();
            }
        });
        MarkerOptions markerOptions = new MarkerOptions().position(maharashtra);
        // ROSE color icon
        markerOptions.icon(BitmapDescriptorFactory
                .defaultMarker(BitmapDescriptorFactory.HUE_ROSE));
        markerOptions.position(maharashtra);
        // adding markerOptions
        Marker marker = map.addMarker(markerOptions);

    }                                              //perform somethings on map load
    public void configMapView(View _view, Bundle _savedInstanceState){
        searchLocationcardView = _view.findViewById(R.id.card_location_fragment_search_location);
        locationFragmentMapView = (MapView) _view.findViewById(R.id.location_fragment_map_view);
        locationFragmentMapView.onCreate(_savedInstanceState);
        locationFragmentMapView.onResume();
        if (locationFragmentMapView != null) {
            locationFragmentMapView.getMapAsync(this);
        }
    }                          //config map view
    public void configEtLocationSearch(final View _view){
        etLocationFragmentSearchLocation = _view.findViewById(R.id.et_location_fragment_search_location);
        etLocationFragmentSearchLocation.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
                if (actionId == EditorInfo.IME_ACTION_SEARCH){
                    //search
                    InputMethodManager inputMethodManager =(InputMethodManager)getActivity().getSystemService(Activity.INPUT_METHOD_SERVICE);
                    inputMethodManager.hideSoftInputFromWindow(_view.getWindowToken(), 0);
                    return true;
                }
                return false;
            }
        });
    }                                       //config location search edittext
    public void hideWidgets(){
        bwidgetsHidden = !bwidgetsHidden;
        if (bwidgetsHidden){
            searchLocationcardView.setVisibility(View.VISIBLE);
        }else {
            searchLocationcardView.setVisibility(View.GONE);
        }
    }
}
