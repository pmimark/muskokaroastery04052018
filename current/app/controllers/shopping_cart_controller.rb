class ShoppingCartController < ApplicationController
    skip_before_action :verify_authenticity_token

  def check_promo
    @promo_discount = Discount.where({ :code => params[:code] }).first
    if @promo_discount && @promo_discount.expires_at > Time.now
      @cart.set_promo_discount(@promo_discount.id)
    end

    redirect_to shop_checkout_path
  end

  def remove_item
    product = Product.find(params[:product_id])
    @item_id = @cart.remove_product(product, params[:option], params[:flavour])

    respond_to do |format|
      format.html { redirect_back_or_default(shop_checkout_path) }
      format.js
    end
  end

  def one_more_item
    product = Product.find(params[:id])
    @cart.one_more(product)

    render :partial => "checkout_order"
  end

  def one_less_item
    product = Product.find(params[:id])
    @cart.one_less(product)

    render :partial => "checkout_order"
  end

  def add_discount
    @discount = Discount.where(:name => params[:code]).first
    if @discount && @discount.expires_at >= Time.now
      @cart = find_cart
      @cart.set_promo_discount(@discount.percentage, @discount.id)
    end

    redirect_to shop_checkout_path
  end

  def update_totals
    update_cart_quantities
    respond_to do |format|
      format.html { redirect_to_back(products_path) }
      format.js
    end
  end

  def order_review_update_totals
    update_cart_quantities
    find_estimated_country

    respond_to do |format|
      format.html { redirect_to_back(shop_checkout_path) }
      format.js
    end
  end

  def shopping_cart
    find_cart
  end

  def empty_cart
    session[:cart] = nil
    find_estimated_country

    respond_to do |format|
      format.html { redirect_to_back(products_path) }
      format.js
    end
  end

  def review_order
    find_estimated_country
    @order = Order.new
    @order.country = current_user.country if current_user
    @order.shipping_country = current_user.shipping_country if current_user
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def checkout
    update_cart_quantities
    find_estimated_country
    @order = Order.new
    @order.country = current_user.country if current_user
    @order.shipping_country = current_user.shipping_country if current_user
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def cancel_pay_now
    session[:order] = nil
    redirect_to '/shop/checkout'
  end

  def place_order

    @order = Order.new(order_params)

    if @order.billing_same_as_shipping
      @order.shipping_country = @order.country
    end

    if @order.save
      if @cart.items.first.as_json['subscription'].present?
       @subscription_name = @cart.items.first.as_json['subscription']["subscription_name"]
       @subscription_period = @cart.items.first.as_json['subscription']["subscription_period"].to_i
       @subscription_date = @cart.items.first.as_json['subscription']["subscription_date"]
       Subscription.create(name: @subscription_name, period: @subscription_period, effective_date: @subscription_date, status: "Pending", order_id: @order.id, code: SecureRandom.hex(4), user_id: current_user.try(:id))
      end
      @cart.items.each do |item|
        line_item = LineItem.new
        line_item.product_id = item.product.id
        line_item.order_id = @order.id
        line_item.quantity = item.quantity
        line_item.item_price = item.unit_price
        line_item.item_name = item.name
        line_item.item_option = item.option
        line_item.item_flavour = item.flavour
        line_item.save
      end
      @order.discount_percentage = @cart.promo_discount
      @order.discount_price = @cart.promo_discount_price
      @order.order_status_id = OrderStatus.where({ :name => "pending payment" }).first.id
      @order.save_shipping_costs # save out total calculations
      @order.save
      session[:cart] = nil # zero out shopping cart session

      # Check if user opted-in to newsletter and signup through Mailchimp's API if true.
      if @order.include_in_mailinglist
        # h = Hominid::API.new(Settings.mailchimp_api_key)
        # list_id = h.find_list_id_by_name(Settings.mailchimp_list_name)
        # # MailChimp API v1.3 method listSubscribe(string apikey, string id, string email_address, array merge_vars, string email_type, bool double_optin, bool update_existing, bool replace_interests, bool send_welcome)
        # h.list_subscribe(list_id, @order.email, { 'FNAME' => @order.split_name.first, 'LNAME' => @order.split_name.last }, 'html', false, true, true, false)

        api = Mailchimp::API.new(Settings.mailchimp_api_key)
        api.listSubscribe(id: Settings.mailchimp_list_id, email_address: params[:email_address])
      end

      respond_to do |format|
        format.html { redirect_to shop_submit_to_paypal_path(@order.id) }
        format.js
      end
    else
      render :action => "checkout"
    end
  end

  def submit_to_paypal
    @order = Order.find(params[:id])
  end

  def thankyou
    @reference_number = params[:order_id]
    if params[:subscription_code].present?
      @subscription = Subscription.find_by_code(params[:subscription_code])
      @subscription.status = "Completed"
      @subscription.save
      PaymentNotification.create!(:order_id => @subscription.order_id, :status => @subscription.status)
      if session[:cart]
         session[:cart] = nil

      end
      if session[:order]
        session[:order] = nil
      end
    end
  end
  
  

  private

  def update_cart_quantities
    if params[:subscription_data].present?
      if params[:subscription_data]['subscription_name'].present?
        params[:subscription_data].each_pair do |key, value|
          @cart.update_item_name(key, value)
          break
        end
      elsif params[:subscription_data]['subscription_period'].present?
        params[:subscription_data].each_pair do |key, value|
          @cart.update_item_period(key, value)
          break
        end
      elsif params[:subscription_data]['subscription_date'].present?
        params[:subscription_data].delete("subscription_period")
        params[:subscription_data].each_pair do |key, value|
          @cart.update_item_date(key, value)
          break
        end
      end
    elsif params[:items]
      if params["items"].keys.present?
        # params["items"].keys.each do 
        params[:items].each do |m| 
          m[1].each do |n|
            arr = n.flatten
            # if arr.first == "Additional Items"
            if arr[0] == "Additional Items"
              hash = arr[1]
              params[:item] = Hash[*hash.first]
              params[:item].each_pair do |key, value|
                @cart.items.each do |item|
                  if item.item_id ==  key && item.as_json['subscription']=="none"
                    if item.quantity != value
                      item.change_quantity(value.to_i)
                    end
                  end
                end
                # @cart.update_item_quantity(key, value.to_i)  
              end
            end
            if arr[0] == "Subscription Items"
              hash = arr[1]
              params[:item] = Hash[*hash.first]
              params[:item].each_pair do |key, value|
                @cart.items.each do |item|
                  if item.item_id ==  key && item.as_json['subscription']['subscription_name'].present?
                    if item.as_json['subscription']['subscription_name'] == arr[1].values.last
                      if item.quantity != value
                        item.change_quantity(value.to_i)
                      end
                    end
                  end
                end
                # @cart.update_item_quantity(key, value.to_i)  
              end
            end
          end
        end
        # end 
      else
        params[:items].each_pair do |key, value|
          @cart.update_item_quantity(key, value)
        end
      end
    end
  end

  def find_estimated_country
    if client_country_code == "CA"
      @estimated_country = "Canadian"
    elsif client_country_code == "US"
      @estimated_country = "United States"
    else
      @estimated_country = "International"
    end
  end


  private

  def order_params
    params.require(:order).permit(:email, :address, :city, :province, :country,
      :postal, :phone, :total, :order_status_id, :purchased_at, :subtotal,
      :shipping_fees, :shipping_name, :free_shipping, :discount_percentage,
      :discount_price,
      :billing_same_as_shipping, :shipping_address, :shipping_city,
      :shipping_province, :shipping_country, :shipping_postal, :shipping_notes,
      :address_optional, :company, :shipping_address_optional, :shipping_phone,
      :name, :include_in_mailinglist)
  end

end
