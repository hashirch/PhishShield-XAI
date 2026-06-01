# PhishShield-XAI: Testing Examples & Scenarios

This document provides a variety of email examples for testing the PhishShield-XAI API. These range from legitimate communications to sophisticated adversarial attacks designed to bypass detection.

## 1. Legitimate Emails (Expected: "legitimate")

These examples represent standard professional and personal communications.

### Scenario A: Business Follow-up
```text
Hi Sarah, I wanted to follow up on the document I shared last week. Could you take a quick look and let me know if everything looks good? I'm happy to discuss any questions you might have. Best, Alex Rivera
```

### Scenario B: Meeting Request
```text
Good morning team, I'd like to schedule a quick sync for the Atlas project on Thursday at 2 PM. Please let me know if you are available or if we need to move it to Friday. Thanks, Priya Sharma.
```

### Scenario C: Newsletter / Informational
```text
Hello, this is the weekly engineering newsletter. This week we are covering the transition to the new CI/CD pipeline and the updated security guidelines. You can read the full report on the internal portal.
```

---

## 2. Classic Phishing Emails (Expected: "phishing")

These emails use traditional tactics: urgency, fear, and suspicious calls to action.

### Scenario A: Credential Harvesting
```text
URGENT: Your Microsoft 365 account has been suspended due to suspicious activity. To avoid permanent deletion of your data, you must verify your identity immediately by clicking the link below: http://microsoft-verify-secure-login.com/auth. Failure to act within 24 hours will result in account termination.
```

### Scenario B: Financial Fraud
```text
Dear Valued Customer, We noticed an unauthorized login attempt to your bank account from an unknown IP address in Russia. For your protection, we have temporarily blocked your online access. Please download the attached invoice and click the 'Secure My Account' button to restore access: http://bit.ly/secure-bank-login-992.
```

### Scenario C: Fake Invoice
```text
Your invoice for order #88291 is now available for payment. A total of $1,249.00 will be charged to your card on file unless you cancel within 12 hours. Review the invoice details here: http://tinyurl.com/invoice-pay-now.
```

---

## 3. Adversarial Attack Examples (Expected: "phishing" but may "evade")

These are "stealthy" phishing emails generated based on the project's attack simulation logic. They use polite language and professional contexts to lower the "threat score".

### Scenario A: The "Gentle" Phish
```text
Hi Michael, Hope your week is going well. I wanted to share the competitive analysis our team completed for the Meridian review. It's at https://workspace.company.com/shared/doc-55291. Some interesting insights in there. Let's chat when you've had a chance to review. Best, Emma Chen
```

### Scenario B: The Internal Tool Update
```text
Hi David, Just a heads up — we're updating our internal tools next week. Feel free to complete the setup at https://portal.internal-tools.net/review/10293 when you get a moment. Let me know if you need any help. Thanks, Marcus Johnson
```

---

## 4. API Testing Commands (CURL)

You can test these examples directly using the command line.

### Health Check
```bash
curl -X GET http://localhost:8000/health
```

### Single Prediction
```bash
curl -X POST http://localhost:8000/predict \
     -H "Content-Type: application/json" \
     -d '{"email_text": "URGENT: Verify your account immediately at http://suspicious-link.com"}'
```

### Batch Analysis (Testing Evasion)
```bash
curl -X POST http://localhost:8000/batch_analyze \
     -H "Content-Type: application/json" \
     -d '{
       "emails": [
         "Hi James, check this doc: https://workspace.com/doc-1",
         "URGENT: Bank account alert! Click here: http://phish.me"
       ]
     }'
```

---

## 5. Interpreting Results
- **Confidence Score**: How sure the model is (0.0 to 1.0).
- **SHAP Features**: Look for `urgency_word_count`, `url_count`, or `tfidf_...` to see what triggered the decision.
- **LIME Highlights**: Check the visual highlights in the web UI to see which specific words were flagged.
- **LLM Explanation**: Read the natural language summary for a human-readable justification.
