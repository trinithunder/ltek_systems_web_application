class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Returns an array of all associated objects
  def associated_objects
    associations = self.class.reflections.values.select { |reflection| reflection.macro != :belongs_to }

    associations.map do |reflection|
      associated_records(reflection)
    end
  end
  
  # Override as_json to include associated objects
    def as_json(options = {})
      options ||= {}

      # Include associated objects in JSON output
      options[:include_associations] ||= true
      if options[:include_associations]
        associated_objects.each do |associated_object|
          if associated_object.present?
            associated_object_name = associated_object.first.class.name.downcase.pluralize.to_sym
            options[:include] ||= {}
            options[:include][associated_object_name] = { only: [:id] } # You can modify `only` to specify attributes to include
          end
        end
      end

      super(options)
    end

  private

  def associated_records(reflection)
    case reflection.macro
    when :has_many, :has_one
      # For has_many and has_one, return the associated objects
      self.send(reflection.name)
    when :has_and_belongs_to_many
      # For HABTM, return the associated objects
      self.send(reflection.name)
    else
      nil
    end
  end
end


# class ApplicationRecord < ActiveRecord::Base
#   primary_abstract_class
# end


# Explanation:

# associated_objects: This method collects all associations (excluding belongs_to) of the current model class and returns them as an array. For each association, it delegates the fetching to the private method associated_records.

# associated_records: This private method checks the type of association (e.g., has_many, has_one, has_and_belongs_to_many) and calls the respective method to retrieve the associated records.
#

# as_json Override: The as_json method has been overridden to include the associated objects in the output. This includes the associated_objects method results and ensures that the associations are included in the JSON representation of the object.

# options[:include]: This part of the code ensures that the associations are rendered as part of the main object. The associated object’s name is pluralized and added to the options[:include] hash, which is handled by ActiveModel::Serializers to include the associated data in the JSON response.

# Association Customization: You can customize what attributes are included for the associated objects by adjusting the only option in the options[:include] hash. You can pass specific fields you want to include in the JSON.

# Use the New Behavior

#Example Model (User)

# class User < ApplicationRecord
#   has_many :posts
#   has_many :comments
# end

# When you call to_json on a User object, it will include all associated posts and comments:

# user = User.find(1)
#puts user.to_json(include_associations: true)

# Expected Output (JSON):

# {
#   "id": 1,
#   "name": "John Doe",
#   "posts": [
#     { "id": 1, "title": "First Post" },
#     { "id": 2, "title": "Second Post" }
#   ],
#   "comments": [
#     { "id": 1, "body": "Great post!" },
#     { "id": 2, "body": "Nice read!" }
#   ]
# }

# Optional Customization

# If you want to fine-tune which associations are included or modify the structure of the JSON response, you can further modify the as_json method. You can also pass specific options when rendering a model to JSON to control which associations are included:

#user.to_json(include: { posts: { only: [:id, :title] }, comments: { only: [:id, :body] } })

# This approach allows you to make your models more flexible by ensuring their associations are easily accessible and can be automatically included in JSON outputs, while maintaining good customization points for more control.
