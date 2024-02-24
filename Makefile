clustername := kind-envoy-playground

make-kind-dir:
	mkdir -p $(HOME)/.kube/kind

#-------------------------------------------------
# Target: Create kind cluster
# ------------------------------------------------

cluster: make-kind-dir cluster-create

cluster-create:
	kind create cluster --name $(clustername) --kubeconfig=$(HOME)/.kube/kind/$(clustername)

#-------------------------------------------------
# Target: playground install 
# ------------------------------------------------

playground:
	kubectl --kubeconfig $(HOME)/.kube/kind/$(clustername) create ns playground 
	kubectl --kubeconfig $(HOME)/.kube/kind/$(clustername) apply -f envoy-config-configmap.yaml -n playground 
	kubectl --kubeconfig $(HOME)/.kube/kind/$(clustername) apply -f blue-svc.yaml -n playground 
	kubectl --kubeconfig $(HOME)/.kube/kind/$(clustername) apply -f deployment.yaml -n playground 

#-------------------------------------------------
# Target: debug install 
# ------------------------------------------------

debug:
	kubectl --kubeconfig $(HOME)/.kube/kind/$(clustername) apply -f debug-deployment.yaml -n playground 

#-------------------------------------------------
# Target: Install 
# ------------------------------------------------

install: \
	cluster \
	playground

#-------------------------------------------------
# Target: Clean 
# ------------------------------------------------

clean:
	kind delete cluster --name $(clustername) 
