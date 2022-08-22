from feast import Entity

# Define an entity for each driver. You can think of entity as a primary key used to
# fetch features.
sample_products = Entity(name="products", join_keys=["product_id"])
