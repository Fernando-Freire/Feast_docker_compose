from feast import FileSource

sample_products_stats = FileSource(
    name="sample_products",
    path="s3://feast/sample_products.parquet",
    s3_endpoint_override="http://minio:9000",  # Needed since s3fs defaults to us-east-1
    timestamp_field="creation_date",
)
