package com.lemon.looka.test2;


import com.lemon.looka.bean.BaseDao;

public interface IView {
    void getData(BaseDao baseDao);
    void showError(String string);
    void showLoading(String message);
    void showComplete();
}
