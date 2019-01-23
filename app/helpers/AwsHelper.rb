
module AwsHelper

  # @note Upload image to AWS S3
  # @param [ActionDispatch::Http::UploadedFile] media_parameter file - uploaded image
  # @param [AppAwsSetting] aws_settings AWS S3 configuration which will be used for image upload
  # bucket = set_bucket(aws_settings)
  # Aws.config = {
  #   access_key_id: ResponseHelper::ACCESS_KEY_ID,
  #   secret_access_key: ResponseHelper::SECRET_ACCESS_KEY,
  #   region: ResponseHelper::REGION
  # }

  # media_parameter.is_a? String ?
  #                           obj.put(body: Base64.decode64(media_parameter.sub(/data:image\/.*;base64,/, '')), acl: 'public-read') :
  #                           obj.put(body: media_parameter.read, acl: 'public-read')

  # bucket = Aws::S3::Resource.new.bucket('hug-api')

  #  obj = s3.object("images/#{SecureRandom.uuid}#{File.extname(media_parameter.respond_to?(:original_filename) ? media_parameter.original_filename : '')}")

  def self.aws_upload_image(media_parameter)
    s3 = Aws::S3::Client.new(access_key_id:  ENV['S3_ACCESS_KEY_ID'],
                             secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
                             region: ENV['REGION'])
    f_name = SecureRandom.uuid
    s3.put_object(bucket: 'hug-api', key: 'images/' + f_name, body: Base64.decode64(media_parameter.sub(/data:image\/.*;base64,/, '')), acl: 'public-read')
    public_url = ResponseHelper::S3_URL_BASE + f_name
    public_url
  end
end
