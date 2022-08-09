project_name: "looker_extenstion"

# project_name: "global_logic"

application: globallogic {
  label: "GlobalLogic Intranet"
#   url: "http://localhost:8080/bundle.js"
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
