json.extract! transaction, :id, :total_price, :order_status_id, :postal_fee_id, :order_status_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
