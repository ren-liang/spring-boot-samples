package com.dcits.config;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.TransactionManagementConfigurer;

import javax.sql.DataSource;

@Configuration
@EnableTransactionManagement
@MapperScan({"com.dcits.domain.dao"})
public class SessionFactoryConfig  implements TransactionManagementConfigurer
{
    private static String MYBATIS_CONFIG = "mybatis-config.xml";
    @Autowired
    private DataSource dataSource;

    private String typeAliasPackage = "com.dcits.domain.model";

    @Bean(name={"sqlSessionFactory"})
    public SqlSessionFactoryBean createSqlSessionFactoryBean()  throws Exception
    {
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();

        sqlSessionFactoryBean.setConfigLocation(new ClassPathResource(MYBATIS_CONFIG));

        sqlSessionFactoryBean.setDataSource(this.dataSource);

        sqlSessionFactoryBean.setTypeAliasesPackage(this.typeAliasPackage);
        PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
        sqlSessionFactoryBean.setMapperLocations(resolver.getResources("classpath:/mapping/*.xml"));
        return sqlSessionFactoryBean;
    }

    @Bean
    public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory)
    {
        return new SqlSessionTemplate(sqlSessionFactory);
    }

    @Bean
    public PlatformTransactionManager annotationDrivenTransactionManager()
    {
        return new DataSourceTransactionManager(this.dataSource);
    }
}

