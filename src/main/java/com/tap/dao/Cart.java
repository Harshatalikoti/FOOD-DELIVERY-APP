package com.tap.dao;

import com.tap.model.CartItem;
import java.util.HashMap;
import java.util.Map;

public class Cart {
    private Map<Integer, CartItem> items;

    public Cart() {
        this.items = new HashMap<>();
    }

    // Adds or updates an item in the cart
    public void addCartItem(int menuId, String itemName, double unitPrice, int quantity) {
        if (quantity <= 0) return;

        if (items.containsKey(menuId)) {
            CartItem existingItem = items.get(menuId);
            int newQuantity = existingItem.getQuantity() + quantity;
            existingItem.setQuantity(newQuantity);
            existingItem.setPrice(unitPrice * newQuantity);
        } else {
            items.put(menuId, new CartItem(menuId, itemName, unitPrice * quantity, quantity));
        }
    }

    // Removes an item from the cart
    public void removeCartItem(int menuId) {
        items.remove(menuId);
    }

    // Updates the quantity and recalculates the price
    public void updateCartItem(int menuId, int newQuantity) {
        CartItem item = items.get(menuId);
        if (item != null && newQuantity > 0) {
            double unitPrice = item.getPrice() / item.getQuantity();
            item.setQuantity(newQuantity);
            item.setPrice(unitPrice * newQuantity);
        } else if (item != null) {
            removeCartItem(menuId); // Remove if quantity <= 0
        }
    }

    // Returns all items in the cart
    public Map<Integer, CartItem> getItems() {
        return items;
    }

    // Calculates the total price of the cart
    public double calculateTotalPrice() {
        return items.values().stream().mapToDouble(CartItem::getPrice).sum();
    }
}
