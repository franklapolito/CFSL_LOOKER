view: connected_fitness_subscription_lifecycle {
    label: "connected_fitness_subscription_lifecycle"
    sql_table_name: "connected_fitness_subscription_lifecycle_catalog_main"."connected_fitness_subscription_lifecycle";;
    dimension: Channel {
        label: " Channel"
        group_label: "Channel.Channel"
        type: string
        sql: ${TABLE}."Channel";;
    }

    dimension: Channel_Channel_Type {
        label: "  Channel Type"
        group_label: "Channel.Channel"
        type: string
        sql: ${TABLE}."Channel Type";;
        drill_fields: [Channel]
    }

    dimension: Calendar_Date_Day {
        label: " Day"
        group_label: "Date.Calendar Date"
        type: date
        sql: ${TABLE}."Day";;
    }

    dimension: Calendar_Date_Month {
        label: "  Month"
        group_label: "Date.Calendar Date"
        type: string
        sql: ${TABLE}."Month";;
        drill_fields: [Calendar_Date_Day]
    }

    dimension: Calendar_Date_Quarter {
        label: "   Quarter"
        group_label: "Date.Calendar Date"
        type: number
        sql: ${TABLE}."Quarter";;
        drill_fields: [Calendar_Date_Month]
    }

    dimension: Calendar_Date_Year {
        label: "    Year"
        group_label: "Date.Calendar Date"
        type: number
        sql: ${TABLE}."Year";;
        drill_fields: [Calendar_Date_Quarter]
    }

    dimension: Fiscal_Date_Day {
        label: " Day"
        group_label: "Date.Fiscal Date"
        type: date
        sql: ${TABLE}."Day";;
    }

    dimension: Fiscal_Date_Fiscal_Quarter {
        label: "   Fiscal Quarter"
        group_label: "Date.Fiscal Date"
        type: number
        sql: ${TABLE}."Fiscal Quarter";;
        drill_fields: [Fiscal_Date_Month]
    }

    dimension: Fiscal_Date_Fiscal_Year {
        label: "    Fiscal Year"
        group_label: "Date.Fiscal Date"
        type: string
        sql: ${TABLE}."Fiscal Year";;
        drill_fields: [Fiscal_Date_Fiscal_Quarter]
    }

    dimension: Fiscal_Date_Month {
        label: "  Month"
        group_label: "Date.Fiscal Date"
        type: string
        sql: ${TABLE}."Month";;
        drill_fields: [Fiscal_Date_Day]
    }

    dimension: Geography_Country {
        label: " Country"
        group_label: "Geography.Geography"
        type: string
        sql: ${TABLE}."Country";;
    }

    dimension: Geography_Region {
        label: "  Region"
        group_label: "Geography.Geography"
        type: string
        sql: ${TABLE}."Region";;
        drill_fields: [Geography_Country]
    }

    dimension: Household_Size {
        label: "Household Size"
        group_label: "Member"
        type: number
        sql: ${TABLE}."Household Size";;
    }

    dimension: Member {
        label: " Member"
        group_label: "Member.Member"
        type: string
        sql: ${TABLE}."Member";;
    }

    dimension: Member_Member_Segment {
        label: "  Member Segment"
        group_label: "Member.Member"
        type: string
        sql: ${TABLE}."Member Segment";;
        drill_fields: [Member]
    }

    dimension: Billing_Period {
        label: "Billing Period"
        group_label: "Plan"
        type: string
        sql: ${TABLE}."Billing Period";;
    }

    dimension: Plan {
        label: " Plan"
        group_label: "Plan.Plan"
        type: string
        sql: ${TABLE}."Plan";;
    }

    dimension: Plan_Plan_Family {
        label: "  Plan Family"
        group_label: "Plan.Plan"
        type: string
        sql: ${TABLE}."Plan Family";;
        drill_fields: [Plan]
    }

    dimension: Product_Product_Category {
        label: "   Product Category"
        group_label: "Product.Product"
        type: string
        sql: ${TABLE}."Product Category";;
        drill_fields: [Product_Product_Line]
    }

    dimension: Product_Product_Line {
        label: "  Product Line"
        group_label: "Product.Product"
        type: string
        sql: ${TABLE}."Product Line";;
        drill_fields: [Product_Product_Name]
    }

    dimension: Product_Product_Name {
        label: " Product Name"
        group_label: "Product.Product"
        type: string
        sql: ${TABLE}."Product Name";;
    }

    dimension: Subscription_Current_Status {
        label: "  Current Status"
        group_label: "Subscription.Subscription"
        type: string
        sql: ${TABLE}."Current Status";;
        drill_fields: [Subscription]
    }

    dimension: Subscription {
        label: " Subscription"
        group_label: "Subscription.Subscription"
        type: number
        sql: ${TABLE}."Subscription";;
    }

    measure: Connected_Fitness_Gross_Monthly_Churn {
        label: "Connected Fitness Gross Monthly Churn"
        group_label: "Churn Analytics"
        description: "SUPERSEDED convention (pre-2025). Gross monthly churn for the CONNECTED FITNESS (Equipment) family only: Cancellations / Paid Subscriptions. No netting of reactivations — a returning member counts as a new subscription, not a reversal. Scope is baked in — plan family is pinned to Equipment, so slicing by Plan Family cannot change the number. The denominator is the visible Paid Subscriptions measure. This was the certified definition of the Connected Fitness churn KPI before the FY2025 restatement (2025-01-01), retained as a distinct named metric for restatement and period-over-period comparison. Still defensible as the conservative attrition view; NOT the current certified KPI."
        value_format: "#,##0.00%"
        type: average
        sql: ${TABLE}."Connected Fitness Gross Monthly Churn";;
    }

    measure: Connected_Fitness_Monthly_Paid_Churn {
        label: "Connected Fitness Monthly Paid Churn"
        group_label: "Churn Analytics"
        description: "CERTIFIED · current definition, effective FY2025 (from 2025-01-01). Net monthly paid churn for the CONNECTED FITNESS (Equipment) family only: (Cancellations − Reactivations) / Paid Subscriptions. Reactivations (win-backs) are netted off: a member who leaves and returns within the window never really left the base. Scope is baked in — plan family is pinned to Equipment, so slicing by Plan Family cannot change the number; this is the 10-K Connected-Fitness churn, not the blended all-plan figure. The denominator is the visible Paid Subscriptions measure (no hidden base). THE certified metric for external churn reporting. Superseded the gross convention on 2025-01-01 (FY2025 restatement; prior periods restated). The prior gross definition is retained as ''Connected Fitness Gross Monthly Churn''. See git history / PR for the change record and approval."
        value_format: "#,##0.00%"
        type: average
        sql: ${TABLE}."Connected Fitness Monthly Paid Churn";;
    }

    measure: Connected_Fitness_Pause_Inclusive_Churn {
        label: "Connected Fitness Pause-Inclusive Churn"
        group_label: "Churn Analytics"
        description: "AVAILABLE · NOT certified for external reporting. Cash / billing view of churn for the CONNECTED FITNESS (Equipment) family only: (Cancellations + Pauses − Reactivations − Resumes) / Paid Subscriptions. Treats a pause as a churn event (billing stopped) and a resume as a win-back. Scope is baked in — plan family is pinned to Equipment, so slicing by Plan Family cannot change the number. The denominator is the visible Paid Subscriptions measure. Diverges from the paid-churn definitions seasonally — highest in summer when pauses spike, and can fall below the certified ''Connected Fitness Monthly Paid Churn'' in January when resumes spike. Use for revenue/cash analysis, not the reported churn KPI."
        value_format: "#,##0.00%"
        type: average
        sql: ${TABLE}."Connected Fitness Pause-Inclusive Churn";;
    }

    measure: Average_Net_Revenue_per_Order {
        label: "Average Net Revenue per Order"
        group_label: "Hardware Orders"
        description: "Net hardware revenue divided by order count."
        value_format: "$#,##0.00"
        type: average
        sql: ${TABLE}."Average Net Revenue per Order";;
    }

    measure: Discount_Amount {
        label: "Discount Amount"
        group_label: "Hardware Orders"
        value_format: "$#,##0.00"
        type: sum
        sql: ${TABLE}."Discount Amount";;
    }

    measure: Discount_Rate {
        label: "Discount Rate"
        group_label: "Hardware Orders"
        description: "Discount as a share of gross hardware revenue."
        value_format: "0.00%"
        type: average
        sql: ${TABLE}."Discount Rate";;
    }

    measure: Gross_Revenue {
        label: "Gross Revenue"
        group_label: "Hardware Orders"
        value_format: "$#,##0.00"
        type: sum
        sql: ${TABLE}."Gross Revenue";;
    }

    measure: Net_Revenue {
        label: "Net Revenue"
        group_label: "Hardware Orders"
        value_format: "$#,##0.00"
        type: sum
        sql: ${TABLE}."Net Revenue";;
    }

    measure: Order_Count {
        label: "Order Count"
        group_label: "Hardware Orders"
        type: sum
        sql: ${TABLE}."Order Count";;
    }

    measure: Return_Rate {
        label: "Return Rate"
        group_label: "Hardware Orders"
        description: "Returned amount as a share of gross hardware revenue."
        value_format: "0.00%"
        type: average
        sql: ${TABLE}."Return Rate";;
    }

    measure: Returned_Amount {
        label: "Returned Amount"
        group_label: "Hardware Orders"
        value_format: "$#,##0.00"
        type: sum
        sql: ${TABLE}."Returned Amount";;
    }

    measure: Units_Sold {
        label: "Units Sold"
        group_label: "Hardware Orders"
        type: sum
        sql: ${TABLE}."Units Sold";;
    }

    measure: Cancellations {
        label: "Cancellations"
        group_label: "Lifecycle Events"
        description: "Count of Cancel events (route 1 / gross)."
        type: sum
        sql: ${TABLE}."Cancellations";;
    }

    measure: Net_MRR_Movement {
        label: "Net MRR Movement"
        group_label: "Lifecycle Events"
        value_format: "$#,##0.00"
        type: sum
        sql: ${TABLE}."Net MRR Movement";;
    }

    measure: Pauses {
        label: "Pauses"
        group_label: "Lifecycle Events"
        type: sum
        sql: ${TABLE}."Pauses";;
    }

    measure: Reactivations {
        label: "Reactivations"
        group_label: "Lifecycle Events"
        type: sum
        sql: ${TABLE}."Reactivations";;
    }

    measure: Resumes {
        label: "Resumes"
        group_label: "Lifecycle Events"
        type: sum
        sql: ${TABLE}."Resumes";;
    }

    measure: Starts {
        label: "Starts"
        group_label: "Lifecycle Events"
        type: sum
        sql: ${TABLE}."Starts";;
    }

    measure: Subscription_Events {
        label: "Subscription Events"
        group_label: "Lifecycle Events"
        type: sum
        sql: ${TABLE}."Subscription Events";;
    }

    measure: Average_Revenue_per_Paid_Subscription {
        label: "Average Revenue per Paid Subscription"
        group_label: "Subscription Base"
        description: "MRR divided by ending paid subscriptions (ARPU)."
        value_format: "$#,##0.00"
        type: average
        sql: ${TABLE}."Average Revenue per Paid Subscription";;
    }

    measure: MRR {
        label: "MRR"
        group_label: "Subscription Base"
        value_format: "$#,##0.00"
        type: average
        sql: ${TABLE}."MRR";;
    }

    measure: Paid_Subscriptions {
        label: "Paid Subscriptions"
        group_label: "Subscription Base"
        description: "Ending paid subscriptions (semi-additive; last non-empty over snapshot date)."
        type: count_distinct
        sql: ${TABLE}."Paid Subscriptions";;
    }

    measure: Paused_Subscriptions {
        label: "Paused Subscriptions"
        group_label: "Subscription Base"
        type: count_distinct
        sql: ${TABLE}."Paused Subscriptions";;
    }

    measure: Churned_Subscriptions__Ops_ {
        label: "Churned Subscriptions (Ops)"
        group_label: "Subscription Flows"
        description: "Operations 'billing stopped' churn = cancels + pauses (route 2)."
        type: sum
        sql: ${TABLE}."Churned Subscriptions (Ops)";;
    }

    measure: Net_New_Subscriptions {
        label: "Net New Subscriptions"
        group_label: "Subscription Flows"
        type: sum
        sql: ${TABLE}."Net New Subscriptions";;
    }

    measure: New_Subscriptions {
        label: "New Subscriptions"
        group_label: "Subscription Flows"
        type: sum
        sql: ${TABLE}."New Subscriptions";;
    }

}
