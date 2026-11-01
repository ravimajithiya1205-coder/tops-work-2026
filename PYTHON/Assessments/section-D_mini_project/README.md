# Section D – AI-Augmented Learning
## Mini Project: Food Delivery Billing System

**Module:** Python for Data Analytics  
**Section:** D – AI-Augmented Learning  
**Language:** Python 3  
**Project Type:** Console-Based Application

---

## 1. Project Overview

The Food Delivery Billing System is a Python console-based application that calculates the final bill for a food delivery order.

The program accepts food item names and prices from the user, calculates the subtotal, adds 18% GST and a flat delivery fee of Rs 30, and applies a 10% loyalty discount for customers who have placed more than five previous orders.

This project demonstrates the use of Python fundamentals, conditional statements, loops, exception handling, user input validation, and formatted output.

## 2. Project Objectives

The main objectives of this project are:

- Accept multiple food items and their prices from the user.
- Calculate the total item subtotal.
- Calculate 18% GST on the subtotal.
- Add a flat delivery charge of Rs 30.
- Apply a 10% loyalty discount if previous orders are more than five.
- Generate a properly formatted billing receipt.
- Handle invalid inputs such as negative prices and non-numeric values.
- Improve the AI-generated solution through manual testing and debugging.

## 3. Billing Rules

| Description | Rule |
|---|---|
| Item Subtotal | Sum of all food item prices |
| GST | 18% of subtotal |
| Delivery Fee | Rs 30 (Flat) |
| Loyalty Discount | 10% of subtotal if previous orders > 5 |
| Final Amount | Subtotal + GST + Delivery Fee - Discount |

### Calculation Formula

GST = Subtotal × 18 / 100

Discount = Subtotal × 10 / 100 (if previous orders > 5)

Final Amount = Subtotal + GST + Delivery Fee - Discount

## 4. Technologies and Python Concepts Used

- Python 3
- Variables and data types
- Lists and tuples
- For loops
- If-else conditional statements
- Try-except exception handling
- User input validation
- String formatting
- Arithmetic operations

## 5. Project Files

| File Name | Description |
|---|---|
| `FoodDeliveryBillingSystem.py` | Improved Python solution after testing and debugging |
| `README.md` | Project documentation |

## 6. How to Run the Project

### Requirements

- Python 3 installed on your computer.
- VS Code, Jupyter Notebook, or another Python code editor.

### Steps

1. Open the project folder in VS Code.
2. Open the terminal.
3. Run the corrected Python file using:

```bash
python FoodDeliveryBillingSystem.py
```

4. Enter the number of food items.
5. Enter each food item's name and price.
6. Enter the customer's previous order count.
7. View the generated billing receipt.

## 7. Sample Input

```text
Enter number of food items: 3

Food Item 1
Enter food item name: Pizza
Enter item price (Rs): 200

Food Item 2
Enter food item name: Burger
Enter item price (Rs): 150

Food Item 3
Enter food item name: Cold Coffee
Enter item price (Rs): 100

Enter previous order count: 6
```

## 8. Expected Output

```text
========== FOOD DELIVERY RECEIPT ==========

Pizza                Rs 200.00
Burger               Rs 150.00
Cold Coffee          Rs 100.00

-------------------------------------------
Subtotal             Rs 450.00
GST (18%)            Rs 81.00
Delivery Fee         Rs 30.00
Loyalty Discount     Rs 45.00

-------------------------------------------
Final Amount         Rs 516.00
===========================================
```

## 9. Testing and Debugging

The initial AI-generated program was tested using different inputs.

The following issues and improvements were identified:

| Test Case | Expected Behaviour |
|---|---|
| Valid food prices | Calculate the bill correctly |
| Negative food price | Display an error message |
| Non-numeric food price | Handle ValueError |
| Negative order count | Reject the input |
| Non-numeric order count | Display an error message |
| Empty food item name | Reject the input |
| Previous orders greater than 5 | Apply 10% discount |
| Previous orders equal to 5 | Do not apply discount |

## 10. Changes Made to the AI-Generated Code

The original AI-generated program had limitations in input validation. It accepted negative previous-order counts and did not handle invalid food prices gracefully.

The corrected version includes additional try-except blocks to handle non-numeric inputs and prevents negative prices and empty food names.

The billing process also stops when invalid data is entered, preventing incorrect calculations.

## 11. Learning Outcomes

Through this project, I learned how to:

- Use AI tools to generate an initial Python program.
- Understand and review AI-generated code.
- Identify bugs and limitations through manual testing.
- Improve code using exception handling and input validation.
- Calculate bills using arithmetic operators and conditional statements.
- Generate formatted receipts using Python string formatting.

## 12. Conclusion

This project demonstrates how Python can be used to develop a simple food delivery billing application.

AI helped generate the initial solution, while manual testing and debugging helped identify and correct its limitations.

The project improved my understanding of Python programming, problem-solving, exception handling, and the responsible use of AI tools in software development.

---

**Project:** Food Delivery Billing System  
**Section:** D – AI-Augmented Learning  
**Module:** Python for Data Analytics