//
//  main.swift
//  inventory
//
//  Created by StudentAM on 1/16/24.
//


import Foundation

// Initial inventory quantities and prices
var inventory = ["Cereals": 100, "Milks": 100, "Syrups": 100, "Cups": 100]
let prices = ["Cereals": 4.99, "Milks": 4.99, "Syrups": 3.99, "Cups": 2.99]

// User cart and total
var cart: [String: Int] = [:]
var cartTotal: Double = 0.0

// Admin ID
let adminID = "1234"


// Main Menu
func mainMenu() {
    print("\nWelcome to the grocery store! Let us know how we can help you:")
    print("1. Add item to cart")
    print("2. Remove item from cart")
    print("3. Check item availability in stock")
    print("4. Admin Menu")
    print("5. Empty Cart")
    print("6. Checkout")

    if let choice = readLine(), let option = Int(choice) {
        switch option {
        case 1:
            addItemToCart()
        case 2:
            removeItemFromCart()
        case 3:
            checkItemAvailability()
        case 4:
            adminMenu()
        case 5:
            emptyCart()
        case 6:
            checkout()
        default:
            print("Please choose a valid option!")
            mainMenu()
        }
    } else {
        print("Invalid input. Please enter a number.")
        mainMenu()
    }
}
// Function to empty the cart
func emptyCart() {
    print("\nEmptying your cart...")

    // Return items to the inventory
    for (item, quantity) in cart {
        inventory[item, default: 0] += quantity
    }

    // Reset cart and total
    cart = [:]
    cartTotal = 0.0

    print("Your cart is now empty.")

    // Return to the main menu
    mainMenu()
}


// Function to add item to cart
func addItemToCart() {
    print("\nWhat would you like to add to your cart?")
    print("1. Cereal")
    print("2. Milk")
    print("3. Syrup")
    print("4. Cup")
    
    if let choice = readLine(), let item = getItem(for: choice) {
        print("How many \(item)s would you like to add to your cart?")
        
        if let quantityInput = readLine(), let quantity = Int(quantityInput), quantity > 0 {
            if let availableStock = inventory[item], availableStock >= quantity {
                inventory[item]! -= quantity
                let price = Double(quantity) * prices[item]!
                cart[item, default: 0] += quantity
                cartTotal += price
                print("You have added \(quantity) \(item)s to your cart!")
                print("Current total is: $\(cartTotal)")
            } else {
                print("Sorry, there is not enough stock available.")
            }
        } else {
            print("Invalid quantity. Please enter a valid number.")
        }
    } else {
        print("Invalid choice. Please enter a valid number.")
    }
    
    mainMenu()
}

// Function to remove item from cart
func removeItemFromCart() {
    print("What would you like to remove from your cart?")
    displayCart()
    
    if let choice = readLine(), let item = getItem(from: cart, for: choice) {
        print("How many \(item)s would you like to remove from your cart?")
        
        if let quantityInput = readLine(), let quantity = Int(quantityInput), quantity > 0 {
            if let cartQuantity = cart[item], cartQuantity >= quantity {
                inventory[item]! += quantity
                let price = Double(quantity) * prices[item]!
                cart[item]! -= quantity
                cartTotal -= price
                print("Removed \(quantity) \(item)s from the cart!")
                print("Current total is: $\(cartTotal)")
            } else {
                print("Invalid quantity. Please enter a valid number.")
            }
        } else {
            print("Invalid quantity. Please enter a valid number.")
        }
    } else {
        print("Invalid choice. Please enter a valid number.")
    }
    
    mainMenu()
}

// Function to check item availability
func checkItemAvailability() {
    print("What item would you like to check if it's in stock?")
    print("1. Cereal")
    print("2. Milk")
    print("3. Syrup")
    print("4. Cup")
    
    if let choice = readLine(), let item = getItem(for: choice) {
        if let availableStock = inventory[item] {
            print("There are currently \(availableStock) \(item)s in stock!")
        }
    } else {
        print("Invalid choice. Please enter a valid number.")
    }
    
    mainMenu()
}

// Function to display cart
func displayCart() {
    print("Your cart:")
    for (item, quantity) in cart {
        print("\(item): \(quantity)")
    }
    print("Total: $\(cartTotal)")
}

// Function to get item based on user input
func getItem(for input: String) -> String? {
    switch input {
    case "1":
        return "Cereals"
    case "2":
        return "Milks"
    case "3":
        return "Syrups"
    case "4":
        return "Cups"
    default:
        return nil
    }
}

// Function to get item from cart based on user input
func getItem(from cart: [String: Int], for input: String) -> String? {
    let index = Int(input)! - 1
    let keys = Array(cart.keys)
    
    
    if index >= 0 && index < keys.count {
        return keys[index]
    } else {
        return nil
    }
    
}

// Function to process checkout
func checkout() {
    print("Thanks for shopping with us!")
    displayCart()
    let tax = cartTotal * 0.0925
    let grandTotal = cartTotal + tax
    print("Your grand total including tax (9.25%) is: $\(grandTotal)")
    
   
    cart = [:]
    cartTotal = 0.0
    
    mainMenu()
}


// Admin Menu
func adminMenu() {
    print("\nEnter Admin ID:")
    if let adminInput = readLine(), adminInput == adminID {
        print("\nWelcome to the Admin menu!")
        print("1. Restock inventory")
        print("2. Generate report")
        print("3. Check the value of items in stock individually")
        print("4. Quit admin menu")

        if let adminChoice = readLine(), let choice = Int(adminChoice) {
            switch choice {
            case 1:
                restockInventory()
            case 2:
                generateReport()
            case 3:
                checkStockValuesIndividually()
            case 4:
                return // Exit the admin menu
            default:
                print("Invalid choice. Please enter a valid number.")
            }
        } else {
            print("Invalid input. Please enter a number.")
        }
    } else {
        print("Invalid Admin ID.")
    }

   
    mainMenu()
}

// Function to check the value of items in stock individually
func checkStockValuesIndividually() {
    print("\nEnter the item you want to check:")
    print("1. Cereal")
    print("2. Milk")
    print("3. Syrup")
    print("4. Cup")

    if let choice = readLine(), let item = getItem(for: choice) {
        if let stock = inventory[item] {
            let value = Double(stock) * prices[item]!
            print("\(item): \(stock) items | Value: $\(value)")
        } else {
            print("Invalid item or item not found.")
        }
    } else {
        print("Invalid choice. Please enter a valid number.")
    }


    adminMenu()
}





func restockInventory() {
    print("\nRestocking inventory...")

    for (item, _) in inventory {
        
        inventory[item]! += 50
    }

    print("Inventory restocked.")
}

func generateReport() {
    print("\nGenerating report...")

    print("Summary Report:")
    for (item, stock) in inventory {
        print("Remaining \(item): \(stock) items")
    }

    let totalSales = cartTotal * 0.0925
    print("Total Sales: $\(totalSales)")

    print("Report generated.")
}



mainMenu()


