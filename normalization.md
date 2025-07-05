# Normalization to 3NF

When we normalize, we break tables into smaller tables so each fact lives in exactly one place.

1. **Find partial dependencies**  
   - Example: If a Property record has both `host_name` and `host_contact`, move those into a new **Host** table.

2. **Find transitive dependencies**  
   - Example: `Payment.amount` depends only on `Booking`, not on `User`, so keep it in the **Payment** table.

3. **Resulting tables**  
   - **User**(user_id, first_name, email, …)  
   - **Host**(host_id, host_name, host_contact, …)  
   - **Property**(property_id, host_id, name, …)  
   - **Booking**(booking_id, user_id, property_id, date, …)  
   - **Payment**(payment_id, booking_id, amount, …)
