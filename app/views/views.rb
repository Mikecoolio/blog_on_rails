# /view/layouts
# application.html.erb
<!DOCTYPE html>
<html>
  <head>
    <title>BlogOnRails</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
    <%= javascript_importmap_tags %>
  </head>

  <body>
  <%= csrf_meta_tags %>
<div id= "navbar-flex">
  <nav id="left-side">
    <a class="navbar-brand-logo" href="<%= posts_path %>">Blog On Rails</a>
  </nav>
    <nav class = center-right>
    </nav>

    <% if user_signed_in? %>
    <nav class= "right-side">
      <a class="nav-link-home" href="/">Home </a>
    Hi, <%= link_to current_user.full_name(current_user.first_name, current_user.last_name), edit_user_path(current_user.id) %>
      <a class="nav-link-create" href="/posts/new", method: :create>New Post</a>
      <%= button_to "Log Out", session_path(current_user.id), method: :delete %>
    </nav>
    <% else %>
    <nav class= "right-side">
    
      <a class="nav-link-home" href="/">Home </a>
      <a class="nav-link-home"><%= button_to 'Login', new_session_path, method: :get %></a>
      <a class="nav-link-home" href="/users/new", method: :create>New User </a>
    <% end %>
    </nav>
</div>

    <%= yield %>
  </body>
</html>

# mailer.html.erb
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <style>
      /* Email styles need to be inline */
    </style>
  </head>

  <body>
    <%= yield %>
  </body>
</html>

# mailer.text.erb
# <%= yield %>

# /views/posts/
# edit.html.erb
<%= render 'shared/header' %>
<div id=edit-page>
  <%= form_with(model: @post) do |f| %>  

  <% if @post.errors.any? %>
      <div style="color: red">
        <ul>
          <% @post.errors.each do |error| %>
            <li><%= error.full_message %></li>
          <% end %>
        </ul>
      </div>
    <% end %>

  <div class="edit-page">
    <%= f.label :title %>
    <%= f.text_field :title %>
  </div>

  <div class="edit-page">
    <%= f.label :body %>
    <%= f.text_area :body %>
  </div>

  <div class="edit-page">
    <%= f.submit %>
  <% end %>
  </div>
</div>
<%= render 'shared/footer' %>


index.html.erb:

<%= render 'shared/header' %>
<%= render 'shared/footer' %>

<div class="index-container">
    
    <% @posts.each do |post| %>
        <div class=post>
            <h1><%= link_to post.title, post_path(post.id)%> </h1>
            <p> <%= post.body %> </p>
        </div>
    <% end %>
</div>

# new.html.erb
<%= render 'shared/header' %>
<%= render 'shared/form' %>

<%= render 'shared/footer' %>
 

show.html.erb:

<%= render 'shared/header' %>

<div class="container">
    <div class="row">
        <h1><%= @post.title %></h1> 
        <p> <%= @post.body %> </p>
    </div>
    <div class="row">
    <p> Posted <%= time_ago_in_words(@post.created_at) %> ago </p>
<div>
  <%= link_to "Edit this post", edit_post_path(@post) %> 
  <%= button_to "Destroy this post", @post, method: :delete %>

<%= link_to "Back to posts", posts_path %>
</div>

</div>

<div>

    <%= form_with(model: [@post, @comment]) do |f| %>  
        <%= f.text_area :body, :cols => 40, :rows => 10, placeholder: "What's on your mind?" %>
        <%= f.submit %>
    <% end %>
<div>

    <% @post.comments.each do |comment| %>
        <%= comment.body %> 
        <%= time_ago_in_words(comment.created_at) %>
        <%= button_to "Destroy this comment", comment_path(comment), method: :delete %>
        <br>
    <% end %>
</div>
<%= render 'shared/footer' %>

(views/posts/update.html.erb exists as a file but is empty)


/views/sessions:
new.html.erb:
<div id="login_form">
    <p>Log In Page</p>
    <%= form_with url: session_path do |f| %>
    <div>
        <%= f.label :email%>
        <br>
        <%= f.text_field :email %>
    </div>
    <div>
        <%= f.label :password %>
        <br>
        <%= f.text_field :password %>
    </div>
        <br>
        <%= f.submit "Log In" %>
    <% end %>
</div>


# /views/shared:
# _footer.html.erb:
</body>
</html>

# _form.html.erb:
<div id="form">
  <%= form_for(@post) do |form| %>
  <% if @post.errors.any? %>
      <div>
        <ul>
          <% @post.errors.each do |error| %>
            <li><%= error.full_message %></li>
          <% end %>
        </ul>
      </div>
    <% end %>
    <%= form.label :title %>
    <%= form.text_field :title %>

    <%= form.label :body %>
    <%= form.text_area :body %>

    <%= form.submit %>
      </div>
  <% end %>
</div>

# _header.html.erb
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blog on Rails</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27">
</head>
<body>
    
</body>
</html>

#_navbar.html.erb
<%= csrf_meta_tags %>
<div id= "navbar-flex">
  <nav id="left-side">
    <a class="navbar-brand-logo" href="<%= posts_path %>">Blog On Rails</a>
  </nav>
    <nav class= "right-side">
      <a class="nav-link-home" href="/">Home </a>
    <% if user_signed_in? %>
      <%= link_to current_user.full_name(current_user.first_name, current_user.last_name), edit_user_path(current_user.id) %>
      <a class="nav-link-create" href="/posts/new", method: :create>New Post</a>
      <%#= link_to 'destroy', session_path, :method => :delete %>
      <%#= link_to "Logout", session_path, method: :delete %>
      <%= button_to "Log Out", session_path(current_user.id), method: :delete %>
    <% else %>
      <a class="nav-link-home"><%= button_to 'Login', new_session_path, method: :get %></a>
      <a class="nav-link-home" href="/users/new", method: :create>New User </a>
    <% end %>
    </nav>
</div>

# /views/users:
# edit.html.erb
<div id="form">
  <%= form_for(@user) do |form| %>
  <% if @user.errors.any? %>
      <div>
        <ul>
          <% @user.errors.each do |error| %>
            <li><%= error.full_message %></li>
          <% end %>
        </ul>
      </div>
    <% end %>

    <%= form.label :first_name %>
    <%= form.text_field :first_name %>

    <%= form.label :last_name %>
    <%= form.text_field :last_name %>

    <%= form.label :email %>
    <%= form.text_field :email %>

    <%= form.submit %>
      </div>
  <% end %>
</div>

<br>
<%= button_to "Edit Password", edit_password_path(@user), method: :get %>

(views/users/update.html.erb exists as a file but is empty)


new.html.erb:
<!DOCTYPE html>
<html>

   <head>
      <title>Text Input Control</title>
   </head>
	
   <body>
    <div id="user-sign-up-page">
        <%= form_for @user do |f| %>
        <div>
            <%= f.label :first_name %>
            <br>
            <%= f.text_field :first_name %>
        </div>
        <div>
            <%= f.label :last_name %>
            <br>
            <%= f.text_field :last_name %>
        </div>
        <div>
            <%= f.label :email%>
            <br>
            <%= f.text_field :email %>
        </div>
        <div>
            <%= f.label :password %>
            <br>
            <%= f.text_field :password %>
        </div>
        <div>
            <%= f.label :password_confirmation %>
            <br>
            <%= f.password_field :password_confirmation %>
        </div>
            <%= f.submit "Sign Up" %>
        <% end %>
    </div>
   </body>
	
</html>

# password_edit.html.erb
<div id="form">
  <%= form_with model: @user, url: password_update_path, method: :patch do |form| %>
  <% if @user.errors.any? %>
      <div>
        <ul>
          <% @user.errors.each do |error| %>
            <li><%= error.full_message %></li>
          <% end %>
        </ul>
      </div>
    <% end %>
    <%= form.label :current_password %>
    <%= form.text_field :current_password %>

    <%= form.label :new_password %>
    <%= form.text_field :password %>

    <%= form.label :new_password_confirmation %>
    <%= form.text_field :password_confirmation %>

    <%= form.submit %>
      </div>
  <% end %>
</div>
    
# password_update.html.erb
("this file exists in /views/users but this file is empty")