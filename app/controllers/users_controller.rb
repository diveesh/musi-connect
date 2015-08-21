class UsersController < ApplicationController
    def login
        if session[:curr_user_id] != nil
            redirect_to ({controller: "search", action: "lookup"})
        end
    end

    def post_login
        @user = User.find_by_login_name(params[:login_name])
        if @user != nil
            if @user.password_valid?(params[:password])
                session[:curr_user_id] = @user.id
                redirect_to ({controller: "search", action: "lookup"}) #, id: params[:id]
            else
                flash[:err] = "Username and password combination is incorrect"
                redirect_to ({action: "login"})
            end
        else
            flash[:err] = "Username not found"
            redirect_to ({action: "login"})
        end
    end

    def post_login_ajax
        @user = User.find_by_login_name(params[:login_name])
        if @user != nil
            if @user.password_valid?(params[:password])
                session[:curr_user_id] = @user.id
                render :body => '{"status": "SUCCESS", "message": "User logged in"}'
            else
                flash[:err] = "Username and password combination is incorrect"
                render :body => '{"status": "FAILURE", "message": "Username and password combination is incorrect"}'
            end
        else
            flash[:err] = "Username not found"
            render :body => '{"status": "FAILURE", "message": "Username not found"}'
        end
    end

    def display_profile
        if params[:id] != nil
            @id = params[:id]
            @user = User.find(params[:id])
        else
            if session[:curr_user_id] != nil
                @user = User.find(session[:curr_user_id])
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
                    puts skill.level, skill.instrument_id
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
        photo = params[:user][:picture]
        if photo != nil
            File.open(Rails.root.join('app', 'assets', 'images', photo.original_filename + user.login_name), 'wb') do |file|
                file.write(photo.read)
            end
            user.photo_file_name = photo.original_filename + user.login_name
        end
        desc = params[:user][:description]
        if desc != nil
            user.description = desc
        end
        puts user.photo_file_name
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
                if photo.original_filename[-3..-1] != 'png' && photo.original_filename[-3..-1] != 'jpg' && photo.original_filename[-3..-1] != 'gif'
                    flash[:err] = "Photo must be of jpg, png or gif format."
                    redirect_to({action: "new"})
                    return
                end
                File.open(Rails.root.join('app', 'assets', 'images', photo.original_filename + new_user.login_name), 'wb') do |file|
                    file.write(photo.read)
                end
                new_user.photo_file_name = photo.original_filename + new_user.login_name
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

    def get_picture
        if params[:id] != nil
            @user = User.find(params[:id])
            render :json => @user
        end
    end
end
