view: d_dates {
  sql_table_name: "DATA_MART"."D_DATES" ;;


  set: fields {
    fields: [
      date_val_date,
      date_val_month,
      date_val_quarter,
      date_val_week,
      date_val_year,
      filter_dates,
      dynamic_date_filter
    ]
  }

  dimension_group: date_val {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."DATE_VAL" ;;
  }
  dimension: datekey {
    primary_key: yes
    type: number
    sql: ${TABLE}."DATEKEY" ;;
  }
  dimension: day_of_week {
    type: number
    sql: ${TABLE}."DAY_OF_WEEK" ;;
  }
  dimension: dayname_of_week {
    type: string
    sql: ${TABLE}."DAYNAME_OF_WEEK" ;;
  }
  dimension: month_name {
    type: string
    sql: ${TABLE}."MONTH_NAME" ;;
  }
  dimension: month_num {
    type: number
    sql: ${TABLE}."MONTH_NUM" ;;
  }
  dimension: quarter {
    type: number
    sql: ${TABLE}."QUARTER" ;;
  }
  dimension: year {
    type: number
    sql: ${TABLE}."YEAR" ;;
  }
  measure: count {
    type: count
    drill_fields: [month_name]
  }

  dimension: date_value {
    datatype: date
    sql: ${TABLE}."DATE_VAL" ;;
  }

  parameter: filter_dates {
    type: unquoted
    allowed_value: {
      value: "Month"
      label: "Month"
    }
    allowed_value:
    {value: "Quarter"
      label: "Quarter"
    }
    allowed_value:
    {value: "Year"
      label: "Year"
    }
  }


  dimension: dynamic_date_filter {
    type: number
    label_from_parameter: filter_dates
    sql: {% parameter filter_dates %} ${date_value} ;;
  }


}
