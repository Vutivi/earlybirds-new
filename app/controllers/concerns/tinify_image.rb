require "tinify"
module TinifyImage
    extend ActiveSupport::Concern
    def tinify image
        Tinify.key = Rails.application.secrets.tiny_png_api_key
        source = Tinify.from_file(image)
        # resized = source.resize(
        #     method: "fit",
        #     width: 300,
        #     height: 200
        # )
        source.as_json['url']
    end

    def minify image
        image = MiniMagick::Image.new(image) do |b|
            b.resize "250x200"
            b.size 3451
        end
    end

end