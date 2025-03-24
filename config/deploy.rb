# config/deploy.rb

set :application, 'ddc'
set :repo_url, 'git@github.com:OrphanZhao/ddc.git'

# 设置部署分支
set :branch, 'main'

# 部署目录
set :deploy_to, '/var/www/ddc'

# 保留的发布版本数量
set :keep_releases, 5

# 如果你使用 Yarn 而不是 NPM
set :npm_flags, '--silent --no-progress'
set :yarn_flags, '--silent --no-progress'

namespace :deploy do
  desc 'Install dependencies and build React application'
  task :build_react do
    on roles(:app) do
      # 切换到 release_path/vite-project 目录
      within "#{release_path}/vite-project" do
        # 安装依赖
        execute :yarn, 'install'
        # 构建应用
        execute :yarn, 'build'
      end
    end
  end

  # 在发布完成后执行构建任务
  after :publishing, :build_react

  # 可选：清理旧版本
  after :finishing, :cleanup
end