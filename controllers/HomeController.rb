class HomeController < ApplicationController
	get '/' do
		erb :index, :locals => {'body_class' => 'home'}
	end
end