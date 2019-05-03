require "test_helper"

describe ProductsController do
  let(:existing_product) { products(:turtleneck) }

  it "should get index" do
    get products_path

    must_respond_with :success
  end

  describe "show" do
    it "should be OK to show an existing, valid book" do
      valid_product_id = existing_product.id

      get product_path(valid_product_id)

      must_respond_with :success
    end

    it "should give a flash notice instead of showing a non-existant, invalid product" do
      product = existing_product
      invalid_product_id = product.id
      product.destroy

      get product_path(invalid_product_id)

      must_respond_with :not_found
      expect(flash[:error]).must_equal "Could not find product with id: #{invalid_product_id}"
    end
  end

  # it "should get new" do
  #   get products_new_url
  #   value(response).must_be :success?
  # end

  describe "create" do
    describe "logged in users" do
      before do
        perform_login(users(:dee))
      end

      it "will save a new book and redirect if given valid inputs" do
        input_title = "Practical Object Oriented Programming in Ruby"
        input_author = "Sandi Metz"
        input_description = "A look at how to design object-oriented systems"
        test_input = {
          "book": {
            title: input_title,
            author_id: Author.create(name: input_author).id,
            description: input_description,
          },
        }

        expect {
          post books_path, params: test_input
        }.must_change "Book.count", 1

        new_book = Book.find_by(title: input_title)
        expect(new_book).wont_be_nil
        expect(new_book.title).must_equal input_title
        expect(new_book.author.name).must_equal input_author
        expect(new_book.description).must_equal input_description

        must_respond_with :redirect
      end
      it "will give a 400 error with invalid params" do
        input_title = ""
        input_author = "Sandi Metz"
        input_description = "A look at how to design object-oriented systems"
        test_input = {
          "book": {
            title: input_title,
            author_id: Author.create(name: input_author).id,
            description: input_description,
          },
        }

        expect {
          post books_path, params: test_input
        }.wont_change "Book.count"

        expect(flash[:title]).must_equal ["can't be blank"]
        must_respond_with :bad_request
      end
      it "will return a 400 with an invalid book" do
        input_title = ""
        input_author = "Sandi Metz"
        input_description = "A look at how to design object-oriented systems"
        test_input = {
          "book": {
            title: input_title,
            author_id: Author.create(name: input_author).id,
            description: input_description,
          },
        }

        expect {
          post books_path, params: test_input
        }.wont_change "Book.count"

        must_respond_with :bad_request
      end
    end

    describe "Not Logged in users (Guest Users)" do
      it "will redirect to some page if the user attempts to do this with any input" do
        input_title = "Practical Object Oriented Programming in Ruby"
        input_author = "Sandi Metz"
        input_description = "A look at how to design object-oriented systems"
        test_input = {
          "book": {
            title: input_title,
            author_id: Author.create(name: input_author).id,
            description: input_description,
          },
        }

        expect {
          post books_path, params: test_input
        }.wont_change "Book.count"

        new_book = Book.find_by(title: input_title)
        expect(new_book).must_equal nil

        must_respond_with :redirect
        must_redirect_to root_path
      end
    end
  end

  # it "should get edit" do
  #   get products_edit_url
  #   value(response).must_be :success?
  # end

  # it "should get update" do
  #   get products_update_url
  #   value(response).must_be :success?
  # end

  # it "should get retire" do
  #   get products_retire_url
  #   value(response).must_be :success?
  # end
end
