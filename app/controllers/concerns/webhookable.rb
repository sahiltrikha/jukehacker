module Webhookable
  extend ActiveSupport::Concern
  # This Concern provides two simple capabilities:
  # Setting the HTTP response content type to “text/xml”
  # Rendering the TwiML object to raw XML

  def set_header
    response.headers["Content-Type"] = "text/xml"
  end

  def render_twiml(response)
    render text: response.text
  end

end