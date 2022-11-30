view: productcode {
  derived_table: {
    sql: SELECT
          products.product_code  AS `products.product_code`
      FROM sales.transactions  AS transactions
      LEFT JOIN sales.products  AS products ON products.product_code = transactions.product_code
      GROUP BY
          1
      ORDER BY
          products.product_code
      LIMIT 500
       ;;
  }



  dimension: products_product_code {
    type: string
    sql: ${TABLE}.`products.product_code` ;;
  }


}
