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

    def display_profile
        if params[:id] != nil
            @id = params[:id]
            @user = User.find(params[:id])
        else
            if session[:curr_user_id] != nil
                @user = User.find(session[:curr_user_id])
            else
                redirect_to ({action: "login"})
            end
        end     
    end

    def logout
        session[:curr_user_id] = nil
        redirect_to ({action: "login"})
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
            @instrumentLevelHash = Hash.new
            userInstrumentSkills.each do |skill|
                puts skill.level, skill.instrument_id
                @instrumentLevelHash[skill.instrument_id.to_s.to_sym] = skill.level
            end
        else
            redirect_to({action: "login"})
        end
    end

    def setup
        if session[:curr_user_id] != nil
            @user = User.find(session[:curr_user_id])
            @instruments = Instrument.all
            @genres = Genre.all
            @interests = Interest.all
            @activities = Activity.all
        else
            redirect_to ({action: "login"})
        end
    end

    def update_profile
        user = User.find(session[:curr_user_id])
        if params[:instruments] != nil
            user.instruments = Array.new
            instruments = params[:instruments]
            instruments.each do |insId|
                #user.instruments << Instrument.find(insId)
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
            File.open(Rails.root.join('app', 'assets', 'images', photo.original_filename), 'wb') do |file|
                file.write(photo.read)
            end
            user.photo_file_name = photo.original_filename
            
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
        # auth_hash = request.env['omniauth.auth']
 
        # render :text => auth_hash.inspect
        existing_user = User.find_by_login_name(params[:login_id])
        if existing_user == nil
            new_user = User.new()
            new_user.first_name = params[:first_name]
            new_user.last_name = params[:last_name]
            new_user.login_name = params[:login_id]
            new_user.password = params[:password]
            new_user.password_confirmation = params[:confirm_password]
            new_user.email_address = params[:email_address]
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
