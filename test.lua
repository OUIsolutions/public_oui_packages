local project_repository = "OUISolutions/BearSSLTrustedAnchors"
local project_name = "bearssl_trusted_anchors"
local package_owner, package_repo_name = project_repository:match("([^/]+)/([^/]+)")
if not package_owner or not package_repo_name then
    error("Malformed repository format. Expected '<package_owner>/<repo>'.")
end

local url = "https://github.com/" .. project_repository .. ".git"
print("Package owner: " .. package_owner)
print("Package repository: " .. package_repo_name)
print("Cloning from URL: " .. url .. "\n")

local clone_command = "git clone " .. url

local output_path = argv.get_flag_arg_by_index({ "output", "o" }, 1, package_repo_name)

clone_command = clone_command .. " " .. output_path .. " 2> /dev/null"

os.execute(clone_command)
local absolute_repo_path = dtw.get_absolute_path(output_path)
-- dtw returns nil if path doesnt exist
if not absolute_repo_path then
    error("Failed to clone the repository.")
end

print("Repository cloned to: " .. absolute_repo_path)

local should_set_repo = argv.flags_exist({ "set-repo", "s" })
if not should_set_repo then return end

set_prop(project_name .. "_repo", absolute_repo_path)
print("Repository prop path set")