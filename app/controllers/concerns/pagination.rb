# fr# frozen_string_literal: true

module Pagination
  extend ActiveSupport::Concern

  included do
    include Pagy::Method
  end

  private

  def paginate(collection, blueprinter, root, options = {})
    pagination, records = pagy(collection)

    {
      root => blueprinter.render_as_hash(records, options),
      meta: {
        page: pagination.page,
        items: pagination.limit,
        count: pagination.count,
        pages: pagination.pages,
        prev: pagination.previous,
        next: pagination.next
      }
    }
  end

  def unpaginated(collection, blueprinter, root)
    {
      root => blueprinter.render_as_hash(collection),
      links: {},
      meta: {}
    }
  end
end
