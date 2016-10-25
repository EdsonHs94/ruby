json.partial! "comments/comment", comment: @comment
json.user do
	json.email @comment.user.email
end