# Kubernetes Demos

## Quick Start

```bash
./scripts/toolbox.sh
```

## Pods

1.  Interactive with cleanup on exit.

    Docker command.

    ```bash
    docker run -ti --rm ubuntu bash
    ```

    Equivalent kubernetes command.

    ```bash
    kubectl run -ti --rm --image ubuntu -- bash
    ```

    Look around and exit using `exit` or `CTRL+D`

    The pod will automatically be deleted because of the `--rm`. Handy for quick
    experimentation without forgetting to clean up after you.

2.  All resources, including this pod, are reteivable through kubectl. In the background
    it simply makes an API call.

    ```bash
    kubectl <verb> <resource> [<resource name>]
    ```

    Run a new pod that logs the time every second. Notice the missing `-ti --rm` flags.
    This pod will just start and execute whatever you've told it to somewhere on
    the cluster.

    ```bash
    kubectl run --image ubuntu clock -- /bin/bash -c 'while true; do date; sleep 1; done'
    ```
    
    Go find your pod.

    ```bash
    kubectl get pods
    ```

    Different formats can be returned from the API using `--output` or `-o`. The
    different formats can be found in kubectl's `--help` system. It's very good,
    use it!

    Get some more information about your pod.

    ```bash
    kubectl get pod clock -o wide
    ```

    Get the YAML representation of your pod and save it to a file.

    ```bash
    kubectl get pod bash -o yaml > clock.yaml
    ```

3.  These YAML manifests can be used as your source of truth when it comes to your
    workloads and their configration.

    Delete your pod.

    ```bash
    kubectl delete pod clock
    ```

    Bring it back using the manifest file.

    ```bash
    kubectl apply -f clock.yaml
    ```

    You can also delete any number of resources that are present in a file or
    folder. Delete the pod again using it's manifest file.

    ```bash
    kubectl delete -f clock.yaml
    ```

4. Nginx

    kubectl exec nginx -- curl localhost
    kubectl run -ti --rm --image busybox -- sh
        wget -q -O- <pod-ip>

    kubectl apply -f sidecar.yaml
    kubectl get pod
    kubectl exec -ti sidecar -c busybox -- sh
        wget -q -O- localhost
        ip addr

    kubectl exec -ti sidecar -c caddy -- sh
        ip addr

## Services

1. Pods get different IP addresses when they get created. To get a stable IP that
    you can use in the cluster you can make use of a Service.


    kubectl expose pod nginx --port 80
    curl nginx-ip

    kubectl apply -f ./
    kubectl get service

    curl red blue web

    node port
    load balancer

## Namespaces

1.  kubectl get ns

## Deployments

1.  kubectl create --help

    kubectl create deployment podinfo --image stefanprodan/podinfo:6.1.0 --port 9898 -o yaml --dry-run=client > deployment.yaml
    kubectl create service clusterip podinfo --tcp 9898 -o yaml --dry-run=client > service.yaml
    kubectl create ingress podinfo --rule podinfo.localhost/*=podinfo:9898 -o yaml --dry-run=client > ingress.yaml

