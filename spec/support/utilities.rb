
def full_title(page_title)
  base_title = "良师益友"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end
