package com.lemon.looka.test2;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.google.gson.Gson;
import com.lemon.looka.R;
import com.lemon.looka.bean.BaseDao;
import com.lemon.looka.test2.http.HttpManager;

public class Test2Activity extends AppCompatActivity implements View.OnClickListener, IView {
    TextView tv1;
    TextView tv2;
    Button btn1;
    Button btn2;
    Button btn3;
    private int page = 1; //默认第一页
    private HttpManager httpManager;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_test2);

        tv1 = findViewById(R.id.test2_tv1);
        tv2 = findViewById(R.id.test2_tv2);
        btn1 = findViewById(R.id.test2_btn1);
        btn2 = findViewById(R.id.test2_btn2);
        btn3 = findViewById(R.id.test2_btn3);
        btn1.setOnClickListener(this);
        btn2.setOnClickListener(this);
        btn3.setOnClickListener(this);

        httpManager = new HttpManager("http://gank.io/api/", this, this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.test2_btn1:
                //请求第一页
                page = 1;
                httpManager.getDataInfo("福利", 2, page);
                break;
            case R.id.test2_btn2:
                //下一页
                page += 1;
                httpManager.getDataInfo("福利", 2, page);
                break;
            case R.id.test2_btn3:
                //上一页
                if (page == 1) {
                    Toast.makeText(this.getApplicationContext(), "已经到第一页", Toast.LENGTH_SHORT).show();
                    return;
                }
                page -= 1;
                httpManager.getDataInfo("福利", 2, page);
                break;
        }
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
        tv1.setText("加载中" + message);
    }

    @Override
    public void showComplete() {
        tv1.setText("加载Ok");
    }
}
