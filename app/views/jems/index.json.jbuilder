json.array!(@jems) do |jem|
  json.extract! jem, :id, :name, :seq, :comment
  json.url jem_url(jem, format: :json)
end
