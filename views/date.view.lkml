# The name of this view in Looker is "Date"
view: date {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: sales.date ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: cy {
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
    sql: ${TABLE}.cy_date ;;
  }

  dimension_group: date {
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
    sql: ${TABLE}.date ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Date Yy Mmm" in Explore.

  dimension: date_yy_mmm {
    type: string
    sql: ${TABLE}.date_yy_mmm ;;
  }

  dimension: month_name {
    type: string
    sql: ${TABLE}.month_name ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_year {
    type: sum
    sql: ${year} ;;
  }

  measure: average_year {
    type: average
    sql: ${year} ;;
  }

  measure: count {
    type: count
    drill_fields: [month_name]
  }
}
