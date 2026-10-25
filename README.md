# Big Tech's AI bill has outgrown its cash flow

Capital expenditure (capex) versus operating cash flow at Alphabet, Amazon, Meta and Microsoft, and how each
company is filling the gap. Built only from each company's own earnings releases and annual report.

**Main finding:** in their latest quarters, Alphabet (Q2 2026: 115%), Amazon (Q2 2026: 117%) and Meta
(Q3 2026: 106%) spent more on capex than their operations generated in cash, and all three raised new debt or equity
in 2026. Microsoft's cash capex was 65% of operating cash flow in April to June 2026 and 63% over its fiscal year.

## Files

- `index.html`: the study (self-contained page, charts drawn in SVG, no external libraries)
- `figures_and_sources.csv`: every reported figure with its source link (88 rows)
- `verify_ratios.R`: recomputes every ratio on the page from the CSV (base R, no packages needed)

## How to check it

1. Open `figures_and_sources.csv` and follow the link of any figure to the original document.
2. Run `Rscript verify_ratios.R` from this folder. The output should match the tables on the page
   (the page rounds to whole percentages).

## How to update it

All numbers live in the `DATA` block at the top of the `<script>` in `index.html`. Ratios and twelve-month sums are
calculated in the page. To add a new quarter, add the reported values to the block and to the CSV.

## Limitations

- Capex is not the same as AI spending; it is an upper bound.
- Each company defines capex differently (see the notes in the page). Microsoft's cash additions exclude finance leases.
- Amazon's quarterly ratios swing widely, so its twelve-month view is the fairer comparison.
- Data as of 25 October 2026. Alphabet, Amazon and Microsoft had not yet reported their third quarter.
- Independent analysis from public documents. Not investment advice.
- Compiled and built with the assistance of Claude (Anthropic).
