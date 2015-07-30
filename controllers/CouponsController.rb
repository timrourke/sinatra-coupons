class CouponsController < ApplicationController

	get '/' do
		@coupons = Coupons.all
		erb :'coupons/coupons', :locals => {'body_class' => 'coupon--all'}
	end

	get '/new' do 
		erb :'coupons/coupon_new', :locals => {'body_class' => 'coupon--single'}
	end

	get '/edit/:id' do
		@coupon = Coupons.find(params[:id])
		erb :'coupons/coupon_edit', :locals => {'body_class' => 'coupon--single'}
	end

	get '/:id' do
		@coupon = Coupons.find(params[:id])
		erb :'coupons/coupon_single', :locals => {'body_class' => 'coupon--single'}
	end

	get '/delete/:id' do
		@coupon = Coupons.find(params[:id])
		if @coupon.destroy
			redirect '/coupons', :locals => {'body_class' => 'coupon--single'}
		else
			redirect back
		end
	end

	post '/new' do
		@filename = params[:coupon_image][:filename]
		file = params[:coupon_image][:tempfile]

		@coupon = Coupons.new
		@coupon.title = params[:coupon_title]
		@coupon.description = params[:coupon_description]
		@coupon.discount = params[:coupon_discount]
		@coupon.expiration_date = params[:coupon_expiration_date]
		@coupon.vendor = params[:coupon_vendor]
		@coupon.img_url = '/images/coupon_uploads/' + @filename

		File.open("public/images/coupon_uploads/#{@filename}", "wb") do |f|
	    f.write(file.read)
	  end
		if @coupon.save
			redirect '/coupons/' + @coupon.id.to_s
		else
			redrect back
		end
	end

	post '/edit' do
		@coupon = Coupons.find(params[:coupon_id])
		@coupon.title = params[:coupon_title]
		@coupon.description = params[:coupon_description]
		@coupon.discount = params[:coupon_discount]
		@coupon.expiration_date = params[:coupon_expiration_date]
		@coupon.vendor = params[:coupon_vendor]

		if (params[:coupon_image])
			@filename = params[:coupon_image][:filename]
			file = params[:coupon_image][:tempfile]
			@coupon.img_url = '/images/coupon_uploads/' + @filename

			File.open("public/images/coupon_uploads/#{@filename}", "wb") do |f|
		    f.write(file.read)
		  end
		else
			@coupon.img_url = params[:coupon_img_url]
		end

		if @coupon.save
			redirect '/coupons/' + @coupon.id.to_s
		else
			redrect back
		end
	end

end
