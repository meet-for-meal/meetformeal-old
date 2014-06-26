json.array! @users do |user|
  json.id user.id
  json.name user.name
  json.hobbies user.hobby_list
end
