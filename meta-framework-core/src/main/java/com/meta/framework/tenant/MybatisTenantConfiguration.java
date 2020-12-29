package com.meta.framework.tenant;

import com.meta.framework.interceptor.mybatis.TenantInvokeInterceptor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.Iterator;
import java.util.List;

/**
 * MybatisTenantConfiguration
 *
 * @author lidongzhang
 */
@Slf4j
@Configuration
public class MybatisTenantConfiguration {

    public MybatisTenantConfiguration() {
        log.info("----------MybatisTenantConfiguration start ----------------");
    }

    @Resource
    private List<SqlSessionFactory> sqlSessionFactoryList;

    @Bean
    public TenantInterceptor tenantIdInterceptor() {
        return new TenantInterceptor();
    }

    @Bean
    public TenantInvokeInterceptor tenantInvokeInterceptor() {
        return new TenantInvokeInterceptor();
    }

    @PostConstruct
    public void addPageInterceptor() {
        Iterator var3 = this.sqlSessionFactoryList.iterator();

        while (var3.hasNext()) {
            SqlSessionFactory sqlSessionFactory = (SqlSessionFactory) var3.next();
            org.apache.ibatis.session.Configuration configuration = sqlSessionFactory.getConfiguration();
            // 拦截器执行顺序 PageInterceptor > TenantInvokeInterceptor > TenantIdInterceptor
            configuration.addInterceptor(tenantIdInterceptor());
            configuration.addInterceptor(tenantInvokeInterceptor());
        }
    }
}
