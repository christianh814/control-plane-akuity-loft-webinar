#!/bin/bash
##
echo "This is an example script that creates the vCluster instance. Just information"
exit 0
##
pullrequestnumber=${1}
prn=${pullrequestnumber:="18"}
id="akuityKeyId"
secret="akuitySecretId"
org="loft-webinar"
inst="akuityArgoCdInstanceName"

kubectl apply -f - <<EOF
apiVersion: management.loft.sh/v1
kind: VirtualClusterInstance
metadata:
  name: gobg-preview-${prn}
  namespace: loft-p-vcluster-demo # Project is called vcluster-demo
spec:
  displayName: gobg-preview-${prn}
  owner:
    user: admin
  templateRef:
    name: vcluster-akuity-template
  parameters: |
    prnumber: "${prn}"
    akuityKeyId: "${id}"
    akuityKeySecret: "${secret}"
    akuityOrgName: "${org}"
    akuityInstanceName: "${inst}"
EOF
