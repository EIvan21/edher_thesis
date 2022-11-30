# If necessary, uncomment the line below to include explore_source.
# include: "thesis_edher_18.model.lkml"

view: dtview {
  derived_table: {
    explore_source: transactions {
      column: order_date {}
      column: product_code {}
      column: average_sales_amount {}
    }
  }
  dimension: order_date {
    description: ""
    type: date
  }
  dimension: product_code {
    description: ""
  }
  dimension: average_sales_amount {
    description: ""
    type: number
  }
  dimension_group: orders {
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
}
