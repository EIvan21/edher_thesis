# The name of this view in Looker is "Products"
view: products {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: sales.products ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Product Code" in Explore.

  dimension: product_code {
    type: string
    sql: ${TABLE}.product_code ;;
    primary_key: yes
  }

  dimension: product_type {
    type: string
    sql: ${TABLE}.product_type ;;
  }

  dimension: product_type_2 {
    type: string
    sql: ${TABLE}.product_type ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
