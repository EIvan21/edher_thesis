# If necessary, uncomment the line below to include explore_source.
# include: "thesis_edher_18.model.lkml"

view: pdt_week {
  derived_table: {
    explore_source: transactions {
      column: order_week {}
      column: total_sales_amount {}

    }

  }
  dimension: order_week {
    description: ""
    type: date_week
  }
  dimension: total_sales_amount {
    description: ""
    type: number
  }
  dimension: week1 {
    sql: DATE_ADD(${order_week}, INTERVAL 1 WEEK) ;;
    type: date_week
  }
}
