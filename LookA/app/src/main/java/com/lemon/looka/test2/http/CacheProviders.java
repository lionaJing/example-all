package com.lemon.looka.test2.http;

import com.lemon.looka.bean.BaseDao;

import java.util.concurrent.TimeUnit;

import io.reactivex.Observable;
import io.rx_cache2.DynamicKey;
import io.rx_cache2.EvictDynamicKey;
import io.rx_cache2.LifeCache;

public interface CacheProviders {
    /**
     *
     * @param baseDao 将要缓存的数据
     * @param userName 分页时会用到,对缓存数据进行命名
     * @param evictDynamicKey true 驱逐缓存直接进行网络请求
     * @return Observable
     */
    @LifeCache(duration = 1,timeUnit = TimeUnit.MINUTES)
    Observable<BaseDao> getGirlInfo(Observable<BaseDao> baseDao, DynamicKey userName, EvictDynamicKey evictDynamicKey);
}
