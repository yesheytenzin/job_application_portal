# frozen_string_literal: true

class ProfileSerializer < Blueprinter::Base
    fields :id, :first_name, :last_name, :username, :phone, :address
end
