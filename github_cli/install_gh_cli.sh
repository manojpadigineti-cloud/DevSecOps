
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install gh
gh auth refresh -h github.com -s admin:org # To login organisation level

# Command to get the token
gh api   -X POST   orgs/manojpadigineti-cloud/actions/runners/registration-token   -H "Accept: application/vnd.github+json"   --jq .token