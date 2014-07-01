json.array! @users do |user|
  json.id user.id
  json.name user.name
  json.email user.email
  json.gender user.gender
  json.hobbies user.hobby_list
end
