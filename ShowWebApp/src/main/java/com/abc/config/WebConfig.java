package com.abc.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

/**
 * @author Shuai.Jing
 * @date 2019/3/29
 */
@Configuration
@Import({WebSocketConfig.class})
public class WebConfig extends WebMvcConfigurerAdapter {

}
