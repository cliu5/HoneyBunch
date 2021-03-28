class Order < ActiveRecord::Base
    def update(new_status)
        self.update_attributes()
    end
end

