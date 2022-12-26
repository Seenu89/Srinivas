view: rbac_view {
    derived_table: {
      sql:
        SELECT 1 AS row_no, 'Priyanka' AS User , "East" AS Region, 100 AS Clients, 1000000 AS Sales, 700000 AS Revenue, "Bob" AS Reporting_Manager, "Harry" AS Reporting_Manager_1 UNION ALL
        SELECT 2 AS row_no, 'Priyanka' AS User , "West" AS Region, 200 AS Clients, 2000000 AS Sales, 600000 AS Revenue, "Bob" AS Reporting_Manager, "Harry" AS Reporting_Manager_1 UNION ALL
        SELECT 3 AS row_no, 'Priyanka' AS User , "North" AS Region, 150 AS Clients, 1500000 AS Sales, 500000 AS Revenue, "Bob" AS Reporting_Manager, "Harry" AS Reporting_Manager_1 UNION ALL
        SELECT 4 AS row_no, 'Priyanka' AS User , "South" AS Region, 70 AS Clients, 190000 AS Sales, 400000 AS Revenue, "Bob" AS Reporting_Manager, "Harry" AS Reporting_Manager_1 UNION ALL
        SELECT 5 AS row_no, 'Priyanka' AS User , "Central" AS Region, 200 AS Clients, 130000 AS Sales, 300000 AS Revenue, "Bob" AS Reporting_Manager, "Harry" AS Reporting_Manager_1 UNION ALL

        SELECT 6 AS row_no, 'Shubham' AS User , "East" AS Region, 50 AS Clients, 100000 AS Sales, 750000 AS Revenue, "Priyanka" AS Reporting_Manager, "Bob" AS Reporting_Manager_1 UNION ALL
        SELECT 7 AS row_no, 'Shubham' AS User , "West" AS Region, 210 AS Clients, 200000 AS Sales, 650000 AS Revenue, "Priyanka" AS Reporting_Manager, "Bob" AS Reporting_Manager_1 UNION ALL
        SELECT 8 AS row_no, 'Shubham' AS User , "North" AS Region, 70 AS Clients, 150000 AS Sales, 540000 AS Revenue, "Priyanka" AS Reporting_Manager, "Bob" AS Reporting_Manager_1 UNION ALL
        SELECT 9 AS row_no, 'Shubham' AS User , "South" AS Region, 30 AS Clients, 19000 AS Sales, 340000 AS Revenue, "Priyanka" AS Reporting_Manager, "Bob" AS Reporting_Manager_1 UNION ALL

        SELECT 10 AS row_no, 'Aarti' AS User , "East" AS Region, 50 AS Clients, 50000 AS Sales, 750000 AS Revenue, "Shubham" AS Reporting_Manager, "Priyanka" AS Reporting_Manager_1 UNION ALL
        SELECT 11 AS row_no, 'Aarti' AS User , "West" AS Region, 210 AS Clients, 80000 AS Sales, 650000 AS Revenue, "Shubham" AS Reporting_Manager, "Priyanka" AS Reporting_Manager_1 UNION ALL

        SELECT 12 AS row_no, 'Pragati' AS User , "East" AS Region, 70 AS Clients, 60000 AS Sales, 540000 AS Revenue, "Shubham" AS Reporting_Manager, "Priyanka" AS Reporting_Manager_1 UNION ALL
        SELECT 13 AS row_no, 'Pragati' AS User , "West" AS Region, 30 AS Clients, 4000 AS Sales, 340000 AS Revenue, "Shubham" AS Reporting_Manager, "Priyanka" AS Reporting_Manager_1 UNION ALL

        SELECT 14 AS row_no, 'Anuja' AS User , "North" AS Region, 50 AS Clients, 50000 AS Sales, 750000 AS Revenue, "Shubham" AS Reporting_Manager, "Priyanka" AS Reporting_Manager_1 UNION ALL
        SELECT 15 AS row_no, 'Anuja' AS User , "South" AS Region, 210 AS Clients, 80000 AS Sales, 650000 AS Revenue, "Shubham" AS Reporting_Manager, "Priyanka" AS Reporting_Manager_1 UNION ALL

        SELECT 16 AS row_no, 'Shantanu' AS User , "North" AS Region, 70 AS Clients, 60000 AS Sales, 450000 AS Revenue, "Shubham" AS Reporting_Manager, "Priyanka" AS Reporting_Manager_1 UNION ALL
        SELECT 17 AS row_no, 'Shantanu' AS User , "South" AS Region, 30 AS Clients, 4000 AS Sales, 390000 AS Revenue, "Shubham" AS Reporting_Manager, "Priyanka" AS Reporting_Manager_1 UNION ALL

        SELECT 18 AS row_no, 'Srinivas' AS User , "West" AS Region, 50 AS Clients, 6000 AS Sales, 74000 AS Revenue, "Aarti" AS Reporting_Manager, "Priyanka" AS Reporting_Manager_1 UNION ALL

        SELECT 19 AS row_no, 'Changa' AS User , "South" AS Region, 40 AS Clients, 400 AS Sales, 33000 AS Revenue, "Anuja" AS Reporting_Manager, "Priyanka" AS Reporting_Manager_1
        ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: row_no {
      primary_key: yes
      type: number
      sql: ${TABLE}.row_no ;;
    }

    dimension: user {
      type: string
      sql: ${TABLE}.User ;;
    }

    dimension: region {
      type: string
      sql: ${TABLE}.Region ;;
    }

    measure: clients {
      type: sum
      sql: ${TABLE}.Clients ;;
    }

    measure: sales {
      type: sum
      sql: ${TABLE}.Sales ;;
    }

    measure: revenue {
      type: sum
      sql: ${TABLE}.Revenue ;;
    }

    dimension: reporting_manager {
      type: string
      sql: ${TABLE}.Reporting_Manager ;;
      link: {
        url: "https://tredencepartner.cloud.looker.com/dashboards/14?User={{ value }}"
        label: "ca"
      }
    }

  dimension: reporting_manager_1 {
    type: string
    sql: ${TABLE}.Reporting_Manager_1 ;;
  }

    set: detail {
      fields: [
        row_no,
        user,
        region,
        clients,
        sales,
        revenue,
        reporting_manager
      ]
    }
  }
