
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.time.Year" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment</title>
<style>
    body {
        font-family: roboto, Arial, sans-serif;
        background-color: #f4f4f4;
        margin-top: 65px;
    }
    .payment-container {
        max-width: 400px;
        margin: auto;
        background: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    .payment-container h2 {
        text-align: center;
        margin-bottom: 15px;
        margin-top: 0;
    }
    .card-logos {
        text-align: left;
        margin-bottom: 20px;
    }
    .card-logos img {
        height: 40px;
        margin: 0 10px;
    }
    .form-group {
        margin-bottom: 15px;
    }
    .form-group label {
        display: block;
        font-weight: bold;
        margin-bottom: 5px;
    }
    .form-group input, .form-group select {
        width: 100%;
        padding: 8px;
        box-sizing: border-box;
    }
    .error {
        color: red;
        font-size: 13px;
        margin-top: 3px;
    }
    .checkout-btn {
        width: 100%;
        padding: 10px;
        background-color: #28a745;
        color: white;
        border: none;
        font-size: 16px;
        cursor: pointer;
        border-radius: 4px;
    }
    .checkout-btn:hover {
        background-color: #218838;
    }
</style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="payment-container">
    <h2>PAYMENT</h2>
    <div class="card-logos">
        <p style="margin-left: 7px;">Accepted cards</p>
        <img src="${pageContext.request.contextPath}/images/visa.png" alt="Visa" style="margin-left: 0px;">
        <img src="${pageContext.request.contextPath}/images/mastercard.png" alt="MasterCard">
        <img src="${pageContext.request.contextPath}/images/amex.png" alt="American Express">
    </div>
    <form onsubmit="return validateForm()" action="Order" method="post" novalidate>
        <div class="form-group">
            <label for="cardNumber">Credit Card Number</label>
            <input type="text" id="cardNumber" name="cardNumber" placeholder="Enter card number" maxlength="19" required>
            <div id="cardError" class="error"></div>
        </div>
        <div class="form-group">
            <label for="expMonth">Exp Month</label>
            <select id="expMonth" name="expMonth" required>
                <option value="">Choose Month...</option>
                <% 
                    for (int m = 1; m <= 12; m++) {
                        String month = (m < 10 ? "0" + m : "" + m);
                        out.println("<option value='" + month + "'>" + month + "</option>");
                    }
                %>
            </select>
            <div id="monthError" class="error"></div>
        </div>
        <div class="form-group">
            <label for="expYear">Exp Year</label>
            <select id="expYear" name="expYear" required>
                <option value="">Choose Year...</option>
                <%
                    int currentYear = Year.now().getValue();
                    for (int i = 0; i < 10; i++) {
                        out.println("<option value='" + (currentYear + i) + "'>" + (currentYear + i) + "</option>");
                    }
                %>
            </select>
            <div id="yearError" class="error"></div>
        </div>
        <div class="form-group">
            <label for="cvv">CVV</label>
            <input type="password" id="cvv" name="cvv" placeholder="Enter CVV" maxlength="3" required>
            <div id="cvvError" class="error"></div>
        </div>
        <input type="hidden" name="action" value="placeOrder">
        <button type="submit" class="checkout-btn">Proceed to Checkout</button>
    </form>
</div>

<script>
function formatCardNumber(e) {
    let value = e.target.value;
    value = value.replace(/\D/g, "");
    value = value.substring(0, 19);
    let formatted = value.replace(/(.{4})/g, "$1 ").trim();
    e.target.value = formatted;
}
document.getElementById("cardNumber").addEventListener("input", formatCardNumber);
document.getElementById("cvv").addEventListener("input", formatCardNumber);

function validateForm() {
    let valid = true;

    const card = document.getElementById("cardNumber").value.replace(/\s/g, "");
    const month = document.getElementById("expMonth").value;
    const year = document.getElementById("expYear").value;
    const cvv = document.getElementById("cvv").value;

    document.getElementById("cardError").textContent = "";
    document.getElementById("monthError").textContent = "";
    document.getElementById("yearError").textContent = "";
    document.getElementById("cvvError").textContent = "";

    if (!/^\d{13,19}$/.test(card)) {
        document.getElementById("cardError").textContent = "Card number must be 13 to 19 digits.";
        valid = false;
    }

    if (month == "") {
        document.getElementById("monthError").textContent = "Please select a month.";
        valid = false;
    }

    if (year == "") {
        document.getElementById("yearError").textContent = "Please select a year.";
        valid = false;
    }

    if (!/^\d{3}$/.test(cvv)) {
        document.getElementById("cvvError").textContent = "CVV must be exactly 3 digits.";
        valid = false;
    }

    return valid;
}
</script>
</body>
</html>