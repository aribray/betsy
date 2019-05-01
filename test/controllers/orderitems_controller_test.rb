require "test_helper"

describe OrderitemsController do
  it "should get edit" do
    get orderitems_edit_url
    value(response).must_be :success?
  end

  it "should get update" do
    get orderitems_update_url
    value(response).must_be :success?
  end

end
