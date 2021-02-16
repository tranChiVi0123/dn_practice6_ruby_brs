require "fileutils"

module Admin::BooksHelper
  def random_last_name_img img_name
    arr = img_name.split(".")
    ran_num = rand 1000..9999
    "#{arr[0] + ran_num.to_s}.#{arr[1]}"
  end

  def upload_img image, img_name
    uploaded_io = image
    dirname = "public/res"
    FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
    File.open(Rails.root.join("public", "res", img_name),
              "wb") do |file|
                file.write(uploaded_io.read)
              end
  end

  def convert_date date
    arr = date.split("-")
    Date.new(arr[0].to_i,
             arr[1].to_i,
             arr[2].to_i)
  end
end
