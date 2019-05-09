module ApplicationHelper
  def stars(product)
    avg = product.average_review.to_i
    str = ""
    avg.times do
      str += "★"
    end
    (5 - avg).times do
      str += "☆"
    end
    return str
  end
end
