# The name of this view in Looker is "Transactions"
# include: "Tests.view"
view: transactions {
  # extends: [tests]
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: sales.transactions ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Currency" in Explore.

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }
  # dimension: currency_param {
  #   type: string
  #   sql: ${TABLE}.{% parameter ${currency_parameter} %} ;;
  # }

  dimension: viewname {
    type: string
    sql: {% if _view._name == "transactions" %}
        "yes"
        {% else %}
        "No"
    {% endif %} ;;
  }

  dimension: customer_code {
    type: string
    sql: ${TABLE}.customer_code ;;
  }

  dimension: market_code {
    type: string
    sql: ${TABLE}.market_code ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: order {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.order_date ;;
  }

  dimension: product_code {
    type: string
    sql: ${TABLE}.product_code ;;
  }

  dimension: sales_amount {
    type: number
    sql: ${TABLE}.sales_amount ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_sales_amount {
    type: sum
    sql: ${sales_amount} ;;
  }

  measure: average_sales_amount {
    type: average
    sql: ${sales_amount} ;;
  }

  dimension: sales_qty {
    type: number
    sql: ${TABLE}.sales_qty ;;
  }
  dimension: sales_more_than_20000{
    type: yesno
    sql: ${sales_amount} > 20000 ;;
  }

  # measure: sales_by_qty {
  #   type: number
  #   sql: SAFE_DIVIDE(${sales_amount},${sales_qty}) ;;
  # }

  measure: count {
    # label: {{_filters['transactions.filter_start']}}
    type: count
    drill_fields: []
  }

  filter: new_filter_test{
    type: date
  }

  dimension: filter_start{
    type: date
    sql: {% date_start new_filter_test %} ;;
  }

  dimension: filter_end{
    type: date
    sql: {% date_end new_filter_test %} ;;
  }

  measure: test_liquid {
    type: sum
    sql: ${sales_amount} ;;
    # filters: [order_date: "this month"]
    value_format_name: decimal_0
    link: {
      label: "Orders for this month"
      url: "{{last_day_this_month | date: '%m-%d-%Y'}}"
    #   url: "{% assign nextmonth = 'now' |
    # date: '%Y-%m' | append: '-01' | date: '%s' | plus: 3024000 | date: '%Y-%m' | append: '-01' | date: '%s' |
    # minus: 86400 | date: '%m-%d-%Y' %}{{ nextmonth }}"
    }
  }

  measure: becca_m3 {
    type: count_distinct
    sql: CASE WHEN CONCAT(${customer_code},${market_code}) LIKE "%1%"
          and ${product_code} =;;
  }

  measure: test_becca {
    type: number
    value_format: "0.0%"
    sql: ${total_sales_amount}/${average_sales_amount} ;;
  }

  dimension: last_day_this_month {
    type: string
    sql: LAST_DAY(CURRENT_DATE()) ;;


  }

  # dimension: is_last_day_of_month {
  #   type: string
  #   sql: EXTRACT( day from DATEADD(day,1,${date_raw}) ) = 1 ;;
  # }

  filter: filter_date {
    type: date
  }
  dimension: is_selected_timeframe {
    type: yesno
    sql: ${order_date}= ${filter_date} ;;
  }




  # Parameters
  # parameter: sales_amount_less_10000 {
  #   type: unquoted

  #   allowed_value: {
  #     label: "Less than 10,000"
  #     value: "< 10000"
  #   }

  #   allowed_value: {
  #     label: "Less than 20,000"
  #     value: "< 20000"
  #   }

  #   allowed_value: {
  #     label: "All Results"
  #     value: "> 0"
  #   }
  # }

  # parameter: currency_parameter {
  #   label: "Currency Parameter"
  #   description: "This is used to filter plan currency for the plans dashboard."
  #   type: unquoted
  #   suggest_explore: network_plan_currencies
  #   suggest_dimension: currency
  # }

  measure: count_distinct_test {
    type: count_distinct
    sql: ${product_code} ;;
    filters: [
      sales_more_than_20000: "yes"
    ]
  }

  measure: count_distinct_prods {
    type: count_distinct
    sql: ${product_code} ;;
  }

  measure: percent_prods_20000 {
    # type:number
    sql: ${count_distinct_test}/NULLIF(${count_distinct_prods},0) ;;
    value_format: "0.00%"
  }

}
