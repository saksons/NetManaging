output "net_info" {
  value       = data.local_file.mikrotik_net_info.content
  description = "Content of file with json info"

}
