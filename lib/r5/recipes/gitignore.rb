append_to_file "#{@project_path}/.gitignore" do
<<EOF
/config/database.yml
/log/*.log
/tmp
/db/schema.rb
EOF
end