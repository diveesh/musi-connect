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

    def index
        if session[:curr_user_id] != nil
            redirect_to({action: "display_profile"})
        else
            redirect_to({action: "login"})
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
        else
            redirect_to({action: "login"})
        end
    end

    def setup
        if session[:curr_user_id] != nil
            @user = User.find(session[:curr_user_id])
            if @user.profile_set
                redirect_to({action: "edit_profile"})
            else
                @instruments = Instrument.all
                @genres = Genre.all
                @interests = Interest.all
                @activities = Activity.all
            end
        else
            redirect_to ({action: "login"})
        end
    end

    def update_profile
        user = User.find(session[:curr_user_id])
        if params[:instruments] != nil
            params[:instruments].each do |id|
                user.instruments << Instrument.find(id)
            end
        end
        
        if params[:genres] != nil
            params[:genres].each do |id|
                user.genres << Genre.find(id)
            end
        end
        
        user.level_anchor = params[:user][:level_anchor]
        user.profile_set = true
        user.save()
        redirect_to({action: "index"})
    end

    def create
        existing_user = User.find_by_login_name(params[:login_id])
        if existing_user == nil
            new_user = User.new()
            new_user.first_name = params[:first_name]
            new_user.last_name = params[:last_name]
            new_user.login_name = params[:login_id]
            new_user.password = params[:password]
            new_user.password_confirmation = params[:confirm_password]
            new_user.profile_set = false
            new_user.level_anchor = nil
            new_user.email_address = params[:email_address]
            if !new_user.save()
                flash[:error_messages] = new_user.errors.full_messages
                redirect_to({action: "new"})
            else
                flash[:error_messages] = nil
                session[:curr_user_id] = new_user.id
                redirect_to ({action: "setup"})  
            end      
        else
            flash[:err] = "That login name has already been taken. Please choose another one"
            redirect_to({action: "new"})
        end
    end
end
