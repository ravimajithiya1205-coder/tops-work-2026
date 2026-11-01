
# Corrected Code - Food Delivery Billing System

print("===== FOOD DELIVERY BILLING SYSTEM =====")

items = []
subtotal = 0

# Get number of food items
try:
    number_of_items = int(input("Enter number of food items: "))

    if number_of_items <= 0:
        print("Error: Enter at least one food item.")

    else:

        # Accept food items and prices
        valid_order = True

        for i in range(number_of_items):

            print("\nFood Item", i + 1)

            name = input("Enter food item name: ").strip()

            if name == "":
                print("Error: Food item name cannot be empty.")
                valid_order = False
                break

            try:
                price = float(input("Enter item price (Rs): "))

                if price < 0:
                    print("Error: Price cannot be negative.")
                    valid_order = False
                    break

                items.append((name, price))
                subtotal = subtotal + price

            except ValueError:
                print("Error: Please enter a valid numeric price.")
                valid_order = False
                break

        # Continue only if all items are valid
        if valid_order:

            # Get previous order count
            try:
                previous_orders = int(
                    input("\nEnter previous order count: ")
                )

                if previous_orders < 0:
                    print("Error: Order count cannot be negative.")

                else:

                    # Calculate bill
                    gst = subtotal * 18 / 100
                    delivery_fee = 30

                    discount = 0

                    if previous_orders > 5:
                        discount = subtotal * 10 / 100

                    final_amount = (
                        subtotal + gst + delivery_fee - discount
                    )

                    # Print receipt
                    print("\n========== FOOD DELIVERY RECEIPT ==========")

                    for name, price in items:
                        print(f"{name:<20} Rs {price:.2f}")

                    print("-------------------------------------------")
                    print(f"{'Subtotal':<20} Rs {subtotal:.2f}")
                    print(f"{'GST (18%)':<20} Rs {gst:.2f}")
                    print(f"{'Delivery Fee':<20} Rs {delivery_fee:.2f}")
                    print(f"{'Loyalty Discount':<20} Rs {discount:.2f}")

                    print("-------------------------------------------")
                    print(f"{'Final Amount':<20} Rs {final_amount:.2f}")
                    print("===========================================")

            except ValueError:
                print("Error: Previous order count must be a whole number.")

except ValueError:
    print("Error: Number of food items must be a valid whole number.")
