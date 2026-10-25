# verify_ratios.R
# Goal: recompute every ratio shown in the study directly from figures_and_sources.csv,
# so the numbers on the page can be checked independently. Base R only.
# Run from the folder that contains figures_and_sources.csv.

fig <- read.csv("figures_and_sources.csv", stringsAsFactors = FALSE)

# Return one reported figure (USD bn); stop if it is missing or ambiguous
get <- function(co, per, met) {
  v <- fig$value_usd_bn[fig$company == co & fig$period == per & fig$metric == met]
  stopifnot(length(v) == 1)
  v
}

# Capex as a share of operating cash flow
row <- function(company, window, ocf, capex) {
  data.frame(company = company, window = window,
             ocf = round(ocf, 1), capex = round(capex, 1),
             fcf = round(ocf - capex, 1),
             capex_pct_of_ocf = round(100 * capex / ocf, 1))
}

# ---- Same quarter: April to June 2026 (Microsoft: fiscal Q4) ----
snap <- rbind(
  row("Alphabet",  "Q2 2026", get("Alphabet", "Q2 2026", "operating_cash_flow"),
                              get("Alphabet", "Q2 2026", "capex_purchases_of_property_and_equipment")),
  row("Amazon",    "Q2 2026", get("Amazon", "Q2 2026", "operating_cash_flow"),
                              get("Amazon", "Q2 2026", "purchases_of_property_and_equipment") -
                              get("Amazon", "Q2 2026", "proceeds_from_property_and_equipment_sales_and_incentives")),
  row("Meta",      "Q2 2026", get("Meta", "Q2 2026", "operating_cash_flow"),
                              get("Meta", "Q2 2026", "purchases_of_property_and_equipment") +
                              get("Meta", "Q2 2026", "principal_payments_on_finance_leases")),
  row("Microsoft", "Q4 fiscal 2026",
                              get("Microsoft", "Q4 fiscal 2026 (Apr-Jun 2026)", "operating_cash_flow"),
                              get("Microsoft", "Q4 fiscal 2026 (Apr-Jun 2026)", "additions_to_property_and_equipment"))
)
cat("\nSame quarter, April to June 2026\n"); print(snap, row.names = FALSE)

# ---- Meta, July to September 2026 ----
meta_q3 <- row("Meta", "Q3 2026", get("Meta", "Q3 2026", "operating_cash_flow"),
                                  get("Meta", "Q3 2026", "purchases_of_property_and_equipment") +
                                  get("Meta", "Q3 2026", "principal_payments_on_finance_leases"))
cat("\nMeta, July to September 2026\n"); print(meta_q3, row.names = FALSE)

# ---- Twelve months to June 2026 ----
meta_ocf <- get("Meta", "Q3 2025", "operating_cash_flow") + get("Meta", "Q4 2025", "operating_cash_flow") +
            get("Meta", "Q1 2026", "operating_cash_flow") + get("Meta", "Q2 2026", "operating_cash_flow")
meta_capex <- get("Meta", "Q3 2025", "purchases_of_property_and_equipment") +
              get("Meta", "Q3 2025", "principal_payments_on_finance_leases") +
              get("Meta", "Q4 2025", "capex_incl_finance_lease_principal") +
              get("Meta", "Q1 2026", "capex_incl_finance_lease_principal") +
              get("Meta", "Q2 2026", "purchases_of_property_and_equipment") +
              get("Meta", "Q2 2026", "principal_payments_on_finance_leases")

ttm <- rbind(
  row("Alphabet",  "12 months to Jun 2026", get("Alphabet", "12 months to Jun 2026", "operating_cash_flow"),
                                            get("Alphabet", "12 months to Jun 2026", "capex_purchases_of_property_and_equipment")),
  row("Amazon",    "12 months to Jun 2026", get("Amazon", "12 months to Jun 2026", "operating_cash_flow"),
                                            get("Amazon", "12 months to Jun 2026", "purchases_of_property_and_equipment_net_of_proceeds")),
  row("Meta",      "12 months to Jun 2026", meta_ocf, meta_capex),
  row("Microsoft", "Fiscal 2026",           get("Microsoft", "Fiscal 2026 (Jul 2025-Jun 2026)", "operating_cash_flow"),
                                            get("Microsoft", "Fiscal 2026 (Jul 2025-Jun 2026)", "additions_to_property_and_equipment"))
)
cat("\nTwelve months to June 2026\n"); print(ttm, row.names = FALSE)

# ---- The year before ----
prior <- rbind(
  row("Alphabet",  "Q2 2025", get("Alphabet", "Q2 2025", "operating_cash_flow"),
                              get("Alphabet", "Q2 2025", "capex_purchases_of_property_and_equipment")),
  row("Amazon",    "Q2 2025", get("Amazon", "Q2 2025", "operating_cash_flow"),
                              get("Amazon", "Q2 2025", "purchases_of_property_and_equipment") -
                              get("Amazon", "Q2 2025", "proceeds_from_property_and_equipment_sales_and_incentives")),
  row("Meta",      "Q2 2025", get("Meta", "Q2 2025", "operating_cash_flow"),
                              get("Meta", "Q2 2025", "purchases_of_property_and_equipment") +
                              get("Meta", "Q2 2025", "principal_payments_on_finance_leases")),
  row("Microsoft", "Q4 fiscal 2025",
                              get("Microsoft", "Q4 fiscal 2025 (Apr-Jun 2025)", "operating_cash_flow"),
                              get("Microsoft", "Q4 fiscal 2025 (Apr-Jun 2025)", "additions_to_property_and_equipment"))
)
cat("\nSame quarter, April to June 2025\n"); print(prior, row.names = FALSE)
