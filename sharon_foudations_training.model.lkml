connection: "events_ecommerce"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: daily_rebuild {
  sql_trigger: select current_date ;;
}

explore: users {
  label: "Users"
  join: order_items {
    type: left_outer
    relationship: one_to_many
    sql_on: ${users.id} = ${order_items.user_id} ;;
  }

  join: user_order_facts {
    type: left_outer
    relationship: one_to_one
    sql_on: ${users.id}=${user_order_facts.id} ;;
  }

}

explore: products {}
