# Steps

## create cluster
```shell
terraform plan -target module.eks.aws_eks_cluster.eks
```

log in
```shell
aws eks update-kubeconfig \
  --region eu-west-2 \
  --name hive
```

At this point:
- The cluster exists
- No nodes yet
- kubectl works, but nothing schedules

##  Create Node Capacity (Managed Node Groups)

```shell
terraform plan -target module.eks.aws_eks_node_group.default
```

##  Configure aws-auth ConfigMap
This allows:
- Node IAM role → Kubernetes node
- Human IAM roles → cluster-admin access

Without this:
- Nodes will never join the cluster

```shell
terraform plan -target module.eks.kubernetes_config_map.aws_auth
```

##  Install Core EKS Add-ons
```shell
terraform plan -target module.eks.aws_eks_addon.addon
```

##  Configure IRSA (IAM Roles for Service Accounts)
This is required for:
- AWS Load Balancer Controller
- ExternalDNS
- Cluster Autoscaler
- CSI drivers (EBS/EFS)

Steps
1.	Create OIDC provider
2.	Create IAM role with trust policy
3.	Annotate Kubernetes service account

```shell
terraform plan -target module.eks.aws_iam_openid_connect_provider.eks
```

## Install AWS Load Balancer Controller
Since you already tagged subnets correctly, this is the next big milestone.

What it gives you
- ALB / NLB for Ingress and Services
- Automatic LB provisioning

Steps:
1.	IAM role via IRSA
2.	Helm install

```shell
helm repo add eks https://aws.github.io/eks-charts
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=<cluster-name> \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller
  ```

## validate network
Run these checks early:
```shell
kubectl get nodes
kubectl get pods -A
kubectl run test --image=nginx
kubectl exec -it test -- curl google.com
```
Confirm:
- Pods in private subnets have outbound internet via NAT
- LoadBalancers land in public subnets
- Internal services use private NLB/ALB if desired


## Add Production Essentials
At this point your cluster is usable. Common next steps:

Scaling & reliability
- Cluster Autoscaler or Karpenter
- PodDisruptionBudgets
- Horizontal Pod Autoscaler

Security
- Network Policies
- Pod Security Standards
- Secrets via AWS Secrets Manager

Observability
- CloudWatch Container Insights
- Prometheus / Grafana
- Fluent Bit / OpenSearch


## order of importance
	1.	✅ EKS cluster
	2.	✅ Node groups
	3.	✅ aws-auth config
	4.	✅ Core add-ons
	5.	✅ IRSA
	6.	✅ AWS Load Balancer Controller
	7.	✅ Autoscaling
	8.	✅ Monitoring & security
