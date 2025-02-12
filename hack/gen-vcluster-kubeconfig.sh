#!/bin/bash
##
echo "Sample script to create Kubeconfig for Virtual Cluster. Example only"
exit
##
vc=${1}
LOFT_URL="vcluster-platform.aks.chx.cloud"
PROJECT="vcluster-demo"
PREFIX="gobg-preview"
VIRTUAL_CLUSTER="gobg-preview-${vc:=20}"
vckc="/tmp/${VIRTUAL_CLUSTER}.kubeconfig"

if [[ -f ${vckc} ]]; then
	rm -f ${vckc}
	touch ${vckc}
	chmod 0600 ${vckc}
fi

cat <<-EOF > ${vckc}
apiVersion: v1
kind: Config
clusters:
  - cluster:
      server: https://${LOFT_URL}/kubernetes/project/${PROJECT}/virtualcluster/${VIRTUAL_CLUSTER}
      insecure-skip-tls-verify: true
    name: loft
contexts:
  - context:
      cluster: loft
      user: loft
    name: loft
current-context: loft
users:
  - name: loft
    user:
      token: ${LOFT_ACCESS_KEY}
EOF

echo "Run the following: export KUBECONFIG=${vckc}"
