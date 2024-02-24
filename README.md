# Envoy Playground - KinD Cluster

## Install
```
$ make install
```

## Test 
### With a Debug Pod
```
$ make debug

$ k exec -it <debug_pod> -- curl -v http://<podIP>:15006/
```

### With Port Forwarding
```
k port-forward <pod> 15006:15006
```

## Cleanup
```
make clean
```