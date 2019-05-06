
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
  {
    name: "Amanda Chantal Bacon",
    email: "dust@scammer101.edu",
    username: "Mandy Bacon",
    uid: 101112,
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
merchant_3 = User.find_by(name: "Amanda Chantal Bacon")

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
    user_id: merchant_2.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1PO320BT3BFj5xOtP3gI6Kdvu7ZWewHQd",
    description: "Wow. You can't make this stuff up folks.",
    name: "Thieves Essential Oil",
    price: 9900,
    quantity: 20,
    user_id: merchant_2.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1Q_AXyDHj_tElFoRwh-Og7PqZfzXqcRxv",
    description: "Cuz why not roll on more thieves?",
    name: "Thieves Roll-on Oil",
    price: 9900,
    quantity: 20,
    user_id: merchant_1.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1V_nDRyM7nrtEeer7IrHXqvO4xCIrJivb",
    description: "For when you need to pull your hair back and really get down to business.",
    name: "Scammer Scrunchie",
    price: 18900,
    quantity: 20,
    user_id: merchant_2.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1GXXCWyNUWcbJ-MgYpzHKnIMh0yZbyP1G",
    description: "For masking the look of pure greed.",
    name: "Dead-Eyelash Extensions",
    price: 2900,
    quantity: 20,
    user_id: merchant_2.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=16W32YMjpQG4wT6xf5F2xn1VAQFY6U_A1",
    description: "Actually just cranberry juice reduction.",
    name: "Bad Blood",
    price: 9900,
    quantity: 20,
    user_id: merchant_1.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1NehE5rQikBkJAHFExeq5bzfAnkdLJBPi",
    description: "Crystal and sunlight blessed nuts.",
    name: "Activated Almonds",
    price: 9900,
    quantity: 10,
    user_id: merchant_1.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=144UMvn4yhZKwezErfkOaB7pbBnhxEVb-",
    description: "A blissful adaptogenic blend of Reishi, Ashwagandha, Astragalus, Mimosa Bark, Dan Shen, Longan Berry & Goji that targets stress for relief of tension and irritability to calm and brighten mood.",
    name: "Spirit Dust",
    price: 9900,
    quantity: 20,
    user_id: merchant_3.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1prgmwyAj9dYbVjT2CPO-sdXsusqlQWWD",
    description: "A scam of a t-neck.",
    name: "Turtleneck Dickie",
    price: 2500,
    quantity: 20,
    user_id: merchant_2.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1HPzvD86b2wXMWgCYl2m6VlE8lPFCRUHy",
    description: "Ok, an actually cute dickie.",
    name: "Vivetta Dickie",
    price: 17500,
    quantity: 6,
    user_id: merchant_2.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=13-VsjbEbQJXZVrp63DFqCB7sryuNeZyA",
    description: "Make that tap water work!",
    name: "Crystal Waterbottle",
    price: 9900,
    quantity: 20,
    user_id: merchant_2.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=16W32YMjpQG4wT6xf5F2xn1VAQFY6U_A1",
    description: "Chic and environmentally friendly!",
    name: "Crystal Straw",
    price: 9900,
    quantity: 100,
    user_id: merchant_1.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=18TwESqPPzgm6g9xOUAWQlbCEfhMEJK9z",
    description: "It's gonna be so fun we promise.",
    name: "Fyre Festival Tickets",
    price: 200000,
    quantity: 2,
    user_id: merchant_1.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1sraCdsrcE1hguwRkt5Xn7RQ4pNonu8Wz",
    description: "Dust for dreams.",
    name: "Dream Dust",
    price: 9900,
    quantity: 20,
    user_id: merchant_3.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1wyjtZoxhGMcVDmHf0RZ1hbJZqKYReHh0",
    description: "Better than regular cashews, for sure.",
    name: "Activated Cashews",
    price: 9900,
    quantity: 30,
    user_id: merchant_2.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=11JncZxJ9UzyCkr06LvLIInUJNaeT46V4",
    description: "Tastes just like regular charcoal!",
    name: "Activated Charcoal",
    price: 9900,
    quantity: 40,
    user_id: merchant_2.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1Wkxcc1CblNVoNMMCrLwiGBYfvJQP5e3-",
    description: "This is way better than the Nerd Alert supplement.",
    name: "Brain Dust",
    price: 9900,
    quantity: 20,
    user_id: merchant_3.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1C6WUIzwZjohSwrp0dglDC1BEuPW4TItx",
    description: "Dust for night time.",
    name: "Night Beauty Dust",
    price: 9900,
    quantity: 20,
    user_id: merchant_3.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1Y0ULM2U9bh3NicB56pbmAT5M-2ROGBxw",
    description: "I just can't.",
    name: "Tummy Tea",
    price: 9900,
    quantity: 10,
    user_id: merchant_1.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1tsBSPdt7SByXnIRbmdOMCiLCxgVoyut5",
    description: "You don't have to buy anything! I promise I just want to hang out!",
    name: "Tupperware Party Tickets",
    price: 2900,
    quantity: 20,
    user_id: merchant_1.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1FK6-HcKPFWo3FDDfNa2Ion3u16Kd7Kuj",
    description: "If you don't buy this tupperware set we  won't be friends anymore.",
    name: "50 pc Tupperware Set",
    price: 19900,
    quantity: 20,
    user_id: merchant_2.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1vqJD08DeCefqZgavO32cLXsDxxAAfIS1",
    description: "Ok actually though, this tupperware is incredible.",
    name: "Legit Tupperware",
    price: 12900,
    quantity: 20,
    user_id: merchant_2.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1x6pljZ9hnk4vsUCF8wPg9Xg_TkeVbi5b",
    description: "For when you're too tired to make reasonable choices.",
    name: "So Effing Tired Vitamins",
    price: 9900,
    quantity: 10,
    retired: false,
    user_id: merchant_1.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1KfFAiFEISWL_uYix8jTXYgBH8Tfa86Ke",
    description: "Oil pulling, but make it skinny.",
    name: "Skinny Oil Pulling",
    price: 9900,
    quantity: 20,
    user_id: merchant_1.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1qcdmOjTxe4sONzzZZ8B2w2boStclW93h",
    description: "You'll definitely get totally ripped!",
    name: "Shakeweight",
    price: 19900,
    quantity: 20,
    user_id: merchant_2.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1wyNVmNqc1sceYBGhkPIHQ3sd0Htl6YrI",
    description: "Ok no shade I love tarot it's so fun, but...let's be honest.",
    name: "Tarot Deck",
    price: 6900,
    quantity: 20,
    user_id: merchant_2.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1lGJZHw9o_SwyVNxB3DetT9_TSRduOwmV",
    description: "For when you want to display a tasteful tarot deck in your scandinavian ispired home.",
    name: "Minimalist Tarot Deck",
    price: 19900,
    quantity: 20,
    user_id: merchant_2.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=176U7vkzfCC98CprC3-OmeoLyxd9xDGEw",
    description: "You should buy 100, then get 10 friends to buy 100 and then you will be rich!",
    name: "Rodan & Fields Moisturizer",
    price: 4900,
    quantity: 1500,
    user_id: merchant_1.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1nApxEpJ9YFfzKb5h2qwWHXwm4zI4Rwt2",
    description: "This supplement will actually teleport you!",
    name: "Perfect Attendance Supplement",
    price: 9900,
    quantity: 10,
    user_id: merchant_1.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1LM3TxMujBDRc_auqKOn1lFu8nHkHX_7E",
    description: "Essential oils for your animals.",
    name: "Paw Balm",
    price: 9900,
    quantity: 20,
    user_id: merchant_1.id,
  },
  {
    photo_url: "https://drive.google.com/uc?id=1cQgTUiXOo0GMfbviBVLw_1iIBz2zoIqN",
    description: "It's totally the same as chocolate. You definitely won't taste a difference at all.",
    name: "Mushroom Cocoa",
    price: 9900,
    quantity: 20,
    user_id: merchant_2.id,
  },

]

failed_product_saves = []
products.each do |product|
  new_product = Product.new(product)
  if new_product.save
    new_product.categories << category_1
    puts "Saved #{product[:name]} Successfully"
  else
    failed_product_saves << product[:name]
  end
end

puts "Failed Product Saves #{failed_product_saves}"

fashion_products = Product.where(price: 9900)
fashion_products.each do |product|
  product.categories.clear
  product.categories << category_2
end
