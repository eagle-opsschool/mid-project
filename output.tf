output "dummy_exporter1" {
  value = "${aws_instance.dummy_exporter1.public_ip}"
}

output "dummy_exporter2" {
  value = "${aws_instance.dummy_exporter2.public_ip}"
}

output "grafana" {
  value = "${aws_instance.grafana.public_ip}"
}

output "kibana" {
  value = "${aws_instance.kibana.public_ip}"
}
