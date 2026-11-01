
# Mini Project: Food Delivery Order Management Console

import json

FILE_NAME = "orders.json"


# ==========================================
# 1. ORDER CLASS
# ==========================================

class Order:

    def __init__(self, order_id, customer_name, items,
                 total_amount, status="Pending"):

        self.order_id = order_id
        self.customer_name = customer_name
        self.items = items
        self.total_amount = total_amount
        self.status = status

    def to_dict(self):

        return {
            "order_id": self.order_id,
            "customer_name": self.customer_name,
            "items": self.items,
            "total_amount": self.total_amount,
            "status": self.status
        }


# ==========================================
# 2. LOAD ORDERS FROM JSON FILE
# ==========================================

def load_orders():

    try:
        with open(FILE_NAME, "r") as file:
            data = json.load(file)

        if not isinstance(data, list):
            print("Invalid order file. Starting with empty orders.")
            return []

        orders = []

        for item in data:
            orders.append(
                Order(
                    item["order_id"],
                    item["customer_name"],
                    item["items"],
                    float(item["total_amount"]),
                    item.get("status", "Pending")
                )
            )

        print("Previous orders loaded successfully.")

        return orders

    except FileNotFoundError:

        print("No previous order history found.")
        print("Starting a new order system.")

        return []

    except json.JSONDecodeError:

        print("Order file is empty or corrupted.")
        print("Starting with empty order history.")

        return []

    except (KeyError, TypeError, ValueError):

        print("Invalid order data found in file.")
        return []


# ==========================================
# 3. SAVE ORDERS TO JSON FILE
# ==========================================

def save_orders(orders):

    try:
        data = [order.to_dict() for order in orders]

        with open(FILE_NAME, "w") as file:
            json.dump(data, file, indent=4)

        return True

    except OSError as error:

        print("Error saving orders:", error)

        return False


# ==========================================
# 4. GENERATE ORDER ID
# ==========================================

def generate_order_id(orders):

    highest_id = 0

    for order in orders:

        try:
            number = int(order.order_id.replace("ORD", ""))
            highest_id = max(highest_id, number)

        except (ValueError, AttributeError):
            continue

    return f"ORD{highest_id + 1:03d}"


# ==========================================
# 5. PLACE NEW ORDER
# ==========================================

def place_new_order(orders):

    print("\n========== PLACE NEW ORDER ==========")

    customer_name = input("Enter customer name: ").strip()

    if customer_name == "":
        print("Error: Customer name cannot be empty.")
        return

    items_input = input(
        "Enter food items separated by commas: "
    ).strip()

    items = [
        item.strip()
        for item in items_input.split(",")
        if item.strip()
    ]

    if len(items) == 0:
        print("Error: Please enter at least one food item.")
        return

    try:

        total_amount = float(
            input("Enter total amount (Rs): ")
        )

        if total_amount <= 0:
            print("Error: Amount must be greater than zero.")
            return

    except ValueError:

        print("Error: Please enter a valid numeric amount.")
        return

    order_id = generate_order_id(orders)

    new_order = Order(
        order_id,
        customer_name,
        items,
        total_amount
    )

    orders.append(new_order)

    if save_orders(orders):

        print("\nOrder placed successfully!")
        print("Order ID:", order_id)
        print("Customer:", customer_name)
        print("Total Amount: Rs", total_amount)
        print("Status: Pending")

    else:
        orders.pop()
        print("Order could not be saved.")


# ==========================================
# 6. VIEW ALL ORDERS
# ==========================================

def view_all_orders(orders):

    print("\n================ ALL ORDERS ================")

    if len(orders) == 0:
        print("No orders found.")
        return

    print(
        f"{'Order ID':<12}"
        f"{'Customer Name':<20}"
        f"{'Items':<10}"
        f"{'Total Amount':<16}"
        f"{'Status'}"
    )

    print("-" * 70)

    for order in orders:

        row = (
            f"{order.order_id:<12}"
            f"{order.customer_name[:19]:<20}"
            f"{len(order.items):<10}"
            f"{order.total_amount:<16.2f}"
            f"{order.status}"
        )

        if order.status.lower() == "delivered":

            # Green colour for delivered orders
            print("\033[92m" + row + "\033[0m")

        else:

            print(row)

    print("-" * 70)
    print("Green colour = Delivered orders")


# ==========================================
# 7. SEARCH ORDER BY ID
# ==========================================

def search_order_by_id(orders):

    print("\n========== SEARCH ORDER ==========")

    search_id = input("Enter Order ID: ").strip().upper()

    if search_id == "":
        print("Error: Order ID cannot be empty.")
        return

    for order in orders:

        if order.order_id.upper() == search_id:

            print("\nOrder Found!")

            print("Order ID:", order.order_id)
            print("Customer Name:", order.customer_name)
            print("Food Items:", ", ".join(order.items))
            print("Item Count:", len(order.items))
            print("Total Amount: Rs", order.total_amount)
            print("Status:", order.status)

            return

    print("Order not found.")


# ==========================================
# 8. UPDATE ORDER STATUS (EXTRA FEATURE)
# ==========================================

def update_order_status(orders):

    order_id = input("Enter Order ID: ").strip().upper()

    for order in orders:

        if order.order_id.upper() == order_id:

            print("1. Pending")
            print("2. On the Way")
            print("3. Delivered")

            choice = input("Select new status: ").strip()

            statuses = {
                "1": "Pending",
                "2": "On the Way",
                "3": "Delivered"
            }

            if choice not in statuses:
                print("Invalid status selection.")
                return

            old_status = order.status
            order.status = statuses[choice]

            if save_orders(orders):

                print("Order status updated successfully.")

            else:

                order.status = old_status

            return

    print("Order ID not found.")


# ==========================================
# 9. MAIN MENU
# ==========================================

def main():

    orders = load_orders()

    while True:

        print("\n======================================")
        print(" FOOD DELIVERY ORDER MANAGEMENT")
        print("======================================")

        print("1. Place New Order")
        print("2. View All Orders")
        print("3. Search Order by ID")
        print("4. Exit")
        print("5. Update Order Status")

        choice = input("\nEnter your choice: ").strip()

        if choice == "1":

            place_new_order(orders)

        elif choice == "2":

            view_all_orders(orders)

        elif choice == "3":

            search_order_by_id(orders)

        elif choice == "4":

            print("\nThank you for using our application!")
            print("Goodbye!")
            break

        elif choice == "5":

            update_order_status(orders)

        else:

            print("Invalid choice. Please select 1 to 5.")


# ==========================================
# 10. PROGRAM EXECUTION
# ==========================================

if __name__ == "__main__":

    main()
