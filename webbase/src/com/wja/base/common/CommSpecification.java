package com.wja.base.common;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.jpa.domain.Specification;

import com.wja.base.util.DateUtil;

public class CommSpecification<T> implements Specification<T>
{
    
    /**
     * serialVersionUID
     */
    private static final long serialVersionUID = -3534444094503385668L;
    
    private Map<String, Object> params;
    
    public CommSpecification(Map<String, Object> params)
    {
        this.params = params;
    }
    
    @Override
    public Predicate toPredicate(Root<T> root, CriteriaQuery<?> query, CriteriaBuilder builder)
    {
        if (this.params != null && this.params.size() > 0)
        {
            String fieldName = null;
            String op = null;
            Path expression = null;
            boolean or = false;
            
            List<Predicate> predicates = new ArrayList<>();
            
            for (String key : this.params.keySet())
            {
                if (StringUtils.isNotBlank(key)) // key 的组成 [(or)_]fieldName[_操作符][_数据类型|时间格式] []表示可以没有
                {
                    String[] infos = key.split("_");
                    int index = 0;
                    // 判断是否(or)_开头
                    if ("(or)".equals(infos[0].trim().toLowerCase()))
                    {
                        or = true;
                        index++;
                    }
                    else
                    {
                        or = false;
                    }
                    
                    if (infos.length > index)
                    {
                        fieldName = infos[index].trim();
                        if (fieldName.contains("."))
                        {
                            String[] names = StringUtils.split(fieldName, ".");
                            expression = root.get(names[0]);
                            for (int i = 1; i < names.length; i++)
                            {
                                expression = expression.get(names[i]);
                            }
                        }
                        else
                        {
                            expression = root.get(fieldName);
                        }
                        
                        // 下一个是操作符，没有则当 eq处理
                        index++;
                        op = "eq";
                        if (infos.length > index)
                        {
                            op = infos[index].trim().toLowerCase();
                        }
                        
                        Object value = this.params.get(key);
                        
                        switch (op)
                        {
                            case "eq":
                                predicates.add(builder.equal(expression, value));
                                break;
                            case "ne":
                                predicates.add(builder.notEqual(expression, value));
                                break;
                            case "like":
                                predicates.add(builder.like(expression, "%" + value + "%"));
                                break;
                            case "lt":
                                predicates.add(builder.lessThan(expression, (Comparable)value));
                                break;
                            case "gt":
                                predicates.add(builder.greaterThan(expression, (Comparable)value));
                                break;
                            case "lte":
                                predicates.add(builder.lessThanOrEqualTo(expression, (Comparable)value));
                                break;
                            case "gte":
                                predicates.add(builder.greaterThanOrEqualTo(expression, (Comparable)value));
                                break;
                            case "isnull":
                                predicates.add(builder.isNull(expression));
                                break;
                            case "in":
                                predicates.add(builder.in(expression.in((Collection)value)));
                                break;
                            case "notin":
                                predicates.add(builder.not(expression.in((Collection)value)));
                                break;
                            case "after":
                                if (value instanceof Date)
                                {
                                    predicates.add(builder.greaterThanOrEqualTo(expression, (Comparable)value));
                                }
                                if (value instanceof String)
                                {
                                    String dstr = ((String)value).trim();
                                    if (StringUtils.isNotBlank(dstr))
                                    {
                                        if (infos.length > ++index)
                                        {
                                        
                                        }
                                    }
                                }
                                break;
                        }
                    }
                }
            }
            // 将查询条件加到查询中
            query.where(predicates.toArray(new Predicate[predicates.size()]));
        }
        
        // 查询条件已经加到查询中，所以返回null
        return null;
    }
    
    private Integer toInteger(Object value)
    {
        if (value instanceof Integer)
        {
            return (Integer)value;
        }
        else
        {
            return Integer.valueOf((String)value);
        }
    }
    
    @SuppressWarnings("unchecked")
    private List<Integer> toIntegerList(Object value)
    {
        List<Integer> datas = new ArrayList<>();
        if (value instanceof List<?>)
        {
            datas = (List<Integer>)value;
        }
        else if (value instanceof String[])
        {
            for (String s : (String[])value)
            {
                datas.add(Integer.valueOf(s));
            }
        }
        else
        {
            datas.add(Integer.valueOf((String)value));
        }
        return datas;
    }
    
    private Double toDouble(Object value)
    {
        if (value instanceof Double)
        {
            return (Double)value;
        }
        else
        {
            return Double.valueOf((String)value);
        }
    }
    
    @SuppressWarnings("unchecked")
    private List<Double> toDoubleList(Object value)
    {
        List<Double> datas = new ArrayList<>();
        if (value instanceof List<?>)
        {
            datas = (List<Double>)value;
        }
        else if (value instanceof String[])
        {
            for (String s : (String[])value)
            {
                datas.add(Double.valueOf(s));
            }
        }
        else
        {
            datas.add(Double.valueOf((String)value));
        }
        return datas;
    }
    
    private Date toDate(Object value, String pattern)
        throws Exception
    {
        if (value instanceof Date)
        {
            return (Date)value;
        }
        else
        {
            String v = (String)value;
            return StringUtils.isBlank(pattern) ? DateUtil.DEFAULT_DF.parse(v)
                : DateUtil.getDateFormat(pattern).parse(v);
        }
    }
    
    private class Condition
    {
        boolean or = false;
        
        String fieldName;
        
        String op = "eq";
        
        String dataType = "string";
        
        String pattern;
        
        Object value;
        
        // key 的组成 [or_]fieldName[_操作符][_数据类型|时间格式] []表示可以没有
        Condition(String paramName, Object value)
        {
            String[] infos = paramName.trim().split("_");
            
            int index = 0;
            // 判断是否or_开头
            if ("or".equals(infos[0].trim().toLowerCase()))
            {
                or = true;
                index++;
            }
            
            if (infos.length > index)
            {
                fieldName = infos[index].trim();
                
                // 下一个是操作符，没有则当 eq处理
                index++;
                if (infos.length > index)
                {
                    String ops = infos[index].trim().toLowerCase();
                    if (StringUtils.isNotBlank(ops))
                    {
                        op = ops;
                    }
                    
                    // 下一个是数据类型，没有就当string处理
                    index++;
                    if (infos.length > index)
                    {
                        String[] dts = infos[index].trim().split("\\|");
                        String dt = dts[0].trim();
                        if (StringUtils.isNotBlank(dt))
                        {
                            this.dataType = dt.toLowerCase();
                        }
                        
                        if (dts.length > 1)
                        {
                            String p = dts[1].trim();
                            if (StringUtils.isNotBlank(dt))
                            {
                                this.pattern = p;
                            }
                        }
                    }
                }
            }
            
            // 值处理
        }
    }
}
