# Apex Donations App - Project Documentation

## Overview

This repository contains a donation management application built with Oracle APEX 24.x. The app provides donors with the ability to make donations, track their giving history, and receive receipts/tax documentation.

**Primary Purpose**: Enable secure online donations while providing transparency through donor visibility into contribution records.

---

## Tech Stack

- **Platform**: Oracle APEX 24.1+ (Enterprise Edition)
- **Database**: Oracle Database with PL/SQL
- **Frontend**: HTML5, CSS3, JavaScript (Vanilla + jQuery where needed)
- **Backend**: Apex SQL Functions, PL/SQL Procedures, REST API endpoints

---

## Page Structure & Features

### 1. Home (`P01`)
- Welcome message and donation call-to-action
- Quick stats: total donations received this month/year
- Recent donor activity feed (last 5 donors)
- Direct link to donate page

**Why**: Provides immediate context for visitors about the organization's impact.

### 2. Donate (`P02`)
- Donation amount selector ($10, $25, $50, custom amounts)
- Payment method selection (credit card via Stripe integration)
- Tax receipt checkbox with estimated tax deduction display
- Donor information form (name, email for receipts)

**Why**: Streamlines the donation flow while collecting necessary donor data.

### 3. My Contributions (`P04`)
- Personal dashboard showing all donations made by logged-in user
- Filterable list: date range, amount ranges, payment method
- Download PDF receipt functionality (via Apex REST API)
- Total contribution summary with year-over-year comparison

**Why**: Builds donor trust through transparency and provides tax documentation.

### 4. All Donors (`P05`)
- Public-facing page showing aggregate donation statistics
- Anonymized list of donors (last name only, no personal data exposed)
- Donation amount distribution chart
- Monthly contribution trends over the past year

**Why**: Demonstrates community engagement while protecting donor privacy.

### 5. Admin Dashboard (`P06`)
- Total donations received today/month/year
- Pending payment notifications count
- Recent transaction log with status (pending, completed, failed)
- Failed donation alerts requiring manual intervention

**Why**: Provides administrators visibility into financial operations and issues needing attention.

---

## Development & Testing Locally

### Prerequisites
1. Oracle Database 23c+ instance running locally or on cloud infrastructure
2. APEX environment configured with database credentials in `APEX_PUBLIC_USER` schema
3. Stripe API keys stored securely (recommended: use Apex Secrets Manager)

### Running the Application
```bash
# Navigate to apex_app_donations_repo directory
cd C:\Users\bruce\apex_app_donations_repo

# Start APEX instance via SQL Developer or similar tool connected to your DB
-- Connect as SYS with appropriate privileges, then run:
SQL> @start_apex.sh  # Custom startup script if provided

# Or manually connect and execute the initialization scripts in order:
@01_create_tables.sql
@02_install_packages.sql
@03_configure_rest_api.sql
```

### Testing Checklist
- [ ] Can create a new donation record via P02 form submission
- [ ] Payment processing flow completes successfully (Stripe webhook integration)
- [ ] Receipt PDF generation works for logged-in users on P04
- [ ] Donor anonymity enforced: no personal data visible in P05
- [ ] Admin alerts trigger when payment fails or requires manual review

---

## Security Considerations

### Payment Processing
1. **Stripe Integration**: All credit card processing handled via Stripe API — never store raw card numbers locally
2. **PCI Compliance**: Achieved through tokenization; no PCI scope for this application
3. **Webhook Verification**: Validate all webhook signatures before processing donations

### Data Protection
- Donor PII stored in encrypted columns (AES-256) within database tables
- Public pages display only anonymized data per privacy policy requirements
- Session management uses secure, HTTP-only cookies with sameSite=Strict

---

## Deployment Notes

### Production Configuration
1. Enable Apex REST API authentication for external integrations
2. Configure Stripe webhook endpoint URL in `APEX_PUBLIC_USER` settings page
3. Set up email notifications via SMTP (configured on P07)
4. Review and update privacy policy links to match actual data practices

---

## Key Files & Scripts

| File | Purpose |
|------|---------|
| `init/01_create_tables.sql` | Creates donation records, donors table with encryption columns |
| `init/02_install_packages.sql` | Installs Apex REST API packages and PL/SQL procedures |
| `src/pages/P02_donate.js` | Frontend logic for donation form validation and submission |
| `src/api/donations.rest` | OpenAPI spec for donation-related endpoints |

---

## Related Documentation

- [APEX 24.x Release Notes](https://docs.oracle.com/en/oracle/apex/)
- [Stripe API Reference](https://stripe.com/docs/api)
- Privacy Policy: `/privacy_policy.html` (linked from P01, P05)
