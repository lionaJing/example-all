package com.lemon.looka.test1.http;


import com.lemon.looka.bean.BaseDao;

import io.reactivex.Observable;
import retrofit2.http.GET;
import retrofit2.http.Path;

public interface GirlService {
    @GET("data/{param}/{number}/{page}")
    Observable<BaseDao> getGirlInfo(@Path("param") String param, @Path("number") int number,
                                    @Path("page") int page);
}
