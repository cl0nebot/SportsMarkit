module Images
  extend ActiveSupport::Concern
  
  TEAM_PHOTO_PLACEHOLDER = "http://cache3.asset-cache.net/gc/187840132-soccer-team-celebrates-gettyimages.jpg?v=1&c=IWSAsset&k=2&d=ZQZzMJ8a0ONoFbdvawrO3ZhmEQ83NvPgJ9Rxm5hkoQw%3d"
  SCHOOL_PHOTO_PLACEHOLDER = "http://www.carlostoxtli.com/wp-content/uploads/2014/05/placeholder15.png"
  LEAGUE_PHOTO_PLACEHOLDER = "http://www.hsph.harvard.edu/niehs/wp-content/themes/hsph/images/placeholder.jpg"
  FACILITY_PHOTO_PLACEHOLDER = "http://www.carlostoxtli.com/wp-content/uploads/2014/05/placeholder15.png"
  USER_PHOTO_PLACEHOLDER = "http://www.hsph.harvard.edu/niehs/wp-content/themes/hsph/images/placeholder.jpg"
  CLUB_PHOTO_PLACEHOLDER = "http://cache3.asset-cache.net/gc/187840132-soccer-team-celebrates-gettyimages.jpg?v=1&c=IWSAsset&k=2&d=ZQZzMJ8a0ONoFbdvawrO3ZhmEQ83NvPgJ9Rxm5hkoQw%3d"
  MODELS = ["User", "Team", "School", "Facility", "League", "Club"]
  GIRL_PHOTOS = ["http://goesphotography.com/Goes_Photography/Headshots_files/hs-black-girl.jpg", "https://brendaladdphoto.files.wordpress.com/2013/04/castillo_7819_5x7_brendaladdphoto.jpg", "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTlSwnZugSuK1RrId4tWBK_yJc2fcPrHkYGtuK49086-5DZ0Q6k","http://darkroom.baltimoresun.com/wp-content/uploads/2013/11/PPC-ph-ho-F-girlsoccer-res-.jpg", "http://photos.nomadicsamuel.com/Other/Korean-Sports-Day-Photo-Essay/i-TsfxSK8/0/1000x1000/Sports-Day-Korean-Elementary-1000x1000.jpg", "https://s-media-cache-ak0.pinimg.com/736x/d9/a8/70/d9a870c41fe2248162ab69d536bc5e72.jpg"]
  BOY_PHOTOS = ["http://i2.wp.com/nicolassage.com/wp-content/uploads/2014/09/best-youth-headshot-outdoors-4568_90.jpg", "http://cache4.asset-cache.net/gc/10138419-portrait-of-black-teen-gettyimages.jpg?v=1&c=IWSAsset&k=2&d=gLQEWLvlJmeHXzRqEa9Tapwx3W9uHQzPd%2fM0wTMWB4ZUGSo%2bLMj%2fynju4LN5C1N7","http://cache4.asset-cache.net/gc/84438992-high-school-football-player-gettyimages.jpg?v=1&c=IWSAsset&k=2&d=rAohnJY2e8reQjLf5jGPispIvThBSMyuprH8U80m8TL9bhUeSDGX3hQfxapZn7G6","http://nnimgt-a.akamaihd.net/transform/v1/crop/frm/storypad-V5xwF4ZcQwDCAHfvnxcCyD/96862f38-e241-454b-999f-c06cc50af654.JPG/r0_0_4423_2949_w1200_h678_fmax.jpg",  "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSIyB7D4fYD9bnBEKAFQpJw-B9Mwc468WjSMUo92TpFNj25pQqkUQ","https://s-media-cache-ak0.pinimg.com/236x/e2/64/f7/e264f7b9333d1dff056a96f3be945b4e.jpg","https://s-media-cache-ak0.pinimg.com/736x/8b/f8/a9/8bf8a945612ac160116ef1c496574d76.jpg", "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQm3wNbg-z3vjAoDRSBGp3acPFsXs6P-Ho-emy_RFzlzqdtwZW7", ]
 

  included do
    has_many :photos, as: :photo_owner
    accepts_nested_attributes_for :photos
    
    has_many :profile_pictures, dependent: :destroy, as: :profile_picture_owner
    accepts_nested_attributes_for :profile_pictures, :reject_if => :all_blank, :allow_destroy => true
  end

  def main_photo
    photos.main.first_or_initialize
  end
  
  def image
    MODELS.each do |model|
      if Photo.where(photo_owner_id: id, photo_owner_type: model).present?
        Photo.where(photo_owner_id: id, photo_owner_type: model).last.image
      else
        eval("#{model.upcase}_PHOTO_PLACEHOLDER")
      end
    end
  end
  
  def avatar
    if self.class.to_s == "User"
      if user_profile_pictures.last.try(:id).blank?
        if self.profile.sex == "Female" #TODO only do this in development
          GIRL_PHOTOS.sample
        elsif self.profile.sex == "Male" #TODO only do this in development
          BOY_PHOTOS.sample
        end
        #"https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Color_icon_gray_v2.svg/2000px-Color_icon_gray_v2.svg.png"
      else
        user_profile_pictures.last.photo
      end
    elsif self.class.to_s == "UserlessRole"
      "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Color_icon_gray_v2.svg/2000px-Color_icon_gray_v2.svg.png"
    elsif self.class.to_s == "School"
      if profile_pictures.last.try(:id).blank?
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Color_icon_gray_v2.svg/2000px-Color_icon_gray_v2.svg.png"
      else
        profile_pictures.last.photo
      end
    elsif self.class.to_s == "League"
      if profile_pictures.last.try(:id).blank?
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Color_icon_gray_v2.svg/2000px-Color_icon_gray_v2.svg.png"
      else
        profile_pictures.last.photo
      end
    elsif self.class.to_s == "Team"
      if profile_pictures.last.try(:id).blank?
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Color_icon_gray_v2.svg/2000px-Color_icon_gray_v2.svg.png"
      else
        profile_pictures.last.photo
      end
    elsif self.class.to_s == "Facility" 
      if profile_pictures.last.try(:id).blank?
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Color_icon_gray_v2.svg/2000px-Color_icon_gray_v2.svg.png"
      else
        profile_pictures.last.photo
      end
    elsif self.class.to_s == "Club"
      if profile_pictures.last.try(:id).blank?
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Color_icon_gray_v2.svg/2000px-Color_icon_gray_v2.svg.png"
      else
        profile_pictures.last.photo
      end
    end
  end
  
  
  
  
  
  
end