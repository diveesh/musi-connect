class SearchController < ApplicationController
    def lookup
        if session[:curr_user_id] == nil
            redirect_to({controller: "users", action: "login"})
        end
        @instruments = Instrument.all
        @genres = Genre.all
        @interests = Interest.all
        @activities = Activity.all
    end

    def display_results
        if session[:curr_user_id] != nil
            @users = User.all.to_set - Set.new.add(User.find(session[:curr_user_id]))
            if params[:instruments] != nil
                @users = @users & User.joins(:instruments).where("instruments.id" => params[:instruments]).to_set
            end
            if params[:genres] != nil
                @users = @users & User.joins(:genres).where("genres.id" => params[:genres]).to_set
            end
            if params[:activities] != nil
                @users = @users & User.joins(:activities).where("activities.id" => params[:activities]).to_set
            end
            if params[:affiliations] != nil
                @users = @users & User.where("affiliation" => params[:affiliations])
            end
            if params[:level_anchors] != nil
                @users = @users & User.where("level_anchor" => params[:level_anchors])
            end
        else
            redirect_to({controller: "users", action: "login"})
        end
    end

end
