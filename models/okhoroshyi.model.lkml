connection: "tpchlooker"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: okhoroshyi_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: okhoroshyi_default_datagroup

explore: d_customer {}

explore: d_dates {}

explore: d_part {}

explore: d_supplier {}

explore: f_lineitems {
  label: "Line Items"
  fields: [
    f_lineitems.fields*,
    d_dates.fields*,
    d_customer.fields*,
    d_supplier.fields*
  ]

  join: d_dates {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${f_lineitems.l_orderdatekey} = ${d_dates.datekey} ;;
  }

  join: d_customer {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${f_lineitems.l_custkey} = ${d_customer.c_custkey} ;;
  }

  join: d_part {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${f_lineitems.l_partkey} = ${d_part.p_partkey} ;;
  }

  join: d_supplier {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${f_lineitems.l_suppkey} = ${d_supplier.s_suppkey} ;;
  }

}
