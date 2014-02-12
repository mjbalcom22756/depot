require 'test_helper'

class ProductTest < ActiveSupport::TestCase
test "product attributes must not be empty" do
  product=Product.new
  assert product.invalid?
  assert product.errors[:title].any?
  assert product.errors[:decription].any?
  assert product.errors[:price].any?
  assert product.errors[:image_url].any?
end

test "product price must be a positive" do
	product=Product.new(title:    "My Book Title",
		decription:"yyy", image_url: "zzz.jpg")
product.price = -1
assert product.invalid?
assert_equal ["must be greater than or equal to 0.01"],
  product.errors[:price]
product.price = 1
assert product.valid?
end

def new_product(image_url)
	Product.new(title:     "My Book Title",
	decription "yyy"
	price: 1,
	image_url: image_url)
end

test "image_url" do 
 ok = %w{fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif}
 bad = %w{fred.doc fred.gif/more fred.gif.more}
 ok.each do |name|
 assert new_product(name).valid?, "#{name} should be valid"
 end
 bad.each do |name|
 assert new_product(name).invalid?, "#{name} shouldn't be valid"
  end
 end
		

test  "product is not valid without a unique title - 118n" do

  product = Product.new(title:      products(:ruby).title,
				decription: "yyy",
				price:      1,
				image_url:     "fred.gif")
assert product.invalid?
assert_equal [I18n.translate('errors.messages.taken')],product.errors[:title]
end
