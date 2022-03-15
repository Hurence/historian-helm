# Public helm repo management.

Has been done thanks to this [tutorial](https://medium.com/@mattiaperi/create-a-public-helm-chart-repository-with-github-pages-49b180dbb417)

Regenerate the package then update the index:

```shell
helm lint
helm package .
helm repo index --url https://hurence.github.io/historian-helm/ .
```




