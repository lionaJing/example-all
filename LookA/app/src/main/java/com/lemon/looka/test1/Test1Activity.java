package com.lemon.looka.test1;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.google.gson.Gson;
import com.lemon.looka.ACache;
import com.lemon.looka.R;
import com.lemon.looka.bean.BaseDao;
import com.lemon.looka.test1.http.RetrofitManager;

public class Test1Activity extends AppCompatActivity implements IView, View.OnClickListener  {
    TextView tv1;
    TextView tv2;
    Button btnNormal;
    Button btnCache;
    Button btnClear;
    private RetrofitManager retrofitManager;
    private final String LOG = "Test";

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_test1);

        tv1 = findViewById(R.id.tv1);
        tv2 = findViewById(R.id.tv2);
        btnNormal = findViewById(R.id.btn1);
        btnNormal.setOnClickListener(this);
        btnCache = findViewById(R.id.btn2);
        btnCache.setOnClickListener(this);
        btnClear = findViewById(R.id.btn3);
        btnClear.setOnClickListener(this);

        retrofitManager = new RetrofitManager("http://gank.io/api/",this,this);
    }

    @Override
    public void getData(BaseDao baseDao) {
        tv2.setText(new Gson().toJson(baseDao.getList()));
    }

    @Override
    public void showError(String string) {
        tv1.setText("加载error");
    }

    @Override
    public void showLoading(String message) {
        tv1.setText("加载中:"+message);
    }

    @Override
    public void showComplete() {
        tv1.setText("加载Ok");
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn1:
                retrofitManager.getInfoOnNet("福利",5,1);
                break;
            case R.id.btn2:
                retrofitManager.getDataOnCache("福利",2,1);
                break;
            case R.id.btn3:
                ACache a = ACache.get(Test1Activity.this.getApplicationContext());
                a.clear();
                break;
        }
    }
}
