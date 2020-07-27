1. Create a new project:

   `oc new-project quay-enterprise`
1. Install the Red Hat Quay Operator
1. Load credentials to obtain Quay:

   `oc apply -f https://raw.githubusercontent.com/secobau/openshift/master/install/redhat-quay-pull-secret.yaml`
1. Please customize the following configuration before applying it:

   `oc apply -f https://raw.githubusercontent.com/redhat-cop/quay-operator/master/deploy/examples/005_advanced_config_example_cr.yaml`
1. 
