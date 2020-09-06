class Post < ApplicationRecord
  has_rich_text :content

  validates :title, length: { maximum: 32 },presence: true
  validate :validate_content_attachable_byte_size
  validate :validate_content_length


  MAX_CONTENT_LENGTH = 150
  ONE_KILOBYTE = 1024
  MEGA_BYTES = 4
  MAX_CONTENT_ATTACHABLE_BYTE_SIZE = MEGA_BYTES * 1_000 * ONE_KILOBYTE

  private

  def  validate_content_attachable_byte_size
    content.body.attachables.grep(ActiveStorage::Blob).each do |attachable|
      if attachable.byte_size > MAX_CONTENT_ATTACHABLE_BYTE_SIZE
          errors.add(
            :base,
            :max_content_attachable_byte_size_is_too_big,
            max_mega_bytes: MEGA_BYTES,
            max_content_attachable_byte_size: MAX_CONTENT_ATTACHABLE_BYTE_SIZE,
            size: attachable.byte_size
          )
      end
    end
    # size = content.body.attachables.grep(AciveStorage::Blob).first.byte_size
    # if size > MAX_ATTACHABLE_SIZE
    #   errors.add(
    #     :content,
    #     :too_learge,
    #     max_content_attachable_byte_size: MAX_CONTENT_ATTACHABLE_BYTE_SIZE,
    #     size: size
    #   )
    # end
  end

  def validate_content_length
    length = content.to_plain_text.length
    if length > MAX_CONTENT_LENGTH
      errors.add(
        :content,
        :too_long,
        max_content_length: MAX_CONTENT_LENGTH,
        length: length
      )
    end
  end

end
