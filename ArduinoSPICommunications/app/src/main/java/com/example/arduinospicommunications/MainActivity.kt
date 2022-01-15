package com.example.arduinospicommunications

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.EditText
import com.google.android.material.button.MaterialButton

class MainActivity : AppCompatActivity() {
    private var             spiName     :   String          =   "SPI0.0"
    private var             handleSpi   :   HandleSpi       =   HandleSpi(spiName)
    private lateinit var    etSpeed     :   EditText
    private lateinit var    etDistance  :   EditText
    private lateinit var    btSpeed     :   MaterialButton
    private lateinit var    btDistance  :   MaterialButton
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        etSpeed     = findViewById(R.id.et_speed)
        etDistance  = findViewById(R.id.et_distance)
        btSpeed     = findViewById(R.id.bt_read_speed)
        btDistance  = findViewById(R.id.bt_read_distance)
        btSpeed.setOnClickListener      {etSpeed.setText(handleSpi.getSpeed())}
        btDistance.setOnClickListener   {etDistance.setText(handleSpi.getDistance()) } }
    override fun onDestroy() = super.onDestroy().also { handleSpi.closeSpi() }
}
