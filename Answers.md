### 1. Explain the relationship between the "Product" and "Product_Category" entities from the above diagram.

In the simple term ,
The "Product" table and "Product_Category" table have a one-to-many relationship because for each category, there can be multiple products [many "Product" in one "Product_Category"], but each "Product" can only belong to one "Product_Category".

on the other hand,
if you define that each "Product" table can belong multiple categories that's time it'll be many-to-many relationships.(worst case);


### 2. How could you ensure that each product in the "Product" table has a valid category assigned to it?


# approach 1

The most straightforward approach is to use a foreign key constraint that references a "Product_Category" table. This ensures that every "Product_Category" ID assigned to a "Product" must exist in the "Product_Category" table.

# approach 1
We can implement validation logic in your application's code to check whether a "Product_Category" ID exists in the "Product_Category" table before allowing a new product to be inserted into the "Product" table. This can be achieved through a query or using ORM (Object-Relational Mapping) tools that often provide ways to validate relationships automatically.