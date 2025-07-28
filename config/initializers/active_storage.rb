# Configure Active Storage to use mini_magick instead of vips for image processing
Rails.application.configure do
  config.active_storage.variant_processor = :mini_magick
end
