module UploadImage
  RESTAURANT_IMAGE_FILENAME = 'restaurant_placeholder_image.jpg'.freeze
  MENU_ITEM_IMAGE_FILENAME = 'menu_item_placeholder_image.jpg'.freeze

  def self.restaurant_image_path
    Rails.root.join('spec', 'support', 'assets', RESTAURANT_IMAGE_FILENAME)
  end

  def self.menu_item_image_path
    Rails.root.join('spec', 'support', 'assets', MENU_ITEM_IMAGE_FILENAME)
  end

  def self.upload_image(image_path)
    Rack::Test::UploadedFile.new(image_path, 'image/jpg')
  end
end
