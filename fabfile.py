from fabric.api import run, env, cd

env.hosts = ['miclle.com']
env.user = 'username'
CODE_DIR = '/var/www/miclle'


def deploy():
    with cd(CODE_DIR):
        run('git pull')
        run('kill -USR2 `cat tmp/pids/unicorn.pid`')


def bundle():
    with cd(CODE_DIR):
        run('git pull')
        run('bundle')
        run('RAILS_ENV=production bundle exec rake assets:precompile')
