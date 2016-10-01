package com.wja.base.common;

import java.util.ArrayList;
import java.util.Calendar;
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
import com.wja.base.util.Log;

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
            Path expression = null;
            
            List<Predicate> predicates = new ArrayList<>();
            Condition con = null;
            
            for (String key : this.params.keySet())
            {
                if (StringUtils.isNotBlank(key)) // key 的组成 [(or)_]fieldName[_操作符][_数据类型|时间格式] []表示可以没有
                {
                    try
                    {
                        con = new Condition(key,this.params.get(key));
                    }
                    catch (Exception e)
                    {
                        Log.LOGGER.error("动态查询条件处理异常：", e);
                        throw new RuntimeException(e);
                    }
                   
                    //如果没有属性名，就跳过这个条件
                    if(StringUtils.isBlank(con.fieldName)){
                        continue;   
                    }
                    
                    //条件属性处理
                    if (con.fieldName.contains("."))
                    {
                        String[] names = StringUtils.split(con.fieldName, ".");
                        expression = root.get(names[0]);
                        for (int i = 1; i < names.length; i++)
                        {
                            expression = expression.get(names[i]);
                        }
                    }
                    else
                    {
                        expression = root.get(con.fieldName);
                    }
                    
                      
                        switch (con.op)
                        {
                            case eq:
                                if(con.or){
                                    predicates.add(builder.or(builder.equal(expression, con.value)));
                                }
                                else{
                                    predicates.add(builder.equal(expression, con.value));
                                }
                                break;
                            case ne:
                                if(con.or){
                                    predicates.add(builder.or(builder.notEqual(expression, con.value)));
                                }
                                else{
                                    predicates.add(builder.notEqual(expression, con.value));
                                }
                                break;
                            case like:
                                if(con.or){
                                    predicates.add(builder.or(builder.like(expression, "%" + con.value + "%")));
                                }
                                else{
                                    predicates.add(builder.like(expression, "%" + con.value + "%"));
                                }
                                break;
                            case lt:
                                if(con.or){
                                    predicates.add(builder.or(builder.lessThan(expression, (Comparable)con.value)));
                                }
                                else{
                                    predicates.add(builder.lessThan(expression, (Comparable)con.value));
                                }
                                break;
                            case gt:
                                if(con.or){
                                    predicates.add(builder.or(builder.greaterThan(expression, (Comparable)con.value)));
                                }
                                else{
                                    predicates.add(builder.greaterThan(expression, (Comparable)con.value));
                                }
                                break;
                            case lte:
                                if(con.or){
                                    predicates.add(builder.or(builder.lessThanOrEqualTo(expression, (Comparable)con.value)));
                                }
                                else{
                                    predicates.add(builder.lessThanOrEqualTo(expression, (Comparable)con.value));
                                }
                                break;
                            case gte:
                                if(con.or){
                                    predicates.add(builder.or(builder.greaterThanOrEqualTo(expression, (Comparable)con.value)));
                                }
                                else{
                                    predicates.add(builder.greaterThanOrEqualTo(expression, (Comparable)con.value));
                                }
                                break;
                            case isnull:
                                if(con.or){
                                    predicates.add(builder.or(builder.isNull(expression)));
                                }
                                else{
                                    predicates.add(builder.isNull(expression));
                                }
                                break;
                            case in:    
                                if(con.or){
                                    predicates.add(builder.or(builder.in(expression.in((Collection)con.value))));
                                }
                                else{
                                    predicates.add(builder.in(expression.in((Collection)con.value)));
                                }
                                break;
                            case notin:
                                if(con.or){
                                    predicates.add(builder.or(builder.not(builder.in(expression.in((Collection)con.value)))));
                                }
                                else{
                                    predicates.add(builder.not(builder.in(expression.in((Collection)con.value))));
                                }
                                break;
                            case after:                         
                                if(con.or){
                                    predicates.add(builder.or(builder.greaterThanOrEqualTo(expression, (Comparable)con.value)));
                                }
                                else{
                                    predicates.add(builder.greaterThanOrEqualTo(expression, (Comparable)con.value));
                                }     
                                break;
                            case before:     
                                Calendar dv = Calendar.getInstance();
                                dv.setTime((Date)con.value);
                                dv.add(Calendar.DATE, 1);
                                if(con.or){
                                    predicates.add(builder.or(builder.lessThan(expression, dv.getTime())));
                                }
                                else{
                                    predicates.add(builder.lessThan(expression, dv.getTime()));
                                }     
                                break;
                        }
                    }
                }

            // 将查询条件加到查询中
            query.where(predicates.toArray(new Predicate[predicates.size()]));
            }      
        // 查询条件已经加到查询中，所以返回null
        return null;
    }
    
    
    
    public enum OP {
    	eq,ne,like,lt,gt,lte,gte,isnull,in,notin,after,before
    }
    
    public enum DType {
    	string,intt,doubt,date
    }
    
    class Condition
    {
        boolean or = false;
        
        String fieldName;
        
        OP op = OP.eq;
        
        DType dataType = DType.string;
        
        String pattern;
        
        Object value;
        
        // key 的组成 [or_]fieldName[_操作符][_数据类型|时间格式] []表示可以没有
        Condition(String paramName, Object value) throws Exception
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
                        op = OP.valueOf(ops);
                    }
                    
                    // 下一个是数据类型，没有就当string处理
                    index++;
                    if (infos.length > index)
                    {
                        String[] dts = infos[index].trim().split("\\|");
                        String dt = dts[0].trim();
                        if (StringUtils.isNotBlank(dt))
                        {
                            this.dataType = DType.valueOf(dt.toLowerCase());
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
            
            if(StringUtils.isNotBlank(fieldName)){
                // 值处理
                handleValue(value);
            }
        }
        
        private void handleValue(Object v) throws Exception{
        	switch(this.op){
	        	case in:case notin:
	        	    process2collection(v);
	        		break;
	        	default:
	        	    process2single(v);
        	}
        }
        
        private void process2collection(Object v){
            switch(this.dataType){
                case intt:
                   this.value = this.toIntegerList(v);
                   break;
                case doubt:
                    this.value = this.toDoubleList(v);
                    break;
                default: 
                    this.value = v;
            }
        }
        
        private void process2single(Object v) throws Exception{
            switch(this.dataType){
                case intt:
                   this.value = this.toInteger(v);
                   break;
                case doubt:
                    this.value = this.toDouble(v);
                    break;
                case date:
                    this.value = this.toDate(v, this.pattern);
                    break;
                default: 
                    this.value = v;
            }
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
    }
}
