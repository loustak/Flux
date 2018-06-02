# Flux API
==========
Flux aim to be a fast and secure messaging applications for general purpose.

Built with Elixir & Phoenix.

## API endpoints
==========
This API send and receive JSON data. 

| HTTP verb | Route | Header body | Description |
|-----------|-------|------|-------------|
| post | /users | email, password, username | Create a new user |
post "/users", UserController, :create
post "/token", TokenController, :create