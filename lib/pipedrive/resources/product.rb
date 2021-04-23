# frozen_string_literal: true

module Pipedrive
  class Product < Resource
    include Fields

    has_many :variations, class_name: "Variation"

    # POST /prooducts/:id/variations
    # Add a variation to this product
    def add_variation(params)
      raise "Param :name is required" unless params.key?(:name)
      raise "Param :prices is required" unless params.key?(:prices)

      response = request(
        :post,
        "#{resource_url}/variations",
        params.merge(id: id)
      )
      Variation.new(response.dig(:data))
    end
  end
end
