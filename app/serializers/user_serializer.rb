class UserSerializer
 include FastJsonapi::ObjectSerializer
 attributes :id, :name, :email, :admin, :confirmed
end