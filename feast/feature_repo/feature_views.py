from datetime import timedelta

from entities import sample_products
from feast import FeatureView, Field
from feast.types import Float32, Int64, String, UnixTimestamp
from file_sources import sample_products_stats

sample_products_stats_view = FeatureView(
    name="sample_products_stats_view",
    entities=[sample_products],
    ttl=timedelta(days=1),
    schema=[
        Field(name="product_id", dtype=Int64),
        Field(name="seller_id", dtype=Int64),
        Field(name="query", dtype=String),
        Field(name="search_page", dtype=Int64),
        Field(name="position", dtype=Int64),
        Field(name="title", dtype=String),
        Field(name="concatenated_tags", dtype=String),
        Field(name="creation_date", dtype=UnixTimestamp),
        Field(name="price", dtype=Float32),
        Field(name="weight", dtype=Float32),
        Field(name="express_delivery", dtype=Int64),
        Field(name="minimum_quantity", dtype=Int64),
        Field(name="view_counts", dtype=Int64),
        Field(name="order_counts", dtype=Int64),
        Field(name="category", dtype=String),
    ],
    online=True,
    source=sample_products_stats,
    tags={},
)
