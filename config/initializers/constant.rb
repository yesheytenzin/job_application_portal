# frozen_string_literal: true

# role
ADMIN = 'admin'
APPLICANT = 'applicant'

# job
DRAFT = 'draft'
OPEN = 'open'
CLOSED = 'closed'

# document
ALLOWED_TYPES = %w[ application/pdf image/png image/jpeg ].freeze
MAX_FILE_SIZE = 10.megabytes
