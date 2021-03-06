class SearchController < ApplicationController
    def lookup
        if session[:curr_user_id] == nil
            redirect_to({controller: "welcome", action: "index"})
        end
        @user = User.find(session[:curr_user_id])
        @instruments = Instrument.all
        @genres = Genre.all
        @interests = Interest.all
        @activities = Activity.all
    end


    def user_search
        if session[:curr_user_id] != nil
            flash[:error_messages] = []
            @users = User.order(:first_name).to_set - Set.new.add(User.find(session[:curr_user_id]))
            filtered = false
            if params[:instruments] != nil
                @users = @users & User.joins(:instruments).where("instruments.id" => params[:instruments]).to_set
                filtered = true
            end
            if params[:genres] != nil
                @users = @users & User.joins(:genres).where("genres.id" => params[:genres]).to_set
                filtered = true
            end
            if params[:activities] != nil
                @users = @users & User.joins(:activities).where("activities.id" => params[:activities]).to_set
                filtered = true
            end
            if params[:interests] != nil
                @users = @users & User.joins(:interests).where("interests.id" => params[:interests]).to_set
                filtered = true
            end
            if params[:affiliations] != nil
                @users = @users & User.where("affiliation" => params[:affiliations]).to_set
                filtered = true
            end
            if @users.size() == 0
                render :body => '{"status":"ERROR", "message":"No users found"}'
                return
            end
            if !filtered
                render :body => '{"status":"ERROR", "message":"No checkboxes selected"}'
                return
            end
            jsonString = '{"status":"SUCCESS", "data": ['
            @users.each_with_index do |user, index|
                userStr = '{"id":"' + user.id.to_s + '", "first_name":"' + user.first_name + '", "last_name":"' + user.last_name + '", "email_address":"' + user.email_address + '"'
                if user.instruments != nil
                    userStr << ', "instruments":['
                    user.instruments.each_with_index do |ins, i|
                        userStr << '"' + ins.name + '"'
                        if i != user.instruments.length - 1
                            userStr << ','
                        end
                    end
                    userStr << ']'
                end
                userStr << '}'
                jsonString << userStr
                if index != @users.length - 1
                    jsonString << ','
                end
            end
            jsonString << ']}'
            render :body => jsonString
        end
    end
end
