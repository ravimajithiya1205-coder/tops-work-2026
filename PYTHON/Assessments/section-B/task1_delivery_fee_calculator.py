# Section B - Task 1: Delivery Fee Calculator

try:
    order_value = float(input("Enter order value (Rs): "))
    distance = float(input("Enter delivery distance (km): "))

    if order_value < 0 or distance < 0:
        print("Error: Order value and delivery distance cannot be negative.")
    else:
        if order_value >= 500:
            delivery_fee = 0
        elif distance <= 5:
            delivery_fee = 30
        else:
            delivery_fee = 60

        final_amount = order_value + delivery_fee

        print("\n----- FOOD DELIVERY BILL -----")
        print(f"Item Total       : Rs {order_value:.2f}")
        print(f"Delivery Fee     : Rs {delivery_fee:.2f}")
        print(f"Final Amount     : Rs {final_amount:.2f}")
        print("------------------------------")

except ValueError:
    print("Error: Please enter valid numeric values.")
