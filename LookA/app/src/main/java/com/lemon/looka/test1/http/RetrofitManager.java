package com.lemon.looka.test1.http;

import android.content.Context;

import com.lemon.looka.ACache;
import com.lemon.looka.bean.BaseDao;
import com.lemon.looka.test1.IView;

import io.reactivex.Observable;
import io.reactivex.ObservableEmitter;
import io.reactivex.ObservableOnSubscribe;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.observers.ResourceObserver;
import io.reactivex.schedulers.Schedulers;
import retrofit2.Retrofit;
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory;
import retrofit2.converter.gson.GsonConverterFactory;

public class RetrofitManager {
    private Retrofit retrofit;
    private IView iView;
    private ACache aCache;
    private final String KEY = "GIRL_KEY";

    public RetrofitManager(String baseUrl, IView iView, Context context) {
        this.iView = iView;
        aCache = ACache.get(context);
        retrofit = new Retrofit.Builder()
                .baseUrl(baseUrl)
                .addConverterFactory(GsonConverterFactory.create())
                .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
                .build();
    }

    /**
     * 具体网络请求(普通的)
     *
     * @param param  数据类型
     * @param number 数量
     * @param page   页数
     */
    public void getInfoOnNet(String param, int number, int page) {
        retrofit.create(GirlService.class)
                .getGirlInfo(param, number, page)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .doOnNext((dao) -> {
                    //存储到缓存
                    aCache.put(KEY, dao);
                })
                .subscribe(new ResourceObserver<BaseDao>() {

                    @Override
                    protected void onStart() {
                        super.onStart();
                        iView.showLoading("");
                    }

                    @Override
                    public void onNext(BaseDao baseDao) {
                        iView.getData(baseDao);
                    }

                    @Override
                    public void onError(Throwable e) {
                        iView.showError("操作失败");
                    }

                    @Override
                    public void onComplete() {
                        iView.showComplete();
                    }
                });
    }

    /**
     * 加载数据(缓存)
     * https://www.jianshu.com/p/74d2c10c3eba?from=timeline
     */
    public void getDataOnCache(String param, int number, int page) {
        Observable<BaseDao> netObservable = retrofit.create(GirlService.class)
                .getGirlInfo(param, number, page)
                .onErrorResumeNext((t) -> {
                    return Observable.never();
                });
        Observable<BaseDao> cacheObservable = Observable.create(new ObservableOnSubscribe<BaseDao>() {
            @Override
            public void subscribe(ObservableEmitter<BaseDao> emitter) throws Exception {
                emitter.onNext((BaseDao)aCache.getAsObject(KEY));
            }
        }).onErrorResumeNext((t) -> {
            return Observable.empty();
        });

        Observable<BaseDao> publishObservable = netObservable.subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .publish((observable) -> Observable.merge(observable,
                        cacheObservable.subscribeOn(Schedulers.io()).takeUntil(observable)));

        publishObservable.subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new ResourceObserver<BaseDao>() {
                    @Override
                    protected void onStart() {
                        super.onStart();
                        iView.showLoading("+缓存");
                    }
                    @Override
                    public void onNext(BaseDao baseDao) {
                        iView.getData(baseDao);
                    }

                    @Override
                    public void onError(Throwable e) {
                        iView.showError("操作失败[缓存]");
                    }

                    @Override
                    public void onComplete() {
                        iView.showComplete();
                    }
                });
    }
}
