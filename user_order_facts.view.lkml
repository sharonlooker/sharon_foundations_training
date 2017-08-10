view: user_order_facts {
  derived_table: {
    sql: select
        u.id,
        sum(oi.sale_price) as life_revenue,
        min(oi.created_at) as first_order,
        max(oi.created_at) as last_order
      from public.users as u
      left join public.order_items as oi
      on u.id = oi.user_id
      group by 1
       ;;
    datagroup_trigger: daily_rebuild
    distribution: "id"
    sortkeys: ["id"]
  }

  measure: count {
    type: count
  }

  dimension: id {
    type: number
    primary_key: yes
    sql: ${TABLE}.id ;;
  }

  dimension: life_revenue {
    type: number
    sql: ${TABLE}.life_revenue ;;
  }

  dimension_group: first_order {
    type: time
    timeframes: [date, week, year]
    sql: ${TABLE}.first_order ;;
  }

  dimension_group: last_order {
    type: time
    timeframes: [date, week, year]
    sql: ${TABLE}.last_order ;;
  }

}
