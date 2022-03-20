# API FINANCES

Api to control my personal finances

### Menu
* [Setup](#setup-gems)
* [Config Initial](#config-initial)
* [Routes](#routes)
* [Rspec Test][#rspec-test]

# SETUP GEMS

- [Ruby (3.1.0)](https://ruby-doc.org/core-3.1.0)
- [Rails 7.0.2](https://github.com/rails/rails)
- [Database Postgres](https://www.postgresql.org/)
- [ApiGuard](https://github.com/Gokul595/api_guard)
- [Rails I18n - 7.0.0](https://github.com/svenfuchs/rails-i18n)
- [Active Model Serializer](https://github.com/rails-api/active_model_serializers)
- [Rspec Rails](https://github.com/rspec/rspec-rails)
- [Database cleaner](https://github.com/DatabaseCleaner/database_cleaner)
- [FactoryBot](https://github.com/thoughtbot/factory_bot_rails)

# Config initial

- configuration your credentials to database connection

```ssh
EDITOR=nano rails credentials:edit
```

```yaml
# your secrect_key default
secret_key: .....

# postgres
pg:
  host: localhost
  username: postgres
  password: admin
  port: 5432
```

- later, run command:

```ssh
rails db:create db:migrate
```

- now we can run our application by running the following command:

```ssh
rails server
```

# Routes
### Registration

This will create an user and responds with access token, refresh token and access token expiry in the response header.

Example request:

```
# URL
POST "/users/sign_up"

# Request body
{
    "email": "user@apiguard.com",
    "password": "api_password",
    "password_confirmation": "api_password"
}
```

Example response body:

```json
{
    "status": "success",
    "message": "Signed up successfully"
}
```

example headers:

```yaml
Access-Token: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDY3MDgwMjAsImlhdCI6MTU0NjcwNjIyMH0.F_JM7fUcKEAq9ZxXMxNb3Os-WeY-tuRYQnKXr_bWo5E
Refresh-Token: Iy9s0S4Lf7Xh9MbFFBdxkw
Expire-At: 1546708020
```

### Sign In (Getting JWT access token)

This will authenticate the user with email and password and respond with access token, refresh token and access token 
expiry in the response header.

>To make this work, the resource model (User) should have an `authenticate` method as available in 
[has_secure_password](https://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html#method-i-has_secure_password). 
You can use [has_secure_password](https://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html#method-i-has_secure_password) 
or your own logic to authenticate the user in `authenticate` method.

Example request:

```
# URL
POST "/users/sign_in"

# Request body
{
    "email": "user@apiguard.com",
    "password": "api_password"
}
```

Example response body:

```json
{
    "status": "success",
    "message": "Signed in successfully"
}
```

example headers

```yaml
Access-Token: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDY3MDgwMjAsImlhdCI6MTU0NjcwNjIyMH0.F_JM7fUcKEAq9ZxXMxNb3Os-WeY-tuRYQnKXr_bWo5E
Refresh-Token: Iy9s0S4Lf7Xh9MbFFBdxkw
Expire-At: 1546708020
```

### Sign out

You can use this request to sign out an user. This will blacklist the current access token from future use if 
[token blacklisting](#token-blacklisting) configured.

Example request:

```
# URL
DELETE "/users/sign_out"

# Request header
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDY3MDgwMjAsImlhdCI6MTU0NjcwNjIyMH0.F_JM7fUcKEAq9ZxXMxNb3Os-WeY-tuRYQnKXr_bWo5E
```

Example response:

```json
{
    "status": "success",
    "message": "Signed out successfully"
}
```

### Refresh access token

This will work only if token refreshing configured for the resource.
Please see [token refreshing](#token-refreshing) for details about configuring token refreshing.

Once the access token expires it won't work and the `authenticate_and_set_user` method used in before_action in 
controller will respond with 401 (Unauthenticated). 

To refresh the expired access token and get new access and refresh token you can use this request 
with both access token and request token (which you got in sign in API) in the request header. 

Example request:

```
# URL
POST "/users/tokens"

# Request header
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDY3MDgwMjAsImlhdCI6MTU0NjcwNjIyMH0.F_JM7fUcKEAq9ZxXMxNb3Os-WeY-tuRYQnKXr_bWo5E
Refresh-Token: Iy9s0S4Lf7Xh9MbFFBdxkw
```

Example response body:

```json
{
    "status": "success",
    "message": "Token refreshed successfully"
}
```

example response headers

```yaml
Access-Token: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDY3MDgwMjAsImlhdCI6MTU0NjcwNjIyMH0.F_JM7fUcKEAq9ZxXMxNb3Os-WeY-tuRYQnKXr_bWo5E
Refresh-Token: Iy9s0S4Lf7Xh9MbFFBdxkw
Expire-At: 1546708020
```

### Change password

To change password of an user you can use this request with the access token in the header and new 
password in the body.

By default, changing password will invalidate all old access tokens and refresh tokens generated for this user and 
responds with new access token and refresh token. 

Example request:

```
# URL
PATCH "/users/passwords"

# Request header
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDY3MDgwMjAsImlhdCI6MTU0NjcwNjIyMH0.F_JM7fUcKEAq9ZxXMxNb3Os-WeY-tuRYQnKXr_bWo5E

# Request body
{
    "password": "api_password_new",
    "password_confirmation": "api_password_new"
}
```

Example response body:

```json
{
    "status": "success",
    "message": "Password changed successfully"
}
```

### Delete account

You can use this request to delete an user. This will delete the user and its associated refresh tokens.

Example request:

```
# URL
DELETE "/users/delete"

# Request header
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDY3MDgwMjAsImlhdCI6MTU0NjcwNjIyMH0.F_JM7fUcKEAq9ZxXMxNb3Os-WeY-tuRYQnKXr_bWo5E
```

Example response:

```json
{
    "status": "success",
    "message": "Account deleted successfully"
}
```

### Rspec Test

To run all test of application, run the following command:
```ssh
rspec
```


That's it, any questions get in touch:

**Facebook:** [Alef Oliveira](https://www.facebook.com/AlefOjedaOliveira)

**Linkedin:** [Alef Ojeda](https://www.linkedin.com/in/alef-ojeda/)
