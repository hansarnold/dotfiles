# Tide preferences migrated from fish_variables.
# Seed missing settings on new machines; keep existing universal values.
set -q VIRTUAL_ENV_DISABLE_PROMPT; or set -U VIRTUAL_ENV_DISABLE_PROMPT true
set -q tide_aws_bg_color; or set -U tide_aws_bg_color normal
set -q tide_aws_color; or set -U tide_aws_color yellow
set -q tide_aws_icon; or set -U tide_aws_icon 
set -q tide_bun_bg_color; or set -U tide_bun_bg_color normal
set -q tide_bun_color; or set -U tide_bun_color white
set -q tide_bun_icon; or set -U tide_bun_icon 
set -q tide_character_color; or set -U tide_character_color brgreen
set -q tide_character_color_failure; or set -U tide_character_color_failure brred
set -q tide_character_icon; or set -U tide_character_icon ❯
set -q tide_character_vi_icon_default; or set -U tide_character_vi_icon_default ❮
set -q tide_character_vi_icon_replace; or set -U tide_character_vi_icon_replace ▶
set -q tide_character_vi_icon_visual; or set -U tide_character_vi_icon_visual V
set -q tide_cmd_duration_bg_color; or set -U tide_cmd_duration_bg_color normal
set -q tide_cmd_duration_color; or set -U tide_cmd_duration_color brblack
set -q tide_cmd_duration_decimals; or set -U tide_cmd_duration_decimals 0
set -q tide_cmd_duration_icon; or set -U tide_cmd_duration_icon
set -q tide_cmd_duration_threshold; or set -U tide_cmd_duration_threshold 3000
set -q tide_context_always_display; or set -U tide_context_always_display false
set -q tide_context_bg_color; or set -U tide_context_bg_color normal
set -q tide_context_color_default; or set -U tide_context_color_default yellow
set -q tide_context_color_root; or set -U tide_context_color_root bryellow
set -q tide_context_color_ssh; or set -U tide_context_color_ssh yellow
set -q tide_context_hostname_parts; or set -U tide_context_hostname_parts 1
set -q tide_crystal_bg_color; or set -U tide_crystal_bg_color normal
set -q tide_crystal_color; or set -U tide_crystal_color brwhite
set -q tide_crystal_icon; or set -U tide_crystal_icon 
set -q tide_direnv_bg_color; or set -U tide_direnv_bg_color normal
set -q tide_direnv_bg_color_denied; or set -U tide_direnv_bg_color_denied normal
set -q tide_direnv_color; or set -U tide_direnv_color bryellow
set -q tide_direnv_color_denied; or set -U tide_direnv_color_denied brred
set -q tide_direnv_icon; or set -U tide_direnv_icon ▼
set -q tide_distrobox_bg_color; or set -U tide_distrobox_bg_color normal
set -q tide_distrobox_color; or set -U tide_distrobox_color brmagenta
set -q tide_distrobox_icon; or set -U tide_distrobox_icon 󰆧
set -q tide_docker_bg_color; or set -U tide_docker_bg_color normal
set -q tide_docker_color; or set -U tide_docker_color blue
set -q tide_docker_default_contexts; or set -U tide_docker_default_contexts default colima
set -q tide_docker_icon; or set -U tide_docker_icon 
set -q tide_elixir_bg_color; or set -U tide_elixir_bg_color normal
set -q tide_elixir_color; or set -U tide_elixir_color magenta
set -q tide_elixir_icon; or set -U tide_elixir_icon 
set -q tide_gcloud_bg_color; or set -U tide_gcloud_bg_color normal
set -q tide_gcloud_color; or set -U tide_gcloud_color blue
set -q tide_gcloud_icon; or set -U tide_gcloud_icon 󰊭
set -q tide_git_bg_color; or set -U tide_git_bg_color normal
set -q tide_git_bg_color_unstable; or set -U tide_git_bg_color_unstable normal
set -q tide_git_bg_color_urgent; or set -U tide_git_bg_color_urgent normal
set -q tide_git_color_branch; or set -U tide_git_color_branch brgreen
set -q tide_git_color_conflicted; or set -U tide_git_color_conflicted brred
set -q tide_git_color_dirty; or set -U tide_git_color_dirty bryellow
set -q tide_git_color_operation; or set -U tide_git_color_operation brred
set -q tide_git_color_staged; or set -U tide_git_color_staged bryellow
set -q tide_git_color_stash; or set -U tide_git_color_stash brgreen
set -q tide_git_color_untracked; or set -U tide_git_color_untracked brblue
set -q tide_git_color_upstream; or set -U tide_git_color_upstream brgreen
set -q tide_git_icon; or set -U tide_git_icon
set -q tide_git_truncation_length; or set -U tide_git_truncation_length 24
set -q tide_git_truncation_strategy; or set -U tide_git_truncation_strategy
set -q tide_go_bg_color; or set -U tide_go_bg_color normal
set -q tide_go_color; or set -U tide_go_color brcyan
set -q tide_go_icon; or set -U tide_go_icon 
set -q tide_java_bg_color; or set -U tide_java_bg_color normal
set -q tide_java_color; or set -U tide_java_color yellow
set -q tide_java_icon; or set -U tide_java_icon 
set -q tide_jobs_bg_color; or set -U tide_jobs_bg_color normal
set -q tide_jobs_color; or set -U tide_jobs_color green
set -q tide_jobs_icon; or set -U tide_jobs_icon 
set -q tide_jobs_number_threshold; or set -U tide_jobs_number_threshold 1000
set -q tide_kubectl_bg_color; or set -U tide_kubectl_bg_color normal
set -q tide_kubectl_color; or set -U tide_kubectl_color blue
set -q tide_kubectl_icon; or set -U tide_kubectl_icon 󱃾
set -q tide_left_prompt_frame_enabled; or set -U tide_left_prompt_frame_enabled false
set -q tide_left_prompt_items; or set -U tide_left_prompt_items pwd git character
set -q tide_left_prompt_prefix; or set -U tide_left_prompt_prefix ''
set -q tide_left_prompt_separator_diff_color; or set -U tide_left_prompt_separator_diff_color ' '
set -q tide_left_prompt_separator_same_color; or set -U tide_left_prompt_separator_same_color ' '
set -q tide_left_prompt_suffix; or set -U tide_left_prompt_suffix ''
set -q tide_nix_shell_bg_color; or set -U tide_nix_shell_bg_color normal
set -q tide_nix_shell_color; or set -U tide_nix_shell_color brblue
set -q tide_nix_shell_icon; or set -U tide_nix_shell_icon 
set -q tide_node_bg_color; or set -U tide_node_bg_color normal
set -q tide_node_color; or set -U tide_node_color green
set -q tide_node_icon; or set -U tide_node_icon 
set -q tide_os_bg_color; or set -U tide_os_bg_color normal
set -q tide_os_color; or set -U tide_os_color brwhite
set -q tide_os_icon; or set -U tide_os_icon 
set -q tide_php_bg_color; or set -U tide_php_bg_color normal
set -q tide_php_color; or set -U tide_php_color blue
set -q tide_php_icon; or set -U tide_php_icon 
set -q tide_private_mode_bg_color; or set -U tide_private_mode_bg_color normal
set -q tide_private_mode_color; or set -U tide_private_mode_color brwhite
set -q tide_private_mode_icon; or set -U tide_private_mode_icon 󰗹
set -q tide_prompt_add_newline_before; or set -U tide_prompt_add_newline_before false
set -q tide_prompt_color_frame_and_connection; or set -U tide_prompt_color_frame_and_connection brblack
set -q tide_prompt_color_separator_same_color; or set -U tide_prompt_color_separator_same_color brblack
set -q tide_prompt_icon_connection; or set -U tide_prompt_icon_connection ' '
set -q tide_prompt_min_cols; or set -U tide_prompt_min_cols 34
set -q tide_prompt_pad_items; or set -U tide_prompt_pad_items false
set -q tide_prompt_transient_enabled; or set -U tide_prompt_transient_enabled false
set -q tide_pulumi_bg_color; or set -U tide_pulumi_bg_color normal
set -q tide_pulumi_color; or set -U tide_pulumi_color yellow
set -q tide_pulumi_icon; or set -U tide_pulumi_icon 
set -q tide_pwd_bg_color; or set -U tide_pwd_bg_color normal
set -q tide_pwd_color_anchors; or set -U tide_pwd_color_anchors brcyan
set -q tide_pwd_color_dirs; or set -U tide_pwd_color_dirs cyan
set -q tide_pwd_color_truncated_dirs; or set -U tide_pwd_color_truncated_dirs magenta
set -q tide_pwd_icon; or set -U tide_pwd_icon
set -q tide_pwd_icon_home; or set -U tide_pwd_icon_home
set -q tide_pwd_icon_unwritable; or set -U tide_pwd_icon_unwritable 
set -q tide_pwd_markers; or set -U tide_pwd_markers .bzr .citc .git .hg .node-version .python-version .ruby-version .shorten_folder_marker .svn .terraform bun.lock Cargo.toml composer.json CVS go.mod package.json build.zig
set -q tide_python_bg_color; or set -U tide_python_bg_color normal
set -q tide_python_color; or set -U tide_python_color cyan
set -q tide_python_icon; or set -U tide_python_icon 󰌠
set -q tide_right_prompt_frame_enabled; or set -U tide_right_prompt_frame_enabled false
set -q tide_right_prompt_items; or set -U tide_right_prompt_items status cmd_duration context jobs direnv bun node python rustc java php pulumi ruby go gcloud kubectl distrobox toolbox terraform aws nix_shell crystal elixir zig time
set -q tide_right_prompt_prefix; or set -U tide_right_prompt_prefix ' '
set -q tide_right_prompt_separator_diff_color; or set -U tide_right_prompt_separator_diff_color ' '
set -q tide_right_prompt_separator_same_color; or set -U tide_right_prompt_separator_same_color ' '
set -q tide_right_prompt_suffix; or set -U tide_right_prompt_suffix ''
set -q tide_ruby_bg_color; or set -U tide_ruby_bg_color normal
set -q tide_ruby_color; or set -U tide_ruby_color red
set -q tide_ruby_icon; or set -U tide_ruby_icon 
set -q tide_rustc_bg_color; or set -U tide_rustc_bg_color normal
set -q tide_rustc_color; or set -U tide_rustc_color red
set -q tide_rustc_icon; or set -U tide_rustc_icon 
set -q tide_shlvl_bg_color; or set -U tide_shlvl_bg_color normal
set -q tide_shlvl_color; or set -U tide_shlvl_color yellow
set -q tide_shlvl_icon; or set -U tide_shlvl_icon 
set -q tide_shlvl_threshold; or set -U tide_shlvl_threshold 1
set -q tide_status_bg_color; or set -U tide_status_bg_color normal
set -q tide_status_bg_color_failure; or set -U tide_status_bg_color_failure normal
set -q tide_status_color; or set -U tide_status_color green
set -q tide_status_color_failure; or set -U tide_status_color_failure red
set -q tide_status_icon; or set -U tide_status_icon ✔
set -q tide_status_icon_failure; or set -U tide_status_icon_failure ✘
set -q tide_terraform_bg_color; or set -U tide_terraform_bg_color normal
set -q tide_terraform_color; or set -U tide_terraform_color magenta
set -q tide_terraform_icon; or set -U tide_terraform_icon 󱁢
set -q tide_time_bg_color; or set -U tide_time_bg_color normal
set -q tide_time_color; or set -U tide_time_color brblack
set -q tide_time_format; or set -U tide_time_format '%T'
set -q tide_toolbox_bg_color; or set -U tide_toolbox_bg_color normal
set -q tide_toolbox_color; or set -U tide_toolbox_color magenta
set -q tide_toolbox_icon; or set -U tide_toolbox_icon 
set -q tide_vi_mode_bg_color_default; or set -U tide_vi_mode_bg_color_default normal
set -q tide_vi_mode_bg_color_insert; or set -U tide_vi_mode_bg_color_insert normal
set -q tide_vi_mode_bg_color_replace; or set -U tide_vi_mode_bg_color_replace normal
set -q tide_vi_mode_bg_color_visual; or set -U tide_vi_mode_bg_color_visual normal
set -q tide_vi_mode_color_default; or set -U tide_vi_mode_color_default white
set -q tide_vi_mode_color_insert; or set -U tide_vi_mode_color_insert cyan
set -q tide_vi_mode_color_replace; or set -U tide_vi_mode_color_replace green
set -q tide_vi_mode_color_visual; or set -U tide_vi_mode_color_visual yellow
set -q tide_vi_mode_icon_default; or set -U tide_vi_mode_icon_default D
set -q tide_vi_mode_icon_insert; or set -U tide_vi_mode_icon_insert I
set -q tide_vi_mode_icon_replace; or set -U tide_vi_mode_icon_replace R
set -q tide_vi_mode_icon_visual; or set -U tide_vi_mode_icon_visual V
set -q tide_zig_bg_color; or set -U tide_zig_bg_color normal
set -q tide_zig_color; or set -U tide_zig_color yellow
set -q tide_zig_icon; or set -U tide_zig_icon 
