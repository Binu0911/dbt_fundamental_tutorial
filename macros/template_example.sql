{ % macro template_example() % }
   
    {% set query %}
        select true as bool
    {% endset %}

    {% if execute %}
        {% set results = run(query).columns[0].values()([0])%}
        {{log('SQL results' ~results,info= True)}}

        select 
            {{results}} as _is_real 
                from a_real_table
    {% endif %}

{% endmacro %}