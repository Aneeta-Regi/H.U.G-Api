
  module LessonHelper

  def self.test
    s3 = Aws::S3::Client.new(access_key_id: ResponseHelper::ACCESS_KEY_ID,
                             secret_access_key: ResponseHelper::SECRET_ACCESS_KEY,
                             region: ResponseHelper::REGION)

    bucket_index = []
    resp = s3.list_buckets
    p 'im here 4'
    resp.buckets.each do |bucket|
      bucket_index << {name: bucket.name}
    end
    p bucket_index

    s3.put_object(bucket: 'hug-api', key: "file3", body: "My first s3 object")

# Check the file exists
    resp = s3.list_objects_v2(bucket: 'hug-api')
    resp.contents.each do |obj|
      puts obj.key
    end

    bucket_index
  end

  def test
    LessonHelper.test
  end
end