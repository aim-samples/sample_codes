package com.example.aasir.speedcounter;

import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {
    int speed = 1000;
    int counter = 0;
    EditText etSpeed;
    Button btStart, btReset;
    TextView tvCounter;
    Handler handler = new Handler();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        etSpeed = findViewById(R.id.et_speed);
        btStart = findViewById(R.id.bt_start);
        btReset = findViewById(R.id.bt_reset);
        tvCounter = findViewById(R.id.tv_counter);
        btStart.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String stringSpeed = etSpeed.getText().toString();
                if (stringSpeed.isEmpty()){
                    speed = 1000;
                }else {
                    speed = Integer.parseInt(stringSpeed);
                }
                handler.post(runnable);
                btStart.setVisibility(View.GONE);
                btReset.setVisibility(View.VISIBLE);
            }
        });
        btReset.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //etSpeed.setText("0");
                counter = 0;
                tvCounter.setText("0");
                handler.removeCallbacksAndMessages(null);
                btStart.setVisibility(View.VISIBLE);
                btReset.setVisibility(View.GONE);
            }
        });
    }
    Runnable runnable = new Runnable() {
        @Override
        public void run() {
            if (counter >= 9) {
                counter = 0;
            }
            counter++;
            tvCounter.setText(""+counter);
            handler.postDelayed(runnable, speed);
        }
    };
}
