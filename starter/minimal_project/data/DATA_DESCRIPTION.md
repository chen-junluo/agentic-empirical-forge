# Data Description

## Dataset summary

| Item | Value |
|------|-------|
| Unit of analysis | firm-year |
| Time span | 2011-2017 |
| Frequency | annual |
| Geographic scope | U.S. publicly listed firms |
| Target sample | S&P 1500 firms, excluding financial firms |
| Final sample size | not finalized in starter |
| Main post-link firm identifier | `gvkey` |
| Main post-link time identifier | `fyear` |

---

## Data source A — Harte-Hanks Computer Intelligence

| Item | Value |
|------|-------|
| Provider | Harte-Hanks / research access workflow |
| Observation level | firm-period or firm-year style technology inventory records |
| Coverage | firm-level technology infrastructure and deployment information |
| Primary identifier(s) | vendor-specific company identifier, firm name |
| Join key(s) | matched firm entity to Compustat / BoardEx |
| Notes | exact public field names depend on actual extract; below is a reasonable starter-style field inventory |

### Variables

| Field name | Meaning | Unit / coding | Notes |
|-----------|---------|---------------|-------|
| `[hh_company_id]` | firm identifier in Harte-Hanks | vendor code | matching field |
| `[hh_firm_name]` | company name in source file | text | used in manual match review |
| `[hh_year]` | year of technology observation | year | should be aligned to `fyear` |
| `[hh_pc_count]` | installed PC count | count | workstation scale proxy |
| `[hh_server_count]` | installed server count | count | infrastructure scale proxy |
| `[hh_lan_flag]` | indicator that LAN / internal networking is installed | binary | exact coding to confirm |
| `[hh_database_flag]` | indicator that database systems are installed | binary | application layer proxy |
| `[hh_erp_flag]` | indicator that ERP systems are installed | binary | enterprise systems proxy |
| `[hh_cloud_flag]` | indicator that cloud-related systems are installed | binary | if available in extract |
| `[hh_it_staff_count]` | number of IT staff or IT function employees | count | if available in extract |
| `[hh_total_sites]` | number of business or technology sites | count | organizational technology footprint |
| `[hh_software_spend_proxy]` | software-related spending or intensity proxy | project-defined | placeholder starter field |
| `[hh_it_investment_proxy]` | broad IT investment or infrastructure intensity measure | project-defined | main explanatory variable candidate |

---

## Data source B — BoardEx

| Item | Value |
|------|-------|
| Provider | WRDS |
| Observation level | person-firm-role-date records |
| Coverage | executives, directors, biographies, board structure, professional background |
| Primary identifier(s) | `companyid`, person-level identifiers |
| Join key(s) | `companyid` linked to Compustat / CRSP via WRDS linkage |
| Notes | exact field names can vary by extract; below is a reasonable starter-style governance field list |

### Variables

| Field name | Meaning | Unit / coding | Notes |
|-----------|---------|---------------|-------|
| `companyid` | BoardEx firm identifier | identifier | main BoardEx firm key |
| `[personid]` | person identifier in BoardEx | identifier | executive / director key |
| `[role_name]` | title of current role | text | CEO / CFO / director classification |
| `[role_start_date]` | role start date | date | for firm-year alignment |
| `[role_end_date]` | role end date | date | for firm-year alignment |
| `[board_flag]` | whether person serves on board | binary | board composition |
| `[executive_flag]` | whether person is an executive | binary | top management composition |
| `[gender]` | person gender | categorical | diversity measure |
| `[age]` | person age | years | demographic attribute |
| `[tenure]` | role tenure | years | governance stability measure |
| `[independence_flag]` | whether director is independent | binary | board monitoring proxy |
| `[outside_directorships_count]` | number of outside board seats held | count | network / busyness measure |
| `[education_text]` | education background | text | may support derived elite education controls |
| `[functional_background_text]` | career or functional background | text | can be used to derive IT or finance experience |
| `[digital_or_it_experience_flag]` | indicator for digital / IT background | constructed | candidate heterogeneity variable |

---

## Data source C — Compustat North America Annual Fundamentals

| Item | Value |
|------|-------|
| Provider | WRDS |
| Observation level | firm-year |
| Coverage | accounting statements and firm characteristics |
| Primary identifier(s) | `gvkey`, `datadate`, `fyear` |
| Join key(s) | `gvkey`; CRSP linkage through CCM when needed |
| Notes | baseline financial panel used after sample construction |

### Variables

| Field name | Meaning | Unit / coding | Notes |
|-----------|---------|---------------|-------|
| `gvkey` | Compustat firm identifier | identifier | main firm key |
| `datadate` | statement date | date | accounting record date |
| `fyear` | fiscal year | year | time index |
| `sic` | Standard Industrial Classification | code | industry controls and filters |
| `at` | total assets | million USD | firm size |
| `sale` | net sales / revenue | million USD | operating scale |
| `emp` | number of employees | count | organization size |
| `ppegt` | gross property, plant, and equipment | million USD | capital intensity |
| `xrd` | research and development expense | million USD | innovation control |
| `ceq` | common equity | million USD | equity measure |
| `csho` | common shares outstanding | millions of shares | market value component |
| `prcc_f` | fiscal-year closing stock price | USD | market value component |

---

## Linkage

| Link step | Description |
|-----------|-------------|
| A → B | Harte-Hanks firm entities are matched to BoardEx / Compustat firm entities through cleaned firm identifiers |
| B → C | BoardEx `companyid` is linked to Compustat / CRSP identifiers using WRDS linkage products |
| Final firm key | `gvkey` |
| Final time key | `fyear` |
| Main attrition risk | Harte-Hanks matching and BoardEx role collapsing |

---

## Derived fields already available

| Field name | Built from | Meaning | Notes |
|-----------|------------|---------|-------|
| `[market_value]` | `prcc_f` × `csho` | approximate equity market value | should be finalized in code |
| `[firm_age]` | listing / founding info + `fyear` | firm age proxy | construction rule needed |
| `[board_it_experience_proxy]` | BoardEx background fields | board-level IT / digital experience proxy | derived governance measure |
| `[it_capital_intensity_proxy]` | Harte-Hanks infrastructure fields | composite IT intensity measure | derived from source A |

---

## Missing but desired fields

| Field name | Why needed | Possible source |
|-----------|------------|-----------------|
| exact Harte-Hanks field names | replace placeholders with actual codebook fields | user extract / vendor codebook |
| S&P 1500 constituent history flag | finalize sample membership rule | WRDS-compatible constituent mapping |
| shock or uncertainty indicator | support stronger design extensions | external event or market data |

---

## Data quality notes

| Topic | Note |
|------|------|
| Missingness | `xrd` and some governance attributes may be missing for some firm-years |
| Outliers | accounting and infrastructure count variables may require winsorization |
| Definition changes | role titles and technology categories may vary across years |
| Merge risks | Harte-Hanks to Compustat linkage is the main sample-loss risk |
| Access restrictions | Harte-Hanks exact field documentation depends on actual access |
