<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>PROJECT_NAME</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
    <%= javascript_include_tag "https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js", "https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js" %>
  <![endif]-->

  <%= javascript_pack_tag 'application' %>
  <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track' => true %>
  <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
  <%= csrf_meta_tags %>
</head>
<body>
  <div class="navbar navbar-default navbar-fixed-top">
    <div class="container container-large">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
      </div>
      <% if current_user %>
      <div class="collapse navbar-collapse">
        <ul class="nav navbar-nav">
          <%= menu_item 'example', '#', /example(?!new)/  %>
        </ul>
        <ul class="nav navbar-nav navbar-right">
          <li id="fat-menu" class="dropdown">
            <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">
              <i class="icon-user"></i> <%= 'Přihlášen' %>:  <%= current_user.display_name %>
              <i class="icon-caret-down"></i>
            </a>
            <ul class="dropdown-menu">
              <li><%= link_to 'Změnit heslo', {controller: 'users', action: 'edit_own_password'} , :tabindex => -1 %></li>
              <li class="divider"></li>
              <li><%= link_to 'Odhlásit', destroy_user_session_path, :method => :delete %></li>
            </ul>
          </li>
        </ul>
      </div>
      <% end %>
    </div>
  </div>
  <div class="container container-large content">
    <% flash.each do |name, msg| %>
      <%= content_tag :div, :class => "alert alert-#{ name == :error ? "danger" : "success" } alert-dismissable" do %>
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <%= msg %>
      <% end %>
    <% end %>

    <%= yield %>
  </div>
</body>
</html>
