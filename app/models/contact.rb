class Contact < ActiveRecord::Base
validates :title, presence: true
validates :email, presence: true
validates :content, presence: true
end
