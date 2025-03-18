class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  #allow_browser versions: :modern
  include MonetizationConcern
  include SeoConcern
  include ApacheVhostConcern
  include PayPalInvoiceConcern
  include EmailServiceConcern
end
