# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160425171337) do

  create_table "backgrounds", force: :cascade do |t|
    t.integer  "section_id",         limit: 4
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "backgrounds", ["section_id"], name: "index_backgrounds_on_section_id", using: :btree

  create_table "blog_categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "slug",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",    limit: 4,     default: 0
  end

  add_index "blog_categories", ["position"], name: "index_blog_categories_on_position", using: :btree
  add_index "blog_categories", ["slug"], name: "index_blog_categories_on_slug", using: :btree

  create_table "blog_posts", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "slug",             limit: 255
    t.text     "body",             limit: 65535
    t.string   "keywords",         limit: 255
    t.string   "description",      limit: 255
    t.integer  "blog_category_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_draft",                       default: false
  end

  add_index "blog_posts", ["blog_category_id"], name: "index_blog_posts_on_blog_category_id", using: :btree
  add_index "blog_posts", ["slug"], name: "index_blog_posts_on_slug", using: :btree

  create_table "discounts", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "slug",       limit: 255
    t.integer  "percentage", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "expires_at"
    t.boolean  "disabled",               default: false
  end

  create_table "discounts_products", id: false, force: :cascade do |t|
    t.integer "discount_id", limit: 4, null: false
    t.integer "product_id",  limit: 4, null: false
  end

  add_index "discounts_products", ["discount_id"], name: "index_discounts_products_on_discount_id", using: :btree
  add_index "discounts_products", ["product_id"], name: "index_discounts_products_on_product_id", using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.string   "slug",                    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment_file_name",    limit: 255
    t.string   "attachment_content_type", limit: 255
    t.integer  "attachment_file_size",    limit: 4
    t.datetime "attachment_updated_at"
  end

  create_table "dynamic_settings", force: :cascade do |t|
    t.string   "nice_name",  limit: 255
    t.string   "name",       limit: 255
    t.text     "value",      limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "features", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.text     "body",                limit: 65535
    t.string   "link_name",           limit: 255
    t.text     "link_url",            limit: 65535
    t.string   "link_type",           limit: 255
    t.integer  "page_id",             limit: 4
    t.integer  "product_id",          limit: 4
    t.string   "photo_file_name",     limit: 255
    t.string   "photo_content_type",  limit: 255
    t.integer  "photo_file_size",     limit: 4
    t.datetime "photo_updated_at"
    t.boolean  "is_homepage_feature"
    t.integer  "position",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active",                         default: false
  end

  add_index "features", ["page_id"], name: "index_features_on_page_id", using: :btree
  add_index "features", ["position"], name: "index_features_on_position", using: :btree
  add_index "features", ["product_id"], name: "index_features_on_product_id", using: :btree

  create_table "feedbacks", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "email",                  limit: 255
    t.text     "website",                limit: 65535
    t.text     "comment",                limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "include_in_mailinglist",               default: false
  end

  create_table "images", force: :cascade do |t|
    t.string   "caption",            limit: 255
    t.text     "link_url",           limit: 65535
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "product_id",   limit: 4
    t.integer  "quantity",     limit: 4
    t.integer  "order_id",     limit: 4
    t.float    "item_price",   limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "item_name",    limit: 255
    t.string   "item_option",  limit: 255
    t.string   "item_flavour", limit: 255
  end

  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id", using: :btree
  add_index "line_items", ["product_id"], name: "index_line_items_on_product_id", using: :btree

  create_table "order_statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.string   "name",                      limit: 255
    t.string   "address",                   limit: 255
    t.string   "city",                      limit: 255
    t.string   "province",                  limit: 255
    t.string   "country",                   limit: 255
    t.string   "postal",                    limit: 255
    t.string   "phone",                     limit: 255
    t.string   "email",                     limit: 255
    t.float    "total",                     limit: 24
    t.integer  "order_status_id",           limit: 4
    t.datetime "purchased_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company",                   limit: 255
    t.string   "address_optional",          limit: 255
    t.string   "shipping_address",          limit: 255
    t.string   "shipping_address_optional", limit: 255
    t.string   "shipping_city",             limit: 255
    t.string   "shipping_province",         limit: 255
    t.string   "shipping_country",          limit: 255
    t.string   "shipping_postal",           limit: 255
    t.string   "shipping_notes",            limit: 255
    t.string   "shipping_phone",            limit: 255
    t.boolean  "billing_same_as_shipping",              default: true
    t.float    "shipping_rate",             limit: 24,  default: 0.0
    t.float    "subtotal",                  limit: 24,  default: 0.0
    t.float    "shipping_fees",             limit: 24,  default: 0.0
    t.boolean  "include_in_mailinglist",                default: false
    t.string   "shipping_name",             limit: 255, default: ""
    t.boolean  "free_shipping",                         default: false
    t.float    "discount_percentage",       limit: 24,  default: 0.0
    t.float    "discount_price",            limit: 24,  default: 0.0
  end

  add_index "orders", ["order_status_id"], name: "index_orders_on_order_status_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "slug",        limit: 255
    t.text     "body",        limit: 65535
    t.string   "keywords",    limit: 255
    t.string   "description", limit: 255
    t.integer  "section_id",  limit: 4
    t.integer  "position",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hidden",                    default: false
    t.text     "intro",       limit: 65535
  end

  add_index "pages", ["position"], name: "index_pages_on_position", using: :btree
  add_index "pages", ["section_id"], name: "index_pages_on_section_id", using: :btree
  add_index "pages", ["slug"], name: "index_pages_on_slug", using: :btree

  create_table "pages_products", id: false, force: :cascade do |t|
    t.integer "page_id",    limit: 4, null: false
    t.integer "product_id", limit: 4, null: false
  end

  add_index "pages_products", ["page_id"], name: "index_pages_products_on_page_id", using: :btree
  add_index "pages_products", ["product_id"], name: "index_pages_products_on_product_id", using: :btree

  create_table "payment_notifications", force: :cascade do |t|
    t.text     "params",         limit: 65535
    t.integer  "cart_id",        limit: 4
    t.integer  "order_id",       limit: 4
    t.string   "status",         limit: 255
    t.string   "transaction_id", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payment_notifications", ["cart_id"], name: "index_payment_notifications_on_cart_id", using: :btree
  add_index "payment_notifications", ["order_id"], name: "index_payment_notifications_on_order_id", using: :btree

  create_table "places", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "address",           limit: 255
    t.string   "city",              limit: 255
    t.string   "province",          limit: 255
    t.string   "country",           limit: 255
    t.string   "postal",            limit: 255
    t.string   "contact",           limit: 255
    t.string   "email",             limit: 255
    t.string   "phone",             limit: 255
    t.text     "website",           limit: 65535
    t.text     "notes",             limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude",          limit: 24
    t.float    "longitude",         limit: 24
    t.boolean  "gmaps",                           default: false
    t.text     "generated_address", limit: 65535
    t.text     "description",       limit: 65535
  end

  add_index "places", ["latitude"], name: "index_places_on_latitude", using: :btree
  add_index "places", ["longitude"], name: "index_places_on_longitude", using: :btree

  create_table "product_flavours", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "slug",         limit: 255
    t.text     "description",  limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_id",   limit: 4,     default: 6
    t.integer  "position",     limit: 4
    t.boolean  "out_of_stock",               default: false
  end

  add_index "product_flavours", ["position"], name: "index_product_flavours_on_position", using: :btree
  add_index "product_flavours", ["product_id"], name: "index_product_flavours_on_product_id", using: :btree
  add_index "product_flavours", ["slug"], name: "index_product_flavours_on_slug", using: :btree

  create_table "product_qualities", force: :cascade do |t|
    t.string  "name",  limit: 255
    t.string  "slug",  limit: 255
    t.string  "kind",  limit: 255
    t.integer "value", limit: 4
  end

  add_index "product_qualities", ["kind"], name: "index_product_qualities_on_kind", using: :btree
  add_index "product_qualities", ["slug"], name: "index_product_qualities_on_slug", using: :btree
  add_index "product_qualities", ["value"], name: "index_product_qualities_on_value", using: :btree

  create_table "product_types", force: :cascade do |t|
    t.string "name",        limit: 255
    t.string "slug",        limit: 255
    t.string "description", limit: 255
  end

  add_index "product_types", ["slug"], name: "index_product_types_on_slug", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",                         limit: 255
    t.string   "slug",                         limit: 255
    t.text     "body",                         limit: 65535
    t.float    "price",                        limit: 24,    default: 15.99
    t.string   "photo_file_name",              limit: 255
    t.string   "photo_content_type",           limit: 255
    t.integer  "photo_file_size",              limit: 4
    t.datetime "photo_updated_at"
    t.boolean  "is_active",                                  default: false
    t.integer  "size",                         limit: 4,     default: 400
    t.boolean  "option_ground",                              default: false
    t.boolean  "option_whole",                               default: false
    t.boolean  "option_ground_decaf",                        default: false
    t.boolean  "option_whole_decaf",                         default: false
    t.integer  "acidity",                      limit: 4,     default: 0
    t.integer  "roast",                        limit: 4,     default: 0
    t.integer  "product_type_id",              limit: 4
    t.string   "keywords",                     limit: 255
    t.string   "description",                  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",                     limit: 4,     default: 0
    t.integer  "body_quality",                 limit: 4,     default: 0
    t.boolean  "lists_all_flavours",                         default: false
    t.boolean  "include_flavour_descriptions",               default: false
    t.boolean  "include_graphs",                             default: true
    t.string   "per",                          limit: 255,   default: "per pkg."
    t.string   "price_alt_txt",                limit: 255,   default: "comes in 400g packages"
    t.boolean  "out_of_stock",                               default: false
    t.boolean  "is_special",                                 default: false
    t.boolean  "option_coffee_pods",                         default: false
  end

  add_index "products", ["is_active"], name: "index_products_on_is_active", using: :btree
  add_index "products", ["position"], name: "index_products_on_position", using: :btree
  add_index "products", ["product_type_id"], name: "index_products_on_product_type_id", using: :btree
  add_index "products", ["slug"], name: "index_products_on_slug", using: :btree

  create_table "sections", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "slug",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",    limit: 4,     default: 0
    t.integer  "page_id",     limit: 4
  end

  add_index "sections", ["page_id"], name: "index_sections_on_page_id", using: :btree
  add_index "sections", ["position"], name: "index_sections_on_position", using: :btree
  add_index "sections", ["slug"], name: "index_sections_on_slug", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255,   null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "shipping_rates", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "country_code", limit: 255
    t.float    "price",        limit: 24,  default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "free_price",   limit: 24,  default: 0.0
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "period",         limit: 4
    t.datetime "effective_date"
    t.string   "status",         limit: 255
    t.string   "code",           limit: 255
    t.integer  "order_id",       limit: 4
    t.integer  "user_id",        limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "user_sessions", force: :cascade do |t|
    t.string   "username",   limit: 255
    t.string   "password",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_sessions", ["username"], name: "index_user_sessions_on_username", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",                  limit: 255,                   null: false
    t.string   "email",                     limit: 255,                   null: false
    t.string   "crypted_password",          limit: 255,                   null: false
    t.string   "password_salt",             limit: 255,                   null: false
    t.string   "persistence_token",         limit: 255,                   null: false
    t.string   "single_access_token",       limit: 255,                   null: false
    t.string   "perishable_token",          limit: 255,                   null: false
    t.integer  "login_count",               limit: 4,     default: 0,     null: false
    t.integer  "failed_login_count",        limit: 4,     default: 0,     null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip",          limit: 255
    t.string   "last_login_ip",             limit: 255
    t.boolean  "su",                                      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin",                                default: false
    t.string   "address",                   limit: 255
    t.string   "city",                      limit: 255
    t.string   "province",                  limit: 255
    t.string   "country",                   limit: 255
    t.string   "postal",                    limit: 255
    t.string   "phone",                     limit: 255
    t.boolean  "billing_same_as_shipping",                default: true
    t.string   "shipping_address",          limit: 255
    t.string   "shipping_city",             limit: 255
    t.string   "shipping_province",         limit: 255
    t.string   "shipping_country",          limit: 255
    t.string   "shipping_postal",           limit: 255
    t.text     "shipping_notes",            limit: 65535
    t.string   "address_optional",          limit: 255
    t.string   "company",                   limit: 255
    t.string   "shipping_address_optional", limit: 255
    t.string   "shipping_phone",            limit: 255
    t.string   "name",                      limit: 255
    t.boolean  "include_in_mailinglist",                  default: false
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 255,   null: false
    t.integer  "item_id",    limit: 4,     null: false
    t.string   "event",      limit: 255,   null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object",     limit: 65535
    t.datetime "created_at"
  end

  add_index "versions", ["item_id"], name: "index_versions_on_item_id", using: :btree
  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
