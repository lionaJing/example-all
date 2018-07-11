package com.lemon.looka;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import com.lemon.looka.test1.Test1Activity;
import com.lemon.looka.test2.Test2Activity;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {
    Button button1;
    Button button2;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        button1 = findViewById(R.id.btn1);
        button2 = findViewById(R.id.btn2);
        button1.setOnClickListener(this);
        button2.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        Intent intent = new Intent();
        switch (v.getId()) {
            case R.id.btn1:
                intent.setClass(MainActivity.this.getApplicationContext(), Test1Activity.class);
                break;
            case R.id.btn2:
                intent.setClass(MainActivity.this.getApplicationContext(), Test2Activity.class);
                break;
        }
        startActivity(intent);
    }
}
