# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :user,
      Types::UserType,
      null: false,
      description: "Returns a user" do
      argument :email, String, required: false, description: "Email of the user"
      argument :id, ID, required: false, description: "ID of the user"
    end

    def user(email: nil, id: nil)
      raise GraphQL::ExecutionError, "You must provide either an email or an ID." if email.nil? && id.nil?
      user = id ? User.find_by(id: id) : User.find_by(email: email)
      raise GraphQL::ExecutionError, "User not found." if user.nil?
      user
    end

    # samples
    # field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
    #   argument :id, ID, required: true, description: "ID of the object."
    # end
    #
    # def node(id:)
    #   context.schema.object_from_id(id, context)
    # end
    #
    # field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
    #   argument :ids, [ID], required: true, description: "IDs of the objects."
    # end
    #
    # def nodes(ids:)
    #   ids.map { |id| context.schema.object_from_id(id, context) }
    # end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end
  end
end
