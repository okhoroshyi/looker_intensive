view: f_lineitems {
  sql_table_name: "DATA_MART"."F_LINEITEMS" ;;

  set: fields {
    fields: [
      l_orderdatekey,
      total_sale_price,
      avg_sale_price,
      total_gross_revenue,
      total_cost,
      total_gross_margin_amount,
      gross_margin_percentage,
      number_of_items_returned,
      total_items_sold,
      item_return_rate,
      average_spend_per_customer,
      number_of_orders,
      l_shipmode,
      l_shipinstruct,
      total_revenue_percentile,
      return_rate_rendered
    ]
  }


  dimension: l_availqty {
    type: number
    sql: ${TABLE}."L_AVAILQTY" ;;
  }
  dimension: l_clerk {
    type: string
    sql: ${TABLE}."L_CLERK" ;;
  }
  dimension: l_commitdatekey {
    type: number
    sql: ${TABLE}."L_COMMITDATEKEY" ;;
  }
  dimension: l_custkey {
    type: number
    sql: ${TABLE}."L_CUSTKEY" ;;
  }
  dimension: l_discount {
    type: number
    sql: ${TABLE}."L_DISCOUNT" ;;
  }
  dimension: l_extendedprice {
    type: number
    sql: ${TABLE}."L_EXTENDEDPRICE" ;;
  }
  dimension: l_linenumber {
    type: number
    sql: ${TABLE}."L_LINENUMBER" ;;
  }
  dimension: l_orderdatekey {
    type: number
    sql: ${TABLE}."L_ORDERDATEKEY" ;;
  }
  dimension: l_orderkey {
    primary_key: yes
    type: number
    sql: ${TABLE}."L_ORDERKEY" ;;
  }
  dimension: l_orderpriority {
    type: string
    sql: ${TABLE}."L_ORDERPRIORITY" ;;
  }
  dimension: l_orderstatus {
    type: string
    sql: ${TABLE}."L_ORDERSTATUS" ;;
  }
  dimension: l_partkey {
    type: number
    sql: ${TABLE}."L_PARTKEY" ;;
  }
  dimension: l_quantity {
    type: number
    sql: ${TABLE}."L_QUANTITY" ;;
  }
  dimension: l_receiptdatekey {
    type: number
    sql: ${TABLE}."L_RECEIPTDATEKEY" ;;
  }
  dimension: l_returnflag {
    type: string
    sql: ${TABLE}."L_RETURNFLAG" ;;
  }
  dimension: l_shipdatekey {
    type: number
    sql: ${TABLE}."L_SHIPDATEKEY" ;;
  }
  dimension: l_shipinstruct {
    type: string
    sql: ${TABLE}."L_SHIPINSTRUCT" ;;
  }
  dimension: l_shipmode {
    type: string
    sql: ${TABLE}."L_SHIPMODE" ;;
  }
  dimension: l_shippriority {
    type: number
    sql: ${TABLE}."L_SHIPPRIORITY" ;;
  }
  dimension: l_suppkey {
    type: number
    sql: ${TABLE}."L_SUPPKEY" ;;
  }
  dimension: l_supplycost {
    type: number
    sql: ${TABLE}."L_SUPPLYCOST" ;;
  }
  dimension: l_tax {
    type: number
    sql: ${TABLE}."L_TAX" ;;
  }
  dimension: l_totalprice {
    type: number
    sql: ${TABLE}."L_TOTALPRICE" ;;
  }


  measure: total_sale_price {
    label: "Total Revenue"
    type: sum
    sql: ${l_totalprice} ;;
  }

  measure: total_revenue_percentile {
    label: "percent of total revenue"
    type: percent_of_total
    sql: ${total_sale_price} ;;
    }

  measure: avg_sale_price {
    type: average
    sql: ${l_totalprice} ;;
  }

  measure: total_gross_revenue {
    label: "Total Gross Revenue"
    type: sum
    filters: [l_orderstatus: "F"]
    sql: ${l_totalprice}  ;;
  }

  measure: total_cost {
    label: "Total Cost"
    type: sum
    sql: ${l_supplycost}  ;;
  }

  measure: total_gross_margin_amount {
    label: "Total Gross Margin Amount"
    type: number
    sql: ${total_gross_revenue} - ${total_cost} ;;
    drill_fields: [d_customer.c_region, d_supplier.acc_balance_bs]
  }

  measure: gross_margin_percentage {
    label: "Goss Margin Percentage"
    type: number
    value_format: "0.00%"
    sql: ${total_gross_margin_amount} / ${total_gross_revenue} ;;
  }

  measure: number_of_items_returned {
    label: "Number of Items Returned"
    filters: [l_returnflag: "R"]
    type: sum
    sql: ${l_quantity}  ;;
  }

  measure: total_items_sold {
    label: "Total Number of Items Sold"
    type: sum
    #filters: [l_orderstatus: "F"]
    sql: ${l_quantity}  ;;
  }

  measure: item_return_rate {
    label: "Item Return Rate"
    type: number
    value_format: "0.00%"
    sql: ${number_of_items_returned} / ${total_items_sold} ;;
  }

  measure: count_customers {
    type: count_distinct
    sql_distinct_key: ${l_custkey} ;;
  }

  measure: average_spend_per_customer {
    label: "Average Spend per Customer"
    type: number
    sql: case when ${count_customers}=0 then 0 else ${total_sale_price} / ${count_customers} end ;;
  }

  measure: number_of_orders {
      type: count
      label: "number of orders"
    }

  measure: return_rate_rendered {
    type: number
    label: "Item Return Rate rendered"
    value_format_name: percent_2
    sql: ${item_return_rate} ;;
    html: {% if value >=0.5 %}
      <font color="red">{{rendered_value}}</font>
      {% elsif value >=0.3 and value <0.5 %}
      <font color="yellow">{{rendered_value}}</font>
      {% else %}
      <font color="green">{{rendered_value}}</font>
      {% endif %}
      ;;
  }
}
