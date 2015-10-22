class PhotosController < ApplicationController
  

  def index
  	@user = User.find(params[:id])
  end

  def map
  	picture = Picture.find(params[:id])

 	# EXIFR::JPEG.new('IMG_6841.JPG').gps?                # => true
	# EXIFR::JPEG.new('IMG_6841.JPG').gps                 # => [37.294112,-122.789422]
	# EXIFR::JPEG.new('IMG_6841.JPG').gps_lat             # => 37.294112
	# EXIFR::JPEG.new('IMG_6841.JPG').gps_lng             # =>-122.789422

	a = EXIFR::JPEG.new("gogoapp.me/upload/19-09-2014-1411113187.jpg")

	if a.exif?

		gon.lat = a.exif[0].gps_latitude[0].to_f + (a.exif[0].gps_latitude[1].to_f / 60) + (a.exif[0].gps_latitude[2].to_f / 3600)
		gon.lng = a.exif[0].gps_longitude[0].to_f + (a.exif[0].gps_longitude[1].to_f / 60) + (a.exif[0].gps_longitude[2].to_f / 3600)
		gon.lng = gon.lng * -1 if a.exif[0].gps_longitude_ref == "W"   # (W is -, E is +)
		gon.lat = gon.lat * -1 if a.exif[0].gps_latitude_ref == "S"      # (N is +, S is -)

	end	

  end	

end
