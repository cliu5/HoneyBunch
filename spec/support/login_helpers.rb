module LoginHelpers
    def login_as(user)
        post "/session", params: { session: {user_id: user.id}}
    end
end