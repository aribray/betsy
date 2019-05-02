
provider = "github"
merchants = [
  {
    name: "Chuck Martinsen",
    username: "Chuckles",
    email: "chucklesthetabby@meows.edu",
    uid: 12345,
    provider: provider,
  },
  {
    name: "Missy Martinsen",
    email: "missy@meows.edu",
    username: "Mooper",
    uid: 6789,
    provider: provider,
  },
]

failed_merchant_saves = []
merchants.each do |merchant|
  new_merchant = User.new(merchant)
  if new_merchant.save
    puts "Saved #{merchant[:name]} Successfully"
  else
    failed_merchant_saves << merchant[:name]
  end
end

puts "Failed Merchant Saves #{failed_merchant_saves}"

merchant_1 = User.find_by(name: "Chuck Martinsen")
merchant_2 = User.find_by(name: "Missy Martinsen")

categories = [
  {
    name: "Fashion",
  },
  {
    name: "Wellness",
  },
]

failed_category_saves = []
categories.each do |category|
  new_category = Category.new(category)
  if new_category.save
    puts "Saved #{category[:name]} Successfully"
  else
    failed_category_saves << category[:name]
  end
end

category_1 = Category.find_by(name: "Fashion")
category_2 = Category.find_by(name: "Wellness")

puts "Failed Category Saves #{failed_category_saves}"

products = [
  {
    photo_url: "https://drive.google.com/uc?id=1LCGn0419g0STAeyDo-miWCD6o5ZOEkXM",
    description: "black, lightweight, breathable wool turtleneck, perfect for those moments when you're sweating your scam.",
    name: "Iconic Tech Turtleneck",
    price: 9900,
    quantity: 20,
    retired: false,
    user_id: merchant_2.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1LCGn0419g0STAeyDo-miWCD6o5ZOEkXM",
    description: "For when you need to pull your hair back and really get down to business.",
    name: "Scammer Scrunchie",
    price: 9900,
    quantity: 20,
    retired: false,
    user_id: merchant_2.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1LCGn0419g0STAeyDo-miWCD6o5ZOEkXM",
    description: "For masking the look of pure greed.",
    name: "Dead-Eyelash Extensions",
    price: 9900,
    quantity: 20,
    retired: false,
    user_id: merchant_2.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1LCGn0419g0STAeyDo-miWCD6o5ZOEkXM",
    description: "Actually just cranberry juice reduction.",
    name: "Bad Blood",
    price: 39900,
    quantity: 20,
    retired: false,
    user_id: merchant_1.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1LCGn0419g0STAeyDo-miWCD6o5ZOEkXM",
    description: "Crystal and sunlight blessed nuts.",
    name: "Activated Almonds",
    price: 6999,
    quantity: 10,
    retired: false,
    user_id: merchant_1.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1LCGn0419g0STAeyDo-miWCD6o5ZOEkXM",
    description: "A blissful adaptogenic blend of Reishi, Ashwagandha, Astragalus, Mimosa Bark, Dan Shen, Longan Berry & Goji that targets stress for relief of tension and irritability to calm and brighten mood.",
    name: "Spirit Dust",
    price: 12900,
    quantity: 20,
    retired: false,
    user_id: merchant_1.id,
  },
]

failed_product_saves = []
products.each do |product|
  new_product = Product.new(product)
  if new_product.save
    new_product.categories << category_2
    puts "Saved #{product[:name]} Successfully"
  else
    failed_product_saves << product[:name]
  end
end

puts "Failed Product Saves #{failed_product_saves}"

fashion_products = Product.where(price: 9900)
fashion_products.each do |product|
  product.categories.clear
  product.categories << category_1
end
