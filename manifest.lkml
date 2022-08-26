project_name: "looker_extenstion"

# project_name: "global_logic"

application: globallogic {
  label: "Looker Extension"
# url: "http://localhost:8080/bundle.js"
  file: "bundle.js"
  entitlements: {
    # allow_same_origin: yes
    # allow_forms: yes
    local_storage: yes
    navigation: yes
    new_window: yes
    core_api_methods: ["me","all_user_attributes","user_attribute_user_values"]
  }
}

application: kitchensink {
  label: "Kitchen sink"
  url: "http://localhost:8080/bundle.js"
  entitlements: {
    local_storage: yes
    navigation: yes
    new_window: yes
    # allow_forms: yes
    # allow_same_origin: yes
    core_api_methods: ["all_connections","search_folders", "run_inline_query", "me", "all_looks", "run_look"]
    external_api_urls: ["http://127.0.0.1:3000", "http://localhost:3000", "https://*.googleapis.com", "https://*.github.com", "https://https://tredencepartner.cloud.looker.com/.auth0.com"]
    oauth2_urls: ["https://accounts.google.com/o/oauth2/v2/auth", "https://github.com/login/oauth/authorize", "https://dev-5eqts7im.auth0.com/authorize", "https://dev-5eqts7im.auth0.com/login/oauth/token", "https://github.com/login/oauth/access_token"]
  }
}

application: helloworld-js {
  label: "HelloWorld (JS)"
  # url: "http://localhost:8080/bundle.js"
  file: "/extension/hello_user.js"
  entitlements: {
    core_api_methods: ["me"]
  }
}

application: work {
  label: "work"
  url: "http://localhost:3000/"
# file: "/extension/hello_user.js"
  entitlements: {
    core_api_methods: ["me"]
    external_api_urls: ["http://127.0.0.1:3000", "http://localhost:3000", "https://*.googleapis.com", "https://*.github.com", "https://https://tredencepartner.cloud.looker.com/.auth0.com"]
  }
}

visualization: {
  id: "hello_world"
  label: "Hello World"
  file: "visualization/bundle1.js"
}

# visualization: {
#   id: "hello_world"
#   label: "Hello World method 3"
#   file: "visualization/bundle1.js"
# }

# visualization: {
#   id: "Force"
#   label: "Force method3"
#   file: "visualization/force.js"
# }

# visualization: {
#   id: "spider-marketplace-dev"
#   label: "Spider Viz"
#   url: "https://marketplace-api.looker.com/viz-dist/spider.js"
#   sri_hash: "oqVuAfXRKap7fdgcCY5uykM6+R9GqQ8K/uxy9rx7HNQlGYl1kPzQho1wx4JwY8wC"
#   dependencies: ["https://code.jquery.com/jquery-2.2.4.min.js","https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.9.1/underscore-min.js","https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.6/d3.min.js","https://cdnjs.cloudflare.com/ajax/libs/d3-legend/1.13.0/d3-legend.min.js"]
# }

# 6abafef65ffb0904b76b4c5b265d04ea31aceeda42995383a90eb59f0269fe18 - embed secret
# client id GbV69fCmTx4wX2mPvpkK
# client secret C2TRhprDKcyGBcZzTVSWQCTS
