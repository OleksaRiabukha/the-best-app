module UploadImage
  def self.image_path
    Rails.root.join('spec', 'support', 'assets', 'res3.jpg')
  end

  def self.restaurant_image
    Rack::Test::UploadedFile.new(image_path, 'image/jpg')
  end
end
