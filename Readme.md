# Flux API ![Flux logo](https://raw.githubusercontent.com/loustak/Flux-Front/master/public/logo_64.png "Flux logo")


Flux aim to be a fast and secure messaging applications for general purpose.

Built with Elixir & Phoenix.

## API endpoints
This API send and receive JSON data.
Unless specified otherwise all the endpoints need the user to be authentified. To authentificate your request, send it with an 'Authorization' header with a value of 'Bearer: jwt_token' where jwt_token is your JWT. 

### Users
| Verb | Route | Body | Description | Success | 
|-----------|-------|------|-------------|----|
| post | /users | email, password, username | Create a new user. The password must be at least 6 characters. No authentification required | No | 201 |
| get | /users | | Get your informations |  200 |
| get | /users/communities | | Get all the communities you have joined |  200 | 
| delete | /users | | Delete your account|  200 |

### Token
| Verb | Route | Body | Description | Success | 
|-----------|-------|------|-------------|----|
| post | /token | email, password | Authentifiate the user. Return a JWT. No authentification required | 201 |
| get | /token/refresh | | Refresh the token | 200 |

### Communities
You must be part of the community to make use of most of the below endpoints.

| Verb | Route | Body | Description | Success | 
|-----------|-------|------|-------------|----|
| post | /communities | name | Create a new community and join it. Create a default discussion named "main" inside the community | 201 |
| get | /communities/:id | | Ask informations about the community :id | 200 |
| put | /communities/:id | name | Update informations of the community :id | 200 |
| delete | /communities/:id | | Delete the community :id | 200 |
| post | /communities/:id/join | | Join the community :id | 201 |
| delete | /communities/:id/quit | | Quit the community :id | 200 |
| get | /communities/:id | | Get all the users inside the community :id | 200 |
| get | /communities/:id/discussions | | Get all the discussions inside the community :id | 200 |

### Discussions
You must be part of the community in which the discussion is to make use of the below endpoints.

| Verb | Route | Body | Description | Success | 
|-----------|-------|------|-------------|-----|
| post | /communities/:community_id/discussions | name | Create a new discussion inside the community :community_id | 201 |
| get | /discussions/:id | | Ask informations about the disscussions :id | 200 |
| put | /discussions/:id | name | Update informations of the disscussions :id | 200 |
| delete | /discussions/:id | | Delete the discussion :id | 200 |

## Messages
There is no endpoints for messages because they are sent trough WebSockets. 
The WebSocket must be connected to ws://.../socket if you use http and wss://.../socket if you use https. You need to pass the JWT in parameter when connecting to the server. Send and receive messages must be in JSON.

Once connected to the server you can join a discussion by sending a message with a field 'topic: id' where id is the discussion you want to connect to. If connected the API send you a JSON object of the discussion.

Once connected to a discussion you can send messages by sending 'topic: discussion_id, event: new_message, payload: data' where discussion_id is the discussion in which you want to send your message and data is the content of the message you want to send. The message will be broadcasted to all the currently connected users.

When a message is sent in your discussion you will receive a message with 'topic: discussion_id, event: message_created, payload: data' where discussion_id is the id of the discussion, and data is the data of the message sent.