package com.example.aasir.thingsmonitor;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONException;
import org.json.JSONObject;

public class MainActivity extends AppCompatActivity {
    EditText etIChannelId, etIApiKey;
    Button btISubmit;
    EditText etOField1, etOField2, etOField3, etOField4;
    String stringChannelId = "";
    String stringApiKey = "";
    String urlPart1 = "https://api.thingspeak.com/channels/";
    String urlPart2 = "/feeds/last?api_key=";


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        etIChannelId = (EditText) findViewById(R.id.et_i_channel_id);
        etIApiKey = (EditText) findViewById(R.id.et_i_api_key);
        btISubmit = (Button) findViewById(R.id.bt_i_submit);
        etOField1 = (EditText) findViewById(R.id.et_o_field1);
        etOField2 = (EditText) findViewById(R.id.et_o_field2);
        etOField3 = (EditText) findViewById(R.id.et_o_field3);
        etOField4 = (EditText) findViewById(R.id.et_o_field4);

        btISubmit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                stringChannelId = etIChannelId.getText().toString();
                stringApiKey = etIApiKey.getText().toString();
                String url = urlPart1 + stringChannelId + urlPart2 + stringApiKey;
                Response.Listener listener = new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {
                        try {
                            JSONObject jsonObject = new JSONObject(response);
                            String field1Data = jsonObject.getString("field1");
                            String field2Data = jsonObject.getString("field2");
                            String field3Data = jsonObject.getString("field3");
                            String field4Data = jsonObject.getString("field4");
                            etOField1.setText(field1Data);
                            etOField2.setText(field2Data);
                            etOField3.setText(field3Data);
                            etOField4.setText(field4Data);
                        } catch (JSONException e) {
                            e.printStackTrace();
                        }
                    }
                };
                GetData getData = new GetData(url, listener);
                RequestQueue queue = Volley.newRequestQueue(MainActivity.this);
                queue.add(getData);
            }
        });
    }
}
class GetData extends StringRequest {

    public GetData(String url, Response.Listener<String> listener) {
        super(Method.GET, url, listener, null);
    }
}