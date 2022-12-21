# frozen_string_literal: true
module Visible
  extend ActiveSupport::Concern

  # Status validation
  VALID_STATUSES = ['public', 'private', 'archived']

  included do
    validates :status, inclusion: { in: VALID_STATUSES}
  end

  # Class method : Used to displau a count of public articles or comments on our main page
  class_methods do
    def public_count
      where(status: 'public').count
    end
  end

  # Status method
  def archived?
    status == 'archived'
  end
end
