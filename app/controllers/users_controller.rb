class UsersController < ApplicationController

    def post_login_ajax
        @user = User.find_by_login_name(params[:login_name])
        if @user != nil
            if @user.password_valid?(params[:password])
                session[:curr_user_id] = @user.id
                render :body => '{"status": "SUCCESS", "message": "User logged in"}'
            else
                render :body => '{"status": "FAILURE", "message": "Username and password combination is incorrect"}'
            end
        else
            render :body => '{"status": "FAILURE", "message": "Username not found"}'
        end
    end

    def edit_account_info
        if session[:curr_user_id] != nil
            @user = User.find(session[:curr_user_id])
        else
            redirect_to({controller: "welcome", action: "index"})
        end
    end

    def display_profile
        if params[:id] != nil
            @id = params[:id]
            @user = User.find(params[:id])
            userInstrumentSkills = InstrumentSkill.where(:user_id => @user.id)
            @instruments = Array.new
            @instrumentLevelHash = Hash.new
            if userInstrumentSkills != nil
                userInstrumentSkills.each do |skill|
                    ins = Instrument.find(skill.instrument_id)
                    @instruments << ins.name
                    @instrumentLevelHash[ins.name.to_sym] = skill.level
                end
            end
            
        else
            if session[:curr_user_id] != nil
                @user = User.find(session[:curr_user_id])
                userInstrumentSkills = InstrumentSkill.where(:user_id => @user.id)
                @instruments = Array.new
                @instrumentLevelHash = Hash.new
                if userInstrumentSkills != nil
                    userInstrumentSkills.each do |skill|
                        ins = Instrument.find(skill.instrument_id)
                        @instruments << ins.name
                        @instrumentLevelHash[ins.name.to_sym] = skill.level
                    end
                end
            else
                redirect_to ({controller: "welcome", action: "index"})
            end
        end     
    end

    def logout
        session[:curr_user_id] = nil
        redirect_to ({controller: "welcome", action: "index"})
    end

    def new
    end

    def edit_profile
        if session[:curr_user_id] != nil
            @user = User.find(session[:curr_user_id])
            @instruments = Instrument.all
            @genres = Genre.all
            @interests = Interest.all
            @activities = Activity.all
            userInstrumentSkills = InstrumentSkill.where(:user_id => @user.id)
            if userInstrumentSkills != nil
                @instrumentLevelHash = Hash.new
                userInstrumentSkills.each do |skill|
                    @instrumentLevelHash[skill.instrument_id.to_s.to_sym] = skill.level
                end
            end
        else
            redirect_to({controller: "welcome", action: "index"})
        end
    end


    def update_profile
        user = User.find(session[:curr_user_id])
        if params[:instruments] != nil
            user.instruments = Array.new
            instruments = params[:instruments]
            instruments.each do |insId|
                level = params[("level_for_ins" + insId.to_s).to_sym]
                skillObject = InstrumentSkill.where(:user_id => user.id, :instrument_id => insId).first
                if skillObject != nil
                    skillObject.level = level
                else
                    InstrumentSkill.create(:user_id => user.id, :instrument_id => insId, :level => level)
                end
            end
        end
        
        if params[:genres] != nil
            user.genres = Array.new
            params[:genres].each do |id|
                user.genres << Genre.find(id)
            end
        end

        if params[:interests] != nil
            user.interests = Array.new
            params[:interests].each do |id|
                user.interests << Interest.find(id)
            end
        end

        if params[:activities] != nil
            user.activities = Array.new
            params[:activities].each do |id|
                user.activities << Activity.find(id)
            end
        end
        
        user.affiliation = params[:user][:affiliation]
        desc = params[:user][:description]
        if desc != nil
            user.description = desc
        end
        if !user.save()
            flash[:error_messages] = user.errors.full_messages
            redirect_to({action: "edit_profile"})
        else
            flash[:error_messages] = nil
            redirect_to({action: "display_profile"})
        end
        
    end

    def failure
    end

    def create
        existing_user = User.find_by_login_name(params[:user][:login_name])
        if existing_user == nil
            new_user = User.new()
            new_user.first_name = params[:user][:first_name]
            new_user.last_name = params[:user][:last_name]
            new_user.login_name = params[:user][:login_name]
            new_user.password = params[:user][:password]
            new_user.password_confirmation = params[:user][:confirm_password]
            new_user.email_address = params[:user][:email_address]
            photo = params[:user][:picture]
            if photo != nil
                if photo.original_filename[-3..-1] != 'png' && photo.original_filename[-3..-1] != 'jpg' && photo.original_filename[-4..-1] != 'jpeg'  && photo.original_filename[-3..-1] != 'gif'
                    flash[:err] = "Photo must be of jpg, png or gif format."
                    redirect_to({action: "new"})
                    return
                end
                obj = S3_BUCKET.objects['images/' + new_user.login_name + photo.original_filename]
                obj.write(
                  file: photo,
                  acl: :public_read
                )
                new_user.photo_file_name = obj.key
            end
            if !new_user.save()
                flash[:error_messages] = new_user.errors.full_messages
                redirect_to({action: "new"})
            else
                flash[:error_messages] = nil
                session[:curr_user_id] = new_user.id
                redirect_to ({action: "edit_profile"})  
            end      
        else
            flash[:err] = "That login name has already been taken. Please choose another one"
            redirect_to({action: "new"})
        end
    end

    def post_edit_user
        if session[:curr_user_id] != nil
            user = User.find(session[:curr_user_id])
            user.first_name = params[:user][:first_name]
            user.last_name = params[:user][:last_name]
            user.email_address = params[:user][:email_address]
            photo = params[:user][:picture]
            if photo != nil
                if photo.original_filename[-3..-1] != 'png' && photo.original_filename[-3..-1] != 'jpg' && photo.original_filename[-4..-1] != 'jpeg'  && photo.original_filename[-3..-1] != 'gif'
                    flash[:err] = "Photo must be of jpg, png or gif format."
                    redirect_to({action: "edit_account_info"})
                    return
                end
                obj = S3_BUCKET.objects['images/' + user.login_name + photo.original_filename]
                obj.write(
                  file: photo,
                  acl: :public_read
                )
                user.photo_file_name = obj.key
            end
            if !user.save()
                flash[:error_messages] = new_user.errors.full_messages
                redirect_to({action: "edit_account_info"})
            else
                flash[:error_messages] = nil
                redirect_to ({action: "display_profile"})  
            end
        else
            redirect_to({controller: "welcome", action: "index"})
        end
    end

    def get_picture
        if params[:id] != nil
            @user = User.find(params[:id])
            render :json => @user
        end
    end
end
