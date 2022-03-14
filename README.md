# historian-helm
Helm chart (and matching helm repository) for kubernetes installation of data historian

```shell
helm repo add historian https://hurence.github.io/historian-helm
# Set at least the following storageClasses in CLI or use values.yml file:
# --set solr.persistence.storageClass=<myStorageClass>
# --set solr.zookeeper.persistence.storageClass=<myStorageClass>
# --set grafana.persistence.storageClass=<myStorageClass>
helm install historian historian/historian \
--set solr.persistence.storageClass=<myStorageClass> \
--set solr.zookeeper.persistence.storageClass=<myStorageClass> \
--set grafana.persistence.storageClass=<myStorageClass>
```




