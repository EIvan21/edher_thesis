# If necessary, uncomment the line below to include explore_source.
# include: "thesis_edher_18.model.lkml"

view: test_fail {
  derived_table: {
    explore_source: transactions {
      column: market_code {}
      column: custmer_name { field: customers.custmer_name }
      column: sales_amount {}
    }
  }
  dimension: market_code {
    description: ""
  }
  dimension: custmer_name {
    description: ""
  }
  dimension: sales_amount {
    description: ""
    type: number
  }
}
