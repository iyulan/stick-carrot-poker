module RouteConstraints
  class NoUserRequiredConstraint
    include RouteConstraints::UserConstraint

    def matches?(request)
      !current_user(request).present?
    end
  end
end
