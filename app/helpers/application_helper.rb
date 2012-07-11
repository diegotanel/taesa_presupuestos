module ApplicationHelper

  def logo
    image_tag("taesa_logo.jpg", :alt => "taesa", :class => "round")
  end

  def title
    base_title = "Sistema de presupuestos"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
