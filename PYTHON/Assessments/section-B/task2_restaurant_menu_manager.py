# Section B - Task 2: Restaurant Menu Manager

menu = {
    "Paneer Burger": {"price": 180, "category": "Snacks"},
    "Masala Dosa": {"price": 90, "category": "Breakfast"},
    "Veg Pizza": {"price": 250, "category": "Main Course"},
    "Cold Coffee": {"price": 120, "category": "Beverages"},
    "Gujarati Thali": {"price": 220, "category": "Main Course"},
    "French Fries": {"price": 100, "category": "Snacks"}
}


def view_all_items():
    print("\n----------- RESTAURANT MENU -----------")
    print(f"{'No.':<5}{'Dish':<22}{'Price (Rs)':<14}{'Category'}")
    print("-" * 58)
    for number, (dish, details) in enumerate(menu.items(), start=1):
        print(f"{number:<5}{dish:<22}{details['price']:<14}{details['category']}")
    print("-" * 58)


def filter_by_category():
    category = input("Enter category to filter: ").strip()
    matches = [
        (dish, details) for dish, details in menu.items()
        if details["category"].lower() == category.lower()
    ]

    if matches:
        print(f"\nItems in {category}:")
        for dish, details in matches:
            print(f"{dish} - Rs {details['price']}")
    else:
        print("No items found in this category.")


def search_dish():
    dish_name = input("Enter dish name: ").strip()
    for dish, details in menu.items():
        if dish.lower() == dish_name.lower():
            print(f"{dish} costs Rs {details['price']}.")
            return
    print("Dish not found.")


while True:
    print("\n===== RESTAURANT MENU MANAGER =====")
    print("1. View all menu items")
    print("2. Filter items by category")
    print("3. Search dish by name")
    print("0. Exit")

    choice = input("Enter your choice: ").strip()

    if choice == "1":
        view_all_items()
    elif choice == "2":
        filter_by_category()
    elif choice == "3":
        search_dish()
    elif choice == "0":
        print("Thank you! Exiting Menu Manager.")
        break
    else:
        print("Invalid choice. Please select 0, 1, 2, or 3.")
