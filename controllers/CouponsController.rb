class CouponsController < ApplicationController

	get '/' do
		@coupons = Coupons.all
		erb :'coupons/coupons', :locals => {:coupons => @coupons}
	end

	get '/new' do 
		erb :'coupons/coupon_new'
	end

	get '/edit/:id' do
		@coupon = Coupons.find(params[:id])
		erb :'coupons/coupon_edit', :locals => {:coupon => @coupon}
	end

	get '/:id' do
		@coupon = Coupons.find(params[:id])
		erb :'coupons/coupon_single', :locals => {:coupon => @coupon}
	end

	get '/delete/:id' do
		@coupon = Coupons.find(params[:id])
		if @coupon.destroy
			redirect '/coupons'
		else
			redirect back
		end
	end

	post '/new' do
		create(params)
	end

	post '/edit' do
		puts params[:coupon_id]
		edit(params[:coupon_id])
	end

	def create(params)
		@coupon = Coupons.new
		@coupon.title = params[:coupon_title]
		@coupon.description = params[:coupon_description]
		@coupon.discount = params[:coupon_discount]
		@coupon.expiration_date = params[:coupon_expiration_date]
		@coupon.vendor = params[:coupon_vendor]
		@coupon.img_url = params[:coupon_img_url]
		if @coupon.save
			redirect '/coupons/' + @coupon.id.to_s
		else
			redirect back
		end
	end

	def edit(id)
		@coupon = Coupons.find(id)
		@coupon.title = params[:coupon_title]
		@coupon.description = params[:coupon_description]
		@coupon.discount = params[:coupon_discount]
		@coupon.expiration_date = params[:coupon_expiration_date]
		@coupon.vendor = params[:coupon_vendor]
		@coupon.img_url = params[:coupon_img_url]
		if @coupon.save
			redirect '/coupons/' + @coupon.id.to_s
		else
			redrect back
		end
	end

end
