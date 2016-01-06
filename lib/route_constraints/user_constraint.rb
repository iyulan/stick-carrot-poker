module RouteConstraints
  module UserConstraint
    def current_user(request)
      User.find_by_id(request.session[:user_id])
    end
  end
end
