# Fix to receive client IP addresses
Matomo originally recorded the pod's IP (10.42.0.xx) for every visitor. To get real visitor IPs Traefik was changed to run as a DaemonSet with externalTrafficPolicy: Local. This preserves the original source IP when traffic enters the Kubernetes cluster and ensures each node has a local Traefik instance. The remaining client IP information is then passed to Matomo through X-Forwarded-For.


# Fix to forward them

[General]
proxy_ip_read_last_in_list = 0
proxy_client_headers[] = HTTP_X_FORWARDED_FOR

This makes Matomo use the first address in the X-Forwarded-For chain, so the real visitor IP is recorded instead of the cloudflared address.

The configuration is applied by the chart's matomo-init container when a new pod is created. values.yaml causes matomo.config to replace the chart's default install.json instead of merging with it. The file therefore keeps the current Matomo installation configuration and adds the required proxy setting.

values.yaml.backup is a copy of the previous configuration kept as a rollback reference.
