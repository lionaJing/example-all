package com.lemon.looka.test2.http;

import android.content.Context;

import com.lemon.looka.bean.BaseDao;
import com.lemon.looka.test2.IView;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.observers.ResourceObserver;
import io.reactivex.schedulers.Schedulers;
import io.rx_cache2.DynamicKey;
import io.rx_cache2.EvictDynamicKey;
import io.rx_cache2.internal.RxCache;
import io.victoralbertos.jolyglot.GsonSpeaker;
import retrofit2.Retrofit;
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory;
import retrofit2.converter.gson.GsonConverterFactory;

/**
 * Created by Jing
 */

public class HttpManager {
    private Retrofit retrofit;
    private IView iView;
    private final CacheProviders cacheProviders;

    public HttpManager(String baseUrl, IView iView, Context context) {
        this.iView = iView;
        retrofit = new Retrofit.Builder()
                .baseUrl(baseUrl)
                .addConverterFactory(GsonConverterFactory.create())
                .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
                .build();
        cacheProviders = new RxCache.Builder()
                .persistence(context.getCacheDir(), new GsonSpeaker())
                .using(CacheProviders.class);
    }

    /**
     * 加载数据
     */
    public void getDataInfo(String param, int number, int page) {
        cacheProviders.getGirlInfo(retrofit.create(GirlService.class).getGirlInfo(param, number, page),
                new DynamicKey(page),
                new EvictDynamicKey(false))
                .observeOn(Schedulers.io())
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new ResourceObserver<BaseDao>() {
                    @Override
                    protected void onStart() {
                        super.onStart();
                        iView.showLoading("开始加载");
                    }

                    @Override
                    public void onNext(BaseDao baseDao) {
                        iView.getData(baseDao);
                    }

                    @Override
                    public void onError(Throwable e) {
                        iView.showError("error"+e);
                    }

                    @Override
                    public void onComplete() {
                        iView.showComplete();
                    }
                });
    }
}
