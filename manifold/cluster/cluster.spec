metadata:
  Annotations: null
  ClusterName: ""
  CreationTimestamp: "2017-02-27T18:16:40Z"
  DeletionGracePeriodSeconds: null
  DeletionTimestamp: null
  Finalizers: null
  GenerateName: ""
  Generation: 0
  Labels: null
  Name: manifold.infra.gl
  Namespace: ""
  OwnerReferences: null
  ResourceVersion: ""
  SelfLink: ""
  UID: ""
spec:
  api:
    dns: {}
  channel: stable
  cloudProvider: aws
  clusterDNSDomain: cluster.local
  configBase: s3://gl-infra-manifold/manifold.infra.gl
  configStore: s3://gl-infra-manifold/manifold.infra.gl
  dnsZone: Z3H59DBTPHI205
  docker:
    bridge: ""
    ipMasq: false
    ipTables: false
    logLevel: warn
    storage: overlay,aufs
    version: 1.12.3
  etcdClusters:
  - etcdMembers:
    - instanceGroup: master-us-east-1a
      name: a
    name: main
  - etcdMembers:
    - instanceGroup: master-us-east-1a
      name: a
    name: events
  keyStore: s3://gl-infra-manifold/manifold.infra.gl/pki
  kubeAPIServer:
    address: 127.0.0.1
    admissionControl:
    - NamespaceLifecycle
    - LimitRanger
    - ServiceAccount
    - PersistentVolumeLabel
    - DefaultStorageClass
    - ResourceQuota
    allowPrivileged: true
    anonymousAuth: false
    apiServerCount: 1
    basicAuthFile: /srv/kubernetes/basic_auth.csv
    clientCAFile: /srv/kubernetes/ca.crt
    cloudProvider: aws
    etcdServers:
    - http://127.0.0.1:4001
    etcdServersOverrides:
    - /events#http://127.0.0.1:4002
    image: gcr.io/google_containers/kube-apiserver:v1.5.2
    kubeletPreferredAddressTypes:
    - InternalIP
    - Hostname
    - ExternalIP
    - LegacyHostIP
    logLevel: 2
    pathSrvKubernetes: /srv/kubernetes
    pathSrvSshproxy: /srv/sshproxy
    securePort: 443
    serviceClusterIPRange: 100.64.0.0/13
    storageBackend: etcd2
    tlsCertFile: /srv/kubernetes/server.cert
    tlsPrivateKeyFile: /srv/kubernetes/server.key
    tokenAuthFile: /srv/kubernetes/known_tokens.csv
  kubeControllerManager:
    allocateNodeCIDRs: true
    attachDetachReconcileSyncPeriod: 1m0s
    cloudProvider: aws
    clusterCIDR: 100.96.0.0/11
    clusterName: manifold.infra.gl
    configureCloudRoutes: true
    image: gcr.io/google_containers/kube-controller-manager:v1.5.2
    leaderElection:
      leaderElect: true
    logLevel: 2
    master: 127.0.0.1:8080
    pathSrvKubernetes: /srv/kubernetes
    rootCAFile: /srv/kubernetes/ca.crt
    serviceAccountPrivateKeyFile: /srv/kubernetes/server.key
  kubeDNS:
    domain: cluster.local
    image: gcr.io/google_containers/kubedns-amd64:1.3
    replicas: 3
    serverIP: 100.64.0.10
  kubeProxy:
    cpuRequest: 100m
    image: gcr.io/google_containers/kube-proxy:v1.5.2
    logLevel: 2
    master: https://api.internal.manifold.infra.gl
  kubeScheduler:
    image: gcr.io/google_containers/kube-scheduler:v1.5.2
    leaderElection:
      leaderElect: true
    logLevel: 2
    master: 127.0.0.1:8080
  kubelet:
    allowPrivileged: true
    apiServers: https://api.internal.manifold.infra.gl
    babysitDaemons: true
    cgroupRoot: docker
    cloudProvider: aws
    clusterDNS: 100.64.0.10
    clusterDomain: cluster.local
    enableDebuggingHandlers: true
    evictionHard: memory.available<100Mi,nodefs.available<10%,nodefs.inodesFree<5%,imagefs.available<10%,imagefs.inodesFree<5%
    evictionPressureTransitionPeriod: 0s
    hostnameOverride: '@aws'
    logLevel: 1
    networkPluginMTU: 9001
    networkPluginName: kubenet
    nonMasqueradeCIDR: 100.64.0.0/10
    podManifestPath: /etc/kubernetes/manifests
  kubernetesApiAccess:
  - 0.0.0.0/0
  kubernetesVersion: 1.5.2
  masterInternalName: api.internal.manifold.infra.gl
  masterKubelet:
    allowPrivileged: true
    apiServers: http://127.0.0.1:8080
    babysitDaemons: true
    cgroupRoot: docker
    cloudProvider: aws
    clusterDNS: 100.64.0.10
    clusterDomain: cluster.local
    enableDebuggingHandlers: true
    evictionHard: memory.available<100Mi,nodefs.available<10%,nodefs.inodesFree<5%,imagefs.available<10%,imagefs.inodesFree<5%
    evictionPressureTransitionPeriod: 0s
    hostnameOverride: '@aws'
    logLevel: 2
    networkPluginMTU: 9001
    networkPluginName: kubenet
    nonMasqueradeCIDR: 100.64.0.0/10
    podManifestPath: /etc/kubernetes/manifests
    registerSchedulable: false
  masterPublicName: api.manifold.infra.gl
  networkCIDR: 172.20.0.0/16
  networking:
    kubenet: {}
  nonMasqueradeCIDR: 100.64.0.0/10
  secretStore: s3://gl-infra-manifold/manifold.infra.gl/secrets
  serviceClusterIPRange: 100.64.0.0/13
  sshAccess:
  - 0.0.0.0/0
  subnets:
  - cidr: 172.20.32.0/19
    name: us-east-1a
    type: Public
    zone: us-east-1a
  topology:
    dns:
      type: Public
    masters: public
    nodes: public
