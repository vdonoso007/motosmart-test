class ApplicationController < ActionController::API

    def auth_request
        token = get_token
        if token.blank?
            head 401
        else
            token = token.split(' ')
            token = token[1]
            if token.blank?
                head 401
            else
                response = JsonWebToken::validate_token(token)

                if (response[:status] != 200)
                    render json: response[:message], status: response[:status]
                end
           
            end
        end
        
    end

    private
    def get_token
        request.headers["Authorization"]
    end
end
