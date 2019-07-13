# frozen_string_literal: true

BASE_URL = "#{Settings.tmp_base_url}" # TODO: read from config file

# Regexps
TMP_ID_REGEXP = "TMP-[A-Z0-9]{6}"
URL_REGEXP = '\/workflows\/(\d+)\/approvals\/(\d+)' # extract workflow id and approval id from url

# Capyabara Timeouts
GLOBAL_WAIT_TIME = Settings.capybara.global_wait_time
WAIT_FOR_PRESENCE = Settings.capybara.wait_for_presence

SITEPRISM_DEBUG_MODE = Settings.siteprism.debug_mode

# ROLES
TMC = 'tmc'
AUTHORISER = 'authoriser'
TRAVELLER = 'traveller'