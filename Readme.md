# Smart Cart CLI

[![Ruby Version](https://img.shields.io/badge/ruby-3.2.2-red.svg)](https://www.ruby-lang.org/en/downloads/)

A **Ruby-based interactive command-line tool** for working with a simple shopping basket (products, offers, and delivery rules).

This CLI tool allows users to:

- Browse available products
- Add/view items in the basket
- Checkout with offers and delivery rules applied
- Clear the basket
- Access a help menu for usage instructions

It uses a **modular, testable architecture** designed for extensibility.

---

## Requirements

- Ruby 3.2.2
- Bundler

## Setup Instructions

1. **Clone the repository**:

   ```bash
   git clone https://github.com/riteshdevror/smart_cart.git
   cd smart_cart
   ```

2. **Install dependencies**:

   ```bash
   bundle install
   ```

3. **Run the CLI**:

   ```bash
   ruby bin/smart_cart
   ```

---

## Usage Instructions

Once the CLI is set up, run:

```bash
./bin/smart_cart
```

You will see:

```bash
Menu : 
1. Products
2. Basket
3. Checkout
4. Help
5. Exit
Choose an option (1-6):
```

---

### 1. Products Menu

```bash
Available Products :
R01: Red Widget - $32.95
G01: Green Widget - $24.95
B01: Blue Widget - $7.95
```

---

### 2. Basket Menu

```bash
Basket Menu :
1. Add item
2. View basket
3. Back
Choose an option (1-3):
```

#### Adding an item
```bash
Add Product to Basket :
1. R01 - Red Widget ($32.95)
2. G01 - Green Widget ($24.95)
3. B01 - Blue Widget ($7.95)
Enter the number of the product to add: 1
Added Red Widget (R01) to basket.
```

#### Viewing basket
```bash
Basket Contents :
Red Widget (R01) x 2 - $32.95 each
```

---
### 3. Checkout Menu
```bash
Checkout :

Basket Contents :
Red Widget (R01) x 1 - $32.95 each

Total: $$37.90
```
---
### 4. Help Menu

```bash
Smart Cart CLI Help

Options:
  1. Products : List available products
  2. Basket   : Add/view items in basket
  3. Checkout : Calculate total with offers and delivery
  4. Help     : Show this help menu
  5. Exit     : Quit the application

Example usage:
  $ bin/smart_cart
  Choose an option: 2 (Basket) → 1 (Add item) → 1 (first product)
```

---

## Assumptions and Design Decisions

- **Products/Offers/Delivery rules**: Loaded from internal data files or Ruby objects

- **Basket**: Manages item quantities and applies offers automatically

- **Delivery Rules**: Automatically applied during checkout based on basket total

---

## Known Limitations

- **Product Management**: No support for adding/removing products dynamically via CLI (defined statically)

- **Offers/Rules**: Limited to predefined rules and promotions

- **Persistence**: Basket resets on every CLI session (no saved carts)

---

## Future Improvements

- **Product Management CLI**: Add ability to create/update/remove products dynamically

- **Persistence**: Save basket state between sessions

- **Enhanced Offers Engine**: Support more complex offer rules
---

## Running Tests

To run the test suite:

```bash
bundle exec rspec
```
