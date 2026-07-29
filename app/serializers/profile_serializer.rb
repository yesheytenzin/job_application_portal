# frozen_string_literal: true

class ProfileSerializer < Blueprinter::Base
    identifier :id
    fields :first_name, :last_name, :username, :phone, :address, :updated_at
end
