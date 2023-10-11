module ApplicationHelper

  def date_proximity(d)
    if d < (Time.current + 1.month) then
      'text-danger'
    elsif d < (Time.current + 6.months) then
      'text-info'
    else
      'text-success'
    end
  end

  def embed_pdf_tag(data=nil, options: {})

    src_options = {
      toolbar:   1,
      navpanes:  0,
      scrollbar: 0,
      statusbar: 0,
      messages:  0,
      nameddest: 'foo.pdf'
    }

    begin
      Base64.strict_decode64(data)
    rescue ArgumentError
      data.tr!('-_', '+/')
    end

    content_tag(:embed, '',
                type: Mime[:pdf].to_s,
                src: "data:#{Mime[:pdf].to_s};base64,#{data}##{src_options.to_param}",
                style: 'height: 700px; width: 100%'
                )

  end


end

