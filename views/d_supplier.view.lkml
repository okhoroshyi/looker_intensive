view: d_supplier {
  sql_table_name: "DATA_MART"."D_SUPPLIER" ;;

  set: fields {
    fields: [
      acc_balance_bs,
      count_all,
      s_name,
      s_region
    ]
  }

  dimension: s_acctbal {
    type: number
    sql: ${TABLE}."S_ACCTBAL" ;;
  }
  dimension: s_address {
    type: string
    sql: ${TABLE}."S_ADDRESS" ;;
  }
  dimension: s_name {
    label: "Sup name"
    type: string
    sql: ${TABLE}."S_NAME" ;;
  }
  dimension: s_nation {
    type: string
    sql: ${TABLE}."S_NATION" ;;
  }
  dimension: s_phone {
    type: string
    sql: ${TABLE}."S_PHONE" ;;
  }
  dimension: s_region {
    type: string
    sql: ${TABLE}."S_REGION" ;;
  }
  dimension: s_suppkey {
    primary_key: yes
    type: number
    sql: ${TABLE}."S_SUPPKEY" ;;
  }
  measure: count {
    type: count
    drill_fields: [s_name]
  }

  dimension: acc_balance_bs {
    type: string
    sql: CASE
    --  WHEN ${s_acctbal} < 1 THEN "=<0"
      WHEN ${s_acctbal} between 1 and 3000 THEN '1-3000'
      WHEN ${s_acctbal} between 3001 and 5000 THEN '3001-5000'
      WHEN ${s_acctbal} between 5001 and 7000 THEN '5001-7000'
      ELSE '>7000'
      END ;;
  }

  measure: count_all {
    type: count
    label: "sup_cnt"
  }
}
