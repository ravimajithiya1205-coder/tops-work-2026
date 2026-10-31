# Section B - Task 4: Delivery Rider OOP System

import csv
import os

FILE_NAME = "riders.csv"


class Rider:
    def __init__(self, rider_id, name, status="Available", total_deliveries=0):
        self.rider_id = str(rider_id)
        self.name = name
        self.status = status
        self.total_deliveries = int(total_deliveries)

    def assign_order(self, order_id):
        if self.status == "On Delivery":
            print(f"{self.name} is already on delivery and cannot take another order.")
        else:
            self.status = "On Delivery"
            print(f"Order {order_id} assigned to rider {self.name} (ID: {self.rider_id}).")

    def complete_delivery(self):
        if self.status == "On Delivery":
            self.total_deliveries += 1
            self.status = "Available"
            print(f"Delivery completed by {self.name}. Rider is now Available.")
        else:
            print(f"{self.name} has no active delivery to complete.")

    def display_info(self):
        print(
            f"ID: {self.rider_id} | Name: {self.name} | "
            f"Status: {self.status} | Total Deliveries: {self.total_deliveries}"
        )


def load_riders():
    riders = []
    if os.path.exists(FILE_NAME):
        with open(FILE_NAME, "r", newline="", encoding="utf-8") as file:
            reader = csv.DictReader(file)
            for row in reader:
                riders.append(
                    Rider(
                        row["rider_id"],
                        row["name"],
                        row["status"],
                        row["total_deliveries"]
                    )
                )
    else:
        riders = [
            Rider("R101", "Amit"),
            Rider("R102", "Rahul"),
            Rider("R103", "Karan")
        ]
    return riders


def save_riders(riders):
    with open(FILE_NAME, "w", newline="", encoding="utf-8") as file:
        fieldnames = ["rider_id", "name", "status", "total_deliveries"]
        writer = csv.DictWriter(file, fieldnames=fieldnames)
        writer.writeheader()
        for rider in riders:
            writer.writerow({
                "rider_id": rider.rider_id,
                "name": rider.name,
                "status": rider.status,
                "total_deliveries": rider.total_deliveries
            })


def find_rider(riders, rider_id):
    for rider in riders:
        if rider.rider_id.lower() == rider_id.lower():
            return rider
    return None


riders = load_riders()

while True:
    print("\n===== DELIVERY RIDER SYSTEM =====")
    print("1. Display all riders")
    print("2. Assign order to rider")
    print("3. Complete delivery")
    print("0. Save and exit")

    choice = input("Enter your choice: ").strip()

    if choice == "1":
        for rider in riders:
            rider.display_info()

    elif choice == "2":
        rider_id = input("Enter rider ID: ").strip()
        rider = find_rider(riders, rider_id)
        if rider:
            order_id = input("Enter order ID: ").strip()
            rider.assign_order(order_id)
        else:
            print("Rider ID not found.")

    elif choice == "3":
        rider_id = input("Enter rider ID: ").strip()
        rider = find_rider(riders, rider_id)
        if rider:
            rider.complete_delivery()
        else:
            print("Rider ID not found.")

    elif choice == "0":
        save_riders(riders)
        print(f"Rider data saved to {FILE_NAME}. Goodbye!")
        break

    else:
        print("Invalid choice. Please try again.")
