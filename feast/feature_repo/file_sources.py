from feast import FileSource

sample_products_stats = FileSource(
    name="sample products",
    path="/feature_repo/data/sample_products.parquet",
    timestamp_field="creation date",
    created_timestamp_column="creation date",
)
