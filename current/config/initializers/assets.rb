# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( meta.js google_maps.js connect_carousal.js admin.js ie.js product_details.js select_skin.js validate_add_to_cart.js validate_contact.js validate_order.js validate_user.js validate_shopping_cart.js admin.css ie.css )

Rails.application.config.assets.precompile += %w( muskoka_roastery_logo.svg )
