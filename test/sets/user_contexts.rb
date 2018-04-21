module Contexts
  module UserContexts
    def create_users
      @batoul_user  = FactoryBot.create(:user)
      @preetha_user = FactoryBot.create(:user, username: "preethag", phone: "666-111-2222")
      @osama_user   = FactoryBot.create(:user, username: "oali", role: "instructor")
    end

    def delete_users
      @batoul_user.delete
      @preetha_user.delete
      @osama_user.delete
    end

    def create_more_users
      @samiha_user     = FactoryBot.create(:user, username: "sam", role: "instructor")
      @sadeka_user     = FactoryBot.create(:user, username: "sad", role: "instructor")
      @sufia_user      = FactoryBot.create(:user, username: "suf", role: "instructor")
      @iram_user       = FactoryBot.create(:user, username: "ir", role: "instructor")
      @ahmed_user      = FactoryBot.create(:user, username: "a", role: "instructor")
      @mohammed_user   = FactoryBot.create(:user, username: "moh", role: "instructor")
      @daniel_user     = FactoryBot.create(:user, username: "dan", role: "instructor")
      @nouser_user     = FactoryBot.create(:user, username: "nouser", role: "instructor")
    end

    def delete_more_users
      @samiha_user.delete    
      @sadeka_user.delete
      @sufia_user.delete
      @iram_user.delete
      @ahmed_user.delete
      @mohammed_user.delete
      @daniel_user.delete
      @noclue_user.delete
    end

    def create_family_users
      @siddiq_user = FactoryBot.create(:user, username: "siddiq", role: "parent")
      @basak_user  = FactoryBot.create(:user, username: "basak", role: "parent")
      @khan_user   = FactoryBot.create(:user, username: "khan", role: "parent")
      @nofam_user  = FactoryBot.create(:user, username: "nofam", role: "parent")

    end

    def delete_family_users
      @siddiq_user.delete
      @basak_user.delete
      @khan_user.delete
      @nofam_user.delete
    end
  end
end