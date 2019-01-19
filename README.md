# Opsschool mid-project

This project create an AWS VPC+subnet that runs dockerise dummy-exporter on dual EC2 machines.

The content of the dummy-exporters is discovered using three-way consul cluster, and along with 2 node-exporters are pulled using prometheus can be seen with nice dashboards on grafana. All the logs are gathered using filebeat and an ELK instance.

## Configuration
The project assume one has ~/.aws/credentials set. Also, one should add to terraform.tfvars one's ssh key path and name.

## Usage
```bash
git clone https://github.com/eagle-opsschool/mid-project.git
terraform apply --auto-approve
```

Running this should take about 10 minutes.

The creation script will output the ip addresses of the machines one should test from remote. To check the environment run:
```bash
dummyExporterService:	curl <dummy_exporter_ip>:65433
Elasticsearch:		curl <kibana_ip>:9200
Grafana:		curl <grafana_ip>:3000
```

## License
Public domain
