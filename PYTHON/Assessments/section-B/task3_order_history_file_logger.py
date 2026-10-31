# Section B - Task 3: Order History File Logger

import json

FILE_NAME = "orders.json"


def load_orders():
    try:
        with open(FILE_NAME, "r", encoding="utf-8") as file:
            return json.load(file)
    except FileNotFoundError:
        return []
    except json.JSONDecodeError:
        print("Warning: orders.json is empty or invalid. Starting with an empty history.")
        return []


def save_orders(orders):
    with open(FILE_NAME, "w", encoding="utf-8") as file:
        json.dump(orders, file, indent=4)


def add_order():
    orders = load_orders()

    customer_name = input("Enter customer name: ").strip()
    items_text = input("Enter items separated by commas: ")
    items = [item.strip() for item in items_text.split(",") if item.strip()]

    try:
        total_amount = float(input("Enter total amount (Rs): "))
    except ValueError:
        print("Error: Total amount must be numeric. Order was not saved.")
        return

    order_status = input("Enter order status: ").strip()

    order = {
        "customer_name": customer_name,
        "items": items,
        "total_amount": total_amount,
        "order_status": order_status
    }

    orders.append(order)
    save_orders(orders)
    print("Order saved successfully.")


def view_orders():
    orders = load_orders()

    if not orders:
        print("No order history found.")
        return

    print("\n========== ORDER HISTORY ==========")
    for number, order in enumerate(orders, start=1):
        print(f"Order {number}")
        print(f"Customer : {order['customer_name']}")
        print(f"Items    : {', '.join(order['items'])}")
        print(f"Total    : Rs {order['total_amount']:.2f}")
        print(f"Status   : {order['order_status']}")
        print("-" * 36)


while True:
    print("\n===== ORDER HISTORY LOGGER =====")
    print("1. Add new order")
    print("2. View orders")
    print("0. Exit")

    choice = input("Enter your choice: ").strip()

    if choice == "1":
        add_order()
    elif choice == "2":
        view_orders()
    elif choice == "0":
        print("Goodbye!")
        break
    else:
        print("Invalid choice. Please try again.")
0