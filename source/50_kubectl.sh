(kubectl >/dev/null 2>&1)
if [ $? -eq 0 ]; then
  alias kcgp="kubectl get pods"
  alias kcgs="kubectl get services"
  alias kcdd="kubectl delete deployments"
  alias kcdp="kubectl delete pods"
  alias kcds="kubectl delete services"
  alias kcgd="kubectl get deployments"
fi
