package com.lemon.looka.bean;

import java.io.Serializable;
import java.util.ArrayList;

public class BaseDao implements Serializable{
    private boolean error;
    private ArrayList<GirlDao> results;

    public boolean isError() {
        return error;
    }

    public void setError(boolean error) {
        this.error = error;
    }

    public ArrayList<GirlDao> getList() {
        return results;
    }

    public void setList(ArrayList<GirlDao> results) {
        this.results = results;
    }
}
