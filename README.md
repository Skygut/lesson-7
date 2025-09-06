# Argo CD (Terraform) + Application (GitOps)

## Передумови
- Terraform >= 1.5
- kubectl >= 1.24
- Налаштований kubeconfig з доступом до вашого кластера (`~/.kube/config`)

## Структура
```
├── argocd/                     # Terraform конфігурація для ArgoCD
│   ├── main.tf                 # Основна конфігурація Helm релізу ArgoCD
│   ├── variables.tf            # Змінні для Terraform
│   ├── outputs.tf              # Вихідні значення
│   ├── terraform.tf            # Конфігурація провайдерів
│   ├── backend.tf              # Локальний Terraform State
│   └── values/
│       └── argocd-values.yaml  # Helm values для ArgoCD
└── applications/
    └── application.yaml        # ArgoCD Application з MLflow ресурсами
```
## 1) Встановлення Argo CD через Terraform
```bash
cd argocd
terraform init
terraform validate
terraform plan
terraform apply
```

## 2) Перевірка, що Argo CD працює
```bash
kubectl get pods -n infra-tools
```
Очікувані компоненти: `argocd-server`, `argocd-repo-server`, `argocd-application-controller`, `argocd-redis`.

## 3) Доступ до UI Argo CD (port-forward)
```bash
kubectl port-forward -n infra-tools svc/argocd-server 8080:80
```
Відкрийте: `http://localhost:8080`

Логін:
```bash
# пароль admin
kubectl -n infra-tools get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d; echo
```
Користувач: `admin`

## 4) Деплой застосунку (Application)
Застосуйте `Application` з цього репозиторію:
```bash
kubectl apply -f application/application.yaml
```
Перевірте статус Application:
```bash
kubectl get applications -n infra-tools
```

## 5) Перевірка сервісу, який задеплоївся
Приклад для MLflow (якщо у маніфестах використовується namespace `mlflow`):
```bash
kubectl get pods -n mlflow
kubectl get svc -n mlflow
```
Доступ (port-forward):
```bash
kubectl port-forward -n mlflow svc/mlflow-service 5000:5000
# Відкрити: http://localhost:5000
```

## 6) Видалення Argo CD
```bash
cd improved-solution/argocd
terraform destroy
```

## Примітки
- Значення Helm для Argo CD: `improved-solution/argocd/values/argocd-values.yaml`.
- Тип сервісу Argo CD — `ClusterIP`, доступ через port-forward.
- У values явно увімкнений локальний `admin` (`configs.params.admin.enabled: "true"`).

## Рекомендації
- Практична робота:
  - Використовуйте port-forward (вже налаштовано `ClusterIP`).
  - `Application` застосовуйте командою без `-n`, бо namespace задано в YAML.
  - Якщо щось не синхронізується: `kubectl describe application mlflow-app -n infra-tools`.
- Продакшн:
  - Вимкнути локального `admin`, увімкнути SSO (OIDC).
  - Використати Ingress/LoadBalancer з TLS.
  - Підібрати requests/limits під продакшн-навантаження.
  - Зберігати Terraform state у віддаленому бекенді (S3/DynamoDB, GitOps flow).

