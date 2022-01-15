package com.example.smartbike

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle

class HomeActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_home)
        var builder = AlertDialog.Builder(this@HomeActivity)
        builder.setTitle("Color")
        builder.setMessage("set background color to red")
        builder.setNeutralButton("Cancel"){_,_ ->
            Toast.makeToast(applicationContext,"you pressed cancel", Toast.LENGTH_SHORT).show()
        }
        val dialog: AlertDialog = builder.create()
        dialog.show()
    }
}