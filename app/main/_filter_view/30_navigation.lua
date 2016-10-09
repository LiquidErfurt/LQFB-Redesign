slot.select('navigation', function()

  ui.link{
    content = function()
      ui.image{ attr = { alt = "LiquidErfurt Logo", id = "lqef_logo_img" }, external = "/static/logo.png" }
    end,
    attr = { id = "lqef_logo_link" },
    module = 'index',
    view   = 'index'
  }

  if app.session.member then
    ui.link{
      text = "Jetzt Abstimmen",
      module = 'index',
      view = 'index',
      params = {
        tab = "open",
        filter = "frozen",
        filter_voting = "not_voted",
        filter_interest = "area"
      }
    }
  end

  if app.session:has_access("anonymous") and not (app.session.needs_delegation_check) then

    ui.link{
      content = "Schlagwortsuche",
      module = 'index',
      view   = 'custom_search'
    }

    ui.link{
      content = _"Search",
      module = 'index',
      view   = 'search'
    }
  
    if app.session.member == nil then
      ui.link{
        text   = _"Login",
        module = 'index',
        view   = 'login',
        params = {
          redirect_module = request.get_module(),
          redirect_view = request.get_view(),
          redirect_id = param.get_id()
        }
      }
    end
    
  end

  if app.session.member == nil then
    ui.link{
      text   = _"Registration",
      module = 'index',
      view   = 'register'
    }
  end
end)


slot.select('navigation_right', function()
  ui.tag{ 
    tag = "ul",
    attr = { id = "member_menu" },
    content = function()
      ui.tag{ 
        tag = "li",
        content = function()
          ui.link{
            module = "index",
            view = "menu",
            content = function()
              if app.session.member_id then
                execute.view{
                  module = "member_image",
                  view = "_show",
                  params = {
                    member = app.session.member,
                    image_type = "avatar",
                    show_dummy = true,
                    class = "micro_avatar",
                  }
                }
                ui.tag{ content = app.session.member.name }
              else
                ui.tag{ content = _"Select language" }
              end
            end
          }
          execute.view{ module = "index", view = "_menu" }
        end
      }
    end
  }
end)

slot.select("footer", function()
  if app.session.member_id and app.session.member.admin then
    ui.link{
      text   = _"Admin",
      module = 'admin',
      view   = 'index'
    }
    slot.put(" &middot; ")
  end
  ui.link{
    text   = _"About site",
    module = 'index',
    view   = 'about'
  }
  if config.use_terms then
    slot.put(" &middot; ")
    ui.link{
      text   = _"Use terms",
      module = 'index',
      view   = 'usage_terms'
    }
  end
  slot.put(" &middot; ")
  ui.tag{ content = _"This site is using" }
  slot.put(" ")
  ui.link{
    text   = _"LiquidFeedback",
    external = "http://www.public-software-group.org/liquid_feedback"
  }
end)

execute.inner()
