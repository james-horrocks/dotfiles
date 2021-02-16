alias homeserver="ssh james@homeserver"
alias zshconfig="nano ~/.zshrc"
alias jetwork="ssh root@jetwork.lan"
alias venv="source venv/bin/activate"
alias python=python3
alias pip=pip3
alias sshadmin="ssh -A dev-jhorrocks -t 'ssh -A admin@release-001.admin.uk'"
alias azkaban="ssh -t dev-jhorrocks ssh -t admin@release-001.admin.uk ec2-user-build-001.data-warehouse.uk"
alias azkaban2="ssh -t dev-jhorrocks ssh -t admin@release-001.admin.uk ec2-user-build-azkaban-001.data-warehouse.uk"
alias azkaban-web="ssh -t dev-jhorrocks ssh -t admin@release-001.admin.uk ec2-user-build-azkaban-web-001.data-warehouse.uk"
alias chezs="chezmoi git status"
alias chezc="chezmoi git add . && chezmoi git -- commit -m"
alias chezp="chezmoi git push"
alias data-qa="aws-vault exec qa -- "
alias data-prod="aws-vault exec prod -- "
alias data-dev="aws-vault exec dev -- "
alias zeppelin=/home/james/.local/share/zeppelin-0.8.1/bin/zeppelin-daemon.sh
