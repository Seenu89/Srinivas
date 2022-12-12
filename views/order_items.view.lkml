# The name of this view in Looker is "Order Items"
view: order_items {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `thelook.order_items`
    ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
    # html: {{ rendered_value | date: "%A, %B %e, %Y" }} ;;
  }

  # dimension: dynamic_date {
  #   label: "Dynamic Date"
  #   type: string
  #   sql:
  #   CASE
  #   WHEN date_diff(CAST({% date_end created_date %} as DATE), CAST({% date_start created_date %} as DATE), DAY) < 30 THEN ${created_date}
  #   WHEN date_diff(CAST({% date_end created_date %} as DATE), CAST({% date_start created_date %} as DATE), DAY) > 365 THEN ${created_year}
  #   WHEN date_diff(CAST({% date_end created_date %} as DATE), CAST({% date_start created_date %} as DATE), DAY) > 90 THEN ${created_month}
  #   WHEN date_diff(CAST({% date_end created_date %} as DATE), CAST({% date_start created_date %} as DATE), DAY) > 30 THEN ${created_week}
  #   ELSE ${created_month}
  #   END ;;
  # }

  parameter: timeframe_selector {
    type: unquoted
    default_value: "week"
    allowed_value: {
      label: "Day"
      value: "date"
    }
    allowed_value: {
      label: "Week"
      value: "week"
    }
    allowed_value: {
      label: "Month"
      value: "month"
    }
    allowed_value: {
      label: "Year"
      value: "year"
    }
  }

  dimension: dynamic_timeframe {
    label_from_parameter: timeframe_selector
    sql:
    {% if timeframe_selector._parameter_value == "date" %} ${created_date}
    {% elsif timeframe_selector._parameter_value == "month" %} ${created_month}
    {% elsif timeframe_selector._parameter_value == "year" %} ${created_year}
    {% else %} ${created_week}
    {% endif %}
    ;;
    html: {% if timeframe_selector._parameter_value == "date" %} {{ value | date: "%a, %b %e '%y" }}
          {% elsif timeframe_selector._parameter_value == "month" %} {{ value | date: "%a, %b %e '%y" }}
          {% elsif timeframe_selector._parameter_value == "year" %} {{ value }}
          {% else %} {{ value | date: "%a, %b %e '%y" }}
          {% endif %} ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.delivered_at ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Inventory Item ID" in Explore.

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: product_id {
    type: number
    #hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;
  }

  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;
    value_format_name: decimal_2
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: hor_menu {
    type: count
    html:
       <div style=" display: flex; justify-content: space-around;">
       <img src="https://mms.businesswire.com/media/20220518005288/en/1457777/5/Logo_HZ_RGB.jpg" width="130" height="30" border="0" />
      </div>
       <ul style="
        float:left;
        list-style:none;
        line-height:36px;
        text-align:center;
        background:#F2F2F2;
        font-family:Google Sans, Noto Sans, Noto Sans JP, Noto Sans CJK KR, Noto Sans Arabic UI, Noto Sans Devanagari UI, Noto Sans Hebrew, Noto Sans Thai UI, Helvetica, Arial, sans-serif;
        font-size:14px">

      <li style="float:left;
      border-right:2px solid #fff;
      border-top:2px solid #fff;">
      <a href=""
      style="display:block;
      padding:12px 28px;
      color:#1d252c;
      font-family: Lucida Console;
      background:#F2F2F2;
      text-decoration:none;
      border-radius: 8px;"
      >OKR's</a></li>

      <li style="float:left;
      border-right:2px solid #fff;
      border-top:2px solid #fff;">
      <a href=""
      style="display:block;
      padding:12px 28px;
      color:#1d252c;
      font-family: Lucida Console;
      background:#F2F2F2;
      text-decoration:none;
      border-radius: 8px;"
      >CRR</a></li>

      <li style="float:left;
      border-right:2px solid #fff;
      border-top:2px solid #fff;">
      <a href=""
      style="display:block;
      padding:12px 28px;
      color:#1d252c;
      font-family: Lucida Console;
      background:#F2F2F2;
      text-decoration:none;
      border-radius: 8px;">Status</a></li>

      <li style="float:left;
      border-right:2px solid #fff;
      border-top:2px solid #fff;">
      <a href=""
      style="display:block;
      padding:12px 28px;
      color:#1d252c;
      font-family: Lucida Console;
      background:#1ce783;
      text-decoration:none;
      border-radius: 8px;"
      >Data Product</a></li>

      <li style="float:left;
      border-right:2px solid #fff;
      border-top:2px solid #fff;">
      <a href=""
      style="display:block;
      padding:12px 28px;
      color:#1d252c;
      font-family: Lucida Console;
      background:#F2F2F2;
      text-decoration:none;
      border-radius: 8px;"
      >Data Search</a></li>

      <li style="float:left;
      border-right:2px solid #fff;
      border-top:2px solid #fff;">
      <a href=""
      style="display:block;
      padding:12px 28px;
      color:#1d252c;
      font-family: Lucida Console;
      background:#F2F2F2;
      text-decoration:none;
      border-radius: 8px;"
      >Data Access</a></li>

      <li style="float:left;
      border-right:2px solid #fff;
      border-top:2px solid #fff;
      "><a href=""
      style="display:block;
      padding:12px 28px;
      color:#1d252c;
      font-family: Lucida Console;
      background:#F2F2F2;
      text-decoration:none;
      border-radius: 8px;"
      >Data Cost</a></li>

      <li style="float:left;
      border-right:2px solid #fff;
      border-top:2px solid #fff;">
      <a href=""
      style="display:block;
      padding:12px 28px;
      color:#1d252c;
      font-family: Lucida Console;
      background:#F2F2F2;
      text-decoration:none;
      border-radius: 8px;"
      >Engage</a></li>

      <li style="float:left;
      border-right:2px solid #fff;
      border-top:2px solid #fff;
      "><a href=""
      style="display:block;
      padding:12px 28px;
      color:#1d252c;
      font-family: Lucida Console;
      background:#F2F2F2;
      text-decoration:none;
      border-radius: 8px;"
      >TRANSFER MARKET</a></li>

      <li style="float:left;
      border-right:2px solid #fff;
      border-top:2px solid #fff;
      "><a href=""
      style="display:block;
      padding:12px 28px;
      color:#1d252c;
      font-family: Lucida Console;
      background:#F2F2F2;
      text-decoration:none;
      border-radius: 8px;"
      >TRADE</a></li>

      </ul>

      ;;
  }

  measure: menu {
    type: count
    # sql: 1;;
    html:
      <img src="https://mms.businesswire.com/media/20220518005288/en/1457777/5/Logo_HZ_RGB.jpg" width="130" height="30" border="0" display="block" margin-left="auto" margin-right="auto"/>

                  <ul style="margin:0;
                  padding:0;
                  list-style:none;
                  line-height:36px;
                  text-align:left;
                  font-family:Google Sans, Noto Sans, Noto Sans JP, Noto Sans CJK KR, Noto Sans Arabic UI, Noto Sans Devanagari UI, Noto Sans Hebrew, Noto Sans Thai UI, Helvetica, Arial, sans-serif;
                  font-size:15px">

      <li style="
      border-right:2px solid #fff;
      border-top:2px solid #fff;">
      <a href=""
      style="display:block;
      padding:0 28px;
      color:#1d252c;
      text-align:left;
      font-family: Lucida Console;       text-decoration:none;" >
      <img src="https://cdn-icons-gif.flaticon.com/7211/7211809.gif" width="30" height="30" border="0" display="block" margin-left="auto" margin-right="auto">
      OKR's
      </a></li>

      <li style="
      border-right:2px solid #fff;
      border-top:2px solid #fff;">
      <a href="
      style="display:block;
      padding:0 28px;
      color:#1d252c;
      font-family: Lucida Console;       text-decoration:none;">
      <img src="https://cdn-icons-gif.flaticon.com/6172/6172532.gif" width="30" height="30" border="0" display="block" margin-left="auto" margin-right="auto">
      CRR</a></li>

      <li style="
      border-right:2px solid #fff;
      border-top:2px solid #fff;">
      <a href=""
      style="display:block;
      padding:0 28px;
      color:#1d252c;
      font-family: Lucida Console;       text-decoration:none;">
      <img src="https://cdn-icons-gif.flaticon.com/7211/7211797.gif" width="30" height="30" border="0" display="block" margin-left="auto" margin-right="auto">
      Status</a></li>

      <a href=""
      style="display:block;
      padding:0 28px;
      color:#1d252c;
      text-align:left;
      font-family: Lucida Console;
      border-right: 3px solid #10c877;
      text-decoration:none;
      color: #10c877">
      <img src="https://cdn-icons-gif.flaticon.com/7211/7211792.gif" width="30" height="30" border="0" display="block" margin-left="auto" margin-right="auto">
      Data Product
      </a>
      <ul style="line-height: 2px;list-style-type:none;">
      <li>
      <a href=""
      style="font-family: Lucida Console; color:#1d252c;">&emsp;
      <img src="https://cdn-icons-gif.flaticon.com/8112/8112922.gif" width="30" height="30" border="0" display="block" margin-left="auto" margin-right="auto">
      Look</a></li>
      <li>
      <a href=""
      style="font-family: Lucida Console; color:#1d252c;"> &emsp;
      <img src="https://cdn-icons-gif.flaticon.com/7211/7211837.gif" width="30" height="30" border="0" display="block" margin-left="auto" margin-right="auto">
      Explore</a></li>
      <li>
      <a href=""
      style="font-family: Lucida Console; color:#1d252c;"> &emsp;
      <img src="https://cdn-icons-gif.flaticon.com/7211/7211834.gif" width="30" height="30" border="0" display="block" margin-left="auto" margin-right="auto">
      Dashboard</a></li>
      </ul>

      <li style="
      border-right:2px solid #fff;
      border-top:2px solid #fff;"><a href=""
      style="display:block;
      padding:0 28px;
      color:#1d252c;
      font-family: Lucida Console;       text-decoration:none;">
      <img src="https://cdn-icons-gif.flaticon.com/8112/8112604.gif" width="30" height="30" border="0" display="block" margin-left="auto" margin-right="auto">
      Data Search</a></li>

      <li style="
      border-right:2px solid #fff;
      border-top:2px solid #fff;"><a href=" "
      style="display:block;
      padding:0 28px;
      color:#1d252c;
      font-family: Lucida Console;       text-decoration:none;">
      <img src="https://cdn-icons-gif.flaticon.com/6569/6569125.gif" width="30" height="30" border="0" display="block" margin-left="auto" margin-right="auto">
      Data Access</a></li>

      <li style="
      border-right:2px solid #fff;
      border-top:2px solid #fff;
      "><a href=""
      style="display:block;
      padding:0 28px;
      color:#1d252c;
      font-family: Lucida Console;       text-decoration:none;">
      <img src="https://cdn-icons-gif.flaticon.com/6172/6172509.gif" width="30" height="30" border="0" display="block" margin-left="auto" margin-right="auto">
      Data Cost</a></li>

      <li style="
      border-right:2px solid #fff;
      border-top:2px solid #fff;
      "><a href=""
      style="display:block;
      padding:0 28px;
      color:#1d252c;
      font-family: Lucida Console;       text-decoration:none;">
      <img src="https://cdn-icons-gif.flaticon.com/7211/7211817.gif" width="30" height="30" border="0" display="block" margin-left="auto" margin-right="auto">
      Engage</a></li>
      </ul>
      ;;
  }

  #     <ul style="font-size: 14px; padding: 2px 1px 2px 3px;">
  #     <li> <a style='border-radius: 5px; padding: 5px 1px 2px 3px; margin-bottom: 10px; font-weight: bold;' href="#">Home</a>
  #     </li><li>
  #     <a style='border-radius: 5px; padding: 5px 10px; margin-bottom: 10px;' href="#">Business Pulse</a>
  #     </li><li>
  #     <a style='border-radius: 5px; padding: 5px 10px; margin-bottom: 10px;' href="#">Demographics</a>
  #     </li><li>
  #     <a style='border-radius: 5px; padding: 5px 10px; margin-bottom: 10px;' href="#">Web Analytics</a>
  #     </li></ul>
  #     ;;
  # }

  measure: menu_new {
    type: count
    # sql: 1;;
    html:
    <ul style="margin:0;
              padding:0;
              list-style:none;
              line-height:36px;
              text-align:left;
              font-size:15px;
              font-family:Open Sans;">

      <li style="
      border-right:2px solid #fff;
      border-top:2px solid #fff;">
      <a href=""
      style="display:block;
      padding:0;
      color:#1d252c;
      text-align:left;" >
      OKR's
      </a></li>

      <a href=""
      style="display:block;
      color:#1d252c;
      text-align:left;
      color: #10c877">
      CRR
      </a>
      <ul style="line-height: 30px;list-style-type:none;">
      <li style="line-height:30px;border-left: 3px solid #10c877;">
      <a href=""
      style=" color:#1d252c;line-height:30px;">&emsp;
      Summary</a></li>
      <li style="line-height:30px;border-left: 3px solid #10c877;">
      <a href=""
      style=" color:#1d252c;line-height:30px;"> &emsp;
      Explore</a></li>
      <li>
      </ul>

      <a href=""
      style="display:block;
      padding:0;
      color:#1d252c;
      text-align:left;
      color: #10c877">
      GTMSO
      </a>
      <ul style="line-height: 30px;list-style-type:none;">
      <li>
      <a href=""
      style=" color:#1d252c;line-height:30px;border-left: 3px solid #10c877;">&emsp;
      Consumption Summary</a></li>
      </ul>

      <li style="
      border-right:2px solid #fff;
      border-top:2px solid #fff;
      "><a href=""
      style="display:block;
      color:#1d252c;">
      Feedback</a></li>

      <li style="
      border-right:2px solid #fff;
      border-top:2px solid #fff;
      "><a href=""
      style="display:block;
      color:#1d252c;">
      Release Notes</a></li>
      </ul>
      ;;
  }

  measure: countt {
    type: count
    # drill_fields: [friendly_name]
    html:  <div style='background-color: #ffffdd; padding: 5px 10px; border: solid 1px #ededed; border-radius: 15px;'>{{value}}</div>;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.last_name,
      users.id,
      users.first_name,
      inventory_items.id,
      inventory_items.product_name,
      products.name,
      products.id
    ]
  }
  ################################################################################################################
  measure: custom_crr{
    group_label: "HTML Measures"
    label: "CRR Overview"
    type: count
    html: <html>
          <span align="Left">
          <p style= "margin:0;padding:0;border:none;line-height:60%"><font line-height="60%" size="4"> dim_metric.hero_metric_category <img src="https://www.freeiconspng.com/uploads/info-icon-27.png" width="20" height="20" style= "margin-bottom:4px" title="metric_description"/></font></p>
          </span>
          <table cellspacing="80" style="width:100%">
          <tbody>
          <tr>
          <td style="background-color:#e7eff3;width:33%;border-right:1px solid transparent;border-radius:10%">
          <div style="margin-right: 4px">
          <span>
          <p style= "margin:0;padding:0;border:none;line-height:0%"><font line-height="0%" size="1"><br><b> Estimated Credited Consumption&nbsp&nbsp</b></font></p>
          <h3 style= "margin-right:2px"><b><font size="5">$897.6M <br> </font></b></h3>
          </span>
          <span>
          <h1> <font size="2">
          <font color="#000000">(4/01/2022 - 31/03/2023)&nbsp</font></p></b>
          </br>
          </font></h1></span>
          </div></td>
          <td style="background-color:transparent;width:33%;border-right:1px solid transparent;border-radius:10%">
          <div style="margin-right: 4px">
          <span>
          <p style= "margin:0;padding:0;border:none;line-height:0%"><font line-height="0%" size="1"><br><b> Quota for Period&nbsp&nbsp</b></font></p>
          <h3 style= "margin-right:2px"><b><font size="5">$974.02M</b></h3>
          </span>
          <span>
          <h1> <font size="2">
          {% if sum_daily_yoy._value > 0 %}
          <b><p style="color: #00B050">▲ {{ sum_daily_yoy._rendered_value }}
          <font color="#000000"> YOY&nbsp</font></p></b>
          {% else %}
          <b><p style="color: #C00000">▼ {{ sum_daily_yoy._rendered_value }}
          <font color="#000000"> YOY&nbsp</font></p></b>
          {% endif %}</br>
          </font></h1></span>
          </div></td>
          <td style="background-color:#f6f7f8;width:33%;border-right:1px solid transparent;border-radius:10%">
          <div style="margin-right: 4px">
          <span>
          <p style= "margin:0;padding:0;border:none;line-height:0%"><font line-height="0%" size="1"><b> Count Between&nbsp&nbsp<br>
          ( {{ start_date._rendered_value }} - {{ end_date._rendered_value }} )&nbsp </b></font></p>





          <h3 style= "margin-right:2px"><b><font size="5">{{ sum_date_range._rendered_value }}</b></h3>
          </span>
          <span>
          <h1> <font size="2">
          {% if sum_date_range_yoy._value > 0 %}
          <b><p style="color: #00B050">▲ {{ sum_date_range_yoy._rendered_value }}
          <font color="#000000"> YOY&nbsp</font></p></b>
          {% else %}
          <b><p style="color: #C00000">▼ {{ sum_date_range_yoy._rendered_value }}
          <font color="#000000"> YOY&nbsp</font></p></b>
          {% endif %}</br>
          </font></h1></span>
          </div></td>
          <tr>
          </tbody>
          </table>
          </html>
      ;;
  }

}
