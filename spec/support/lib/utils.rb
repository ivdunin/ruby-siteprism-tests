# frozen_string_literal: true

def trip_date(days_ahead = 1, format = '%d-%m-%Y')
  (DateTime.now() + days_ahead).strftime(format)
end