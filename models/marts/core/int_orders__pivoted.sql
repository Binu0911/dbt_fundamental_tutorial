{%- set payment_methods = ['bank_transfer', 'credit_card','coupan','gift_card','bitcoin'] -%} 
## to remove the white spaces which we are getting in compile code ,we give '-' both and end. It will make our compile code good.
with payments as (select *  from {{ref('stg_payments')}}),
pivoted as (
    select
         order_id,
        {%- set payment_methods = ['bank_transfer', 'credit_card','coupan','gift_card'] -%}
        {%-  for payment_method in payment_methods -%}
        sum(case when payment_method = '{{payment_method}}' then amount else 0 end) as {{payment_method}}_amount   
        {%- if not loop.last -%}
           ,
        {%- endif%}
        {% endfor -%}
    from payments
    where status = 'success'
    group by 1
    order by order_id desc
)
select * from pivoted