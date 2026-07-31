# frozen_string_literal: true

module Pagination
  extend ActiveSupport::Concern

  included do
    include Pagy::Method
  end

  private

  def paginate(collection, blueprinter, root, options = {})
    pagy, records = pagy(:offset, collection)

    {
      "#{root}": blueprinter.render_as_hash(records, options),
      meta: {
        page: pagy.page,
        items: pagy.limit,
        count: pagy.count,
        pages: pagy.last,
        prev: pagy.previous,
        next: pagy.next,
      }
    }
  end

  def unpaginated(collection, blueprinter, root)
    {
      "#{root}": blueprinter.render_as_hash(collection),
      links: {},
      meta: {}
    }
  end
end
