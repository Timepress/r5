E = Element

def ef text
  Element.find text
end

def show_alert header, text
   ef('#alert_header').html = header
   ef('#alert_body').html = text
   ef('#alert_window').show
end
